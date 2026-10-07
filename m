Received: from mta0.migadu.com (out-163.mta0.migadu.com [91.218.175.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2AE3DB300
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 13:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791381042; cv=none; b=bSIvH1Xw560rhODe1RBlLXZZ/MRd6/F59tJql2LjK30FpkCYiLGu3c3VXhMxEh4qo3yEVy5h2lI5ClJT6tuqA/PRvf6R3bPTl2d4i2LCElL5a0XnNqdablEbBslED0Eu28qYodREy+vnEuzBVj5C7ysJM6oCDU28IOBRyvfqOcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791381042; c=relaxed/simple;
	bh=9uh3YtH2vzcWNChlP5JxXc/8qcNZiQgtmlGLwUVnUpM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=t9LlqLsUoe0usyvsdLm+7JnBPSi8O7EJcdqssFJsW+fwx7M9UArpPIKLdI1VWf5A3nAojOwLz/EfNzL8IAnbXnYcEgf+3rugyG1/FKophqByIcql+0ZRDevBHz1YrRWSZriipPi58vibgqM3TVgdcXdyNzyvVmZlVcQzzr6iKQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GpdLbIts; arc=none smtp.client-ip=91.218.175.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GpdLbIts"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=9uh3YtH2vzcWNChlP5JxXc/8qcNZiQgtmlGLwUVnUpM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791381029; v=1; x=1791985829;
 b=GpdLbItsKLa8HQwn4difBoTylqS8JCO0f/07aFwUILXRuv4xiCBVjQ/7etqJoGKodfbhcdQm
 tMTNrao/ojP0F3i3fyB2bY1WvK8A7zq5mC0enSEm2NxIe7/gaPc1KQGjCPEjYjWwDOVvncUGK1e
 I5DLlPZlZ/fdKwHDx7b9hVf0=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 2f3032bb5f9bba28;
	Wed, 07 Oct 2026 13:50:27 +0000
X-Mizu-Trace-ID: 2f3032bb5f9bba28
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.12\))
Subject: Re: [PATCH v3] mm/hugetlb: fix max-only subpool accounting on
 alloc_hugetlb_folio failure
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20260428113037.88766-2-enderaoelyther@gmail.com>
Date: Wed, 7 Oct 2026 15:50:12 +0200
Cc: Andrew Morton <akpm@linux-foundation.org>,
 mawupeng1@huawei.com,
 Oscar Salvador <osalvador@suse.de>,
 David Hildenbrand <david@kernel.org>,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <B83FA5F4-740F-4CEF-B9C2-6ED51C893A92@linux.dev>
References: <20260427145247.84157-2-enderaoelyther@gmail.com>
 <20260428030712.66256-2-enderaoelyther@gmail.com>
 <20260428113037.88766-2-enderaoelyther@gmail.com>
To: Zhao Li <enderaoelyther@gmail.com>
X-Mailer: Apple Mail (2.3901.100.1.1.12)



