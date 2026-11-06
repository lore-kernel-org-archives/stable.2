Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.210
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793955431;
	b=b0G4nAxxiecYxkT8/BLOvzElgXCqCRP5qUlqWSgSrXd/2q9JzCrwFi2h/V61EVOKyuZx
	 JIH+HO0/AH4yYr3cFbiF2jjaq+KoB/+GzCKdIYEco47lHwYV2QxghJBeMJo0WIExpgVzH
	 1Y4AoibloZTwsfNBy/ps1LxLXBijjGBTrhuB57ywjKXplfwoySEZJkFy1JhgChyRC6uFZ
	 yKsoJvDntO7eNzLW2+y3Q9xFOcom54pn4HqODt0jUwPaK0WcdqLkgSPSe8qzADxNRMZBI
	 TNqlkYSQjIQZU2/c7CWDvvVsxSn5nJf6jjA0AK0KVyEO4Qqz9CK7ks1zwhPQXmpBQXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793955431;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uEDgoWpPDYrGMjWs1+sKQhmAR0GJCys8+3dlCw7BcnU=;
	b=KtvCfB737Isoe4t2t0AXRBt3p8NxSj7fpKspf0vpfiQFlYVUW8G++C3mDq3BeZJG3HbL
	 kqlrKetaTNumdmti7LYb+ZCqFiG9xo0WEr2/Btq6ufTFRjV+hZd+3j5LlymanoiHMreMw
	 ieZF0Mh46trb4ZxoI7lCPEqF7vcI0r3C5371zRrf4dFU3HCFoOD0kX/g39MF9MQexm+qW
	 Wl1zPpk/QT+hoPG+GGmQOxp4a23fevHKVxv0IbvCQ4mu12OQm38IlUeoVqYtO+oa1w7o1
	 PhU2cAxoIOoX4+I+svE1NTYWdpOz8pCGZ1yU1h8n/pVrRCeOLyJ1yl8/qocndcqzmiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foxmail.com;
	spf=pass smtp.mailfrom=foxmail.com;
	dkim=pass header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=INhjR+Bm;
	arc=none smtp.remote-ip=162.62.57.210
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFECA606A32D;
	Fri,  6 Nov 2026 08:57:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFECA606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=INhjR+Bm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1793955424;
	bh=uEDgoWpPDYrGMjWs1+sKQhmAR0GJCys8+3dlCw7BcnU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=INhjR+BmgTb5N19c61aPE7YkxRBzvtRTBEWmoMQFMKuZnisrZVgqoKACnYeTZCode
	 CZf1GcPM3rg0iKKVkndSyJNsZyUkX0kUTGbdMGjZj9f+jFlEPGGAnrxOpGFBty/rm/
	 kE/xa+TFugVlOIzuUSxvMARp3uEby8tMTZX7Q/0A=
Received: from localhost.localdomain ([107.173.101.132])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id E3B13271; Fri, 06 Nov 2026 16:56:59 +0800
X-QQ-mid: xmsmtpt1793955419t0yph4opv
Message-ID: <tencent_BB887B4DB8D2131AF5026893E0FE567D6D05@qq.com>
X-QQ-XMAILINFO: NnIX2CK8LSsJ+PVchsWyqFT3XBXG4OJi5KeUOwaKhov+0XNVCXqslTH62lDdP9
	 eZmkMK8SxI81xBWPoXasa5PWUJKvzJmAZ4BR4LqdB5EFMfFDie2dDpN97acrKaqAyPz9KAI7Jr+Z
	 N2Eal5XPrD65XaAZnThqZeQrRAiAeiW8jo083DH0BowNSp/usgKmTaRQKgCIe5OlhMHHAqUmYxIn
	 P2uGAOVXkXAG8AzRdBWyBIiC15WOfM3nekMeNBvBLVj/krt/2WlyROaE4o9cgr7FStwFEl9rvQ4r
	 JNpVkTVOEBMFAfGMnqD6igsI0d8gsZD+NJCpxDlQxJQrUIPdFki62PnV6zAr9n/4lYMEb5nZuQ6Z
	 bxNib1wVhvwyKG/lMrO2Gx7c4EXEZJHlPSs1gWyQEm3Nh6pORTeInEYoTiPvgAMH1J0Isz002Hdo
	 fx1K6wj8IWUvV/6fEiePKLatFQ2pf9N91Ej9bzoqe5DDNNRZerT+LrPCHmptodhJulZFhmwAxcx5
	 xJEtE6UCvyo6MhEPFh5h8PSczTV+yIzumRmeNBanaxycP2533IWnh0QVFKQSpgrsiAcNPDahu3K7
	 rRoxlzrGrQkmlKjtHHgFKZ5Fu2gUFdINaCjN0LAu0cq8p8yTmoKa3O65dEfXilpew0eoG+hWonMo
	 LuFiC/A56MTqLozWTbm9QH9IuBCzF0zSCDvql3hVTRKVCgUj1t1keyBBXKcQjPQqe2Yqp/PywoIP
	 a3glvH7K9FmtNONXPU10k445KHQWl/Uo+xFaDI4wut2EEo6lWy5yThxEXyBmEEJH0veU1e60ym3v
	 EGLvvXfICVFYNZxNXK76MF3WNyCqVpx774xqsLar14eJKT6qPLH+vZiem7IRTYcmeZCWCxj/Xc8U
	 W/JXcIlLgJo4xSLIQabjDFtaDiGarWgQEPpzMCaPYO0q/LEaXKmj5AVh3A1t4poYBy1+FWo5bKJz
	 Ni7EyGMcb0YsFpeHzLlLwV8APsPXisnmCSdGZENzSOffOfdLM4qeljycw4mGeRcRJbv6BE64dyti
	 iUTzGXdPmecjm8FSJFf27VLzUJSPhEN286A0KDF+br8UrijPx0I1sQUrHVPgOoOj7TgWY+cw==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: "Ziyou Wang (Lenovo)" <ziyou.dev@foxmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	"Ziyou Wang (Lenovo)" <ziyou.dev@foxmail.com>
