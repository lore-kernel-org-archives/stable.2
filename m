Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973611C5F39;
	Tue,  7 Jul 2026 02:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783390552; cv=none; b=rW1Uu6PZCgki9jjXF/VA6rN2BvQa8dP18owhmFQ07FlACkXvJLZ5+MqDYWf13BAqLEDYru329AMB3uaGB8dfZDPkscY1D14IyTlw5uP32zNYa5PrSt/PwCyjcV+atE4F/N0NmJRe+94PxGukBvB4/+KWGyg5o/CPxevrjLxEjX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783390552; c=relaxed/simple;
	bh=pV9BzhNdi7n+83ZVzOmqSjzZH1peo856Tx6CEPss22c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h2IREaOuDb03pJL1EfvbX/wNmZgc5JW8w4V108RFfLmjB5rm5PnvH1kQH9eScu8uwC1FEaRNoiSKPSAQqnUOvot3UIZG/4S0dIpyYzV0FymEuBgwS+lf2u7O7IjZOdEynZAQCBbiKgZvFLWGqbez8aK3KCqxC/4iz6PomCNAXnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=SIuk7UbI; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="SIuk7UbI"
Received: from localhost.localdomain (unknown [10.101.193.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id D60003FA36;
	Tue,  7 Jul 2026 02:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1783390548;
	bh=O3KtnSXzuYHcWhuLOK8fkMMD2v0nxTbelFrG5sqnf9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=SIuk7UbI+73FQPPatMAZLzfwhljI3ZTAR3ATE7dhyqtH9zJ8oGfRP3rZwGkP+SLO9
	 wSwObxlUq647r3tHFgrMDzIXLx3QlZTNRwmFoG9s8QihwuAoa9pFeQHRnE7IFFkpjS
	 9v0kd+hdaE6zDBPzF0TYUwy80V1D4mNd/F0OZJPMiYp9qt3wAFfxSb4kZb0+DvVIpE
	 avFkvT0pCn8h7H8gAYyZcsJq1HM4rVdHvpE1aZkv5JKiT/OfpCcSXohOSCgI0p8HOw
	 kSaIvnoQxyAWdYvGPgIeLvKAfw/YKUotNKAIGRnf2To7QAlNy3+YxfjGPulWfGa7LB
	 Q5T6QhkGzAQsVU+Ga/z/AwtoDkBoEC8Oznn27nd6RRMJQu5iHFI+Bm6Wgb2iu3OddH
	 ziU/pkJIKO/UMn1gRWg8bNIUcbPZMQAR3u7pfsorax71OzG2gSukhZx0PqlyPzN5/Y
	 dVvXkKI82KVtZx+2lgi93AEsIw8bR92Gs0BvP9Ff0SoqSAJW+LXCry8/KyCDu1ci40
	 WILxNyFXVAsFOIXjL5KLxk3FmnqNSEAWAbSgnbPcDAx3IIxGgAegHmsWkMM7BREwlZ
	 f9Op9v/XxWrLNFWcw4Ad8RMD3usRxzvAXvaVBIocd6remyEDrTDtcPqX6V7cLVfQjd
	 ylhoF6QzhSfL/cz7GHVsK2SM=
From: Max Lee <max.lee@canonical.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	acelan.kao@canonical.com,
	mani@kernel.org,
	helgaas@kernel.org,
	kaihengf@nvidia.com,
	victorshihgli@gmail.com,
	lukas@wunner.de,
	pandoh@google.com,
	Max Lee <max.lee@canonical.com>,
	stable@vger.kernel.org
Subject: [PATCH v4] PCI: Disable ASPM L0s for Realtek RTS525A
Date: Tue,  7 Jul 2026 10:15:27 +0800
Message-ID: <20260707021527.639611-1-max.lee@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610024723.188514-1-max.lee@canonical.com>
References: <20260610024723.188514-1-max.lee@canonical.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Realtek RTS525A PCIe card reader reports an AER Correctable Replay
Timer Timeout storm when ASPM L0s is enabled on its link.  On an affected
HP ZBook Power 16 inch G11, the Root Port received tens of millions of
AER interrupts from the RTS525A even when the rtsx_pci driver was
blacklisted and the endpoint was not enabled by a driver.

For example:

  pcieport 0000:00:1c.6: AER: Multiple Correctable error message received from 0000:58:00.0
  rtsx_pci 0000:58:00.0: PCIe Bus Error: severity=Correctable, type=Data Link Layer, (Transmitter ID)
  rtsx_pci 0000:58:00.0:   device [10ec:525a] error status/mask=00001000/00006000
  rtsx_pci 0000:58:00.0:    [12] Timeout
  pcieport 0000:00:1c.6: AER: Correctable error message received from 0000:58:00.0

Testing with OS-native AER control showed that disabling only L0s on the
RTS525A link stops new AER interrupt and counter growth while leaving L1
enabled.  Disabling L1, L1 substates, or Clock PM alone did not stop the
storm.

Prevent the broken L0s configuration by removing L0s from the RTS525A
advertised ASPM capability.  This avoids enabling the non-working ASPM
state instead of masking the resulting AER Replay Timer Timeout reports.

Reviewed-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Max Lee <max.lee@canonical.com>
---
Changes in v4:
  - Add an AER log snippet to make the quirk easier to find.
  - Reword the RTS525A comment to describe this as a Replay Timer Timeout storm.
  - Add Reviewed-by tags from Lukas Wunner and Manivannan Sadhasivam.
  - Add Cc stable tag as suggested by Lukas Wunner.

 drivers/pci/quirks.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index caaed1a01dc0..ab94bd7f3a34 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2520,6 +2520,9 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x10f1, quirk_disable_aspm_l0s);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x10f4, quirk_disable_aspm_l0s);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x1508, quirk_disable_aspm_l0s);
 
+/* Realtek RTS525A generates a Replay Timer Timeout storm when L0s is enabled. */
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_REALTEK, 0x525a, quirk_disable_aspm_l0s);
+
 static void quirk_disable_aspm_l0s_l1(struct pci_dev *dev)
 {
 	pcie_aspm_remove_cap(dev,
-- 
2.43.0

