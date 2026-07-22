Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311164C0404
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 10:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784717832; cv=none; b=Nbc5jbvN/yumIPp7CZJh+0tdavBiqZgjqrP9fnd55fgaPrJZBgs7hAWBbZ+86I6KS4+znF4KMBxrBcrMubUX8y/bw80AVQNOxG9toA+C0Zl4Xc/3fCNczdzOUbhT1HHNwvKw/7TEMX1Ls/N+60gV6LvkSCTQUdwwA4LMn+qNV/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784717832; c=relaxed/simple;
	bh=B9+O62Qxe6H1mnJ4OChCmotqXnWYm/eK8eBsbaRkPvE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z8TKbo4hFanNZLtiDRG8TDaBGEgjRguekh4RII8r21C3ALOg3tk178Z2um9P30kJNSmuLrIHXvAGyTAIOZcKU85NonD6vNhjsQNNXvorRJ9l9f3yabQyudjJTaaFP0sjVmnya9DC3lOsEPGnaCqni6BNKhA5ZTXGSkJg29JIXM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pTNfFEhd; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pTNfFEhd"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-ca766c1c9ccso7439659a12.0
        for <stable@vger.kernel.org>; Wed, 22 Jul 2026 03:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784717830; x=1785322630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oL47R6uIS/ybOhrX4ZH/w0z1fyW4ymKCM6yK0jT66lI=;
        b=pTNfFEhdz8JtC8Qngmc7/XokLRfsi8peJ8LyDUNa2vWecEmbN+UFmeImpBXntDwkHn
         ova/vWYRaLirUQg4gd91MGaa7X7gm7s28IyBznv4naJDf2Iud6gqvZK0MAzGUQnZGt+4
         9S6eTG/TUp5qhbzyEH1+JrUO4dlnYULNZVOZ+gQaQtRY9b01NUPk6OIojTh3pm96yEJX
         o9Te8OA2nf5E09sWpnQvHl+iEqmChyF+T41Byk2bBOJPPeDsF7ngb2NdXN6MR3Xdlp43
         bxqSt0zRJLsRyqmwPXbECRpRwV9LCfZKL19RTNEl+k7UaHOgkt+YqSlLLzbQrDUwx++A
         l3Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784717830; x=1785322630;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oL47R6uIS/ybOhrX4ZH/w0z1fyW4ymKCM6yK0jT66lI=;
        b=gfR2xyW3zeBYC+jY5qI2kzhm61y+MUBSTPCeEqYi0te79fxAGfpfT7F2fsr41bBOdT
         +nbJ3Kvfdwvq5+DE3W99ba8chLuS6MDOdIKGI3gB1C+YewzU96b52EtOcNLMnEmAxpO1
         AyI4AsDnFhO2+YC1EF+DmKe1++oYQahk/Ttg0Ctwtb7SkDBZR8ZCiKaz/rPLqmogulV0
         DceChLGo4DCw/33wsbi+GnBoHxMoF6lFoics+FUfsCHvSuYOlw9oRkKFIVfF2IQsy+pz
         Oo1UqsAeK0PbCsXELuCPWn40CHHszWNF2qtYZMjJpoD0LwR57g1Fxb9fONlCi2O4aRPe
         4lJA==
X-Forwarded-Encrypted: i=1; AHgh+Roa415yyJlAp2GlJkUybewutTijTgq8tqeM6tl5R+a2wYAHIQ2hokac737aLnSoMf2SjOtbiaw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7uRgL6i1X1kHhjHdW29p/YHIiOkDBFzvc4QR2jUX5HIyCJggG
	54EHbrlBB9Q0ehWNT+AM3tKLTCNmbS1jeDLD0SwCEZZnR43UidqWOHuZ
