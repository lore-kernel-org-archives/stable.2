Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6CF411670
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 15:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782919401; cv=none; b=bJq0PzjGapVvU9UF6GfmBa9QJf98ftC+ht6owzyLTexznlb3PB5/63ktD51gKVY98RWgYoeo9p5I3p8zTR17lSWvMm7gMg2TEvKEzW4sl7fxd71FK6pMQ89nO1i3VtZFDH7cmDqpOB2OAFgntGw5E7Gjl6Ei2ioN+l9IfV23rEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782919401; c=relaxed/simple;
	bh=11rMUklXb0pqNOKXlW6EemWO3Cy6rhYqZNz+Hsxi7Ic=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sgXKqmdfQJt38/sJYinKYJqq5Lp34jhesLzdy/Xpjq6nwoX4OBed1OSPzI6F5qZkK0bLIlM37otl7mWv6wCsvLsihYQcr7m4NOj2AUyrNCYN+DWg2tzU4wPlglcQ93WZiIjfO6rgnEsz4FeDhmcygfB9JWGPQjohK/3/eIVVovE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hyt/uq5e; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hyt/uq5e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782919399; x=1814455399;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=11rMUklXb0pqNOKXlW6EemWO3Cy6rhYqZNz+Hsxi7Ic=;
  b=Hyt/uq5eW5fwCGvlYuU4KUyjTYk+4qrPD68qebGTKA76hNs/VveRGuGL
   22E9VMH9PCPSeDcAdBKjZYA9ZHUsp7Hc4XF+ee48pf0I2u1kyOopqKCfJ
   rHYr/imYzWCjNt0zyPDmAzGV+0Q1RoxjleNA04RCZuG4NOPnYKQIbe59b
   +367cCvgbePhTlJSNlohXukTpJ5vX0c7rUgI23ZXKj9LRTa01NYo/Gu8/
   dSgs5tbjsZRmPNJwwAItnnct1L76yFSU6SpLTAlZDhXlEz97DsfZ5XFjX
   Vt7BZybjOgjF26Y57x7jg+Zq1t/GS8HfUmFkq4rfhZn6vz8xspHnxoQ24
   w==;
X-CSE-ConnectionGUID: HpJuc3S0QlKBTiCAZdeEGA==
X-CSE-MsgGUID: R/yYWV+URqCVJ1yLJtnG/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="83789255"
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="83789255"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 08:23:19 -0700
X-CSE-ConnectionGUID: fAmO+TmlRpmiBDAiEP2W2g==
X-CSE-MsgGUID: xsORQ27NRSuvz1RHDfTk+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="252727577"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO [10.245.244.120]) ([10.245.244.120])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 08:23:17 -0700
Message-ID: <fead429b4ee46bfb7cd1f1dee27912e155797fc6.camel@linux.intel.com>
Subject: Re: [PATCH] drm/ttm: Fix UAF on dma-buf attach failure for sg BOs
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Nitin
 Gote	 <nitin.r.gote@intel.com>, intel-xe@lists.freedesktop.org
Cc: stable@vger.kernel.org, Matthew Auld <matthew.auld@intel.com>
Date: Wed, 01 Jul 2026 17:23:15 +0200
In-Reply-To: <b32a5081-545f-4703-ad88-ce54cc1efe09@amd.com>
References: <20260701062559.3731993-2-nitin.r.gote@intel.com>
	 <dfed18b63a7b6cf164b3af7f65df8b4a1b9dbdf2.camel@linux.intel.com>
	 <b32a5081-545f-4703-ad88-ce54cc1efe09@amd.com>
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

