Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794177597;
	b=THdpRQ/XXCWkF0h0e/Z07DU+G1CcRJC2XPvj5EtehTmlMVIk+cdQtzjxp84fYzNtKZQ3
	 FUFsfHmuQJWMTMdQnF1GdOSwjFC6s6J/k7YxxiqbjTAegiCefAxovQKmM1rsoAiqvoQn9
	 ISrSNczv6jOKh941QXvDsnKQlHahA5H4QOGrqd7NwMnXg3GAeK3EEIhM26OTTDOg34ISh
	 MUkGyKkhpqerxaURXr/0wDJoOXYhAO+9f/KCRe8qxW6df1JQrgZults/QPjGyfAnFvTdw
	 Di60Qqr2Rpr0ozJUJCi3J4OSbcGX0Fu/Rrg1icafcokeWG5M2J75ETB5DSLUuR6r6tA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794177597;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=B8yjlxqiZsnHs1InT2MGi8hOJCH6xDuUcZ/rw+mTA3g=;
	b=TcY8x8OONTCDWOIEg5Sk+oFWpGm2k5UcJoB2YdOAoF3hUQViWrxqGB4QDAb83SfGOenI
	 Fe1dHc/MTJWdKJNSZJJuI4gtkFHCdCRCwlCLiKz1XUz9yGfro5NVKcPlEuyOdoTRZ0G97
	 auYYiUVN9rVH6Q/TKLgl+rKgdIVyffUy14Jkt1+wDR3dF5ffPhCcp1U8Y6cwnMjTfQ7PV
	 t8sMCM6d1hwkCkSt6CZKZF1ZWvzKlWdhqzFQPNUi51lvt+bpmPpf+HioyHkctnrjgQma/
	 s/OKJmDGlyE5Sc+G/E2/z/CwInpn0mc221JtZkyJLXc/JXQFSyXA74JwS4AeS4LVg/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AIcDVyCM;
	arc=none smtp.remote-ip=209.85.161.48
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C8F606A33C
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 22:39:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1C8F606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AIcDVyCM
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6deb848ddd7so191737eaf.0
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 14:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794177596; x=1794782396; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=B8yjlxqiZsnHs1InT2MGi8hOJCH6xDuUcZ/rw+mTA3g=;
        b=AIcDVyCMD4CMxZQaALEvvx7PHNLdDnl+kXVVYfmq/I2jnUrb2mMfudBA3TBcN7PymD
         xbhmNc49SQSDHiokqZpi4iN/TdzinttT3dCdu2GG3aku/hLxXW/86Fm72uI6kee7WYzA
         Omio9YsTtGfikq5cLF2BxQw3kkQMIqZsHC2hPdstNvE4dlnA1Uj3ww5EsD7phhmnd/Rx
         W+A2Fp0vgpbXutWhNh/jytiRRnx+S5YrQ3ypfirDhpoBXtTRq/2jdNZWJvmyiZ/uexuQ
         ZPzIjiLX/xF9dqRU37AeBXS5y59tRXu25jSTDU9Nsd04r0ytnPXcXQxpAdzTu2/jUAOf
         K+7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794177596; x=1794782396;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=B8yjlxqiZsnHs1InT2MGi8hOJCH6xDuUcZ/rw+mTA3g=;
        b=WUWPl+sVqUqYXaYb1hGaGJj+p9E4Tvyyq0spAbx5xSV/LbeXNOpjM/qk6L3zhp+Qcw
         Hu7ddOOlRx7M8E++TTGRRYpj2I3zDcBvonQV3fOsZ/x7MvpcMxVqaZvQizGQWaUYcTaW
         +caKPLfF3afNQ/Beo0m4O8m6Zi4HFVvqJpZJjJCDWqdsLYgWfsJenGrHedgL/y1pHqje
         pzUvg0gad/uJIqmW6+DQCOtlWVtVWILHwb1cY/Z8MUjWNQPTVzTN5wwr4kJtuXmrs6jV
         c660r6QeQ9Ii3JCjz0VJUeVDpx7BIoFF4LZz9nRyRdBieMUFTK1JV5y2H2U/ilf4k7F7
         rSEA==
X-Forwarded-Encrypted: i=1; AL+hErF1tsPAlkSkj7+KSB/9OjzQwNS31D1DWQtZWXDpNoNkpO4eWzC5Uv0g9/lZmrlodad848DUqdw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9j4ExzESVIybxl5jzhCqtk7/KCy0tO3MvZVJw+SqFgENvAlxq7
	Eaim7lSSgH5wnY4HQIYc1SL3M7Mh2BkhQVU1pzunF4xxEuwi+CpE1VGQ
