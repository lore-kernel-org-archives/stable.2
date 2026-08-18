Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAFD4657F5
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 11:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787053349; cv=none; b=Pq/t5t+QLTuL4AuAmwFng54Ca56XHbFExOqB/EkKM4eIq0gWsDVEMkBS1/kU1Lxv5JqDIw40Qqd5oARy9qK8X5AYQQ3JQQdknH7Y1AD5TZ+//zvSMQX0vuW1iTaW1kt/QcS9VAgQN0o/BC6ROY6y86z0/iYBzLjyjg+ozZmKOnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787053349; c=relaxed/simple;
	bh=IOpDNvkEnFnrZ6EcBnAkBbqLV+BZ1aPCJvKd0Hacm2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=POcleANlOnpQ8OBXun/lvfcgjUR6IoxS/yEElrkbRMpP9AoqrXXAMQAuoSklrJrDyNmtt7xDoocaCdBNkI19Md2OF4yFNIdHvM64IPDMLibhqv17Hpw1vR0543Y3y37SbLjsjxMJQVLBf3P3+/3jkYaAURqH8/dWVB0Sd2ePbxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C43VYSh2; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C43VYSh2"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47f93b2fe4cso2497252f8f.0
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 04:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787053346; x=1787658146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C0Lkar/FZUF71jSh3gVWEuj9Qdc3ucoRXfitsWLZ7XY=;
        b=C43VYSh2KNpRpo85M/DzIlVGk6Bz01GVBxX/5aWpma8P0A+hus02T6VkxSJvnzSmN+
         QvbPKGxl6koF3a3AMZJz8o6utCoVDKGTRCSqyYREyoWy1DzyVbu+SmEd0PTeVEjHUSar
         EdGIfUVvBdiukzJq0iC4tSjeKZgy6Xacix032U+V1hk0BfHgoa+oWn3vhbLDgYEXZX7X
         iKKWY96q/H/RqqDWfduc2/0EFbal9X9K+55Ehly1lBIfeCVSQt7+NznVSO2TT3l4y4wO
         5+ClNCferrr1X3oRHiaWMj3yJD/ADPlp07V2WPOyZ/RRlXOVudBamYYqzcRCaLuiw+Ye
         kpjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787053346; x=1787658146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=C0Lkar/FZUF71jSh3gVWEuj9Qdc3ucoRXfitsWLZ7XY=;
        b=KAsxHaHPf529lUzE8aro8YOmfmqIvsKIb7GC79nJhIY8y8wolwq+HkHEAdIeAG6EWs
         iCPaO6xhj4RdsCq8eTsfSlYnVPUzvWL2I6WyWbRGbPDGE4iDDRBPyjjoKQWVEWyfO89n
         yGsxPStdMRjSbmfbvlqmMlmeuTJDkPXym7mqbCpn2aavweJhVRddPb9CWGO5fH33sP+N
         jnVs49dVa7CElOVGVx0XdkWizwiovDIGTpVa3fT6B0w7wfwc3kQbtqQfnV4Zv5WxIeuA
         M89nNdRjonzXBjUMX0MGgOV5EHWfiOgAm/xLL8rsnT+pMT7TbFsjhFTqdN7Ez51GC3zH
         phIQ==
X-Forwarded-Encrypted: i=1; AHgh+RrU2tQFOlwLG1DOa51rEuzbaQAbr2L8fFVX/ScWtKEzXWfe7CNv7A9XSqgxyBQGB0NoSUOcCMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkFK5F4DvNwKgpapQHGId4TuzcUhO3k5A34WmKuvM66heH8V6A
	HxeBOX3wdv6QjoSm9Yx+uHN+q1gUMz/WFivtWDb9d+ItuxYohj8/dOCv
