Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795609306;
	b=DoRS3giEt3aoKAz6QQcV1X4Zhb9K+bU0cWg3Ck8IaIOeKrw8wAvAKx6I5cFHqkmuStEv
	 Z2GHDa3HVqhsEZi0iUrd0wlN2tN66DWO9Dmc7PgCZYzQSlUasvqnA38vD66tEC4t4v7f5
	 VTT5P4BTC6CIMqjT0cWDY6LhuGMVSobHWtUGxo4SXGZkzsMto2TLCbzfQ8fDFHCd0VJGV
	 xV6AFP9+/7zTooK/Z9ZkhO4BNVfElOZQvIlAWPidSKNkYzPRE3+0kBHJygQccD58zn0JX
	 RHTZHe2ZGqr8qx5USWidx0wzFJKW+gEaQumdZCz+KHik4H0NNgVNrWY/yoLNKOx00WA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795609306;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=MA+Kx+uKQP6OM3muhrQQ7gMLzt5UOS5UjDB/PUfvv7E=;
	b=D6zrMST+ucysbQiX7chbs26VJrLIMvTGuLDyvSCiPgOfLlfnpWSYbOy0bgkm+MrUkJY6
	 dbdXjqZ9rhduL1Prlh246kaxBJbBJ1SHSEdJgrtZGxciCaaJuM3/DMv0Rv4G9pMnRbj+F
	 YeFdkjcgbRluBKSQqYsUm6ARpnsUyMcuuqstERR/Z0C2+v6IVGqRAUwHIuYe6wsbJUdtX
	 vXROmKruidx+pzWcVUaC1NjzfS8q/wARr3AyjKF3OAw6lkCgTnndIi1xrlzowi4a8ltTT
	 bA7MYW/tFyJrgPSRoTwloh1vCPXxGibCJ/2ok43GFElwo1AEP13/VLiEqJehkhQtCaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SQ7tVrvg;
	arc=none smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5A6606A68B
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:21:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A5A6606A68B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SQ7tVrvg
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8b2382bf051so3091904b3a.3
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 04:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795609305; x=1796214105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MA+Kx+uKQP6OM3muhrQQ7gMLzt5UOS5UjDB/PUfvv7E=;
        b=SQ7tVrvgLwEpKg/dLncg5k3nm1AW6DlK3MzIRxWHfEFYxIUSgU+pEFVBWmLtSqhRAf
         cDNcL04vHuB2g4ruka7p3ZhQZ9RSTR13frc8ReyxZsKXO5hWNlkhMXqcTHgvEujwvDXE
         B+IKebgDnatZc7R7okaBERbKSJ6Vm9G4tI0cRTRdcHKjFFI0BBcpPiU7Dv4YI/ybjRRH
         xtvhYCNbjxhjup6G4BXDyWdIH5FuOqWdD+a1m4q4BUkw0FhQQWifbf4BYI2by48nO1K0
         LIHoQ83IteO873Hcc+QgxDxjOu4s1a5qds2nmum2eQDph5GQHsZvmEN4yQXYliprzMq5
         g+5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795609305; x=1796214105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MA+Kx+uKQP6OM3muhrQQ7gMLzt5UOS5UjDB/PUfvv7E=;
        b=PdbsA3a3eGEVwYxwi806petcL7Wa5n/+4+fG1oIkMEkAZpcflpNBrpvLLZNN+hqBfy
         +buaMlmKdbnhqK7bw8ulF0SYjvL0MDG6GdEJtjPSjXDmZGhQk3D101FwvXr6V2DfAhMe
         JuKLAke9kFJ8FzOGDNt0gUvaU5Dz4KGaHpzJ6U+Eh4UYROWl7Cj3NC9DR/DX/c0059t1
         HUpRa+m3cIO6nPvvRmy6joC0/QjMLKE/VjEsvtWRNwDYkOl7VTHtlPcU0F9nL6180QDx
         Dar2ckDcnHH0l5IHq9p7itdqN1Y/6ZjYRU2I2AKgr9uZwaaxvri9tGOu/UdvSwuLwipI
         b2nQ==
X-Forwarded-Encrypted: i=1; AL+hErEIs1R3A0qLxXXJ/R1AWJ8X61xOwvMGRN4JLbb9DBDYh/2i//mRglWw+jlecFeTZn7qeBEGI8s=@vger.kernel.org
X-Gm-Message-State: APuU4Z/LbztIGnpVvASXSOPsR46Ag9ibXkApA/Qa8tvefnI3fzZ44YOj
	ItA19K/HhuQ2G8jlYMtsoXiwfo5RmD7g9nD7LtgazxH9tjwzRT7OQFCU
