Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02221F3BA4;
	Thu, 23 Jul 2026 02:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784772714; cv=none; b=kB9EGQ4vJ0j6zNmSzzgTt5aXLpiV9ERB7BoNxJjvStirld0inkdW7W1C1pPQou+qHGiyNFDwY+zm/U4QkIpKZ2BCskjgn7jClNwn3XhizYiEv89c3rnFCrnH4f518sXgn+5jrW9/MmAF9FKBet0afFL0XXm8eIN/c4eUqr4WBX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784772714; c=relaxed/simple;
	bh=ccwqqlobaTAnEiobGrwELO3nNWwQTi3T3ptifJRDGP0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hge16+BaX8SbG7pCkN2DeB6ZTEzgZZJnmQnJfOvnH50DVlNztUadhOMo53PxGNP/JlVp5KaImLHFd3+FuZZRi3R07QmLKZ+qPg4hFFwKaMYbPtPC9xGgS1rCf6nqT8i8Ug5C66RomNuc48nlCQWp/xGZR/kpObfZEZyPWg6JoSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: dc4433e2863b11f1aa26b74ffac11d73-20260723
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:a61bf3b6-0791-4ad3-9013-c35b3a9b4613,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:e7bac3a,CLOUDID:75bec1811ee3dfd11169296165e90edc,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|136|850|865|898,TC:nil,Content
	:0|15|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
	,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: dc4433e2863b11f1aa26b74ffac11d73-20260723
X-User: lilinmao@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lilinmao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 3070265; Thu, 23 Jul 2026 10:11:48 +0800
From: Linmao Li <lilinmao@kylinos.cn>
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: Yixun Lan <dlan@kernel.org>,
	Alex Elder <elder@riscstar.com>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	Linmao Li <lilinmao@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2] i2c: spacemit: request IRQ after controller initialization
Date: Thu, 23 Jul 2026 10:11:40 +0800
Message-Id: <20260723021140.2293844-1-lilinmao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260722094302.2284191-1-lilinmao@kylinos.cn>
References: <20260722094302.2284191-1-lilinmao@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

spacemit_i2c_probe() requests the IRQ before it enables the clocks, resets
the controller and runs init_completion(). If an interrupt is already
pending, the handler runs too early: it reads registers while the clocks
are still off and calls complete() on an uninitialized completion. Request
the IRQ after the controller and completion are initialized, but still
before the adapter is registered.

Fixes: 5ea558473fa3 ("i2c: spacemit: add support for SpacemiT K1 SoC")
Cc: stable@vger.kernel.org # v6.15+
Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
Reviewed-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Reviewed-by: Alex Elder <elder@riscstar.com>
---
v2:
- add Cc: stable # v6.15+ as requested by Troy Mitchell
- collect Reviewed-by from Troy Mitchell and Alex Elder

 drivers/i2c/busses/i2c-k1.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-k1.c b/drivers/i2c/busses/i2c-k1.c
index 51a0c3d80fc9..3fe716cc153d 100644
--- a/drivers/i2c/busses/i2c-k1.c
+++ b/drivers/i2c/busses/i2c-k1.c
@@ -723,11 +723,6 @@ static int spacemit_i2c_probe(struct platform_device *pdev)
 	if (i2c->irq < 0)
 		return dev_err_probe(dev, i2c->irq, "failed to get irq resource");
 
-	ret = devm_request_irq(i2c->dev, i2c->irq, spacemit_i2c_irq_handler,
-			       IRQF_NO_SUSPEND, dev_name(i2c->dev), i2c);
-	if (ret)
-		return dev_err_probe(dev, ret, "failed to request irq");
-
 	clk = devm_clk_get_enabled(dev, "func");
 	if (IS_ERR(clk))
 		return dev_err_probe(dev, PTR_ERR(clk), "failed to enable func clock");
@@ -755,6 +750,11 @@ static int spacemit_i2c_probe(struct platform_device *pdev)
 
 	init_completion(&i2c->complete);
 
+	ret = devm_request_irq(i2c->dev, i2c->irq, spacemit_i2c_irq_handler,
+			       IRQF_NO_SUSPEND, dev_name(i2c->dev), i2c);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to request irq");
+
 	platform_set_drvdata(pdev, i2c);
 
 	ret = i2c_add_numbered_adapter(&i2c->adapt);
-- 
2.25.1

