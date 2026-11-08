Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794171713;
	b=bLVYPeiKAa4xfIRbseBR7JGK2PKIU9MMM4Kz7HtdAQyFBN7zwMPLPKJiiJpmvjfyNOkC
	 YYPoC9mGlrrZNVcyRPBsYhNciU9OStf8iLxVMV63eJKyEJnRcgLVXf9Q+VpvZmc/ZNASt
	 QhvcfkJMeMTtu6uHj2ba3OoX5/mRfKJj+Gu9oUhwU+l80/lHRR9tDq6jzaYdL8NB1QEc0
	 yDB8E5saoit3gBq0bFLme4LZBcVQIdZ9GDqsbSNfKB7MnzEGOFP7YpH81kV542eVMNAzX
	 2tmn+JQogVPqaZqoTAYRjBMTWG50E8SHCnqK7DHhD8Y4/hFeKruP0gTCV+EmTPXH/tA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794171713;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=xzZ92AGYO1/PLurTCQdhrPzW6aHFVPEii/Y+wkIOdWo=;
	b=F1pm7/NvZ80YJLcTDMEGWefM43UY07RtfA8Xn55cdNVgwjNE0kE6cY3iALQVkJw39ywe
	 oOzGQ+1r8/B59qxnvcIOCw1Qt0ZbR9wTOt73TAWV2edOU0Kx/MYo9X0s5fOyyPeZrhtuf
	 942AwrD8m6iXrsQ6OWYM3DTQwBheOLlf2W0RP65+VEmmBkzLJE8q6XjYj+K3nwYdggPHu
	 Fh3ejKjeeme6xvHLktn576d5iDHaHhqeBECvJOem+ONMssJEjSy8xI+PoSqpK9PV7UOP/
	 RZV1YgNKy0pN6HaCYw2c7VGiGdo9B2fnFJ6TrDRsz8MnZa4Tic26NWyLY1mdL6lOqIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GAI8YDyV;
	arc=none smtp.remote-ip=209.85.160.42
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC93606A31C
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 21:01:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4AC93606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GAI8YDyV
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-48e9476e26aso77111fac.3
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 13:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794171712; x=1794776512; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xzZ92AGYO1/PLurTCQdhrPzW6aHFVPEii/Y+wkIOdWo=;
        b=GAI8YDyV/GYaVX0jyn1/XXjuYWTKmzesrnE9NA4oVePo8YEAA4DkCleel3M5fLz5He
         8PGzIZqdATBFS1N4uWQOusndBRUPaYJazzenma64Bow2XBPtNOguq9zH1CFrqRGXRjLF
         nijkWkoIRuzyhg3u2OO+sYB7twgKGeob2gjq/yddfU+nU0vxrjn/TgB8qhbtOPeGYxCQ
         7hTWTKa8I+DYQWwKC0COzJ7cBYy+TPYTWYMNQPZNrqmfmhbH9KXIPnk0DnhZ77xAxFVn
         MbNvQm3Ds1bBzhbuq1MBYu30mZbL4IuFwDsGXOrmQiz4OttoYtoVsBbFO36L/ZdPGd70
         vnTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794171712; x=1794776512;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=xzZ92AGYO1/PLurTCQdhrPzW6aHFVPEii/Y+wkIOdWo=;
        b=LBrGNdA9Zhm1KgCaNhdSBd5L3Z1+sjbr6yChdgMpRy+4o3hCKgGbpbUAT+H6nI0aeh
         Gh+zyH+ZroBtEgvullwHeoh+51/OaalZXp+JS28Z9gmx3ZJTxSGlwC6ICI0jx1nrQFuF
         zzaUPV4q1g0+qQc2phhl1oeyy97565xjn/f0Nbr75q1d3/ftEt3kUbdYO3bOWl+2cOLk
         lSNoGySO0nfxfJqcT5j/6NADGpejsWgYcIbE9Ls2aO73EqClwzwFKgnC8HpU+X6t23Vd
         6BD5eH+O/j3r+ASxnL8LfLYHGrwnilbg0lkCdZR1SAOIwrFdhIA9Ld1/XHDhdAQS2DUZ
         wkAw==
X-Forwarded-Encrypted: i=1; AL+hErFUCpfeo24iMxuXC0Q/UdBtHG1HZrjdapm7Gm0zh9IU7nkTcrYjBu/OpJvDv/q8AKTsnpcLp8E=@vger.kernel.org
X-Gm-Message-State: APuU4Z8hV3iFP6uMuXxbuLCiZcgbzB4+iwgCO0xTzijKrgvMR3mrFOi6
	30gb3tgGfXNNOjr43/0cXJEjUa4x16I+jnVDW8sroY9i9KDzZrkyTCZN
