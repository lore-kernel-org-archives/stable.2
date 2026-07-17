Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B5A313E30
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 17:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784309668; cv=none; b=SJplhCUiOBNyACJJWzARtladUFnxFUZpRBs2LBfziOTn4RjDLCDrC9JrrJxCdZA10JEgUiOpdKCpqlAQiMrTZ4O6a5N5YFp6/ez7hMa2ea6/ru4gJXyGHbRy5M44/SjtlgSl7Xf6ScywhKsHpadPaFT6aWCnSmdh+tRDruc5jdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784309668; c=relaxed/simple;
	bh=8mTcF3LrBHm9pBuVinQPgEuDDUBku44k3jODpXxKvUU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZmiQi9W+cjgCfpWBQnACP0BsnkAH+4k3HCcYX9YgDDF+aYGRVICM7LWzLC53/3CLPa83N0j94FQ5OY5zFc2+XwOxak86SUjHl0qzpUR10T4kUsHXU6QH4sq1oYpLPH6O/cyBGmtcrFFPisxBl7Xl3SU/bSYXZeEZ006p2Oxwh2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K5kF2J8L; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5kF2J8L"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7eb1dc6bd53so4356161a34.2
        for <stable@vger.kernel.org>; Fri, 17 Jul 2026 10:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784309665; x=1784914465; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BLtDXAflMK2OGRvVokloY5BLx70bkl08IwDveQGG/q4=;
        b=K5kF2J8LceIsRQUIHajvxrODpJWRp/bY78P4F/FB2+fhgWtL9i/eEawWwJSV/xxGiT
         pjUv/8LhsgvaFMR4V0rwUWcqcFbp2iIAJJUn1RqO+2uDKB2pc1LbjxXBGR5moLXxiW5Z
         hCoaJREBP0R7HhyUMpZYkLKBX3hfHYLJTpStj2E9FU0hcCdP/pJjizHYm62nUmToU4kP
         rcRoL4AKD9E8QPC5hPMtXFkTl/vH5GpvaVNVk8NNgezvsCEph3x34FLw2GfneAv5P3Te
         ewd/e1b9PLeu16H/JnP4EQs/2dzb5rTpCFXnpFR+2Y8KTi9ygasPcX5Ojh/kynt5xnU7
         20hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784309665; x=1784914465;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BLtDXAflMK2OGRvVokloY5BLx70bkl08IwDveQGG/q4=;
        b=kmZ2tTc5N9uZGKLOA2dOWryqE2UeuTq2RrhqAQEmlfTYVXI4tf1WGzVelgLshAVxBI
         wGkdo1D54tC+C4rN+t9DHGl6nEHZhWKrQRLXVU+0HUmVl2mtafMXSRrdQFNlMeiXblCs
         F2zejLi+dNpu/O4KgJwMHQUT1O2IlzxDEEklajwxosueYk2OVPolX52pEFfZ5lnOxevx
         JfF+5ZuL/tRspIQxLlSK1a9DBvTqI5x02IVklsl3c6Pi/v3NkgH/vTlq4NmAtVwJrhh6
         hcWwaXrHzUzYTBgkkj0EKWL+KQge5FNhJWVsgVjXvPSjqoEFNvXu01wwtiB7OoiJ7NDg
         ItIQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqapq7LisjpMfIN6824fpCf0IE1cOUqcfGfbsbfZAeLb4gsO1JwXCZwKh14V+hn5fwV+FoPkUE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/16z6XfU3WopFtemkavNfgek02+5Vyf+qLZHESMJaFO1gJMqY
	q/zQsAWMQ2RMUMNX9Y29WR0p2ihG23zre41PcWj/FqKQ97XS71ovmhUa6PI4CfPrtaU=
