Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3662A37AA63
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 11:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782127321; cv=none; b=JiScuNqg2Dk4RsPpYamcl1Uin+SKSNpl+RYZ6ZfSeczFSV7BtfrrrOf/YjK5ZWoE2KDzxNrlFGdCmNQOmceAiAssXjly0EqDZCbs30skLreuUGVBV9Iy0qlPMUYnZjN7BjQzQQYjcjvf5Rf3njLm8MbhZRjAquIeHKxlqPCLENE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782127321; c=relaxed/simple;
	bh=DbsgN559wwgkJdyMTyrJSGpe3stlPCRZqzaheFNXpgc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ncPrrR1i5rRpDhp0ke6w5QXR4JZJA2x8aWdjLh3ivtpXX1G1RAmH4BWo1IKdUeBWZrX6No4Hie9eSmrC793FsgYvTATbTYnsJN112059837Bgs3Mw5YD/DL10MEvxVeAJIstPqJ/7Kx/mMeq4DmnIMiVJ0ILb86EVK+kU6lkXGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Hus2QOkI; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Hus2QOkI"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782127317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eyu8QkMU9oD+rhZhohHWmAdRSmzUx+ZJodmNZ5O/EZQ=;
	b=Hus2QOkIp0sv1hOTAN3UcVZHhAwB+Vqzn++43K5BnELGdr9+tGZHGuYxKpVEznX5be4EEh
	TuHnXTqHZVboT3QA0d6ckg8lLp8YpIvxvh22O9hbMrent2/wABmngEewPkcEw4hZngleN7
	/o4iL0DHhWQNxDcykNUgQ2FN2lvNs78=
From: Lance Yang <lance.yang@linux.dev>
To: richard.weiyang@gmail.com
Cc: david@kernel.org,
	akpm@linux-foundation.org,
	riel@surriel.com,
	liam@infradead.org,
	vbabka@kernel.org,
	harry@kernel.org,
	jannh@google.com,
	balbirs@nvidia.com,
	ziy@nvidia.com,
	sj@kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org,
	ljs@kernel.org,
	Lance Yang <lance.yang@linux.dev>
Subject: Re: [Patch v2] mm/page_vma_mapped: revalidate and do proper check before return device-private pmd
Date: Mon, 22 Jun 2026 19:21:47 +0800
Message-Id: <20260622112147.66777-1-lance.yang@linux.dev>
In-Reply-To: <20260620021353.nn7xp2ldqachq7gp@master>
References: <20260620021353.nn7xp2ldqachq7gp@master>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On Sat, Jun 20, 2026 at 02:13:53AM +0000, Wei Yang wrote:
>On Fri, Jun 19, 2026 at 12:48:26PM +0200, David Hildenbrand (Arm) wrote:
>>On 6/19/26 12:44, Lorenzo Stoakes wrote:
>>> -cc wrong email
>>> 
>>> On Tue, Jun 16, 2026 at 06:34:36AM +0000, Wei Yang wrote:
>>>> For pmd_trans_huge() and pmd_is_migration_entry(), we does following
>>>> before return the pmd entry:
>>>>
>>>>   * re-validate pmd entry after PTL
>>>>   * check PVMW_MIGRATION
>>>>   * check_pmd()
>>>>   * handle on pte level if split under us
>>>>
>>>> But for device-private pmd, we just return after pmd_lock().
>>>>
>>>> This may return improper entry, e.g. if we are looking for a migration
>>>> entry, device-private entry could still be returned, which leads to data
>>>> corruption.
>>> 
>>> I don't thik this is quite clear?
>>> 
>>> How about:
>>> 
>>> 	If a softleaf entry is present, the existing code simply acquires the
>>> 	PMD lock and returns success even if PVMW_MIGRATION is set (indicating a
>>> 	migration entry is sought), meaning that the caller can incorrectly
>>> 	interpret the entry as something it is not, causing data corruption.
>>> 
>>>>
>>>> This patch fixes commit 65edfda6f3f2 ("mm/rmap: extend rmap and migration
>>>> support device-private entries") by following the same pattern as
>>>> pmd_trans_huge() and pmd_is_migration_entry() for device private entry.
>>>>
>>>> While at it, it cleanups the pmd entry handling in page_vma_mapped_walk().
>>>>
>>>>   * Instead of handling trans huge/migration entry/device private entry
>>>>     in a mixed manner, we put each case into its own if condition and
>>>>     handle with the same pattern.
>>>>   * Also we grab PTL and make sure pmd is not changed under us after
>>>>     above check instead of do the check with PTL hold.
>>>>   * restart the process if pmd is changed under us
>>> 
>>> You're doing quite a bit for a fix and you're putting it all in one place.
>>> 
>>> How about do the fix as 1 patch, and then cleanups as other ones? It helps with
>>> review too :)
>>> 
>>> It's a general rule of thumb that if you do more than one of moving, refactoring
>>> or changing code, to do them as separate patches so a reviewer/somebody
>>> bisecting can clearly separate each.
>>> 
>>> Also PLEASE do not add new functionality (this lock recheck) in a fixes
>>> patch. We'll end up backporting new logic that way.
>>> 
>>> Make the fixes bit _minimal_.
>>
>>To be fair, I asked for this
>>
>>https://lore.kernel.org/all/2d48ef0d-1110-4a9d-adcb-f701a1ce2cfa@kernel.org/
>>
>>But given that Wei mostly used my quick draft without properly checking the
>>implications, yeah, let's fix it first separately.
>
>Sorry, if I misunderstand your point.
>
>>
>>I can then follow up with a proper cleanup.

