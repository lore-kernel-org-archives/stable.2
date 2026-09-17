Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E26415F2B;
	Thu, 17 Sep 2026 09:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789635668; cv=none; b=I4kKQMC+E5UegXWaH6fWAjTlKjZ1pqo/3M1wklRMVW8nYJMxdOOcmaxpsMXI9DRhQNatJm9Sj19Xo9n1py9T1eZj6GHcEinsX5xjcHgxRdgHewOLZGbtdxI0p8gKTHk/Yr03qz1nlW6oHdB7uVsMBZxK2pR4R+dok8I7wYIUOaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789635668; c=relaxed/simple;
	bh=5B3Om38I2GRDfvvgx1jujGCKOofDwqLD3LwIW6yS+H4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I8nAsOjk7PBL4stoYlSQ8eY5YBdSnwXZdLf1ppDP1uukkJxIlUTlPUfiP8yJt5iQQ1OlghDIF9xrSYddf1X/AKPTmbOuCc3h77/Xl3R64WSUgp3wclu0T8+mWa3HP1Ynhdl627jBa6gpS3d9Jlb92AeOQTQgY25EkGu/beJz/Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 4a846410b27611f19a56ed5b684f684d-20260917
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:8f1b1728-055f-495c-8729-2175222fdec1,IP:0,U
	RL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:85394816a6678e312f1fe5417836ff7e,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|850|865|898,TC:nil,Content:0|15|50|99,ED
	M:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 4a846410b27611f19a56ed5b684f684d-20260917
X-User: zhangyunfei1@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zhangyunfei1@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1871585613; Thu, 17 Sep 2026 17:00:55 +0800
From: Zhang Yunfei <zhangyunfei1@kylinos.cn>
To: netdev@vger.kernel.org
Cc: jiawenwu@trustnetic.com,
	mengyuanlou@net-swift.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	aleksandr.loktionov@intel.com,
	leitao@debian.org,
	weirongguang@kylinos.cn,
	u.kleine-koenig@baylibre.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net 2/2] net: ngbe: clear DRV_LOAD bit when ngbe_open() fails
Date: Thu, 17 Sep 2026 17:00:50 +0800
Message-Id: <20260917090050.1927999-3-zhangyunfei1@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260917090050.1927999-1-zhangyunfei1@kylinos.cn>
References: <20260917090050.1927999-1-zhangyunfei1@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ngbe_open() sets the WX_CFG_PORT_CTL_DRV_LOAD bit via
wx_control_hw(wx, true) to tell the management firmware that the
host driver has taken over the port (NCSI/OOB firmware stops using
its management channel). Every error path of ngbe_open() returns
without clearing it, leaving rings, IRQs and the PHY torn down
while the firmware still believes the host owns the port, an
inconsistent driver-firmware handshake state that persists until
the next successful ifup.

Roll the bit back on all open error paths, matching ngbe_close()
and ngbe_dev_shutdown(), which already clear it.

Fixes: e7956139a6cf ("net: ngbe: Add irqs request flow")
Cc: stable@vger.kernel.org
Signed-off-by: Zhang Yunfei <zhangyunfei1@kylinos.cn>
---
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index 6d8289e2532d..88f00b72a512 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -494,7 +494,7 @@ static int ngbe_open(struct net_device *netdev)
 
 	err = wx_setup_resources(wx);
 	if (err)
-		return err;
+		goto err_control_hw;
 
 	wx_configure(wx);
 
@@ -526,6 +526,8 @@ static int ngbe_open(struct net_device *netdev)
 err_free_resources:
 	wx_free_isb_resources(wx);
 	wx_free_resources(wx);
+err_control_hw:
+	wx_control_hw(wx, false);
 	return err;
 }
 
-- 
2.25.1