X-Gm-Gg: AZFdTZeCJBOK8EkUQ3uejQ/EA/SlYyt1iu5LNoAjAqu20JtuL+rwzy/9bzkmkLhhxil
	1tFrR2rw69jY5l0M8XFipuotfh/7oQGhCYzlskMhyDcW+4S+gepFUNuClhgRkYLCCk+TRA9IyqJ
	A/f1kU9rsW338jO3VnQZsvvzNRjoK676tibSO++PsMJJWieAeb4AxgRKTRy8YlHFTaB4q3TOkdJ
	EmhXUHaTojw1Wvc2W8XEgJN/IwdGFCYhGJi4y+eCIsONX+LTUCyqZzTdl7iLh1Ry24LgPVaSTCY
	MwMM/UucYae5dokMbSjE7frNzehR4DPtJunflXY2aZcTDa2Ya0YZC+k8e1GYOfBEQeTER5E/TjA
	g89pJ2RciDr6wsIN+xr/p+EV3qpSe4Qk3X3xeVkHeFQ5OOsQPwejuBJu6nU+dL2jOLsSd7wUhw0
	rHEos7wHUa1hbt9XRMGwRVu9TWLx0/itxwPpxZMRMBTiTrrtCbWQIgkySmnNR7I6Tw0epeIKMjF
	S/z2O3lSq3WcVftk8za2wVr9nFLceBLb3Cy2oBrTrNN/PUyqDWzGWxploP444Xz+UR3fiIm8bIS
	RAL8P7i6JBTORzHAGGHD1JkLHnJ1vgID6w==
X-Received: by 2002:a05:6a00:2d8e:b0:869:9298:ba59 with SMTP id d2e1a72fcca58-8c876741225mr17478088b3a.0.1795609305329;
        Wed, 25 Nov 2026 04:21:45 -0800 (PST)
Received: from server225.. ([39.170.101.209])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87285c89dsm8688656b3a.13.2026.11.25.04.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 04:21:44 -0800 (PST)
From: Ping Li <leeonion.muyu@gmail.com>
To: miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ping Li <leeonion.muyu@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v5 1/3] mtd: rawnand: intel: declare NAND_USES_DMA
Date: Wed, 25 Nov 2026 20:21:33 +0800
Message-Id: <20261125122135.44696-2-leeonion.muyu@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261125122135.44696-1-leeonion.muyu@gmail.com>
References: <20261125115108.4147741-1-leeonion.muyu@gmail.com>
 <20261125122135.44696-1-leeonion.muyu@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ebu_nand_read_page_hwecc()/ebu_nand_write_page_hwecc() feed the
page buffers provided by the NAND core straight to the DMA
engine, but the driver never declares NAND_USES_DMA.  Because of
this, nand_base cannot know the controller DMAs these buffers and
never bounces non-linear-map ones (see the use_bounce_buf logic
in nand_do_read_ops()/nand_do_write_ops()).

Non-linear-map buffers are not hypothetical here: mtdblock's
write cache is vmalloc'ed and UBIFS passes vmalloc'ed LPT buffers,
so such buffers can reach the controller's DMA engine, for which
they are not a valid dma_map_single() input.

Declare NAND_USES_DMA so that nand_base bounces non-linear-map
buffers through chip->data_buf, as the other DMA-capable
controllers (arasan, denali, meson, mtk, nuvoton...) already do.

Fixes: 0b1039f016e8a ("mtd: rawnand: Add NAND controller support on Intel LGM SoC")
Cc: stable@vger.kernel.org
Signed-off-by: Ping Li <leeonion.muyu@gmail.com>
---
 drivers/mtd/nand/raw/intel-nand-controller.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/nand/raw/intel-nand-controller.c b/drivers/mtd/nand/raw/intel-nand-controller.c
index cfb4b231e067..1f493fb426d6 100644
--- a/drivers/mtd/nand/raw/intel-nand-controller.c
+++ b/drivers/mtd/nand/raw/intel-nand-controller.c
@@ -688,6 +688,7 @@ static int ebu_nand_probe(struct platform_device *pdev)
 	nand = &ebu_host->chip;
 	nand->controller = &ebu_host->controller;
 	nand->controller->ops = &ebu_nand_controller_ops;
+	nand->options |= NAND_USES_DMA;
 
 	/* Scan to find existence of the device */
 	ret = nand_scan(&ebu_host->chip, 1);
-- 
2.34.1

