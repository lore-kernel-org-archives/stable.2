Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795076098;
	b=SStcCrwsTGiSyJYsDTO8BBXxgbB0/ytqjA8ycDEgDZ8OCE8ljGgb9sG76Ukkaim9Ii3M
	 1Yi5341nqx0600Zj3JwMcEZdOEzNFT/paqTiiAX7C3+pabjfxlhBsjjCqotpVH5X8o26n
	 sKb3orC5RhuGweC+4+KPRUoKzPSPyAgE2stlVI12My9txVdIbFO4bvILtvGhd5cs+6FZt
	 aK7/GKPhhs4SufHn4PNt8Vp7joBVcBdXa6XNY4wBDD4hktw3UET0IL208b5ieleq1L20l
	 PlXy1gDyFaWQ38rSjs9pqlfZnHBlq4QRR+KP6ztfi4eLBno3FWkHyeWVVP7Mkj8MNkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795076098;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=ej7ChYpOZ5l1Y3NR+n8BUjqWY6jWLDDINKnXOpUmMGg=;
	b=SsQz01LaP4h/Im/rqs8ySmDK2+/6LoWmAprPs7dJGQfiweRqy+wEgieb2u9F9wB9plqf
	 2/bk3kokdNHjRZG1S9B47U6w7wyooPFJYagoUwxZRrXOtHFAPfCrHOmaYs7PeUMNGOggL
	 WBqJ2hHmxADAvOcTkqqz2yP1c/GB+4UDfBRmrmhJNifjAnZqZlQpCSfWoIvt+lkxyU8zv
	 Y6gM3dvtRi6/PrvpYXi+u/v7HN6dYeMD3jNtLYwqmv7EQ+Ld9HJu9HElCmyci0y8oNMsw
	 VgdTMrx/NWajalRnFO56ORY+feu181XZAyz3s8URf7hAphI6P+2siMdMQW/1wdLLbdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ia++hh9Z;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F28606A326
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 08:14:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73F28606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ia++hh9Z
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-49465892f7bso1473530f8f.1
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 00:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795076097; x=1795680897; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ej7ChYpOZ5l1Y3NR+n8BUjqWY6jWLDDINKnXOpUmMGg=;
        b=Ia++hh9Zurz6bop0/BSOU1RZsLr/+TaRJPL24B7wEwqNUG16tuQJ7MNqwDR0WbsBN2
         rmSAdXZkyQEB9Dg1/pqAcyUl0uJq3ySybcH5aoGgTXBuirs12ESa6b+sYDuXEsz2TPBd
         GGSS59O9t4mD0xr1ZW0zZBbJyJSTWqRZcW3Y+/8KOKAEuv5qNVYvoHsET2hdbOh/fFVK
         D75x9fu1NCIsOqLsCycINXayS2awoOcbUZLwnd3Sswg7iFGxEb+ddeS3sLWp9neEqmnq
         7EJkPQQk7GZI/gSQ99M1j+f6uptmvFCfoYuXux6k8mLBfDjn7JzD4+BnSayb6mES/JHQ
         tLjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795076097; x=1795680897;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ej7ChYpOZ5l1Y3NR+n8BUjqWY6jWLDDINKnXOpUmMGg=;
        b=v5sIMoW+f3Pf1u60WNtAV5hnP4Vn/82fqk2yOcFfP7hQMosFfF4LF2zlPxOdq+DlJs
         U8H+DJ2Qs8vSNbG3enua9WEQSbuIxCFXLD8lK0knFfSbMGI4RS1hPI5dGPJAqWFCrWco
         KuJhlXZ/2Goqg98ITBWU0FYoRomEBnWetYmo91AUZOJLsXtgNX9q8WQqykocK+hFzEVm
         KErI9iVz5JOjhDjpGZfTnE+36n40u/CTyMhTIJcpK9gPIIh+xQBbfEAnWXN595PcJK+8
         KvckgmbSYBS2w5eDBpPbdw//on77iCAiwfgiFN0A8Cx0/IdW3L5hBLdbogxKLP0B78rc
         4YSQ==
