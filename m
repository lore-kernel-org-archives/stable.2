Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793013736;
	b=PlgFTgg35wxRISpvD3KVbx9ouC2uGE1X0RlwMAkJrM3RR2iJwWb3vcyFQzv5ykKVKqFo
	 koYcyAacgNRvH/TNGy3a/v8cNu9EmYxPKhaJM71+1BO651Ed6EQq6kj4+60F+0yfBvz3E
	 XliMIplLHyTQWsfELDNlUZOvxBHSpDTc7JqqFC0lcg7/HW0MieexZwGMinbZaEm8P7C4Z
	 OtNW7wkzsDpFSI4d8cpEfDbQCV1Y0C/hekYyWEoXAhGxV/wTGmfDEKsL8Ti34QEkPPh4a
	 nuxbohKQlb/uVZYDOwkGwW/VCvVWzDyYDcgLjr5rblhzxaKZhYEN6YBSO58a8pmASqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793013736;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CwUajG6zOxtmKYKaBabWQ/RQ7YEOVECEPn4qU0GhKJI=;
	b=s1vAAjs7ixSusFRk2+DQ95Q05TlBz88FTTIZMRhc1vwU2oPqsowLVJAi1ghXqLMKqzwv
	 39r4JnYqa8gz58MlfDu1apcA0JM1IRmN3YB+/sXA0s3hYLczHXXRaboJjJLK3crlKjy3H
	 r8+7uM/hezfFyvC1MzPxlJX23U5USr2DRZwM4Inhrz3EdpfBmAKyEewkGneGOwHCDUxym
	 9SXfxAKs9ILsCp8DZDdATEBavNHJ5y2GtBtVwiethQ+gIgGGRbdAGAby4AGF58T2Tk1NV
	 oR6ph2YuL02NB3kWVw43V3GHA6wlxcKO4VI7D3wxIB9ZrezJpe2Ps0a/dmU8JWZxh9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="A/GaxXPF";
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CAA60A260C
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 11:22:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22CAA60A260C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=A/GaxXPF
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a5177d78c7so11621985e9.2
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 04:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793013734; x=1793618534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CwUajG6zOxtmKYKaBabWQ/RQ7YEOVECEPn4qU0GhKJI=;
        b=A/GaxXPFgozeZ7aLS9ssmDZFGeG8eQ01zyFtmvsEFEjHgN0ZpShGubPQPT4c6ak1P4
         dwJQljiF8o8ydDBGa6DWNlST6KmndsguhxZoSXBAF3cFAr2VLIcvGww58U1l7TFXyNr8
         u0Q4hMX8JyTzhJVfOXgZ3SVw+3ig1+XWrfnCsemzqNe0ZHHPfQhwrnXOFn88YwOD0KHK
         fFH17KsZHJiZ5b4vfG3iNjUBmmh1/cUqLR1CARwXyQ0+Nz1Wocn3dwCeQvYHYg1Hx4mt
         FGAGya+o5DgR2lQ5bxC6kUC9MmXpRGjhBQCx9E6zappKoh4FpNHs2/Ap46JX+RZIs0UM
         e+8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793013734; x=1793618534;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CwUajG6zOxtmKYKaBabWQ/RQ7YEOVECEPn4qU0GhKJI=;
        b=jRfmVftvY635rFc+nCT4IRCqUyXm8W1gGDG5fc9mNbWgdaovIFIRQTfvI0rlFpHUJH
         WoK/CAOIO7vVA7bpDudXRav3qYN98SOptoJurHo9QELlKjMYzkvvmaUlQqD1JdWI79Vs
         gkYTGG14wL8rnE3wkK1Ydem7aplodnFrwx1bRwWMaLhfRrS77NIptYAS8C1GgCuUvnPV
         9WM8Lje94a7d71xW6GQqn6ryY/5tMcavUHXlqHILw08xUP7wG1/anK1gYe6cK+KDn/5/
         9y6vKJ8whpLeUYuyQAxXFqJG9b837EuC3O9aD900TX2acXAc1DW8qJrBW+XmH3Suj6am
         IHTw==
