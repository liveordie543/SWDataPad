using SWDataPad.Data.Entities;

namespace SWDataPad.Data.Repositories
{
    public class CharacterRepository : BaseRepository<Character>
    {
        public void DeleteById(int id)
        {
            Character character = SelectSingleOrDefault(c => c.Id == id);
            if (character != null)
            {
                Delete(character);
            }
        }
    }
}