X-Gm-Gg: AYBFou2bs/kxZTuibXoi6XyJrkETF6CDnLpPo6QkxBtGNgB2G1C4u6yQ+WJkXpo7Rck
	ccqkqc72+YTDkx9K8yIirLXWKxZCMn23tMQLcPou2P/NqhbR6H9tb9E1pLTshpKRSMsE+A35Sg9
	r6IepqFpzTuRIs6ye/Lnn0AOvIr5CyeJ3hJJpTSgHMTpaC383V1p8byJXMm0Boy2LHj/oyPm+oh
	IKHTMgZ10zZrNlztDU44UuvBSVH+4RSzDG10r4nZqk6VWj2TYj6UXRDAIChMgvi+bpS7aNr1lw/
	9AW+3uOZ3oXE3rPAJV4s7IRLFEQxB/tTqiFkV3icq8YWlqiQx/YV601W5oC6Hqlhvano7T9KQUc
	WmsGBc0J9rt82cZo8ndyHSGHg8V3RyBPoup2+O0ej7fgziAppegks1MPBVGqSm0A1/2oz0HURL3
	KdvvNCCsNLrvX3tjbqeKK+6r9MLwNjOHQrWNSEvsr2KMB8etAUQyjT9e0BkOUHQHfIX5GTbZrol
	K5gO3dT5xFVWBRRaeZI4AjBKD7LLHL2hBq9Qy7b1ylLWbaDUTFacvvpojcG+JWx0sBfCn0365HY
	gRQDUfa/2zY1jooVvbpzfwpSeKOUQJLCXul0JBaoZDKUYNWcNt/4mzF5RjEPJMLwlN4ZYEMTdWb
	z8V1Z8BHjwPWGuwSHx0O6RZwn4OOBpDbJP4V0d8r/BAMLVr776ykOxsOORG8JMnG+u3rkhIOJ4P
	IEnOcGeYDducwnhM7o8jbwuo3YKf3hUExO574WaeYzHaO2mdBy5e/n
X-Received: by 2002:a05:6871:201:b0:4a7:1685:49f0 with SMTP id 586e51a60fabf-4adebfe9930mr1320398fac.11.1794171712263;
        Sun, 08 Nov 2026 13:01:52 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4ade6a0c000sm3239010fac.14.2026.11.08.13.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 13:01:51 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 08 Nov 2026 14:01:38 -0700
Subject: [PATCH] mtd: rawnand: nandsim: validate overridesize before
 shifting
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261108-submit-nandsim-overridesize-bound-v1-v1-1-9cde7657a69b@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNSw6CQBBEr0J6bQcGDaJXMS7m00qb0JjpgRAJd
 3dGl69S9WoDpcikcK02iLSw8iQZzKECP1h5EnLIDG3TdsY0Z9TZjZxQrATlEaeFYuRAyh9CN80
 ScDFofH/0jvrm1F0gq96RHrz+bm73P2fPi3wq7tJwVvM+WvFDicYU6nJRC60J9v0L2yG+VqgAA
 AA=
X-Change-ID: 20261107-submit-nandsim-overridesize-bound-v1-1c83cbe80469
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 David Woodhouse <dwmw2@infradead.org>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 wang wei <a929244872@163.com>, stable@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

The size overflow check shifts by overridesize before validating it, so
values at least 64 already cause an invalid shift. Smaller values can
pass that check but exceed the width of the later eraseblock-count shift.

Use check_shl_overflow() to calculate the unsigned eraseblock count and
reject values that cannot be represented. Derive the byte size by
multiplying the two 32-bit quantities in 64-bit arithmetic.

Fixes: a5ac8aeb2900 ("[MTD] nandsim: enhance nandsim to allow arbitrary NAND size")
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/nandsim.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/raw/nandsim.c b/drivers/mtd/nand/raw/nandsim.c
index fe968037f75a..6716eafb4b00 100644
--- a/drivers/mtd/nand/raw/nandsim.c
+++ b/drivers/mtd/nand/raw/nandsim.c
@@ -16,6 +16,7 @@
 #include <linux/types.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/overflow.h>
 #include <linux/vmalloc.h>
 #include <linux/math64.h>
 #include <linux/slab.h>
@@ -2341,21 +2342,21 @@ static int __init ns_init_module(void)
 	}
 
 	if (overridesize) {
-		uint64_t new_size = (uint64_t)nsmtd->erasesize << overridesize;
 		struct nand_memory_organization *memorg;
+		unsigned int eraseblocks;
 		u64 targetsize;
 
 		memorg = nanddev_get_memorg(&chip->base);
 
-		if (new_size >> overridesize != nsmtd->erasesize) {
+		if (check_shl_overflow(1U, overridesize, &eraseblocks)) {
 			NS_ERR("overridesize is too big\n");
 			ret = -EINVAL;
 			goto cleanup_nand;
 		}
 
 		/* N.B. This relies on nand_scan not doing anything with the size before we change it */
-		nsmtd->size = new_size;
-		memorg->eraseblocks_per_lun = 1 << overridesize;
+		nsmtd->size = (u64)nsmtd->erasesize * eraseblocks;
+		memorg->eraseblocks_per_lun = eraseblocks;
 		targetsize = nanddev_target_size(&chip->base);
 		chip->chip_shift = ffs(nsmtd->erasesize) + overridesize - 1;
 		chip->pagemask = (targetsize >> chip->page_shift) - 1;

---
base-commit: 30daaf3e7897b4a8d9b72e5b0c86dd6e2a4d7d85
change-id: 20261107-submit-nandsim-overridesize-bound-v1-1c83cbe80469

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

