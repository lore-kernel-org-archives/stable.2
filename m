Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6953D4128;
	Wed, 29 Jul 2026 12:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785328569; cv=none; b=t5Om8IWOiFDCZ9SC8i5ZxaDAIqfX5n4hrB7+glE9dZ4+QwqDUdDBKj5lvfLkpz1Rfcv3T12H2QSU030tOOZvNuVg57kCmkEWo3pU6O/kwLifLbaa+4qbIhr4peSS8S7p7Ipcba4KwWezlZU9qE1qq9EWzMTp4xWMhlm/johMu0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785328569; c=relaxed/simple;
	bh=SuUSfgaNjoyz2PVdLRahrunDfQf8b7iHya9Riqbdr8c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NccrhXqaaGyd3HcMjE0bMA55DUTJp1R+1qs0uFA/AtJXQu4ZVeeR32+r/+iESB1fWxZHJ5K0doZotFomLoZyH6efzOELqc7rCxArsgPxSSP7txXNUwNG0QTd9UoADvJEY5xa6gr9Lzjj6va5QSlzfo2A5VkZDM3laaKIe18iJmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=RA5OEsBM; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="RA5OEsBM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1785328535; x=1785933335; i=spasswolf@web.de;
	bh=La3/EjeeiT/yepazPQRXS2mJezdgg47OaAIINry03EI=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=RA5OEsBMjjakoUO2uOurYWER9JhYdmoguDS+MIWC+7penyzYmgGxHYxdUaWforxH
	 N/xlSAzFyvgQjH4V1yWSchXBbePdlE2QXrDoITq+SUTS1bzgMp8Do5g8eN3RUeh/t
	 qBgW8O/0mWadg/R6XFVuAUWDuuI+k1EFzfTNcGjugrFe77SqIz0z/3UqOOIgYk+h6
	 p0SmwgL4Rlt2g5NnxdCWrWPIRdEN6yL7GdbyoYYWTf+J05WL1bg7H7gEKlphoSnvq
	 cFSdoXInceoihnka9AGJ37ufmH00LxVhrx/G0Dg32aCOWpHALfdG3S4o5rqBPPPr4
	 9HR2KhiKoicNu35nJw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MrwsB-1xKUa21Jxd-00aYy9; Wed, 29
 Jul 2026 14:35:35 +0200
Message-ID: <1ead313022bc62dce1f42af9f855727eb9074443.camel@web.de>
Subject: Re: [PATCH] drm/amd/display: fix usage of DC_FPU_{BEGIN,END} with
 PREEMPT_RT
From: Bert Karwatzki <spasswolf@web.de>
To: "mikhail.v.gavrilov@gmail.com" <mikhail.v.gavrilov@gmail.com>, 
	linux-kernel@vger.kernel.org
Cc: linux-next@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	amd-gfx@lists.freedesktop.org, "# = v7 . 1" <stable@vger.kernel.org>, Alex
 Deucher <alexander.deucher@amd.com>, Rafal Ostrowski
 <rafal.ostrowski@amd.com>, Mario Limonciello	 <mario.limonciello@amd.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,  Thomas Gleixner
 <tglx@linutronix.de>, spasswolf@web.de
Date: Wed, 29 Jul 2026 14:35:34 +0200
In-Reply-To: <ef1bc3d070c4156f1811c0c4a567ec98ac8fadaf.camel@gmail.com>
References: <20260727105059.75716-1-spasswolf@web.de>
		 <ef1bc3d070c4156f1811c0c4a567ec98ac8fadaf.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CKQk8lnl5lxRRlCkQJXPwtG/tj0XCbkh4W2VXTvOn/cPlF9gVNI
 lAZX8fw2b44gQaHg2hWKMa0573QZUIqeJoZ5WBRELIp61AG0OooRCtI8SpcqbIfFiCBM3ad
 jv7OVrcqyNbJQyvOzkjsLunXULmYJMznw5mLA6c+oSDQOGrh2KKDclGmh/2iars8UkGTG/X
 qVa3qSAuv6R7KvoDzZpew==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lBrE20jatY4=;mXE3W5iZh1Lpkwr6pi69WNWw6Iq
 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

