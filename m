Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794843057;
	b=kteH8QPJMta+Lu4rHZwrlUJEem9hoiATD9INi3A5qlw+UUn8Sjm7AO7PlWsJ9junfBjZ
	 D95e5wKU8FO4TpFR5lXGwfFV7oB93ZEoqpv33u58mALT8wq+J7rPNWrKS5zJ24Ndqt63R
	 hT3famEIp+qSUidevxGjJCr/wAdaYnkIL1/o0ixr+UVqpVVkO0VMUITAyWCrDl5riCupm
	 gNUBpgL1FYee4gLKGpPCXzB1XcDda7WePHQj9xuhN6kLlnX/cc3HB26I7uMEKTWRGQJoT
	 d/t4ORTPWNey1vD8Zz1hbyQjoIFl0cIBFM00qGQ+M3Dx+vUxPkPeNvzq2z9ypo37uYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794843057;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id;
	bh=32NJq9EvkJ4412Q5l3aqJH/r1Tghp1UTAcFKtTsA+rA=;
	b=IMQTApBe/HCZZ+Yx78teql4Q5v3ukegIM5OuWQXSBAu9zJAvMpof7Ao2aUFdppMy9Xdm
	 kD+oRoCvAgsbfVlzSMOh+VcLSGlo+bh5IIucJNkw1rkJU+myjYa3/IEF6TU1i32k/dqYe
	 W0STIKQp4KYabJ1FZnXTEbv2fNA57VrQuvcqYYbajwPhQ5JyiU1OdTCE+S41V4QsTLCLd
	 IdIyRyQm7obUeUrZ8J+2CJTdgW0UhoOFXGqZrnRE1RO/QM57cIhO4uQTVkPSpBstw4sZ6
	 DbjrYe0yjE9qpW7V10RjUdyYzw4haiYBDUaTpdZK0NHHU5cp0N5fjzvkM9pMeLfye/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b="np/GTuzu";
	arc=none smtp.remote-ip=195.10.208.51
Received: from mout-b-206.mailbox.org (mout-b-206.mailbox.org [195.10.208.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A68606A31C;
	Mon, 16 Nov 2026 15:30:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3A68606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=np/GTuzu
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-206.mailbox.org (Postfix) with ESMTPS id 4jSsJW5x0VzQm;
	Mon, 16 Nov 2026 16:30:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1794843051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=32NJq9EvkJ4412Q5l3aqJH/r1Tghp1UTAcFKtTsA+rA=;
	b=np/GTuzuFjpeRDolIiAp3KNxgTZBJfYfUlQsjv9SOH8WUqpiKwT1o/0cxG+nSsn/t7+hvH
	2bfHm/ivbFFOTTi7WogQlj3LxV1isvhJfuVKr/9qxUMOCDXm5LprFGxfyCd+wAXJmRDOnq
	2uDnODFHsWHSquYixYqfkHbKJ8Vv7kovkaTr5SNFkBA+bpMOWLDthq27FL6EKdv537sDXT
	N0l0Yrz7MjerKJVK8Te7eDtbD9UQ3VadhTF53MoQn2I3HvN8vdvvQyOAr3EwkiFzlIrB+e
	tuWduSkkU7/yJOvu0jGMGpQ7ciPqHHB9svJsHeXJm5Ro9HJDDd3Lb/AP/R1p/g==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of antonio@mandelbit.com designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=antonio@mandelbit.com
From: Antonio Quartulli <antonio@mandelbit.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Antonio Quartulli <antonio@mandelbit.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Yan, Zheng" <zheng.z.yan@intel.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v2 3/3] igb: only allow runtime PM if the device can wake up
Date: Mon, 16 Nov 2026 16:30:39 +0100
Message-ID: <20261116153041.3002666-4-antonio@mandelbit.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261116153041.3002666-1-antonio@mandelbit.com>
References: <20261116153041.3002666-1-antonio@mandelbit.com>
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
X-Rspamd-Queue-Id: 4jSsJW5x0VzQm

igb lets the device be runtime suspended even if it can't signal a
wake-up from D3. Such a device doesn't notice the link coming back, so
the port stays down until it is resumed from user space.

Allow runtime PM only if pci_dev_run_wake() is true, as e1000e and
r8169 do. Devices that can't wake up no longer runtime suspend, even
with power/control set to auto.

Tested with the 82576 emulated by QEMU.

Fixes: 749ab2cd1270 ("igb: add basic runtime PM support")
Cc: stable@vger.kernel.org
Closes: https://bugzilla.ipfire.org/show_bug.cgi?id=13562
Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
---
v2: no code changes; mention the tested hardware.

Note: igc may have the same issue: igc_probe() also allows runtime PM
regardless of pci_dev_run_wake(). We didn't have igc hardware to test a
fix with, so no igc patch is sent for now.

 drivers/net/ethernet/intel/igb/igb_main.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 894eedb..9046611 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -3677,7 +3677,11 @@ static int igb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	dev_pm_set_driver_flags(&pdev->dev, DPM_FLAG_NO_DIRECT_COMPLETE);
 
-	pm_runtime_put_noidle(&pdev->dev);
+	/* A device that can't wake up wouldn't notice the link coming back
+	 * while runtime suspended
+	 */
+	if (pci_dev_run_wake(pdev))
+		pm_runtime_put_noidle(&pdev->dev);
 	return 0;
 
 err_register:
@@ -3900,7 +3904,8 @@ static void igb_remove(struct pci_dev *pdev)
 	struct igb_adapter *adapter = netdev_priv(netdev);
 	struct e1000_hw *hw = &adapter->hw;
 
-	pm_runtime_get_noresume(&pdev->dev);
+	if (pci_dev_run_wake(pdev))
+		pm_runtime_get_noresume(&pdev->dev);
 #ifdef CONFIG_IGB_HWMON
 	igb_sysfs_exit(adapter);
 #endif
-- 
2.56.0

