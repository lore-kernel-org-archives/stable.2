Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEE73EFD3C
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 10:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783421073; cv=none; b=JP92Qd9mIn2jRSmfBfD+VeXZ0+Af35dZETmihd1Bb+iACJQ46k0BGRZPoIbW/4Q+RVZjeyMK2LZI5Q8Q/S7c1EZJYFZgrJog7Cdey+6Ih6p/ZVHoFt+S6vWkIP6q25Tn0DpjrJ9QHT1R6Wx8Lryre854T4b/vxPg6eCa/JfKVkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783421073; c=relaxed/simple;
	bh=c4DuEQXoYdUlj9kPvWQg6xKpQiaW5B+oIzP0uipvjbA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s/8X2KnbEEOqBZI/nC/lV4agehJOuh25lpCikgku3hDRCpiXCkBN/jy/Zih1jaMUOuR06Nvj1oltNKkcPxvx0A0W44SQMuzyirlU+j22KM4mbM4VGjCZ2RzzwHYFqjUQGZzCnNt4b+y73DyYY1/qa95Go1nyfVmCrG2O8BULmH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DEbxq4hW; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DEbxq4hW"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-493b7612475so37739965e9.3
        for <stable@vger.kernel.org>; Tue, 07 Jul 2026 03:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783421068; x=1784025868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4LDYgyzNvpU9k9285LEQE6swWCWmhGuoOR6Z4V9Ca7E=;
        b=DEbxq4hWM0PsD7zN4F24ENiFCe+5VPPUzG6NKab9aKJEHTPihckU2ftB+kA+QvHXGM
         RQOtlwJ0e+g7J+SI3v3NebLdJJuem+W9SMeFNe8jZPCfw30eaYw6suWp5xiG0Goe7oR/
         /v6MvSBEfk39i2atvy2VZnzJWg4SY11/mBBFT8ydZvnv9nmq0rGZ2HJJRzXG10yqMSkM
         t2Hl6zz0AZ1PMzDuC61aIejbZSeyxSf48WqWinsm5svQReWz6o5AGlo6/khCfsIvMG95
         8VuThXs/8v7AaRQxtlrAn1BceWKquX1Hj8GhBgJufAE4cNBvtpvE0cZqCl5S7LgMHiXC
         kwUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783421068; x=1784025868;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4LDYgyzNvpU9k9285LEQE6swWCWmhGuoOR6Z4V9Ca7E=;
        b=lRNG8tDeQ7b7Rs8a+hO0bjE/gn5m6nV0l/U5EDlzL4nKznEOXqevSbkiqZfpoB/jzx
         J9Bj17PFS8A3w7guD7Y05+bMZkadzhqxL+fhg+ItLLRByZJ0Pzl6edjv/XEoLb1ciyXV
         F0cdKi0MVvW0A7npr3nMEejbU7WRPDyce40qeP1RtWMBzuoQW7MAP+KN3iCRk5GiISmH
         fS9QneZe4OB39Ji2h2bKoo4TJ5nAZrdM8rR4T+mWDLc7U8EpZhxXGyapTtmTLicMf5Uw
         R46XNcR6h7QTg71v5LO7+EAYH2plHJ2cIVRUm6uFjTp8NzXYFlisvWyr88vKEH1mjNdt
         4q2Q==
X-Forwarded-Encrypted: i=1; AHgh+RpY0O8jdBr+OerCAOsZyOzeTzbZTjxqTl/g8Tok/aaNVXX59UaIetr/1B3+LskZZl871uGnMZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSnUiQdDHihI0t56KBb7ITPWcALfeB1xcNAzZ91kfR7A4U4rhI
	EN4xs/4pjYTI/vOuA57tV/Q83qmYlzuDftQtkHWdsTCaWPa11JgUQwjG
X-Gm-Gg: AfdE7cldglCPDJmGVjtTyD1LpEoe6amD3d965I3xcERHqowp8oJtqSbVHwhbJgo+MiZ
	e13o6eUIl1ARbtdAKtBafEVz42Fna4iWnMOW3nm65vYtLMx8eIkhHXoJ3jgKPWSJAxZrPwdwtOq
	L5fQJqIgL9UWZSqF8tmi6GMPvGKOi+UfqbgO8Kka2q79GMwNQ6ITkfnD9PEKyFNkivwI2J2mqp2
	XbTTboWekFFjVtKY/4QLN8S8WlTIgylwoeGjR1nbD5mUeLps2dZcwi1H8gD1TwNbjTnInc0NeNk
	2MoPZ/42fXxKEt1a3BQocJGJ+EmsZA4PRMTB1qGTX6dJLYCYyg7CFZkzB9hIf8Z/7GggqVlIxFw
	645tZLbaeG/whS9bwVBxhSGKWOWH7EyU8HU9wpCaEbSsBTkL/b+ezFsqe3cYr+BEtauybRU+SSm
	rosuNLs3eCguAHN5duPG+qI0eAtaisX4g/kNsFYJRjuYDD95GeIWNlSpe4Pq2ecsfGBa7b7C8uh
	ahdrmexaCkiTPVfWuAnlh6TSg==
X-Received: by 2002:a05:600c:8119:b0:493:d2b1:48d2 with SMTP id 5b1f17b1804b1-493df062c54mr52553535e9.2.1783421067487;
        Tue, 07 Jul 2026 03:44:27 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:9ca:c182:d5fe:87bf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d905sm33223586f8f.2.2026.07.07.03.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 03:44:27 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org
Cc: wsa+renesas <wsa+renesas@sang-engineering.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH linux-5.10.y-stable] mmc: renesas_sdhi: Add quirk entry for RZ/G2H SoC
Date: Tue,  7 Jul 2026 11:44:17 +0100
Message-ID: <20260707104417.105834-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

The RZ/G2H (R8A774E1) SoC uses the same SDHI IP as the R-Car H3-N
(R8A77951) and requires the sdhi_quirks_bad_taps2367 quirk.

The 5.10 stable backport of commit 77fa80a1b732 ("mmc: renesas_sdhi:
Add OF entry for RZ/G2H SoC") adds an OF match entry for RZ/G2H.
However, unlike upstream, the 5.10 driver applies SoC-specific quirks
through the sdhi_quirks_match table. As a result, the required quirk is
not applied for RZ/G2H.

Add the missing sdhi_quirks_match entry for RZ/G2H ES3.x.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
Hi Sasha,

As requested [0], here is a patch to add the missing quirk entry
for RZ/G2H SoC.

[0] https://lore.kernel.org/all/20260706135124.draft-0005@kernel.org/

Cheers, Prabhakar
---
 drivers/mmc/host/renesas_sdhi_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index c0acb309e3243..f02f9ef5cfbc8 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -903,6 +903,7 @@ static const struct renesas_sdhi_quirks sdhi_quirks_r8a77990 = {
  */
 static const struct soc_device_attribute sdhi_quirks_match[]  = {
 	{ .soc_id = "r8a774a1", .revision = "ES1.[012]", .data = &sdhi_quirks_4tap_nohs400 },
+	{ .soc_id = "r8a774e1", .revision = "ES3.*", .data = &sdhi_quirks_bad_taps2367 },
 	{ .soc_id = "r8a7795", .revision = "ES1.*", .data = &sdhi_quirks_4tap_nohs400 },
 	{ .soc_id = "r8a7795", .revision = "ES2.0", .data = &sdhi_quirks_4tap },
 	{ .soc_id = "r8a7795", .revision = "ES3.*", .data = &sdhi_quirks_bad_taps2367 },

base-commit: 738ac465e4e900d4a391a27da4e20c090eaa1e75
-- 
2.54.0

