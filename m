Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4826019C54E
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 04:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789272311; cv=none; b=ujo/jYzagdrMJGiIO74eCfIyTQ/TnWvnZFEc8m/kxI3GeYIBbWGOS8R2OAAlFlUTx+7KDtkLTh1MG27ucsqQ6JM7ph7P3u9a/cLXG66vo1mqs+ILI7GmsdAt05Chg86GFviCUj9WfOvvfwM9Uyo7d+FAhdStk5Dusb2JRXYn18g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789272311; c=relaxed/simple;
	bh=y0VCkdd6MdNfgfkdo72YtGDzxt8P1PR4Yg0G/UOw0XY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TikYOcPh4Lyhy7K2BKr/1X3d95ZcsiXvdChRd6UWBMp/QNUlH/Ee6+CcEb3Tce/lUn3Rb1xpPgSrxdGrolQPUoRKg33y2mMXB3Qa5pDI6gr6SB1EVJlnpOPKkHx+qtoIP+7jFOtQYHx9sQRi2OZUX6svZxi0YcR9oFvt4QeeyqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qp3znQ1E; arc=none smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qp3znQ1E"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4bf948737e1so846746b6e.2
        for <stable@vger.kernel.org>; Sat, 12 Sep 2026 21:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789272307; x=1789877107; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5Oa+YOncmCkkVL2k0GTFisduj2Byb339ftd8reg9zeE=;
        b=Qp3znQ1EhRAJtvcvnY786CY+/QrPT7ZavtQ+lFoOnuprIdxn4M3xYVduicHlq4nXhi
         CW0pMFAbK+UmYCrUmTvyD/SAE59+tbYkpN8uoqmnFAIIqsIlwvoh4VQPsPn+h8owMAeO
         DAPy6HYX+3XQBlZFZ5PSMHOzON3IKeVQXcSo7HEJZO1MYao7oWXwemQflNdjebcFLmDK
         A2bxZzenK2tVI4ckFhs704323hMNU/m1GJz/ZeDlokfhNnL31PvFwDpxrTB8/Uc+FS1u
         K6LUy/43pVNVCiG759LblBPlJuvGFYveORwKsxYE5EAjALpI+yvUyit8UgxoHcap6zAt
         M41w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789272307; x=1789877107;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5Oa+YOncmCkkVL2k0GTFisduj2Byb339ftd8reg9zeE=;
        b=PoOWqKR6jI32W4fKbgmBcMk6NFx0xfHzWTtTE5VjDhNSAkZnJgWv7xK2BE3dyJG5rg
         RXf9205cYtPGwrAAvPYeg7guwoKh0jw+XKtbKt37mpeRX74KGuP/PyAzMkGB+Jrpz7gN
         EXjBhmCGLjNQJkh60VnA+GHC23RseCOPIUXLf5ONRq266FuQCKo8GNvL18MADb5E0k1d
         B7iRDc/+UfLyiFqq1tdXK+mYrQvfMtx3X0Kk8K/jtWeVdEckY2IgOGKEkSWBRM6vN6Ob
         BXJxSUNFhfuiRRILaOI9kDPOjKmF8Jepz0DMzmeOQ9xUue/wRfzGNzWaZEhXY4qBuMxj
         gIig==
X-Forwarded-Encrypted: i=1; AKwUvBwSjE8DvjdyBZPBrvMfdASQfcZ7wu4uMunncTPTvdq+WbI8qbpXH1MHvheiQ8J2bvhvwxrFZf4=@vger.kernel.org
X-Gm-Message-State: AFuF++n/GOh1pSQJpzK37bxdJavK2YxT/feUSP96MRXIlimNOgZAaOMq
	QipuDccr48DYWenzMML+c4x6OxZptqC0qnOumb1ZisUXa4v4pg3Jvzdc
X-Gm-Gg: AYBFou25Nr3C9JKkoQRhD7qdqD1N02vzVQfomXj4Ewlwc297TfFIWTM5Z1fYaq9qejd
	Q+RfVTNWqUud0AjKPpaEmqNce1yskaN7jMh4HJ4+uwJldjnrOKoiLDFTS0Rp54mEDQcsTdZwPGx
	bXFnQBE+1wQYjITVCRDOdLgH/bw76a94fY35+zIUBuxjT+lnSNjXYfIOWWxqJwaJldci/UgKKhA
	ik5lUX2bek9l7PRw2vnKub67PcQOHkFr7fXFo+pqISOI4t/FWJLtlqrhsAhN/R+pdl3gel4Yov5
	4PEJYv60JaX+HQGlWlabn5PAkLdzgNsQ+IJrZn49802+sH6htR7vjUHi8qpt8wkndzN5IXAkZqT
	bKEkuxq3mA/aWJzZtdprrSRK3lrkJpyV4wL4ZTRooWfpEuHDEZtFtDhPr6kjnhfxnA9K8Ke51Ro
	IIeK99NGDpj9GSfwzQolhfObl1Jev+ILfCE3UmhCdSihjDQua440mquXr0FiNKgYMBs5R8AUb+C
	9t/OZRU7kR8TXLMK3vwUIDbCjkMVEzFDHNISeOjGqEaoU4o8FyP4MwkYMWxhhIyQ0o8HB29JNBW
	PLlJkhl9pmr//H0jyu7lsgxT0jgmrcNDAqigb6u6pewMM3qr80XGgPkMf1ADAFFqfVGzPDZXxAN
	/5ogLhKNE+fzVG4WRF2gEzvZXzR1Te6PlwBqORZm8
