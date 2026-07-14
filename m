Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2E143CECA;
	Tue, 14 Jul 2026 18:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784054024; cv=none; b=FvFxpUp1VuXeV2k4FP/HFZTm8oqaCxXvvBNVqtwv7t49bg79mhCluYHuEM5n1K0D8hViDtu5m9h+S56O3UiDjtEGsjC2U2QPFh9ehGBT6hx1pxWZYXUEf+JPVSHAQMT/IJ/ZWvKn+amMG3sAJOECCv4yIxRRFpukmDQleDj1ZSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784054024; c=relaxed/simple;
	bh=G+CQm2u0t0jDXEYLT97IgrcW4GZxek5QHJjqTILuWeo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cnuwNCi/sqVKBUvpHzI2wj6elotvad2E0hjC8cLQk4p9XFHs+AMS4jgH9usHSUDPDlqjmX3cf73bJIeHaGoa1y/XqnmAtf0XcIdTZbORBrNXtPSW+7rXNP7154uUINAucNh/THfjGSSxwnWaJYIXIq1PzczWGZyWl6jGFxY78g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CH3qaEjK; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CH3qaEjK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784054022; x=1815590022;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=G+CQm2u0t0jDXEYLT97IgrcW4GZxek5QHJjqTILuWeo=;
  b=CH3qaEjKWw5poOJJ1jE++MnlO42OWSlwEBNt8V/3spY0DaS+/vMLX4aQ
   Sy6Yhtk2Z+RV5T92DD5iv5D8HrXom3wJIhQrEXjYxJweTJHHa9FRfINAq
   HrBzIENakx+G4OMXR17RfpGJJqumuYhBsW94g6OnTcr9fatfVgYWtqWoW
   4Tty/GSvulR3uA2GZ+XnGxQE9cUs+byyIOMZA6hcL7/zTghrwdcjOFmxS
   DlZBD5xxPEnlWmBsReybEJKEz8nYOW7O8bHAOV15+ZuWanEDXpRuW7SjP
   ymn3ZQtFbTICISbfedaPYMklheF8n6w1SmptC94zvRBtpq4k9eWY03ZoW
   g==;
X-CSE-ConnectionGUID: RVgSD4BFRj25Zo3CVBbfew==
X-CSE-MsgGUID: H9HV/vf2RmCrK7Ay7hrRsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="95038848"
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="95038848"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 11:33:42 -0700
X-CSE-ConnectionGUID: vI5Lrot2TqCssFkfALbIog==
X-CSE-MsgGUID: a+xk3+08R8akDWBAe+bVnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="259511182"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO [10.245.245.238]) ([10.245.245.238])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 11:33:39 -0700
Message-ID: <b66a85c300828f2a79bce20cdbad9051c617b694.camel@linux.intel.com>
Subject: Re: [PATCH] drm/ttm: Account for NULL and handle pages in
 ttm_pool_backup
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Matthew Brost <matthew.brost@intel.com>, intel-xe@lists.freedesktop.org,
 	dri-devel@lists.freedesktop.org
Cc: Christian Koenig <christian.koenig@amd.com>, Huang Rui
 <ray.huang@amd.com>,  Matthew Auld <matthew.auld@intel.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard	
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
	 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Tue, 14 Jul 2026 20:33:36 +0200
In-Reply-To: <20260702214815.4009271-1-matthew.brost@intel.com>
References: <20260702214815.4009271-1-matthew.brost@intel.com>
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

