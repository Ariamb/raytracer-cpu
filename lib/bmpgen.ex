import Bitwise
defmodule Bmpgen do
  @moduledoc """
  Documentation for `Bmpgen`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Bmpgen.hello()
      :world

  """
  def hello do
    :world
  end

  def fileHeaderSize do #constant
    14
  end

  def infoHeaderSize do #constant
    40
  end

  def bytes_per_pixel do
    4
  end

  #def recursivebasicwrite(heigth, 0, originalwidth) do
  #  File.write!("img.bmp", [<<0>>, <<0>>, <<0>>], [:append])
  #  recursivebasicwrite(heigth-1, originalwidth, originalwidth)
  #end
  
  def recursiveFill(mat, maxi, maxj, maxi, maxj) do
    #File.write!("img.bmp", [<<0>>, <<0>>, <<0>>], [:append])
  end

  def recursiveFill(mat, i, maxj, maxi, maxj) do
    #File.write!("img.bmp", [<<0>>, <<0>>, <<0>>], [:append])
    IO.puts("#{i}/#{maxi}")
    recursiveFill(mat, i + 1, 0, maxi, maxj)
  end
  


  def recursiveFill(mat, i, j, maxi, maxj) do
    b = div(i, 256) * 10
    g = 256 - div(j, 256)
    r = 256 - div(i, 256)
    File.write!("img.bmp", [<<b>>, <<g>>, <<r>>, <<255>>], [:append])
    #File.write!("img.bmp", [<<255>>, <<0>>, <<0>>, <<255>>], [:append])

    Bmpgen.recursiveFill(mat, i, j+1, maxi, maxj)
    


    #mat = Matrex.set(mat, 1, (i * 1024 + j) * 4 + 0, <<(i+j) * 255 / (maxi+maxj)>>)
    #mat = Matrex.set(mat, 1, (i * 1024 + j) * 4 + 1, <<(j * 255 / maxj)>>)
    #mat = Matrex.set(mat, 1, (i * 1024 + j) * 4 + 2, <<(i * 255 / maxi)>>)
    #mat = Matrex.set(mat, 1, (i * 1024 + j) * 4 + 3, <<255>>)
  end



  def writeFileHeader(height, stride) do
    fileSize = Bmpgen.fileHeaderSize + Bmpgen.infoHeaderSize + (stride * height)    
    fileHeader = ['B'] ++ ['M'] ++ [<<fileSize>>] ++ [<<fileSize >>> 8>>] ++ [<<fileSize >>> 16>>] ++ [<<fileSize >>> 24>>] ++ List.duplicate(<<0>>, 4) ++ [<<Bmpgen.fileHeaderSize + Bmpgen.infoHeaderSize>>] ++ List.duplicate(<<0>>, 3)
    #IO.inspect(fileHeader)
    IO.puts("\n-----------------------\n")
    File.write!("img.bmp", fileHeader)
  end
  def writeInfoHeader(height, width) do
    
    infoHeader = [<<Bmpgen.infoHeaderSize>>] ++ List.duplicate(<<0>>, 3) ++ [<<width>>, <<width >>> 8>>, <<width >>> 16>>, <<width >>> 24>>, <<height>>, <<height >>> 8>>, <<height >>> 16>>, <<height >>> 24>>, <<1>>, <<0>>, <<Bmpgen.bytes_per_pixel * 8>>] ++ List.duplicate(<<0>>, 25)
    #IO.inspect(infoHeader)
    File.write!("img.bmp", infoHeader, [:append])
  end
end
width = 1024
height = 1024
widthInBytes = width * Bmpgen.bytes_per_pixel

paddingSize = rem((4 - rem(widthInBytes, 4)), 4)
stride = widthInBytes + paddingSize


Bmpgen.writeFileHeader(height, stride)
Bmpgen.writeInfoHeader(height, width)
Bmpgen.recursiveFill(69, 0, 0, 1024, 1024)


#img = Matrex.zeros(1, width * height * Bmpgen.bytes_per_pixel)



#fileHeader = [] ++ ['B'] ++ ['M'] ++ 

#File.write!("img.bmp", ['B'])