X-Received: by 2002:a05:6808:6807:b0:4c2:2fb4:3676 with SMTP id 5614622812f47-4c31bdfc3ccmr17088364b6e.16.1789272307014;
        Sat, 12 Sep 2026 21:05:07 -0700 (PDT)
Received: from [127.0.1.1] (184-96-157-145.hlrn.qwest.net. [184.96.157.145])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-47df8699647sm6011535fac.5.2026.09.12.21.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 21:05:06 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH v4 00/17] mtd: rawnand: sunxi: support the Allwinner
 randomized OOB format
Date: Sat, 12 Sep 2026 22:04:51 -0600
Message-Id: <20260912-submit-sunxi-nand-vendor-oob-layout-v1-v4-0-4a64bed94229@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5XOz2oCMRAG8FeRnDslk0Td9eR7lB4mf9QpbiLJG
 hTZd29WD7Y9WRgYPhh+39xECZlDEZvFTeRQuXCKLZi3hXAHivsA7FsWSqqV7FBCOduBx7bihSF
 S9FBD9ClDShaOdE3nESpC0IjGo3Sud6Jhpxx2fLkXfXw+cpO+ghtnfb44cBlTvt4/qTjf/bu0j
 QSz0t1SExry/XY/EB/fXRrEXFrVk+2leZlVjbWo5NrsDDla/2X1T7Z/mdWN7XTnrLSES/OLnab
 pG+X8tRicAQAA
X-Change-ID: 20260810-submit-sunxi-nand-vendor-oob-layout-v1-e3114d10cc9c
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Masahiro Yamada <yamada.masahiro@socionext.com>, 
 Boris Brezillon <bbrezillon@kernel.org>, 
 Brian Norris <computersforpeace@gmail.com>
Cc: linux-mtd@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2

Allwinner NAND firmware leaves the bad-block marker in the randomizer
data stream. On H6/H616 it also places all protected user data before the
first ECC step. These choices differ from the mainline format, which
keeps the physical marker plain and maximizes the H6/H616 user-data area.

Add allwinner,randomized-oob to select the firmware format for the
configured hardware-ECC geometry. Older controllers keep their fixed
four-byte-per-step user-data layout; H6/H616 use four bytes per 1 KiB
step, capped at 16 bytes, packed before the first ECC step. Without the
property, retain the existing marker handling and OOB layout.

Normal hardware-ECC accesses use the controller randomizer. MTD_OPS_RAW
continues to bypass both ECC and randomization and expose physical data
and OOB, including randomized markers stored by firmware.

Address the ECC-error paths as well. In randomized-OOB mode, use the
controller-specific vendor spare-byte erased-page heuristic on the
protected user data from the original hardware read. Older controllers
use exact erased-spare checks, including their first-page and page-127
signatures; H616 requires byte zero and at least nine of ten spare bytes
to be 0xff. Accepted erased pages return all-0xff data and OOB without a
raw reread. An all-zero physical page instead returns a bad marker and
an ECC failure.

Other ECC failures retain the original decoded data and protected OOB for
bad-block and flash-BBT pattern scans. PIO and DMA share this page-wide
classification, including randomized-format subpage reads. Plain-marker
mode keeps its existing physical erased-chunk check.

Prepend independent fixes for interrupt/completion ordering, PIO OOB
lengths, per-step pattern IDs, read/write error handling and duplicate
OOB program confirms, followed by OOB-helper cleanups.
These fixes also apply when randomized-OOB mode is disabled.

Also combine contiguous unprotected OOB reads and reduce repeated chip
setup and register accesses without changing the page format.

Finally, bound H6/H616 DMA batches by the 128-byte user-data register bank.
Keep the existing default OOB allocation and ECC offsets, reusing hardware
slots across batches instead of changing the format or falling back to PIO.
Preserve page-wide ECC accounting and a single final program confirm.

Assisted-by: Codex:gpt-6-astra
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes in v4:
- prepend an independent fix for completion reuse and IRQ timeout races:
  initialize the completion once, finish IRQ register updates before
  signalling success, and drain timed-out handlers before clearing their
  interrupt state
- add a separate fix for aggregate protected-user-data register overflow
  by splitting DMA transfers into bounded batches, retaining the existing
  OOB layout, ECC offsets and DMA support
