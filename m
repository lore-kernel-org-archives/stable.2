Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6979446066
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 22:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788560285; cv=none; b=mmzItJrxX1xvKD6EaXUTo+7K8+GLbD+DV7TJLWUqrEG7VDGi6LSud6qfFLN7SgLxiz/hbEMmaUBVuctIxrYCCM9tRqtnvNjR5gf3uJ8chmSe1kEAoFN6BMDAqP1YjtzyPi+U4NWYmOFJgIq8Mmn4NCIrKsjWWvFXZVzH2tcd3pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788560285; c=relaxed/simple;
	bh=M3ljDf5cp1LAD/hxypnrKeBycVDg5CrbHCeWC0NTb5Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=FKubaTlKRo6JlE1cKXI0TuXmQUZYru77tmVI80DaO3GSSfheJoZ5JtSLyskLRhsvL0DYNKBJ6R8e4alv0PW2HycPPRC82UEsrgWdfxq3aX3A73TtuaT2V1vc1TTvweV5IG44c9s1dIyeIgMwGkfdvfC2BA7Fll+SKuTUMZ4XZbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sB8d7N9x; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sB8d7N9x"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-4b38ea4c63aso1373427b6e.1
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 15:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788560282; x=1789165082; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=937oNA2R/MB70KQ5+NEYQ+AXWnqJFM7/BAjPlSp0cIU=;
        b=sB8d7N9xR174ERGeKGUXgcU+Qim0RlcUSFzZeiU8VJGI+W7BZPV/hm8c0zRm+b8Yup
         o2s0j6wsytdH9I3E/7rfYnsnaHDOOZMa9taEfbBfkIOvtEH8ywzwzUuK5HUkMYUNAtTQ
         yWXzZvnZ3iFUp/Hf8vAjv7jvkEl+yYx3m0SepPTYJ47CErTY5VZCKMcMyYvptgQ+9VHi
         mwpJwh4xsPY8AZOyrDRrGu1u5w9ik/R1CAAWGIV8oztZHnlKF/OvTDxHOS6dTPuRq+Ll
         W2ItJYvLX30TAidDLWBZsqwjNXY9wipp3iCtSoMRJWOpH1rRPyupjuUWOWWJSgA8EOBF
         /nNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788560282; x=1789165082;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=937oNA2R/MB70KQ5+NEYQ+AXWnqJFM7/BAjPlSp0cIU=;
        b=bzwHVYwrUoay9bVVK39F3TEdr/1pdOe5OELH7Gm11/OAwVreZ1OC0iONuUL52LEcSV
         YQ+R68PhdGLY3QytNwU80S5Xu5m7DWO6hjJ6broWAOFVI1CtoPBSIQ1WDt/itKQZVBUi
         e0I8eK+OYdA+o0u59EShiBMHQR8IWJJXRm/8l5Zmg7qYBCbZ4j/7dvghWa4/jq06hXB7
         iqcZ1uD8z0pka6KMbaweF6c+EpkfrbrBKi0+qPvTl5pv8s1r+2aPjgoQbppJpyHOZw+R
         2388++6OeSJy4HY7hX4tdfFmDczb3sa6swMZ5wj7FTFZeaGJpsU/tnR505I/qkUKPeKb
         ymHQ==
X-Forwarded-Encrypted: i=1; AKwUvBxpz8HE9KC1U8hE0sPADkqv/mUsuAlcafv7tsEOERHu2+r0ybqqMszhFwayPI0OctjRX/65Teo=@vger.kernel.org
X-Gm-Message-State: AFuF++kltugzScxf26KxTcVPHw5HkytcZ+MTVFiuZaIMQwaI+GrQYWF+
	jnfKFbMtlVfA/5zGooh0rjzWmLm4SZq46xQLhdTq2SPU6IC9x4liXoLn
