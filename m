Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37A3331A53
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 09:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790934771; cv=none; b=WWUMPsGKpJnzofURJ8UZ/M7FDekjRNbNtqjJFn1NC0YsG6PvCMIKvXk1Jh94sGz/62J0+kXaGlx9BzIRa+1u9m88H8BkzT/yJKjKs5+2vgpfcD9iCKaDXHKOoWggO6OCa66gq5Z5nl8OYxpwOTr+he7xEdQGVVz6mjp4m3Vo1Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790934771; c=relaxed/simple;
	bh=dOxcqAV/3m9cJNuO0lc8CSNyqj0luR/M0WHV8fHhgpc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cdqaAPime9JEzx2ZA7IxOONZuzThrzCVKktVg34vwe24dBHfRKT7WqrLMWtpDuIoWBW93bZzan6dL7C8yvxAGLK6ZjONXCp7CLFRthSAMh342d+MO76bWc9WaaU0/seo7sxhPgxYsagpJxs5jwnvmqZhyYpstPnKecr4It+SQ1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Exwkb1Bo; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Exwkb1Bo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790934769; x=1822470769;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=dOxcqAV/3m9cJNuO0lc8CSNyqj0luR/M0WHV8fHhgpc=;
  b=Exwkb1BoGx/lZc1SmFqW4MNoCL6+iwbzCELXdbvyo7BgQ8uWG/ew/72+
   /yJH+2IOBR/HKXIQtzKMU8H2OnQwG0OPDLIbRiDnqGYRr6Ea88YZwP423
   lqnW1BwRNJY8o3j+lbfE4JtZDBDnbQUC6gpXQ82hy74q09sbTxC5+98Eg
   qUxlpqBSq0HCOKYxsQ+mTzUfqaiUuDi9rKT911Yje4OxxycvwEIEUFiz1
   ac/6M+zRyMGMF7vtpwsPktFEEnPMMNQeIRxmLw5HMRzMtCrmG/MbvUb3M
   wPQHWaYHtxVyTflkUVGK1pT88P5DEGFV0qKi/LgTWfA3OKw5bDWaZAa/y
   Q==;
X-CSE-ConnectionGUID: rB1AwSsXRqaXfKgbBCatCA==
X-CSE-MsgGUID: LPaUQKLsS8Soem1sl05OFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="102275170"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="102275170"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 02:52:48 -0700
X-CSE-ConnectionGUID: x+ACUD/RRYGL4vYFfDbvMQ==
X-CSE-MsgGUID: 5r1r34UxSbe3xUPFQ67+KQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="304181080"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO [10.245.244.200]) ([10.245.244.200])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 02:52:46 -0700
Message-ID: <b9553a5e4e6f3a5f836e3b61c22f1cbc59da3ad6.camel@linux.intel.com>
Subject: Re: [PATCH v2 2/2] drm/xe: Fix stale pinned_link entry when fb-pin
 performs the final unpin
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Matthew Auld <matthew.auld@intel.com>, intel-xe@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Rodrigo Vivi
	 <rodrigo.vivi@intel.com>, stable@vger.kernel.org, Matthew Brost
	 <matthew.brost@intel.com>
Date: Fri, 02 Oct 2026 11:52:44 +0200
In-Reply-To: <a0ded4eb-98e3-4142-b2c5-3dc55d9687d1@intel.com>
References: <20261001134018.111553-1-thomas.hellstrom@linux.intel.com>
	 <20261001134018.111553-3-thomas.hellstrom@linux.intel.com>
	 <a0ded4eb-98e3-4142-b2c5-3dc55d9687d1@intel.com>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-2.fc43) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-10-01 at 18:26 +0100, Matthew Auld wrote:
> On 01/10/2026 14:40, Thomas Hellstr=C3=B6m wrote:
> > xe_bo_pin_external() and xe_bo_unpin_external() maintain the bo's
> > pinned_link list membership in xe->pinned.late.external, based on
> > whether the current call is the outermost pin or the final unpin.
> > However, the same external bo's pin_count can also be raised and
> > lowered directly by __xe_pin_fb_vma()/__xe_unpin_fb_vma(), which
> > pin
> > the bo as a display scanout buffer without going through
> > xe_bo_pin_external()/xe_bo_unpin_external() at all, and have no
> > notion of, or ownership over, pinned_link.
> >=20
> > If a bo is pinned both externally (e.g. dma-buf export) and as an
> > fb,
> > and the external unpin happens first, xe_bo_unpin_external()
> > correctly
> > observes pin_count > 1 and leaves the bo on pinned_link. When the
> > fb
> > unpin later performs the true last unpin (pin_count 1 -> 0), it
> > never
> > touches pinned_link, leaving the bo linked on xe-
> > >pinned.late.external
> > indefinitely. Once the bo is subsequently freed, this stale list
> > entry
> > points into freed memory, corrupting the list and risking a
> > use-after-free the next time the list is walked or spliced.
> >=20
> > The backup object pin/unpin sites in
> > xe_bo_notifier_prepare_pinned()/
> > xe_bo_notifier_unprepare_pinned() have the same bypass
> > characteristic,
> > though they never add their bo to a pinned list, so are not
> > affected
> > by this particular list-corruption issue.
> >=20
> > Move the pinned_link removal into xe_bo_account_unpin(), which
> > already
> > runs on every unpin path (kernel, external, framebuffer, backup
> > object) right before the true 1 -> 0 pin_count transition. Since
> > list_del_init() only operates on the node itself, this removal is
> > list-agnostic and safe to perform regardless of which list
> > (external
> > or kernel_bo_present) the bo happens to be linked on, or which code
> > path is performing the final unpin. Drop the now-redundant explicit
> > list_del_init() calls in xe_bo_unpin_external() and xe_bo_unpin().
>=20
> I think you can also use this idea to bypass the p2p checking? Create
> a=20
> VRAM + TT buffer, turn it into an fb and use it for scanout. While fb
> pinned you dma-buf export/import + map it (dynamic). AFAICT you can=20
> trick xe_dma_buf_map() since this buffer looks like you can migrate
> it=20
> (dual placement) but since already fb pinned this will make it skip
> the=20
> actual migrate/validate, so it falls through to mapping the VRAM
> using=20
> the pci address. However, this could be on a system that lacks p2p=20
> support. Don't see what prevents that?