FYI, spent a few days chasing the history here. Dropping my notes in case
they save someone else some time reading or refactoring this code :P

TL;DR below.

For THP PMDs, the lockless pmd_trans_huge() check was only a candidate
filter from day one.

ace71a19cec5 [1] ("mm: introduce page_vma_mapped_walk()") already had the
lock-and-recheck rule: the lockless check only got us into the branch,
then the code took pmd_lock() before making any PMD-level decision:

	if (pmd_trans_huge(*pvmw->pmd)) {
		pvmw->ptl = pmd_lock(mm, pvmw->pmd);
		...
	} else {
		...
	}

616b8371539a [2] ("mm: thp: enable thp migration in generic path") later
added PMD migration entries to that same locked branch:

	if (pmd_trans_huge(*pvmw->pmd) || is_pmd_migration_entry(*pvmw->pmd)) {
		pvmw->ptl = pmd_lock(mm, pvmw->pmd);
		...
	} else {
		...
	}

Current code spells that helper as pmd_is_migration_entry(); that came
from the later 0ac881efe164 softleaf cleanup, with no functional change
intended.

3306d3119cea [3] ("mm: page_vma_mapped_walk(): use pmde for *pvmw->pmd")
later made the post-lock PMD value explicit as pmde. Same rule, just less
repeated *pvmw->pmd dereferencing under PTL:

	pmde = READ_ONCE(*pvmw->pmd);
	if (pmd_trans_huge(pmde) || is_pmd_migration_entry(pmde)) {
		pvmw->ptl = pmd_lock(mm, pvmw->pmd);
		pmde = *pvmw->pmd;
		...
	}

One extra detail matters here. In ace71a19cec5 [1], the locked THP PMD
branch rejected a non-present PMD before the present-THP check:

	if (pmd_trans_huge(*pvmw->pmd)) {
		pvmw->ptl = pmd_lock(mm, pvmw->pmd);
		if (!pmd_present(*pvmw->pmd))
			return not_found(pvmw);
		if (likely(pmd_trans_huge(*pvmw->pmd))) {
			...
		} else {
			...
		}
	}

616b8371539a [2] could not keep that order after adding PMD migration
entries, because a PMD migration entry is non-present. So the locked
branch was reshaped to check the still-present THP PMD case first, and
only then handle the non-present PMD as the PMD migration-entry case:

	if (pmd_trans_huge(*pvmw->pmd) || is_pmd_migration_entry(*pvmw->pmd)) {
		pvmw->ptl = pmd_lock(mm, pvmw->pmd);
		if (likely(pmd_trans_huge(*pvmw->pmd))) {
			...
		} else if (!pmd_present(*pvmw->pmd)) {
			...
		} else {
			...
		}
	}

Inside that non-present branch, 616b8371539a [2] made it a
PMD-migration-only case: first require THP migration support, then
require PVMW_MIGRATION. Otherwise it is not a match:

	if (pmd_trans_huge(*pvmw->pmd) || is_pmd_migration_entry(*pvmw->pmd)) {
		pvmw->ptl = pmd_lock(mm, pvmw->pmd);
		if (likely(pmd_trans_huge(*pvmw->pmd))) {
			...
		} else if (!pmd_present(*pvmw->pmd)) {
			if (thp_migration_supported()) {
				if (!(pvmw->flags & PVMW_MIGRATION))
					return not_found(pvmw);
				...
			} else
				WARN_ONCE(1, "Non present huge pmd without pmd migration enabled!");
			return not_found(pvmw);
		} else {
			...
		}
	}