On Thu, 2026-07-02 at 14:48 -0700, Matthew Brost wrote:
> Pages in ttm_pool_backup can be NULL or backup handles
> (ttm_backup_page_ptr_is_handle()), neither of which can be passed to
> set_pages_array_wb() or freed. Add a dedicated WB pass before the
> dma/purge loop that walks allocations using the same i +=3D num_pages
> stride, skipping NULL and handle entries, and calls
> set_pages_array_wb()
> once per contiguous run of real pages. Apply the same NULL/handle
> guard
> to the dma/purge loop.
>=20
> Fixes the following oops:
>=20
> Oops: general protection fault, kernel NULL pointer dereference 0x0:
> 0000 [#1] SMP NOPTI
> RIP: 0010:__cpa_process_fault+0xf8/0x770
> RSP: 0018:ffffc90000a87718 EFLAGS: 00010287
> RAX: 0000000000000000 RBX: ffffc90000a87868 RCX: 0000000000000000
> RDX: 0000000000001000 RSI: 0005088000000000 RDI: ffffffff827c5f34
> RBP: 0005088000000000 R08: ffffc90000a877cb R09: ffffc90000a877d0
> R10: 0000000000000000 R11: 000000000000001b R12: 000ffffffffff000
> R13: ffffc90000a87868 R14: ffffc90000a87868 R15: ffff88815b882ae0
> FS:=C2=A0 0000000000000000(0000) GS:ffff8884ec840000(0000)
> knlGS:0000000000000000
> CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f930b844000 CR3: 000000000262e003 CR4: 0000000008f70ef0
> PKRU: 55555554
> Call Trace:
> =C2=A0<TASK>
> =C2=A0__change_page_attr_set_clr+0x989/0xe90
> =C2=A0? __purge_vmap_area_lazy+0x6c/0x3a0
> =C2=A0? _vm_unmap_aliases+0x250/0x2a0
> =C2=A0set_pages_array_wb+0x7f/0x120
> =C2=A0ttm_pool_backup+0x4c9/0x5b0 [ttm]
> =C2=A0? dma_resv_wait_timeout+0x3b/0xf0
> =C2=A0ttm_tt_backup+0x32/0x60 [ttm]
> =C2=A0ttm_bo_shrink+0x66/0x110 [ttm]
> =C2=A0xe_bo_shrink_purge+0x12b/0x1b0 [xe]
> =C2=A0xe_bo_shrink+0xbb/0x270 [xe]
> =C2=A0__xe_shrinker_walk+0xf7/0x160 [xe]
> =C2=A0xe_shrinker_walk+0x9d/0xc0 [xe]
> =C2=A0xe_shrinker_scan+0x11f/0x210 [xe]
> =C2=A0do_shrink_slab+0x13b/0x270
> =C2=A0shrink_slab+0xf1/0x400
> =C2=A0shrink_node+0x352/0x8a0
> =C2=A0balance_pgdat+0x32c/0x700
> =C2=A0kswapd+0x205/0x2f0
> =C2=A0? __pfx_autoremove_wake_function+0x10/0x10
> =C2=A0? __pfx_kswapd+0x10/0x10
> =C2=A0kthread+0xd1/0x110
> =C2=A0? __pfx_kthread+0x10/0x10
> =C2=A0ret_from_fork+0x1b1/0x200
> =C2=A0? __pfx_kthread+0x10/0x10
> =C2=A0ret_from_fork_asm+0x1a/0x30
> =C2=A0</TASK>
>=20
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Huang Rui <ray.huang@amd.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> Cc: stable@vger.kernel.org
> Fixes: b63d715b8090 ("drm/ttm/pool, drm/ttm/tt: Provide a helper to
> shrink pages")
> Cc: stable@vger.kernel.org
> Assisted-by: GitHub_Copilot:claude-opus-4.8
> Signed-off-by: Matthew Brost <matthew.brost@intel.com>

Reviewed-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>

> ---
> =C2=A0drivers/gpu/drm/ttm/ttm_pool.c | 30 ++++++++++++++++++++++++++----
> =C2=A01 file changed, 26 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c
> b/drivers/gpu/drm/ttm/ttm_pool.c
> index 3d5f2ae0a456..ff043420d517 100644
> --- a/drivers/gpu/drm/ttm/ttm_pool.c
> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> @@ -1065,9 +1065,31 @@ long ttm_pool_backup(struct ttm_pool *pool,
> struct ttm_tt *tt,
> =C2=A0		return -EBUSY;
> =C2=A0
> =C2=A0#ifdef CONFIG_X86
> -	/* Anything returned to the system needs to be cached. */
> -	if (tt->caching !=3D ttm_cached)
> -		set_pages_array_wb(tt->pages, tt->num_pages);
> +	/* Anything returned to the system needs to be cached. Walk
> allocations
> +	 * skipping NULL pages and issue set_pages_array_wb() per
> contiguous run.
> +	 */
> +	if (tt->caching !=3D ttm_cached) {
> +		pgoff_t run_start =3D 0, run_count =3D 0;
> +
> +		for (i =3D 0; i < tt->num_pages; i +=3D num_pages) {
> +			page =3D tt->pages[i];
> +			if (unlikely(!page ||
> ttm_backup_page_ptr_is_handle(page))) {
> +				if (run_count) {
> +					set_pages_array_wb(&tt-
> >pages[run_start],
> +							=C2=A0=C2=A0
> run_count);
> +					run_count =3D 0;
> +				}
> +				num_pages =3D 1;
> +				continue;
> +			}
> +			num_pages =3D 1UL << ttm_pool_page_order(pool,
> page);
> +			if (!run_count)
> +				run_start =3D i;
> +			run_count +=3D num_pages;
> +		}
> +		if (run_count)
> +			set_pages_array_wb(&tt->pages[run_start],
> run_count);
> +	}
> =C2=A0#endif
> =C2=A0
> =C2=A0	if (tt->dma_address || flags->purge) {
> @@ -1075,7 +1097,7 @@ long ttm_pool_backup(struct ttm_pool *pool,
> struct ttm_tt *tt,
> =C2=A0			unsigned int order;
> =C2=A0
> =C2=A0			page =3D tt->pages[i];
> -			if (unlikely(!page)) {
> +			if (unlikely(!page ||
> ttm_backup_page_ptr_is_handle(page))) {
> =C2=A0				num_pages =3D 1;
> =C2=A0				continue;
> =C2=A0			}
