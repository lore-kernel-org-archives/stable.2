Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE5D2EFD9B;
	Fri,  7 Aug 2026 14:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786111242; cv=none; b=Fcf+wG6fVnuyg9TOqPU2+cfsZUqw2ynskDrt49ORhGRDUCmEv+G2H5whkUNMB2oAURYyoRxFLD6vYt09uoivN4O1wnDJvBZkRxdQW6RRGMNEDg9lFhECn0IPNwivp7QpFp1elhoE7dOc0txqXTSiM2tRszTL91ezqBESGaO59pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786111242; c=relaxed/simple;
	bh=RKKDMvicEIoSk9m1DECOyPqK5E4m382ttP6I/dYe6v0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z6v9LP9Y0x/DT7ifVXcteKpT8sgPIxmXcsW1PY8ncSr7nqnFsDEn8ngHu7veKd8zhD2Bi9ll3pwjWj+IzZu+8uo4rF/cX3AtnsDiWsprjMmHQWynv2CGh3Fwtud77VjJ4FqkVK40kvy1RV208BmTGP75IgteqptKRROo3hOyVUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=Sn7NB216; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BHBxlMqn; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="Sn7NB216";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BHBxlMqn"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 59B361D000E1;
	Fri,  7 Aug 2026 10:00:37 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 07 Aug 2026 10:00:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1786111237; x=1786197637; bh=DJAZw34dtz
	rwkk0TYe0dNbIpi34f2Kh0DKaC/Xc8flc=; b=Sn7NB216OMhW5xjXF+Sb71qGvH
	jPNsxpdxD3TFNCLKPKZP94iozweg8VVRk2oyCwqCPBtn+wRuISIgETcykpzRafin
	7YJ+Gd8+0x0DT/0ydUCKUkGKkQVRRsMqLzloTvoJGIZ++rmpt5y3fhkN7zSJFH0l
	7FpcRipNkGTrV9F6h7r2eWpUGpZc30p8IrSETTElEb/ds1mbJHpGPch9oxJsXr61
	IK/f2Opm/z4JnarWAzjHj+lkWywKYQ0ZllpPzv7dbro7CaG2/eGzmL6kubp89eew
	fOb2PzwasMj//L8vyh8Q7szrvovp92+y08urS12NbRk6S5l1+54KZuFJ9pGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786111237; x=1786197637; bh=DJAZw34dtzrwkk0TYe0dNbIpi34f2Kh0DKa
	C/Xc8flc=; b=BHBxlMqnb4dkIlK8sm4MY+WS96pcPDg1fIPRtEvNZlIVh4N7L0O
	tIdFe/XpIGpWcCzVsY1FbMlfp9ZiDYaEOh/CevstyJz9zVuW4KDYcGC1jeoYFIbl
	wEaq46nwkmK5wt/6Q90Dd6mSYTTSMwmPvyKkbBOIXAO+5P9N+DZ7wZS0E4s+T8CK
	+OIN1kXIRMYI4LuczkBGryYz0DyFfc+jczto/dfFowCAgCcQVwjtY98VE/wL5fKP
	1EMrjrFobhnDKcUjbier3J1gZtP/Y+gi9xZvaLEZhqPOc80aUUL0Sk79TDIIUuk8
	ZlbYEIPzFIfnRRoU5Gzddrd9VnXIyd6TDvw==
X-ME-Sender: <xms:BOV1agoxdfglcapzl9fXIKBSPRnL_FNSnIgGcgoBeizrwexZUFEg2g>
    <xme:BOV1amhcDxYQ90GSnfcJu8Ww69vEoJ5LPTA6pjHTa7q-zbeLKmasiLwHR2htrLINO
    B30iJZfogAYaYZAQeAUzJPMceSb6ExVaxaqq9ZEJ2UnK54JIQI>
X-ME-Received: <xmr:BOV1aijPR-hOX2F0C5rjpLiFrrwXOq-3Xbld9cMp6wS5GFYJ911LskiK-OLun3nQvruXCeebYxruUpfkQAXijo7Jdm9JkZPbZPvw2oyW-H0>
X-ME-Proxy-Cause: dmFkZTE75DRO/Pukjqn4DdkcNqksdu5oMMCOWbuKrjBeOaPob5+OCoG2vNxkHcFNstSHMA
    oWuPYXkMaLgPCZoU1o+rC5nM9rrk0Uuv3eLxmyjiGrkUIH0p0xyCTdFajpfxMT7IUZOgM6
    idXWasNXKz4+PLdfB/Uw3I/IKQFNBmDIsBFUmOF6qtBMPT8zYbzCXI6CeerFi/IeeSIu3F
    35WCv2vIP5nZhml64loCsGzzsplVd8K1AebEHclA3Rq5Ax20qYTAaOkNzIerVnxmXIzehS
    iRUe8OZ2cQVZfsXYTH45srpQ0TnPOydhwuyKacNXr9rPQwK6b/UGhPR1Fn6D3G4gsIZHHh
    z6Zl271iIMXbm+H4Vu1k7ApGfDGFyqE9V57iH62zraPoAdnfAPshtSoH4oF7g+aLOpIHKw
    3q6jswCdi+fxQ0Y6v1JvhZlvE8WdX9jlr0JRyDGLCrBJafyPnI59+aHwLV2JtvC6Ec1NeF
    wSdbqxTJCTZhD9lDqr/FBDOaVYWorJHRyFw9bHffkosHjozODxwJEErun6mRivTVzvslF/
    gEZf1AQ1nrP8jyzzQ0BtBKmKNgzR69cgGXkYPje2T8oPUXQbss2pR5OqHrx4KFr9p8Kueh
    5ZofMbL2+gMWQqruF09GCBhws6N4EM+Q0qV2sQqFhZkcbpA08ZeIXjU/t9IQ
