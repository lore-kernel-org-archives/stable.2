Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB6B52ED4A
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 12:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788871026; cv=none; b=KSd5j3maTw5MSr83hTJJ2PxXmpleu5TA32xdMOUUiFRf9EbsljCOix++lWMRD+eVmK3xaSEMhePu/M4Es2NauBeQ8fnmNTiW2Eay8pYZRWIoOeLp3l684mPIEmEQ8paaYzzi3DBzk2vbOdq844EVAidvWHiye0CbVaU2zhgaTNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788871026; c=relaxed/simple;
	bh=rFgdO2dJ9qHWHCugdPsurRI0n1j/jdZfr1HAi1LVuiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MAYGRZmGcCgpLQGoEufVea1XipYT4bXIz1jEYXwVEJ4tK3YDY2PVugyuFFgpOKMu87LZtzteT02Molvb8HM8eIR/GiFXDt0t4Iu5LPzKTDxJpXRQM88ef9cMCOt0DWOEY1m5n9O6kkuGNI7vWKGXn76QzFRN3g22pNKDZ8ywSco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rLLyEI3S; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rLLyEI3S"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cfbdac7a1so1509575e9.1
        for <stable@vger.kernel.org>; Tue, 08 Sep 2026 05:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788871021; x=1789475821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+PniewoGsEvcFKc5X/0XmY8z47zqDeJXJz7RtOPgSmc=;
        b=rLLyEI3SMmxMOLKyiHNRr2PZaQulnFWIlx2NnPM+OfWM+ExYhYCjETiTGcWl020RC9
         U2kFNCCRPe9pUympox+69Lzx1EmI7eIvrQhhEBUVnBFoo/b3XiX66l1e2KjKxoSRTVs8
         RZQR5G15AZ5JwjiiMAEU7rFWOjt5D3TgBQL/7lVNE9lMGLuqYuCzM6KoLWM53BVcuyDp
         tGsqAdYPnjyXxH8ZjCxQ8wmytz0p2vWrO37529tMhsfESUrEWBrjYocL5N1ir8lm4NBj
         nTXO6mdXfUfMSIcFk40IuDj403NCLAGbRwqO+/pAYJBYb0/lir2WSjvcy/NgzMCOmJVO
         +uuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788871021; x=1789475821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+PniewoGsEvcFKc5X/0XmY8z47zqDeJXJz7RtOPgSmc=;
        b=dQhkwcikMU/CQ9fuG58DbNdzds7CcuD85yB+fJ7jBEjAKzSdUQEMmTf4Q/4izLAyVo
         lQUh64/9qizVWhxWLKOU78sg5gE+yc79FxwBC9zdlFLN3ttSPxP52m+vsnznavY6WiF1
         Nu2fyjCxSmQIrIBQHq0IQv6YDvpLtHe/UrxxmTJeD8MIGK/PEg6t5X+zDnMRz6BEgdqk
         pa2yo/XH3jWm0WI1EgHg91CiTvvkOoJ1jglDxrLcEefyJwoyG14DD12mUSo/ptw++dlA
         QaBUuQmZaeZh4Hosv2KElDymb6ec0D/Ud/iJwGpiviZeYcqONgk81PR549qfWDonC+i9
         YNlA==
X-Forwarded-Encrypted: i=1; AKwUvBwCn88/rtfoMxyyJnCVvmKVdAA3wyXMTMsCdkesnQHFdfalJW6kDjlZ1DoduXbOpwr+OlayCBg=@vger.kernel.org
X-Gm-Message-State: AFuF++l0qCsMAv6WilD8iHdqHfokDW888F5zbgUSd2oHH3aHB77hvf+D
	23rRwakge6VA0cT0JIei7tJTPs7rL5dFhNlybq/HwPLwYdpWQ58P0btg
X-Gm-Gg: AYBFou3ttVJX4JuV/37SHEqH/SiqbzjVarnq5sYmpt+mqWHbZ4/lEK+gKThrIxKd6uv
	27jQ2yaQIxHlwRJODeRNjRvHsnbTvz5e59toPwcaIFWtwILhM2KhDWcp7/YERMdbCc6TyL7DBRu
	VoqDUmlwN4skwrwgdw0rRFnOBrXAWY3E8PI2prKHAc3EQrJdcot/j4bjeTCix7QtUHhSWVsX9RA
	XFZxj1VPg4SQpSbRcIHI2Ya5bD9IAbnv24XLxelEjaC0fMqxQAwn/n8B8msJX31Z53/vaXUNOSD
	5BpOPFZOSH7E8MedtkR/74uMBFQkbLdVOVSNdEMF//skNQq3qeXyf2pQWcMFFqo2wxEcteam4Kr
	6uMioRJMhTXW8NTiSAdFiMPp0gpnPCQaqyo/NbNC3FZ2fe9/AgTXgDR3gHHpk5ZfOot206hy/EB
	WCltbFUr7z9/Ecggph92hlWbKY5PeQf7J1ture3qsWdJbWsQMigUz+68geh9M0xVGgjTuF1w03e
	3NLmMYY7DmIBLJ5r88bS5Fg0BwfmO+WZQ5M02CYb11+q8WVKowxA9U/+UA7OkbgJg5oqA==
