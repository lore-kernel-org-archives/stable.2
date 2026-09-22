Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC3B52ED54;
	Tue, 22 Sep 2026 10:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790071736; cv=none; b=XhfdoJ9ri15SEp2d7QaOv80o5FfUonrG7qe2ARt/q/MKcICzgW4XI60nbri1ulDBV9JFz8f1oTQJ4+ONdLbLb3a3Zpqqhm6ROYlPpZtIRiGNUoeS+DLUqEnPb/Jdtbns49PpXy2SmNN/sY4d15xIQDX/Hk9qRILAr77T/M12LZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790071736; c=relaxed/simple;
	bh=e+eNEcMPwuY1L/f/No9euutQJ6DWj+ZEmGwxUzDnIMs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UWYL0plhTqxO+PPaBhH1N5n/3+2Reu5mQmmNPwsVXYpDYI+qoxm5kk4KsX+74m+eqMBa7/4UMT+58k1K5CWgX9/eYTWQjZEi8U4yPgNx4C8kwRNr6Ph9pIHUd1HEf+JkeE1kF9J4OEcP+Qk1GXhOPxrmoUyIY83b7Tg5bmU71JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 97e11f5ab66d11f19a56ed5b684f684d-20260922
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:2228f14f-ae5e-4d52-8510-a92a882dbd55,IP:0,U
	RL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:7c91bf996b27ec3763f539524f2e0972,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|136|850|865|898,TC:nil,Content:0|15|50|9
	9,EDM:5|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
	I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 97e11f5ab66d11f19a56ed5b684f684d-20260922
X-User: zhangyunfei1@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zhangyunfei1@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1361700814; Tue, 22 Sep 2026 18:08:44 +0800
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
Subject: [PATCH net v2 1/2] net: ngbe: propagate resume errors to the PM core
Date: Tue, 22 Sep 2026 18:08:35 +0800
Message-Id: <20260922100836.1147718-2-zhangyunfei1@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260922100836.1147718-1-zhangyunfei1@kylinos.cn>
References: <20260922100836.1147718-1-zhangyunfei1@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ngbe_resume() declares err as u32 and unconditionally returns 0, so
failures of wx_init_interrupt_scheme() or ngbe_open() are silently
swallowed, and the return value of ngbe_reset_hw() is ignored
entirely. The device stays in netif_device_detach() state with a
broken interrupt scheme, the PM core is told the resume succeeded,
and the netdev never appears in the networking stack again: the
reset task also bails out early on the missing
netif_device_present() check, so the device cannot self-heal.

Fix the type to int and propagate the errors instead, making the
whole tail of the resume path consistent with the
pci_enable_device_mem() failure path at the top, which already
propagates its error. If the hardware reset fails, the remaining
resume steps cannot succeed, so return early instead of continuing
with a broken device. A failed resume is then reported to the PM
core, which records and logs the failure, instead of being silently
swallowed.

Fixes: 6963e463256e ("net: ngbe: add Wake on Lan support")
Cc: stable@vger.kernel.org
Signed-off-by: Zhang Yunfei <zhangyunfei1@kylinos.cn>
---

Changes in v2:
- also propagate the ngbe_reset_hw() failure, so the whole tail of
  ngbe_resume() reports errors to the PM core;
- drop the inaccurate "device can be re-probed" claim: the PM core
  records and logs the failure, there is no re-probe.

 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index 855dc963c610..e8cabcc84a41 100644
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
@@ -968,7 +968,9 @@ static int ngbe_resume(struct pci_dev *pdev)
 	pci_set_master(pdev);
 	device_wakeup_disable(&pdev->dev);
 
-	ngbe_reset_hw(wx);
+	err = ngbe_reset_hw(wx);
+	if (err)
+		return err;
 	rtnl_lock();
 	err = wx_init_interrupt_scheme(wx);
 	if (!err && netif_running(netdev))
@@ -977,7 +979,7 @@ static int ngbe_resume(struct pci_dev *pdev)
 		netif_device_attach(netdev);
 	rtnl_unlock();
 
-	return 0;
+	return err;
 }
 
 static struct pci_driver ngbe_driver = {
-- 
2.25.1