X-ME-Proxy: <xmx:BOV1akHbQftCG-95noW6kq7GJup35lnXCKkK2x5jIwUZoUDdjWGZbw>
    <xmx:BOV1atCVetoYaPiaeP7d-1U7cwD8ltNRw2mjyQzesBsZy99rEEmpsw>
    <xmx:BOV1ao_vZPfWiP8XOg584c2QR79-d90L6RYAEWufFkfdCHg4gUxXlg>
    <xmx:BOV1aog1Wf0NnJCZ4VTmp-MtA5dEZFZ6TstxEi3OZk9pahWoPqt8zQ>
    <xmx:BeV1agfxpLxd-1iPcPjC-j_KlGtEoiO_NIcQsmi5UjdlGAPehUCxI6eB>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Aug 2026 10:00:36 -0400 (EDT)
Date: Fri, 7 Aug 2026 16:00:19 +0200
From: Greg KH <greg@kroah.com>
To: Bert Karwatzki <spasswolf@web.de>
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, amd-gfx@lists.freedesktop.org,
	"# = v7 . 1" <stable@vger.kernel.org>,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Rafal Ostrowski <rafal.ostrowski@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v7.2-rc6] drm/amd/display: fix usage of
 DC_FPU_{BEGIN,END} with PREEMPT_RT
Message-ID: <2026080712-grandma-scrooge-9ba3@gregkh>
References: <202608061233.eufnR5Qm-lkp@intel.com>
 <20260807124944.154232-1-spasswolf@web.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807124944.154232-1-spasswolf@web.de>

On Fri, Aug 07, 2026 at 02:49:42PM +0200, Bert Karwatzki wrote:
> On PREEMPT_RT kernels kvzalloc_obj() can sleep because spin_lock is
> converted to rt_mutex. dc_create_plane_state() can be called while
> inside an FPU-guarded region, resuling in "scheduling while atomic"
> errors on PREEMPT_RT kernels.
>  Fix this by calling kvzalloc_obj() with DC_RUN_WITH_PREEMPTION_ENABLED().
> Also fix the error path in dc_create_stream_for_sink().
> 
> Fixes: 3539437f354b ("drm/amd/display: Move FPU Guards From DML To DC - Part 1")
> Link: https://lore.kernel.org/lkml/20260723123449.6494-1-spasswolf@web.de/
> Signed-off-by: Bert Karwatzki <spasswolf@web.de>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_stream.c  | 5 +++--
>  drivers/gpu/drm/amd/display/dc/core/dc_surface.c | 5 +++--
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> index 7666cdc78f4e..a5a304a3f802 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> @@ -233,8 +233,9 @@ struct dc_stream_state *dc_create_stream_for_sink(
>  
>  fail:
>  	if (stream) {
> -		kfree(stream->update_scratch);
> -		kfree(stream);
> +		if (stream->update_scratch)
> +			DC_RUN_WITH_PREEMPTION_ENABLED(kfree(stream->update_scratch));
> +		DC_RUN_WITH_PREEMPTION_ENABLED(kfree(stream));
>  	}
>  
>  	return NULL;
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c b/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
> index 72845fc788f3..04982673ffbc 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
> @@ -33,6 +33,7 @@
>  #include "dpp.h"
>  
>  #include "dc_plane_priv.h"
> +#include "dc_fpu.h"
>  
>  /*******************************************************************************
>   * Private functions
> @@ -86,8 +87,8 @@ uint8_t  dc_plane_get_pipe_mask(struct dc_state *dc_state, const struct dc_plane
>   ******************************************************************************/
>  struct dc_plane_state *dc_create_plane_state(const struct dc *dc)
>  {
> -	struct dc_plane_state *plane_state = kvzalloc_obj(*plane_state,
> -							  GFP_ATOMIC);
> +	struct dc_plane_state *plane_state;
> +	DC_RUN_WITH_PREEMPTION_ENABLED(plane_state = kvzalloc_obj(*plane_state, GFP_ATOMIC));
>  
>  	if (NULL == plane_state)
>  		return NULL;
> -- 
> 2.55.0
> 
> Fix for stable with the old error handling in
> dc_create_stream_for_sink() and compile fix form arm64/clang.
> 
> Bert Karwatzki
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
