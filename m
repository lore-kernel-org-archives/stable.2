Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15965352032;
	Thu, 10 Sep 2026 01:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789002730; cv=none; b=S2ZpIr32l3ytfGQo5AGgRZEMSQP1Gjar+dX8AKHhBDaq4m43tZ0sn9B+skdrw40yWIREih963G10uKX+JRlKvPrGPlOC9/hZ50HjqHSloXfwTsZU6ReQduWYwf+4CT5DzaG1pVvWVwblWLxEHZeLbxdkOuMxyG47Bh+0rKSg/9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789002730; c=relaxed/simple;
	bh=jCcrHF+pJYVkp+pgHVqNx93JGeFZOZz6Oh0TsW6mRnI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qltCuPN+G1i0If6SY3oYVgt9qqjhBgb04iAqZgO1R1AYAgoZObdFfv6qgMfaYTnyVXjtcSzBnBrpiNUIs7qZ5eB8POrKLYgg6SfQ0ByKEaDFhzzXRD0bCe1o36fdOaO/GCfJwBsK3T29SH8RzOw+t8BHWRGB6gcfq7V6Khjc8Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 9c01e71cacb411f19a56ed5b684f684d-20260910
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:a1c88878-7b05-4cbc-a57b-04b103082ad9,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:7db8b62,CLOUDID:a33e1639ab237ca0431f939f701201ab,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|136|850|865|898,TC:nil,Content:0|15|50|9
	9,EDM:-3|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,O
	SI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 9c01e71cacb411f19a56ed5b684f684d-20260910
X-User: gonglinkai@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <gonglinkai@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 855703371; Thu, 10 Sep 2026 09:11:53 +0800
From: Linkai Gong <gonglinkai@kylinos.cn>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Xin Ji <xji@analogixsemi.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	gonglinkai@kylinos.cn
Subject: [PATCH v3] usb: typec: anx7411 - stop the IRQ before destroying the workqueue
Date: Thu, 10 Sep 2026 09:11:50 +0800
Message-Id: <20260910011150.2966843-1-gonglinkai@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260908060333.4097219-1-gonglinkai@kylinos.cn>
References: <20260908060333.4097219-1-gonglinkai@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The IRQ is devm-managed, so it can still queue plat->work while
remove() is tearing the queue down. Disable it first.

Fixes: fe6d8a9c8e64 ("usb: typec: anx7411: Add Analogix PD ANX7411 support")
Cc: stable@vger.kernel.org
Signed-off-by: Linkai Gong <gonglinkai@kylinos.cn>
---
v3:
- add Cc: stable (Heikki)

v2:
- keep the minimal remove() race fix; drop the workqueue later if wanted
  (code unchanged from v1)

 drivers/usb/typec/anx7411.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/anx7411.c b/drivers/usb/typec/anx7411.c
index 41df115912b9..c3d36da692e4 100644
--- a/drivers/usb/typec/anx7411.c
+++ b/drivers/usb/typec/anx7411.c
@@ -1566,8 +1566,11 @@ static void anx7411_i2c_remove(struct i2c_client *client)
 	anx7411_partner_unregister_altmode(plat);
 	anx7411_unregister_partner(plat);
 
-	if (plat->workqueue)
+	if (plat->workqueue) {
+		disable_irq(plat->intp_irq);
+		cancel_work_sync(&plat->work);
 		destroy_workqueue(plat->workqueue);
+	}
 
 	i2c_unregister_device(plat->spi_client);
 
-- 
2.25.1
