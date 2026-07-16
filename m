Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FD719E7F7;
	Thu, 16 Jul 2026 10:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784196974; cv=none; b=Y83/rf0dss0BY30RWB35CceOexgQvsfSmjMfI/D/O+p3NmGkdJ7I/5+BsQfHv0BBQV4q2Y2vzFr1rG7O/0Oj5GwdBCv5mkrl3cd0J4zALhOgX6zOqkHSeAltp5js1zE8B1jlPmJWo7u7xoLKl3OasEGeh2KYPKW9m9WvyNzJ3F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784196974; c=relaxed/simple;
	bh=am88p2GxIiCDIJm6iOj35LZLeewTz66h2PYgN4q+T4w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RjN1l5ju0R5ZWnXmmWFxvWg2fuKQU5/hDc5b0wbGkeo7RTyvLl/C5bg8SNoq9tbjMlzvsvTseUJLgLBG+dnBfccmnO14aTa6heafj1ntdl+lwAG3pUKrK9em14OcJf73rs+CnNApwHHmF8ZYRJmS2NAyfu/75bYR0M43jZW1vdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=asDZQDqE; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="asDZQDqE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784196971; x=1815732971;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=am88p2GxIiCDIJm6iOj35LZLeewTz66h2PYgN4q+T4w=;
  b=asDZQDqEVgVOOu6Dsr7MRpDKvaIFHyY8St/Disvfv5KrqoUI6Bu7XFYc
   BSrbfnMHJaA0tMTYVXKYCccXbbvBkAI3QUkDB7yjcb8RpYORAZ7eux05o
   TNZi4Axbv975bwYR2w0fGXq21/G/zSQx1wfDrqoxECZ9Qpub249Fr9/74
   Tjwy5eT8pHXBB54VdUZAOz5uEfwoMCi9V58ZKy/CxVxU+LTz4XPD/gsHs
   1KTK9No9lrM6S2EJAcTrsVpW3GBW/+ApeMW29jVIw0/aWBfM0Ea9XxdzV
   2Ni76mLLzXmfktMBl2gBHlNvybC9kaBu9a/ucZse6aqhN04rG7QPq/i3M
   g==;
X-CSE-ConnectionGUID: qDkIQIsMR9K7Zc2lUSZZSw==
X-CSE-MsgGUID: JI0WmdXjSu+aGy+UQp+o+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="96366940"
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="96366940"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 03:16:10 -0700
X-CSE-ConnectionGUID: hrEJ2yL5SvSUgF3B9bLkUg==
X-CSE-MsgGUID: xP9P/anMSZ6LkMlkpqtkaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="252033158"
Received: from slindbla-desk.ger.corp.intel.com (HELO [10.245.245.44]) ([10.245.245.44])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 03:16:07 -0700
Message-ID: <5f39a0f4700788c93c788d7481f23e34be8ae3db.camel@linux.intel.com>
Subject: Re: [PATCH v7] drm/ttm/pool: back up at native page order
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Matthew Brost <matthew.brost@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,  Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann	 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter	 <simona@ffwll.ch>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Date: Thu, 16 Jul 2026 12:16:05 +0200
In-Reply-To: <alfWw2PJVFHSOGqy@gsse-cloud1.jf.intel.com>
References: <20260715080058.3794385-1-matthew.brost@intel.com>
	 <f58b1d99-6485-4ef7-8a5f-c63e6fad9ba8@linux.intel.com>
	 <alfWw2PJVFHSOGqy@gsse-cloud1.jf.intel.com>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-07-15 at 11:51 -0700, Matthew Brost wrote:
> On Wed, Jul 15, 2026 at 06:13:30PM +0200, Thomas Hellstr=C3=B6m wrote:
> >=20
> > On 7/15/26 10:00, Matthew Brost wrote:
> > > ttm_pool_split_for_swap() unconditionally splits high-order pool
> > > pages
> > > into order-0 pages before backup, so every compound the shrinker
> > > touches is shattered even when the rest of the system would
> > > prefer it
> > > stay intact. Under sustained kswapd pressure this fragments
> > > memory
> > > enough to drive other parts of MM into recovery loops.
> > >=20
> > > Back up each compound at its native order instead. In
> > > ttm_pool_backup(), hand the full compound to the new
> > > ttm_backup_backup_folio(), which backs up subpages to a
> > > contiguous
> > > range of shmem indices and returns the base handle plus the
> > > number of
> > > subpages actually backed up (@nr_backed). On full success, free
> > > the
> > > compound once at its native order -- no split_page(), no per-4K
> > > refcount juggling.
> > >=20
> > > A per-folio backup can't be made fully atomic under memory
> > > pressure:
> > > ttm_backup_backup_folio() must allocate shmem folios before
> > > source
> > > subpages can be released, so under true OOM any subpage may fail
> > > while the rest of the compound is still live. Two mechanisms
> > > handle
> > > this without regressing reclaim behaviour:
> > >=20
> > > =C2=A0=C2=A0 - alloc_gfp gets __GFP_NOMEMALLOC whenever order > 0 (cl=
eared
> > > again
> > > =C2=A0=C2=A0=C2=A0=C2=A0 for order-0), so a high-order backup fails f=
ast with -ENOMEM
> > > =C2=A0=C2=A0=C2=A0=C2=A0 instead of draining kernel reserves, leaving=
 them for other
> > > =C2=A0=C2=A0=C2=A0=C2=A0 allocations under the same pressure.
> > >=20
> > > =C2=A0=C2=A0 - If ttm_backup_backup_folio() still returns a short
> > > @nr_backed with
> > > =C2=A0=C2=A0=C2=A0=C2=A0 a valid handle for the successfully-backed p=
refix, split the
> > > =C2=A0=C2=A0=C2=A0=C2=A0 source compound with ttm_pool_split_for_swap=
(), free the
> > > prefix as
> > > =C2=A0=C2=A0=C2=A0=C2=A0 order-0 pages (already safely in shmem), and=
 retry the
