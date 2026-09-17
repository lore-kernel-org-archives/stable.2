Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A8B3A8740;
	Thu, 17 Sep 2026 09:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789635670; cv=none; b=nesWCKUpQNNsnjaID+psqtV1hDk6jqYaamgRiviUU1nCopcX5wRaPcXdtZEAKd2qAIw2rvVe7hRkKe0u8AE+8Tzt+ehLw0gZ5+mE50FcRim6aX0dtPIHSIaDRXgMIW8UTrY09LZeKPU4/el7k4Xtk3PPe5aBROl9IK/DVGy5540=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789635670; c=relaxed/simple;
	bh=agH/VFgceVsM7VmBqu7IAQXXz0/IA+0HOvGAW6nxzvo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qn9JD4iXtVkq+M1Ke4tu8waZta4ljhyn+JEPlwgnFrowTwOUluOEaRoKWN8IFXSq6rM2ZNpEeG4HBeXrJz22cHjPY0GHbaA8o0GyAmG5HXRSyx3/l823h3USXDnmgvJIS46aTP3W+7IWUenpRomTh5bLYQJszTmFRLnqzvogqaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 4a0babd8b27611f19a56ed5b684f684d-20260917
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:fc808779-4db4-44e0-9ee8-ead0c321d7ec,IP:0,U
	RL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:b30f4fa16f98c85e4f7068f4aeec2ec0,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|136|850|865|898,TC:nil,Content:0|15|50|9
	9,EDM:5|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
	I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 4a0babd8b27611f19a56ed5b684f684d-20260917
X-User: zhangyunfei1@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zhangyunfei1@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1112342510; Thu, 17 Sep 2026 17:00:54 +0800
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
Subject: [PATCH net 1/2] net: ngbe: propagate resume errors to the PM core
Date: Thu, 17 Sep 2026 17:00:49 +0800
Message-Id: <20260917090050.1927999-2-zhangyunfei1@kylinos.cn>
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

ngbe_resume() declares err as u32 and unconditionally returns 0, so
failures of wx_init_interrupt_scheme() or ngbe_open() are silently
swallowed. The device stays in netif_device_detach() state with a
broken interrupt scheme, the PM core is told the resume succeeded,
and the netdev never appears in the networking stack again: the
reset task also bails out early on the missing
netif_device_present() check, so the device cannot self-heal.

Fix the type to int and return err, making the tail of the resume
path consistent with the pci_enable_device_mem() failure path at
the top, which already propagates its error. A failed resume then
becomes visible to the PM core and the device can be re-probed.

Fixes: 6963e463256e ("net: ngbe: add Wake on Lan support")
Cc: stable@vger.kernel.org
Signed-off-by: Zhang Yunfei <zhangyunfei1@kylinos.cn>
---
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index 855dc963c610..6d8289e2532d 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -954,7 +954,7 @@ static int ngbe_resume(struct pci_dev *pdev)
 {
 	struct net_device *netdev;
 	struct wx *wx;
-	u32 err;
+	int err;
 
 	wx = pci_get_drvdata(pdev);
 	netdev = wx->netdev;
@@ -977,7 +977,7 @@ static int ngbe_resume(struct pci_dev *pdev)
 		netif_device_attach(netdev);
 	rtnl_unlock();
 
-	return 0;
+	return err;
 }
 
 static struct pci_driver ngbe_driver = {
-- 
2.25.1

