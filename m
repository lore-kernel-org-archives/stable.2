Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E160D3F8236
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 04:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788497328; cv=none; b=pYIBYW1ZMrLCFX3yRux4r0ZSK7IEWd1CeozlIGI3x69C0B+XV0n7mI9tIVh2b+h2GBeeAn2P55doi6spcb9ziX1fK6iX+erydKTsdej5hL/AzKCWEp6URUt7PXkACh+HgMhpS3ot5Jdf/C1CpWny7tzQ87nNRzKhE7O5pCaOwUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788497328; c=relaxed/simple;
	bh=Ujx2/GcxmfzT+3P7DIPGtQMFVT+U0MMrsZYM3deg0b8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=br66aG3xlqJFY1SdZT8lF4ckuozbdzGQdfdln9iPqyX8NG3BN8yzK6VcogVcmEEcUJR6fffPZIG8fSyILQfo3pRVotWvHLnnZC7W1R8BLz+wdMvmNiwknVRHScY6NRql7RTgm5u/6e4E9qRdYfgMJkQ1mvoQyFNl+13wkQYWE9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BwkDgvC5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BwkDgvC5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F5C41F00A3D;
	Fri,  4 Sep 2026 04:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788497326;
	bh=2UheLhw3NYhTc+UuqxzU9ZjDM5vAL9q+3+aVIP+ySYY=;
	h=Subject:To:Cc:From:Date;
	b=BwkDgvC57CSiECmxMFDyxaG8v/kh4R7NYIX1foib7lAR02mZ7Mh74G+ezvp0FXbiW
	 ZpcNws/t0yuuGD3ym13CGtr1h8fQhaJqiBQeAd7mgU3iW+6C2MOG0wsqK1/xQzazKi
	 Q4eeIEmkQO5upIyzV6/hEUU3tywq4M9wdtlwcDWk=
Subject: FAILED: patch "[PATCH] wifi: rtw89: pci: add .shutdown callback to stop rfkill" failed to apply to 6.12-stable tree
To: yhchen312@gmail.com,pkshih@realtek.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 04 Sep 2026 06:48:33 +0200
Message-ID: <2026090433-armed-frequent-d9dc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 667c12782aaf8dd3cb2213e528fe63a73cb63345
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090433-armed-frequent-d9dc@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 667c12782aaf8dd3cb2213e528fe63a73cb63345 Mon Sep 17 00:00:00 2001
From: "Yuhang.chen" <yhchen312@gmail.com>
Date: Wed, 29 Jul 2026 09:41:42 +0800
Subject: [PATCH] wifi: rtw89: pci: add .shutdown callback to stop rfkill
 polling on reboot

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

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 09c19a6b9058..889a94d7f534 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -6453,6 +6453,7 @@ enum rtw89_flags {
 	RTW89_FLAG_CHANGING_INTERFACE,
 	RTW89_FLAG_HW_RFKILL_STATE,
 	RTW89_FLAG_UNPLUGGED,
+	RTW89_FLAG_SHUTDOWN,
 
 	NUM_OF_RTW89_FLAGS,
 };
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index e381aacda667..c1be69a3c192 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -2004,7 +2004,8 @@ static void rtw89_ops_rfkill_poll(struct ieee80211_hw *hw)
 	lockdep_assert_wiphy(hw->wiphy);
 
 	/* wl_disable GPIO get floating when entering LPS */
-	if (test_bit(RTW89_FLAG_RUNNING, rtwdev->flags))
+	if (test_bit(RTW89_FLAG_RUNNING, rtwdev->flags) ||
+	    test_bit(RTW89_FLAG_SHUTDOWN, rtwdev->flags))
 		return;
 
 	rtw89_core_rfkill_poll(rtwdev, false);
diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index c5b82fc46d06..8c3f4eb52cc5 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -4878,6 +4878,19 @@ void rtw89_pci_remove(struct pci_dev *pdev)
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
index 0e1557cedd20..cba52584ea68 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -1752,6 +1752,7 @@ struct pci_device_id;
 
 int rtw89_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id);
 void rtw89_pci_remove(struct pci_dev *pdev);
