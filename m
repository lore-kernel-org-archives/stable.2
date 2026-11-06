Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.210
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793953621;
	b=uoDSwytgZQ/AO76kV/YvEBAHsHulxxN+oZesYtGgjJRDo3hesQaq6YlWcU20Qr/d2Uu/
	 aeC9Hxq+krAp/t5ApITbiwUFsB69iptyZkC179EXs5PcZ6m9w7uTtocHeMpzCcbueCsyP
	 UPVqaYvHDm1k8xQylrMadp3d+nguPfIUE3km9XAKMhADkpMbyjr97ZOTBdzX4GuEBkftV
	 WHzXFtbEf/q3cHxiohjNPGp+/jyAzoUuGW5XSXVtCLHjRLDGG9RzS8Gpm92xwmDBemthI
	 K6Cf2hyzPF9G4Yy3uyft3YzBZ+NDWsS7HmSM4C0dD5fYeQK20EVXx5tGDmkpDBuqr2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793953621;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=wz9hYkqc++0EzNl2y+NbUtn+iv7qQMZY9Esdr24qlaw=;
	b=I2hrO/kgb4v8kxG6G2gWYkMxijg1PxvRwIzwiQ2Iex/cG0LYE19K5uMp+dCb56oa8T8x
	 eFN5mD6EBsXALnmprVvHoYfRWbie8QYXkecWbg1+/cz3PN8iXtkK3Q1/cXzf97iAbCly5
	 WcDQh2P8bndGAvt+rTJLMcU549OWxK02g0iabAulkLbNzuZOJGsS1KqwH2Aev5sQMetSy
	 9maNEy+mRB54yJeuibRgXBVaIBThIcpv+FmEsd3Y+3RVPvy4ykkxjmyuAE56YI3rTCGP0
	 0TDFe9dMMsOcTnuYJaT9GH0/YX6/uehHHfqP6UVzZxFPWhmrLpFpj5VGIdPSaSib0Zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foxmail.com;
	spf=pass smtp.mailfrom=foxmail.com;
	dkim=pass header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=ZbNky3wT;
	arc=none smtp.remote-ip=162.62.57.210
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706BD606D817;
	Fri,  6 Nov 2026 08:26:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 706BD606D817
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=ZbNky3wT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1793953614;
	bh=wz9hYkqc++0EzNl2y+NbUtn+iv7qQMZY9Esdr24qlaw=;
	h=From:To:Cc:Subject:Date;
	b=ZbNky3wTfd3zHIDOkml82cpmYBdq6BwxX6TBzBA++RqAWuiGxUlCuidkzLtOPEdxT
	 XuznpDBaFSfdkuyg2mHacKngZ/Mg3UcSDaog3ahXw5FNjvsQPqVs1YOyTxp8jbc0P8
	 fr8clEowijTj40ZZohuSEjgI5GGMstALLgzY2OsM=
Received: from localhost.localdomain ([107.173.101.132])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id 6B12D6D0; Fri, 06 Nov 2026 16:26:49 +0800
X-QQ-mid: xmsmtpt1793953609tf1r742pr
Message-ID: <tencent_0EA784F33CA15095806009C26E9DD624B809@qq.com>
X-QQ-XMAILINFO: OIPiZ4jSkGWAjJc0fQxqa64HY1Agza7ljOPRmAaGtqhl+/5q2AtT8bR2xzYX5c
	 Wm8RLv3pjQrkmridK+WYa8kIroEYukpgfYNBTIuzTAqFHTvVJaP+SUIgoJj0n6S8e1VRn6n6luJ7
	 SkRc8MbL77lJT/wNweDYN787D+ADNo7mc5/hMRzRnIUOwW1x4PjsDOZVoWY9RPryPUMwQqDB77Oc
	 kfXgw6F882Umi2tGKA1Q5VdwuGr7XgXbLcXyGjAoY0sb/iLfowtdKaMalc4DcIZrYA0sVp8UZcaS
	 iV16UEgz6yUfH+d6vXKmX8Dl8RhQHcDD+Z01SrzEt+jo3YCrDEys38qEerXl/GkDpzY4p5eVMrFE
	 DzUWrHnYCzGybzmpOpzbBJRhQe1Zca/WT9FROCgDuVz6eyZUyqKmC4KNEv2eFMgOHROlxmbtiPwE
	 2l0qpYvstXtwcACJdySFzmqvftIdTqpj5AKfH7DxtJHn/DU3ujvC9hMkxz72h9VVmEzhWVw+nFSJ
	 fK+FLB0lTGBHGNQi5rv62NmOSxIhXmbOyhBMbrFJMwxi0g/9vI6JXTUGtEZWrRXU4w4Swnyc70PI
	 nG9KjibDk6yLcPiO6UFaIH95+0F9JOHO4LMBDSGpxvZQeNlSrbwgghuOCRm7BY83XvQCZ4cZyzWe
	 Qwb51x7wa7uQR/oHnDWGtJF39yxwwF6liI+I+DO/QEPC9eEab5u+FlJw2kps5jNKGIk9FC9+Xelg
	 qTf2Rz1P1syGI9NVrojVL/d1OJQVG1l/CbdIBSyLCiJwLH4xfeS2AN+KNgW9oCQaUVSmtnEOeacx
	 zlQ4OE/z2dtlPBoDS3FcVmfv7TVHTtY0r8JbgrGU/0iK8ywxxOvKEJZIuK/jP73xT4m9PsxrYsAl
	 LZoUfkTLNcSLsjFmQLUl0PscgfYQPn7R9UKlW7xu8+/VsTE6aEO/v1iK4+gKHR8d/DXCAK5nrZnp
	 Z+PPd8NPkgQzZw0wL23cfNzJtSqE6IR1G05kr0ZROlEi1iWEA/QnIfe/yNCJMBNvRFqHQ5J8dm6J
	 Ar7r3N57zUI+7ERhi8yRoc/otStm7XY7MgB3HHKQ==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: "Ziyou Wang (Lenovo)" <ziyou.dev@foxmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	"Ziyou Wang (Lenovo)" <ziyou.dev@foxmail.com>
Subject: [PATCH] PCI/DPC: Increase recovery timeout to 60 seconds
Date: Fri,  6 Nov 2026 16:26:12 +0800
X-OQ-MSGID: <20261106082612.1840817-1-ziyou.dev@foxmail.com>
X-Mailer: git-send-email 2.43.0
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

Use PCIE_RESET_READY_POLL_MS (60 seconds) as the timeout so pciehp
waits as long as pci_dev_wait() does, which is sufficient for all known
devices.

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
 drivers/pci/pcie/dpc.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

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

