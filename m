Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793109194;
	b=Wb/lGe5dk7HopDS/1xOaDcFFtVJHfJeh4d8qLdDMg6bhiuFBkxIhqDsP3VSkTtJ+8EG7
	 l4IphWEFoGS4/4qIuavUlEHRg+JMxyVdYz3pPuMuhWawQlqdiN2MVBJyRxtGpT9Z1mWrX
	 R7lJpTuugs2AEMTtGHHkeY2a8C1ElWSD8kHyVW2xg76jjR1mmjviwtteaLNHpJwH4pYde
	 8xAPZrcabTBrp+fsqzGMAtmypq6PddekIUPpHDlBDQoPVUc+WX8XlawbCm4RRxu+CKoUW
	 ZXs11Rs6utolp1IuATvijyHeKFb8WnbnbyNDSeYFjqF4LKE6Qak+pDEv73bqcQpNkfA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793109194;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=C/QHwPFaYMgxwOdflsCg2rHPFq6Z1Jx6heGTIKTaV+Y=;
	b=f3J0rs2DMK88CGZUM0Jl9WSejVEIb4xg6qQ6P+JeElGl2lIxLGVD7jZd5kSUAQ5Oa8vZ
	 e46vaJ8bJd/NuE7Fej4ifdOVSpSg7I1JIpcuAnU3YZrx50bWaeuw9X97RppUEBz6k8UAi
	 1ZcuSOZcdARgaowbCTeUuCf8VV9OqzZuKrzLZyr0ectl1rgq6EvECdG0NKza0WwlKjk1R
	 lWp4NGLbSPAzMKRrS6Y8vQN2gDA1YNPND8HmYzj42NS07PHRZOq1uZcznaFmo0hMEvQ1X
	 /WpwYL/Ed2f4zQTYg1RXxDjuCgxF2sc9dixpg4ilhsV74OsanrjPE0n038EU6myI3iw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=neat.no;
	spf=pass smtp.mailfrom=neat.no;
	dkim=pass header.d=neat.no header.i=@neat.no header.a=rsa-sha256 header.s=google header.b=Cn4hdgaq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.42
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB3B606A31A
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 13:53:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BB3B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=neat.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neat.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=neat.no header.i=@neat.no header.a=rsa-sha256 header.s=google header.b=Cn4hdgaq
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-675676afc3cso4930381d50.3
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 06:53:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793109192; cv=none;
        d=google.com; s=arc-20260327;
        b=YJh8bJzV3l/xrsAYwlJ2Oe11MRIqCMN6UPKcmeZJkhyC7dFE6nRzHFgXp0LtRqrvna
         ovYstvEq5bN2MtHnTX5mPnN0WBZT7o3GM+ExzyWl/bvqRskbwPdWCAD3Q7OKJ9Vv76VW
         vnOpvVi4fqF5KJvqs3VFwd1vwGOFRm98UHJ/mLA1aSwXsnjmI/v5YHP4ThSG1HaLoDZE
         zTFACvsPkua6wmuXsJlQQ8stbfA2lAvFfikRNCVp2+C7wlV1EYhRtpLrW4zliX2E5SYW
         E1URFAmtemS3HVmN2vg5eNJjKkilRtaHjdMKagfzzjY/3vdvDm0wyph3BPasVxmnemwH
         6LHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C/QHwPFaYMgxwOdflsCg2rHPFq6Z1Jx6heGTIKTaV+Y=;
        fh=PhJzMUzj3MW/b3PwtKy+zlCuwt6ODW9d+8e4JxfcyTw=;
        b=oS9LiXEodn26Vz9f4QZtEx/H6/DwfCEeU4sGTkXpC0i6sEfg7hYFj2Oco8KrJNmTRE
         QVlTgzAsRGz9RL9FoVwasQOOkT4/eDJdQnKU7/ieF1Jdt1L8E3Kh777vGAW3Bg3clKia
         78hQoVswVEpohTNzgnUJZAKAzm3onKFG1zUxQKTQ0nLHkpXBJo7e4WOfytgrQs+goac9
         9gBvCY2jJfWEtzTYsADbPaB0s0zNUb0FczzYyJalEhwXQC5g9fDEWefxugIjaXXEhC5s
         VrTgw2auSjF57qZzcXTRlD3XHa3Mi5+pk7tKbqDzvktIibgtyszM8u3BH+OLmqg3pQu2
         Fg+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=neat.no; s=google; t=1793109192; x=1793713992; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C/QHwPFaYMgxwOdflsCg2rHPFq6Z1Jx6heGTIKTaV+Y=;
        b=Cn4hdgaqC4F2s/DWyAb+scaTCfrDYvwg0+px/rl9Y1lzKFAeG4MMAD6bAp7UclOXPM
         7aYflXaKOo0xGwsAFiHyJmOKUwgQ54yWvnQ4syMBHfg4daQzhGXKFR0B2HF+unfdub+O
         ReR+zZoSFj8FeVsLt0dLNS5Me/o2qiTCjy93kA6QwfmqtfMk+w0yKv+D6i+fJiczLPkp
         isVbdjMskVYWFTyOGqzmf0fv4pJiPuLXYVjwl6Tpb+JCd4WDywm37ZKAeHXwwK/K5Dgn
         LuqQLhvGBvXKpQtwQ6yOqDAOyeD1WmwHoCu2Lqk8jOeHrXetGYRuLeGd9cGOC8q95iX6
         IpOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793109192; x=1793713992;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C/QHwPFaYMgxwOdflsCg2rHPFq6Z1Jx6heGTIKTaV+Y=;
        b=B6S12XWXcRMS6O7XsPkRYel867OoGD4bISUlKZnA0vujL+Id4xFDfou9qLeP8NdeOD
         c9883DqUm1e+Dp9TyMQ7bbXIpeFVwPfs8P28xfJkTtehsLgkMB+8aB36AB2pnzCx302+
         7tRjjtVJji4HxkQ8zwU/OzdBkFWJcvK+ISXQwjBMURqdfvC+/Fk+XD1G9ATI4n3kRp7S
         iMsfc+Awu3nmalpEXV1Hak6ooJj2+gZ/imEZZVNco4XOQsrv0xMJcVdyS8Bx/GblPcdX
         bz99CBpOzIjKw5BOQewWY1XMa2ju/wrKdtyYpMne0GJ6DHYOB58BNQi17zMrf3mstp2w
         seGQ==
