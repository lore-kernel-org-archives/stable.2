Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EA1425CD0
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 11:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780574152; cv=none; b=U/wSqU1xUgyxEB97LyDX2U/tXgGVrauqqim+MSWzu8B7065Sy+24glKicQoourMjq3dtNhxdSR40E9inSQXWhMfmdQb/GNY7wYX9sU7CCX73+29nUdjodpdfXAcwRCZM3x1ZhA09wCf7chjkBAPskb2JAo07wNmoLMvHuoqoLPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780574152; c=relaxed/simple;
	bh=WiJCO2VPGWayooAtP7ojZlp+mnlxxSpXLrbQfkxz4Lc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hUXdUstGFiHtLyduCUeI9ST7K7070k7uY1pa7fPir9jpDZpi5rGVhJRFvYj0gKu0VkTmLY51gaEZ8dobFQfjcMaNABlmlVab/HiUA1zSkP59zd/10stamXdijxXPjsWwR2jP0bHzeB2mLrL+iSLidLbZLsHnZMmFb+x981FXXLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OOHlQ/6Y; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OOHlQ/6Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780574150; x=1812110150;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=WiJCO2VPGWayooAtP7ojZlp+mnlxxSpXLrbQfkxz4Lc=;
  b=OOHlQ/6Y6Q76hth3bfiJkIDJgDW6Rq2EF+cEMZS/LVvHtjlblbyvh6jc
   rS/YQ3U0BlMKnoM0lOM13i53ZXzq/EAjzURqoa86bHDuLXLmQvbG+3PDC
   gGt/FrnKvVkT1d1cg9Te3+SBJWJsXMUN2zMdmWQN6Ga00nEq9nsekXRRb
   8kGRBYHMEQF1Ip0mXah7OT2rQBZnDwC/7Hl1+9fuump8PWHFuRaXNVYf6
   hMrbtGLqMt24T8yK2dbsbEh10C7BnVvdiBLawOfnYK3agnmvQf8f/oknF
   cSov24xuI6cp7PTKc9rGAi2HxOqbM0SHGGd9W539dEbTnvernJVNdlOmX
   g==;
X-CSE-ConnectionGUID: eBjZoTmmSOGE8HZ1oexFLA==
X-CSE-MsgGUID: 9zoQSOOXTEm9ZSPtd8Zj5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="106846456"
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="106846456"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 04:55:49 -0700
X-CSE-ConnectionGUID: jKFXS8KSQpqkEIePL9nQzA==
X-CSE-MsgGUID: L4CODvdFQ76UIDmWW03dTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="282630445"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO [10.245.245.65]) ([10.245.245.65])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 04:55:47 -0700
Message-ID: <50b96c72150be42d2516e34ae8bf221a661449ea.camel@linux.intel.com>
Subject: Re: [PATCH] drm/xe: Fix UAF in xe_gem_prime_import() on attach
 failure
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Matthew Auld <matthew.auld@intel.com>, "Gote, Nitin R"
	 <nitin.r.gote@intel.com>, Christian =?ISO-8859-1?Q?K=F6nig?=
	 <christian.koenig@amd.com>, "intel-xe@lists.freedesktop.org"
	 <intel-xe@lists.freedesktop.org>, Christian =?ISO-8859-1?Q?K=F6nig?=
	 <ckoenig.leichtzumerken@gmail.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>, "Brost, Matthew"
	 <matthew.brost@intel.com>, "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>
Date: Thu, 04 Jun 2026 13:55:43 +0200
In-Reply-To: <7269ac80-1470-46d6-bf2d-75b5ab7acf91@intel.com>
References: <20260601101536.1333480-2-nitin.r.gote@intel.com>
	 <ff4a02f0-5a59-4bad-af76-3d71146f136e@intel.com>
	 <5e3854dd-d6ad-4110-966e-9029ef7c2374@amd.com>
	 <b9b9e20f-703d-4e43-bd1a-17d8bbcead70@intel.com>
	 <157c5cfc-b0a5-4ee9-b91a-909e87df3080@amd.com>
	 <SA3PR11MB8118477615C02DD99CA966F7D0152@SA3PR11MB8118.namprd11.prod.outlook.com>
	 <SA3PR11MB8118C54C085BCAF117582849D0102@SA3PR11MB8118.namprd11.prod.outlook.com>
	 <9d26ec14323cb5a54e2b6e58cb177a4a7eb3652a.camel@linux.intel.com>
	 <7269ac80-1470-46d6-bf2d-75b5ab7acf91@intel.com>
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

