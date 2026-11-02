Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793638427;
	b=Yz+cK2Cig5a0hPZkdY/ZEdvkkE4M4hJ1nySSSDBYqPzim7Wp+v6WGlaxnJcFzCv/VoER
	 t4V0NEQ5+tulfx0CLYFYMaQNKdiX7UgD8OMcFgXa/R4TbZy5MdORxPsBhlhLoCbuc/Xxc
	 oDpgBUzlPOw6LsH6kXXGrhrjyYGAel3rR4NmlfHid2yKgcbuEMKyEpzTPXK9zT8jUlZu9
	 otG034Thta3mgYv/luJUMRb5UJ+gTJXzcSOrwzE4XBtIC15sEqp59v54pFGoyaahHDve/
	 xTTTtvravzsPCt43Alq4cq4h6ju41PgVV2P3uz5pwiAtmmNWC153cHGGR7rB47QHraw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793638427;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/SI2PUcddBfYVKVC/aRECHCKeHfS2EJHFz816z3+gq4=;
	b=BtExrt9n2l8RYOimKZZatdk30f3lKyfHE/X7E/3Qdzug+v3vkxKb6+U5SdNW9hIX1V4y
	 VyIMrYdM+NZwRfbi1OarptcEDZuABKkQzIWx+LFnLYmGGmwaKLCqLP6hUgXhE6RVb20Ml
	 z40agQhdJU3wZumEo6OCOlQqwcK4umcNM0xCFZ9AmMCkHYexftYfsakPD4XoPCLO/Q3Tc
	 38ndicznR5JIsxLEldLOrOfUuAU+IxC7VUinBPKkBWTTPTiKFGZI8MrPuUg2X2b4mrhfC
	 VipCJUmpAU7QStcYIHJpOcoplCfaRaI1/xateloO75gNF3/jVqnfw3l8s5wovFIyp1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Mrct8IJt;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE5F606A587
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 16:53:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BE5F606A587
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Mrct8IJt
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48afcfc4bf5so3335821f8f.1
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 08:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793638426; x=1794243226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/SI2PUcddBfYVKVC/aRECHCKeHfS2EJHFz816z3+gq4=;
        b=Mrct8IJtpCBAs8emeLa9gEOzLlPTC7ZbFWCaC4tZWeWvvw76PJTEj9hlsgEdvnc6Oh
         s2vUCBogGKkeslv+vcwtSCY8Ic0yjOykp7/j34zxJKsUXtFZtSoBhT2go7Q58IEcWKgp
         VN1AgmPogpMkxjLGDEWdCAnT0EG8mFxBbUMOpvnzwVnEZhA9pXYnJkV89tgPGxXgpCxp
         z3lEj4XEOH9h+NqB0HccWMQeRyljm6r6BKqsQFjtu9niERFQ+lKg22LukdPuoMmK2Dl6
         1ATyFrk90MhyY0xD3zU/oi3rNwNygeai099u4eKQ72YsDDwh/qgCJut7ka9QfwwUmuhi
         2aQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793638426; x=1794243226;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/SI2PUcddBfYVKVC/aRECHCKeHfS2EJHFz816z3+gq4=;
        b=yM2ILhTnrNR1oaJJWuE5pDEAX90HGGegK+1Jp9M4trJJVMRH/26utGxBD4HABLiD1E
         8XkPYUcCITnQk7qxKyoxO2sDRYd+S3tZE1TUdU6MJU7Y9WgC+gPl0mVDucEwLN/EDnrh
         9oc7AhpQJbFfVHipF4O3SI4b/FwAXx7OWpkaWCUdBL0F1+BKPQEC3V5F6PcrhDe7c2WJ
         6J2XjLuWqLKlvGMw67doNd7GyVt2ZUDANEQq6En3oIyWH2OZnQIb0m9mXQTZe+X2XzpN
         iEoRE/DdHAz3MhsbWaUfZhBt0vbIYEi1PdTn6E5uLmE2tDVdgZ6G2ZIcBEOa9Ej3wQlh
         T6aA==
X-Forwarded-Encrypted: i=1; AKwUvBzNvnXjNriOeYtWkAdgMxxNC9aXIgPE/Rg2If+21l7KAOXj5M6On7T313oWNdIV68l2cky7UT8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ym39kGBHtfcgY8UffrPN09Th01wILu6//QK8r3/J1sCM9YEwA
	HtWcyRGFtwZYW2OoG9HPhcY7zjVzuHRv3lN4G15n+gOOxdi6hKOD9Aw=