X-Forwarded-Encrypted: i=1; AKwUvBxYDR2hdWLY/pM18U/lUjQUA3O1/GOLtWTnpetV/WdivK5sk9shVZFENu6Kt0M7/9xrjAQ752I=@vger.kernel.org
X-Gm-Message-State: AFq9FYIe9lS8H5fRw+XPHAn4YRyiFt42dQLI2qEz4GBwRtyRU5S9yAFP
	W5j823wz0Uhh1YB2V5nx+XCrGkBeCgACE6KNH+fI14AamUBpJ3aKZ+J90SwkGu9NpYpEg/csKqz
	PDomS/eroTspvNKLWIpLnV/7G9CZufYIZkjKpMnBRJ/NS0tqK61wpDRT+4YAd4bKADffLuXvjTQ
	1grIuUR+mwqNujbyyVOaOVLzBSOhM45CEvQpTT7pzQvdZKi/LMWHOZLBxDM8jsE0x9e14Xw2bvP
	haluaCqf3X0+o3vzMxFebdfclCyL/6haKSLl91AvQkAnVtng1w8hg==
X-Gm-Gg: AYBFou0AUl5lNKoBHW/aVdqzxOaZ6wOBhw5PrOiB02HeAMFXzzz3QLTUVc/wOWT6AOZ
	SfZJQg7zLY64KIKDuPEfuf03MXaSMNqzzwn0GtTbX+6cbfNyDoTGK3i1uK4wbYsCyTNJHH/pwhx
	AhfxRMNlyxN1d6p0ha3DOpHnDJIm6/GXyEp06AjW75KA8huQ6CF2ZQ5mCUc3u9VMINvx7zUh8vk
	CR8ANkx18nszqraGAyJyT592xMgHArz7p64ResMjh7TO/p5tLB3w0Xrs/WPAWO01i1/u3p5p6FL
	T2sOmJ7KOcp6d9vMbEVAqAL7pmSkOxQNndNudDB3r4EJCXxcGTGZyFkEggFsATQFN/Ru2jNblFa
	KH08/NEkcbePP9wzP/CrFLJjt8qmESRIppg0nrHzn8qpEp70fMyW+0xhL
X-Received: by 2002:a05:690e:1905:b0:675:6228:2fdd with SMTP id
 956f58d0204a3-67a45193dcdmr8073792d50.4.1793109192290; Tue, 27 Oct 2026
 06:53:12 -0700 (PDT)
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
 <a8b9450f-af4b-47bf-b7b1-3b326ed52dfc@igalia.com>
In-Reply-To: <a8b9450f-af4b-47bf-b7b1-3b326ed52dfc@igalia.com>
From: Lucas Tanure <lucas.tanure@neat.no>
Date: Tue, 27 Oct 2026 13:53:01 +0000
X-Gm-Features: AclHuK_nxwMrSebAhzH6BzwzfF__ms2hub9Qe_tDk-dxbFBTVEwwSaw33DD8X-Y
Message-ID: <CALt7t=Ef9LS5vNOZq7JGZ1n-L5rgMk7mXBGE66jicfdkqAC35g@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] drm/vc4: hdmi: enable scrambling before the TMDS
 clock starts