Thanks, for reviewing, Matt. Yup that concern indeed seems valid. I'll
craft a separate patch for that.=20

Meanwhile, Sashiko flagged a couple of issues with the current series,
so I'll send out a v3. Please let me know if your R-Bs still hold.

Thanks,
Thomas



>=20
> >=20
> > Fixes: 44e694958b95 ("drm/xe/display: Implement display support")
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > Cc: intel-xe@lists.freedesktop.org
> > Cc: <stable@vger.kernel.org> # v6.8+
> > Assisted-by: LLM
> > Signed-off-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> >=20
> > v2:
> > - New patch
> > ---
> > =C2=A0 drivers/gpu/drm/xe/xe_bo.c | 25 ++++++++++++++++---------
> > =C2=A0 1 file changed, 16 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/xe/xe_bo.c
> > b/drivers/gpu/drm/xe/xe_bo.c
> > index 2fbbba7cf4b0..581bfded21db 100644
> > --- a/drivers/gpu/drm/xe/xe_bo.c
> > +++ b/drivers/gpu/drm/xe/xe_bo.c
> > @@ -487,12 +487,27 @@ static void xe_bo_account_pin(struct xe_bo
> > *bo)
> > =C2=A0=C2=A0 * held, before &ttm_buffer_object.pin_count is decremented=
 by
> > =C2=A0=C2=A0 * ttm_bo_unpin(), so that the check against the true 1->0
> > transition sees
> > =C2=A0=C2=A0 * the pin count that is about to be released.
> > + *
> > + * On the true last unpin, also removes @bo from whichever pinned-
> > bo list
> > + * (external or kernel_bo_present) it may currently be linked on,
> > since a
> > + * bo's final unpin can happen through a pin path (e.g.
> > framebuffer,
> > + * backup object) that has no notion of, or ownership over, that
> > list.
> > + * This is safe and list-agnostic: list_del_init() only needs the
> > node
> > + * itself, not knowledge of which list it is threaded through, and
> > is a
> > + * no-op if @bo is not linked.
> > =C2=A0=C2=A0 */
> > =C2=A0 static void xe_bo_account_unpin(struct xe_bo *bo)
> > =C2=A0 {
> > =C2=A0=C2=A0	struct xe_device *xe =3D xe_bo_device(bo);
> > +	bool last_unpin =3D bo->ttm.pin_count =3D=3D 1;
> > =C2=A0=20
> > -	if (bo->ttm.pin_count =3D=3D 1 && bo->ttm.ttm &&
> > ttm_tt_is_populated(bo->ttm.ttm))
> > +	if (last_unpin && !list_empty(&bo->pinned_link)) {
> > +		spin_lock(&xe->pinned.lock);
> > +		list_del_init(&bo->pinned_link);
> > +		spin_unlock(&xe->pinned.lock);
> > +	}
> > +
> > +	if (last_unpin && bo->ttm.ttm && ttm_tt_is_populated(bo-
> > >ttm.ttm))
> > =C2=A0=C2=A0		xe_ttm_tt_account_add(xe, bo->ttm.ttm);
> > =C2=A0 }
> > =C2=A0=20
> > @@ -3311,11 +3326,6 @@ void xe_bo_unpin_external(struct xe_bo *bo)
> > =C2=A0=C2=A0	xe_assert(xe, xe_bo_is_pinned(bo));
> > =C2=A0=C2=A0	xe_assert(xe, xe_bo_is_user(bo));
> > =C2=A0=20
> > -	spin_lock(&xe->pinned.lock);
> > -	if (bo->ttm.pin_count =3D=3D 1 && !list_empty(&bo-
> > >pinned_link))
> > -		list_del_init(&bo->pinned_link);
> > -	spin_unlock(&xe->pinned.lock);
> > -
> > =C2=A0=C2=A0	xe_bo_unpin_account(bo);
> > =C2=A0=20
> > =C2=A0=C2=A0	/*
> > @@ -3337,10 +3347,7 @@ void xe_bo_unpin(struct xe_bo *bo)
> > =C2=A0=C2=A0	xe_assert(xe, xe_bo_is_pinned(bo));
> > =C2=A0=20
> > =C2=A0=C2=A0	if (mem_type_is_vram(place->mem_type) || bo->flags &
> > XE_BO_FLAG_GGTT) {
> > -		spin_lock(&xe->pinned.lock);
> > =C2=A0=C2=A0		xe_assert(xe, !list_empty(&bo->pinned_link));
> > -		list_del_init(&bo->pinned_link);
> > -		spin_unlock(&xe->pinned.lock);
> > =C2=A0=20
> > =C2=A0=C2=A0		if (bo->backup_obj) {
> > =C2=A0=C2=A0			if (xe_bo_is_pinned(bo->backup_obj))
