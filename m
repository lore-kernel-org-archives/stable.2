Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB2A517BAE
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 20:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790972840; cv=pass; b=cTbAi86Z4s5Ljs53ThNZXMiqGrLiNA19Aa3AzIOxKxzySoFBtqpXsQvwzTH90+96Xm+kDws+oqJjgFyn4QFGIVwtijP2khULWDgoN9mLU2xzfz3DzWLb/ihYhorC8PtHcF/7i+WvoehHM8NM0+GUr3rRHGRP1Dxb17M2Pq4eobY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790972840; c=relaxed/simple;
	bh=/E3jkSclwTqOe2Pbyuvbiu+LTKO0ibu6E9SAVsw4pUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y5hZPi0IkOoltVf14eZzfF7RxOpNIsQuHyeIoa0xSsXXX14P2x8pJ3haFy6kHLmaZZOxgN2nssNOpwfkXOelt9peoMpj4tDJbufuMmI18xQmbMVQIICSMbp+Yo4AkczQiI/EmZuABQ5tS+nTqQWnWFCImz2Fjq2/vib9SJd//DY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tk62CE8h; arc=pass smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tk62CE8h"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-33fb4680717so7205892eec.1
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 13:27:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790972833; cv=none;
        d=google.com; s=arc-20260327;
        b=aTG1Agbz/1jotrgw9KNf+m3+0vfEEBe36B8zhLyd/t5REXW82EstTlMgMaIStO3Qac
         UlLO1Eo2jJ4dpVSJ4xTgbBSNIfTEF32jwoCDay+nvG1e77K6wd5c/nkecZxU4ocjQfub
         1qcJJJ7AdWAr3g1xSg+pMcDt0TkZdk51JVAx9AiP1H4bUjpQtgOeTyV0Y5+ATXTnn2Rf
         PLvJDcZlxUsq3Pneza0IVtU5hAjEW/NRrU9QvdMaO8lmVCh4XG8+rAb8VsOFoFOqRCFV
         A2Cj28EsHDvh8No0LyfGGdTXFbwY15NYB1T1aex9a7R3NOesfhbw1J0mA48BKxXcU4Ti
         dXoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pxSWnSWRJ9M/USzaWwOGc1VbHfaj2Un/7bCqN3HRKO4=;
        fh=cv6F2xhZGf6UvZBnyDQ/eM3DBDA3/7GqIljLF/MtLBw=;
        b=V3QSRbelIRJyNx1Xpn3sX7R0VSP13EqtjZOCGBpm/1XcZU7pVl0MbTSMj8C/tvu+uC
         x5hq2x2E5nzRJSExFaCbtL/JRixcg4IK8kkpPboJS72ksX8UbPL5lG7krAwFm/ScxgDK
         kRwvG/PmfZVQmdX3TB6XoSx2vmz0U21fm01YPHyHbUDThvUg5hnMV6riCfkKX9qRhYrq
         eL6V9K15AZeTFbREi5/FkVUN0BtjnwWz3Spn+0N2agAR6zWTrXw0qIrxYK9ovslCOWHP
         LxnVUpQ3iaOukEPHCkLtb4t96aeH4YacD9+XmdcmhE6KdAcG6ct+eJunVZaf0b3Azi6d
         mlbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790972833; x=1791577633; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pxSWnSWRJ9M/USzaWwOGc1VbHfaj2Un/7bCqN3HRKO4=;
        b=Tk62CE8h5pkZF9r+jPy6KJ1o3+vu3JllDf8k8HjKGW4CEvL3xk6pjEB3nkHE0vIJot
         WJcSQvgMp9v4ci2laPsLLh+svgDgXLfAlgd3j/9UrVpW4pLxN2uFPmZ8GrVi+aFe07bG
         Bxh17SkTxJPKmd2Dz1JgTR5PFxsqkz6gac83Yn0j5OKPrGohN/CFyIU7zpUUkqQ725cc
         4RLXjAJ3rTV+dHx6WJl+1QOa58cDvXNKYzB5PPcQQHu1xslWIrTXKT8+7iV3Jh3Yrobq
         vxsoU9UIlRRXk04K0optLG7oFeh5ldsbVqvzX1E0E8xETtb5Zrl7iXw0MYVq2d5SlHpV
         fHMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790972833; x=1791577633;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pxSWnSWRJ9M/USzaWwOGc1VbHfaj2Un/7bCqN3HRKO4=;
        b=SAHapxxhj+0ODppZisRly1LeIYj/jnoU1h6cq7INine1fSSdgSX3wdz4VpYdFPxGbR
         xo/3D8kPFs3U+iuFsCT2Ux/CqUGrZpk0aSPpK+rWnUZb0wmxCpIbVHNRzzr/3EAsRkML
         TgaWX0MApupw5J9Zpd7rawtiu2l0mT1bP0Ezl5iJvU22nlh8tW4bgZVHlNmWhzR7RKbb
         lFaVggXtdGuo42dxokBIGms8vtKUKlYdPyF/S/s+avR9qpF+MM0JAbPzmhOE4Xl6XzM4
         2njJvOXd6kECQsERI+0Oj8p2ydLhHIg4yKHxcpqdVo6rVkGrQyUGtghM8yjK19LaaVYL
         dEPQ==
