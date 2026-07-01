Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03278349CCB
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 14:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782916387; cv=none; b=a032b0ZXIXcZ1UavxhGA7E80OX1kLeUJYX5NhoWQMbwG9XYvm5RV/wnLS4+MKNwVp0Ak5uyv+NofGN8FOGEaQMa18BFKHWJOGr/ZS26NyRKvdAQgyeCeP05JLrJK4KCzhqZ0+xwboNPwvJ4BYuvMw14H5V3v+gtRRyKifytRA6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782916387; c=relaxed/simple;
	bh=PVDJdvbzVnjBvqbTW3wXKW0Q8emMfF1A6Yg99bqBWco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k6pi9sSMf8FqH5paH6FP3QbFa7tZLc/bBTfWavSAOmUh9uUCrEeqOlvfCYRGoFYoPEpSBJqqc1A24EoPycFLIS1MjeUPhuxOEaPFrG9tQankxEH3xxxUuOoBBEbJDxXfpLoP4wBUb7GMO0zaUEelGIhPG7BxOLYlyKEjvK8EptU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pLBoR9MT; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pLBoR9MT"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-39669bcaadfso7658301fa.0
        for <stable@vger.kernel.org>; Wed, 01 Jul 2026 07:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782916384; x=1783521184; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=39U0sS3/Vmv9CORImQp2BstRkdp76UPlrYtszoCbUnE=;
        b=pLBoR9MTeQQ8KmqdbgwsNsOpYVp1+DSodxg83Rig6DeXjv96gns0NsO5BUv+jVPEEO
         hpin9wFO7GCwDSXMKIHsxbe2vQ/1JAb1jIxA/Xkl//6sjLH+A68K+ebRSMmSHthMR07z
         lm0HAVtWWVRB8S27hIkCxId/oTBM1M+oPk32/M80BtQnikj2XV6koK/PHQBxQ7cRiKAb
         er/sTw/SvUnsM8twB2fW9krBbm6gmheSYnfpzVAc6t9Fay/eO+ab0OD62PA5ogzNYPOU
         eMLTBDa/26/sn5rm1qA9I64gPdUqNzYose7b/vuPL7jL1HyW+06dycnxb2y4sZvn50jp
         caFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782916384; x=1783521184;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=39U0sS3/Vmv9CORImQp2BstRkdp76UPlrYtszoCbUnE=;
        b=iPl0e/lmyFcQTx/eUore2fOi/0QhvPKrgdmOGf71Vm07ys1CfNnxyD831XZxPyhVVf
         qUHM2P3KVzWH2j4w4tCGbPoXZdl3qc68k3XbxpQgeEOzWG7ThkdnfhHxMeTP9lFWlOjV
         m1fKGjMZj4POt7FSp56sasDKMQ08KW4990X3E06OxmWhorXDhvfGTsLdtJQYQ6F7fEvs
         BquIAAuDlVGb5gT5GLPtBqs0MxVHJFqz2/NTJHhJDZTSfXfsdcUfBtIjlW/fhtGvWu6Y
         fdwIlajawwhj8jHkEvR6PWbzBaT81iXEkl9sgQsiQ1m38OiwliH91TIw2UyNofJzgeia
         YKZA==
X-Forwarded-Encrypted: i=1; AHgh+Rpge6otW+kGRE7QzOx4NJXSzUhtSwQhpm5KKJB1mQf636i8zPFLMXavprJvM3UAINJKc8IAWFo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yweg3F769ZSZn3aVLhk9Ty0ZWITl75CnsBtKgIbL7hg+lC8wl5s
	4QKvV5uTEXYrY7uSSXCVBgV4FN68Iit40TcYNWcorz5A783EN/R34zxL
X-Gm-Gg: AfdE7clYSjyKNtikQoxyTfpf7lSS7diMGVbwPT4eCbiGqUQWk5CJ72ATXddhFqa1ofQ
	2Fg0YlbauYmHE7fszEY4xAKsy+3VhkcnT+PzeoAckAKXqJMavlWKS6T7ttql99c4rxmfQ8nBapU
	IhCZ6iSrALHpHED9PReSOSjA7wrocOKT9trpc3wg4JQZ8LeRXLn6RYAPW8dUFHnOTqqfsJaZsOD
	Af/mTVgDjvfyjjiHWJslfs+JhP85RjE6phZrKIsNv1I6tFACISb8f7xbVPSEcJ1LoxqSPCtRZKe
	USg0kFDACrnCqxoExR1vXSiPw2sMTwwshHPJrMKUtLK5iCa/TmamcBZfoVYOpQbPD1nMKsgieJj
	kiiT0gJIEcHq6JmjarFT+WDj6XuHHIxQ+KmlcQVD+w+Uu6i/kryLSrbTS4whFCCFc0FyV7F4t/6
	ukhiyZpsOwKOwcnBl5+SUexmeaCJ0=
