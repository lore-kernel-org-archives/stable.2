Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.218
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793929775;
	b=ZRESExB8zzUbzK/DdAgZHUm4q+jtp7YRs1Ve1Z1OgRVbR3PbkrxeJPpPL3doEyzDNRYC
	 rYQwMTLG5yAFzWm9qmEEjYDIYN+3VtbdKYJAZpXvEqAhQsB2U+XPBGYbCnariS9Bv+edp
	 AuLGmsd6gNwuZ5EPlNEtKvAXrt1I/j9X0psLVlcVBp1v90m097Aib/n+vwlzLyCYT61N5
	 PuaVXd6/l5vQWZmmZWtkJShf+5ZlBjcnINboCUWxOmOKqLPq74b4fjGNYuYHPuCJNoA5C
	 +a2yt8ZSIgAAvtj5Rn8UFiSFFCjGGDOPr/WdralSpjHiBfO8Uv8eISVydXkhjUyMNMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793929775;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=obWEFYHxqQD8Gd1XcASfPfqXODJZ6EymLi6RVwWdKYg=;
	b=JmkDGyarM/iEQE+tnqpups5XnejW09fIS3gvawuK+KU8mUvVDEg8C1JTixIpEo4dxrzo
	 GB/cSZGfvHdbr3CAkq0nbmqRcV0Qrvbf2rkaxejgkuRlNqRLtbxHYyZlGUYD+72lIwQWM
	 gjhYL5DoiK4bLnzPfA6W9i1o7zNUu6vsAPyVC2s2u0QvS3yjHogEUm2j5WnU0ba1rc8XT
	 qmOdDkj2FARNbkizarXpRZmVfXRm6erpq1Yc3v46hFcMDeO+Zd5vt1v+hEUoizrRC8EkI
	 sb7xAJkXyFWmMLjgW+0C+vy8Ukff7sxvnC4flo889fQUbxAnMyZBm18dtjn2OZA0+ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b="Gedp/X2F";
	arc=none smtp.remote-ip=115.124.28.218
Received: from out28-218.mail.aliyun.com (out28-218.mail.aliyun.com [115.124.28.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B458606A31B;
	Fri,  6 Nov 2026 01:49:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B458606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=Gedp/X2F
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1793929770; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=obWEFYHxqQD8Gd1XcASfPfqXODJZ6EymLi6RVwWdKYg=;
	b=Gedp/X2FQC+skmb+8LrSDkz5GOwbaP+c2C9I+n4SNXHbSRVjGR7BCFbmfoMPMCNzwxpwaewU5gZp5dnJz401sOUHTHkZodFo26g2ycG1+HBrbcVwveIBitZD0wLV32cGSFm314CA6pdvD3/iCrHDXODwKVC0iUdKutpLSWCTmz4=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07813765|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00538106-0.00124658-0.993372;FP=11962638910552167427|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033023087102;MF=guozh23@xiaopeng.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.jxtOOy9_1793929768;
Received: from localhost(mailfrom:guozh23@xiaopeng.com fp:SMTPD_---.jxtOOy9_1793929768 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 06 Nov 2026 09:49:29 +0800
From: Guo Zihao <guozh23@xiaopeng.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: Yangtao Li <frank.li@vivo.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] mtd: lantiq-flash: Fix NULL pointer dereference in probe
Date: Fri,  6 Nov 2026 09:49:28 +0800
Message-ID: <20261106014928.4126855-1-guozh23@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
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

ltq_mtd_probe() dereferences ltq_mtd->map->virt before the map_info
structure is allocated: the map pointer itself is still NULL when
ltq_mtd->map->virt is assigned, because the structure is allocated a
few lines below. Any device with a "lantiq,nor" compatible therefore
crashes the kernel with a NULL pointer dereference during probe.

Assign the mapping after the map_info allocation instead.

Fixes: 6145e07e9c77 ("mtd: lantiq-flash: Use devm_platform_get_and_ioremap_resource()")
Cc: stable@vger.kernel.org
Signed-off-by: Guo Zihao <guozh23@xiaopeng.com>
---
 drivers/mtd/maps/lantiq-flash.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/maps/lantiq-flash.c b/drivers/mtd/maps/lantiq-flash.c
index 80d467eba..5c2ace302 100644
--- a/drivers/mtd/maps/lantiq-flash.c
+++ b/drivers/mtd/maps/lantiq-flash.c
@@ -118,15 +118,15 @@ ltq_mtd_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, ltq_mtd);
 
-	ltq_mtd->map->virt = devm_platform_get_and_ioremap_resource(pdev, 0, &ltq_mtd->res);
-	if (IS_ERR(ltq_mtd->map->virt))
-		return PTR_ERR(ltq_mtd->map->virt);
-
 	ltq_mtd->map = devm_kzalloc(&pdev->dev, sizeof(struct map_info),
 				    GFP_KERNEL);
 	if (!ltq_mtd->map)
 		return -ENOMEM;
 
+	ltq_mtd->map->virt = devm_platform_get_and_ioremap_resource(pdev, 0, &ltq_mtd->res);
+	if (IS_ERR(ltq_mtd->map->virt))
+		return PTR_ERR(ltq_mtd->map->virt);
+
 	ltq_mtd->map->phys = ltq_mtd->res->start;
 	ltq_mtd->map->size = resource_size(ltq_mtd->res);
 
-- 
2.50.1