- distinguish logical page steps from batch-local hardware slots, retain
  page-wide ECC accounting and avoid retrying partially transferred writes
- Link to v3: https://patch.msgid.link/20260909-submit-sunxi-nand-vendor-oob-layout-v1-v3-0-838cb0ba1547@gmail.com

Changes in v3:
- add a prerequisite fix for the logical OOB length used by PIO transfers
- clarify logical ECC steps versus hardware slots and share protected-OOB
  register indexing
- select the controller-specific vendor spare-byte erased-page check from
  the SoC capabilities, only in randomized-OOB mode and without rereading
  the main data
- retain hardware-decoded data and protected OOB on other ECC failures
  for bad-block and BBT pattern scans (reported by Miquel Raynal)
- retain a bad marker and ECC failure for all-zero physical pages, and
  disable the ECC exception for the vendor format
- share page classification between PIO and DMA, reading complete pages
  for randomized-format subpage requests
- propagate OOB read errors and defer randomized-format ECC accounting
  until those reads have succeeded
- propagate read/program setup, column-change and buffer-transfer errors,
  including extra OOB; stop failed writes and disable ECC and randomization
- discard partial DMA ECC statistics before retrying in PIO, and keep
  correction counts separate from successful OOB-transfer status
- select the current hardware step's pattern ID instead of slot zero
- avoid a second program confirm after an OOB-only write
- avoid redundant column changes before writing extra OOB bytes
- reject oversized ECC steps in randomized-OOB mode before the core can
  fall back to software ECC
- combine adjacent parity and trailing OOB reads in randomized-OOB mode
- remove duplicate chip setup immediately before core page commands
- program each packed DMA user-data length register once per operation,
  and write PIO slot zero directly without read-modify-write
- reuse pattern IDs and packed error counters within a DMA read, while
  refreshing the snapshot after every PIO ECC operation
- Link to v2: https://patch.msgid.link/20260904-submit-sunxi-nand-vendor-oob-layout-v1-v2-0-b12074f4aca7@gmail.com

Changes in v2:
- rebase on the current MTD nand/next branch
- retain the merged protected-OOB allocation, BBM reservation and
  stack-buffer fixes
- clarify that randomization is part of the normal hardware-ECC page
  format while MTD_OPS_RAW continues to expose physical bytes
- explain why a BSP-compatible BBM remains randomized in physical raw data
- document the decoded bad-block and flash-BBT access paths
- reject the firmware OOB format with software or disabled ECC
- document the BSP page-format compatibility contract and the
  older-controller format audit
- Link to v1: https://patch.msgid.link/20260810-submit-sunxi-nand-vendor-oob-layout-v1-v1-0-463853a14ad9@gmail.com

To: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>
To: Vignesh Raghavendra <vigneshr@ti.com>
To: Chen-Yu Tsai <wens@kernel.org>
To: Jernej Skrabec <jernej.skrabec@gmail.com>
To: Samuel Holland <samuel@sholland.org>
To: Richard Genoud <richard.genoud@bootlin.com>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Maxime Ripard <mripard@kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
To: Boris Brezillon <bbrezillon@kernel.org>
To: Brian Norris <computersforpeace@gmail.com>
Cc: linux-mtd@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-sunxi@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org

---
James Hilliard (17):
      mtd: rawnand: sunxi: drain interrupts before reusing the completion
      mtd: rawnand: sunxi: use the logical step's OOB length in PIO
      mtd: rawnand: sunxi: propagate page-setup and erased-check errors
      mtd: rawnand: sunxi: stop failed program operations and disable ECC
      mtd: rawnand: sunxi: select the pattern ID for the current ECC step
      mtd: rawnand: sunxi: propagate buffer and column transfer errors
      mtd: rawnand: sunxi: avoid a second program confirm for OOB writes
      mtd: rawnand: sunxi: avoid redundant column changes for extra OOB
      mtd: rawnand: sunxi: clarify OOB register and step handling
      dt-bindings: mtd: sunxi: Add randomized OOB flag
      mtd: rawnand: sunxi: support randomized OOB formats
      mtd: rawnand: sunxi: select the packed H6/H616 OOB layout
      mtd: rawnand: sunxi: combine contiguous unprotected OOB reads
      mtd: rawnand: sunxi: avoid duplicate chip setup before page commands
      mtd: rawnand: sunxi: reduce user-data length register accesses
      mtd: rawnand: sunxi: reuse ECC status within each DMA read
      mtd: rawnand: sunxi: bound DMA batches by the user-data register bank

 .../bindings/mtd/allwinner,sun4i-a10-nand.yaml     |   10 +
 drivers/mtd/nand/raw/sunxi_nand.c                  | 1158 ++++++++++++++------
 2 files changed, 827 insertions(+), 341 deletions(-)
---
base-commit: 7e874b1750a40f3dc9a629aeb72eba09c77f77e9
change-id: 20260810-submit-sunxi-nand-vendor-oob-layout-v1-e3114d10cc9c

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