Note that PMD-level swap entries for anonymous THPs were not supported
then, and still aren't supported today.

After those gates, the entry still had to be a migration entry for the
target THP. Functionally, that check goes back to 616b8371539a [2]:

	if (pmd_trans_huge(*pvmw->pmd) || is_pmd_migration_entry(*pvmw->pmd)) {
		pvmw->ptl = pmd_lock(mm, pvmw->pmd);
		if (likely(pmd_trans_huge(*pvmw->pmd))) {
			...
		} else if (!pmd_present(*pvmw->pmd)) {
			if (thp_migration_supported()) {
				if (!(pvmw->flags & PVMW_MIGRATION))
					return not_found(pvmw);
				if (is_migration_entry(pmd_to_swp_entry(*pvmw->pmd))) {
					swp_entry_t entry = pmd_to_swp_entry(*pvmw->pmd);

					if (migration_entry_to_page(entry) != page)
						return not_found(pvmw);
					return true;
				}
			} else
				WARN_ONCE(1, "Non present huge pmd without pmd migration enabled!");
			return not_found(pvmw);
		} else {
			...
		}
	}

The later commits mostly changed how the same rule is written.
e2e1d4076c77 rewrote it into the negative-check style; 2aff7a4755be
changed the page comparison to check_pmd() when pvmw moved to
pfn/nr_pages; 0d206b5d2e0d switched the PFN extraction to
swp_offset_pfn(); and 0ac881efe164 moved the PMD swap-entry helpers over
to softleaf helpers.

e2e1d4076c77: nested positive style -> negative-check style
2aff7a4755be: page comparison -> check_pmd(PFN range)
0d206b5d2e0d: swp_offset() -> swp_offset_pfn()
0ac881efe164: pmd_to_swp_entry/is_migration_entry -> softleaf helpers

For the PMD-mapped THP case, the positive decision was also made under
pmd_lock() from day one. In ace71a19cec5 [1], after taking pmd_lock(),
the PMD had to still be a THP PMD, the walk had to be a
non-PVMW_MIGRATION walk, and the PMD had to map the target THP:

	if (pmd_trans_huge(*pvmw->pmd)) {
		pvmw->ptl = pmd_lock(mm, pvmw->pmd);
		...
		if (likely(pmd_trans_huge(*pvmw->pmd))) {
			if (pvmw->flags & PVMW_MIGRATION)
				return not_found(pvmw);
			if (pmd_page(*pvmw->pmd) != page)
				return not_found(pvmw);
			return true;
		} else {
			...
		}
	} else {
		...
	}

2aff7a4755be later changed the target check from pmd_page(...) == page to
check_pmd(pmd_pfn(pmde), pvmw), when pvmw moved to pfn/nr_pages. Same
rule, but range-based now.

The split fallback was there from ace71a19cec5 [1] as well. After taking
pmd_lock(), if the locked PMD was no longer a THP PMD, the walker did not
make a PMD-level true/not_found decision. It dropped pmd_lock(), cleared
pvmw->ptl, and continued at PTE level:

	if (pmd_trans_huge(*pvmw->pmd)) {
		pvmw->ptl = pmd_lock(mm, pvmw->pmd);
		...
		if (likely(pmd_trans_huge(*pvmw->pmd))) {
			...
		} else {
			/* THP pmd was split under us: handle on pte level */
			spin_unlock(pvmw->ptl);
			pvmw->ptl = NULL;
		}
	} else {
		...
	}
	if (!map_pte(pvmw))
		goto next_pte;

616b8371539a [2] kept that fallback after adding PMD migration entries.
e2e1d4076c77 only rearranged the !pmd_present() block; the split fallback
still drops pmd_lock() and falls through to map_pte().

Now the outer non-present PMD case. In ace71a19cec5 [1], this was not an
explicit else-if branch yet. It was hidden in check_pmd():

static inline bool check_pmd(struct page_vma_mapped_walk *pvmw)
{
	pmd_t pmde;
	/*
	 * Make sure we don't re-load pmd between present and !trans_huge check.
	 * We need a consistent view.
	 */
	pmde = READ_ONCE(*pvmw->pmd);
	return pmd_present(pmde) && !pmd_trans_huge(pmde);
}

