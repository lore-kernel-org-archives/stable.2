Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792693772;
	b=1U22Bq9yvjwigvPzcuQT1XauysCvs3y1qoMrGTvZjBDLX3T/dCiHCDVRVH27+aq4aDUf
	 viDcfCgoV21rzLR+82OuKT8qSY7fXhliopbHWSCrjFc66/O/OfLyXgqM3hxlmchWJ68Ix
	 4CKR5J6O53D3ji95Cq1HUSdhKpvexxZHJ8K3r+KQV0N1Q9VPUkZaMIbpoSa6LNd8txeSo
	 o7flqQWQdtWWRLtyUmHu9IqX9f/wBrWyrW+whjD1biQkZ9HzW6WfdE4wsG+d07Vkpno4r
	 x8tBwApCADWgU9w71iTYcuKxgdobE/MfZcqiEWqXY5xRphesJ56kGEvlbsqP7czjI6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792693772;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Organization:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=Unr027+HipeiaEr9adjjqZOA3I/uVdgh9rSHPsOuPiA=;
	b=a1tkhaLguxv8nj3lr4+Y/SextKJEdRfWpfmdF9UDym8m7+pr4VPgOt42huyJClcuHZ48
	 EXe4vnMDLArrEc/3qnW4OrwQChulLdvNuDodzVhKKjmB/hYvk/vazjUnXDoSWEVhkMn5c
	 DJqyplUis6oM+EVNOKm8joWg3ZAqt9P/Sio4+D1uH3UFHf90eYkAdq8Q/TpmbiWVbXmAZ
	 xw8NJh9/pW5qajMyheI0X/zAzgu0Nje591c8KqituP8qjc0duv0Z6A0AcbSZTewhbyfRG
	 XeWyjp4X5qUpJG76PNKT7duWHL8B3Qhp59e5stoCQGveKPtNsuT3hrK9UvXduL84V8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YtC3mCDc;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A646606A320
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 18:29:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A646606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YtC3mCDc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792693772; x=1824229772;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=6BwPdua4UuOyGEYU8/f5ZAANCuDIRmi8quDTOodfj4w=;
  b=YtC3mCDcBm+YjtW1suURyVJ3u3sQxJEtqfDpCbGoziDus+t3B0kmj8ru
   EXWemyXgnY22dmayeFPrLx3EGRA74M9TH03mtpcgZCnFngzcFqQ8NNnmk
   TPEgzy6z5DLd7/N9RRDOK66eg8ETA+R9NDjAN3zGw5IZF5bF1hD7HFxPV
   ZqT4jv4ILGLrcQ/QcoUfUMernpF2KPYxhaliJ7MbDlP7UpZorzkQknrm4
   VYV/pZV9uoRCJOZZ2xhcOA5HZKThGPZFxNAOs1UycEPe+6JONxkqhv9t0
   +B73zcL/oXt7zHA6uRmbOFqx6VdCNY0DkgmHp0FI1ApxWdyyAREFQNcEE
   A==;
X-CSE-ConnectionGUID: F8mfHZtnTUWs+hM1vm9Q+g==
X-CSE-MsgGUID: NeDpJaBzTjCSUgikAwybkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1466494"
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="1466494"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 11:29:25 -0700
X-CSE-ConnectionGUID: HXKz2F3uRGeN+fzF7sv0tA==
X-CSE-MsgGUID: duw25cQBTSS1Ts2LHjrFuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="3553184"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO [10.245.244.44]) ([10.245.244.44])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 11:29:24 -0700
Message-ID: <45831f6088cde19e2885cbbde52574da8a595e18.camel@linux.intel.com>
Subject: Re: [PATCH 1/2] drm/xe/sa: make suballocator waits uninterruptible
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Matthew Auld <matthew.auld@intel.com>, intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>, stable@vger.kernel.org
Date: Thu, 22 Oct 2026 20:29:21 +0200
In-Reply-To: <20261022174058.226432-5-matthew.auld@intel.com>
References: <20261022174058.226432-4-matthew.auld@intel.com>
	 <20261022174058.226432-5-matthew.auld@intel.com>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-2.fc43) 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi, Matt

On Thu, 2026-10-22 at 18:41 +0100, Matthew Auld wrote:
> Large BO clears and copies in xe_migrate_clear() and
> xe_migrate_copy()
> are split into multiple passes, each needing a batchbuffer from the
> fixed size kernel bb pool. Once the pool fills up, __xe_sa_bo_new()
> waits interruptibly for space, so a pending signal (e.g. Xorg's 5ms
> SIGALRM smart-scheduler timer) makes it fail mid-loop with -
> ERESTARTSYS.
> The partial progress is then thrown away and the restarted ioctl
> starts
> again from byte 0, including the memory allocation, which can
> livelock
> if the signal arrives faster than the whole operation completes. In
> the
> shrinker path the same error also aborts the shrinker walk, even
> though
> ctx->interruptible is false.
>=20
> Being interruptible here doesn't seem to buy much anyway: on error
> the loop already waits uninterruptibly for all submitted passes
> before
> returning. So just make the suballocator waits uninterruptible,
> matching
> amdgpu and radeon. The other users (page reclaim from a kworker, and
> the
> GuC buffer cache) shouldn't really see any meaningful change.

This is a deviation from the "make all waits possible interruptible".
One might argue that user-space that interrupts kernel work with a 5ms
time only to restart it again and again is not well-behaving and
continously shoots itself in the foot.

Given our pipelining abilities, isn't there a risk that we delay signal
delivery with up to 10s?

In the worst case, is there a way we can periodically at least check
for pending signals or perhaps increase the sa bo size so that it
doesn't block on a single large buffer?

/Thomas

>=20
> Assisted-by: LLM
> Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/9644
> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel
> GPUs")
> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> Cc: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: <stable@vger.kernel.org> # v6.12+
> ---
> =C2=A0drivers/gpu/drm/xe/xe_sa.c | 5 +++--
> =C2=A01 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/xe/xe_sa.c b/drivers/gpu/drm/xe/xe_sa.c
> index f32045f40b7a..d9c2b28b08c2 100644
> --- a/drivers/gpu/drm/xe/xe_sa.c
> +++ b/drivers/gpu/drm/xe/xe_sa.c
> @@ -165,7 +165,8 @@ void xe_sa_bo_sync_shadow(struct drm_suballoc
> *sa_bo)
> =C2=A0 * @size: number of bytes we want to suballocate
> =C2=A0 * @gfp: gfp flags used for memory allocation. Typically GFP_KERNEL=
.
> =C2=A0 *
> - * Try to make a suballocation of size @size.
> + * Try to make a suballocation of size @size. Any waits for space
> are
> + * uninterruptible.
> =C2=A0 *
> =C2=A0 * Return: a &drm_suballoc, or an ERR_PTR.
> =C2=A0 */
> @@ -178,7 +179,7 @@ struct drm_suballoc *__xe_sa_bo_new(struct
> xe_sa_manager *sa_manager, u32 size,
> =C2=A0	if (size > sa_manager->base.size)
> =C2=A0		return ERR_PTR(-ENOBUFS);
> =C2=A0
> -	return drm_suballoc_new(&sa_manager->base, size, gfp, true,
> 0);
> +	return drm_suballoc_new(&sa_manager->base, size, gfp, false,
> 0);
> =C2=A0}
> =C2=A0
> =C2=A0/**
