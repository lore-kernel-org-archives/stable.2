Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0038B245008;
	Wed,  1 Jul 2026 15:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782920201; cv=none; b=W/qHquAEvW/EYK+ZB+tda5CrwEbg0MwDtnZISSDU768aU6ikSEmd4nNZXFVIxgB9Jzd6YWnEI2/82oHmBFuOEssflammPrL90Xxp9X2jo8U78wzigHCLDwbYxrUwKgWK3dlq6sclXfNELXkKthYATneNHk6iq04ZHabb/Sek5IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782920201; c=relaxed/simple;
	bh=VQbiLwjGvEdfzzudWHAJ36uApEcKpDu6X348Bgy2HKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tHPuMLEAPSr+QUhDRQ783ze/DlFcwwQF0UVOJtGQE24C8XGm1W16CGtMLyGqZQd/QTwPSbYQ9NBNhC/RTohRM5hExRqXVFzY4FToH6RPifWIA7c5sTLY91PWZeZEj24TOLltxfETwwj/pr3QN6nEnmUHvb9AoXfIUeClkJmBGSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ALO4TMX7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ALO4TMX7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D012A1F000E9;
	Wed,  1 Jul 2026 15:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782920199;
	bh=WY27tDnwZ3xUvIzjDTrPDWKSVQtL01pzpiUeaQvLqC4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ALO4TMX7lDqgm7sGla6n18nE+akAFq9ByefM9KKD+Z+2aMlhlzz1bfYh5EX8Ue1LD
	 CaXlcc30DmhgX2WgUZr1EhGcATiFy2R9++0KhfinF0EFC5PWHXDClDmmMHJuS8SVwK
	 65JQv9p4HWYUW+dMukAJsHL+TYg80h0IzjFZiBIs/X/FMedv+G1sXAbam8ttWQqm7p
	 GChUKrXC6bUpbW5eUrdIy+WWXlj2BOayiO+G7UAnkbPnF/UctcedhWjn2zQuoBkPop
	 OjkFcOQTRPGXaSNW3qPicXE8/garC5Z8UcWRMe4lc6vid426CPm2wgbhA9mX8sZLxk
	 AMoICgIKckaDQ==
Message-ID: <d4e4180e-dcdf-40e6-b5a2-2ac55f4aecc4@kernel.org>
Date: Wed, 1 Jul 2026 17:36:33 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch mm-hotfixes v5] mm/page_vma_mapped: fix device-private PMD
 handling
To: Klara Modin <klarasmodin@gmail.com>, Wei Yang <richard.weiyang@gmail.com>
Cc: akpm@linux-foundation.org, ljs@kernel.org, riel@surriel.com,
 liam@infradead.org, vbabka@kernel.org, harry@kernel.org, jannh@google.com,
 balbirs@nvidia.com, sj@kernel.org, ziy@nvidia.com, lance.yang@linux.dev,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260630021540.17297-1-richard.weiyang@gmail.com>
 <akUebBUyNFCbWt_k@soda.int.kasm.eu>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <akUebBUyNFCbWt_k@soda.int.kasm.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/1/26 16:33, Klara Modin wrote:
> Hi,
> 
> On 2026-06-30 02:15:40 +0000, Wei Yang wrote:
>> Commit 65edfda6f3f2 ("mm/rmap: extend rmap and migration support
>> device-private entries") introduced the concept of device-private
>> PMD entries, but did not correctly update the rmap walk code to
>> account for them.
>>
>> As a result, when page_vma_mapped_walk() encounters device-private
>> PMD entries, it takes no action other than to acquire the PMD lock
>> and exit.
>>
>> However this is highly problematic for two reasons - firstly,
>> device private entries possess a PFN so check_pmd() needs to be
>> called to ensure an overlapping PFN range.
>>
>> Secondly, and more importantly, if PVMW_MIGRATION is set the
>> caller assumes the returned entry is a migration entry, resulting
>> in memory corruption when the caller tries to interpret the device
>> private entry as such.
>>
>> In addition, commit 146287290023 ("mm/huge_memory: implement
>> device-private THP splitting") allowed device private PMDs to be
>> split like THP mappings, but again did not update this code path.
>>
>> As a result, we might race a PMD split prior to acquiring the PMD
>> lock.
>>
>> This patch addresses all of these issues by invoking check_pmd(),
>> ensuring PMVW_MIGRATION is not set and checks whether a split raced
>> us we do for PMD THP and migration entries.
>>
>> Instead of checking for a subset of the cases after taking the
>> pmd_lock(), put device-private along with pmd_trans_huge() and
>> pmd_is_migration_entry(). Also remove thp_migration_supported() as
>> it is already guarded by pmd_is_migration_entry().
> 
> This results in a build bug for my Raspberry Pi 1:
> 
>  In file included from <command-line>:
>  In function ‘check_pmd’,
>      inlined from ‘page_vma_mapped_walk’ at /home/klara/git/linux/trees/bisect/mm/page_vma_mapped.c:256:10:
>  /home/klara/git/linux/trees/bisect/include/linux/compiler_types.h:702:45: error: call to ‘__compiletime_assert_433’ declared with attribute error: BUILD_BUG failed
>    702 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>        |                                             ^
>  /home/klara/git/linux/trees/bisect/include/linux/compiler_types.h:683:25: note: in definition of macro ‘__compiletime_assert’
>    683 |                         prefix ## suffix();                             \
>        |                         ^~~~~~
>  /home/klara/git/linux/trees/bisect/include/linux/compiler_types.h:702:9: note: in expansion of macro ‘_compiletime_assert’
>    702 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>        |         ^~~~~~~~~~~~~~~~~~~
>  /home/klara/git/linux/trees/bisect/include/linux/build_bug.h:40:37: note: in expansion of macro ‘compiletime_assert’
>     40 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>        |                                     ^~~~~~~~~~~~~~~~~~
>  /home/klara/git/linux/trees/bisect/include/linux/build_bug.h:60:21: note: in expansion of macro ‘BUILD_BUG_ON_MSG’
>     60 | #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
>        |                     ^~~~~~~~~~~~~~~~
>  /home/klara/git/linux/trees/bisect/include/linux/huge_mm.h:113:28: note: in expansion of macro ‘BUILD_BUG’
>    113 | #define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })
>        |                            ^~~~~~~~~
>  /home/klara/git/linux/trees/bisect/include/linux/huge_mm.h:117:26: note: in expansion of macro ‘HPAGE_PMD_SHIFT’
>    117 | #define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
>        |                          ^~~~~~~~~~~~~~~
>  /home/klara/git/linux/trees/bisect/include/linux/huge_mm.h:118:26: note: in expansion of macro ‘HPAGE_PMD_ORDER’
>    118 | #define HPAGE_PMD_NR (1<<HPAGE_PMD_ORDER)
>        |                          ^~~~~~~~~~~~~~~
>  /home/klara/git/linux/trees/bisect/mm/page_vma_mapped.c:142:20: note: in expansion of macro ‘HPAGE_PMD_NR’
>    142 |         if ((pfn + HPAGE_PMD_NR - 1) < pvmw->pfn)
>        |                    ^~~~~~~~~~~~
> 
> bisect log:
> 
>  # bad: [be5c93fa674f0fc3c8f359c2143abce6bbb422e6] Add linux-next specific files for 20260630
>  git bisect start 'HEAD'
>  # status: waiting for 'good' commit(s), 'bad' commit known
>  # good: [dc59e4fea9d83f03bad6bddf3fa2e52491777482] Linux 7.2-rc1
>  git bisect good dc59e4fea9d83f03bad6bddf3fa2e52491777482
>  # bad: [6148219e90732fd06f5d7a498bda974e6a43ab4b] Merge branch 'nand/next' of https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git
>  git bisect bad 6148219e90732fd06f5d7a498bda974e6a43ab4b
>  # bad: [e0326ebe10191447ab8fa2e904080df7b743765e] Merge branch 'for-next' of https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git
>  git bisect bad e0326ebe10191447ab8fa2e904080df7b743765e
>  # bad: [fbc9c5ac47cef5a2b04aef30c8e990b32dcf2548] Merge branch 'hwmon' of https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
>  git bisect bad fbc9c5ac47cef5a2b04aef30c8e990b32dcf2548
>  # bad: [e488171f6f6df6fc899a355079665fdb3c50b0e3] Merge branch 'for-linus' of https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git
>  git bisect bad e488171f6f6df6fc899a355079665fdb3c50b0e3
>  # bad: [60db0fcb8fc9d80ac0b63041c632b41a311a45f1] Merge branch 'fs-current' of linux-next
>  git bisect bad 60db0fcb8fc9d80ac0b63041c632b41a311a45f1
>  # good: [51021d260d682aa17b3533848a99160ab83e0c93] Merge branch 'vfs.fixes' of https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
>  git bisect good 51021d260d682aa17b3533848a99160ab83e0c93
>  # good: [ded56474db6552260786a65898322464b72c7540] mm: a second pagecache maintainer
>  git bisect good ded56474db6552260786a65898322464b72c7540
>  # good: [6c893b948351d42cfc3761cc746ab5b3d03ee7f3] Merge branch 'misc-7.2' into next-fixes
>  git bisect good 6c893b948351d42cfc3761cc746ab5b3d03ee7f3
>  # good: [bfcc55a14179495b0c41408908fd7b9d7785c694] lib: test_hmm: use device devt for coherent device range selection
>  git bisect good bfcc55a14179495b0c41408908fd7b9d7785c694
>  # good: [a27318567c92ba5482906d047e71a7aa4fd01889] Merge branch 'fixes' of https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git
>  git bisect good a27318567c92ba5482906d047e71a7aa4fd01889
>  # bad: [6887a39652cdfd4cfd3b0962662c9cbc26ce5252] mm/page_vma_mapped: fix device-private PMD handling
>  git bisect bad 6887a39652cdfd4cfd3b0962662c9cbc26ce5252
>  # good: [2cc6bd0efc264b9ac760c2bc74dff4f521a680a1] MAINTAINERS: s/SeongJae/SJ/
>  git bisect good 2cc6bd0efc264b9ac760c2bc74dff4f521a680a1
>  # first 'bad' commit: [6887a39652cdfd4cfd3b0962662c9cbc26ce5252] mm/page_vma_mapped: fix device-private PMD handling
> 
>>
>> Fixes: 65edfda6f3f2 ("mm/rmap: extend rmap and migration support device-private entries")
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> Suggested-by: David Hildenbrand <david@kernel.org>
>> Cc: David Hildenbrand <david@kernel.org>
>> Cc: Balbir Singh <balbirs@nvidia.com>
>> Cc: SeongJae Park <sj@kernel.org>
>> Cc: Zi Yan <ziy@nvidia.com>
>> Cc: Lorenzo Stoakes <ljs@kernel.org>
>> Cc: Lance Yang <lance.yang@linux.dev>
>>
>> ---
>> v5:
>>   * put device-private pmd handling along with the other two cases
>>   * remove thp_migration_supported()
>> v4: https://lore.kernel.org/all/20260624065353.1622-1-richard.weiyang@gmail.com/T/#u
>>   * refine subject and commit log based on Lorenzo's suggestion
>>   * put pmd device-private entry handling in its own if branch,
>>     suggested by Lorenzo
>>
>> v3:
>>   * remove cleanup part, only fix the issue for device-private entry
>>   * refine user effect description based on Lorenzo's suggestion
>>
>> v2: https://lore.kernel.org/all/20260616063436.20455-1-richard.weiyang@gmail.com/T/#u
>>   * specify the possible error case of current code and user visible effect
>>   * besides fix, cleanup the pmd entry handling based on David's suggestion
>>
>> v1: https://lore.kernel.org/linux-mm/20260508013728.21285-1-richard.weiyang@gmail.com/
>> ---
>>  mm/page_vma_mapped.c | 30 ++++++++++++++++--------------
>>  1 file changed, 16 insertions(+), 14 deletions(-)
>>
>> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
>> index 2ccbabfb2cc1..2d6c58488e3a 100644
>> --- a/mm/page_vma_mapped.c
>> +++ b/mm/page_vma_mapped.c
>> @@ -243,21 +243,30 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>>  		 */
>>  		pmde = pmdp_get_lockless(pvmw->pmd);
>>  
>> -		if (pmd_trans_huge(pmde) || pmd_is_migration_entry(pmde)) {
>> +		if (pmd_trans_huge(pmde) || pmd_is_migration_entry(pmde) ||
>> +		    pmd_is_device_private_entry(pmde)) {
>>  			pvmw->ptl = pmd_lock(mm, pvmw->pmd);
>>  			pmde = *pvmw->pmd;
>> -			if (!pmd_present(pmde)) {
>> +			if (pmd_is_migration_entry(pmde)) {
>>  				softleaf_t entry;
>>  
>> -				if (!thp_migration_supported() ||
>> -				    !(pvmw->flags & PVMW_MIGRATION))
>> +				if (!(pvmw->flags & PVMW_MIGRATION))
>>  					return not_found(pvmw);
>>  				entry = softleaf_from_pmd(pmde);
>> +				if (!check_pmd(softleaf_to_pfn(entry), pvmw))
>> +					return not_found(pvmw);
>> +				return true;
>> +			} else if (pmd_is_device_private_entry(pmde)) {
>> +				softleaf_t entry;
>>  
> 
>> -				if (!softleaf_is_migration(entry) ||
>> -				    !check_pmd(softleaf_to_pfn(entry), pvmw))
> 
> My only guess here would be that the compiler evaluates
> !softleaf_is_migration(entry) to always be true and optimises away the
> !check_pmd(softleaf_to_pfn(entry), pvmw) which is why this worked
> before?

Weird, we enter this path only with

pmd_trans_huge(pmde) || pmd_is_migration_entry(pmde) ||
pmd_is_device_private_entry(pmde)

If any one of these would compile for !CONFIG_TRANSPARENT_HUGEPAGE that would be
odd.

pmd_is_device_private_entry() is hard-coded to false unless
CONFIG_ARCH_ENABLE_THP_MIGRATION. Which is only selected with
ARCH_ENABLE_THP_MIGRATION.

pmd_trans_huge() as well.

Maybe it's struggling with pmd_is_migration_entry() on some (older) compilers?
(not innlining stuff and not properly optimizing it out).

The whole conditional must be optimized out.

We could check for IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) right at the start
to make it easier for the compiler:

if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) &&
    (pmd_trans_huge(pmde) || pmd_is_migration_entry(pmde) ||
     pmd_is_device_private_entry(pmde))) {


-- 
Cheers,

David
