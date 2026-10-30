Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793382522;
	b=TpCEtH30axTdsdBG8NoUsqwgHH11/+uVNLyKWwCRRoBBpnezJ53Kkq/mAqUwz1f05v0H
	 rS+qyWyC+Oza6fTE8dXZ5FgWpoVTSVNk6RYRz042sVT133cGWV8pnGsZGumdLigrF0g7e
	 CWwIh8+ZSPkjzzUCk1+w/jJV00emMArGe/Fa9Pt1LaoL6D1fUbwQMDdDYV5jN253Tw8LP
	 z1LqKy9GuAZJj7G1WRGq2wA0aCdwO9ThVU/Lb+WIlXBugy3Ay3Ly+wYs0j3n542k4aKXV
	 3AQeZCqNsO32pFr/otI/QGPhc0xKeSAB+c3ew1boRSUsQL+Qrx5edkeV73/EI8kyLDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793382522;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=tCjjKUaujfaLQmslqeozg0SLDvgknvluRFAYaG2v0rY=;
	b=IiX7c+U5Jxn1K1XFEc1lljtt4gV7lrz3O9squhIzg9P678GSLG5Ie3kZh3m6HtOj/ws7
	 6tzL+PtdHTiIY25IdOjlO5vCjsKIML/GDgolIq35QUOSkXZr+n+M43qMF537EAMpE8HTE
	 SsEWv3Pcb10EHVnP3mZW+Vdxpab7MDaLIumK4aB/5GfLJMtVow+QrI0zST1uYh2H8eqNY
	 zL83GFQK+aAUPF8oAYd9WhqSANqecZHM8JrSXAxbmVqgRtXf4Y8zed+g8LGtdmRoRIm/+
	 2ncLlr1TbowfAi0DZilXK/vARpmm627rpiJc748t2n+bPiJHyw0luLj1CtG/qmwyjiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eG9YMGAR;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1365160A2600
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 17:48:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1365160A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eG9YMGAR
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48af4d4e61fso599876f8f.2
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 10:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793382520; x=1793987320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tCjjKUaujfaLQmslqeozg0SLDvgknvluRFAYaG2v0rY=;
        b=eG9YMGARFvw5RWZ9FOha9w1hmFX4WF2/xGDopuZwL/tK4dlTLz6ZpSjxLSuIXe4XcP
         GrC788d6VDuzwLPPYzcsB6nejTW20+VOGxtjYcMiuDDOxJC/z3G4CLtgHMrwyVyx2lM8
         2fWLPpBTmlI63HSKy2oZuHcICBFpTfZd1MrOOwMm2jB40T3hrrulwmZMB5DHkcNdhjCg
         ytuoYZ6SRlgu6BD1bos23QrTjIC43wYuZISNZVBzM7OZ/sBf3xQioOO759Mjb8NahFzc
         pvywIu6SODN8TQntMLg7DXwhRNQi8GgiSSsng8ijZaQZ1TwnZGpr5DBIgt1UWcVZPkwO
         la/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793382520; x=1793987320;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tCjjKUaujfaLQmslqeozg0SLDvgknvluRFAYaG2v0rY=;
        b=nPVo3BZ30NAZndpPHA6Pi58afoxFIP1uC1NneOlHOAXZxpX95PdoDFpwjXuRreC7/F
         4SGo1Q6dSRX732/9UAjnmkznh7nJdfauMdksumIFxJLVcAO32qRoitkdlLLYmBCjNSgS
         Y2Dqgoa+BU/N3xRZsQRp2VrdJ6iH/0kV/IyuYvNp+lYudY0TJWcaRtw/wD6XD1D5CQ9a
         oxJd+K7Da1ls8DHlgTZRsVMzoRQt61lO0GJb4ZIA//sQljsclDO3e+AMpqCvLcsxwQQN
         NdMFe1Ol8pdG4dYEnE46Z9wnpO/CMSAn43WgGB5QuC46VqkOln3nNyXcFOzGOlt5eyx7
         1jnw==
