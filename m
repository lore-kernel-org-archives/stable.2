Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998963B83F9;
	Wed, 30 Sep 2026 09:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790761689; cv=none; b=u1zCjnIPeM8SfMxzn53fs0BSeceowy7YZr76yCOQThwyhgQv1CmsAQdZtqmTRyItu1RTfkbIYRTOb/ixaztG8xH1g4UswA5BC66QyfKMx+gdfFaWLTPXYlDBM+HlNe1gq9KeuVEHSTBwtSHD4uV1m1LUs06ZGPqStgUY7x50Xqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790761689; c=relaxed/simple;
	bh=zm5VFrHmyz+/sNLaSW+Dt3U8QFai1/239D3Wu5zb/O0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TvWe0DbO845fLZzLP6sRSL5+dAJT3wgzLF01cDohh/iux8PVYv4XqAsmvVvPUwnvlZcrj2mrYyZ/yeZJsiL24qrFWcizWJ/jzt4AvTjT7sk0ggsf06sIz/uKM831qPYPryHylsBEHOWJXmfzHCdoQtmBJRadv+dqzD+hmuO6bjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 01a9e916bcb411f19a56ed5b684f684d-20260930
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:8edde7f8-6271-41aa-9eb6-c503825cf016,IP:0,U
	RL:25,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:25
X-CID-META: VersionHash:7db8b62,CLOUDID:dd6e600df21f98dd37a51a1cc52b3aa1,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|136|850|865|898,TC:nil,Content:0|15|50|9
	9,EDM:5|-100,IP:nil,URL:11|95|82|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil
	,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 01a9e916bcb411f19a56ed5b684f684d-20260930
X-User: zhangyunfei1@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zhangyunfei1@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1997194022; Wed, 30 Sep 2026 17:47:53 +0800
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
	leitao@debian.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH net v3 1/2] net: ngbe: propagate resume errors to the PM core
Date: Wed, 30 Sep 2026 17:47:47 +0800
Message-Id: <20260930094748.1198085-2-zhangyunfei1@kylinos.cn>
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

After a failed resume from suspend, the device stays detached from
the networking stack: every attempt to bring the interface up fails
the netif_device_present() check in __dev_open() with -ENODEV,
while the PM core is told that resume succeeded.

ngbe_resume() declares err as u32 and unconditionally returns 0:
the return value of ngbe_reset_hw() is ignored entirely, and
failures of wx_init_interrupt_scheme() and ngbe_open() are silently
swallowed. The interrupt scheme torn down at suspend is never
rebuilt, so the device cannot self-heal.

Fix the type to int and propagate the errors, making the whole tail
of the resume path consistent with the pci_enable_device_mem()
failure path at the top. If the hardware reset fails, return early:
the remaining resume steps cannot succeed. The suspend path may
already have torn the interface down (ngbe_close() and
wx_clear_interrupt_scheme()), leaving freed rings and IRQs behind
while netif_running() still reports true, so set WX_STATE_RES_FREED
on every failing return, the same mark ngbe_down_suspend() uses for
the PCI error recovery path: a later ngbe_close() skips the
teardown of the already-freed state, and ngbe_up_complete() clears
the bit again so later opens are unaffected. This is safe on the
wx_init_interrupt_scheme() failure path too, as it cleans up after
itself.

Found by manual code inspection of the PM error paths; the missing
ngbe_reset_hw() propagation was reported by Sashiko in its review
of v1. The failure paths are unreachable without fault injection:
a loadable test module injects failures into ngbe_reset_hw(),
wx_init_interrupt_scheme() and ngbe_open(). In a QEMU VM the
unfixed driver hits the kernel "Trying to free already-free IRQ"
warning on the post-suspend close; with the fix, the error is
reported and no warning appears. No physical ngbe device is
involved.

Fixes: 6963e463256e ("net: ngbe: add Wake on Lan support")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917090050.1927999-1-zhangyunfei1%40kylinos.cn
Cc: stable@vger.kernel.org
Signed-off-by: Zhang Yunfei <zhangyunfei1@kylinos.cn>
---
Changes in v3:
- set WX_STATE_RES_FREED on every failing return of ngbe_resume()
  (the pci_enable_device_mem() failure, the reset failure early return
  and the wx_init_interrupt_scheme()/ngbe_open() failures), so that a
  later ngbe_close() skips re-running the teardown on the already-freed
  post-suspend state (Sashiko review of v2);

Changes in v2:
- also propagate the ngbe_reset_hw() failure, so the whole tail of
  ngbe_resume() reports errors to the PM core;
- drop the inaccurate "device can be re-probed" claim: the PM core
  records and logs the failure, there is no re-probe.

 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index 855dc963c610..8247f6c14be0 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -954,13 +954,14 @@ static int ngbe_resume(struct pci_dev *pdev)
 {
 	struct net_device *netdev;
 	struct wx *wx;
-	u32 err;
+	int err;
 
 	wx = pci_get_drvdata(pdev);
 	netdev = wx->netdev;
 
 	err = pci_enable_device_mem(pdev);
 	if (err) {
+		set_bit(WX_STATE_RES_FREED, wx->state);
 		wx_err(wx, "Cannot enable PCI device from suspend\n");
 		return err;
 	}
@@ -968,16 +969,23 @@ static int ngbe_resume(struct pci_dev *pdev)
 	pci_set_master(pdev);
 	device_wakeup_disable(&pdev->dev);
 
-	ngbe_reset_hw(wx);
+	err = ngbe_reset_hw(wx);
+	if (err) {
+		set_bit(WX_STATE_RES_FREED, wx->state);
+		wx_err(wx, "Hardware reset failed: %d\n", err);
+		return err;
+	}
 	rtnl_lock();
 	err = wx_init_interrupt_scheme(wx);
 	if (!err && netif_running(netdev))
 		err = ngbe_open(netdev);
 	if (!err)
 		netif_device_attach(netdev);
+	else
+		set_bit(WX_STATE_RES_FREED, wx->state);
 	rtnl_unlock();
 
-	return 0;
+	return err;
 }
 
 static struct pci_driver ngbe_driver = {
-- 
2.25.1