On Wed, 2026-07-01 at 15:20 +0200, Christian K=C3=B6nig wrote:
> On 7/1/26 14:59, Thomas Hellstr=C3=B6m wrote:
> > Hi, Nitin
> >=20
> > On Wed, 2026-07-01 at 11:56 +0530, Nitin Gote wrote:
> > > When a dma-buf importer creates a ttm_bo_type_sg BO with bo-
> > > > base.resv
> > > pointing at the exporter's dma_buf->resv and
> > > dma_buf_dynamic_attach()
> > > fails, no dma_buf reference is held. The exporter can be freed
> > > before
> > > the delayed_delete worker calls dma_resv_lock(bo->base.resv),
> > > causing
> > > a
> > > use-after-free:
> > >=20
> > > =C2=A0 Oops: general protection fault, probably for non-canonical
> > > address
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x6b6b6b6b6b6b6b9c
> > > =C2=A0 Workqueue: ttm ttm_bo_delayed_delete [ttm]
> > > =C2=A0 RIP: 0010:mutex_can_spin_on_owner+0x3f/0xc0
> > >=20
> > > ttm_bo_individualize_resv() skips the resv swap for all sg BOs to
> > > keep
> > > the shared resv available for delayed_delete to release the dma-
> > > buf
> > > mapping. A BO whose attach never succeeded has no mapping to
> > > release,
> > > yet it keeps bo->base.resv pointing at the exporter resv that
> > > delayed_delete later locks once the exporter is gone.
> > >=20
> > > Fix this by checking bo->base.import_attach, which is set only
> > > after
> > > a
> > > successful attach. The check is placed after
> > > dma_resv_copy_fences()
> > > so
> > > successful imports still copy fences to _resv before returning,
> > > keeping
> > > the shared resv for delayed_delete. Failed imports fall through
> > > to
> > > swap
> > > resv to _resv, so delayed_delete never locks the stale exporter
> > > resv.
> > >=20
> > > Closes:
> > > https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8023
> > > Fixes: d99fbd9aab62 ("drm/ttm: Always take the bo delayed cleanup
> > > path for imported bos")
> > > Cc: stable@vger.kernel.org=C2=A0# v6.8+
> > > Cc: Thomas Hellstrom <thomas.hellstrom@linux.intel.com>
> > > Cc: Christian Konig <christian.koenig@amd.com>
> > > Cc: Matthew Auld <matthew.auld@intel.com>
> > > Assisted-by: GitHub_Copilot:claude-sonnet-4.6
> > > Signed-off-by: Nitin Gote <nitin.r.gote@intel.com>
> > > ---
> > > Hi Thomas/Christian,
> > > Thank you for the review. Addressed the v3 review comments in
> > > this=20
> > > v4 version.
> > >=20
> > > v4:
> > > - Moved import_attach check to after dma_resv_copy_fences() so
> > > fences
> > > =C2=A0 are copied before returning for successful imports (Thomas).
> > > - Removed exporter-alive claim from commit message (Thomas).
> >=20
> > That's not sufficient. What I meant was that this invalidates the
> > approach in its current form:
> >=20
> > A			B
> > prime_import()	=09
> > exported_get();
> > exported_lock();
> > bo_create();		lru_walk():
> > attach_fail();		bo_get();
> > bo_put();	=09
> > exported_unlock();	bo_lock() // exporter_lock
> > exporter_put();	=09
> > exporter_free();=09
> > 			bo_unlock(); //UAF
> > 		=09
> > There is no guarantee that the exporter stays alive until
> > resv individualization happens.
>=20
> IIRC at least for AMDGPU that shouldn't be possible.
>=20
> We intentionally create the imported BO as empty shell without
> ttm_resource object, so it is not on any LRU list.
>=20
> But to be honest I haven't looked into that in years, so it is
> perfectly possible that this is messed up again.

Yeah, this was recently changed in xe, but I'm not 100% sure we
actually create a bo resource.

In any case if we add an assert

WARN_ON_ONCE(bo->type =3D=3D ttm_bo_type_sg && bo->res);

just before / after=C2=A0
bo->base.resv =3D &bo->base._resv;

or something similar, we would hit that if the bo is published on the
LRU and would need an additional fix in the driver.

/Thomas


>=20
> Regards,
> Christian.
>=20
> >=20
> > /Thomas
> >=20
> >=20
> > >=20
> > > v3:
> > > - Dropped the xe-side reordering approach since importer_priv
> > > must be
> > > =C2=A0 valid when dma_buf_dynamic_attach() publishes the attachment.
> > > - Per Christian's suggestion on the v1 thread, keyed the check on
> > > =C2=A0 import_attach rather than removing the sg guard entirely.
> > > - Fixes both xe and amdgpu in a single TTM patch.
> > >=20
> > > =C2=A0drivers/gpu/drm/ttm/ttm_bo.c | 24 +++++++++++++++---------
> > > =C2=A01 file changed, 15 insertions(+), 9 deletions(-)
> > >=20
> > > diff --git a/drivers/gpu/drm/ttm/ttm_bo.c
> > > b/drivers/gpu/drm/ttm/ttm_bo.c
> > > index bcd76f6bb7f0..9b6341f69805 100644
> > > --- a/drivers/gpu/drm/ttm/ttm_bo.c
> > > +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> > > @@ -203,15 +203,21 @@ static int ttm_bo_individualize_resv(struct
> > > ttm_buffer_object *bo)
> > > =C2=A0	if (r)
> > > =C2=A0		return r;
> > > =C2=A0
> > > -	if (bo->type !=3D ttm_bo_type_sg) {
> > > -		/* This works because the BO is about to be
> > > destroyed and nobody
> > > -		 * reference it any more. The only tricky case
> > > is
> > > the trylock on
> > > -		 * the resv object while holding the lru_lock.
> > > -		 */
> > > -		spin_lock(&bo->bdev->lru_lock);
> > > -		bo->base.resv =3D &bo->base._resv;
> > > -		spin_unlock(&bo->bdev->lru_lock);
> > > -	}
> > > +	/*
> > > +	 * Successfully imported sg BOs need the shared resv for
> > > dma-buf
> > > +	 * cleanup. Failed imports have no attachment or mapping
> > > and
> > > can
> > > +	 * use the private _resv.
> > > +	 */
> > > +	if (bo->type =3D=3D ttm_bo_type_sg && bo-
> > > >base.import_attach)
> > > +		return 0;
> > > +
> > > +	/* This works because the BO is about to be destroyed
> > > and
> > > nobody
> > > +	 * references it any more. The only tricky case is the
> > > trylock on
> > > +	 * the resv object while holding the lru_lock.
> > > +	 */
> > > +	spin_lock(&bo->bdev->lru_lock);
> > > +	bo->base.resv =3D &bo->base._resv;
> > > +	spin_unlock(&bo->bdev->lru_lock);
> > > =C2=A0
> > > =C2=A0	return r;
> > > =C2=A0}