X-Gm-Gg: AYBFou3r42ek7Z4LWWNKS+eaM5pyX6nz6kRwaL0WUHdUFQjObu86wbxxSOnGsrzLNa8
	tzy/WSmFiOZN+3mJc0rG1+xcBfqyBMrGek8MXApdhVuCxSxT3TEBFiND7XRRdnfZ0BryW0CKNEj
	Q69+60tYZCvNre9gTpNfcOZfnX1DTC+JYAbH8xezym4mbG3xQSvk+0bMg5QWBtnX+ymV4VGhxxx
	+TTFYqE6I1FwEIJNiL95qOczxCqzJ6CMc87HESSjzOhdUAFvYHegr2F56dVNgDK73rPsPcjNQ/T
	nVuEZU54z3lyvfPM1KgJRunOGi9JnIURiIKtPmq3GfCB7fvVjgV3ZIFC7H0VgyRUgU+aNTd/5gV
	Osdzc95QNIoTPb81gJsl4W6w10NQRe1ZT2aAlBVo0nOy/tCtf2FIT6xf95uwushY+Mdk17w1pxn
	M+sok9Typke5gakoj/Dde/yKc2I02IPEXJvva0ZfNeMgvwz/Qmyjih4K3/b7d44k3YhaNnEKD+w
	j/5Ev4Ez2kCW9p2qc2KmlYdc5cZ8E6jntHqHVSApm8WBJpY4nfZDBDtlq/aofTmG89CARJ71P35
	BV9+BRFCGswcjM0VvIZVLkBP6GuN+0cO3/MaRtGEoJsF7WHXwdITPJbWElUFQ4ZETKA5tmXJBnW
	6H/pq+G9C8LLOjz+w8A==
X-Received: by 2002:a05:6808:6807:b0:4a3:fb6c:9adf with SMTP id 5614622812f47-4b9622c35abmr8613617b6e.12.1788560282554;
        Fri, 04 Sep 2026 15:18:02 -0700 (PDT)
Received: from [127.0.1.1] (184-96-151-165.hlrn.qwest.net. [184.96.151.165])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b971c8ed6asm3718199b6e.17.2026.09.04.15.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 15:18:01 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 04 Sep 2026 16:17:58 -0600
Subject: [PATCH] mtd: rawnand: sunxi: fix free OOB section offsets
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-submit-sunxi-nand-free-oob-offset-v1-1-cf389b9ac94c@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWN2wrCMBBEf6Xss0trLC31V8SHXDZ2hW4kiRIo/
 XcTfRrOMJzZIVFkSnDtdoj04cRBKpxPHdhVy4OQXWVQg5qGZRgxvc3GuYYURtHi0EciDMFg8D5
 RRu3GyzIpP89+gep5RfJcfh+3+5+r5Ek2N3FbGJ0ITdRi11Zt2fXN3AuVDMfxBUIgyQelAAAA
X-Change-ID: 20260904-submit-sunxi-nand-free-oob-offset-ad43962f77f9
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Richard Genoud <richard.genoud@bootlin.com>
Cc: linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

The sunxi hardware ECC OOB layout places protected user data before the
ECC bytes for every step. Since variable user-data lengths were
introduced, free sections after the first use sunxi_get_ecc_offset(),
which skips the protected user data and points at the ECC bytes instead.

As a result, the MTD free-OOB interface addresses ECC bytes rather than
the protected user data for those sections. Use sunxi_get_oob_offset() to
point each free section at the beginning of its protected user data. Keep
the special two-byte offset for section zero to reserve the bad block
marker.

Fixes: 54dcd6aa69db ("mtd: rawnand: sunxi: introduce maximize variable user data length")
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 83666dd6cb2a..559b42687b1b 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -2013,7 +2013,7 @@ static int sunxi_nand_ooblayout_free(struct mtd_info *mtd, int section,
 		return 0;
 	}
 
-	oobregion->offset = sunxi_get_ecc_offset(sunxi_nand, ecc, section);
+	oobregion->offset = sunxi_get_oob_offset(sunxi_nand, ecc, section);
 	oobregion->length = user_data_sz;
 
 	return 0;

---
base-commit: def559a215699aa2f2d8ef98f30156b9d562a154
change-id: 20260904-submit-sunxi-nand-free-oob-offset-ad43962f77f9

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

