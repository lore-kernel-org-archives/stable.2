Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793063438;
	b=yU8LdhkvNHEhzAW4mGx5wYB+2txfr2gBnhUZgj8xzJ15TLk5CQGkHEAX/JXEm9spKt6G
	 yYqPxnOs20qFBaG4BLP2ZmLRTcmINCuIHomFta9aYKHGcgZGghTO25bbH/3Oxdobcgtyi
	 t2gSL/ivz8NLX/jbKuucemKIYhh7ZwQfKp0wtN+o+br42EL0uEA/0/1TaZN2G5INu6kQu
	 srR5yQ4GGQFQm8zqqKwi+zLZVuI1DS1zvaB2xeAyBEg3NYPko9fqIyd+3KLlkXH3vtQht
	 zqiswamSGwNaGXULFL1XneLLdwVNAhkPZMWBbQ+vGKa3ItM0mlyGcWgnmM2Pk+2PWnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793063438;
	h=DMARC-Filter:X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-META:X-CID-BVR:
	 X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sQ6or6RHM10CyX3g5zf/eJ0i+hptie8RBH5If6Yz+P4=;
	b=lIV9lkse4/h/KZpFZN1DP24DaL96Ec4hWD80N6FbAm7+Mi14RqQzXEwaCklAuzrdd7yW
	 unNQDOiXRkTaq0yKzQvQN7itNnhtQPHAtZR+DiMM6oplzFFGqZxZBSDfNpyPpOseGdTyT
	 OaV2jQFgLcJKmGyDNO/Mu31wjAeaNebV8nYrKVRM0tF7LyajqO/PaKEttgqG7nAsxnon+
	 jw69lln+fSfnBjgp2G3HUHKkqmXarklDqW1GEghoSoPU3x/PWdWzXsz5VzIhzV3LGGUJs
	 0c6guf4f7G7rdvwPA3V5+np9VSCJHCR3LSpxdTogBMOAx/sH7xQFk1KmE4z2bB58eOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA280606A31A;
	Tue, 27 Oct 2026 01:10:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA280606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 324da7acd1a311f19a56ed5b684f684d-20261027
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:852f5f3e-4031-4a72-ae25-321bc406faff,IP:0,U
	RL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:166f55551dc327e66c9daa7955fcb792,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|136|850|865|898,TC:nil,Content:0|15|50|9
	9,EDM:5|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
	I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 324da7acd1a311f19a56ed5b684f684d-20261027
X-User: chenchangcheng@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <chenchangcheng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 316597076; Tue, 27 Oct 2026 09:10:27 +0800
From: Chen Changcheng <chenchangcheng@kylinos.cn>
To: markus.elfring@web.de
Cc: chenchangcheng@kylinos.cn,
	hverkuil+cisco@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	mchehab@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3] media: dm1105: fix rc_dev leak on probe error paths
Date: Tue, 27 Oct 2026 09:10:17 +0800
Message-Id: <20261027011017.28834-1-chenchangcheng@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <74064ad6-8a0c-45c6-bdfb-0b4eb21d0f3e@web.de>
References: <74064ad6-8a0c-45c6-bdfb-0b4eb21d0f3e@web.de>
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

The return value of a dm1105_ir_init() call was ignored within dm1105_probe().
The error detection and exception handling was incomplete.
Thus add a needed condition check.
Adjust a subsequent jump target for the completion of the desired error handling.

Fixes: 519a4bdcf822 ("V4L/DVB (11984): Add support for yet another SDMC DM1105 based DVB-S card.")
Cc: stable@vger.kernel.org
Signed-off-by: Chen Changcheng <chenchangcheng@kylinos.cn>
---
Changes in v2:
- Added Fixes: tag and Cc: stable@vger.kernel.org.

Changes in v3:
- Refined commit message wording per suggestion from Markus Elfring.

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
-- 
2.25.1

