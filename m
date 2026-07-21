Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467F9404BF9;
	Tue, 21 Jul 2026 05:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784613368; cv=none; b=uEajAh5xssyPoXW7l8h+1NZIGpMuoitsp1snr7PcAMticbBNBCmTWJ4MoCNeWC/wGeQyqJdkvi3Ds8DHauzAUPAmz36JH3ImFFhermec2dZXL3NEj1JpKl3R2jKfwaCL3hm5I5bUBfHKHRafZZrLUml+9IeAapbVP4H99KfJ4m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784613368; c=relaxed/simple;
	bh=Y2gwgHaEj+jCfi3QyAWF0Bcz8UsY+imk7JgmQWPie/U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gNxUEo2EuBSb1jnHpYlKJS79yy82NUKGO3x6t3/QGm+3ggG9xysYT9q/hNWPZE/xoAeEicj6eWZVnFQy/l0tnKGp/Y6zpSI6TzFaO2L4iPYf/QMdxL61TahTQA8+JQYF3E6i6SIGk0OWUdPUCMhe54oi1B6RjKoxwZWdfg5m+O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d755ea0c84c811f1aa26b74ffac11d73-20260721
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:3abbd7cb-4d31-4bfa-9081-963275be62bb,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:e7bac3a,CLOUDID:ae008b5714b89812c1283027768eccd9,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:
	0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d755ea0c84c811f1aa26b74ffac11d73-20260721
X-User: lilinmao@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lilinmao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1894067425; Tue, 21 Jul 2026 13:55:56 +0800
From: Linmao Li <lilinmao@kylinos.cn>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Haotian Zhang <vulab@iscas.ac.cn>,
	Tomohiro Yoshidomi <sylph23k@gmail.com>,
	David Rheinsberg <david@readahead.eu>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linmao Li <lilinmao@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] Input: psxpad-spi - set driver data before use
Date: Tue, 21 Jul 2026 13:55:51 +0800
Message-Id: <20260721055551.1714965-1-lilinmao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

psxpad_spi_suspend() retrieves the controller state with
spi_get_drvdata(), but probe never stores it, so suspend dereferences a
NULL pointer. Store it during probe.

Fixes: 8be193c7b1f4 ("Input: add support for PlayStation 1/2 joypads connected via SPI")
Cc: stable@vger.kernel.org
Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
---
 drivers/input/joystick/psxpad-spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/joystick/psxpad-spi.c b/drivers/input/joystick/psxpad-spi.c
index f902a56d011f..b1ab2486bb0d 100644
--- a/drivers/input/joystick/psxpad-spi.c
+++ b/drivers/input/joystick/psxpad-spi.c
@@ -301,6 +301,7 @@ static int psxpad_spi_probe(struct spi_device *spi)
 	/* input poll device settings */
 	pad->idev = idev;
 	pad->spi = spi;
+	spi_set_drvdata(spi, pad);
 
 	/* input device settings */
 	input_set_drvdata(idev, pad);
-- 
2.25.1