X-Gm-Gg: AYBFou1f56pD1oCHL+Ar79ETLuWHckdRO0icSL+povS2fO8Sb2Hu7jCLQw10rpAm7ME
	CgcskvzixIt+CQORsA71H4YufL8iRuQAeRCEE40b36dEgmy+hQ5Kr1k/B6492fdWnqezbyjEsEV
	tLmMm9xOQREYB3Ga2MzAekxIUac7uX36yZkY14YI99zklplYDsp6jZ3Se9Ipy5M+1sZLFP1Nu2K
	/uy0pTHQ7eLKgKwO4HMPzbkIeKP639ehSPQ9flplQjxShrg4DAAWl/nlVLGkw2M0GuQRsK+zB/Y
	hs0TPhuTfCDLG1kWdDPRt2br0lWtmefAYwkxsHOFMDbhow7xpfPd9Xy/RKpsFIty1yeIN64w7SJ
	Tnk8hXWCsU1/XyfL2AEGABVW75wt4tsPTCbetlsDapFjNJra+8b54Bs+iAlZGzX4RyR8ys2jP53
	DKLEvOilp6qtdtIgdDKZUu4YibP2F9BWO02fbAum4ok4bnWs6ilJMDsRw3scUngYM9W6jeWY6LV
	nwiNbeUQs3PyGT9/lyB4qxpMJSo7bD+Qp5f3Dv5QaoI2Aid5ny+/h9aLec47lcILWLW9M2Hhwdq
	m8a/HNfsWUawKxSt9zI=
X-Received: by 2002:a05:6000:2892:b0:48d:c186:dcc6 with SMTP id ffacd0b85a97d-48e6e5183c9mr24881547f8f.57.1793638425647;
        Mon, 02 Nov 2026 08:53:45 -0800 (PST)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b8e5f4sm21479385f8f.40.2026.11.02.08.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 08:53:42 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>,
	Oder Chiou <oder_chiou@realtek.com>,
	Bard Liao <bardliao@realtek.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Jorge Eduardo Candelaria <jorge.candelaria@ti.com>,
	Margarita Olaya Cabrera <magi.olaya@ti.com>,
	Misael Lopez Cruz <misael.lopez@ti.com>,
	patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	tristan@talencesecurity.com
Subject: [PATCH v6 0/4] ASoC: cancel pending delayed works on codec removal
Date: Mon,  2 Nov 2026 16:53:36 +0000
Message-ID: <20261102165340.1558853-1-tristmd@gmail.com>
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

Several ASoC codec drivers schedule delayed works for jack detection
and microphone polling but do not cancel them on component removal,
leaving handlers that can run against freed memory.

This series adds proper teardown ordering in four codec drivers:
rt5668, rt5659, twl6040, and wm8994.

Changes since v5:
  - Patch 4/4 (wm8994): add comments clarifying why mic_work is
    cancelled twice (before and after jackdet_bootstrap), per
    Charles Keepax review.  No functional change.
  - Patches 1-3/4: no changes.

Changes since v4:
  - Patch 1/4 (rt5668): correct Fixes tag from nonexistent
    e13da14e8543 to d59fb2856223.  No code changes.
  - Patches 2-4/4: no changes.

Changes since v3:
  - rt5668 (1/4): track IRQ acquisition with irq_acquired flag.
  - Patches 2-4/4: no code changes.

Changes since v2:
  - rt5668 (1/4): also cancel jd_check_work, disable IRQ first.
  - twl6040 (3/4): swap ordering -- free_irq() first.
  - rt5659/wm8994: no code changes.

Changes since v1:
  - Unified series per Mark Brown request.
  - rt5659: guard cancel with jack_detect_work_inited flag.
  - wm8994: cancel mic_work before and after jackdet_bootstrap.

Tristan Madani (4):
  ASoC: rt5668: cancel delayed works on component removal
  ASoC: rt5659: cancel jack_detect_work on component removal
  ASoC: twl6040: cancel headset jack work on component removal
  ASoC: wm8994: drain delayed works on remove and probe error

 sound/soc/codecs/rt5659.c  | 20 +++++++++++++++++++-
 sound/soc/codecs/rt5659.h  |  3 +++
 sound/soc/codecs/rt5668.c  | 20 +++++++++++++++++++-
 sound/soc/codecs/twl6040.c |  1 +
 sound/soc/codecs/wm8994.c  | 16 ++++++++++++++++
 5 files changed, 58 insertions(+), 2 deletions(-)

-- 
2.47.3