X-Received: by 2002:a05:651c:440b:10b0:39b:cd2:8bad with SMTP id 38308e7fff4ca-39b36f2eee5mr1776751fa.39.1782916383815;
        Wed, 01 Jul 2026 07:33:03 -0700 (PDT)
Received: from localhost (soda.int.kasm.eu. [2001:678:a5c:1202:7b92:9ac1:b9ef:5287])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39b37fda160sm469551fa.29.2026.07.01.07.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 07:33:02 -0700 (PDT)
Date: Wed, 1 Jul 2026 16:33:02 +0200
From: Klara Modin <klarasmodin@gmail.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org, 
	riel@surriel.com, liam@infradead.org, vbabka@kernel.org, harry@kernel.org, 
	jannh@google.com, balbirs@nvidia.com, sj@kernel.org, ziy@nvidia.com, 
	lance.yang@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [Patch mm-hotfixes v5] mm/page_vma_mapped: fix device-private
 PMD handling
Message-ID: <akUebBUyNFCbWt_k@soda.int.kasm.eu>
References: <20260630021540.17297-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="eweq4kf6ukv7wsn7"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260630021540.17297-1-richard.weiyang@gmail.com>


--eweq4kf6ukv7wsn7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi,

On 2026-06-30 02:15:40 +0000, Wei Yang wrote:
> Commit 65edfda6f3f2 ("mm/rmap: extend rmap and migration support
> device-private entries") introduced the concept of device-private
> PMD entries, but did not correctly update the rmap walk code to
> account for them.
> 
> As a result, when page_vma_mapped_walk() encounters device-private
> PMD entries, it takes no action other than to acquire the PMD lock
> and exit.
> 
> However this is highly problematic for two reasons - firstly,
> device private entries possess a PFN so check_pmd() needs to be
> called to ensure an overlapping PFN range.
> 
> Secondly, and more importantly, if PVMW_MIGRATION is set the
> caller assumes the returned entry is a migration entry, resulting
> in memory corruption when the caller tries to interpret the device
> private entry as such.
> 
> In addition, commit 146287290023 ("mm/huge_memory: implement
> device-private THP splitting") allowed device private PMDs to be
> split like THP mappings, but again did not update this code path.
> 
> As a result, we might race a PMD split prior to acquiring the PMD
> lock.
> 
> This patch addresses all of these issues by invoking check_pmd(),
> ensuring PMVW_MIGRATION is not set and checks whether a split raced
> us we do for PMD THP and migration entries.
> 
> Instead of checking for a subset of the cases after taking the
> pmd_lock(), put device-private along with pmd_trans_huge() and
> pmd_is_migration_entry(). Also remove thp_migration_supported() as
> it is already guarded by pmd_is_migration_entry().

This results in a build bug for my Raspberry Pi 1:

 In file included from <command-line>:
 In function ‘check_pmd’,
     inlined from ‘page_vma_mapped_walk’ at /home/klara/git/linux/trees/bisect/mm/page_vma_mapped.c:256:10:
 /home/klara/git/linux/trees/bisect/include/linux/compiler_types.h:702:45: error: call to ‘__compiletime_assert_433’ declared with attribute error: BUILD_BUG failed
   702 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
       |                                             ^
 /home/klara/git/linux/trees/bisect/include/linux/compiler_types.h:683:25: note: in definition of macro ‘__compiletime_assert’
   683 |                         prefix ## suffix();                             \
       |                         ^~~~~~
 /home/klara/git/linux/trees/bisect/include/linux/compiler_types.h:702:9: note: in expansion of macro ‘_compiletime_assert’
   702 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
       |         ^~~~~~~~~~~~~~~~~~~
 /home/klara/git/linux/trees/bisect/include/linux/build_bug.h:40:37: note: in expansion of macro ‘compiletime_assert’
    40 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
       |                                     ^~~~~~~~~~~~~~~~~~
 /home/klara/git/linux/trees/bisect/include/linux/build_bug.h:60:21: note: in expansion of macro ‘BUILD_BUG_ON_MSG’
    60 | #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
       |                     ^~~~~~~~~~~~~~~~
 /home/klara/git/linux/trees/bisect/include/linux/huge_mm.h:113:28: note: in expansion of macro ‘BUILD_BUG’
   113 | #define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })
       |                            ^~~~~~~~~
 /home/klara/git/linux/trees/bisect/include/linux/huge_mm.h:117:26: note: in expansion of macro ‘HPAGE_PMD_SHIFT’
   117 | #define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
       |                          ^~~~~~~~~~~~~~~
 /home/klara/git/linux/trees/bisect/include/linux/huge_mm.h:118:26: note: in expansion of macro ‘HPAGE_PMD_ORDER’
   118 | #define HPAGE_PMD_NR (1<<HPAGE_PMD_ORDER)
       |                          ^~~~~~~~~~~~~~~
 /home/klara/git/linux/trees/bisect/mm/page_vma_mapped.c:142:20: note: in expansion of macro ‘HPAGE_PMD_NR’
   142 |         if ((pfn + HPAGE_PMD_NR - 1) < pvmw->pfn)
       |                    ^~~~~~~~~~~~

bisect log:

 # bad: [be5c93fa674f0fc3c8f359c2143abce6bbb422e6] Add linux-next specific files for 20260630
 git bisect start 'HEAD'
 # status: waiting for 'good' commit(s), 'bad' commit known
 # good: [dc59e4fea9d83f03bad6bddf3fa2e52491777482] Linux 7.2-rc1
 git bisect good dc59e4fea9d83f03bad6bddf3fa2e52491777482
 # bad: [6148219e90732fd06f5d7a498bda974e6a43ab4b] Merge branch 'nand/next' of https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git
 git bisect bad 6148219e90732fd06f5d7a498bda974e6a43ab4b
 # bad: [e0326ebe10191447ab8fa2e904080df7b743765e] Merge branch 'for-next' of https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git
 git bisect bad e0326ebe10191447ab8fa2e904080df7b743765e
 # bad: [fbc9c5ac47cef5a2b04aef30c8e990b32dcf2548] Merge branch 'hwmon' of https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
 git bisect bad fbc9c5ac47cef5a2b04aef30c8e990b32dcf2548
 # bad: [e488171f6f6df6fc899a355079665fdb3c50b0e3] Merge branch 'for-linus' of https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git
 git bisect bad e488171f6f6df6fc899a355079665fdb3c50b0e3
 # bad: [60db0fcb8fc9d80ac0b63041c632b41a311a45f1] Merge branch 'fs-current' of linux-next
 git bisect bad 60db0fcb8fc9d80ac0b63041c632b41a311a45f1
 # good: [51021d260d682aa17b3533848a99160ab83e0c93] Merge branch 'vfs.fixes' of https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
 git bisect good 51021d260d682aa17b3533848a99160ab83e0c93
 # good: [ded56474db6552260786a65898322464b72c7540] mm: a second pagecache maintainer
 git bisect good ded56474db6552260786a65898322464b72c7540
 # good: [6c893b948351d42cfc3761cc746ab5b3d03ee7f3] Merge branch 'misc-7.2' into next-fixes
 git bisect good 6c893b948351d42cfc3761cc746ab5b3d03ee7f3
 # good: [bfcc55a14179495b0c41408908fd7b9d7785c694] lib: test_hmm: use device devt for coherent device range selection
 git bisect good bfcc55a14179495b0c41408908fd7b9d7785c694
 # good: [a27318567c92ba5482906d047e71a7aa4fd01889] Merge branch 'fixes' of https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git
 git bisect good a27318567c92ba5482906d047e71a7aa4fd01889
 # bad: [6887a39652cdfd4cfd3b0962662c9cbc26ce5252] mm/page_vma_mapped: fix device-private PMD handling
 git bisect bad 6887a39652cdfd4cfd3b0962662c9cbc26ce5252
 # good: [2cc6bd0efc264b9ac760c2bc74dff4f521a680a1] MAINTAINERS: s/SeongJae/SJ/
 git bisect good 2cc6bd0efc264b9ac760c2bc74dff4f521a680a1
 # first 'bad' commit: [6887a39652cdfd4cfd3b0962662c9cbc26ce5252] mm/page_vma_mapped: fix device-private PMD handling

> 
> Fixes: 65edfda6f3f2 ("mm/rmap: extend rmap and migration support device-private entries")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> Suggested-by: David Hildenbrand <david@kernel.org>
> Cc: David Hildenbrand <david@kernel.org>
> Cc: Balbir Singh <balbirs@nvidia.com>
> Cc: SeongJae Park <sj@kernel.org>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Lorenzo Stoakes <ljs@kernel.org>
> Cc: Lance Yang <lance.yang@linux.dev>
> 
> ---
> v5:
>   * put device-private pmd handling along with the other two cases
>   * remove thp_migration_supported()
> v4: https://lore.kernel.org/all/20260624065353.1622-1-richard.weiyang@gmail.com/T/#u
>   * refine subject and commit log based on Lorenzo's suggestion
>   * put pmd device-private entry handling in its own if branch,
>     suggested by Lorenzo
> 
> v3:
>   * remove cleanup part, only fix the issue for device-private entry
>   * refine user effect description based on Lorenzo's suggestion
> 
> v2: https://lore.kernel.org/all/20260616063436.20455-1-richard.weiyang@gmail.com/T/#u
>   * specify the possible error case of current code and user visible effect
>   * besides fix, cleanup the pmd entry handling based on David's suggestion
> 
> v1: https://lore.kernel.org/linux-mm/20260508013728.21285-1-richard.weiyang@gmail.com/
> ---
>  mm/page_vma_mapped.c | 30 ++++++++++++++++--------------
>  1 file changed, 16 insertions(+), 14 deletions(-)
> 
> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> index 2ccbabfb2cc1..2d6c58488e3a 100644
> --- a/mm/page_vma_mapped.c
> +++ b/mm/page_vma_mapped.c
> @@ -243,21 +243,30 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>  		 */
>  		pmde = pmdp_get_lockless(pvmw->pmd);
>  
> -		if (pmd_trans_huge(pmde) || pmd_is_migration_entry(pmde)) {
> +		if (pmd_trans_huge(pmde) || pmd_is_migration_entry(pmde) ||
> +		    pmd_is_device_private_entry(pmde)) {
>  			pvmw->ptl = pmd_lock(mm, pvmw->pmd);
>  			pmde = *pvmw->pmd;
> -			if (!pmd_present(pmde)) {
> +			if (pmd_is_migration_entry(pmde)) {
>  				softleaf_t entry;
>  
> -				if (!thp_migration_supported() ||
> -				    !(pvmw->flags & PVMW_MIGRATION))
> +				if (!(pvmw->flags & PVMW_MIGRATION))
>  					return not_found(pvmw);
>  				entry = softleaf_from_pmd(pmde);
> +				if (!check_pmd(softleaf_to_pfn(entry), pvmw))
> +					return not_found(pvmw);
> +				return true;
> +			} else if (pmd_is_device_private_entry(pmde)) {
> +				softleaf_t entry;
>  

> -				if (!softleaf_is_migration(entry) ||
> -				    !check_pmd(softleaf_to_pfn(entry), pvmw))

My only guess here would be that the compiler evaluates
!softleaf_is_migration(entry) to always be true and optimises away the
!check_pmd(softleaf_to_pfn(entry), pvmw) which is why this worked
before?

> +				if (pvmw->flags & PVMW_MIGRATION)
> +					return not_found(pvmw);
> +				entry = softleaf_from_pmd(pmde);
> +				if (!check_pmd(softleaf_to_pfn(entry), pvmw))
>  					return not_found(pvmw);
>  				return true;
> +			} else if (!pmd_present(pmde)) {
> +				return not_found(pvmw);
>  			}
>  			if (likely(pmd_trans_huge(pmde))) {
>  				if (pvmw->flags & PVMW_MIGRATION)
> @@ -266,17 +275,10 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>  					return not_found(pvmw);
>  				return true;
>  			}
> -			/* THP pmd was split under us: handle on pte level */
> +			/* THP/device-private pmd was split under us: handle on pte level */
>  			spin_unlock(pvmw->ptl);
>  			pvmw->ptl = NULL;
>  		} else if (!pmd_present(pmde)) {
> -			const softleaf_t entry = softleaf_from_pmd(pmde);
> -
> -			if (softleaf_is_device_private(entry)) {
> -				pvmw->ptl = pmd_lock(mm, pvmw->pmd);
> -				return true;
> -			}
> -
>  			if ((pvmw->flags & PVMW_SYNC) &&
>  			    thp_vma_suitable_order(vma, pvmw->address,
>  						   PMD_ORDER) &&
> -- 
> 2.34.1
> 

Regards,
Klara Modin

--eweq4kf6ukv7wsn7
Content-Type: application/gzip
Content-Disposition: attachment; filename="config.gz"
Content-Transfer-Encoding: base64

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

--eweq4kf6ukv7wsn7--
