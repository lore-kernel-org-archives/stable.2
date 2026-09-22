Received: from mail-qk2-f42.google.com (mail-qk2-f42.google.com [74.125.230.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9398C175A83
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 00:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790035763; cv=none; b=KK0uSO9KrwB7+I6w9XCYF+Fv343j9auha0lVbK7NBxiruXRG5j1SDWLHKSHzSsHqVfTmqlOMRhk1+6FJXSc0ZkGgV0MTgQH0Rzh+TPfqVhQdWN02V7RfhWt2bnUCE3TpX8RH3eW/iPxZ7RH1EGC8mwbLwyPeyUPLT4G8tkOif+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790035763; c=relaxed/simple;
	bh=g+F1XzIjG9tPsGCMtumO2J7BqYdSrLwWUlEAMXEUQy4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rQZpwlQL8gl/dgJ9hEDVetP3L0+wmmzvhTorI3O9utK/AqI4ynMUgnUGe6D2C5TwckX2IyDEcyYQm2NolbhrCw1WPG/Rf+HtyjFeI7Ix7sQ/M4yHRNZXrmyowimJYQ2ZEkSKaAsrggvnc4Vl5oPqj/qmrLKJAlhS3zEXFWlsr/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qGGPDtBe; arc=none smtp.client-ip=74.125.230.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qGGPDtBe"
Received: by mail-qk2-f42.google.com with SMTP id af79cd13be357-93bd580489dso365594285a.1
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 17:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790035759; x=1790640559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+px+gyXVLidkcy+k/uZ//IG8TqK3wgfrhlr6nss3oOM=;
        b=qGGPDtBeywuo8153H6+ImNCOQoLuVwZOD6Mn+7G7Z34viSUp0V7Vi9B3EQK1qFe7N+
         LHX8M3oXk2LQkNZzXaBuY0cvlBT8iDieUmTacF5nCg26WHx4wC9MIa1U9ba5DK5OpTE7
         6S2XAl5sOt5Ck16J06WaF4rJAwBR6aDueZfjtbsStFgd4m73AR27P8qxvQncXG1QlaJL
         5VgXA+FQOmFiw/7wJxcX+MwYxeBHNWKQ53RAlhYFsMyh5J+3EqtFbPIMBorEZkf8enPj
         b9L5oId/otBx92cRC+WKNThy5zk7+DwfvT+2mYd0wyzGm4SEkF8/SWFITwMyMfaelVgG
         gKBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790035759; x=1790640559;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+px+gyXVLidkcy+k/uZ//IG8TqK3wgfrhlr6nss3oOM=;
        b=oafWgRHkigcPJZz3ECR8AgYhpnUULXM9CZTJn0YVHmcbaMKxsM8fdAZypSldFrVOsJ
         J3q+obE7BqRljkHT7IabD0nGxDUNYu/TiYg5sKI1mrOoSQ6nEx3K7ykOtWKH41OjZTHs
         21l1H9uzj518OoSrhBhT8BQHs22IjqXP3BP2h8tPVNidCIEaN403ClE0p70832DiB2Kg
         kqDQ/3g28F/xXLbn1SHNwrnXjvKz+doa1tRTJ5C/CPDFXdshOhwfQbC/Tzs8VPA6JOMZ
         Xo6Q0CPhRWdO/8TXvKf9oA4HyEKS5RFZa9RCH1O9K60Z1ypT81SJpQ4bmZXoLYtLEJvb
         GvYA==
X-Forwarded-Encrypted: i=1; AKwUvBwfu78qU1QSeuOdJFjIBEGHylh6STfIUPItXne+34aIorglLZ1sFm8ktwSPpLxx34Kn10hOSQ0=@vger.kernel.org
X-Gm-Message-State: AFuF++kIUsn/O4dbw0A1tHFeTuvxS38guX+WJVVUS1toMKmIdoCJm5QN
	ZCOw1q5fMNkCaO4W9csWPtzxtsdT3eB2X9gKhCq70YzdBxiCgAcvGy4=
X-Gm-Gg: AYBFou2BctqRIQ/EVUTIneyPlymCxTGuZflH/wUCZNEMqIvCJBVMam0+kdLlhgb7tsS
	2Oo6K40g7eBydVZ8CrymOOz0dhj1ZFDh69d9uDKK4aUsn07iI65wnhdTadkiaEBDdxbGxQ6CRxp
	vN3ITg/yspdl1EOUBBSVInGlWx3ftEufhfXawyG9v3nuZHEfoCDZJh6DS0YT77UPpRn9TJvdNSa
	I6W59FvCJW3DRYdHXs/wxQQjxgNNayczKMo5qrrYlE/iw9Bc17noQgTj4c2fIhMMwhrUzlyspv6
	wKpjh7ijeLYYkrfmgl1NWN3VX6T97cbCHIOaGuspDYwKtmp2Nn5SPvcjbNloLy88MmDnox6kDRO
	/EUFh5izIKc3EdCClKrlVoWHfk90Qsy2j1RjDWMe5DYMNKj/TKmRUyo1VivNnN6BMFlFEzkTRyd
	2KPFGkksQO11tLuwjtArSYMVTA62RXd3T5NxQQlvgHh99XPQZbZEqR82YW3rnhDwpHljsrCJxKt
	rv/BXAS3Qo1SftT2q0n/QyG5YkK1OS1AnpuhXcwgEpmKWeyiCBq1+pvy1mg+3TR6v5/JMD/PogE
	KJPJi71qUeZT7bFth4dSQAJabTCH
X-Received: by 2002:a05:620a:1791:b0:93b:f246:bae8 with SMTP id af79cd13be357-93c15e78ed6mr305051085a.37.1790035759325;
        Mon, 21 Sep 2026 17:09:19 -0700 (PDT)
Received: from i4-gl-tmk5904-1.ad.psu.edu ([130.203.156.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c19a812d4sm53263785a.22.2026.09.21.17.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 17:09:18 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Myeonghun Pak <mhun512@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH net] net: airoha: npu: cancel wdt_work after releasing the WDT IRQ
Date: Mon, 21 Sep 2026 20:09:14 -0400
Message-ID: <20260922000914.542068-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

airoha_npu_remove() calls cancel_work_sync() on each core's wdt_work,
but the watchdog IRQ that queues it is requested with devm_request_irq()
and is freed only after .remove() returns.  airoha_npu_wdt_handler() can
therefore schedule_work() again once the cancel has returned.  struct
airoha_npu, which contains the work, is devm_kzalloc()'d and is freed in
that same unwind, so the late work dereferences freed memory.

Register the work with devm_work_autocancel() before devm_request_irq()
and drop .remove().  Devres runs in reverse order, so the IRQ is freed
before cancel_work_sync(), including when probe fails.  A cancel left in
.remove() cannot get that order.  Initializing the work first also stops
a pending watchdog interrupt from queuing an uninitialized work item.
Probe currently calls INIT_WORK() only after devm_request_irq().

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: 23290c7bc190 ("net: airoha: Introduce Airoha NPU support")
Cc: stable@vger.kernel.org # 6.15+
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/net/ethernet/airoha/airoha_npu.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ethernet/airoha/airoha_npu.c
index 5bb4817a898d..4d3195eb00f7 100644
--- a/drivers/net/ethernet/airoha/airoha_npu.c
+++ b/drivers/net/ethernet/airoha/airoha_npu.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/devcoredump.h>
+#include <linux/devm-helpers.h>
 #include <linux/firmware.h>
 #include <linux/platform_device.h>
 #include <linux/of_net.h>
@@ -751,12 +752,15 @@ static int airoha_npu_probe(struct platform_device *pdev)
 		if (irq < 0)
 			return irq;
 
+		err = devm_work_autocancel(dev, &core->wdt_work,
+					   airoha_npu_wdt_work);
+		if (err)
+			return err;
+
 		err = devm_request_irq(dev, irq, airoha_npu_wdt_handler,
 				       IRQF_SHARED, "airoha-npu-wdt", core);
 		if (err)
 			return err;
-
-		INIT_WORK(&core->wdt_work, airoha_npu_wdt_work);
 	}
 
 	/* wlan IRQ lines */
@@ -803,18 +807,8 @@ static int airoha_npu_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static void airoha_npu_remove(struct platform_device *pdev)
-{
-	struct airoha_npu *npu = platform_get_drvdata(pdev);
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(npu->cores); i++)
-		cancel_work_sync(&npu->cores[i].wdt_work);
-}
-
 static struct platform_driver airoha_npu_driver = {
 	.probe = airoha_npu_probe,
-	.remove = airoha_npu_remove,
 	.driver = {
 		.name = "airoha-npu",
 		.of_match_table = of_airoha_npu_match,

base-commit: 238650ef6c7c7cca08e032527329424c9fbd70e5
-- 
2.53.0
