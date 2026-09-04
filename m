Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710CD44605B
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 22:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788561575; cv=none; b=OPqqR0bZ7IzWm4kO2dfe7nBFknNdL/LWUhffIoPE71t8WUcFJBi1NwvEBDclS5ZQeIz0rVjyjel92K0e8OwJnNXLeF5/+eGskDusETb+aEex0cW1QrZlUyxPRVUPX1cVkZAhh4SgvwPCddTJXEhcU/lAGRUOoc4E5rsKGkQ6e34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788561575; c=relaxed/simple;
	bh=iBM2Aon1Yd8l6bN24Yt2ji5Rw3iayumL16MfoDmzTJ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ovZPvygMSo0Yseo1sye8iJ0JXWQ65ZS9EI+AtIVAoOBIBHhAi35a6feBA/bxmEHksytQdxCSKorsJktZpX5C0vSh7qF8R51QL2ssMmhfCwTnYWfFQiCkvaCfUjvc1+/WXwvcvCQjW4U7sYJoxj7NhPruiktz66zQSHk8/Hw/g84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IYqH4o1A; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYqH4o1A"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7f5934ba2a5so969366a34.3
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 15:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788561572; x=1789166372; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5YxDY3gpgXUEyHB4LKpf5sbAqmUcywMUpLTIkNPDeQo=;
        b=IYqH4o1AP1c1AWeKaC+Xt3UD84zClv+5pji7iy6ErgpjwSWXJzzVtWXoy+Pds9rC3R
         y3R2KgttIifw1xkVKdRl+UXNqjXM3wiuTLEv9GWYYJybJA0Y1D1XjPuTypHNGdwqfT5a
         NqEbItxhiZn22NuDWHTH06VBpRz9t1QKrkucdqkVuNeAcGSEWDm4l1Bb6fD7pNZSOW49
         Xn9OyJFpu3h+FqIz6cZ1qhXoqMz1th3uGg0V36OQGZg46L7ChLOBc81ScvuTXhifB1ZS
         zQe8/mZ38d/nS/NPCwOegscd9hJGoxAdEkmiVTDd55LDEMmuhgOXfr2A67fVpsSyyfpP
         WVBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788561572; x=1789166372;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=5YxDY3gpgXUEyHB4LKpf5sbAqmUcywMUpLTIkNPDeQo=;
        b=XC3FnZEw4FUfPq1VcdW0fUkAqnf1IBieqa3r8tiOVSPCEW2/xDkSz6RF3jTTRAnQkC
         1rDmeUGgeq3tHr6rGCVO3ljTIkaByrEUvy+Okz4IPLzO+wdEGnpBNb2AVa++Ozs9hTME
         rs9jzQ9tvITz89RFgAWFwf0nNe2MMRr5KDwQqzIK+fSfYIvRkgbSSUu1Jcq1m8WChgPS
         xTBQIQFtlNmbwQOUMed/79SHKKoSR3lseuvhFhlD0mwfvqGvUcvUhYs3hhA7eKFsR/TZ
         GD+Y3AkqTOj/pZGnObeaKGvg9IRX+UixkoYiMYx3fKetmnTHIAz1cxvNAXziUr15Tf0y
         pXzg==
X-Forwarded-Encrypted: i=1; AKwUvBwFclEMqGW60ilyEwOVvSFSJg7dabrbQ3eYD8fp3JYZf890UvBNfpJxat697x/eCkGZwhFmLZU=@vger.kernel.org
X-Gm-Message-State: AFuF++l45nZRPiseDtCrR9ZhhykANaZgEdTk2YBirY9bc4uLoH/FVPez
	GVnSYf9Mo2LIXb4NISoCx1C6jwqsowyFAbIL50XBffVyBSz2oqFToU7E
