Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793003283;
	b=VVgImotYglXM9RaBoiHcii28CIRTD/ZaXjcMy5MFpr+7OLCYvdoRhZrFCzxSY7sv9eXi
	 i6JDko3EV29IMGwbyqTsKuXG6S9YpwsdgPRJsOjBfOwsf2VF9bu2Du8mqMA/yy02VcJPn
	 RGeYOIEI9FvAozvpmUe6OEkrGHqC9QykkzsqByR0FWrPU1ISbltuJYhZVraQ1LGA6NLHp
	 kTwht0vkyp22Fv1ikEmtZruvrycc1yy92q8yxo2clYhhmMgmCB6yW10Uhc6xHmyZb1657
	 dyPQAczzc6aOETscU9xxZlNYPrxkzvmt9LWwkKO4iD60ow02RAIMXQcQwLJ91sJTz1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793003283;
	h=DMARC-Filter:X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-META:X-CID-BVR:
	 X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ihYV+mcM/pIIr2OdkPHUw/Z9MQ6f23kGw1ypoiRMOtk=;
	b=O0dw3v5XgnUnRly37aRsO1SYsObaG0TnnZ8GvAnuse8a/ilEfDI+4YH9y9DreZMjApop
	 T8BAsj7EYbBjlBiNfceIEUpURcXJluBZITmuTiHJYCnxKPBGY8DW2mvaKeBWe5bVkwVLG
	 x8DgDOZ+omP+8khzxJSeWmHLBCyX3+GmlZdtfj4WU49YCSUQsjuj7WUD+FjHfXoOGDkrY
	 7lI4r8+xCbHWkWm3dLZNe5zymXZnopf976ldH9whgg1ucdMdanu13qm/GpuFr50vlYWst
	 RNin9sALqjw/ApeTiez2FQMGz4AZDuxkLGrPbAUPKqXCBC9/an/qgAxiA09dvAQHuFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23E5606A31A;
	Mon, 26 Oct 2026 08:28:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D23E5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 25c90f08d11711f19a56ed5b684f684d-20261026
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:48b8ec55-9216-432a-ba82-046e1ba312fd,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:7db8b62,CLOUDID:2cc7dfedd116a540874866a81ca6db60,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|136|850|865|898,TC:nil,Content:0|15|50|9
	9,EDM:-3|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,O
	SI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 25c90f08d11711f19a56ed5b684f684d-20261026
X-User: chenchangcheng@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <chenchangcheng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1938705012; Mon, 26 Oct 2026 16:27:57 +0800
From: Chen Changcheng <chenchangcheng@kylinos.cn>
To: markus.elfring@web.de
Cc: chenchangcheng@kylinos.cn,
	hverkuil+cisco@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	mchehab@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] media: dm1105: fix rc_dev leak on probe error paths
Date: Mon, 26 Oct 2026 16:27:18 +0800
Message-Id: <20261026082718.89558-1-chenchangcheng@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <6217c190-e8f1-4faa-b934-b1774501a3af@web.de>
References: <6217c190-e8f1-4faa-b934-b1774501a3af@web.de>
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

dm1105_ir_init() registers an rc_dev that must be cleaned up by
dm1105_ir_exit().  However, in dm1105_probe() the return value of
dm1105_ir_init() is ignored, and neither the workqueue nor the
request_irq error path calls dm1105_ir_exit().  If IR initialization
succeeds but a later step (create_singlethread_workqueue or
request_irq) fails, the registered rc_dev is leaked.

Fixes: 519a4bdcf822 ("V4L/DVB (11984): Add support for yet another SDMC DM1105 based DVB-S card.")
Cc: stable@vger.kernel.org
Signed-off-by: Chen Changcheng <chenchangcheng@kylinos.cn>
---
 drivers/media/pci/dm1105/dm1105.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/media/pci/dm1105/dm1105.c b/drivers/media/pci/dm1105/dm1105.c
index ae4544042a74..9d49e95c8182 100644
--- a/drivers/media/pci/dm1105/dm1105.c
+++ b/drivers/media/pci/dm1105/dm1105.c
@@ -1125,14 +1125,16 @@ static int dm1105_probe(struct pci_dev *pdev,
 	if (ret < 0)
 		goto err_dvb_net;
 
-	dm1105_ir_init(dev);
+	ret = dm1105_ir_init(dev);
+	if (ret)
+		goto err_dvb_net;
 
 	INIT_WORK(&dev->work, dm1105_dmx_buffer);
 	sprintf(dev->wqn, "%s/%d", dvb_adapter->name, dvb_adapter->num);
 	dev->wq = create_singlethread_workqueue(dev->wqn);
 	if (!dev->wq) {
 		ret = -ENOMEM;
-		goto err_dvb_net;
+		goto err_dm1105_ir_exit;
 	}
 
 	ret = request_irq(pdev->irq, dm1105_irq, IRQF_SHARED,
@@ -1144,6 +1146,8 @@ static int dm1105_probe(struct pci_dev *pdev,
 
 err_workqueue:
 	destroy_workqueue(dev->wq);
+err_dm1105_ir_exit:
+	dm1105_ir_exit(dev);
 err_dvb_net:
 	dvb_net_release(&dev->dvbnet);
 err_disconnect_frontend:

base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
-- 
2.25.1

