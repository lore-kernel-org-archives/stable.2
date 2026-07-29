Received: from mail-244108.protonmail.ch (mail-244108.protonmail.ch [109.224.244.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BBE1BD9D0;
	Wed, 29 Jul 2026 15:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785339738; cv=none; b=F6ye2nItBumTv/Gdy6Y9wSoKJtw2pgicg0ANzoLShxTMNVsvFmUiU+qspDfPQdej65zhnGUM5AW3bhU697X8Mj3DqjSe8KbzsstmMNXKB68hQ6f1IEvVtC3xJ2en7m8CdjHFLYKN0uE52Ovz7a/VVTDWJYylIRdvyXnVW+MQKRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785339738; c=relaxed/simple;
	bh=Olh4nNsDGaFJrsKVTyoGHF4VMzmjiVqD0B/Lv9+Pees=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=m7nMqGLyzCB03biqWFCkujZvn8ht61DGgTvdjSGLjlUms8JraMDAbncG/LX8Vdn4YS4SqrjMJA/A/CtP+gVIWazmIZmU0B35n5wGesG8FB+iTj29CEC9FQLj64LE8iUNRX6nZf4lgy4M4FltJRJbNzAqJX8OPoRYvyh3hF0F8bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=berg.pm; spf=pass smtp.mailfrom=berg.pm; dkim=pass (2048-bit key) header.d=berg.pm header.i=@berg.pm header.b=MADugjMw; arc=none smtp.client-ip=109.224.244.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=berg.pm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berg.pm
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berg.pm header.i=@berg.pm header.b="MADugjMw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=berg.pm;
	s=protonmail; t=1785339729; x=1785598929;
	bh=wffQpMSmMsUnw/XJJovvFrdoiKXOLa4H3fOB0O3IRJo=;
	h=From:Subject:Date:Message-Id:To:Cc:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=MADugjMwbr3ZAEPRIsbj1M6gfhup9tQjpCdZ3vpeQQ1desDvOk49UBTz9auQ6Oe/j
	 XDqbdSWMKdeLSloeT9HeWxyJSGNlraSlnetCudc6zGDahsMnqpqJTQOrwxK/KRMEdO
	 dzTL/k8c6jVh/FKi+g5MjY433GX2PwQWelazWmr3cCguPRukmWQUTl8ReXXNpPkmMM
	 yormlsufvSbogbLtgsvVe+TxMpxhzu1q6MkMHcYBvuWeJLFROhcaayGoJiYql2PxQ9
	 GkzKn1NHqhanEQiGGUQoQjn8Glx0GAPkYtlETyAW4O8YVsb1XQ/73nYiQlosxEnHW2
	 7E29ExtXldHIA==
X-Pm-Submission-Id: 4h9GmG6TwGz2Sd59
From: Jakob Berg Jespersen <dev@berg.pm>
Subject: [PATCH v2 0/2] media: i2c: Surface Pro 7+ camera flip fixes
Date: Wed, 29 Jul 2026 17:41:24 +0200
Message-Id: <20260729-sp7plus-ov-flips-v2-0-91884b81a8f5@berg.pm>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NQQ6CMBBFr0Jm7ZhSoCSuvAdhYcsAYxCaDjQaw
 t0F3Lt8yfvvryAUmARuyQqBIgtP4w76koDrH2NHyM3OoJU2qtQKxZd+WASniO3AXtAa50xe6Mx
 YA/vMB2r5fSar+sey2Ce5+egcRs8yT+Fzfsb08P7kY4oKizbLC6tMmTV0txS6q39BvW3bF2Bcs
 NfAAAAA
X-Change-ID: 20260720-sp7plus-ov-flips-b6cc645236b6
To: Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 =?utf-8?q?K=C3=A9vin_L=27h=C3=B4pital?= <kevin.lhopital@bootlin.com>, 
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>, 
 Daniel Scally <dan.scally@ideasonboard.com>, 
 Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Daniel Scally <djrscally@gmail.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Tooraj Taraz <tooraj.taraz@yahoo.com>, 
 "Joseph V. Lavigne" <jlavig88@gmail.com>, stable@vger.kernel.org, 
 Hans de Goede <johannes.goede@oss.qualcomm.com>, 
 Jakob Berg Jespersen <dev@berg.pm>, 
 Fernando Rimoli <fernandorimoli11@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785339726; l=3708;
 i=dev@berg.pm; s=20260719; h=from:subject:message-id;
 bh=Olh4nNsDGaFJrsKVTyoGHF4VMzmjiVqD0B/Lv9+Pees=;
 b=W45znt+mDZOWRsU8Bd0iwSvIaIEaOObgKKrcHr1+BHLLQz3btmCUBosU9iLJ4AtR+/7oxs1uS
 i1W/UYMFICICokBUGp/dHLsUnekFgjk9EqdokfAL+1rkGm251fBDsKB
X-Developer-Key: i=dev@berg.pm; a=ed25519;
 pk=b1r+eoJThwSQ/r5DjO7jrcosyrIsyhlOuKk9CBdvBxs=

This series fixes an inverted horizontal-flip control on the two
OmniVision sensors of the Microsoft Surface Pro 7+ (front ov5693 and
rear ov8865). Both sensors are mounted with a 180 degree rotation (ACPI
SSDB rotation 180), so libcamera requests HFLIP=1+VFLIP=1 to correct the
mount and, with the inverted control, gets a mirrored image instead. The
ov5693 patch additionally compensates the Bayer phase, which shifts one
column when the flip bits are cleared.

The inverted-HFLIP behaviour has been confirmed on three platforms: the
Surface Pro 7+ (here), a Surface Pro 9 (Fernando Rimoli), and a Surface
Go (Hans de Goede).

  1/2  media: i2c: ov8865: fix horizontal flip control polarity
  2/2  media: i2c: ov5693: fix horizontal flip polarity and Bayer phase

Note: bringing these cameras up on the Surface Pro 7+ needs two
prerequisites this series does not itself depend on -- it concerns only
image orientation and colour. The ov5693 front camera streams on IPU6
only with a MIPI clock-lane-gate write being added by Fernando Rimoli
[1]; and the ov8865 rear camera powers on only with an int3472 POWER1
regulator mapping I posted separately [2].

I discovered these issues independently, though the motivation to work
on the Surface cameras came from the linux-surface community. I'd like
to credit two parallel efforts there on the same hardware family: Tooraj
Taraz observed the inverted feed while adding Surface Pro 9 camera
support out of tree [3], and Joseph V. Lavigne posted an RFC enabling
the ov8865 power supply on the Surface Pro 7+ itself [4]. I have not
drawn on their code here.

Thanks to Sakari, Hans, Bryan and Fernando for the review, testing and
suggestions on v1.

[1] https://lore.kernel.org/linux-media/20260720163819.104130-1-fernandorimoli11@gmail.com/
[2] https://lore.kernel.org/platform-driver-x86/20260729-sp7plus-int3472-v2-1-cdfaf97ac3ad@berg.pm/
[3] https://github.com/linux-surface/linux-surface/pull/1867
[4] https://github.com/linux-surface/linux-surface/pull/2201

---
Changes in v2:
- Simplified both commit messages and the code comments (Sakari, Hans).
- ov5693: dropped the "like the ov8865" cross-reference; made the
  message self-contained (Hans).
- Added Fixes: and Cc: stable to both patches (Bryan).
- Picked up Reviewed-by (Hans, both) and Tested-by (Fernando, ov5693).
- Dropped the RFC prefix.
- Retested on the Surface Pro 7+ (7.1.5): both cameras correctly
  oriented; ov5693 colours correct (Bayer compensation).
- Link to v1: https://patch.msgid.link/20260720-sp7plus-ov-flips-v1-0-5f345b0673de@berg.pm

To: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
To: Kévin L'hôpital <kevin.lhopital@bootlin.com>
To: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: Daniel Scally <dan.scally@ideasonboard.com>
To: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: linux-media@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Daniel Scally <djrscally@gmail.com>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Tooraj Taraz <tooraj.taraz@yahoo.com>
Cc: Joseph V. Lavigne <jlavig88@gmail.com>

---
Jakob Berg Jespersen (2):
      media: i2c: ov8865: fix horizontal flip control polarity
      media: i2c: ov5693: fix horizontal flip polarity and Bayer phase

 drivers/media/i2c/ov5693.c | 12 +++++++++++-
 drivers/media/i2c/ov8865.c |  3 ++-
 2 files changed, 13 insertions(+), 2 deletions(-)
---
base-commit: a52e6f7923c17a672135b485ffd96fbd72f46267
change-id: 20260720-sp7plus-ov-flips-b6cc645236b6

Best regards,
--  
Jakob Berg Jespersen <dev@berg.pm>

