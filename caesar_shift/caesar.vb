Module caesar
    ' Author: Jose Ramón Lambea
    ' Date: 2014/02/26
    '
    ' Caesar / Shift cipher analyzer
    ' Practice of introduction to cryptography.
    ' This is a early version, but it can:
    ' -c Cipher a plain text file.
    ' -a Analyze a plain text file.
    ' -u Uncipher a plain text file.

    Sub Main()
        If My.Application.CommandLineArgs.Count = 0 Then
            Console.Write("Usage: caesar.exe [-c | -a | -u] ciphered_text_file" & vbCrLf & _
                          "       -c output_file 0-26             Apply cipher" & vbCrLf & _
                          "       -a ciphered_file                Analyze file" & vbCrLf & _
                          "       -u ciphered_file 0-26          Uncipher file" & vbCrLf & _
                          "       --auto ciphered_file       Autouncipher file")

        ElseIf My.Application.CommandLineArgs.Count <= 3 Then

            Dim file As String
            Dim key As Integer

            Select Case My.Application.CommandLineArgs(0)
                Case "-c"

                    If My.Application.CommandLineArgs.Count <> 3 Or _
                        My.Application.CommandLineArgs(2) < 1 Or _
                        My.Application.CommandLineArgs(2) > 26 Then

                        Console.Write("It is necessary a number between 1 and 26 to cipher the text.")

                    ElseIf Not IO.File.Exists(My.Application.CommandLineArgs(1)) Then
                        Console.WriteLine("The file " & My.Application.CommandLineArgs(1) & " doesn't exists.")

                    Else

                        file = My.Application.CommandLineArgs(1)
                        key = My.Application.CommandLineArgs(2)

                        If cipher(file, key, file & "_ciphered") Then
                            Console.WriteLine("File " & file & "_ciphered generated successfuly.")
                        Else
                            Console.WriteLine("The process has not been successful.")
                        End If

                    End If

                Case "-a"

                    If Not IO.File.Exists(My.Application.CommandLineArgs(1)) Then
                        Console.WriteLine("The file " & My.Application.CommandLineArgs(1) & " doesn't exists.")

                    Else

                        file = My.Application.CommandLineArgs(1)

                        If analyze(file) Then
                            Console.WriteLine("Analysis succeeded.")
                        Else
                            Console.WriteLine("The process has not been successful.")
                        End If
                    End If

                Case "--auto"

                    If Not IO.File.Exists(My.Application.CommandLineArgs(1)) Then
                        Console.WriteLine("The file " & My.Application.CommandLineArgs(1) & " doesn't exists.")

                    Else

                        file = My.Application.CommandLineArgs(1)

                        key = analyze(file)

                        If key Then
                            Console.WriteLine("Analysis succeeded, running next step: deciphering.")

                            If cipher(file, 26 - key, file & "_unciphered") Then
                                Console.WriteLine("File " & file & "_unciphered generated successfuly.")
                            Else
                                Console.WriteLine("The process has not been successful.")
                            End If

                        Else
                            Console.WriteLine("The analysis result doesn't permit run the deciphering process.")
                        End If
                    End If

                Case "-u"

                    If My.Application.CommandLineArgs.Count <> 3 Or _
                        My.Application.CommandLineArgs(2) < 1 Or _
                        My.Application.CommandLineArgs(2) > 26 Then

                        Console.WriteLine("It is necessary a number between 1 and 26 to uncipher the text.")

                    ElseIf Not IO.File.Exists(My.Application.CommandLineArgs(1)) Then
                        Console.WriteLine("The file " & My.Application.CommandLineArgs(1) & " doesn't exists.")

                    Else

                        file = My.Application.CommandLineArgs(1)
                        key = 26 - My.Application.CommandLineArgs(2)

                        If cipher(file, key, file & "_unciphered") Then
                            Console.WriteLine("File " & file & "_unciphered generated successfuly.")
                        Else
                            Console.WriteLine("The process has not been successful.")
                        End If

                    End If

            End Select

            Console.ReadKey()
        End If

    End Sub

    Function cipher(ByVal file As String, ByVal key As Integer, ByVal outFile As String) As Boolean
        Dim alphabet As String = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        Dim sr As New IO.StreamReader(file)
        Dim sw As New IO.StreamWriter(outFile, True)
        Dim curChar As Char = ""
        Dim x As Integer

        While Not sr.EndOfStream
            curChar = Chr(sr.Read).ToString.ToUpper

            If alphabet.IndexOf(curChar) >= 0 Then

                x = alphabet.IndexOf(curChar) + key + 1

                If x > 26 Then
                    sw.Write(Mid(alphabet, x - 26, 1))
                Else
                    sw.Write(Mid(alphabet, x, 1))
                End If

            Else

                sw.Write(curChar)

            End If

        End While

        sw.Close()

        Return True

    End Function

    Function analyze(ByVal file As String) As Integer
        Dim alphabet As String = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        Dim sr As New IO.StreamReader(file)
        Dim matches(alphabet.Length) As Integer
        Dim curChar As Char = ""
        Dim highest As Integer = 0
        Dim highPos As Integer = 0
        Dim total As Integer = 0

        While Not sr.EndOfStream
            curChar = Chr(sr.Read).ToString.ToUpper

            If alphabet.IndexOf(curChar) >= 0 Then matches(alphabet.IndexOf(curChar)) += 1

        End While

        For Each match In matches
            total += match
        Next

        For i = 0 To alphabet.Length - 1

            If matches(i) > highest Then
                highPos = i
                highest = matches(i)
            End If

            Console.WriteLine("Letter " & Mid(alphabet, i + 1, 1) & " whith " & matches(i) & " matches with " & ((100 / total) * matches(i)).ToString("0.0") & "%.")

        Next

        Console.WriteLine()
        Console.WriteLine("- Then...")
        Console.WriteLine("The letter " & Mid(alphabet, highPos + 1, 1) & " should be an ""E"".")

        If highPos + 1 > 5 Then
            Console.WriteLine("The key might be " & highPos + 1 - 5)
            Return highPos + 1 - 5
        ElseIf highPos + 1 < 5 Then
            Console.WriteLine("The key might be " & 26 - (5 - (highPos + 1)))
            Return 26 - (5 - (highPos + 1))
        Else
            Console.WriteLine("The file might not be ciphered.")
            Return 0
        End If

    End Function
End Module
