using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;

namespace tpmodul9_1302210127;
[ApiController]
[Route("api/[controller]")]
public class MahasiswaController : ControllerBase
{
    private static List<Mahasiswa> listMhs = new List<Mahasiswa>
    {

        new Mahasiswa("Rafidhia Haikal P.", "1302210127"),
        new Mahasiswa("Glorious Satria D. A.", "1302213015"),
        new Mahasiswa("Putu Vidya A. R.", "1302213026"),
        new Mahasiswa("Farhan Mulya A.", "1302213073"),
        new Mahasiswa("Kevin", "1302210019")
        
    };

    [HttpGet()]
    public IEnumerable<Mahasiswa> Get()
    {
        return listMhs;
    }

    [HttpGet("{id}")]
    public Mahasiswa Get(int id)
    {
        return listMhs[id];
    }


    // POST api/<ValuesController>
    [HttpPost]
    public void Post([FromBody] Mahasiswa value)
    {
        listMhs.Add(value);
    }

    // PUT api/<ValuesController>/5
    [HttpPut("{id}")]
    public void Put(int id, [FromBody] Mahasiswa value)
    {
        listMhs[id] = value;
    }

    // DELETE api/<ValuesController>/5
    [HttpDelete("{id}")]
    public void Delete(int id)
    {
        listMhs.RemoveAt(id);
    }
}