X-Gm-Gg: AR+sD11vfFQEnwSW3Q/+VDFM+iRv5jgGXB8xIlHzisq33GWokFgsMX59AiccHh4OjhD
	woA2GNjhYpE7YWV8293mC4MIL7Co3uAqhBfcrtWJRECWcHYZvQBLddeeb3xaI322Tfw4Hlcj/kF
	bK2kYGdH1urCcemPDDw6i6ATLBTviJYwMi7HdBKX/n2HrNmoKf2W9t+P3h2yQmBy+2EFP/Hotb9
	4A/0zEbkKOdz1rGnc9uKINPY5bkGaZx5sykGJF4vuOv5haiuPuk6TXHJUnvJ8xitVn4aGnG6BVM
	qGNv4HOrYBpZ0+SUdhw2aDJW9QgVmYtAZev9G4lBm9eluYezG3yFlZKVu3BtBXXuNi6LjDGINwt
	7t6JUiWJLBODSYu3Pn29Tdf8X1ibvBZn6PtvnNSeUPzoAiJSFXOIyndwZCAVth3lul4+jGh+igI
	4VqNuIg2sXzkx5ubPhgn49nYXhBiZIi4nlFCSvCx//fAhJ+N3NcSqB
X-Received: by 2002:a05:6a00:2e28:b0:848:5bd5:6e86 with SMTP id d2e1a72fcca58-84c29532751mr22016873b3a.53.1784717830094;
        Wed, 22 Jul 2026 03:57:10 -0700 (PDT)
Received: from DESKTOP-L3Q0GIV.localdomain ([203.230.195.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e17237c32sm1154781b3a.6.2026.07.22.03.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 03:57:09 -0700 (PDT)
From: Sangho Lee <kudo3228@gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org,
	Sangho Lee <kudo3228@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] freevxfs: reject invalid OLT record sizes
Date: Wed, 22 Jul 2026 19:57:06 +0900
Message-ID: <20260722105706.1385095-1-kudo3228@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vxfs_read_olt() walks image-controlled Object Location Table records by
adding each record's on-disk olt_size to the current cursor:

	oaddr += fs32_to_cpu(infp, ocp->olt_size);

The value is not checked before it is used. A crafted VxFS image can set a
record size to zero, which prevents the cursor from advancing and leaves
mount(2) spinning in the kernel. Oversized values can also move the cursor
past the mapped OLT block without first rejecting the malformed image.

Reject malformed OLT header and record sizes before using them. A valid
header must place the first record after the header and within the mapped
OLT extent. Each record must be at least large enough to contain the common
record header and must fit in the remaining extent.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Sangho Lee <kudo3228@gmail.com>
---
 fs/freevxfs/vxfs_olt.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/fs/freevxfs/vxfs_olt.c b/fs/freevxfs/vxfs_olt.c
index 23f35187c289..e5fb3b86d88e 100644
--- a/fs/freevxfs/vxfs_olt.c
+++ b/fs/freevxfs/vxfs_olt.c
@@ -56,6 +56,7 @@
 	struct buffer_head	*bp;
 	struct vxfs_olt		*op;
 	char			*oaddr, *eaddr;
+	u32			olt_size;
 
 	bp = sb_bread(sbp, vxfs_oblock(sbp, infp->vsi_oltext, bsize));
 	if (!bp || !bp->b_data)
@@ -77,12 +78,21 @@
 		goto fail;
 	}
 
-	oaddr = bp->b_data + fs32_to_cpu(infp, op->olt_size);
 	eaddr = bp->b_data + (infp->vsi_oltsize * sbp->s_blocksize);
+	olt_size = fs32_to_cpu(infp, op->olt_size);
+	if (olt_size < sizeof(*op) || olt_size > eaddr - bp->b_data) {
+		pr_notice("vxfs: invalid olt header size\n");
+		goto fail;
+	}
+	oaddr = bp->b_data + olt_size;
 
 	while (oaddr < eaddr) {
 		struct vxfs_oltcommon	*ocp =
 			(struct vxfs_oltcommon *)oaddr;
+		u32			rec_size = fs32_to_cpu(infp, ocp->olt_size);
+
+		if (rec_size < sizeof(*ocp) || rec_size > eaddr - oaddr)
+			goto fail;
 		
 		switch (fs32_to_cpu(infp, ocp->olt_type)) {
 		case VXFS_OLT_FSHEAD:
@@ -93,7 +103,11 @@
 			break;
 		}
 
-		oaddr += fs32_to_cpu(infp, ocp->olt_size);
+		/*
+		 * rec_size has already been checked to advance oaddr and stay
+		 * within the mapped OLT extent.
+		 */
+		oaddr += rec_size;
 	}
 
 	brelse(bp);
-- 
2.43.0
