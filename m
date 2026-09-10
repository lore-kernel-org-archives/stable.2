Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AB425DB12
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 01:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789002031; cv=none; b=USlc7Pz7+9zC2lAvOlEs/CQm64e74xvCw9Fib8DIEtuGFggV2dnIGFwu9M+/TXbrqbKyycTAHWCajjQi8w4AY98BDNM8fiNAtoEdeyDp73DwyS2o2orVuunjyalPrY9Sbbf7zP+HGFREz6Fou7U+o8luCceRK7EDMldETRw1puI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789002031; c=relaxed/simple;
	bh=IDC35oCs29c+RuGWA0nn0XRcd5JnAJABvpzSfzp5YOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gB+rn45tLqpVBtpHBo4CcEufHvsDxdjdb5C7xGZNUTARLT04mFR+LcBj9lJ/VU9MEWzV1z7T7eF6fT/9SPOP2l8AoiJvLNAX7+0MmfoIsZd6Hb+R1ljQiy/IvOaGOqTxSPp2P89oGXGuwdVK1qmB4kQn/WbCGjVKMxIs2YU4xA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XEWcGiOA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XEWcGiOA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 592E61F000FF;
	Thu, 10 Sep 2026 01:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789002029;
	bh=l/yOwphQdl88Ynw/rTVTj2Amo6Z8IMfOzYbh6JwHZmI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XEWcGiOAkRd/ZWUQ7USyCI1UEP0FuO5PVuGhtaa4zugEjd1Q8ICWwHsWtFlvjnNeO
	 GjIIOD2pfX9Dm0tgNX5GJF4PVW1ZQXehAdHT/a33DWYa1r/+gcduhAklZHecymdRgM
	 kp3PCMtewcbcqj0PwA/j+DXdCeFMliRBOULs756T/+dZQJD8hGLGHBEV4oSOyivvAD
	 ckUCY2nyHO6pVuMfkvcwFpqzipfbwWZE6Cgnfk2b7rs/6RsRgStLNGkPllbtlEjUcD
	 BJ/gpHqG0RpOxqiXgL4NLlnaWPkPNwMGjYdRP0irW8Epn+Qnmd9WHbzoOV4JkyGRzL
	 2tdUPRxGMOw3g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Yuhang.chen" <yhchen312@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] wifi: rtw89: pci: add .shutdown callback to stop rfkill polling on reboot
Date: Wed,  9 Sep 2026 21:00:26 -0400
Message-ID: <20260910010026.3788615-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090432-juvenile-roundworm-d5e3@gregkh>
References: <2026090432-juvenile-roundworm-d5e3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Yuhang.chen" <yhchen312@gmail.com>

[ Upstream commit 667c12782aaf8dd3cb2213e528fe63a73cb63345 ]

Since the hardware rfkill polling was introduced, arm64 platforms can
panic with an asynchronous SError during warm reboot:

  SError Interrupt on CPU8, code 0x00000000be000011 -- SError
  Workqueue: events_power_efficient rfkill_poll [rfkill]
    rtw89_pci_ops_read8+0x94/0x160 [rtw89_pci]
    rtw89_core_rfkill_poll+0x50/0x1e0 [rtw89_core]
    rtw89_ops_rfkill_poll+0x40/0x68 [rtw89_core]
    ieee80211_rfkill_poll+0x3c/0x70 [mac80211]
    cfg80211_rfkill_poll+0x40/0x2a0 [cfg80211]
    rfkill_poll+0x30/0x88 [rfkill]
  Kernel panic - not syncing: Asynchronous SError Interrupt

On the reboot path the kernel only runs device_shutdown(), which calls
each driver's .shutdown callback; .remove is not invoked.  The rtw89 PCI
driver had no .shutdown callback, so nothing stopped the rfkill polling
work while the platform was tearing the PCIe link down.  Once the link
is gone, the next MMIO read from the poll handler targets a
non-responding device and is reported as a fatal asynchronous SError on
arm64.

Add rtw89_pci_shutdown(), wired to all rtw89 PCI device drivers, which
sets a new RTW89_FLAG_SHUTDOWN flag (mirroring the USB
RTW89_FLAG_UNPLUGGED pattern).  When the flag is set,
rtw89_ops_rfkill_poll() returns early, so no MMIO read is issued to the
chip after shutdown begins and the SError no longer occurs.

This does not call the full .remove path from .shutdown, to keep the
shutdown handler minimal and avoid running the non-idempotent teardown
twice.

Fixes: 0b38e6277aed ("wifi: rtw89: add support for hardware rfkill")
Cc: stable@vger.kernel.org
Suggested-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Yuhang.chen <yhchen312@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20260729014142.2746777-1-yhchen312@gmail.com
[ Omitted the .shutdown registration in rtw8922de.c because the driver is absent from the target tree. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw89/core.h       |  1 +
 drivers/net/wireless/realtek/rtw89/mac80211.c   |  3 ++-
 drivers/net/wireless/realtek/rtw89/pci.c        | 13 +++++++++++++
 drivers/net/wireless/realtek/rtw89/pci.h        |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8851be.c  |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852ae.c  |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852be.c  |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852bte.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852ce.c  |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8922ae.c  |  1 +
 10 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index e146fd082f21a..7e35168e8d606 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -5042,6 +5042,7 @@ enum rtw89_flags {
 	RTW89_FLAG_CHANGING_INTERFACE,
 	RTW89_FLAG_HW_RFKILL_STATE,
 	RTW89_FLAG_UNPLUGGED,
+	RTW89_FLAG_SHUTDOWN,
 
 	NUM_OF_RTW89_FLAGS,
 };
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 474be7a5e49c7..968d0346a87f4 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -1879,7 +1879,8 @@ static void rtw89_ops_rfkill_poll(struct ieee80211_hw *hw)
 	lockdep_assert_wiphy(hw->wiphy);
 
 	/* wl_disable GPIO get floating when entering LPS */
-	if (test_bit(RTW89_FLAG_RUNNING, rtwdev->flags))
+	if (test_bit(RTW89_FLAG_RUNNING, rtwdev->flags) ||
+	    test_bit(RTW89_FLAG_SHUTDOWN, rtwdev->flags))
 		return;
 
 	rtw89_core_rfkill_poll(rtwdev, false);
diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 17a199ee1d4a4..6c1f66e65497f 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -4829,6 +4829,19 @@ void rtw89_pci_remove(struct pci_dev *pdev)
 }
 EXPORT_SYMBOL(rtw89_pci_remove);
 
