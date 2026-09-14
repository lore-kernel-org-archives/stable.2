Received: from mail-oo2-f40.google.com (mail-oo2-f40.google.com [74.125.231.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81661415B76
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 21:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789420199; cv=none; b=U49CxIiG2q9w31reRiqYRk8Ev7LPZhq33d/pMhiHuEDwUtMHKFZCFmNmCgX1D1TVdJgPb5WYJDgNdCSGVToFMnQ6ueWtrC+UgbsMpP3z9+UgFhx8qJ0+qu2Yn89dsXYFLh/IpHyHmRDgoaw7V0D9VMnel9GiF4bML6JDbDAQ0kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789420199; c=relaxed/simple;
	bh=nzuQEWXCMUlFJdTepL0sc/JDwf/2fFgLg+mHa1bUxLI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OR3/abFWUp2DDsSJPZnBZhnv9yEvgTiJ8zGJuLiJ2lC0JuBDMv6YcY1L0slTV0xPw4JbpdhRTG1cDPSRz2tciM/f+Nl93lrj41wFLKrYoey3xf0tb8avynH0zup6NPzdSiVHKnnFb5Pj5Q5jnO3TnTYG1BpluAmU8iNOBucv9PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jyN1KrLG; arc=none smtp.client-ip=74.125.231.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jyN1KrLG"
Received: by mail-oo2-f40.google.com with SMTP id 006d021491bc7-6c24d19ebcfso1395646eaf.3
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 14:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789420195; x=1790024995; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XwTPxRgU+fYFHTYoxwRr5IV8pHvdn98ivroHogPVzFs=;
        b=jyN1KrLGILg118InC8Rch3QY7v+w8j1bAw+xq9OlZu+9XnlmhJxBq29iRlzHHkbOhc
         V+mJ0NwcszG9Y1Hks5T9OBFsubV+CQyk+OhPc2JdjBo42xVCGhoXZ6WWRptW3liOp/B5
         thSneRt4Y70wWrFOuVBgAhd+jQnU2TY/KejmORPSvp511Gk0LQZMVvRrrNNeII6P8crB
         lKlV8ewdAVUY2MSDh/1oZLzLWC9/bnftDeIm6JnpKhkqXeGeQWKKT51ccXky1lqQdY60
         NAOpKer+bvCgJnNDj59ql/PfUHInUNgugN92iPlalGAeuu7OTUNlnOBOs3csu9bPNTBW
         3y/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789420195; x=1790024995;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XwTPxRgU+fYFHTYoxwRr5IV8pHvdn98ivroHogPVzFs=;
        b=h4Ag91bwSzwOCGNX0gxwRopOc6taZL0H2wrHj2JoBaf82ppRGkW+5HJl7d01pWsArg
         rauPJSA2ntoH3ze6+WQ4OyjO8+JTqB+Nwa73gp+WSNy9DMDTFgQHG4rh8R/IqWSoa39I
         vStSluRZcthZwVPlXdZp/E9NYcjbNJwgyDdxou4wCi1Qy6q+1Kvyr7EPltPVm6AA79kD
         tT2h+meLLp1G/BVynQkTilHPZGVTYglo0JPpgwFOknxAhlOcwf7j8eOW45VVGZBeqsmi
         R++5/KxpkjSe93ItHlb3DWNVFqBXJluMAjd0R1y+Y9YPuNtVaL1Ryqn0Vx8x+YiwJAw0
         4GZQ==
X-Forwarded-Encrypted: i=1; AKwUvByi5BiaZRwmISslGYWqWvbHrVMdvJm4TtaQb8ZbrX8DM71Wtz5czr147y5D74USElls5as1ko8=@vger.kernel.org
X-Gm-Message-State: AFuF++kBgCQiGoIWm35x60S3vZh+Kc2O1gdJIJBOkBxJD0Ucx8cei7kC
	w0fZydSTdhBowHMs1okK8mHhIavVeG7GiielPp8MOVU4w1hZEotr1fKv
X-Gm-Gg: AYBFou0E+Ad5ReXb/JdWumzh3qszvVZ2oq6XHP8htAfpdWB4luCzyPVswVJYKdSvvUs
	6CMJFIGXwqs71TagT4Hungdt6IvRgY8i6zgUk0pvHIBcELWs/koZNE+aBefN+/EpLiIh35Mxnzu
	FB9zFUlFTbOb7xrtdbSg6lCBxniCZLPX3zXcm0Kbj+uDLqFfm504Xsg8AVZsS0j7egZ9g+HPvQv
	7W82XDYut+Nyjg+eoz4u4NIsoPL03cH9dw5NGwf3PiQ6Meom3t2IPjsuVmAtHye4rbRwH6Pg2sg
	2GoDW+IJW2xjLcXxOe/Ezcqzx1mGul49thA2l4m1QoI0KDKBcO4dtmhidtv1xjxKJ/UQXYeByFS
	fY4PqnW/GHFXDFLJQDPOWeLou89DJ1qtp+gAh/L9Wd1C6rC8wgoXAKqABgc7gbk0eVIet/oYyho
	EJBb17b5SlkxQTrhl4wVBe0FIBhK3cTNYO3ZbeiBApoAJZjEhcWvntmqix6roiMPHJfXOCUy0Qx
	HgbVdNwS2AFh9eBF6RdUyHK16EDDg/2qhKhKH31JkcMnzOWwrHDa9nhSCAiAiCiO2XnZrgPfkSS
	t0lll+wsNOJFBHyoEEJHdak8XMH3dqCAW/km+jWNrCXle/4LToA6tWz8EY1OmjbMW0E9NU7T3CP
	C6JaLPLYb6sESu5dWaIUiFKvkDQQj
X-Received: by 2002:a05:6820:c86:b0:6b7:318d:85d with SMTP id 006d021491bc7-6c5418508femr4548990eaf.25.1789420195159;
        Mon, 14 Sep 2026 14:09:55 -0700 (PDT)
Received: from [127.0.1.1] (184-96-157-145.hlrn.qwest.net. [184.96.157.145])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6c45bfc3fe9sm4698544eaf.15.2026.09.14.14.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 14:09:54 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH v6 00/18] mtd: rawnand: sunxi: support the Allwinner
 randomized OOB format
Date: Mon, 14 Sep 2026 15:09:46 -0600
Message-Id: <20260914-submit-sunxi-nand-vendor-oob-layout-v1-v6-0-2fb084fe0751@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5XQTWrDMBAF4KsErauikcay3VXvUbIY/ThRiaUiO
 yYh+O6R00XdZuOCQDwYvjfMjQ0+Bz+wt92NZT+FIaRYgn7ZMXukePA8uJKZFFKLBgQfzqYPY/n
 iJfBI0fHJR5cyT8nwE13TeeQTcK8A0IGwtrWsYF/Zd+HyKPrYf+cifXo7LvoycQzDmPL1sckEy
 9y/S8sTHLVqKkWA5Nr3Q0/h9GpTz5bSSf6wrcDNrCysASlq7JAs1X9ZtWbbzawqbKMaa4QhqPC
 JxRULcjOLyxFIo/GuRSmfjlCtWbWZrQpbuxpA1Jp092vbeZ7vGO3hYEoCAAA=
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

Keep ECC exception mode enabled for physical-pattern reporting. Uniform
physical steps can suppress hardware ECC errors, so classify them with the
vendor page check too and exclude their correction counters.

Other ECC failures retain the original decoded data and protected OOB for
bad-block and flash-BBT pattern scans. PIO and DMA share this page-wide
classification, including randomized-format subpage reads. Plain-marker
mode keeps its existing physical erased-chunk check.

Start with fixes for interrupt/completion ordering, PIO OOB lengths,
per-step pattern IDs, read/write error handling, duplicate OOB program
confirms and the extra-OOB cursor. Follow these with the small-page
command fix and the DMA register-bank fix, then the OOB-helper cleanup,
binding and randomized-format support.

Use page-addressed reads to reposition small-page NAND in hardware-ECC
read paths, retaining transport errors and the existing geometry checks.
Select PIO for those pages because the DMA sequencer uses large-page
random-column commands. Large-page DMA and the on-flash layout are unchanged.

Bound H6/H616 DMA batches by the 128-byte user-data register bank.
Keep the existing default OOB allocation and ECC offsets. Fill the first
batch to the bank limit, then use one hardware slot per remaining logical
step: PAGE_OP generates later main-data columns independently of the initial
column. Preserve page-wide ECC accounting, DMA support and a single final
program confirm.
All of these fixes apply without the randomized-OOB property.

Finish with optimizations to combine contiguous unprotected OOB reads and
reduce repeated chip setup and register accesses without changing the
page format.

Assisted-by: Codex:gpt-6-astra
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes in v6:
- retain the bank-sized first DMA batch, but transfer later logical steps
  individually to avoid PAGE_OP's absolute internally generated main columns
- keep ECC exception mode enabled for randomized reads on all supported
  controllers, using the shared physical-pattern classifier
- classify uniform-pattern steps even when hardware suppresses their ECC
  errors; skip their correction counters and preserve decoded buffers unless
  the page-wide zero override or vendor spare predicate accepts the page
- Link to v5: https://patch.msgid.link/20260913-submit-sunxi-nand-vendor-oob-layout-v1-v5-0-7d711076a6f7@gmail.com

Changes in v5:
- add a separate small-page command-handling fix: use READ0/READ1/READOOB
  with the page address for rereads and normal OOB access, and select PIO
  instead of the large-page DMA sequencer
- keep physical reread errors visible, preserve the OOB cursor and retain
  the existing ECC geometry requirements, including rejection of 512+16
  with controller ECC
- group the small-page fix and the DMA register-bank fix with the opening
  fixes, ahead of cleanups, bindings, format support and optimizations
- make the DMA register-bank fix independent of randomized-OOB support
  and the later register-access optimizations
- Link to v4: https://patch.msgid.link/20260912-submit-sunxi-nand-vendor-oob-layout-v1-v4-0-4a64bed94229@gmail.com

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
James Hilliard (18):
      mtd: rawnand: sunxi: drain interrupts before reusing the completion
      mtd: rawnand: sunxi: use the logical step's OOB length in PIO
      mtd: rawnand: sunxi: propagate page-setup and erased-check errors
      mtd: rawnand: sunxi: stop failed program operations and disable ECC
      mtd: rawnand: sunxi: select the pattern ID for the current ECC step
      mtd: rawnand: sunxi: propagate buffer and column transfer errors
      mtd: rawnand: sunxi: avoid a second program confirm for OOB writes
      mtd: rawnand: sunxi: avoid redundant column changes for extra OOB
      mtd: rawnand: sunxi: use page reads to reposition small-page NAND
      mtd: rawnand: sunxi: bound DMA batches by the user-data register bank
      mtd: rawnand: sunxi: clarify OOB register and step handling
      dt-bindings: mtd: sunxi: Add randomized OOB flag
      mtd: rawnand: sunxi: support randomized OOB formats
      mtd: rawnand: sunxi: select the packed H6/H616 OOB layout
      mtd: rawnand: sunxi: combine contiguous unprotected OOB reads
      mtd: rawnand: sunxi: avoid duplicate chip setup before page commands
      mtd: rawnand: sunxi: reduce user-data length register accesses
      mtd: rawnand: sunxi: reuse ECC status within each DMA read

 .../bindings/mtd/allwinner,sun4i-a10-nand.yaml     |   10 +
 drivers/mtd/nand/raw/sunxi_nand.c                  | 1178 ++++++++++++++------
 2 files changed, 846 insertions(+), 342 deletions(-)
---
base-commit: 7e874b1750a40f3dc9a629aeb72eba09c77f77e9
change-id: 20260810-submit-sunxi-nand-vendor-oob-layout-v1-e3114d10cc9c

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