X-Received: by 2002:a05:600c:8485:b0:499:5b0f:72b with SMTP id 5b1f17b1804b1-49d01dcc32cmr183513645e9.1.1788871020732;
        Tue, 08 Sep 2026 05:37:00 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME (20014C4E1B825D004857F441745A19CB.dsl.pool.telekom.hu. [2001:4c4e:1b82:5d00:4857:f441:745a:19cb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d0af538d0sm253454955e9.8.2026.09.08.05.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 05:36:59 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Frank Zhang <rmxpzlb@gmail.com>
Cc: Igor Paunovic <royalnet026@gmail.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Laurent.pinchart@ideasonboard.com,
	airlied@gmail.com,
	andrzej.hajda@intel.com,
	luca.ceresoli@bootlin.com,
	daniels@collabora.com,
	dmitry.baryshkov@oss.qualcomm.com,
	heiko@sntech.de,
	jernej.skrabec@gmail.com,
	jonas@kwiboo.se,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	neil.armstrong@linaro.org,
	rfoss@kernel.org,
	simona@ffwll.ch,
	tzimmermann@suse.de,
	macromorgan@hotmail.com,
	dri-devel@lists.freedesktop.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] drm/bridge: dw-hdmi-qp: Guard clear_audio_infoframe when PHY is down
Date: Tue,  8 Sep 2026 14:36:34 +0200
Message-ID: <20260908123638.7282-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908070220.41574-1-rmxpzlb@gmail.com>
References: <20260908070220.41574-1-rmxpzlb@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Frank,

Thank you for sending v5 so quickly.

I tested it on an Orange Pi 5 Plus (RK3588) against the exact case I
reported in [1]. v5 applied cleanly to my 7.2.0-rc7 based tree with no
context fixup, which v4 still needed here.

Reproducer, unchanged from [1]: the compositor turns the HDMI sink off
(so tmds_char_rate is 0 and the PHY is down), then plughw:hdmi1,0 is
opened and closed. Before, that took the machine down on close, in
dw_hdmi_qp_bridge_clear_audio_infoframe() -> regmap_update_bits_base()
-> _regmap_read() -> regmap_mmio_read32le(), either as a synchronous
external abort in the closing task or as an asynchronous SError panic.
The task died with interrupts disabled, so the codec lock stayed held
and every later open of that PCM hung in D state until reboot.

With v5 applied, three consecutive open/close cycles in that state all
behave identically: prepare fails with -ENODEV as before (3 x "ASoC
error (-19) at snd_soc_dai_prepare()"), no external abort, no SError,
the shutdown path completes, and the PCM can be opened again afterwards.

I also confirmed with ftrace that the guard is what stops it, rather than
the path simply not being reached. Tracing
dw_hdmi_qp_bridge_clear_audio_infoframe with function_graph:

  - sink off (tmds_char_rate == 0): the function is entered and returns
    as a leaf, 2.9 us, with no calls inside it at all.

  - sink on, as a positive control: the same function shows
    regmap_update_bits_base() -> _regmap_update_bits() -> _regmap_read()
    / _regmap_write() nested inside - the same frames the crash walked
    through - so the tracer does see the body, and "empty" in the first
    case really is the tmds_char_rate check taking effect.

Tested-by: Igor Paunovic <royalnet026@gmail.com> # Orange Pi 5 Plus (RK3588)

Two notes, so this is not read as more than it is.

First, what I exercised is the sequential case: the display is already
off before the audio device is closed. I did not try to hit the narrow
window the automated review raised in this thread, where the atomic
disable lands between the tmds_char_rate check and the register access,
so my test says nothing about that race either way.

Second, for whoever picks this up: Detlev Casanova's patch [2] covers
the other half of the same problem on this hardware - the enable/prepare
side returning -EOPNOTSUPP when there is no link - and has three
Tested-by tags. The two are complementary here. His cuts the case where
the PCM is opened while the sink is already off; yours covers the case
where the PCM is already open and the output goes away underneath it.
Taking only one of them still leaves a way to reach the crash. With both
applied together on this board the path is quiet and the -19 messages
are gone as well.

[1] https://lore.kernel.org/all/20260907153000.hdmiqp-audio-1-royalnet026@gmail.com/
[2] https://lore.kernel.org/all/20260519-fix-hdmi-audio-warnings-v1-1-9608966c993f@collabora.com/

Igor
