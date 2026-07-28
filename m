Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44841A6811
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 00:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785199921; cv=none; b=Jnwi4UYKTkQElDeL+D1ZM/xTWqwIIsNRBa4ydPN77hyR+faFU6xqTz8p4kh93uuesl1tiuuvqTag7VHWMG/4jb+gBrfIlrtjQaZsjM6/xe6BtwEB0EIdRa3ySNU7w/KTyHevuLATg76M6E5KMJ+qCxlyR4RvS9tWhctD45yhwpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785199921; c=relaxed/simple;
	bh=Z5GRTOSO0S9G9u7VZF3YwLNRY4a8OnVa7f57JM8Jl3E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Bc+kRma9EOJ6i1Sasxm8Whn+jHF+fqgtiHjn3Vw3aaWSng2NiRyKfXpQs7AsY8jEXCcGngjjsvY7S08G24vFoFY8bVzHoZnaT+WvRP3PtR9Tft79pDFUZOzXWV4X3+G02gMoC5bDN1CULLdW+/j6sljvecGJYTMDh0aJ0uW69Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=izMqkOr5; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="izMqkOr5"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5b013084dc2so2497553e87.0
        for <stable@vger.kernel.org>; Mon, 27 Jul 2026 17:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785199917; x=1785804717; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=YyiWxM0l+pV+N+P60T/IcxD0yZfdk4dsxpPoSCJ6HvA=;
        b=izMqkOr5JFmy/U1v9D9OCEyK+91238U8oTepcOD0103u9VQqrDl4zdDFZCbDKsu5of
         a4M0bNkVRNws/F3rVejHqxHHvwtox4fcxDMOd9LZzUMtIv8JpxkZ44vY253xIeHqO+yY
         ovxH4lgLNPX+GqVu1y0pH0orLx9A/Li9PdJElxUm2ryWLVgrB+xXtEZyqrGLs0QW53Kt
         C+OzDFUm+KgVqhTlSkc/0y/W/6iUkQFA+Haeb6UjoUk1WkZs9oXrtvUBQfxPRRh7Vk08
         JoRGPyM1XEfrEoS43COSVUtuDGwR8bEQDDnEwnvBsc58pDzh1wBKH3YtLy8YnVKrDPyh
         srUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785199917; x=1785804717;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YyiWxM0l+pV+N+P60T/IcxD0yZfdk4dsxpPoSCJ6HvA=;
        b=piYwdkrun2nqLxI628qRqcSlEgFUPUjSKCbiS4XkKiMvkm6A67gZqykfxL/MuWrh/J
         FUbfLPIPjUXE/hWpWLCcuw3YkbztUyR5Ep3ymIKRg3h13d0IfCAQ/Gl50CqGU9JXCpF6
         RwE39g7smTHRsnZDQc/8TewfVgr9gjrpu01FSVgd8yrL63GGio1rP6HBZMgxyQeCyIlD
         xlDVrRliZWLUeZhaPGUqQKP1vd8AL4n5q8KHt1GRFGoECGUpA23VUaRhymGj9qqFJAlp
         41wXQLC0/RzpXYjM553RTFYdF633qI+8kSyKwdqQMKmnBUTt491Zjr95oqEvUkhf698x
         IV/w==
X-Forwarded-Encrypted: i=1; AHgh+RpsN+5S+EjZnVmzMBfUDIppFl5aneQ9xBhHD+gEW3bqZ174UrL0ZgirecS39gUGNtEpFOwlIc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG9GmQxZ8SEla0Xd7ij/hFtaydS/twfR7yHtiH9n2/50n/o4tj
	DS0cNDe0tVT0HlJoEc+KLEJz05YakhnpW6RvGm6LZuAGofOgNVMmHDCD
X-Gm-Gg: AR+sD10zWWbxowUCJ/E8gL5h5Fo3iR6Oy/a//b7VCPkjj+3qBmqIb5qhw788V3dc32T
	okhQbgoU0fP9hkTJ8Qikt578ESe/S5lHzKh9eqa3GNIQJMycrGybQ9Vge0LCTPP7lwiYLmXwMv5
	jQoRMQBPS5jdTxaMASH9AgKf1gFMRGO/rEFDOfFgI5Q4JkR4giJgtNu09Q6hZtPg0B3gsMsJwwW
	0gOWeAXcHNhtt0olrVMeJf/iY3rqj5KAjVSu3Cwr0h5HgB266Hq+ObTBRtlOcTAbHzAJl1Ft+kv
	bsLcz+NuGUCFj0pE59zUpwp/U/qTMmnxLObM8siZMjYHOPi39Sn5ZIWDx9M82WqfPhzYhp2zSfp
	g8r0MgdLfG36GaEY/Bp1LWS+7Ee+DWa/vbTX56O5gt2kINB2UU9Dv5TP81bPLFSdiHR85HwlrCn
	FrtiwxCoxjmoLHQ02/5S/0
X-Received: by 2002:a05:6512:3407:b0:5b0:197b:9811 with SMTP id 2adb3069b0e04-5b2d023bef9mr31905e87.53.1785199916589;
        Mon, 27 Jul 2026 17:51:56 -0700 (PDT)
Received: from primary-ws.local ([188.234.148.119])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b2be077c14sm1758822e87.1.2026.07.27.17.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 17:51:55 -0700 (PDT)
Message-ID: <ef1bc3d070c4156f1811c0c4a567ec98ac8fadaf.camel@gmail.com>
Subject: Re: [PATCH] drm/amd/display: fix usage of DC_FPU_{BEGIN,END} with
 PREEMPT_RT
