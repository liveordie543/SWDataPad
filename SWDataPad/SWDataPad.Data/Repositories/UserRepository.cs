using SWDataPad.Data.Entities;
using System.Data.Entity;
using System.Linq;

namespace SWDataPad.Data.Repositories
{
    public class UserRepository : BaseRepository<User>
    {
        protected override IQueryable<User> BuildSingleEntityQuery(IQueryable<User> query)
        {
            return base.BuildSingleEntityQuery(query)
                .Include(u => u.Characters);
            //.Include(u => u.Characters.Select(c => c.CharacterSheet));
        }

        protected override IQueryable<User> BuildMultiEntityQuery(IQueryable<User> query)
        {
            return base.BuildMultiEntityQuery(query)
                .Include(u => u.Characters);
            //.Include(u => u.Characters.Select(c => c.CharacterSheet));
        }
    }
}