To: =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, Maxime Ripard <mripard@kernel.org>, 
	Dave Stevenson <dave.stevenson@raspberrypi.com>, Dom Cobley <popcornmix@gmail.com>, 
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 1:07=E2=80=AFPM Ma=C3=ADra Canal <mcanal@igalia.com=
> wrote:
>
> Hi Cristian,
>
> On 26/10/26 22:23, Cristian Ciocaltea wrote:
> > Hi Lucas,
> >
> > On 2026/10/26, Lucas Tanure wrote:
> >> HDMI 2.0 asks the source to set TMDS_Bit_Clock_Ratio in the sink while
> >> the TMDS clock is stopped and to start the clock at least 1 ms later.
> >> vc4 writes the bit, and enables the scrambler, at the end of the enabl=
e
> >> sequence, long after the PHY has started, and clears it before the PHY
> >> stops. A sink that samples the bit when the clock appears never locks
> >> a 4K60 signal from a Raspberry Pi 5, while laptops that follow the
> >> order work on the same sink.
> >>
> >> Patch 3 is the fix. Patch 1 is needed on BCM2712, where phy_disable()
> >> was an empty stub upstream, so the PHY kept running after disable; the
> >> Raspberry Pi tree has carried this since 2024. Patch 2 fixes a
> >> pre-existing race in the scrambling work cancel that the fix would
> >> otherwise make easier to hit.
> >>
> >> v1 was tested on a Raspberry Pi 5 running the Raspberry Pi 6.18 kernel
> >> with the same change applied, against the sink that showed the
> >> problem: plain enable at 4K60, 1080p60 to 4K60, 4K30 to 4K60, a sink
> >> reset and a sink power cycle all lock with zero character errors. v2
> >> and v3 carry the same code; the hardware test of the final form is
> >> still pending and will be reported in this thread. Mainline was not
> >> booted on the Pi 5. The BCM2711 path is unchanged except for the
> >> enable order; I have no Pi 4 at hand.
> >
> > While converting vc4 to the common HDMI 2.0 scrambling infrastructure, =
I
> > ran several tests on the Raspberry Pi 5 and didn't notice any (obvious)
> > issues.
> >
> > Hence, could you please verify whether your problem reproduces with a
> > recent mainline kernel?  If it does, could you also give [1] a try and
> > report back the actual behavior?
> >
>
> I suspect you didn't hit this on mainline because vc6_hdmi_phy_disable()
> is a stub, so the TMDS clock never stops between disable and enable.
>
> Best regards,
> - Ma=C3=ADra
>
> > [1] https://protect.checkpoint.com/v2/r02/___https://lore.kernel.org/lk=
ml/20261014-vc4-common-scramb-v3-0-c68d58d959a2@collabora.com/___.YzJlOm5lY=
XQ6YzpnOmQ1ODUyMWJlOGIwNzJjNjNmOWRiMDk3ZmFmYWFkNDliOjc6YTM1MTpiMzBiNzY3ODAy=
MzBkOGM2M2U0ZjRjMTY2MzE5ZjVhZWZjY2QxYmRjZDBlOWI4MzI0MGYxMjkyNjQ1Y2NkNzJiOnA=
6VDpG
> >
> > Regards,
> > Cristian
>
>
Hi Cristian, Ma=C3=ADra,

Tested on a Raspberry Pi 5 with the Raspberry Pi 7.3 tree [1] as base
(pure mainline panics at boot on this board). That tree carries
vc6_hdmi_phy_disable() implemented, so the clock does stop on disable.

1. plain rpi-7.3.y: 4K60 never locks.
2. 7.3 + my patches: all lock.
3. 7.3 + the 7.4 scrambling infrastructure + Cristian's 9 patches: same
   failures as in 1.
4. same as 3 + drm_connector_hdmi_enable_scrambling() moved before
   phy_init() and drm_connector_hdmi_disable_scrambling() after
   phy_disable(): all lock, zero errors, picture on the panel.

Ma=C3=ADra, I also tried 3 with vc6_hdmi_phy_disable() emptied again, as on
mainline: same failures as in 1. So the stub is not what hides this.
Cristian did not see it because his sink re-evaluates
TMDS_Bit_Clock_Ratio after the clock is running and forgives the late
write, as most TVs do. Ours samples the bit when the clock first
appears and never again. So to reproduce the issue you need a strict
HDMI input.

Happy to send a v4 on top of Cristian's series, with the two helper
calls moved and patch 2 dropped since the common helper already cancels
synchronously, if that is the preferred order.

[1] https://github.com/raspberrypi/linux/tree/rpi-7.3.y

Thanks,
Lucas Tanure
