Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463AB4A207D
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 14:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791209942; cv=none; b=vGicrVCpAngy/bG/xt6pCPZ7Jo3Kalv8F1O3TxQdcpy7zPOAJqEd7a5iPCHLGuN+hgPDyjHQWx4YQzb6kA4T2hBa0L6/B+CtEEDHYwxCyBe6VZse/elbVwHhGhqDoZSOSOY5uttdoaAmaB8qCJji7thvYHw9XE+f4Alt5IWNW+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791209942; c=relaxed/simple;
	bh=khhPwX+MmApBh1r6x/eUB4xZNi8NIK0p6TVSIGaHi/Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aBMcfK1H4szGe669V+5/KZN0qoc878ppqeFGvpAoKA3RUJa2K72SBFAcRy5zodmY8U4mabi62mBWfneXjqquGCv8mEWqVQ+3rZOxr4T1uGrEw4/KQiT871Nf8yqbfnvtmphvZjb/UwRpMnpFPUuP43ATR5FutlPvb+Ia1I2RGn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hbqSnwG0; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hbqSnwG0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791209937; x=1822745937;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=khhPwX+MmApBh1r6x/eUB4xZNi8NIK0p6TVSIGaHi/Q=;
  b=hbqSnwG0qYtyEcE1+I/CdgHkCmUnLuPxIE4y4v/3E4di5NpQ+5oNmIzC
   qJ/Fb7g6JDXAki4W421TVsx+GkbTKuu14yOJuPOiIW1Lh3262TI+d5oLT
   G+9NVvWslJXe0S0X20eiWovDfFEGyhJb9dCx00w/vxKmOjEnNSdKWWZ/i
   uw6S4JJLmxcssB5YQ0rMGCci74EvPa8WUj3j5dcUS+efWEXeogv39Bend
   6ISdE32oP+KzWhj92443dZiWMHVz6DnSjNGWonHHaaZ7teAj6idpA9toI
   ue+edQiLd87HROMDNJo/fWbmFI5cc4HGZViaowDnbu0Srtq+arJbEq601
   Q==;
X-CSE-ConnectionGUID: TXysmyLrS3yCc2unAk8xfA==
X-CSE-MsgGUID: JK2J3FQeShe10MePeWW57Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="79439655"
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="79439655"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 07:17:40 -0700
X-CSE-ConnectionGUID: Kj3OHN9lQ1e4gQxhKSjlGg==
X-CSE-MsgGUID: tl6ZZSxTTFiPpxlQU6475g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="886467"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO [10.245.245.209]) ([10.245.245.209])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 07:17:37 -0700
Message-ID: <8ba544fe1a920392ee9449b398fbd0f3a5ede2a8.camel@linux.intel.com>
Subject: Re: [PATCH 2/2] drm/xe/vm: make PREFETCH to TT sticky
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Matthew Auld <matthew.auld@intel.com>, intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>, stable@vger.kernel.org
Date: Mon, 05 Oct 2026 16:17:27 +0200
In-Reply-To: <04c348e7-2fed-4fe9-a151-860b05433a75@intel.com>
References: <20260928164820.1237049-4-matthew.auld@intel.com>
	 <20260928164820.1237049-6-matthew.auld@intel.com>
	 <92619c231f212306eb1c0c274b69c47687696159.camel@linux.intel.com>
	 <04c348e7-2fed-4fe9-a151-860b05433a75@intel.com>
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

On Fri, 2026-10-02 at 14:32 +0100, Matthew Auld wrote:
> On 02/10/2026 13:43, Thomas Hellstr=C3=B6m wrote:
> > On Mon, 2026-09-28 at 17:48 +0100, Matthew Auld wrote:
> > > When userspace explicitly requests DRM_XE_VM_BIND_OP_PREFETCH to
> > > system
> > > memory (XE_PL_TT), xe_bo_migrate() moves the buffer object to TT.
> > > However, because XE_PL_TT is marked with TTM_PL_FLAG_FALLBACK in
> > > the
> > > buffer's default placement (introduced in commit 5c87fee3c96c
> > > ("drm/xe:
> > > Attempt to bring bos back to VRAM after eviction")), any
> > > subsequent
> > > validation during exec immediately migrates the buffer back to
> > > VRAM,
> > > completely undoing the userspace prefetch request.
> > >=20
> > > Use xe_bo_migrate_tt_sticky() when prefetching to XE_PL_TT so
> > > that
> > > the
> > > buffer remains resident in system memory across subsequent
> > > validations.
> > >=20
> > > Assisted-by: LLM
> > > Reported-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> > > Fixes: 5c87fee3c96c ("drm/xe: Attempt to bring bos back to VRAM
> > > after
> > > eviction")
> > > Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> > > Cc: Matthew Brost <matthew.brost@intel.com>
> > > Cc: <stable@vger.kernel.org> # v6.12+
> >=20
> > I think we need somewhere to clear this stickiness. Perhaps if
> > xe_bo_migrate() is called with another destination than the sticky
> > one,
> > we'd clear it?
>=20
> In the other patch in bo_migrate() there is:
>=20
> +	ret =3D ttm_bo_validate(&bo->ttm, &placement, tctx);
> +	if (!ret)
> +		xe_bo_reset_sticky_placement(bo);
> +	return ret;
> +}
>=20
> So if something successfully uses a non-sticky migrate(), it will
> reset.=20
> Is this enough?

Yes, I missed that. That should be enough IMO.

Reviewed-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>


>=20
> >=20
> > Thanks,
> > Thomas
> >=20
> >=20
> >=20
> >=20
> > > ---
> > > =C2=A0=C2=A0drivers/gpu/drm/xe/xe_vm.c | 5 ++++-
> > > =C2=A0=C2=A01 file changed, 4 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/gpu/drm/xe/xe_vm.c
> > > b/drivers/gpu/drm/xe/xe_vm.c
> > > index 425c678f4480..2068e0cf50ff 100644
> > > --- a/drivers/gpu/drm/xe/xe_vm.c
> > > +++ b/drivers/gpu/drm/xe/xe_vm.c
> > > @@ -3406,7 +3406,10 @@ static int op_lock_and_prep(struct
> > > drm_exec
> > > *exec, struct xe_vm *vm,
> > > =C2=A0=C2=A0				mem_type =3D
> > > region_to_mem_type[region];
> > > =C2=A0=C2=A0			}
> > > =C2=A0=20
> > > -			err =3D xe_bo_migrate(bo, mem_type, NULL,
> > > exec);
> > > +			if (mem_type =3D=3D XE_PL_TT)
> > > +				err =3D
> > > xe_bo_migrate_tt_sticky(bo,
> > > NULL, exec);
> > > +			else
> > > +				err =3D xe_bo_migrate(bo,
> > > mem_type,
> > > NULL, exec);
> > > =C2=A0=C2=A0		}
> > > =C2=A0=C2=A0		break;
> > > =C2=A0=C2=A0	}