and the caller was:

	if (pmd_trans_huge(*pvmw->pmd)) {
		pvmw->ptl = pmd_lock(mm, pvmw->pmd);
		...
	} else {
		if (!check_pmd(pvmw))
			return false;
	}

So outside the THP PMD branch, a non-present PMD failed check_pmd() and
ended the walk.

a7b100953aa3 [4] ("mm: page_vma_mapped: ensure pmd is loaded with
READ_ONCE outside of lock") then made that lockless PMD value explicit in
page_vma_mapped_walk():

So this branch means: the lockless PMD read did not look like a THP PMD,
did not look like a PMD migration entry, and was non-present.

	pmde = READ_ONCE(*pvmw->pmd);
	if (pmd_trans_huge(pmde) || is_pmd_migration_entry(pmde)) {
		pvmw->ptl = pmd_lock(mm, pvmw->pmd);
		...
	} else if (!pmd_present(pmde)) {
		return false;
	}

The point of that commit was to use the same READ_ONCE() PMD snapshot for
the initial lockless checks, rather than letting the compiler reload or
reuse a stale PMD value around check_pmd().

732ed55823fc [5] ("mm/thp: try_to_unmap() use TTU_SYNC for safe
splitting") then added the PVMW_SYNC wait to this same outer non-present
PMD branch:

	pmde = READ_ONCE(*pvmw->pmd);
	if (pmd_trans_huge(pmde) || is_pmd_migration_entry(pmde)) {
		pvmw->ptl = pmd_lock(mm, pvmw->pmd);
		...
	} else if (!pmd_present(pmde)) {
		/*
		 * If PVMW_SYNC, take and drop THP pmd lock so that we
		 * cannot return prematurely, while zap_huge_pmd() has
		 * cleared *pmd but not decremented compound_mapcount().
		 */
		if ((pvmw->flags & PVMW_SYNC) &&
		    PageTransCompound(pvmw->page)) {
			spinlock_t *ptl = pmd_lock(mm, pvmw->pmd);

			spin_unlock(ptl);
		}
		return false;
	}

A lockless non-present PMD was still not a mapping. PVMW_SYNC only
changed whether the walker could return immediately: under PVMW_SYNC, it
had to take and drop pmd_lock() first, so it would not return while
zap_huge_pmd() had cleared *pmd but not yet decremented
compound_mapcount().

a9a7504d9bea [6] ("mm/thp: fix page_vma_mapped_walk() if THP mapped by
ptes") then changed the end of this branch from return false to
step_forward(PMD_SIZE) + continue:

		pmde = READ_ONCE(*pvmw->pmd);

		if (pmd_trans_huge(pmde) || is_pmd_migration_entry(pmde)) {
			pvmw->ptl = pmd_lock(mm, pvmw->pmd);
			...
		} else if (!pmd_present(pmde)) {
			/*
			 * If PVMW_SYNC, take and drop THP pmd lock so that we
			 * cannot return prematurely, while zap_huge_pmd() has
			 * cleared *pmd but not decremented compound_mapcount().
			 */
			if ((pvmw->flags & PVMW_SYNC) &&
			    PageTransCompound(page)) {
				spinlock_t *ptl = pmd_lock(mm, pvmw->pmd);

				spin_unlock(ptl);
			}
			step_forward(pvmw, PMD_SIZE);
			continue;
		}
		if (!map_pte(pvmw))
			goto next_pte;

That was about the walk range, not about making a non-present PMD a match.
step_forward(pvmw, PMD_SIZE) advances pvmw->address to the next PMD
boundary, and continue restarts the walk from there. So this branch only
rules out the current PMD-sized slot.

		pmde = pmdp_get_lockless(pvmw->pmd);

		if (pmd_trans_huge(pmde) || is_pmd_migration_entry(pmde) ||
		    (pmd_present(pmde) && pmd_devmap(pmde))) {
			pvmw->ptl = pmd_lock(mm, pvmw->pmd);
			...
		} else if (!pmd_present(pmde)) {
			/*
			 * If PVMW_SYNC, take and drop THP pmd lock so that we
			 * cannot return prematurely, while zap_huge_pmd() has
			 * cleared *pmd but not decremented compound_mapcount().
			 */
			if ((pvmw->flags & PVMW_SYNC) &&
			    thp_vma_suitable_order(vma, pvmw->address,
						   PMD_ORDER) &&
			    (pvmw->nr_pages >= HPAGE_PMD_NR)) {
				spinlock_t *ptl = pmd_lock(mm, pvmw->pmd);

				spin_unlock(ptl);
			}
			step_forward(pvmw, PMD_SIZE);
			continue;
		}

2aff7a4755be later converted page_vma_mapped_walk() to pfn/nr_pages, so
the PVMW_SYNC condition became VMA/range based.

c453d8c7d138 tightened the VMA side to transhuge_vma_suitable(vma,
pvmw->address), and 3485b88390b0 later made that helper order-aware,
giving the current thp_vma_suitable_order(vma, pvmw->address, PMD_ORDER)
spelling.

		if (pmd_trans_huge(pmde) || is_pmd_migration_entry(pmde) ||
		    (pmd_present(pmde) && pmd_devmap(pmde))) {

There was also a temporary devmap wrinkle. 6472f6d2f7d9 added
pmd_devmap() here because huge devmap PMDs were not covered by the old
pmd_trans_huge() test.

8a6a984c2e0e later removed the explicit pmd_devmap() checks because DAX
no longer created pmd_devmap entries, and pXd_trans_huge() covered those
mappings. This did not change the outer non-present PMD rule above.

65edfda6f3f2 [7] ("mm/rmap: extend rmap and migration support
device-private entries") later added the device-private PMD case into
this same outer non-present branch:

		pmde = pmdp_get_lockless(pvmw->pmd);

		if (pmd_trans_huge(pmde) || is_pmd_migration_entry(pmde)) {
			pvmw->ptl = pmd_lock(mm, pvmw->pmd);
			pmde = *pvmw->pmd;
			...
		} else if (!pmd_present(pmde)) {
			/*
			 * If PVMW_SYNC, take and drop THP pmd lock so that we
			 * cannot return prematurely, while zap_huge_pmd() has
			 * cleared *pmd but not decremented compound_mapcount().
			 */
			swp_entry_t entry = pmd_to_swp_entry(pmde);

			if (is_device_private_entry(entry)) {
				pvmw->ptl = pmd_lock(mm, pvmw->pmd);
				return true;
			}

			...
		}

That changed the old rule for this branch: a lockless non-present PMD was
no longer always skipped. If the lockless PMD decoded as device-private,
the walker took pmd_lock() and returned true.

0ac881efe164 later converted this code to softleaf helpers, with no
functional change intended. So the names changed, but the control flow
stayed the same:

		pmde = pmdp_get_lockless(pvmw->pmd);

		if (pmd_trans_huge(pmde) || pmd_is_migration_entry(pmde)) {
			pvmw->ptl = pmd_lock(mm, pvmw->pmd);
			...
		} else if (!pmd_present(pmde)) {
			const softleaf_t entry = softleaf_from_pmd(pmde);

			if (softleaf_is_device_private(entry)) {
				pvmw->ptl = pmd_lock(mm, pvmw->pmd);
				return true;
			}

			if ((pvmw->flags & PVMW_SYNC) &&
			    thp_vma_suitable_order(vma, pvmw->address,
						   PMD_ORDER) &&
			    (pvmw->nr_pages >= HPAGE_PMD_NR))
				sync_with_folio_pmd_zap(mm, pvmw->pmd);

			step_forward(pvmw, PMD_SIZE);
			continue;
		}

514c2fe9927e later moved the PVMW_SYNC take/drop pmd_lock() helper into
sync_with_folio_pmd_zap().

Note that PMD device-private handling still did not line up with the PTE
side, as I pointed out earlier[8].

[1] https://lore.kernel.org/all/20170129173858.45174-3-kirill.shutemov@linux.intel.com/T/#u
[2] https://lore.kernel.org/all/20170717193955.20207-6-zi.yan@sent.com/
[3] https://lore.kernel.org/all/53fbc9d-891e-46b2-cb4b-468c3b19238e@google.com/
[4] https://lore.kernel.org/all/1507222630-5839-1-git-send-email-will.deacon@arm.com/
[5] https://lore.kernel.org/linux-mm/20210616012353._aWHpXxeZ%25akpm@linux-foundation.org/
[6] https://lore.kernel.org/all/fedb8632-1798-de42-f39e-873551d5bc81@google.com/
[7] https://lore.kernel.org/all/20251001065707.920170-5-balbirs@nvidia.com/
[8] https://lore.kernel.org/all/20260619121909.90510-1-lance.yang@linux.dev/

[...]

Cheers, Lance