X-Forwarded-Encrypted: i=1; AKwUvBzT8RicPAx2IcPuJfarRbMZMqqk0NzrPUh6E+j71mH393e09OZ9b3PRrLIlFaEvvK1qc4yMVFg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKh8GsiHp6cKCgQ2UtBOqLPzncTCerTa2QNMTKnRI9NvhMfCCL+
	MI1rKR7fjyn9DAruzwoRMgHNmwlQORlIoYFhBxtL7dMl5RI8ivBRqDs=
X-Gm-Gg: AYBFou0qpPMLYMj0TiI4VYIwPgWLDzh1DCmJsqXu1db4JLudEfRS/xuWkGdgXFlHUgQ
	jgWia/JM2kW61LtuqcmFWl55QnOCfJTSSvSFa82RBHDlcGT6LvGGQ90HyFcq6T+Ntgxt0yh/yZR
	jz5xNuetmmKyekDf1csNtvJT6x9nRTmsotVHdZCgDp1AxLQQ33jVJAWtMqs44/BvwV8haZwSwhP
	tYnpTDTESycXo2sjCwF/pwn82DMKiHXN+V/KjJdxZuH2T3EpxPOlcPFGQDJO+ZzX/uGQPpV6XWF
	BdzuAK8a++W4f6LuOxj3382l5d0+AdlobeO/DkfJNBnrWPTKb0uh9dUvGzCfYO9T41VqBVos1g0
	KnxnpJ80ciaadvaGzL/x+VnoHWXLAhz4n0v0BNCfvZvj1sgYfibOGU/3C4WjfYqcyf1Ko80CEnr
	i5dwlk2IyvUIUfAu1dAvVs/qZdPMzoPBM5HLjsKUezyomou6aPlfqP5oaiKUYOBeILlGcARUNFt
	fCC79X8szaWLc458LFXh2Uqpg==
X-Received: by 2002:a05:600c:3ba9:b0:4a2:d7e:5ccb with SMTP id 5b1f17b1804b1-4a35ac99bbemr117137165e9.15.1793013734410;
        Mon, 26 Oct 2026 04:22:14 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a359f59750sm129141265e9.0.2026.10.26.04.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 04:22:13 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Takashi Iwai <tiwai@suse.com>
Cc: Oder Chiou <oder_chiou@realtek.com>,
	Bard Liao <bardliao@realtek.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Jorge Eduardo Candelaria <jorge.candelaria@ti.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH 0/4] ASoC: cancel pending delayed works on component remove
Date: Mon, 26 Oct 2026 11:22:08 +0000
Message-ID: <20261026112212.2519775-1-tristmd@gmail.com>
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

From: Tristan Madani <tristan@talencesecurity.com>

Four ASoC codec drivers initialise delayed works that are not
cancelled during component removal.  If the card is unbound while
these works are pending, callbacks fire after DAPM widgets are freed.

rt5668 and rt5659 share the same pattern: the IRQ handler reschedules
work after the codec is reset.  Track IRQ acquisition so that
disable_irq() only quiesces a line the driver owns, then drain all
delayed works before resetting the hardware.

twl6040 frees the plug-detect IRQ but does not drain the work that the
handler schedules.

wm8994 frees IRQs and firmware but does not cancel any of the four
delayed works that IRQ handlers and DAPM events schedule.

Tristan Madani (4):
  ASoC: rt5668: cancel pending delayed works on component remove
  ASoC: rt5659: cancel jack_detect_work on component remove
  ASoC: twl6040: cancel headset jack work on component remove
  ASoC: wm8994: drain all delayed works on component remove

 sound/soc/codecs/rt5659.c  | 17 ++++++++++++++++-
 sound/soc/codecs/rt5659.h  |  2 ++
 sound/soc/codecs/rt5668.c  | 20 +++++++++++++++++++-
 sound/soc/codecs/twl6040.c |  1 +
 sound/soc/codecs/wm8994.c  |  4 ++++
 5 files changed, 42 insertions(+), 2 deletions(-)

-- 
2.47.3