X-Gm-Gg: AYBFou3hxLWxsRh3E7G/1phTy+zLHQMwZ5EvxvTYfzVP0tD7OzvQFaan8E3n5UmWwQD
	NLJcBG817P7ppBxFk6aDVYyDacTB1L3E+pZcFNOnQ2uRi09UQBRwhitl6G3PGOJMBrmJE3+0Dks
	LszD2mwB5QrMfP96XhvLKTaamnpp4js5X4C5dWSzWTLCgWXokRFRusrd8ecP5uc5a3uQwIZe5AB
	NJGO8Em7yl0Ppd2MHdW1JmjDFf+h6eT8iepHfl9obye8ayfj/C/doIEPXSynE85oUUcvE6q+3wN
	HxmvpkFckkhozHzyT+qLis72wP8T2AuALQUhM8UFHSEEW1FcDU42LdB1peqDfFXSNDotkALYTs6
	HR0bumDGb1/pFuX0yclUAFNarWKSdooJHfeODtwR97gjNTRZk5UAmzaH3D4aTnjneYyyaiFRX64
	UkbgaauI/vMiQfTP/hntC6UzfI3sijOctW4WLxEZhhcCbvXE/Wr98uf6knMtznTB9qEBZRQEcLD
	XC4mAfebcer/WiTa3/iFIptF8xTfbKHijetESriIZQMNCMEpkOBqXiX782x1KrtlXf6ri5sE0Kv
	Ez+5YsWOGarO2NGOwTBcya1MMxAUA+RHlrYHThZ5DU0S+1IrkbvAzcrE/ZXEdRorM3Vx+gsCxXh
	++DoTFVHp+POCsJwwV9Q=
X-Received: by 2002:a05:6820:1c87:b0:6a1:8192:4d89 with SMTP id 006d021491bc7-6b6fe2b1023mr6553755eaf.29.1788561572187;
        Fri, 04 Sep 2026 15:39:32 -0700 (PDT)
Received: from [127.0.1.1] (184-96-151-165.hlrn.qwest.net. [184.96.151.165])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-475523da013sm3488655fac.1.2026.09.04.15.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 15:39:31 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 04 Sep 2026 16:39:27 -0600
Subject: [PATCH v2] mtd: rawnand: sunxi: fit maximized ECC step to page
 size
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-submit-sunxi-nand-ecc-step-validation-v2-1-6e3ba6200948@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNQQrCQAyF4auUrA3EwdrqVcTFdCZqRGOZjKVQe
 nejrh7/5nsLGBdhg2OzQOFJTF7qETYNpFvUK6NkbwgU9nSgHdp7eEr10VlQo2bklNAqjzjFh+R
 YXUDitttS3w8td+DWWPgi8+/ndP63Q3dO9YvDun4AApqGjokAAAA=
X-Change-ID: 20260904-submit-sunxi-nand-ecc-step-validation-0e571088b5e7
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Boris Brezillon <bbrezillon@kernel.org>
Cc: linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

When nand-ecc-maximize is set, the driver unconditionally selects a
1024-byte ECC step. A NAND with a 512-byte page consequently produces
zero ECC steps before the available OOB bytes are divided by the step
count.

The older sunxi NAND controllers support 512-byte ECC blocks. Select the
smaller of the page size and the preferred 1024-byte step, using a
512-byte step for a 512-byte page while retaining 1024-byte steps for
larger pages. Unsupported smaller steps and controllers without
512-byte support continue to be rejected by the existing checks.

Fixes: 4796d8655915 ("mtd: nand: sunxi: Support ECC maximization")
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes in v2:
- fix ECC maximization at its source by selecting a 512-byte step for
  512-byte pages instead of validating the derived step count
- retain 1024-byte steps for larger pages and the existing capability checks
- rebase on the current MTD nand/next branch
- Link to v1: https://patch.msgid.link/20260811060651.227431-1-james.hilliard1@gmail.com
---
 drivers/mtd/nand/raw/sunxi_nand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 83666dd6cb2a..de1e6b49f79a 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -2084,7 +2084,7 @@ static int sunxi_nand_hw_ecc_ctrl_init(struct nand_chip *nand,
 	if (nanddev->ecc.user_conf.flags & NAND_ECC_MAXIMIZE_STRENGTH) {
 		int bytes = mtd->oobsize;
 
-		ecc->size = 1024;
+		ecc->size = min_t(unsigned int, mtd->writesize, 1024);
 		nsectors = mtd->writesize / ecc->size;
 
 		if (!nfc->caps->reg_user_data_len) {

---
base-commit: def559a215699aa2f2d8ef98f30156b9d562a154
change-id: 20260904-submit-sunxi-nand-ecc-step-validation-0e571088b5e7

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