> On Apr 28, 2026, at 13:30, Zhao Li <enderaoelyther@gmail.com> wrote:
>=20
> alloc_hugetlb_folio() calls hugepage_subpool_get_pages() when map_chg
> is set.  For a subpool with max_hpages !=3D -1, that bumps used_hpages
> regardless of whether it returns gbl_chg =3D 0 (rsv slot consumed) or
> gbl_chg > 0 (used_hpages slot only).  If the allocation later fails
> before a folio is returned, the unwind must undo the used_hpages
> bump.  The old cleanup only ran for !gbl_chg, leaking used_hpages on
> the gbl_chg > 0 path.
>=20
> For gbl_chg > 0 on max-only subpools (max_hpages !=3D -1, min_hpages
> =3D=3D -1), hugepage_subpool_get_pages() took only a speculative
> used_hpages slot.  Drop that slot directly under spool->lock.  In
> that configuration hugepage_subpool_put_pages() cannot restore
> rsv_hpages, so the direct decrement is the exact inverse and is
> race-free against concurrent puts.  This matches the used_hpages-only
> part of hugetlb_reserve_pages()'s out_put_pages cleanup, but
> restricts it to the max-only case where no rsv_hpages restoration is
> possible.
>=20
> Mounts with min_hpages !=3D -1 are left unchanged for now.  v2's
> approach (hugepage_subpool_put_pages() + h->resv_huge_pages++ to
> back a restored rsv_hpages slot) double-counts global backing under
> concurrent free_huge_folio() and creates phantom reservations under
> concurrent hugetlb_unreserve_pages().  Safe cleanup of that quadrant
> needs a coordinated fix across multiple call sites.
>=20
> Reproduced on size=3D20M hugetlbfs with the faulting task in a hugetlb
> cgroup whose limit is exceeded.  Vanilla leaks 6/8 hugepages of
> subpool quota; this patch leaks 0/8.  Verified under QEMU.
>=20
> Fixes: a833a693a490 ("mm: hugetlb: fix incorrect fallback for =
subpool")
> Cc: stable@vger.kernel.org # v6.15+
> Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
> ---
> Changes in v3:
> - Replace v2's hugepage_subpool_put_pages() + h->resv_huge_pages++ on
>  the gbl_chg > 0 branch with a direct used_hpages-- under spool->lock.
> - Restrict the cleanup to (max_hpages !=3D -1, min_hpages =3D=3D -1) =
where
>  the direct decrement is the exact inverse of the speculative bump.
>=20
> Changes in v2:
> - Skip the gbl_chg > 0 cleanup when max_hpages is unset.
> - Add hugepage_subpool_put_pages() + h->resv_huge_pages++ on the
>  gbl_chg > 0 branch.
>=20
> mm/hugetlb.c | 25 ++++++++++++++++++-------
> 1 file changed, 18 insertions(+), 7 deletions(-)
>=20
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index f24bf49be047e..cfdeaf6394c5b 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -3025,13 +3025,24 @@ struct folio *alloc_hugetlb_folio(struct =
vm_area_struct *vma,
> hugetlb_cgroup_uncharge_cgroup_rsvd(idx, pages_per_huge_page(h),
>    h_cg);
> out_subpool_put:
> - 	/*
> -	 * put page to subpool iff the quota of subpool's rsv_hpages is =
used
> -	 * during hugepage_subpool_get_pages.
> -	 */
> - 	if (map_chg && !gbl_chg) {
> - 		gbl_reserve =3D hugepage_subpool_put_pages(spool, 1);
> - 		hugetlb_acct_memory(h, -gbl_reserve);
> + 	if (map_chg) {
> + 		if (!gbl_chg) {
> + 			/* Full inverse when subpool_get_pages() =
consumed rsv_hpages. */
> + 			gbl_reserve =3D =
hugepage_subpool_put_pages(spool, 1);
> +			hugetlb_acct_memory(h, -gbl_reserve);
> + 		} else if (gbl_chg > 0 && spool && spool->min_hpages =3D=3D=
 -1 &&

The gbl_chg > 0 check can be dropped: negative values jump directly to
out_end_reservation, while zero is handled by the preceding if =
(!gbl_chg).

> +   			spool->max_hpages !=3D -1) {
> + 			unsigned long flags;
> +
> + 			/*
> +			 * For max-only subpools, subpool_get_pages() =
took only a
> +			 * speculative used_hpages slot. Drop that slot =
directly.
> +			 */
> + 			spin_lock_irqsave(&spool->lock, flags);
> + 			if (spool->used_hpages > 0)
> + 				spool->used_hpages--;
> + 			unlock_or_release_subpool(spool, flags);

Could we use hugepage_subpool_put_pages(spool, 1) here?

With the max-only check in place, the helper cannot restore rsv_hpages, =
so it already
performs the required used_hpages decrement and subpool lifetime =
handling under the
appropriate lock.

Thanks,
Muchun

> + 		}
> }
>=20
>=20
> --
> 2.50.1 (Apple Git-155)