X-Gm-Gg: AYBFou0hMj74DSaTQBpOSg4bBlaoLeBcWND9k7W29q2WitPdxzrBnkAXs+WxCo0WluJ
	T9nLFoN+CjtpnYMWHfM04ZrL8kg4umWYDZjNsUCSWo3EGnKlnF4rEq+kG6YrtVk2EVVeXRLtrBK
	Hjx4ckRUW0pHpjsG9MaD4JxDma7dywCaI6oQbbzmiOsENtx4BC/pXa1d1Op1zXGPEoJRYOAYm0T
	RH/RBef6WbYMvhb70QJaH8MzWSxBB5QDU1jinKaY767uzGaOyrIPE25qLHC4wwRDa7FkFyBE3lk
	yFO4iT89uWE/GCZhWn3MpX2BA1YRXdagdSLRE7J2ZB5+fkOh8BAHFzTOn5eFSYArW4hjn5s+m9S
	rxhwYCmWyLdmimkEn2Stxg4uY3h5svyQcZx1o1vU3R8ZYx6BPAF2DQGccqB+9CvibFBo1wgf5La
	gCtQxWYK6McAY15XHvlsUdfTx9QOhXTLNegsG4xHU4lC9rstrDkaWG/vMSbJ1irSQejJhhrZMjf
	naJI5UWsG0vfv0MZuFlPix+VYfycIxhugHWVSSqzzbHeX4wo6eqPevyDaNkZFfXRVTxxEWVuZRQ
	aeXB5KjVmOIPMW4JIxhusk0Cc44cedVJcOeY/gMAfcwLqEoPH2bFCNVu9if7U77clNCk5JS8UYb
	5TJmzrvMaQ1NQjb3/7llIqWQdzG9IZPepDKYLTCjVbfipxU8fdg23VCQHrALEPl2XEjYurDUVBC
	v8fUQR3S48FTlXnJqJOXmmUTxfR9wgTQcdY9oUJ/FMhV+FZnm7w6LZ
X-Received: by 2002:a05:6820:811:b0:716:f300:648e with SMTP id 006d021491bc7-7170f1be2bemr1233736eaf.5.1794177595688;
        Sun, 08 Nov 2026 14:39:55 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-7170f8cbcb9sm2087214eaf.6.2026.11.08.14.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 14:39:55 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 08 Nov 2026 15:39:52 -0700
Subject: [PATCH] mtd: rawnand: nandsim: reject unrepresentable page counts
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
Message-Id: <20261108-submit-nandsim-page-count-v1-v1-1-63e961cc1dcf@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMywqDMBBFf0Vm3cHERbD9ldJFHmOdQkZJogjiv
 zdpl+dy7jkhU2LK8OhOSLRz5kUq6FsHfrbyJuRQGQY1GK3ViHlzkQuKlZA54mqr4pdNCu4a7za
 M2qjJeeOhJtZEEx+//PP15/r/kC+t2QxnM6FLVvzcplhC39K90FHgur4GIcqpoAAAAA==
X-Change-ID: 20261108-submit-nandsim-page-count-v1-9ad8160fbc6c
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 David Woodhouse <dwmw2@infradead.org>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

The simulator stores its total page count in an unsigned int and uses
signed int indices to initialize and free the page array. A device size
accepted by overridesize can exceed both limits even when the eraseblock
count is representable. In particular, a power-of-two page count above
UINT_MAX truncates to zero and reaches a zero-sized allocation.

Reject page counts above INT_MAX before allocating wear counters or page
storage. This preserves the full page count and keeps the page-array
indices representable, while reporting invalid geometry as -EINVAL.

Fixes: 6eda7a55f786 ("[MTD] [NAND] nandsim: allow for 64-bit size")
Cc: stable@vger.kernel.org
Closes: https://lore.kernel.org/r/sashiko-outbox-204066@kernel.org/
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/nandsim.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mtd/nand/raw/nandsim.c b/drivers/mtd/nand/raw/nandsim.c
index fe968037f75a..802493e01ed9 100644
--- a/drivers/mtd/nand/raw/nandsim.c
+++ b/drivers/mtd/nand/raw/nandsim.c
@@ -13,6 +13,7 @@
 #define pr_fmt(fmt)  "[nandsim]" fmt
 
 #include <linux/init.h>
+#include <linux/limits.h>
 #include <linux/types.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
@@ -2361,6 +2362,12 @@ static int __init ns_init_module(void)
 		chip->pagemask = (targetsize >> chip->page_shift) - 1;
 	}
 
+	if (div_u64(nsmtd->size, nsmtd->writesize) > INT_MAX) {
+		NS_ERR("too many pages for the simulator\n");
+		ret = -EINVAL;
+		goto cleanup_nand;
+	}
+
 	ret = ns_setup_wear_reporting(nsmtd);
 	if (ret)
 		goto cleanup_nand;

---
base-commit: 30daaf3e7897b4a8d9b72e5b0c86dd6e2a4d7d85
change-id: 20261108-submit-nandsim-page-count-v1-9ad8160fbc6c

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