X-Gm-Gg: AR+sD111mKzsudIJagGmEuJyy/kasQGt9EeiU0+RtK4dyp+cBMLjNzFttlK9AuW0ClQ
	PSyge8SW21VWsc3zZO66iPLYV0WT3W6mi8gIoOnnSb3/BTvLgU/ndoqw8FNGyoDtT+zShxaom2N
	I5VItLCbKo0iyQ2oJe0hPBNvsVtaWCwgDxPhv2H8q2yB8UjD7so21wvpQ/2BexLeDpp6tbbT9vN
	PNCv2yVx1lvP2P/kgC1Dc4AjHZl65a9xytOs3P0Ju0mQhKbNFN9jx/WivKB9CoXZz8OytchVIeP
	rm9h1HG0IxsI6z8v+7EqV2eYCwC6c/F2a25ySIzwRMjT1B9KeA5flhw+x/MFdrDZDf3/qxCaeXl
	qsUrkMgfMtP8sjuUX2jVkNij8K3F/cP0EXn+DoSTj/DX2X25WVPtX9I0n8NLqTTz6DlRHmjm/E1
	vV8PWILVVnXCy3WNDk6qcsCmE50oA0W0+4H/0Qz6cXkFKc/+y30wHzuq8I6H7zou3B0A==
X-Received: by 2002:a05:6000:290e:b0:47f:776f:3838 with SMTP id ffacd0b85a97d-481606f682dmr48887208f8f.6.1787053331518;
        Tue, 18 Aug 2026 04:42:11 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4998780397esm28680785e9.3.2026.08.18.04.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 04:42:11 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Stefan Agner <stefan@agner.ch>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: Mehmet Fide <mehmet.fide@screeningeagle.com>,
	Boris Brezillon <bbrezillon@kernel.org>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Edward Karpicz <webmaster@toradex.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] mtd: rawnand: vf610_nfc: fix reads on chips with more than 64 bytes of OOB
Date: Tue, 18 Aug 2026 13:42:07 +0200
Message-ID: <20260818114208.2780311-2-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260818114208.2780311-1-mehmet.fide@gmail.com>
References: <20260818114208.2780311-1-mehmet.fide@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

The driver only implements the 64-byte OOB layout, so attach_chip()
shrinks mtd->oobsize when the chip provides more. That clamp does not
survive: nand_scan_tail() runs nanddev_init() after ->attach_chip(), and
it restores mtd->oobsize from the memory organization, which still holds
the value detected from the chip.

The driver therefore transfers writesize + the chip's full OOB size, so
the hardware ECC parity ends up at a different offset than the layout the
controller was set up for, and every ECC-protected read fails with
-EBADMSG.

Measured on a Colibri VF61 (MX30LF4G28AC, 2048-byte pages, 112 bytes of
OOB): with the clamp lost, UBI cannot read the erase counter headers of
the pages U-Boot has just written, and the on-flash bad block table
written by an older kernel reads back with ECC errors, so the board does
not boot. Kernels before commit a7ab085d7c16 ("mtd: rawnand: Initialize
the nand_device object") are not affected because nothing overwrote the
clamp there, which is why the same chip works with a v4.4 kernel and
with U-Boot, whose copy of this driver has no memory organization to
restore the value from. Edward Karpicz reported that the clamp no longer
takes effect on this chip; see the link below.

Clamp the memory organization as well so the driver's 64-byte layout
stays in effect, and log the truncation once, as it decides which
on-flash layout the system uses.

Reported-by: Edward Karpicz <webmaster@toradex.com>
Link: https://community.toradex.com/t/colibri-vf50-vf61-on-the-current-bsp-mainline-u-boot-v2026-07-and-linux-6-18-lts/30735
Fixes: a7ab085d7c16 ("mtd: rawnand: Initialize the nand_device object")
Cc: stable@vger.kernel.org
Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---
 drivers/mtd/nand/raw/vf610_nfc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/vf610_nfc.c b/drivers/mtd/nand/raw/vf610_nfc.c
index 9940681810cf..f27ef2b0884d 100644
--- a/drivers/mtd/nand/raw/vf610_nfc.c
+++ b/drivers/mtd/nand/raw/vf610_nfc.c
@@ -771,8 +771,14 @@ static int vf610_nfc_attach_chip(struct nand_chip *chip)
 	}
 
 	/* Only 64 byte ECC layouts known */
-	if (mtd->oobsize > 64)
+	if (mtd->oobsize > 64) {
+		dev_info(nfc->dev,
+			 "using 64 of %d OOB bytes, ECC layout is unchanged\n",
+			 mtd->oobsize);
 		mtd->oobsize = 64;
+		/* nand_scan_tail() restores mtd->oobsize from the memorg */
+		nanddev_get_memorg(&chip->base)->oobsize = 64;
+	}
 
 	/* Use default large page ECC layout defined in NAND core */
 	mtd_set_ooblayout(mtd, nand_get_large_page_ooblayout());
-- 
2.54.0