+void rtw89_pci_shutdown(struct pci_dev *pdev)
+{
+	struct ieee80211_hw *hw = pci_get_drvdata(pdev);
+	struct rtw89_dev *rtwdev;
+
+	if (!hw)
+		return;
+
+	rtwdev = hw->priv;
+	set_bit(RTW89_FLAG_SHUTDOWN, rtwdev->flags);
+}
+EXPORT_SYMBOL(rtw89_pci_shutdown);
+
 MODULE_AUTHOR("Realtek Corporation");
 MODULE_DESCRIPTION("Realtek PCI 802.11ax wireless driver");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index cb05c83dfd567..09fca0e46cd1b 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -1737,6 +1737,7 @@ struct pci_device_id;
 
 int rtw89_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id);
 void rtw89_pci_remove(struct pci_dev *pdev);
+void rtw89_pci_shutdown(struct pci_dev *pdev);
 void rtw89_pci_basic_cfg(struct rtw89_dev *rtwdev, bool resume);
 void rtw89_pci_ops_reset(struct rtw89_dev *rtwdev);
 int rtw89_pci_ltr_set(struct rtw89_dev *rtwdev, bool en);
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851be.c b/drivers/net/wireless/realtek/rtw89/rtw8851be.c
index ce59ac9f56ba8..79ea3ccb79572 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851be.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851be.c
@@ -92,6 +92,7 @@ static struct pci_driver rtw89_8851be_driver = {
 	.id_table	= rtw89_8851be_id_table,
 	.probe		= rtw89_pci_probe,
 	.remove		= rtw89_pci_remove,
+	.shutdown	= rtw89_pci_shutdown,
 	.driver.pm	= &rtw89_pm_ops,
 	.err_handler    = &rtw89_pci_err_handler,
 };
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852ae.c b/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
index 9e05e831569d2..4f1624740dd2b 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
@@ -94,6 +94,7 @@ static struct pci_driver rtw89_8852ae_driver = {
 	.id_table	= rtw89_8852ae_id_table,
 	.probe		= rtw89_pci_probe,
 	.remove		= rtw89_pci_remove,
+	.shutdown	= rtw89_pci_shutdown,
 	.driver.pm	= &rtw89_pm_ops,
 	.err_handler    = &rtw89_pci_err_handler,
 };
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852be.c b/drivers/net/wireless/realtek/rtw89/rtw8852be.c
index 12db0d0be5479..72bbaf22893fc 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852be.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852be.c
@@ -96,6 +96,7 @@ static struct pci_driver rtw89_8852be_driver = {
 	.id_table	= rtw89_8852be_id_table,
 	.probe		= rtw89_pci_probe,
 	.remove		= rtw89_pci_remove,
+	.shutdown	= rtw89_pci_shutdown,
 	.driver.pm	= &rtw89_pm_ops,
 	.err_handler    = &rtw89_pci_err_handler,
 };
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bte.c b/drivers/net/wireless/realtek/rtw89/rtw8852bte.c
index 8c995aa953251..b10587fa5f324 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bte.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bte.c
@@ -98,6 +98,7 @@ static struct pci_driver rtw89_8852bte_driver = {
 	.id_table	= rtw89_8852bte_id_table,
 	.probe		= rtw89_pci_probe,
 	.remove		= rtw89_pci_remove,
+	.shutdown	= rtw89_pci_shutdown,
 	.driver.pm	= &rtw89_pm_ops,
 	.err_handler    = &rtw89_pci_err_handler,
 };
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852ce.c b/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
index 150fed189414d..281f46455de42 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
@@ -121,6 +121,7 @@ static struct pci_driver rtw89_8852ce_driver = {
 	.id_table	= rtw89_8852ce_id_table,
 	.probe		= rtw89_pci_probe,
 	.remove		= rtw89_pci_remove,
+	.shutdown	= rtw89_pci_shutdown,
 	.driver.pm	= &rtw89_pm_ops,
 	.err_handler    = &rtw89_pci_err_handler,
 };
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922ae.c b/drivers/net/wireless/realtek/rtw89/rtw8922ae.c
index 90c62b757c57b..1ad7d44d03522 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922ae.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922ae.c
@@ -109,6 +109,7 @@ static struct pci_driver rtw89_8922ae_driver = {
 	.id_table	= rtw89_8922ae_id_table,
 	.probe		= rtw89_pci_probe,
 	.remove		= rtw89_pci_remove,
+	.shutdown	= rtw89_pci_shutdown,
 	.driver.pm	= &rtw89_pm_ops_be,
 	.err_handler    = &rtw89_pci_err_handler,
 };
-- 
2.53.0

