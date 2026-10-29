Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793274410;
	b=vqqn19V8w5QKFMnvcjNGbkpl0hwCPheLK48jIk3mGhenA9Nc1K/cmKC14Q44NDTHes5V
	 um16QC+/ZDEDmaTZ9j4dWHsCZGvhk0KSX3ot0JZ81zI2vge4G4B70nhdH+8DlsIH0h74i
	 OvC+sMSkuVh6rFAz9VFGliTgbUlWons9RVOMzBb/pwm+MGx9QDyM8rIZ9W6ErqeVmuJTg
	 +GSIFkUyUm8XeMf/lu22myMZfEfSYjyNAEjeCSnSfNxIi7R7f3ABHHTfwouWdomIiA7ce
	 ThXh8Sz/zRHNglykCPVav5L9AhbColOYsmfO8DDkvv+pAaege3rLOTakNnqk+bGZAVQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793274410;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=riFBiDySsld/0Y1PSfvBfA5dP3L6lbgdUG897qeFids=;
	b=JbQ7epiOCDUm8zoJYrnte57FmbqQ2DbKOMlH8UzMCJoF0b1hhdkjBmE7UhbfZ0roNa+R
	 RpR8dKSaOzU2U4zIif79xLpxdYYk6IXQV162Z1YhtwIAKwZIBzTRQvtMh0U/ESXd8Oe/V
	 YPOESlmGp7eNngV3kdqnvEws21OjWUt+bJzulvvslcKYynQns9wuHDT56CM+0Y04EGAkt
	 yUXA/f6r82ds9EEvVBACQDdkj9d06vdGZGC5Js5LvQUBqbrecWCOei8hVaQaeJK+lG2VF
	 KArF54jox+GGNbg/rrTP5SglstPx39DXTGI64hcx4FLiByfHCVp0YRxmuviIqRxhBsQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=neat.no;
	spf=pass smtp.mailfrom=neat.no;
	dkim=pass header.d=neat.no header.i=@neat.no header.a=rsa-sha256 header.s=google header.b=UNGBejL3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.178
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35690606A31A
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 11:46:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35690606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=neat.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neat.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=neat.no header.i=@neat.no header.a=rsa-sha256 header.s=google header.b=UNGBejL3
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8b056d58f2aso19191507b3.2
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 04:46:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793274408; cv=none;
        d=google.com; s=arc-20260327;
        b=rsQ4BaZdM+nzR+okK0Mnc2mLrqQDZK4nk4oagjCHlzAqGJhbGY7RZBDbg2MlPZi08r
         bQCUgsT7JWk3S6i2CgD/u0EuHLPH5NY4oNOhzuSVUFhVyvWX+tjA67e2gmJ+Ob71v3zM
         0IW0DVjk3kvMlc7n3Q8HWomnnfBJndEYqDplkAlovrK3yB/I0g0F00Fc7S0W80FuzqYH
         B5LlNhZGjtNRHjns1j85v8poJHUMno1Za34WhuFMBE7D6Mkc1aZLUGYdf3BuPvRKWMXr
         ksoWpL5XyZtLZT2v9DngSgrHfv1EsrIkkwC3cRRfiP5azVwpGUO3O/X/tAqAw37PdieQ
         hCBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=riFBiDySsld/0Y1PSfvBfA5dP3L6lbgdUG897qeFids=;
        fh=WWCoTjjtnOUWcJcj07X2dSwuNvyJD4jbdtVIVvgaKoo=;
        b=sooLbTaEX8qlof/MT4EcT/CfUCvQWPnTV6p+R7/jCvpQd8sF9AIojRsitcTLqwDtEu
         dz/Ef02X00+YCO4yEtenu5yIBTmHmygv6QAaXQzulF6H7AnQ3Tpo9Vx3Yi/gHDcaDlbL
         yHvF9MVaS0iDp9UJ0U8PM8oSzjrPPWZiVLiIQxN3u7kCBCdFtnICoVOOiPY4W3uvKtLB
         b//5iIv88/joB1Wtzio4uCFqbGlhp4gCrbB01CeEKWuupOxlDHaptU4swngvuDDSA8iW
         LekTmv+gzuE2BPJCpUFhlIv2vCVhvrblIzqa/C33Bu4QJ39Sx31FTHQY5zz1n8AI1OvZ
         Z70w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=neat.no; s=google; t=1793274408; x=1793879208; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=riFBiDySsld/0Y1PSfvBfA5dP3L6lbgdUG897qeFids=;
        b=UNGBejL3/YdG8ePaXjDTiRKcTUKWi6gcMpckNIKbBO53r1O6756+iqg09scmbh68p8
         FJfbJvLxT8Nk18ak4tH4o82K5MOHt8IL65zSsCkYq842OkU0VujUDGJTy9SkBB3zroOL
         5uy/W4Qn4WRSvLUDttkxpibfwfvUX8h9ozDpHh/rjTSGB9e1XXNNWpeGak86YFGXNCwj
         iCb6/B8h0rWWorD/5YBlifT1kvYyEcUtKuCWzwxbLix9Z12uxEc9fb2Uhgv2H6dmltv9
         HccQCX9VSIMwg3j7awqtcHpHOk71EZfCTeP7IanPnMs7zS4WJm+ziAJ0n3J2slJw95Kc
         771g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793274408; x=1793879208;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=riFBiDySsld/0Y1PSfvBfA5dP3L6lbgdUG897qeFids=;
        b=Og8kR7UIluT8iMFveJO/p3HTlpUOuLSIXfxX7RSM0TYQ+EzAcGY+uGM3kRQvTQQ0WC
         6ARvq4NWBmg5K/deno9NV9vFwvg3fHywlUSKeJEy6gjeGhhGUpB0B0DSBKUoFNzs8Dix
         Sbz3nj4Jh+OBWFyP7+iwyxZ47kw4aXY52qkM/z1fc81zO1MHvSNaQJySFydjB0KBtkCE
         fOcp3MubXNe9dKFUQIydzo9j8D7E85pnQXrPi27p0KePUQJvovKGVAo0n/maFG05V4sR
         zrvaxOodaPFtk806wbYhEQ4bcyEmPM012ICDW2Wm9YLAOfeIw0y7jBwA9PAGJlT4mWtl
         0oaQ==
