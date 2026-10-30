Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793379862;
	b=v7UPvaUFZku53btbEb/r1DmXY7bSLjMGyvmfyBnMdoya57Fz8q8yx/DqQsyaSYwnsKLU
	 Y1g68iEQDqWyFRYbFvqYE/8ZCiNtv5Kr2pIn9AXEUFvYKo3KRcsZgeLy+zNWedmlqlo5m
	 3yfq6C2C6LZ+tSAlb4EmzL0CsxzOYxuKoCgE+taSlPG8QPDfgyxFzUWqcu9cER7EazbHn
	 Mxv6BBdHSwKE1leVopSw+Zed0OzR8SahNdk8mXak48NOKerx8KoFYqGfWYojshyphx9vg
	 4DpHXHFC6FoUr7dnh1yB3yWtf1G6zr+eK8pt1w8GpvLBvgKdt0h61RjoF5cEqIJoFbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793379862;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=3klLgljL50YjSiyfASYNU3sNBhIfOofJ+tatrsMN0Lo=;
	b=D22WKUOqrpMQYYspVkp2PxAadXtZMmzgJBo0AHRLnTNqa6jDG9VL5yLOCF4v+YsYjFsu
	 0ouupk1MmYn/xJTDK+MqNsHiUTgReOzpdNFbzaK68HPPuRoQ5SS5DKWoH5XIkA04nxCkp
	 PloLX8eWUd1GHUp+SvRZEpOe5aLUK7Ntdnd/eKpoqp9D8VQjmoZxVtc0oNT6HXSoJs2Pt
	 wyU8Cyk2L1gOR6WgaIqOartZlS8ejjYd7S1q7gYxCQ4FbcbK4W3gGv7pQRDGVXjsOgQAi
	 lK51O/B6+NcldKFkvESz6hcCpjhsichq8kjXl7FwTjqfB1OLLV7W0VZOdqJWVAUPptg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZgnJAQZi;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3B4606A320
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 17:04:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA3B4606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZgnJAQZi
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so6492945e9.3
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 10:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793379860; x=1793984660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3klLgljL50YjSiyfASYNU3sNBhIfOofJ+tatrsMN0Lo=;
        b=ZgnJAQZit+77wmp8pwrjjySRzjKTs37CgW/TEWVXUymKEIZIINqvKCfL793h8SajtG
         3DUr8ad214SrhE2k3NOSGqsjTK/IwV0lhcS/Zu+iqYGG+LxshSqrZHK2bPHG3vNEdZeW
         pKEHrvAPSuZcycGR0vgi4OJfG8PlqSYBlZlMOxmSrUnvQiBx4TN3ZspqczIbQgzCJ+Ci
         rHRGuPCRaLjEXgpKqJt6f2tI0BuoI84nkQa5DFDQYmvMBcumbcDvgrjoJSzanW53mAw/
         8uLNnIkNWuYmgN0cdr79xDdTOmVU4nGAIiyPuwF620ijJk65FPMzMGlwkogRz84djazG
         tN1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793379860; x=1793984660;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3klLgljL50YjSiyfASYNU3sNBhIfOofJ+tatrsMN0Lo=;
        b=FaRG0gNBoH7P75zI/dNOnwxeUFSMAK2F/476e0Lp9pXVSRqQlSNVZZZVrwWVcIUpmh
         ar5vJJhpU99rdjqdOcBCcW3pfi3jNrHclYOjmaWDpWuKN6yEVMtO4f8ya9jNpznUehWK
         479PwWufyo8oXgM8yykbUrjlxdQdsM3okX3USbNEjxIBwB67jzFC6OyN8vCnXSVZ94Fg
         ap1BXO6XujrwQKStOSqEUfHnqPjAaCX2bc4M5krL+5tGheRoKJCZNS7VKBHl/ibZSCuu
         +ZGRhRaTKmOtNgUBLmTg+LfrmNmKNZjITE7IyySiIDWHkkA/VlBDubVpKvaVMOZUJaG6
         7QQg==
X-Forwarded-Encrypted: i=1; AKwUvBwkbK4POpKydDNZE1MgX7jK8AiRF5xzxg1bLUzMfoVQ1m6eeKt1rpXN5i6xm3b3pHcnL6De5xg=@vger.kernel.org
X-Gm-Message-State: AFq9FYK7tCDC1p4+dOT8PRgxyyEWh5yB/BN9MpyJ6gbkbx5fJPF54dbp
	HmVE6hTi0NDgh7Uha1ETPmzC51QlPo4J/mLSXdw0O7k1M+9BlQ86B4c=
X-Gm-Gg: AYBFou0wvjVM4wBWQMwt0mt+y2yIe5Utzzxmj5W4+24Zdm/iUF1xqaccxDMHxugRR9p
	R7IZE19CGOthuiUYHZkBuyo+t/dZQonTkW2hgqytJViW5goPXlMRDmENqFOr5EoTKRkBWmeDiwi
	chzD6caiflONnwdg3lcPYH70Ht9AmmnoYs2Xhd30iNo7DfJhbsAVE+CHOI5iklVjjwCj8TvwEEo
	NdYcPmwaki4NFBQX69HU/X4+mLjGKutk92RTRZ9f3Os8Z8jZYvTMp/XLdynsJgYXVmWTcffrqXX
	i0zIEKhOppSqzasVCU9o3kDyogx0n2daFofzn9/5ZpIU3EWbddLrzFBwW6IRup2PzlQWYGlMc5I
	qCLWsVuI+g0bN6HrFyeVNbPA0/DET2VIyFGHSXg9ebxeabsvR+5D86l6sLTszGwwbOIX7wQiEFQ
	wqvpQSMcdeTA30Vx3Bjr0mfPqlLGB859V0SeGk/4ouMBK2KgM2uwAnjMkViJrRu2ABgrSPSTKDq
	AMQGXfha4FM6j0fqed32OXUGhMfwrF/Rf7q3kcoev109tfsbo0xV0id2/kbpJ6RgN31lA6EhdXv
	Dsjw4h0QR24=
X-Received: by 2002:a05:600c:6989:b0:4a7:6425:c274 with SMTP id 5b1f17b1804b1-4ac150b38d0mr64239885e9.2.1793379859483;
        Fri, 30 Oct 2026 10:04:19 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf7146621sm75121785e9.13.2026.10.30.10.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 10:04:17 -0700 (PDT)
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
Subject: [PATCH v4 0/4] ASoC: cancel pending delayed works on codec removal
Date: Fri, 30 Oct 2026 17:04:12 +0000
Message-ID: <20261030170416.3561618-1-tristan@talencesecurity.com>
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