On Thu, 2026-06-04 at 12:32 +0100, Matthew Auld wrote:
> On 04/06/2026 12:14, Thomas Hellstr=C3=B6m wrote:
> > Hi,
> >=20
> > On Thu, 2026-06-04 at 04:54 +0000, Gote, Nitin R wrote:
> > > Hi,
> > >=20
> > > > -----Original Message-----
> > > > From: Intel-xe <intel-xe-bounces@lists.freedesktop.org> On
> > > > Behalf
> > > > Of Gote, Nitin
> > > > R
> > > > Sent: Monday, June 1, 2026 8:57 PM
> > > > To: Christian K=C3=B6nig <christian.koenig@amd.com>; Auld, Matthew
> > > > <matthew.auld@intel.com>; intel-xe@lists.freedesktop.org;
> > > > Christian
> > > > K=C3=B6nig
> > > > <ckoenig.leichtzumerken@gmail.com>
> > > > Cc: stable@vger.kernel.org; Thomas Hellstrom
> > > > <thomas.hellstrom@linux.intel.com>; Brost, Matthew
> > > > <matthew.brost@intel.com>; Prosyak, Vitaly
> > > > <Vitaly.Prosyak@amd.com>
> > > > Subject: RE: [PATCH] drm/xe: Fix UAF in xe_gem_prime_import()
> > > > on
> > > > attach failure
> > > >=20
> > > > Hi Christian,
> > > >=20
> > > > > -----Original Message-----
> > > > > From: Christian K=C3=B6nig <christian.koenig@amd.com>
> > > > > Sent: Monday, June 1, 2026 5:47 PM
> > > > > To: Auld, Matthew <matthew.auld@intel.com>; Gote, Nitin R
> > > > > <nitin.r.gote@intel.com>; intel-xe@lists.freedesktop.org;
> > > > > Christian
> > > > > K=C3=B6nig <ckoenig.leichtzumerken@gmail.com>
> > > > > Cc: stable@vger.kernel.org; Thomas Hellstrom
> > > > > <thomas.hellstrom@linux.intel.com>; Brost, Matthew
> > > > > <matthew.brost@intel.com>; Prosyak, Vitaly
> > > > > <Vitaly.Prosyak@amd.com>
> > > > > Subject: Re: [PATCH] drm/xe: Fix UAF in xe_gem_prime_import()
> > > > > on
> > > > > attach failure
> > > > >=20
> > > > > On 6/1/26 14:01, Matthew Auld wrote:
> > > > > > On 01/06/2026 12:39, Christian K=C3=B6nig wrote:
> > > > > > >=20
> > > > > > >=20
> > > > > > > On 6/1/26 12:46, Matthew Auld wrote:
> > > > > > > > On 01/06/2026 11:15, Nitin Gote wrote:
> > > > > > > > > xe_dma_buf_create_obj() creates the importer BO with
> > > > > > > > > obj-
> > > > > > > > > > resv
> > > > > > > > > pointing at the exporter's dma_buf->resv. When
> > > > > > > > > dma_buf_dynamic_attach() fails, no dma_buf reference
> > > > > > > > > is
> > > > > > > > > held so
> > > > > > > > > the exporter can be freed immediately. Since
> > > > > > > > > ttm_bo_release() now
> > > > > > > > > always defers cleanup for ttm_bo_type_sg BOs to the
> > > > > > > > > TTM
> > > > > > > > > workqueue, the worker later calls
> > > > > > > > > dma_resv_lock() on the already-freed exporter resv,
> > > > > > > > > causing a UAF.
> > > > > > > > >=20
> > > > > > > > > Reset obj->resv to the BO's private _resv before
> > > > > > > > > calling
> > > > > > > > > xe_bo_put() in the error path. The BO is not yet
> > > > > > > > > published
> > > > > > > > > (attach
> > > > > > > > > failed) and carries no fences, so the switch is safe.
> > > > > > > > >=20
> > > > > > > > > Observed with igt@xe_live_ktest@xe_dma_buf_kunit on
> > > > > > > > > BMG
> > > > > > > > > (QEMU):
> > > > > > > > >=20
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 Oops: general protection fault, =
probably for
> > > > > > > > > non-
> > > > > > > > > canonical
> > > > > > > > > address 0x6b6b6b6b6b6b6b9c
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 Workqueue: ttm ttm_bo_delayed_de=
lete [ttm]
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 RIP: 0010:mutex_can_spin_on_owne=
r+0x3f/0xc0
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 Call Trace:
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <TASK>
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ? __ww_mutex_lock.constpro=
p.0+0x2dd/0x18e0
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ? ttm_bo_delayed_delete+0x=
41/0xc0 [ttm]
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ww_mutex_lock+0x3c/0xb0
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ttm_bo_delayed_delete+0x41=
/0xc0 [ttm]
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 process_one_work+0x239/0x7=
40
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 worker_thread+0x200/0x3f0
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kthread+0x10d/0x150
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret_from_fork+0x3bd/0x470
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret_from_fork_asm+0x1a/0x3=
0
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 </TASK>
> > > > > > > > >=20
> > > > > > > > > Closes:
> > > > > > > > > https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items=
/8023
> > > > > > > > > Fixes: d99fbd9aab62 ("drm/ttm: Always take the bo
> > > > > > > > > delayed
> > > > > > > > > cleanup
> > > > > > > > > path for imported bos")
> > > > > > > > > Cc: stable@vger.kernel.org=C2=A0# v6.8+
> > > > > > > > > Cc: Thomas Hellstrom
> > > > > > > > > <thomas.hellstrom@linux.intel.com>
> > > > > > > > > Cc: Matthew Brost <matthew.brost@intel.com>
> > > > > > > > > Cc: Matthew Auld <matthew.auld@intel.com>
> > > > > > > > > Signed-off-by: Nitin Gote <nitin.r.gote@intel.com>
> > > > > > > > > ---
> > > > > > > > > =C2=A0=C2=A0=C2=A0 drivers/gpu/drm/xe/xe_dma_buf.c | 8 ++=
++++++
> > > > > > > > > =C2=A0=C2=A0=C2=A0 1 file changed, 8 insertions(+)
> > > > > > > > >=20
> > > > > > > > > diff --git a/drivers/gpu/drm/xe/xe_dma_buf.c
> > > > > > > > > b/drivers/gpu/drm/xe/xe_dma_buf.c index
> > > > > > > > > 8a920e58245c..6d944bd4065c
> > > > > > > > > 100644
> > > > > > > > > --- a/drivers/gpu/drm/xe/xe_dma_buf.c
> > > > > > > > > +++ b/drivers/gpu/drm/xe/xe_dma_buf.c
> > > > > > > > > @@ -384,6 +384,14 @@ struct drm_gem_object
> > > > > > > > > *xe_gem_prime_import(struct drm_device *dev,
> > > > > > > > > =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 attach =
=3D dma_buf_dynamic_attach(dma_buf,
> > > > > > > > > dev-
> > > > > > > > > > dev,
> > > > > > > > > attach_ops, obj);
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(att=
ach)) {
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * The B=
O was created with resv =3D dma_buf-
> > > > > > > > > >resv
> > > > > > > > > +(exporter's
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * resv)=
. Since attach failed, no dma_buf
> > > > > > > > > reference is
> > > > > > > > > +held and
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the e=
xporter may be freed before TTM's
> > > > > > > > > delayed_delete
> > > > > > > > > +worker
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * runs.=
 Switch to the BO's own resv to
> > > > > > > > > prevent
> > > > > > > > > a UAF
> > > > > > > > > +when
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * ttm_b=
o_delayed_delete() tries to lock the
> > > > > > > > > stale pointer.
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 obj->resv =3D=
 &obj->_resv;
> > > > > > > >=20
> > > > > > > > +Christian, does amdgpu not have the type of same issue
> > > > > > > > here? Also
> > > > > > > > +any
> > > > > thoughts here?
> > > > > > >=20
> > > > > > > Oh, good catch. Yeah I think we have the same problem on
> > > > > > > amdgpu as well.
> > > > > >=20
> > > > > > Maybe dumb question, but why does the
> > > > > > ttm_bo_individualize_resv()
> > > > > > skip the
> > > > > final switch of the resv for type_sg?
> > > > >=20
> > > > > Because we need the original resv object for cleaning up the
> > > > > mapping
> > > > > should the initial attach and then map have succeed.
> > > > >=20
> > > > > > It goes through the trouble of copying the fences across?
> > > > >=20
> > > > > Because we need to know when the import can be cleaned up.
> > > > >=20
> > > > > In other words TTM takes a copy of the current fences and
> > > > > only
> > > > > unmap,
> > > > > detach and then do the final cleanup after we are sure that
> > > > > the
> > > > > set of
> > > > > fences which was active on destruction is now signaled.
> > > > >=20
> > > > > If new fences are added to the resv object (maybe by the
> > > > > exporter
> > > > > itself or other
> > > > > importers) after our reference count got down to zero then we
> > > > > don't
> > > > > care about that.
> > > > > > If we do need to handle this here, do we also need to grab
> > > > > > the
> > > > > > lru
> > > > > > lock, like we
> > > > > do in ttm_bo_individualize_resv() when doing the swap?
> > > > >=20
> > > > > Good question, of hand I would say yes but I clearly need to
> > > > > check the
> > > > > source code as well.
> > > > >=20
> > > > > Might be better to switch the type of the BO on error so that
> > > > > the
> > > > > normal cleanup will just switch over to the local dma_resv
> > > > > object.
> > > > >=20
> > > >=20
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 obj->resv =3D &obj->_resv;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 gem_to_xe_bo(obj)->ttm.type =3D
> > > > ttm_bo_type_kernel;
> > > >=20
> > > > Switching the type to ttm_bo_type_kernel lets
> > > > ttm_bo_individualize_resv() swap
> > > > resv to the BO's private _resv under lru_lock, which prevents
> > > > UAF
> > > > without
> > > > needing any manual locking.
> >=20
> > The lru lock is IIRC only needed and safe when the ttm refcount is
> > zero
> > (in the TTM destruction path) to protect against a racing LRU walk
> > trylock succeeds against the incorrect resv.
> >=20
> > I wonder whether this was actually why xe code initially took care
> > not
> > to publish the bo on the LRUs until the attachment succeeded.
> >=20
> > A TTM LRU walker may pick up the exporting resv as soon as the
> > resource
> > is published on the LRU, and then try to lock it using
> > ttm_lru_walk_ticketlock(). The lru lock doesn't protect against
> > that.
> > =C2=A0=20
> > So we have a sort of moment22, since with that approach
> > move_notify()
> > could be called without the bo being fully initialized.
> >=20
> > One way to move forward would perhaps be to, for now, reinstate
> > that
> > and have move_notify check if the bo is a stub or fully initialized
> > before doing anything.
> >=20
> > Also perhaps we should in the future consider allowing dma-buf
> > attachment removal under a separate lower-level lock than the resv.
>=20
> Is it plausible to check for drm_gem_is_imported() in=20
> ttm_bo_individualize_resv()? If sg && !imported then it should be
> safe=20
> to swap out the resv?

That'd require we never dropped the exporter refcount until the
individualization happens. Hard to assert, and would be fragile. Also
not completely sure on the stance currently WRT gem and ttm layer code
separation, but that OTH is fixable.

/Thomas


>=20
> >=20
> > Thanks,
> > Thomas
> >=20
> >=20
> > >=20
> > > Checked all bo->type readers (xe_evict_flags(), xe_bo_move(),
> > > xe_bo_can_migrate()) and found they can be called concurrently by
> > > the
> > > shrinker or eviction paths without any synchronization, making
> > > the
> > > bo->type change unsafe.
> > >=20
> > > Switching resv to &obj->_resv under lru_lock, mirroring
> > > ttm_bo_individualize_resv(), is the more reasonable.
> > > I'll send this as v2, along with a separate patch fixing the same
> > > issue in amdgpu.
> > >=20
> > > - Nitin
> > >=20
> > > > > Since we don't need the original dma_resv for the cleanup
> > > > > that
> > > > > should work
> > > > fine.
> > > > >=20
> > > > > > Ideally xe and amdgpu can just have identical solutions
> > > > > > here.
> > > > >=20
> > > > > Yeah completely agree.
> > > > >=20
> > > > > Regards,
> > > > > Christian.
> > > > >=20
> > > > > >=20
> > > > > > >=20
> > > > > > > How the heck did you found that? Do we have a dummy
> > > > > > > driver
> > > > > > > (VGEM?)
> > > > > > > which
> > > > > could be made to always fail attachment for a test case?
> > > >=20
> > > > The bug was found via the existing KUnit test
> > > > (xe_dma_buf_kunit),
> > > > which was
> > > > failing on a BMG VM device. The test runs 20 parameter
> > > > combinations.
> > > > the failing ones use force_different_devices=3Dtrue +
> > > > mem_mask=3DXE_BO_FLAG_VRAM0 + nop2p_attach_ops, where
> > > > dma_buf_dynamic_attach() returns -EOPNOTSUPP, hitting the error
> > > > path.
> > > >=20
> > > > On bare metal BMG the race window is too narrow to hit the
> > > > issue.
> > > > To make it
> > > > more deterministic, added a small msleep(100) in
> > > > ttm_bo_delayed_delete() just
> > > > before the dma_resv_lock() call, which widened the race window.
> > > > With KASAN enabled, that gave a clear slab-use-after-free in
> > > > __ww_mutex_lock
> > > > =E2=80=94 the 0x6b6b6b6b SLUB poison pattern in the faulting addres=
s
> > > > confirmed the
> > > > UAF.
> > > >=20
> > > > Thanks,
> > > > Nitin
> > > >=20
> > > > > > >=20
> > > > > > > @Vitaly can you take a look and try to come up with a
> > > > > > > test
> > > > > > > case for that?
> > > > > Thanks in advance.
> > > > > > >=20
> > > > > > > Thanks for the notice,
> > > > > > > Christian.
> > > > > > >=20
> > > > > > > >=20
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 xe_bo_put(gem_to_xe_bo(obj));
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 return ERR_CAST(attach);
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > > > > >=20
> > > > > > >=20
> > > > > >=20
