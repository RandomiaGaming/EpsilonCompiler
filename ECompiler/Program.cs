using System.Diagnostics;
using System.Text;

namespace ECompiler
{
    public static class Program
    {
        public static void Main(string[] args)
        {
            
        }
        public static void Format(string filePath)
        {

        }
        public static void Compile(string filePath)
        {
            string cCode = CompileToC(code);

            byte[] cCodeBytes = Encoding.UTF8.GetBytes(cCode);

            FileStream? cCodeStream = CreateTempFile(".c", FileAccess.Write, FileShare.Read);

            cCodeStream.Write(cCodeBytes, 0, cCodeBytes.Length);

            cCodeStream.Dispose();

            FileStream? GCCFile = CreateTempFile(".exe", FileAccess.Write, FileShare.Read);

            Stream? GCCResource = typeof(Program).Assembly.GetManifestResourceStream("GCC.exe");

            GCCResource.CopyTo(GCCFile);

            GCCResource.Dispose();

            GCCFile.Flush();

            AwaitProgram(GCCFile.Name, $"\"Program.exe\" \"{cCodeStream.Name}\"");

            GCCFile.Dispose();

            File.Delete(cCodeStream.Name);

            File.Delete(GCCFile.Name);
        }
        public static void AwaitProgram(string exePath, string args)
        {
            Process.Start(exePath, args).WaitForExit();
        }
        public static string CompileToC(string code)
        {
            return code;
        }
        public static FileStream? CreateTempFile(string extension = "", FileAccess fileAccess = FileAccess.ReadWrite, FileShare fileShare = FileShare.None)
        {
            FileStream? output = null;
            uint tempFileID = 0;
            string tempFolder = Path.GetTempPath();
            while (output is null)
            {
                try
                {
                    output = File.Open(Path.Combine(tempFolder, "ECompiler" + tempFileID.ToString() + extension), FileMode.CreateNew, fileAccess, fileShare);
                }
                catch
                {
                    tempFileID++;
                }
            }
            return output;
        }
    }
}