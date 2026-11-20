Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795208526;
	b=falrZpZNorE+tC/fBRcdjvjyv3PF+as/sG/99J2oGAu/nzUEaR9gpTuIeA8/5CKXbQp7
	 yzRzdkV1856ppz5jSEnD2mljdHpp3xE0S6Zj8I8bayESWkzt3+g425mIkns5aqVfq5uCC
	 B5QmXgj6F1akMTE7uhSQm97/5Uy2GyFtGJQy2eO3xhdRaaOS/T8zgBDdez4Av5Zi+WjrY
	 wn32DXtkNWe6wd/ygFDwrJcV2FrPFel6A0rVuv3FiRL4IxfFZ/quMhwU2rYf5oOkzZYqF
	 0xIksJOei9sgErMWndMvdig6tlG320192fOYMn5BWx8+zhLsAgtFXjOdGWm5eKhh+bA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795208526;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id;
	bh=n34JAgo+BYEXBsBH3HriYNhCx1OSAseNztdfnC7EmCA=;
	b=GsN9DMdm0slSdGvaSVpoZNZYfw2+inswcIvqzlM0sTdymvu0fqgwTlYFUiUuMbBpoTAN
	 PFneuHbqt87LbyVX6gTffdyHTRLDHD1z0SvB5XVK8uapIzf26MrNQ8JUfnrqTFUgA1hwa
	 DJoxuFCZQ5SMrIvGXfqTU9/fa+NCwIlZqTyT96rWLi0rtiRBKwJvxNLUB1q2YiO3FvmJZ
	 a42zTdCRHm4LMy3TiMyRr2D2i8ztcnEf4J9mXYIi7M3vhkw48ru5oRbIQLLOGoU53Mh3W
	 Vptb3dZYKKK00X2Ili0yT6I+Rha+thTJViTyB+VPdLdlAfKY7NBiZYQtaFtSj3Bznfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=H2YdIHHe;
	arc=none smtp.remote-ip=195.10.208.47
Received: from mout-b-107.mailbox.org (mout-b-107.mailbox.org [195.10.208.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3235606A696;
	Fri, 20 Nov 2026 21:01:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3235606A696
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=H2YdIHHe
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-107.mailbox.org (Postfix) with ESMTPS id 4jWSST2lTlz3wjt;
	Fri, 20 Nov 2026 22:01:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1795208505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n34JAgo+BYEXBsBH3HriYNhCx1OSAseNztdfnC7EmCA=;
	b=H2YdIHHeSCyc4bQ+GvtyAWBTBiXFnjJVPo1L8cQw/bC4eWfX5sTS2rst213vmMT7ANXl+K
	UqLWCTWBQbXL1+QCYmiBEZOB6UUOfsHWWX13/NPvY8WqdhN5LHtv3U4Jyog5pmnBy/ZAZp
	TBBmdJ+REW9dSmU2skOBgoz8XPnoBWvmrdvMvlYWHwEJzGqBCA0C5BT6TvxCKjjmMRICay
	NZn+MTVAJsW4xDI6taVRZ1mfekmKFADaGpIBoueISzy+gLWetSOHiNLHJQIpW+ehooigDN
	PQKzja6RbokrD8xGDUqAATOJhzEGGjwmTBcSQR69HE+9Fcv8xw3XNk65ARnZKg==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of antonio@mandelbit.com designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=antonio@mandelbit.com
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
	Janis Edvarts Lacis <janislacis06@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v4 4/4] igb: only allow runtime PM if the device can wake up
Date: Fri, 20 Nov 2026 22:01:32 +0100
Message-ID: <20261120210134.133238-5-antonio@mandelbit.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261120210134.133238-1-antonio@mandelbit.com>
References: <20261120210134.133238-1-antonio@mandelbit.com>
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
X-Rspamd-Queue-Id: 4jWSST2lTlz3wjt

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
v4: no changes
v3: no changes
v2: no code changes; mention the tested hardware

Note: igc has the same issue: igc_probe() also allows runtime PM
regardless of pci_dev_run_wake().

 drivers/net/ethernet/intel/igb/igb_main.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 6196d7a..72eeaf3 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -3654,7 +3654,11 @@ static int igb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	dev_pm_set_driver_flags(&pdev->dev, DPM_FLAG_NO_DIRECT_COMPLETE);
 
-	pm_runtime_put_noidle(&pdev->dev);
+	/* A device that can't wake up wouldn't notice the link coming back
+	 * while runtime suspended
+	 */
+	if (pci_dev_run_wake(pdev))
+		pm_runtime_put_noidle(&pdev->dev);
 	return 0;
 
 err_register:
@@ -3876,7 +3880,8 @@ static void igb_remove(struct pci_dev *pdev)
 	struct igb_adapter *adapter = netdev_priv(netdev);
 	struct e1000_hw *hw = &adapter->hw;
 
-	pm_runtime_get_noresume(&pdev->dev);
+	if (pci_dev_run_wake(pdev))
+		pm_runtime_get_noresume(&pdev->dev);
 #ifdef CONFIG_IGB_HWMON
 	igb_sysfs_exit(adapter);
 #endif
-- 
2.56.1