X-Forwarded-Encrypted: i=1; AKwUvBxU+veHRQy6JZCo+nsKZQHQlfpxYdAHanTOM0oOLMlhngBXPpQulJRKLKuNAXSafr4dCzEtdzQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJACDVLPkrZrRWldbyyfJrWg2DMgsT87ADEsI7j+GlZMMzfL1lE
	ndT3cAKIjDzEGjUszAcIt5IOkt4EfPzJHr7o31JH2xNcAY19J9rw+Bg=
X-Gm-Gg: AYBFou16ekH4uwkMGJkdhSjhhuLViGIRg6SIX7AjQfchnMp8cX5Hj6UuGFB70dxqfwC
	sJpwg/OhkB3UfhiTl2EK316zYEBimusn1LaTSgRS4JsBouyQwLFOYHcAivXUE+HwBptAsKGhRvs
	UMDKs5wL66VRjmoqkNCje1ouoXFz1Hzv8Hi0RYwof5Oy6Dk7iiSziK88BdphyPkzW4SkOb1MakZ
	LJacATv2FXdWyMC79hxaDgqYBmS+0yB+m5ePIN0m4dC8EqJ2rBcU5UewQQov3ZAtmTPPCgHdoM8
	sKaG0ajM6zS08EHmaPZoZNWpQxdjoXkjXbYax+pc0LGRzAym2eI8Iu4xwUzw7S8QdPIAv2hwb0b
	1JGuvjy1xYh4S+u0uqsjmC5ImUJdS+OsVw0UbB6B7oPW8AKIFnAVy/CtU7c9LF0aclTD1h+HBeT
	KpY0PzAIMmL1NUVEBZt2+VMjHmFrviMsgtFEV5D8QKU4yn8CHNIjRji3nV2g9OWbhQucFZQ/7o2
	G9FM9Dpk9Pos30J3nSZ6KnjH9FB21EmNwCsiACW+9NOWDC4BAJy8IdWCRmqh3Z/3I9mOc3gVyNo
	5p1zCTtbZy5wE7lo9xsKNki57BihVetQjQ==
X-Received: by 2002:a05:6000:310f:b0:488:83f7:6352 with SMTP id ffacd0b85a97d-48e6e2c33admr6901151f8f.4.1793382519367;
        Fri, 30 Oct 2026 10:48:39 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b8e5f4sm4492926f8f.40.2026.10.30.10.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 10:48:38 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: Mark Brown <broonie@kernel.org>,
	Oder Chiou <oder_chiou@realtek.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Bard Liao <bardliao@realtek.com>,
	Misael Lopez Cruz <misael.lopez@ti.com>,
	patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v5 0/4] ASoC: cancel pending delayed works on codec removal
Date: Fri, 30 Oct 2026 17:48:33 +0000
Message-ID: <20261030174837.1839402-1-tristan@talencesecurity.com>
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

Changes since v4:
  - Patch 1/4 (rt5668): correct Fixes tag from nonexistent
    e13da14e8543 to d59fb2856223 ("ASoC: rt5668: add rt5668B codec
    driver").  No code changes.
  - Patches 2-4/4: no changes.

Changes since v3:
  - rt5668 (1/4): track IRQ acquisition with irq_acquired flag to
    avoid calling disable_irq() when devm_request_threaded_irq()
    failed.  Re-enable IRQ in rt5668_probe() when a sound card
    rebinds after rt5668_remove() disabled it, preventing permanent
    IRQ silencing across unbind/rebind cycles.
  - Patches 2-4/4: no code changes.

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

 sound/soc/codecs/rt5659.c  | 20 +++++++++++++++++++-
 sound/soc/codecs/rt5659.h  |  3 +++
 sound/soc/codecs/rt5668.c  | 20 +++++++++++++++++++-
 sound/soc/codecs/twl6040.c |  1 +
 sound/soc/codecs/wm8994.c  | 14 ++++++++++++++
 5 files changed, 56 insertions(+), 2 deletions(-)

-- 
2.47.3