Am Dienstag, dem 28.07.2026 um 05:51 +0500 schrieb mikhail.v.gavrilov@gmai=
l.com:
> On Mon, 2026-07-27 at 12:50 +0200, Bert Karwatzki wrote:
> > On PREEMPT_RT kernels kvzalloc_obj() can sleep because spin_lock is
> > converted to rt_mutex. dc_create_plane_state() can be called while
> > inside an FPU-guarded region, resuling in "scheduling while atomic"
> > errors on PREEMPT_RT kernels.
> > =C2=A0Fix this by calling kvzalloc_obj() with
> > DC_RUN_WITH_PREEMPTION_ENABLED().
> > Also fix the error path in dc_create_stream_for_sink().
> >=20
> > Fixes: 3539437f354b ("drm/amd/display: Move FPU Guards From DML To DC
> > - Part 1")
> > Link:
> > https://lore.kernel.org/lkml/20260723123449.6494-1-spasswolf@web.de/
> >=20
> > Signed-off-by: Bert Karwatzki <spasswolf@web.de>
> > ---
> > =C2=A0drivers/gpu/drm/amd/display/dc/core/dc_stream.c=C2=A0 | 5 +++--
> > =C2=A0drivers/gpu/drm/amd/display/dc/core/dc_surface.c | 4 ++--
> > =C2=A02 files changed, 5 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> > b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> > index dbc12640b01c..4ac835777b58 100644
> > --- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> > +++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> > @@ -233,8 +233,9 @@ struct dc_stream_state
> > *dc_create_stream_for_sink(
> > =C2=A0
> > =C2=A0fail:
> > =C2=A0	if (stream) {
> > -		kfree(stream->update_scratch);
> > -		kfree(stream);
> > +		if (stream->update_scratch)
> > +			DC_RUN_WITH_PREEMPTION_ENABLED(kfree(stream-
> > > update_scratch));
> > +		DC_RUN_WITH_PREEMPTION_ENABLED(kfree(stream));
> > =C2=A0	}
> > =C2=A0
> > =C2=A0	return NULL;
> > diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
> > b/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
> > index 88e825a6582c..d5c6427796b6 100644
> > --- a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
> > +++ b/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
> > @@ -85,8 +85,8 @@ uint8_t=C2=A0 dc_plane_get_pipe_mask(struct dc_state
> > *dc_state, const struct dc_plane
> > =C2=A0
> > *********************************************************************
> > *********/
> > =C2=A0struct dc_plane_state *dc_create_plane_state(const struct dc *dc=
)
> > =C2=A0{
> > -	struct dc_plane_state *plane_state =3D
> > kvzalloc_obj(*plane_state,
> > -							=C2=A0
> > GFP_ATOMIC);
> > +	struct dc_plane_state *plane_state;
> > +	DC_RUN_WITH_PREEMPTION_ENABLED(plane_state =3D
> > kvzalloc_obj(*plane_state, GFP_ATOMIC));
> > =C2=A0
> > =C2=A0	if (NULL =3D=3D plane_state)
> > =C2=A0		return NULL;
>=20
> Hi Bert,
>=20
> You may not be aware that the same allocation is already wrapped once,
> at the dcn32 call site:
>=20
>   183182235f6d ("drm/amd/display: Wrap DCN32 phantom-plane allocation
> in DC_RUN_WITH_PREEMPTION_ENABLED")
>=20
> That one only covers the dcn32 DML1 path, while your trace goes through
> dcn401_validate_bandwidth() and dml21 - so wrapping the call site could
> never have caught your case.  Which is a good argument for guarding the
> allocation in the callee, as you do: dc_create_plane_state() is reached
> from every DCN and both DML generations.

I did try a different approach, using DC_RUN_WITH_PREEMPTION_ENABLED furth=
er
upward in the calltrace (This would have the slight benefit of more code
running with preemption enabled). This does not work because dml21_utils.c=
 is compiled
as a _LINUX_FPU_COMPILATION_UNIT, so DC_RUN_WITH_PREEMPTION_ENABLED does n=
othing.
(see drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.h)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_utils.c b/d=
rivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_utils.c
index 835fece1d46a..8c92deded8cd 100644
=2D-- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_utils.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_utils.c
@@ -286,7 +286,8 @@ static struct dc_plane_state *dml21_add_phantom_plane(=
struct dml2_context *dml_c
        (void)plane_programming;
        struct dc_plane_state *phantom_plane;
=20
-       phantom_plane =3D dml_ctx->config.svp_pstate.callbacks.create_phan=
tom_plane(dc, context, main_plane);
+       DC_RUN_WITH_PREEMPTION_ENABLED(phantom_plane
+                       =3D dml_ctx->config.svp_pstate.callbacks.create_ph=
antom_plane(dc, context, main_plane));
        if (!phantom_plane)
                return NULL;
=20
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_mall_phantom.c b/d=
rivers/gpu/drm/amd/display/dc/dml2_0/dml2_mall_phantom.c
index 4543a60a0683..464bab9fc13b 100644
=2D-- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_mall_phantom.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_mall_phantom.c
@@ -769,10 +769,11 @@ static void enable_phantom_plane(struct dml2_context=
 *ctx,
                if (curr_pipe->top_pipe && curr_pipe->top_pipe->plane_stat=
e =3D=3D curr_pipe->plane_state) {
                        phantom_plane =3D prev_phantom_plane;
                } else {
-                       phantom_plane =3D ctx->config.svp_pstate.callbacks=
.create_phantom_plane(
+                       DC_RUN_WITH_PREEMPTION_ENABLED(phantom_plane =3D
+                                       ctx->config.svp_pstate.callbacks.c=
reate_phantom_plane(
                                        ctx->config.svp_pstate.callbacks.d=
c,
                                        state,
-                                       curr_pipe->plane_state);
+                                       curr_pipe->plane_state));
                        if (!phantom_plane)
                                return;
                }




Bert Karwatzki
