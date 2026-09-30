Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBAD3164C7;
	Wed, 30 Sep 2026 09:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790761682; cv=none; b=k+c11YghNQUlt6AvcKQt6xhFIw6h8RM6CQQhaK6maoBKJciGlyoCzDYw6lH4zrjBFq22swUPk1UKdAzduUFUfN7gqNwxdGutOdH28g66Y+wRgVcf1O+QQ2TQbseqQAC8yIBOCaFb+tMneWpIBDw9FyLVSaDxBiAH+OUtGigznCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790761682; c=relaxed/simple;
	bh=lwEcqCyKsFypxB5M3nc3cmtiWuKHCnVPfoT6mMQvJD0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oFLjMPZnBx/vOUSdmOOXfL4lPAwBvTfZi97wns1KBBoc0HbQdpBjcSRkxe6BkQW8HTHgKsCCuxQiv5u6z69LVrZ6DnivhStmznc9pQxin93W/iElezOKTx1A/90yEzShJFBKkhi5j55m/tSkjLGKD7TGZh1QrdJ4yZQiYI1iQFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 022eacdcbcb411f19a56ed5b684f684d-20260930
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:6310bc8b-bf42-4f1a-b2ed-0a52248acfe7,IP:0,U
	RL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:6cc734ab183f0f13482966ec1187efb4,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|850|865|898,TC:nil,Content:0|15|50|99,ED
	M:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 022eacdcbcb411f19a56ed5b684f684d-20260930
X-User: zhangyunfei1@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zhangyunfei1@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1878704301; Wed, 30 Sep 2026 17:47:54 +0800
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
	u.kleine-koenig@baylibre.com,
	weirongguang@kylinos.cn,
	zhangyunfei1@kylinos.cn,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	leitao@debian.org
Subject: [PATCH net v3 2/2] net: ngbe: clear DRV_LOAD bit when ngbe_open() fails
Date: Wed, 30 Sep 2026 17:47:48 +0800
Message-Id: <20260930094748.1198085-3-zhangyunfei1@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260930094748.1198085-1-zhangyunfei1@kylinos.cn>
References: <20260930094748.1198085-1-zhangyunfei1@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On NCSI-managed systems, a failed ifup - for example when IRQ or
ring allocation fails under memory pressure - leaves the port
without either host or firmware driving it: the firmware already
handed the port over on open, so out-of-band management of the NIC
through that port stops until the next successful ifup.

ngbe_open() sets the WX_CFG_PORT_CTL_DRV_LOAD bit to tell the
management firmware the host has taken over the port, but every
error path returns without clearing it, leaving rings, IRQs and the
PHY torn down while the firmware still believes the host owns the
port.

Roll the bit back on all open error paths, matching ngbe_close()
and ngbe_dev_shutdown(), so a failed ifup leaves the same
firmware-visible state as if the interface had never been opened.

Found by manual code inspection of the open error paths. The
deterministic reproduction uses a loadable test module injecting a
wx_setup_resources() failure: in a QEMU VM the unfixed driver
leaves DRV_LOAD set after a failed open, and with the fix the bit
is cleared. No physical ngbe device is involved.

Fixes: a1cf597b99a7 ("net: ngbe: Add ngbe mdio bus driver.")
Cc: stable@vger.kernel.org
Signed-off-by: Zhang Yunfei <zhangyunfei1@kylinos.cn>
---
Changes in v3:
- correct the Fixes tag to a1cf597b99a7, the commit that introduced
  the bug (the first ngbe_open() failure path after the DRV_LOAD bit
  is set; v2 pointed at e7956139a6cf, which added more failing returns
  but not the first one); no code change.

 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index 8247f6c14be0..0aea5a99a1e2 100644
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

