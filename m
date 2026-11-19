Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.40
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795097072;
	b=m/NipnLy3gjyqbpz4Do4HvRXqn2Hx/T7jQwsXtUPs91Tgg+oHPUqkVsI7TVzuXDRbDZ0
	 f08KravDBdnN1zpwXthieFU1YKjeQ9Z166NXqnI/iQtRk6i8Mjh95y+M+sLvnfjCG1X8z
	 qZ1C7MSS7qEfrYtsjbO6RhCvdr+Gq6VBqvsvq5PBpOubOEwaIyoxJZvsLp8rUsVC9zFop
	 beJ8k/tU85c4nAmisSVZyTPSEhDC+mFbvCGj0cA93nia9MfBZLNEI4tp7aEDTqmzvYHjh
	 zXf2t6h0K0V6keRzygauB9/b0+tKbQ1L+5hMt5eqiMk/EFfBVRtHBOEa7oKAaV9QX5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795097072;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id;
	bh=vGRcRbB2ziFhxyWI2QvN4m+vvYLWQzf1owkGu4UysCg=;
	b=ke1mfr5pD57Fps+zqWZjS0Mug7P0fBdRPaCR5Zc46BywvRhauajrZ/WnAw5rmdgXtoA+
	 u7ytfNmqfqu7uYbftbS4moTPOa33OmCQpaSQw4udNKC4unX/R3/YBu2cXTNKlcswolaqC
	 ovHgQltv/ppvpyNjJkcsuHVEFPexdLzYfn3Ipz5XI+p1UURJdxW3I43NoAXd8rAGcXMFZ
	 caUeD17jb3bAIUIq/qMxeQlT3oiQzdUMFPwjCR7yDNhRCITvZARwieBUt/44f0n6ihO2M
	 CiBs4kQfZ0Yhh3R38eGd79YbJiaLTbXaiLoRJ0uqA9e2ZRPx+Dwlpn6vi45ct3sXDcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=xPNoUUdM;
	arc=none smtp.remote-ip=195.10.208.40
Received: from mout-b-210.mailbox.org (mout-b-210.mailbox.org [195.10.208.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6898560A262D;
	Thu, 19 Nov 2026 14:04:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6898560A262D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=xPNoUUdM
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-210.mailbox.org (Postfix) with ESMTPS id 4jVgFL6clVzFq3F;
	Thu, 19 Nov 2026 15:04:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1795097062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vGRcRbB2ziFhxyWI2QvN4m+vvYLWQzf1owkGu4UysCg=;
	b=xPNoUUdMtGpPd1ZBksgZS4Reu7at+KlhwHfvxUgIQM6UZ/UugnPFiIDLFzGvYxwfOLKuRh
	5TZRftTVIVXQIp0OWRz0rx3aMRGKKpns0vWCRp13Asj+bYBli3Cgp6KPcc8Mwafo0yZjGS
	ueCIGPB1X+FYu+w/LseiyY/CL0OD/anaoo1clluySZ+PiyYr7xDrJQ4kn3LUjJhtxb/acq
	XC6UL/KinioRcVgKw7QEqTsW3cX/yNi1h8TRDofTon7vnIC+rkSnNPSb0jPw7E/dPh1iU7
	PJGvxNvSDWINbHmVoga34xQ+Gg4NXKcqpyjVnP8hYczwKbF98Q8psvosywsxBw==
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
Subject: [PATCH net v3 4/4] igb: only allow runtime PM if the device can wake up
Date: Thu, 19 Nov 2026 15:04:10 +0100
Message-ID: <20261119140412.163202-5-antonio@mandelbit.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261119140412.163202-1-antonio@mandelbit.com>
References: <20261119140412.163202-1-antonio@mandelbit.com>
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
X-Rspamd-Queue-Id: 4jVgFL6clVzFq3F

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