X-Forwarded-Encrypted: i=1; AKwUvBxwJdVZnYA7g5AzYPLju032mURSZ4s1wj1qsiWRxvhdQ7xVjXrhV1CxVuuDh1gao+uqkSYR6JY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKDK6VA5RYHRX+A2ioWOidFWWuYHIAuap4GyvjtoG+usVL/bBSn
	iciGyufN2Uwqx+xrnnh/bgjWbFA2x0wipO1z/l7fyLqqObHDXfKtem27E0GAgkldRua2Ks6nvcX
	62hWvnFvP4+RRH8ehP1bk3DT6pCrboQQloBkdxyun7fOOCTWwXN7QVKS7O03kzMGhXTRYDRM2AW
	uaZIy56ZDbiAxtXzWp2rtKE93ynx+akFGJDS82bgFhJuxlARr6rEqIyXWqngMxwUQiVwWwRaXmg
	JqZnJS4YMPcpU+meo9+rADByDPFczEHENPPzwk6hCpXCauXe++C+A==
X-Gm-Gg: AYBFou39psIzaXomj0d2up5jJBwkg9iwtks4K0KXZDNen/W728ynwrP3WNVyd5Dm8IQ
	L6BmIpI/aWVybFjxwRw5ntz8FG8e/9WSZQ6D63JVTdLljmfBwI6FHE5/nAC7pfp7T4/PBOQoU2S
	zb7AXSCIYSbLfR5qaHUHTS6jg86Q173ft9KYBOlZu1kk26pJeAaI2GHlGI0CZX9/a/bdN8IcULY
	XePogGYiqq7YpLw53wdRw51Xry+UIWxLJMAaBDoqF/V9yA+4nVMsqZEOQ6m8C6w9A8Mqzm369I+
	HZ9WUbDdLzrUOvAlDfoPxEdJrMjmDAiI7ZwBVqJDzCyEsvFMYdDgPzaDudllNm3gTpgMhPZquCD
	q6+mqc08G8ii7OroxVk/vTo8QDGLBMrQyWhdOLSwpWZWUQInxrMUha/Ky