Subject: [PATCH v2] PCI/DPC: Increase recovery timeout to 60 seconds
Date: Fri,  6 Nov 2026 16:56:55 +0800
X-OQ-MSGID: <20261106085655.1841186-1-ziyou.dev@foxmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261106082612.1840817-1-ziyou.dev@foxmail.com>
References: <20261106082612.1840817-1-ziyou.dev@foxmail.com>
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

Some NVMe devices need more than 5 seconds to recover after DPC
containment, but pci_dpc_recovered() waits only 4 seconds.  If the device
hasn't recovered by then, pciehp reports "device recovery failed" and
the device is re-enumerated.

Move PCIE_RESET_READY_POLL_MS definition from pci.c to pci.h so it can be
used in dpc.c.  Use PCIE_RESET_READY_POLL_MS (60 seconds) as the timeout
so pciehp waits as long as pci_dev_wait() does, which is sufficient for
all known devices.

Tested with INNOGRIT NVMe SSD [1dbe:5668] with ACS Fatal error
injection:

Upstream kernel (7.3.0-master+, 4s timeout):
  [123.018691] nvme: not ready 1023ms after DPC; waiting
  [124.106690] nvme: not ready 2047ms after DPC; waiting
  [125.642703] pciehp: Slot(64): Link Down
  [126.218696] AER: subordinate device reset failed
  [126.218700] AER: device recovery failed
  Device re-enumerated as nvme1

With this patch (60s timeout):
  [74.894811] nvme: not ready 1023ms after DPC; waiting
  [75.982813] nvme: not ready 2047ms after DPC; waiting
  [78.094810] nvme: ready 4095ms after DPC
  [78.094816] nvme: restart after slot reset
  [78.111620] AER: device recovery successful
  Device works normally

Fixes: a97396c6eb13 ("PCI: pciehp: Ignore Link Down/Up caused by DPC")
Cc: stable@vger.kernel.org
Signed-off-by: Ziyou Wang (Lenovo) <ziyou.dev@foxmail.com>
---
 drivers/pci/pci.c      |  1 -
 drivers/pci/pci.h      | 10 ++++++++++
 drivers/pci/pcie/dpc.c | 11 ++++++-----
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 8cc6a89130b5..08f08f25e597 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -80,7 +80,6 @@ struct pci_pme_device {
  * limit, but 60 sec ought to be enough for any device to become
  * responsive.
  */
-#define PCIE_RESET_READY_POLL_MS 60000 /* msec */
 
 static void pci_dev_d3_sleep(struct pci_dev *dev)
 {
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index ba3c3fddddc2..1e8ddcc013ff 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -61,6 +61,16 @@ struct pcie_tlp_log;
  */
 #define PCIE_RESET_CONFIG_WAIT_MS	100
 
+/*
+ * Time to wait for a device to become ready after a reset.
+ *
+ * Devices may extend the 1 sec period through Request Retry Status
+ * completions (PCIe r6.0 sec 2.3.1).  The spec does not provide an upper
+ * limit, but 60 sec ought to be enough for any device to become
+ * responsive.
+ */
+#define PCIE_RESET_READY_POLL_MS	60000	/* msec */
+
 /* Parameters for the waiting for link up routine */
 #define PCIE_LINK_WAIT_MAX_RETRIES	10
 #define PCIE_LINK_WAIT_SLEEP_MS		90
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 2b779bd1d861..df1c469fa24c 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -116,12 +116,13 @@ bool pci_dpc_recovered(struct pci_dev *pdev)
 		return false;
 
 	/*
-	 * Need a timeout in case DPC never completes due to failure of
-	 * dpc_wait_rp_inactive().  The spec doesn't mandate a time limit,
-	 * but reports indicate that DPC completes within 4 seconds.
+	 * Wait for DPC recovery completion.  Use PCIE_RESET_READY_POLL_MS
+	 * (60s) to match pci_dev_wait() timeout.  Some devices need >5 seconds
+	 * to recover after DPC containment.  The 4 second timeout is too short.
 	 */
-	wait_event_timeout(dpc_completed_waitqueue, dpc_completed(pdev),
-			   msecs_to_jiffies(4000));
+	wait_event_timeout(dpc_completed_waitqueue,
+			   dpc_completed(pdev),
+			   msecs_to_jiffies(PCIE_RESET_READY_POLL_MS));
 
 	return test_and_clear_bit(PCI_DPC_RECOVERED, &pdev->priv_flags);
 }
-- 
2.53.0