X-Gm-Gg: AfdE7cnzM6NLFEPZ/buRFqgHwDwnPhT7CbHbCj3egFyHeWGPpko5SnT1EO4n59oeHQC
	cb8kvG4uOkG3dodfwkkAVRw4DDqUwOva99Y3bLFM69kjyWCBIwm0OQzWQAM+VVEIcmB62BOOKDm
	sQ9QDyvLzMFJokCG9i7ltfqEnBhlPoE0et2mM68L6CQy8c58OG88btuLG4OXIAxz9FkR9XNacHO
	HWY8mcOv/KbF57/93WaCefzvcUZ+KijlIRN1f1UDamsKI82KYjLbVukKhIVvgI2C41ScvadP6BT
	UPOnOe6ldkbg0oPAc/tZJVL235HnvG0/4fxdmkCli+Z2j2LHRFx9iTXjEFhZDZtyzBM6jwL6Pyi
	jMfKcme10SyGu0/ZGicI06xVVLgGtPpieblE4Yo0ByNl7koMmXU+x7H9IdcPUnZPoizAA8kXghB
	EGXAhUP3DaTGEdOHg0Za4VxX+2BAqZzRUE5GK5QpACiEjehim+rlcSPHyhz7QSgvJwtljBMBvZ9
	+508f0wPgjOSwafxkS8VNbnJr9PrDEXUJaE4xRtuatVrQjfJpYeQg==
X-Received: by 2002:a05:6830:2e02:b0:7e6:f7fb:9678 with SMTP id 46e09a7af769-7ed9aa576f9mr2021902a34.1.1784309665179;
        Fri, 17 Jul 2026 10:34:25 -0700 (PDT)
Received: from [127.0.1.1] (174-29-11-8.hlrn.qwest.net. [174.29.11.8])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7edad965130sm1677212a34.11.2026.07.17.10.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 10:34:24 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH v2 0/3] mtd: rawnand: sunxi: fix H6/H616 controller timings
Date: Fri, 17 Jul 2026 11:33:56 -0600
Message-Id: <20260717-submit-sunxi-nand-h6-h616-timings-v2-0-225515107640@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWN0QqDMAxFf0XyvIAWael+Zeyhs5lmYDaaOgTx3
 40bXDicl3M3UCpMCtdmg0JfVn6Libs0MExJRkLO5uBa59vQBdTlMXM1yMooSTJO3tZ5rDyzjIo
 h9snF2DsfMljnU+jJ6+/jdv+7RV401DMM+34AvMI2ZIUAAAA=
X-Change-ID: 20260717-submit-sunxi-nand-h6-h616-timings-794a2994267d
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Richard Genoud <richard.genoud@bootlin.com>
Cc: linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2

The sunxi NAND timing solver currently applies the original A10 NDFC
timing characteristics to every supported controller. The H6/H616 NDFC
uses two internal cycles for several setup and hold intervals and has
different delay-field encodings, so the resulting clock and timing
register values do not match the hardware.

Prepare for per-controller timing data in two behaviorally focused
patches, then add and select the H616 characteristics in the final fix.
Legacy controllers retain their existing setup-cycle behavior and delay
encodings.

Tested on an H616 board with Toshiba TC58NVG1S3H NAND.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v1 -> v2:
  - Split legacy timing setup from the H616 fix  (suggested by Miquel)
  - Move tADL/tWHR encodings to a separate patch  (suggested by Miquel)
  - Keep the timing lookup helper unchanged  (suggested by Miquel)
  - Drop the minimum-period helper  (suggested by Miquel)
  - Align H616 timing-data and capability names  (suggested by Miquel)
  - Add Cc: stable to all three patches  (suggested by Miquel)

---
James Hilliard (3):
      mtd: rawnand: sunxi: group controller delay tables
      mtd: rawnand: sunxi: describe tADL and tWHR delays
      mtd: rawnand: sunxi: fix H6/H616 controller timings

 drivers/mtd/nand/raw/sunxi_nand.c | 119 +++++++++++++++++++++++++++-----------
 1 file changed, 86 insertions(+), 33 deletions(-)
---
base-commit: 6f5156d7a31a8c3b0f34af4675c9299c8f877cbe
change-id: 20260717-submit-sunxi-nand-h6-h616-timings-794a2994267d

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

