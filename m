Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7BF379C4A
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 12:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790944991; cv=none; b=RNSsKdeuUKGXxIh4PzlxPM60v2JY8B1SI5ROggcJnBlRgQv2GBZ8aTjOzB5lwiE0BC7Dhi16HEk0YahXYxVBC/mX4XxddG904nsNC4XXBxkcy/Nx9QZqPURJxBtabLKwd2c6Dzq81t26W3hlhdR0uTFuf31C+oacW/forBSjC/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790944991; c=relaxed/simple;
	bh=pV17yDyLayBJaMKeWhYnaloOLDaj3BpYKbKQGWgLUMQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bDTiq/w7twc68U8+koTenOVf58oAwAqCc7TPd6UaBAkGVdbmZzYEP/ieLUfatUrwZaWjc0p0BkRdtG3qsjfrHJwRYGVGBX7929x+h/rUCNldpfxuoeLl+qgdAqrYsH3iYIgrB/JojYUr8ma9a3CDwSMBnm14QEC5NtneSCW4qbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B+IWiwYG; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B+IWiwYG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790944990; x=1822480990;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=pV17yDyLayBJaMKeWhYnaloOLDaj3BpYKbKQGWgLUMQ=;
  b=B+IWiwYGUmjQcW/w+IxhcIyyVcLfW5XIjdIMPKlR4Y5oc0u/3lzRAG3P
   aZ57DnIMwqRBcz1vK1M5EpT8CufGCbNYNDScrflKaObU3xg9S5+20x7Vs
   YLwJfpZ2daYJ0kPxZL5xy7oJTKZ1yiWMGkCeuUZ0AknRKhD/MHaERh20A
   AjLwrFIVPT0/WwZ5/6x8WDiXhpGlmmQ6FPJt206+kq31IbhmSCHg8iAUR
   VxbdThI9E3BhLpGSmePe5B47fa8NRQivGW6KIu2Mgvd5gKeEDxV7erJtA
   AB7MDUCk7LwOJgTJ3Rk5tNe1mZtZ21omtqlPlWjxH8C+j1PNW5dhn8LFo
   Q==;
X-CSE-ConnectionGUID: MynrX0Y1ScaapYQL6cw2sg==
X-CSE-MsgGUID: 1o1AuLumSu2MA3XqMm+P8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="90609766"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="90609766"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 05:43:09 -0700
X-CSE-ConnectionGUID: TNIYoNU5Q66S72FzQPFDpw==
X-CSE-MsgGUID: zq69cSJfThuZzr5gvwIYTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="275434223"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO [10.245.244.200]) ([10.245.244.200])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 05:43:08 -0700
Message-ID: <92619c231f212306eb1c0c274b69c47687696159.camel@linux.intel.com>
Subject: Re: [PATCH 2/2] drm/xe/vm: make PREFETCH to TT sticky
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Matthew Auld <matthew.auld@intel.com>, intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>, stable@vger.kernel.org
Date: Fri, 02 Oct 2026 14:43:05 +0200
In-Reply-To: <20260928164820.1237049-6-matthew.auld@intel.com>
References: <20260928164820.1237049-4-matthew.auld@intel.com>
	 <20260928164820.1237049-6-matthew.auld@intel.com>
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

On Mon, 2026-09-28 at 17:48 +0100, Matthew Auld wrote:
> When userspace explicitly requests DRM_XE_VM_BIND_OP_PREFETCH to
> system
> memory (XE_PL_TT), xe_bo_migrate() moves the buffer object to TT.
> However, because XE_PL_TT is marked with TTM_PL_FLAG_FALLBACK in the
> buffer's default placement (introduced in commit 5c87fee3c96c
> ("drm/xe:
> Attempt to bring bos back to VRAM after eviction")), any subsequent
> validation during exec immediately migrates the buffer back to VRAM,
> completely undoing the userspace prefetch request.
>=20
> Use xe_bo_migrate_tt_sticky() when prefetching to XE_PL_TT so that
> the
> buffer remains resident in system memory across subsequent
> validations.
>=20
> Assisted-by: LLM
> Reported-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> Fixes: 5c87fee3c96c ("drm/xe: Attempt to bring bos back to VRAM after
> eviction")
> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: <stable@vger.kernel.org> # v6.12+

I think we need somewhere to clear this stickiness. Perhaps if
xe_bo_migrate() is called with another destination than the sticky one,
we'd clear it?

Thanks,
Thomas




> ---
> =C2=A0drivers/gpu/drm/xe/xe_vm.c | 5 ++++-
> =C2=A01 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
> index 425c678f4480..2068e0cf50ff 100644
> --- a/drivers/gpu/drm/xe/xe_vm.c
> +++ b/drivers/gpu/drm/xe/xe_vm.c
> @@ -3406,7 +3406,10 @@ static int op_lock_and_prep(struct drm_exec
> *exec, struct xe_vm *vm,
> =C2=A0				mem_type =3D
> region_to_mem_type[region];
> =C2=A0			}
> =C2=A0
> -			err =3D xe_bo_migrate(bo, mem_type, NULL,
> exec);
> +			if (mem_type =3D=3D XE_PL_TT)
> +				err =3D xe_bo_migrate_tt_sticky(bo,
> NULL, exec);
> +			else
> +				err =3D xe_bo_migrate(bo, mem_type,
> NULL, exec);
> =C2=A0		}
> =C2=A0		break;
> =C2=A0	}