+void rtw89_pci_shutdown(struct pci_dev *pdev);
 void rtw89_pci_basic_cfg(struct rtw89_dev *rtwdev, bool resume);
 void rtw89_pci_ops_reset(struct rtw89_dev *rtwdev);
 int rtw89_pci_ltr_set(struct rtw89_dev *rtwdev, bool en);
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851be.c b/drivers/net/wireless/realtek/rtw89/rtw8851be.c
index 459d2e778b83..81c62296c32d 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851be.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851be.c
@@ -94,6 +94,7 @@ static struct pci_driver rtw89_8851be_driver = {
 	.id_table	= rtw89_8851be_id_table,
 	.probe		= rtw89_pci_probe,
 	.remove		= rtw89_pci_remove,
+	.shutdown	= rtw89_pci_shutdown,
 	.driver.pm	= &rtw89_pm_ops,
 	.err_handler    = &rtw89_pci_err_handler,
 };
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852ae.c b/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
index 142a45a2e718..3defb0748648 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
@@ -96,6 +96,7 @@ static struct pci_driver rtw89_8852ae_driver = {
 	.id_table	= rtw89_8852ae_id_table,
 	.probe		= rtw89_pci_probe,
 	.remove		= rtw89_pci_remove,
+	.shutdown	= rtw89_pci_shutdown,
 	.driver.pm	= &rtw89_pm_ops,
 	.err_handler    = &rtw89_pci_err_handler,
 };
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852be.c b/drivers/net/wireless/realtek/rtw89/rtw8852be.c
index 1c622a99c070..9b48e70c2b56 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852be.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852be.c
@@ -98,6 +98,7 @@ static struct pci_driver rtw89_8852be_driver = {
 	.id_table	= rtw89_8852be_id_table,
 	.probe		= rtw89_pci_probe,
 	.remove		= rtw89_pci_remove,
+	.shutdown	= rtw89_pci_shutdown,
 	.driver.pm	= &rtw89_pm_ops,
 	.err_handler    = &rtw89_pci_err_handler,
 };
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bte.c b/drivers/net/wireless/realtek/rtw89/rtw8852bte.c
index 73c7ebd33ab4..850ae9cbac18 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bte.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bte.c
@@ -100,6 +100,7 @@ static struct pci_driver rtw89_8852bte_driver = {
 	.id_table	= rtw89_8852bte_id_table,
 	.probe		= rtw89_pci_probe,
 	.remove		= rtw89_pci_remove,
+	.shutdown	= rtw89_pci_shutdown,
 	.driver.pm	= &rtw89_pm_ops,
 	.err_handler    = &rtw89_pci_err_handler,
 };
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852ce.c b/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
index bb5d5745aa62..daff152f66bc 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
@@ -123,6 +123,7 @@ static struct pci_driver rtw89_8852ce_driver = {
 	.id_table	= rtw89_8852ce_id_table,
 	.probe		= rtw89_pci_probe,
 	.remove		= rtw89_pci_remove,
+	.shutdown	= rtw89_pci_shutdown,
 	.driver.pm	= &rtw89_pm_ops,
 	.err_handler    = &rtw89_pci_err_handler,
 };
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922ae.c b/drivers/net/wireless/realtek/rtw89/rtw8922ae.c
index 8f3a1cd463d9..e82c866dfa36 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922ae.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922ae.c
@@ -113,6 +113,7 @@ static struct pci_driver rtw89_8922ae_driver = {
 	.id_table	= rtw89_8922ae_id_table,
 	.probe		= rtw89_pci_probe,
 	.remove		= rtw89_pci_remove,
+	.shutdown	= rtw89_pci_shutdown,
 	.driver.pm	= &rtw89_pm_ops_be,
 	.err_handler    = &rtw89_pci_err_handler,
 };
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922de.c b/drivers/net/wireless/realtek/rtw89/rtw8922de.c
index 09400a0efcfd..a71e41f28544 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922de.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922de.c
@@ -113,6 +113,7 @@ static struct pci_driver rtw89_8922de_driver = {
 	.id_table	= rtw89_8922de_id_table,
 	.probe		= rtw89_pci_probe,
 	.remove		= rtw89_pci_remove,
+	.shutdown	= rtw89_pci_shutdown,
 	.driver.pm	= &rtw89_pm_ops_be,
 	.err_handler    = &rtw89_pci_err_handler,
 };