X-Received: by 2002:a05:690c:ec3:b0:8b1:9c2:87d2 with SMTP id
 00721157ae682-8b1b5c83536mr37789387b3.73.1793274407861; Thu, 29 Oct 2026
 04:46:47 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026164028.78792-1-lucas.tanure@neat.no> <at_4EgWZFghkRHzH@collabws.localdomain>
 <a8b9450f-af4b-47bf-b7b1-3b326ed52dfc@igalia.com> <CALt7t=Ef9LS5vNOZq7JGZ1n-L5rgMk7mXBGE66jicfdkqAC35g@mail.gmail.com>
 <a054e9e4-304a-427c-b78f-973fd06f1199@igalia.com> <f534555a-b62f-4bf9-96cf-ebd74b4b30f0@collabora.com>
In-Reply-To: <f534555a-b62f-4bf9-96cf-ebd74b4b30f0@collabora.com>
From: Lucas Tanure <lucas.tanure@neat.no>
Date: Thu, 29 Oct 2026 11:46:35 +0000
X-Gm-Features: AclHuK8RskCuC8Hdfkuek5FOUrJUlV6Oh_eeADhyjfk2iiUYXH6Ab5jF-a3wR7k
Message-ID: <CALt7t=GBa=9G-qGfTLohrcJaNApE_=Pc3TMD0jjTOiDevOP-kQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] drm/vc4: hdmi: enable scrambling before the TMDS
 clock starts
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Maxime Ripard <mripard@kernel.org>, Dave Stevenson <dave.stevenson@raspberrypi.com>, 
	Dom Cobley <popcornmix@gmail.com>, 
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 8:19=E2=80=AFPM Cristian Ciocaltea
<cristian.ciocaltea@collabora.com> wrote:
>
> Hi Ma=C3=ADra, Lucas,
>
> On 10/27/26 3:58 PM, Ma=C3=ADra Canal wrote:
> > Hi Lucas,
> >
> > On 27/10/26 10:53, Lucas Tanure wrote:
> >> On Tue, Oct 27, 2026 at 1:07=E2=80=AFPM Ma=C3=ADra Canal <mcanal@igali=
a.com> wrote:
> >>>
> >>> Hi Cristian,
> >>>
> >>> On 26/10/26 22:23, Cristian Ciocaltea wrote:
> >>>> Hi Lucas,
> >>>>
> >>>> On 2026/10/26, Lucas Tanure wrote:
> >>>>> HDMI 2.0 asks the source to set TMDS_Bit_Clock_Ratio in the sink wh=
ile
> >>>>> the TMDS clock is stopped and to start the clock at least 1 ms late=
r.
> >>>>> vc4 writes the bit, and enables the scrambler, at the end of the en=
able
> >>>>> sequence, long after the PHY has started, and clears it before the =
PHY
> >>>>> stops. A sink that samples the bit when the clock appears never loc=
ks
> >>>>> a 4K60 signal from a Raspberry Pi 5, while laptops that follow the
> >>>>> order work on the same sink.
> >>>>>
> >>>>> Patch 3 is the fix. Patch 1 is needed on BCM2712, where phy_disable=
()
> >>>>> was an empty stub upstream, so the PHY kept running after disable; =
the
> >>>>> Raspberry Pi tree has carried this since 2024. Patch 2 fixes a
> >>>>> pre-existing race in the scrambling work cancel that the fix would
> >>>>> otherwise make easier to hit.
> >>>>>
> >>>>> v1 was tested on a Raspberry Pi 5 running the Raspberry Pi 6.18 ker=
nel
> >>>>> with the same change applied, against the sink that showed the
> >>>>> problem: plain enable at 4K60, 1080p60 to 4K60, 4K30 to 4K60, a sin=
k
> >>>>> reset and a sink power cycle all lock with zero character errors. v=
2
> >>>>> and v3 carry the same code; the hardware test of the final form is
> >>>>> still pending and will be reported in this thread. Mainline was not
> >>>>> booted on the Pi 5. The BCM2711 path is unchanged except for the
> >>>>> enable order; I have no Pi 4 at hand.
> >>>>
> >>>> While converting vc4 to the common HDMI 2.0 scrambling infrastructur=
e, I
> >>>> ran several tests on the Raspberry Pi 5 and didn't notice any (obvio=
us)
> >>>> issues.
> >>>>
> >>>> Hence, could you please verify whether your problem reproduces with =
a
> >>>> recent mainline kernel?  If it does, could you also give [1] a try a=
nd
> >>>> report back the actual behavior?
> >>>>
> >>>
> >>> I suspect you didn't hit this on mainline because vc6_hdmi_phy_disabl=
e()
> >>> is a stub, so the TMDS clock never stops between disable and enable.
> >>>
> >>> Best regards,
> >>> - Ma=C3=ADra
> >>>
> >>>> [1] https://protect.checkpoint.com/v2/r02/___https://lore.kernel.org=
/lkml/20261014-vc4-common-scramb-v3-0-c68d58d959a2@collabora.com/___.YzJlOm=
5lYXQ6YzpnOmQ1ODUyMWJlOGIwNzJjNjNmOWRiMDk3ZmFmYWFkNDliOjc6YTM1MTpiMzBiNzY3O=
DAyMzBkOGM2M2U0ZjRjMTY2MzE5ZjVhZWZjY2QxYmRjZDBlOWI4MzI0MGYxMjkyNjQ1Y2NkNzJi=
OnA6VDpG
> >>>>
> >>>> Regards,
> >>>> Cristian
> >>>
> >>>
> >> Hi Cristian, Ma=C3=ADra,
> >>
> >> Tested on a Raspberry Pi 5 with the Raspberry Pi 7.3 tree [1] as base
> >> (pure mainline panics at boot on this board).
>
> I recall encountering this issue a while ago and spent significant time
> bisecting.  The faulty commit was d87773de9efe1
> ("clocksource/drivers/arm_arch_timer: Default to EL2 virtual timer when r=
unning
> VHE"), introduced in v7.2-rc1.  Reverting it restored the normal boot.
>
> Note this was later addressed via commit 94f39e4c017e
> ("clocksource/drivers/arm_arch_timer: Workaround bcm2712 broken EL2 virtu=
al
> timer"), part of the v7.2 kernel release.
>
> Which is the mainline version you've tried?

Master at 6b4b543fa187 ("Merge tag 'parisc-for-7.4-rc1'",
v7.3-16411-g6b4b543fa187), so 94f39e4c017e is already in. The panic is
something else. I had no serial console on that boot, so I have no logs.

>
> >> That tree carries
> >> vc6_hdmi_phy_disable() implemented, so the clock does stop on disable.
> >>
> >> 1. plain rpi-7.3.y: 4K60 never locks.
> >> 2. 7.3 + my patches: all lock.
> >> 3. 7.3 + the 7.4 scrambling infrastructure + Cristian's 9 patches: sam=
e
> >>     failures as in 1.
> >> 4. same as 3 + drm_connector_hdmi_enable_scrambling() moved before
> >>     phy_init() and drm_connector_hdmi_disable_scrambling() after
> >>     phy_disable(): all lock, zero errors, picture on the panel.
>
> Thanks for testing all this.
>
> >> Ma=C3=ADra, I also tried 3 with vc6_hdmi_phy_disable() emptied again, =
as on
> >> mainline: same failures as in 1. So the stub is not what hides this.
> >> Cristian did not see it because his sink re-evaluates
> >> TMDS_Bit_Clock_Ratio after the clock is running and forgives the late
> >> write, as most TVs do. Ours samples the bit when the clock first
> >> appears and never again. So to reproduce the issue you need a strict
> >> HDMI input.
>
> Yeah, that's probably why this issue went unnoticed - most displays are p=
retty
> tolerant and don't require 100% spec conformance.
>
> >>
> >> Happy to send a v4 on top of Cristian's series, with the two helper
> >> calls moved and patch 2 dropped since the common helper already cancel=
s
> >> synchronously, if that is the preferred order.
> >>
> >
> > As your patches are fixes, I'd prefer to push them to drm-misc-fixes an=
d
> > then Cristian's would rebase on top of your patches, as their patches
> > will go to drm-misc-next.
> >
> > Are you okay with this plan, Cristian?
>
> Yes, but sadly I will not be able to reproduce the issue and confirm my r=
ebase
> will not regress.  Hence I'd appreciate if Lucas could recheck this after=
 I send
> that series out.

Sure, CC me.
>
> Also, Ma=C3=ADra, could you please let me know when you apply the fixes?
>
> I guess I then need to wait for drm-misc-fixes to get merged into drm-mis=
c-next
> before I can proceed with the rebase.
>
> Kind regards,
> Cristian
Lucas
