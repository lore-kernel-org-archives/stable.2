Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794567547;
	b=cIsF75p/En6Shagwk/i5i6EnsZc5ns3CLgqb4JI4iA+4YB0KPU45QPsZuhUF1G8PWfMo
	 C4f60pyJTfAfPcoIgQrImoqOrK4CuWfCqqQqZB/7Venyyv/qshKb/9diWGvRoSmX+bXcI
	 2+0ngZoLb4nZZuAFChXOTR30UWdp+g4MrRdErWeqYmNvNyWvkfrmCOFpq0CXXQl7XsUO1
	 LAWlPSIkRZ47A8XVfr1CXtDo+f4sGRPbfodzjc8puAn79qyU7CmniKOdp0baxja7CxySM
	 VgPPrCMbt7M6aQ6oWLA4TzMh9m689JFbw/q9ky7mCNrLel2xkaPVtYlKUh8kFqn9xCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794567547;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id;
	bh=glKruA5muTr4k5zyDKpMfaKEQatBb9MU3FU/gWAzl6U=;
	b=Hp3aSQHAJWzqiQpUuX1miqe8xmrcqc6HYpgjH7W+9vYEy9awW5FcHTYqYuOQAEpCOs3J
	 NPM4s9TWMz9SoW2nPFpK4hP9vpRekVAwZs4fB/0VJ6xDERmUPzymEHKa2wGJkEbX+qcoH
	 3gUMnxgn2b+ZmRj3Fr1dVma/ZAAbwPqmRJ+mNzNtwyDEnwQfYijZ5XtWVCcqodGheYIc4
	 oS4GJmw8/hnd8lH9/oPQVWLNHkiicNVV7CVILMBvuObdrBOv9+ANwlLQVMKM8LuheWVz1
	 jc0d2pyEP5y4b7syIfGL/XZ6hR/2p6TrqOyyj0vBwC/voEqBp1uWwCHY7ApEQACY3AQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=ClZB++I9;
	arc=none smtp.remote-ip=195.10.208.55
Received: from mout-b-110.mailbox.org (mout-b-110.mailbox.org [195.10.208.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC11D606B26C;
	Fri, 13 Nov 2026 10:59:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC11D606B26C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=ClZB++I9
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-110.mailbox.org (Postfix) with ESMTPS id 4jQvQ0026wzNmD9;
	Fri, 13 Nov 2026 11:58:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1794567528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=glKruA5muTr4k5zyDKpMfaKEQatBb9MU3FU/gWAzl6U=;
	b=ClZB++I9/DL5q3UOhzm5ne4XL5kAB3pQHYGawyeMbkNlt/W4/XOlaDtsslcXdTfo1q+v2Q
	CvZoFJF5COMcKf+InnoKOhb8SjDv+Eeuc7p0keMxQGoctyUTOeLcgAjPKcFyH0+TvHLR4i
	B3OMkA7T5MpQM+S39Geys+tiFmoyKvoCehIKW859vmdOSp7ovCJHNmllMEPJOx3t25g6Yz
	uwPZ587vMzM8m2BBb5Ux79Jjj5/6vAfFDXhLH6R0y+JeusamCp/9b+rQi6r7wpvE/47I1M
	AkHCkaJBAruEXgAGqEGp9wkJnAlMGNbP4lJ8cvk8fWXa+fior//AXn1shxZnkg==
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
Subject: [PATCH net 3/3] igb: only allow runtime PM if the device can wake up
Date: Fri, 13 Nov 2026 11:58:33 +0100
Message-ID: <20261113105835.3821433-3-antonio@mandelbit.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261113105835.3821433-1-antonio@mandelbit.com>
References: <20261113105835.3821433-1-antonio@mandelbit.com>
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
X-Rspamd-Queue-Id: 4jQvQ0026wzNmD9

igb lets the device be runtime suspended even if it can't signal a
wake-up from D3. Such a device doesn't notice the link coming back, so
the port stays down until it is resumed from user space.

Allow runtime PM only if pci_dev_run_wake() is true, as e1000e and
r8169 do. Devices that can't wake up no longer runtime suspend, even
with power/control set to auto.

Fixes: 749ab2cd1270 ("igb: add basic runtime PM support")
Cc: stable@vger.kernel.org
Closes: https://bugzilla.ipfire.org/show_bug.cgi?id=13562
Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
---
Note: igc may have the same issue: igc_probe() also allows runtime PM
regardless of pci_dev_run_wake(). We didn't have igc hardware to test a
fix with, so no igc patch is sent for now.

 drivers/net/ethernet/intel/igb/igb_main.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 4d97399..59f59da 100644
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