From: "mikhail.v.gavrilov@gmail.com" <mikhail.v.gavrilov@gmail.com>
To: Bert Karwatzki <spasswolf@web.de>, linux-kernel@vger.kernel.org
Cc: linux-next@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	amd-gfx@lists.freedesktop.org, "# = v7 . 1" <stable@vger.kernel.org>, Alex
 Deucher <alexander.deucher@amd.com>, Rafal Ostrowski
 <rafal.ostrowski@amd.com>, Mario Limonciello	 <mario.limonciello@amd.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,  Thomas Gleixner
 <tglx@linutronix.de>
Date: Tue, 28 Jul 2026 05:51:53 +0500
In-Reply-To: <20260727105059.75716-1-spasswolf@web.de>
References: <20260727105059.75716-1-spasswolf@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.61.1 (3.61.1-3.fc45) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-07-27 at 12:50 +0200, Bert Karwatzki wrote:
> On PREEMPT_RT kernels kvzalloc_obj() can sleep because spin_lock is
> converted to rt_mutex. dc_create_plane_state() can be called while
> inside an FPU-guarded region, resuling in "scheduling while atomic"
> errors on PREEMPT_RT kernels.
> =C2=A0Fix this by calling kvzalloc_obj() with
> DC_RUN_WITH_PREEMPTION_ENABLED().
> Also fix the error path in dc_create_stream_for_sink().
>=20
> Fixes: 3539437f354b ("drm/amd/display: Move FPU Guards From DML To DC
> - Part 1")
> Link:
> https://lore.kernel.org/lkml/20260723123449.6494-1-spasswolf@web.de/
>=20
> Signed-off-by: Bert Karwatzki <spasswolf@web.de>
> ---
> =C2=A0drivers/gpu/drm/amd/display/dc/core/dc_stream.c=C2=A0 | 5 +++--
> =C2=A0drivers/gpu/drm/amd/display/dc/core/dc_surface.c | 4 ++--
> =C2=A02 files changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> index dbc12640b01c..4ac835777b58 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> @@ -233,8 +233,9 @@ struct dc_stream_state
> *dc_create_stream_for_sink(
> =C2=A0
> =C2=A0fail:
> =C2=A0	if (stream) {
> -		kfree(stream->update_scratch);
> -		kfree(stream);
> +		if (stream->update_scratch)
> +			DC_RUN_WITH_PREEMPTION_ENABLED(kfree(stream-
> >update_scratch));
> +		DC_RUN_WITH_PREEMPTION_ENABLED(kfree(stream));
> =C2=A0	}
> =C2=A0
> =C2=A0	return NULL;
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
> b/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
> index 88e825a6582c..d5c6427796b6 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
> @@ -85,8 +85,8 @@ uint8_t=C2=A0 dc_plane_get_pipe_mask(struct dc_state
> *dc_state, const struct dc_plane
> =C2=A0
> *********************************************************************
> *********/
> =C2=A0struct dc_plane_state *dc_create_plane_state(const struct dc *dc)
> =C2=A0{
> -	struct dc_plane_state *plane_state =3D
> kvzalloc_obj(*plane_state,
> -							=C2=A0
> GFP_ATOMIC);
> +	struct dc_plane_state *plane_state;
> +	DC_RUN_WITH_PREEMPTION_ENABLED(plane_state =3D
> kvzalloc_obj(*plane_state, GFP_ATOMIC));
> =C2=A0
> =C2=A0	if (NULL =3D=3D plane_state)
> =C2=A0		return NULL;

Hi Bert,

You may not be aware that the same allocation is already wrapped once,
at the dcn32 call site:

  183182235f6d ("drm/amd/display: Wrap DCN32 phantom-plane allocation
in DC_RUN_WITH_PREEMPTION_ENABLED")

That one only covers the dcn32 DML1 path, while your trace goes through
dcn401_validate_bandwidth() and dml21 - so wrapping the call site could
never have caught your case.  Which is a good argument for guarding the
allocation in the callee, as you do: dc_create_plane_state() is reached
from every DCN and both DML generations.

On dcn32 the two wraps now nest.  That is harmless, because
DC_RUN_WITH_PREEMPTION_ENABLED() is conditional on dc_is_fp_enabled():
once the outer instance has left the FPU region, the inner one expands
to a plain call.  But it does make the dcn32 wrap redundant, and I
think it should be dropped in a follow-up now that the allocation is
guarded in the callee.

One thing that may be worth adjusting in the commit message: this is
not only a PREEMPT_RT problem.  183182235f6d was needed on a plain non-
RT x86 kernel. There DC_FP_START() takes fpregs_lock(), which disables
local softirqs, and dc_plane_state is around 335 KiB, so kvzalloc_obj()
falls through to the vmalloc path and hits BUG_ON(in_interrupt()).  So
on RT any allocation inside the FPU region is illegal, while on non-RT
it is specifically the large ones - two failure modes, one root cause.

About the FPU register question raised by the review bot: as far as I
can see it applies to every existing user of
DC_RUN_WITH_PREEMPTION_ENABLED(), 183182235f6d included, so it looks
like a property of the macro rather than something your patch
introduces.  An answer from AMD on that would be useful either way.

I have dcn32 hardware here (RX 7900 XTX) and can test the patch on
non-RT if that helps.

--=20
Thanks,
Mikhail