X-Forwarded-Encrypted: i=1; AKwUvBzi3EeeOO7ccLeMPdQ61hVd9cPBlbrZyhsJj2yr58oPa9Nf0ciWd6Y+c4ukEX9E66J4TiTO4PI=@vger.kernel.org
X-Gm-Message-State: AFq9FYK5ibxnz/il3YTxmwLzXp8qDnPoyAC71xyo2oSuuxgmV8uhjYXO
	nCPbM9RjF0JA7W9EovT6GUj5qFk3J4zKOsH0P0psi1gHh/hFiUAwCku1lVlwU8VrI2UVGbXYZIt
	P9as2f4GbEobvpYDFWbETSOlPuOIlrnk=
X-Gm-Gg: AYBFou2U7UpjriMP87Jz22Ho2zXQ/KrvqS5rVqNbgGfc8HoumWS5Pf63eOLgz9sb+E4
	49B7VfLeiCc4yIqgv57DVBexPXjRF9l/4liqjzp3MeksxJXSS/vcPT1+UkMq0UC5vLdCdQbF+xM
	xFTWhbtpeqOsAGnmRCvEgsg0y29FZ80xgGopS04BxZE+VQlJe7Y6SHFDUwvs/FcAw2kr5BslQkg
	fbdIkgVq0BZMLW9V5vt4ZXyQyhyh8ItDd8TVGQzfGeGeNs0gOaGacPtV4SqXTPnQw5DCTOe9D6V
	AnWa0MgHAM6QPzdjQVX2r21la+V2zzkUkPTHKYouxTiZUgLZChp06KT0KScvqXpI73Z/Dd9yfOW
	/pC35JFdkHwE=
X-Received: by 2002:a05:7300:d788:b0:34d:861c:99b8 with SMTP id
 5a478bee46e88-351116a0c6amr738247eec.21.1790972833038; Fri, 02 Oct 2026
 13:27:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825211819.100210-1-mauriciobellon@gmail.com>
 <20260825211819.100210-3-mauriciobellon@gmail.com> <CHXPR12MB99922037436C4ADE71BA82E152E5B12@CHXPR12MB999220.namprd12.prod.outlook.com>
 <CABNo9DcRfNQyw436eP_Y4PdbbwW7NTH3tfH0SB4st+uShFvtJA@mail.gmail.com>
In-Reply-To: <CABNo9DcRfNQyw436eP_Y4PdbbwW7NTH3tfH0SB4st+uShFvtJA@mail.gmail.com>
From: Mauricio Bellon <mauriciobellon@gmail.com>
Date: Fri, 2 Oct 2026 17:27:00 -0300
X-Gm-Features: AclHuK_CIfPFlIQiGSPAiToKVF5xWjKYzn1ROgmtUkXM-ukPSNc90K7QM4K-zcI
Message-ID: <CABNo9DeZNoJ+EW2Q2od29TD8LCmgrOg35DKKqsNA0ZJJ3g6FiQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amd/display: enable sink DSC before source DSC
To: "Zuo, Jerry" <Jerry.Zuo@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Lin, Wayne" <Wayne.Lin@amd.com>, 
	"Limonciello, Mario" <Mario.Limonciello@amd.com>, Mauricio Bellon <mbellon@lenovo.com>, 
	"Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>, 
	Rodrigo Siqueira <siqueira@igalia.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
	"Koenig, Christian" <Christian.Koenig@amd.com>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jerry,

Just a friendly ping on the DSC ordering question below. I'm currently
blocked on this before preparing the next revision.

Thanks,
Mauricio

Em ter., 8 de set. de 2026 =C3=A0s 17:00, Mauricio Bellon
<mauriciobellon@gmail.com> escreveu:

>
> Hi Jerry,
>
> Thanks for catching that, you're right.
>
> I went back through the sequence and confirmed that my new
> dp_set_dsc_on_rx() call runs in the pre-enable phase, before
> enable_link() performs DP link training. I had mixed up the requirement
> to configure source-side DSC before link setup with the separate
> requirement to enable DSC on the sink only after training.
>
> It happened to work with the X13 and monitor I tested, including the
> hotplug cases, but that clearly doesn't make the ordering safe for other
> sinks. I won't keep patch 2 in its current form.
>
> Would the right place for dp_set_dsc_on_rx() be at the start of the
> post-enable phase, after link training but before
> hwss->enable_stream()? Or should it stay in its current location after
> hwss->enable_stream()?
>
> I'll wait for your guidance on the intended placement before sending a
> revision. Patch 1 should be independent of this sink DSC ordering change.
>
> Thanks,
> Mauricio
>
>
> Em ter., 8 de set. de 2026 =C3=A0s 15:14, Zuo, Jerry <Jerry.Zuo@amd.com> =
escreveu:
> >
> > AMD General
> >
> > Hi Mauricio:
> >
> >      This change breaks dsc, causing black screen.
> >
> >      Sink RX dsc enable should land after link training. Writing dsc en=
able to the RX on an untrained link is too early, that should be done after=
 training. That is likely to be the main sequence regression.
> >
> > Regards,
> > Jerry
> >
> > > -----Original Message-----
> > > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> > > Mauricio Bellon
> > > Sent: Tuesday, August 25, 2026 17:18
> > > To: amd-gfx@lists.freedesktop.org
> > > Cc: Lin, Wayne <Wayne.Lin@amd.com>; Limonciello, Mario
> > > <Mario.Limonciello@amd.com>; Mauricio Bellon <mbellon@lenovo.com>;
> > > Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo)
> > > <Sunpeng.Li@amd.com>; Rodrigo Siqueira <siqueira@igalia.com>; Deucher=
,
> > > Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> > > <Christian.Koenig@amd.com>; stable@vger.kernel.org
> > > Subject: [PATCH 2/2] drm/amd/display: enable sink DSC before source D=
SC
> > >
> > > [Some people who received this message don't often get email from
> > > mauriciobellon@gmail.com. Learn why this is important at
> > > https://aka.ms/LearnAboutSenderIdentification ]
> > >
> > > From: Mauricio Bellon <mbellon@lenovo.com>
> > >
> > > Direct DisplayPort high-refresh modes using DSC and two-way ODM can
> > > commit without visible output during a 4K120-to-4K144 transition. A w=
orking
> > > 4K144 stream can also return black after long-pulse hotplug reconstru=
ction.
> > >
> > > The DPMS-on path currently enables source DSC before link enablement =
but
> > > does not enable sink DSC until after the source stream is enabled. Th=
is leaves
> > > the sink and source compression state ordered differently while the s=
tream is
> > > brought up.
> > >
> > > Enable sink DSC immediately before source DSC in the pre-enable phase=
, and
> > > remove the later redundant sink-enable operation near PPS packet
> > > programming. This establishes the order as sink DSC, source DSC, stre=
am
> > > enablement, and PPS before the compressed stream becomes visible.
> > >
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Mauricio Bellon <mbellon@lenovo.com>
> > > ---
> > >  drivers/gpu/drm/amd/display/dc/link/link_dpms.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
> > > b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
> > > index 48b086d15..412ce52b3 100644
> > > --- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
> > > +++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
> > > @@ -2635,8 +2635,10 @@ static enum dc_status
> > > link_set_dpms_on_pre_enable_link(
> > >          */
> > >         if (stream->timing.flags.DSC) {
> > >                 if (dc_is_dp_signal(stream->signal) ||
> > > -                       dc_is_virtual_signal(stream->signal))
> > > +                       dc_is_virtual_signal(stream->signal)) {
> > > +                       dp_set_dsc_on_rx(pipe_ctx, true);
> > >                         link_set_dsc_enable(pipe_ctx, true);
> > > +               }
> > >         }
> > >
> > >         if (link->replay_settings.config.replay_supported
> > > && !dc_is_embedded_signal(link->connector_signal))
> > > @@ -2729,7 +2731,6 @@ static enum dc_status
> > > link_set_dpms_on_post_enable_link(
> > >         if (stream->timing.flags.DSC) {
> > >                 if (dc_is_dp_signal(stream->signal) ||
> > >                                 dc_is_virtual_signal(stream->signal))=
 {
> > > -                       dp_set_dsc_on_rx(pipe_ctx, true);
> > >                         link_set_dsc_pps_packet(pipe_ctx, true, true)=
;
> > >                 }
> > >         }
> > > --
> > > 2.53.0
> >
