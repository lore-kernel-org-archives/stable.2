Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793374926;
	b=Bv7+Ev9tzoyFXIYqQ/HOGZzOysJy5Bu8WDfrqFI1KXzrgi+nW4T254khTVC8jYWXLGqa
	 g0VhLg39T/EhRfofRt4tfNaNIEJtFciLBMoG3Ep1rXoLDqV8tkVJEAOwk/HzB2l3uyB82
	 WXsFLMFv4E4c5sOvs+xnGpBsCl+MQVN2cVUk0KZK3LCWYm5Iu0NjxHdzuHGk34/iVgFl9
	 8MINrRC7WWrcRzqygN3pcpVEL2dEED9m1TGRyYesKZl79nfJef/kogbGsbyPp4A7n/Tk6
	 Q2+R6dRjd/WF+ORml1Ful19kWyHOR0z3Xc8+dOfZjra10cmKfwg+2jjQGjZRCZP1waw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793374926;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=POhY/41PhuxMSqZgcCWiywGbaYgiSE/QllHx5WvgqQU=;
	b=cpKPgIKI/Ntv0blki7JEJU9diJJmwPiK6TZZUoG4GYgd20dqepMU6nLGKWz+wZ4i7nL3
	 lrVnUmT49QXSNIR4GOPMusVzczYE9CpdKkFCAHa6kE3z0uWWZYuyewqVL6w684fyBAJN1
	 z3PJKQITzxE/zvK0/oP/z+ghsyhPKpBMrBiETZJZG09OZNdd5EbByvvixhsj7ZJL/vEdg
	 BSIDOAPA6t7ItA+VItM2wNbeNjNYyWw4msib/ZZHbs6Uy+x6kC/l70l0EnAVJPwySFQr1
	 AbOQzZS4AVfJk559hG+M+3lAx4V64jEuYcIs7ZMJRQGUlRA0SzbH9ac+hQftSokNy4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oofqVAc0;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397EE606A31A
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 15:42:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 397EE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oofqVAc0
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a4d7ae1ae9so8136255e9.1
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 08:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793374924; x=1793979724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=POhY/41PhuxMSqZgcCWiywGbaYgiSE/QllHx5WvgqQU=;
        b=oofqVAc0woCEGyx/cxu3pYBBvdASXJDrMlU84MQdGkKgQEA93GVn1ig0Csl1mcuKng
         EPXW1VNeDmvPkfIcHiphDp2Jb7SyHYgSZFo946rSAJa840pkP8icy6IyfnDoNxhC4Yg4
         /pnjenHd8fAj69qYTdOLmAuG3Xe2dJxUytQITsO6GUzbQx4o9X/TjifPLWrcvVD3lpeW
         ibjEEKcTi1Jos/choLtw5BkLwbYii+O1V/5lGxIKFkP1ppgaMccie8pWKKC2beMN4gJZ
         JZNxuf5FTv9dkw23HPKfK07hy68/P1bdgFcvLNp71wygj8yEuSNB7uxFf3cNc9UlDqNh
         R+Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793374924; x=1793979724;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=POhY/41PhuxMSqZgcCWiywGbaYgiSE/QllHx5WvgqQU=;
        b=G//0totYpuKy4xVTqSbXWUTyP0lfvqw0roU+j0zHqRjkOX4umdw1j3hXs+WBg7DK7D
         7KuFv/k0ersCv+l2FTtldoh5ZWIshbbGhhe4gykNatGwyPqTCgweq4mubORZMiFbwOB/
         ljaKi6tkLPioDTY9pJiUypMaZzptuSUtewuZMqAEoAJj8AYM92TEeBULok5XSPTIK2IL
         BLJOn7qvVxYx6/MzUchH032AvwHhs9O2mZ7/xWX6K6GSLDS+7DmWXkEH40DNaIU6kgIL
         Y/83d2v4IxoC2MHFqxMM4JcfMvGg6IbSy/LpADRq/6ZEae/i2vuGn3XehGA8h7cSlOZW
         UE6g==
X-Forwarded-Encrypted: i=1; AKwUvBzREAQuvKC9Y0VZGJ7rFdJYUIck661VnearNx0kpeJOUI15vlrKqzLPDTAhXz8Mndhmy6R+mRs=@vger.kernel.org
X-Gm-Message-State: AFq9FYIV/QJZeq7ixYFPe24WtzP/gi3ctZ/8Dv7JYgy2fS8JiVZiJvuM
	7TN3EztzRiNSypnPrFL8FU5oTSFAzqUdJ0T9etGKn60k7u/hTKNE5ak=