X-Forwarded-Encrypted: i=1; AL+hErFTFj7OJSkgwoBKegIljzW8rQpkJ2/Ro7d4rycaUqwVVqaTdXPIvVbReTzEvrKczvka2x+ecGI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/cBJHSjQdAt/sa32eGAaWCnhlsKrHKpc+plNMt66fUi8vAaOwV
	3x9mzy9jeagoTbXhaqHswrVyLUdPMcBuYpPRvEp2P8yt1xLgiFuqKhKnakq0og==
X-Gm-Gg: AZFdTZdeRDLdID86j9K8eRQ4g7fkDwmF6WxHFC2uKwaRSaZKLtwIMfCmv+/xFetpYMe
	yOMjILmhCH62QACG4IlHLXfr2EuN2TFViFlQX+K1wm0ieacUG7Ej5ZD6bf+ftKr+YyuxqVrWk05
	hEOwOqc9PM4XM+6jt9bOOKpfjtA7/KgdWusZjoomJGhC+pF6YFExHGj724kW6ofTVJ/piSNv8Ai
	V2ndUPDRwFDi5owzX1DsKAu8wLV2k5nI9+wX9vUuUMUr/pn0IVhkobs63dyYla2Ms3fAsVbDN4W
	enxIfy/gOPgV53w8a6On275gf1YbOWzU3zwhILHRNrYSxvv8QOi8j+p3AM913/ulur5tYP/fI8u
	e7JWWe8tV83fo4IRweQL56SjwFs012a4vgJvOGXisDYa8NCDubabtfNJEk4VaJ+1DUkNz+9jfXI
	L+NAm03gKAkgpVpUptaYuL6SJjjisvseECv2gpHi2tKHcBiqGuOMKuiQ5hHXCTJG+bMH+eI3TDg
	FwqH0DtYTT/0lpMQkKT2k/QPVpcZSYRsVlXbMh66V6kJ9V1o0Om0syn+XGp1gvAXF800XvafVlV
	rQzs/WkyDoH7N3G+xDk1GPz9qsJDyVsq3ZJfkV9NeoJvdMN2vhDkUTtWcxaxlROqZHvM5u81WZ8
	FTOI=
X-Received: by 2002:a5d:5f92:0:b0:4a9:df02:6040 with SMTP id ffacd0b85a97d-4a9df02654fmr1704178f8f.3.1795076096580;
        Thu, 19 Nov 2026 00:14:56 -0800 (PST)
Received: from [192.168.0.253] (5403F394.catv.pool.telekom.hu. [84.3.243.148])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4a65560911fsm9161190f8f.26.2026.11.19.00.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 00:14:55 -0800 (PST)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Thu, 19 Nov 2026 09:14:46 +0100
Subject: [PATCH] mtd: spinand: cleanup ECC engine when
 spinand_randomizer_init() fails
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
Message-Id: <20261119-spinand-cleanup-ecc-engine-v1-1-60d007d2ddd8@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqDQAwF0KtI1gaMFJFepXQRMl8bkHSYQRHEu
 3fo8m3eRRXFUenZXVRwePVvNEjfkX00VrCnZhqHcRKRmWv20EhsGzT2zDBjxOoBTiq6DAbFY6I
 W5ILFz3/+et/3D2xfVgJsAAAA
X-Change-ID: 20261118-spinand-cleanup-ecc-engine-da1af0ceae46
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Cheng Ming Lin <chengminglin@mxic.com.tw>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.14.3

When the spinand_randomizer_init() fails, the code jumps to the
'err_cleanup_nanddev' label and the code leaves the ECC engine
initialized.

Change the respective goto statement to use the correct label which
ensures that the ECC engine gets cleaned up correctly.

Cc: stable@vger.kernel.org
Fixes: 54e1bc80af0c ("mtd: spinand: Add support for randomizer")
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
 drivers/mtd/nand/spi/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 18bba02fbd31..f6741d121b70 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1982,7 +1982,7 @@ static int spinand_init(struct spinand_device *spinand)
 	spinand_cont_read_init(spinand);
 	ret = spinand_randomizer_init(spinand);
 	if (ret)
-		goto err_cleanup_nanddev;
+		goto err_cleanup_ecc_engine;
 
 	mtd->_read_oob = spinand_mtd_read;
 	mtd->_write_oob = spinand_mtd_write;

---
base-commit: 760d2efe91a84363d25c1051a10572242e75fe86
change-id: 20261118-spinand-cleanup-ecc-engine-da1af0ceae46

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>