> > > remaining
> > > =C2=A0=C2=A0=C2=A0=C2=A0 subpages at order 0, where __GFP_NOMEMALLOC =
is cleared and
> > > =C2=A0=C2=A0=C2=A0=C2=A0 reserves may be used as a last resort.
> > >=20
> > > This preserves the original split-on-OOM fallback while keeping
> > > the
> > > common case fragmentation-free, and preserves the "partial backup
> > > is
> > > allowed" contract (shrunken is incremented per subpage backed
> > > up).
> > >=20
> > > The restore-side leftover-page split in ttm_pool_restore_commit()
> > > is
> > > left as-is: it's unreachable in practice and not worth
> > > complicating
> > > the restore state machine to avoid.
> > >=20
> > > Testing: the existing backup_fault_inject point only truncated
> > > tt->num_pages, which never exercised the reactive split path
> > > above
> > > since it never left a compound partially backed up. Wire fault
> > > injection into ttm_backup_backup_folio() itself: past the first
> > > subpage of a compound, synthesize a -ENOMEM in place of
> > > shmem_read_folio_gfp() when should_fail() trips, producing the
> > > same
> > > short @nr_pages_backed a real failure would and forcing
> > > ttm_pool_backup() through the split-and-retry path. The
> > > fault_attr
> > > stays private to ttm_pool.c; ttm_backup.c reaches it through
> > > ttm_backup_fault_inject_folio(), declared in ttm_pool_internal.h.
> > >=20
> > > While converting the writeback branch to operate on the whole
> > > folio,
> > > the unlock condition after shmem_writeout() also changed from `if
> > > (ret)` to `if (ret =3D=3D AOP_WRITEPAGE_ACTIVATE)`, matching the
> > > actual
> > > contract: shmem_writeout()/swap_writeout() only leave the folio
> > > locked
> > > when returning AOP_WRITEPAGE_ACTIVATE; any other return
> > > (including a
> > > hard error from arch_prepare_to_swap()) means the folio was
> > > already
> > > unlocked internally. The old `if (ret)` check would have double-
> > > unlocked in that hard-error case.
> > >=20
> > > Cc: Christian Koenig <christian.koenig@amd.com>
> > > Cc: Huang Rui <ray.huang@amd.com>
> > > Cc: Matthew Auld <matthew.auld@intel.com>
> > > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > > Cc: Maxime Ripard <mripard@kernel.org>
> > > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > > Cc: David Airlie <airlied@gmail.com>
> > > Cc: Simona Vetter <simona@ffwll.ch>
> > > Cc: dri-devel@lists.freedesktop.org
> > > Cc: linux-kernel@vger.kernel.org
> > > Cc: stable@vger.kernel.org
> > > Fixes: b63d715b8090 ("drm/ttm/pool, drm/ttm/tt: Provide a helper
> > > to shrink pages")
> > > Suggested-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com=
>
> > > Assisted-by: Claude:claude-opus-4.6
> > > Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> > > ---
> > > =C2=A0 drivers/gpu/drm/ttm/ttm_backup.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 138 +++++++++++++++--
> > > -------
> > > =C2=A0 drivers/gpu/drm/ttm/ttm_pool.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 89 ++++++++++++---
> > > =C2=A0 drivers/gpu/drm/ttm/ttm_pool_internal.h |=C2=A0=C2=A0 8 ++
> > > =C2=A0 include/drm/ttm/ttm_backup.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 12 +--
> > > =C2=A0 4 files changed, 178 insertions(+), 69 deletions(-)
> > >=20
> > > diff --git a/drivers/gpu/drm/ttm/ttm_backup.c
> > > b/drivers/gpu/drm/ttm/ttm_backup.c
> > > index 81df4cb5606b..a8f0b12c86d2 100644
> > > --- a/drivers/gpu/drm/ttm/ttm_backup.c
> > > +++ b/drivers/gpu/drm/ttm/ttm_backup.c
> > > @@ -6,23 +6,25 @@
> > > =C2=A0 #include <drm/ttm/ttm_backup.h>
> > > =C2=A0 #include <linux/export.h>
> > > -#include <linux/page-flags.h>
> > > =C2=A0 #include <linux/swap.h>
> > > +#include "ttm_pool_internal.h"
> > > +
> > > =C2=A0 /*
> > > =C2=A0=C2=A0 * Need to map shmem indices to handle since a handle val=
ue
> > > =C2=A0=C2=A0 * of 0 means error, following the swp_entry_t convention=
.
> > > =C2=A0=C2=A0 */
> > > -static unsigned long ttm_backup_shmem_idx_to_handle(pgoff_t idx)
> > > -{
> > > -	return (unsigned long)idx + 1;
> > > -}
> > > =C2=A0 static pgoff_t ttm_backup_handle_to_shmem_idx(pgoff_t handle)
> > > =C2=A0 {
> > > =C2=A0=C2=A0	return handle - 1;
> > > =C2=A0 }
> > > +static unsigned long ttm_backup_shmem_idx_to_handle(pgoff_t idx)
> > > +{
> > > +	return (unsigned long)idx + 1;
> > > +}
> > > +
> >=20
> > This seems like an unrelated change?
> >=20
>=20
> Yes, let me drop this.
>=20
> >=20
> > > =C2=A0 /**
> > > =C2=A0=C2=A0 * ttm_backup_drop() - release memory associated with a h=
andle
> > > =C2=A0=C2=A0 * @backup: The struct backup pointer used to obtain the =
handle
> > > @@ -68,17 +70,23 @@ int ttm_backup_copy_page(struct file *backup,
> > > struct page *dst,
> > > =C2=A0 }
> > > =C2=A0 /**
> > > - * ttm_backup_backup_page() - Backup a page
> > > + * ttm_backup_backup_folio() - Backup a folio
> > > =C2=A0=C2=A0 * @backup: The struct backup pointer to use.
> > > - * @page: The page to back up.
> > > - * @writeback: Whether to perform immediate writeback of the
> > > page.
> > > + * @folio: The folio to back up.
> > > + * @order: The allocation order of @folio.=C2=A0 Since TTM allocates
> > > higher-order
> > > + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pages without __G=
FP_COMP, folio_nr_pages(@folio)
> > > would always
> > > + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 1; the cal=
ler must pass the true order
> > > explicitly.
> > > + * @writeback: Whether to perform immediate writeback of the
> > > folio's pages.
> > > =C2=A0=C2=A0 * This may have performance implications.
> > > - * @idx: A unique integer for each page and each struct backup.
> > > + * @idx: A unique integer for the first page of the folio and
> > > each struct backup.
> > > =C2=A0=C2=A0 * This allows the backup implementation to avoid managin=
g
> > > =C2=A0=C2=A0 * its address space separately.
> > > - * @page_gfp: The gfp value used when the page was allocated.
> > > - * This is used for accounting purposes.
> > > + * @folio_gfp: The gfp value used when the folio was allocated.
> > > + * Currently unused.
> > > =C2=A0=C2=A0 * @alloc_gfp: The gfp to be used when allocating memory.
> > > + * @nr_pages_backed: Output. On a successful return, set to the
> > > number of
> > > + * pages actually backed up, which may be less than (1 <<
> > > @order)
> > > + * if an -ENOMEM was encountered mid-folio.
> > > =C2=A0=C2=A0 *
> > > =C2=A0=C2=A0 * Context: If called from reclaim context, the caller ne=
eds to
> > > =C2=A0=C2=A0 * assert that the shrinker gfp has __GFP_FS set, to avoi=
d
> > > @@ -87,53 +95,87 @@ int ttm_backup_copy_page(struct file *backup,
> > > struct page *dst,
> > > =C2=A0=C2=A0 * that the shrinker gfp has __GFP_IO set, since without =
it,
> > > =C2=A0=C2=A0 * we're not allowed to start backup IO.
> > > =C2=A0=C2=A0 *
> > > - * Return: A handle on success. Negative error code on failure.
> > > - *
> > > - * Note: This function could be extended to back up a folio and
> > > - * implementations would then split the folio internally if
> > > needed.
> > > - * Drawback is that the caller would then have to keep track of
> > > - * the folio size- and usage.
> > > + * Return: A handle for the first backed-up page on success
> > > (handles for
> > > + * subsequent pages follow sequentially). -ENOMEM if no pages
> > > could be backed
> > > + * up. Any other negative error code if a non-ENOMEM failure
> > > occurred; in that
> > > + * case any pages backed up so far are truncated before
> > > returning.
> > > =C2=A0=C2=A0 */
> > > =C2=A0 s64
> > > -ttm_backup_backup_page(struct file *backup, struct page *page,
> > > -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool writeback, pgoff_t idx, =
gfp_t
> > > page_gfp,
> > > -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gfp_t alloc_gfp)
> > > +ttm_backup_backup_folio(struct file *backup, struct folio
> > > *folio,
> > > +			unsigned int order, bool writeback,
> > > pgoff_t idx,
> > > +			gfp_t folio_gfp, gfp_t alloc_gfp,
> > > +			pgoff_t *nr_pages_backed)
> > > =C2=A0 {
> > > =C2=A0=C2=A0	struct address_space *mapping =3D backup->f_mapping;
> > > -	unsigned long handle =3D 0;
> > > +	int nr_pages =3D 1 << order;
> > > =C2=A0=C2=A0	struct folio *to_folio;
> > > -	int ret;
> > > -
> > > -	to_folio =3D shmem_read_folio_gfp(mapping, idx,
> > > alloc_gfp);
> > > -	if (IS_ERR(to_folio))
> > > -		return PTR_ERR(to_folio);
> > > -
> > > -	folio_mark_accessed(to_folio);
> > > -	folio_lock(to_folio);
> > > -	folio_mark_dirty(to_folio);
> > > -	copy_highpage(folio_file_page(to_folio, idx), page);
> > > -	handle =3D ttm_backup_shmem_idx_to_handle(idx);
> > > -
> > > -	if (writeback && !folio_mapped(to_folio) &&
> > > -	=C2=A0=C2=A0=C2=A0 folio_clear_dirty_for_io(to_folio)) {
> > > -		folio_set_reclaim(to_folio);
> > > -		ret =3D shmem_writeout(to_folio, NULL, NULL);
> > > -		if (!folio_test_writeback(to_folio))
> > > -			folio_clear_reclaim(to_folio);
> > > +	int ret, i;
> > > +
> > > +	*nr_pages_backed =3D 0;
> > > +
> > > +	for (i =3D 0; i < nr_pages; ) {
> > > +		int to_nr, j;
> > > +
> > > =C2=A0=C2=A0		/*
> > > -		 * If writeout succeeds, it unlocks the
> > > folio.	errors
> > > -		 * are otherwise dropped, since writeout is only
> > > best
> > > -		 * effort here.
> > > +		 * Only inject past the first subpage so
> > > *nr_pages_backed is
> > > +		 * always > 0 here, matching a genuine mid-
> > > compound -ENOMEM
> > > +		 * and driving the caller's reactive split
> > > fallback instead
> > > +		 * of an early, no-progress failure.
> > > =C2=A0=C2=A0		 */
> > > -		if (ret)
> > > +		if (IS_ENABLED(CONFIG_FAULT_INJECTION) && i &&
> > > +		=C2=A0=C2=A0=C2=A0 ttm_backup_fault_inject_folio())
> > > +			to_folio =3D ERR_PTR(-ENOMEM);
> > > +		else
> > > +			to_folio =3D shmem_read_folio_gfp(mapping,
> > > idx + i, alloc_gfp);
> > > +		if (IS_ERR(to_folio)) {
> > > +			int err =3D PTR_ERR(to_folio);
> > > +
> > > +			if (err =3D=3D -ENOMEM && *nr_pages_backed)
> > > +				return
> > > ttm_backup_shmem_idx_to_handle(idx);
> > > +
> > > +			if (*nr_pages_backed) {
> > > +				shmem_truncate_range(file_inode(
> > > backup),
> > > +						=C2=A0=C2=A0=C2=A0=C2=A0 (loff_t)idx
> > > << PAGE_SHIFT,
> > > +						=C2=A0=C2=A0=C2=A0=C2=A0
> > > ((loff_t)(idx + i) << PAGE_SHIFT) - 1);
> > > +				/*
> > > +				 * The pages just truncated are
> > > no longer
> > > +				 * backed up; don't let the
> > > caller mistake
> > > +				 * them for valid handles.
> > > +				 */
> > > +				*nr_pages_backed =3D 0;
> > > +			}
> > > +			return err;
> > > +		}
> > > +
> > > +		to_nr =3D min_t(int, nr_pages - i,
> > > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 folio_next_index(to_folio) - (idx
> > > + i));
> > > +
> > > +		folio_mark_accessed(to_folio);
> > > +		folio_lock(to_folio);
> > > +		folio_mark_dirty(to_folio);
> > > +
> > > +		for (j =3D 0; j < to_nr; j++)
> > > +			copy_highpage(folio_file_page(to_folio,
> > > idx + i + j),
> > > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 folio_page(folio, i + j));
> > > +
> > > +		if (writeback && !folio_mapped(to_folio) &&
> > > +		=C2=A0=C2=A0=C2=A0 folio_clear_dirty_for_io(to_folio)) {
> > > +			folio_set_reclaim(to_folio);
> > > +			ret =3D shmem_writeout(to_folio, NULL,
> > > NULL);
> > > +			if (!folio_test_writeback(to_folio))
> > > +				folio_clear_reclaim(to_folio);
> > > +			if (ret =3D=3D AOP_WRITEPAGE_ACTIVATE)
> > > +				folio_unlock(to_folio);
> > Actually, it may be that the whole above block (setting reclaim
> > etc) is
>=20
> The check for AOP_WRITEPAGE_ACTIVATE was also missing from the old
> code.
> This was flagged by a separate core MM patch that performed some
> tree-wide cleanup around shmem_writeout(). Reading through the
> shmem_writeout() implementation, the need for this check appears
> fairly
> obvious.
>=20
> > duplicating what shmem_writeout already does and that got missed in
> > the
> > conversion to shmem_writeout. In any case, that might belong in a
> > separate
>=20
> It is less obvious whether folio_set_reclaim() is called somewhere
> along the shmem_writeout() path, and it is possible that we have this
> part wrong. I think I agree that we should follow up on this and post
> a
> separate patch if needed.
>=20
> > patch. Note also that if shmem happened to allocate a 2M page, and
> > we call
> > shmem_writeout on it, it might be split on further copies to it,
> > like if
> > we're trying to back up a 4K-populated bo to a 2M shmem page. Also
> > pre-existing.
> >=20
>=20
> I don't think we pass in the original folio which what we trying to
> avoid splitting in this patch, but I do see code around 'to_folio'
> being
> split, so we may need a follow up here too?

The split actually happens in the shmem code, so what's problematic in
our code is if we repeatedly call shmem_writeout() with dirtied folio
content on 4K granularity.=20

Now typically shmem doesn't allocate 2M pages (depending on default
distro configuration), so no reason for immediate action.

So with the unrelated reordering at the top of the patch fixed,

Reviewed-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>




>=20
> Matt
>=20
> >=20
> > > +		} else {
> > > =C2=A0=C2=A0			folio_unlock(to_folio);
> > > -	} else {
> > > -		folio_unlock(to_folio);
> > > -	}
> > > +		}
> > > -	folio_put(to_folio);
> > > +		folio_put(to_folio);
> > > +		i +=3D to_nr;
> > > +		*nr_pages_backed =3D i;
> > > +	}
> > > -	return handle;
> > > +	return ttm_backup_shmem_idx_to_handle(idx);
> > > =C2=A0 }
> > > =C2=A0 /**
> > > diff --git a/drivers/gpu/drm/ttm/ttm_pool.c
> > > b/drivers/gpu/drm/ttm/ttm_pool.c
> > > index 80d0ad41456a..1bf37023fed6 100644
> > > --- a/drivers/gpu/drm/ttm/ttm_pool.c
> > > +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> > > @@ -53,8 +53,23 @@
> > > =C2=A0 #ifdef CONFIG_FAULT_INJECTION
> > > =C2=A0 #include <linux/fault-inject.h>
> > > =C2=A0 static DECLARE_FAULT_ATTR(backup_fault_inject);
> > > +
> > > +/*
> > > + * Exposed to ttm_backup.c so a mid-compound subpage can be made
> > > to fail
> > > + * with -ENOMEM, exercising the reactive split-and-retry
> > > fallback in
> > > + * ttm_pool_backup() for high-order backups.
> > > + */
> > > +bool ttm_backup_fault_inject_folio(void)
> > > +{
> > > +	return should_fail(&backup_fault_inject, 1);
> > > +}
> > > =C2=A0 #else
> > > =C2=A0 #define should_fail(...) false
> > > +
> > > +bool ttm_backup_fault_inject_folio(void)
> > > +{
> > > +	return false;
> > > +}
> > > =C2=A0 #endif
> > > =C2=A0 /**
> > > @@ -492,7 +507,7 @@ static void ttm_pool_split_for_swap(struct
> > > ttm_pool *pool, struct page *p)
> > > =C2=A0 /**
> > > =C2=A0=C2=A0 * DOC: Partial backup and restoration of a struct ttm_tt=
.
> > > =C2=A0=C2=A0 *
> > > - * Swapout using ttm_backup_backup_page() and swapin using
> > > + * Swapout using ttm_backup_backup_folio() and swapin using
> > > =C2=A0=C2=A0 * ttm_backup_copy_page() may fail.
> > > =C2=A0=C2=A0 * The former most likely due to lack of swap-space or me=
mory,
> > > the latter due
> > > =C2=A0=C2=A0 * to lack of memory or because of signal interruption du=
ring
> > > waits.
> > > @@ -1050,12 +1065,12 @@ long ttm_pool_backup(struct ttm_pool
> > > *pool, struct ttm_tt *tt,
> > > =C2=A0 {
> > > =C2=A0=C2=A0	struct file *backup =3D tt->backup;
> > > =C2=A0=C2=A0	struct page *page;
> > > -	unsigned long handle;
> > > =C2=A0=C2=A0	gfp_t alloc_gfp;
> > > =C2=A0=C2=A0	gfp_t gfp;
> > > =C2=A0=C2=A0	int ret =3D 0;
> > > =C2=A0=C2=A0	pgoff_t shrunken =3D 0;
> > > -	pgoff_t i, num_pages;
> > > +	pgoff_t i, j, num_pages, npages;
> > > +	pgoff_t nr_backed;
> > > =C2=A0=C2=A0	if (WARN_ON(ttm_tt_is_backed_up(tt)))
> > > =C2=A0=C2=A0		return -EINVAL;
> > > @@ -1133,9 +1148,11 @@ long ttm_pool_backup(struct ttm_pool
> > > *pool, struct ttm_tt *tt,
> > > =C2=A0=C2=A0	if (IS_ENABLED(CONFIG_FAULT_INJECTION) &&
> > > should_fail(&backup_fault_inject, 1))
> > > =C2=A0=C2=A0		num_pages =3D DIV_ROUND_UP(num_pages, 2);
> > > -	for (i =3D 0; i < num_pages; ++i) {
> > > -		s64 shandle;
> > > +	for (i =3D 0; i < num_pages; i +=3D npages) {
> > > +		unsigned int order;
> > > +		s64 handle;
> > > +		npages =3D 1;
> > > =C2=A0=C2=A0		page =3D tt->pages[i];
> > > =C2=A0=C2=A0		if (unlikely(!page))
> > > =C2=A0=C2=A0			continue;
> > > @@ -1144,19 +1161,61 @@ long ttm_pool_backup(struct ttm_pool
> > > *pool, struct ttm_tt *tt,
> > > =C2=A0=C2=A0		if
> > > (unlikely(ttm_backup_page_ptr_is_handle(page)))
> > > =C2=A0=C2=A0			continue;
> > > -		ttm_pool_split_for_swap(pool, page);
> > > +		order =3D ttm_pool_page_order(pool, page);
> > > +		npages =3D 1UL << order;
> > > +
> > > +		/*
> > > +		 * We don't allow dipping kernel reserves for
> > > high order backup
> > > +		 */
> > > +		if (order)
> > > +			alloc_gfp |=3D __GFP_NOMEMALLOC;
> > > +		else
> > > +			alloc_gfp &=3D ~__GFP_NOMEMALLOC;
> > > +
> > > +		/*
> > > +		 * Back up the compound atomically at its native
> > > order. If
> > > +		 * fault injection truncated num_pages mid-
> > > compound, skip
> > > +		 * the partial tail rather than splitting.
> > > +		 */
> > > +		if (unlikely(i + npages > num_pages))
> > > +			break;
> > > -		shandle =3D ttm_backup_backup_page(backup, page,
> > > flags->writeback, i,
> > > -						 gfp,
> > > alloc_gfp);
> > > -		if (shandle < 0) {
> > > -			/* We allow partially shrunken tts */
> > > -			ret =3D shandle;
> > > +		handle =3D ttm_backup_backup_folio(backup,
> > > page_folio(page),
> > > +						 order, flags-
> > > >writeback, i,
> > > +						 gfp, alloc_gfp,
> > > +						 &nr_backed);
> > > +		/*
> > > +		 * Zero progress on this compound (whether order
> > > 0 or a
> > > +		 * high-order compound that failed before
> > > backing up even
> > > +		 * its first subpage) is unrecoverable: bail out
> > > rather than
> > > +		 * looping forever with npages =3D=3D nr_backed =3D=3D 0
> > > below.
> > > +		 */
> > > +		if (unlikely(handle < 0 && !nr_backed)) {
> > > +			ret =3D handle;
> > > =C2=A0=C2=A0			break;
> > > =C2=A0=C2=A0		}
> > > -		handle =3D shandle;
> > > -		tt->pages[i] =3D
> > > ttm_backup_handle_to_page_ptr(handle);
> > > -		__free_pages_gpu_account(page, 0, false);
> > > -		shrunken++;
> > > +
> > > +		for (j =3D 0; j < nr_backed; j++)
> > > +			tt->pages[i + j] =3D
> > > ttm_backup_handle_to_page_ptr(handle + j);
> > > +
> > > +		shrunken +=3D nr_backed;
> > > +
> > > +		if (unlikely(nr_backed < npages)) {
> > > +			/*
> > > +			 * Partial OOM backup: split the
> > > compound and free the
> > > +			 * subpages whose content is now in
> > > shmem. Continue the
> > > +			 * loop from the first un-backed order-0
> > > page.
> > > +			 */
> > > +			ttm_pool_split_for_swap(pool, page);
> > > +			for (j =3D 0; j < nr_backed; j++)
> > > +				__free_pages_gpu_account(page +
> > > j, 0, false);
> > > +			npages =3D nr_backed;
> > > +			continue;
> > > +		}
> > > +
> > > +		/* Fully backed up: free at native order. */
> > > +		page->private =3D 0;
> > > +		__free_pages_gpu_account(page, order, false);
> > > =C2=A0=C2=A0	}
> > > =C2=A0=C2=A0	return shrunken ? shrunken : ret;
> > > diff --git a/drivers/gpu/drm/ttm/ttm_pool_internal.h
> > > b/drivers/gpu/drm/ttm/ttm_pool_internal.h
> > > index 24c179fd69d1..cbb17a2129fe 100644
> > > --- a/drivers/gpu/drm/ttm/ttm_pool_internal.h
> > > +++ b/drivers/gpu/drm/ttm/ttm_pool_internal.h
> > > @@ -22,4 +22,12 @@ static inline unsigned int
> > > ttm_pool_beneficial_order(struct ttm_pool *pool)
> > > =C2=A0=C2=A0	return pool->alloc_flags & 0xff;
> > > =C2=A0 }
> > > +/*
> > > + * Implemented in ttm_pool.c, used by ttm_backup.c. Returns true
> > > if a fault
> > > + * should be injected mid-compound to test the reactive split-
> > > and-retry
> > > + * fallback in ttm_pool_backup(). Always returns false when
> > > + * CONFIG_FAULT_INJECTION is disabled.
> > > + */
> > > +bool ttm_backup_fault_inject_folio(void);
> > > +
> > > =C2=A0 #endif
> > > diff --git a/include/drm/ttm/ttm_backup.h
> > > b/include/drm/ttm/ttm_backup.h
> > > index 29b9c855af77..49efa713e87c 100644
> > > --- a/include/drm/ttm/ttm_backup.h
> > > +++ b/include/drm/ttm/ttm_backup.h
> > > @@ -13,9 +13,8 @@
> > > =C2=A0=C2=A0 * ttm_backup_handle_to_page_ptr() - Convert handle to st=
ruct
> > > page pointer
> > > =C2=A0=C2=A0 * @handle: The handle to convert.
> > > =C2=A0=C2=A0 *
> > > - * Converts an opaque handle received from the
> > > - * ttm_backup_backup_page() function to an (invalid)
> > > - * struct page pointer suitable for a struct page array.
> > > + * Converts an opaque handle received from a
> > > ttm_backup_backup_*()
> > > + * function to an (invalid) struct page pointer suitable for a
> > > struct page array.
> > > =C2=A0=C2=A0 *
> > > =C2=A0=C2=A0 * Return: An (invalid) struct page pointer.
> > > =C2=A0=C2=A0 */
> > > @@ -59,9 +58,10 @@ int ttm_backup_copy_page(struct file *backup,
> > > struct page *dst,
> > > =C2=A0=C2=A0			 pgoff_t handle, bool intr, gfp_t
> > > additional_gfp);
> > > =C2=A0 s64
> > > -ttm_backup_backup_page(struct file *backup, struct page *page,
> > > -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool writeback, pgoff_t idx, =
gfp_t
> > > page_gfp,
> > > -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gfp_t alloc_gfp);
> > > +ttm_backup_backup_folio(struct file *backup, struct folio
> > > *folio,
> > > +			unsigned int order, bool writeback,
> > > pgoff_t idx,
> > > +			gfp_t folio_gfp, gfp_t alloc_gfp,
> > > +			pgoff_t *nr_pages_backed);
> > > =C2=A0 void ttm_backup_fini(struct file *backup);
> > Otherwise LGTM.
> >=20
> > /Thomas
> >=20
> >=20