X-Gm-Gg: AYBFou0g6Cm4bijaYtXOnh7s0k/fdPIicjOm6WwmVBdLrh42R4hhE676qkl7I6WlaMa
	fj9FVLXCCHzTS8bv1csnN76ke9LtYKudFNQVd+nUueZKBNo9qTOFgW8CBEhryGJMdvYymJ0Nw6S
	PaZAQAzAH6ju/VP1p1E96pz2iBXg5czCbO+lEs4G2vvY5hbsCoYp34swOLZo6IuQ8eWTyuFsfvc
	3Z6QkXgKdMUIG1CMhOrdMwEopzQ9vwzR3opcDJBTQa+2w4JPv0TewgkcHkWDlwLW8lo6pmNzCER
	+zd6L6Y2n0mx0yClNegnDqmvA/wA7zo6/JvcYW/+AMyg1nQUEr5UL1p/dE9UnunEqWjrTz5ntp1
	lwNK7DUV4S4c8zre00hBq5cwvrMM0a9zpAp+P+1YCihG8bHnqGjoRau9iQDjYbqjOgB5ToE8fBZ
	WjnAUhOIPLsGjSHysTw3eWtq/Y0XV0RvEYq3sQAkm5oz4hxPUClrLHO65PywaMF9yCL15Yly83E
	SetuLyIHbZWxn0Ciol6hRdA0MJt68XPzDrqW6t1Yg9tvKigm1k0ZX94shZW9hXGaQNtXZMS5yD1
	jRGU4Iq9Q1A=
X-Received: by 2002:a05:600c:5249:b0:4a7:7f3f:6f8e with SMTP id 5b1f17b1804b1-4ac1228b5bfmr59543675e9.0.1793374924310;
        Fri, 30 Oct 2026 08:42:04 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa80f047bfsm144419935e9.3.2026.10.30.08.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 08:42:03 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Bard Liao <bardliao@realtek.com>,
	Misael Lopez Cruz <misael.lopez@ti.com>,
	patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v3 0/4] ASoC: cancel pending delayed works on codec removal
Date: Fri, 30 Oct 2026 15:41:58 +0000
Message-ID: <20261030154202.2989936-1-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several ASoC codec drivers schedule delayed works for jack detection
and microphone polling but do not cancel them on component removal,
leaving handlers that can run against freed memory.

This series adds proper teardown ordering in four codec drivers:
rt5668, rt5659, twl6040, and wm8994.

Changes since v2:
  - rt5668 (1/4): also cancel jd_check_work (re-arms itself every
    500 jiffies while jack inserted). Disable IRQ before cancelling
    to prevent the handler from scheduling new work in the window
    between cancel and devm IRQ release.
  - rt5659 (2/4): no code change from v2.
  - twl6040 (3/4): swap ordering -- free_irq() first, then cancel
    residual work. Fixes the race where the handler fires between
    cancel and free_irq and re-arms the work.
  - wm8994 (4/4): no code change from v2.

Changes since v1:
  - Unified series per Mark Brown request.
  - rt5659: guard cancel with jack_detect_work_inited flag since
    INIT_DELAYED_WORK is conditional on jd_src, per Mark Brown.
  - wm8994: cancel mic_work before and after jackdet_bootstrap for
    cyclic re-arming through DAPM power-up chain.

Tristan Madani (4):
  ASoC: rt5668: cancel delayed works on component removal
  ASoC: rt5659: cancel jack_detect_work on component removal
  ASoC: twl6040: cancel headset jack work on component removal
  ASoC: wm8994: drain delayed works on remove and probe error

Tristan Madani (4):
  ASoC: rt5668: cancel delayed works on component removal
  ASoC: rt5659: cancel jack_detect_work on component removal
  ASoC: twl6040: cancel headset jack work on component removal
  ASoC: wm8994: drain delayed works on remove and probe error

 sound/soc/codecs/rt5659.c  | 20 +++++++++++++++++++-
 sound/soc/codecs/rt5659.h  |  3 +++
 sound/soc/codecs/rt5668.c  |  7 +++++++
 sound/soc/codecs/twl6040.c |  1 +
 sound/soc/codecs/wm8994.c  | 14 ++++++++++++++
 5 files changed, 44 insertions(+), 1 deletion(-)

-- 
2.47.3

