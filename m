Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24C33630BF
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 21:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788210699; cv=none; b=LAOWvR7XAoNUVzTb/u5iepVa6ffycvAgV5KiAFro6pSb9AF1eXWtR+KPnAbB1k7BkSi+rgckvRAiLwuaU9zUYeP8n70s8nJ1biNyNcVA6LLEB/XGSNNpdJ5MDfwweLE94QNsW+ixK7IVTQ+Netz0UJ3t3n/EwgAa7Xj6JcfhOkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788210699; c=relaxed/simple;
	bh=Q63MR04sB+zNUYx0lqlqqCJa/F6jjRvfRvkJKfzV9mM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WVk3MX61hNjJUwViEcKrlgwNXWTAKbpGuVW7cz7YEBfzRQOGNvkWBB05U0tL5RQc5Xb0y9H8V3VP1BKjKB6rYRK+mowVPJVhjoiLefcdRpf7oMnNXhjgfastNrUBsin6Ya6RLNRYuFCWBnl880+Cos08ANEXll5K4jJbAXzay/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LKXvhqX3; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKXvhqX3"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cc1c9b7c1e4so673733a12.2
        for <stable@vger.kernel.org>; Mon, 31 Aug 2026 14:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788210697; x=1788815497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YvP8FNVlmhwGF7juXCoARc73UH3L7nBQG3sdAe9hHrY=;
        b=LKXvhqX3IXYGeorBmCqwq3TXqmSg91vEl75c6PzVa5Mh+7Q2sN48Kd9aof6BSjRBuE
         KIqAiElu9Y0/Bbyte/JwrQeMPYG+Z7a4DgLy12d7j8evDorTwXTIknTwLDGy/mqqIxa/
         V11W7/UjcqA2FbIz5MbvITDWUmTyRqYEq4NZe9wRQuyeAAplRa++1quh0Wfj0yVIBAwY
         X6cjLI8qcc2e+eJ5QASj5s5XEvMuCXIue3W8YiDYtO7IO42rt5C6VlDM0JmkfamCBOH8
         lhqCjuF+wT8bVUFxDLVVZht6mCZgWfwLOIrkNi7Fxoys3/WbbtVSul/brXw++e/hqr5O
         jMRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788210697; x=1788815497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YvP8FNVlmhwGF7juXCoARc73UH3L7nBQG3sdAe9hHrY=;
        b=qe3NPU8FmYOUWKajP/aN45BeIcRlAqEbCCQddPRmZ/rnMzpybgElTV0CnMcaf4b18p
         9lSjV1BjoNysUYlmAduLtUC+Ic1d69hVUa1Mf+17T5BN+z9iktXUp7+4pxXR6ewTUke4
         T3KoYzGQ8MBtaE4AE4TSsOyYbUk8PRnURuv4GQGpp6w0sUpdLFo01j+xZeCpmCqqYjxc
         iZbEpkuNogSn0TBw91TRgvnq5OMLri90fOj/FyuMu7oFtZFvalXFYtnz6cEqGrtRKgVV
         RfObIYEe/4CTSM6ifa8PQc5wsbApPOBO9eyqXYLGgTl+/CiBZe+mIMiu3YWk3Sxu7CyC
         Vn9g==
X-Forwarded-Encrypted: i=1; AKwUvByxCYLDBoJDGlxzaqbWuwglmfMcjEoHkJNm3f71CYq/4xJAYHnhCE06uHUCodv/HL+m7y1FmrQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kJZB0VR99DPdhJEs34DmiUGMDKSdRqPby2TlST2o1r7DlO/9p+
	fUBdSUISKx59+oedKqnMn33D7HLlyLPqO57kCnw9wh1Og1Er5/aSQUOj2Sex5/M/
X-Gm-Gg: AYBFou1fJ1wn7paZauNsSQZ6DQVmSeOZouKN2Blz3eb94gSkUO2XkUp4DN2zcKdxHNL
	QWIzswBcZjNJzZQ0PQWhvYmLlg/Dp/M+VJPpwhpiBE0zrfykH+8rHq0eL6EkAlLZb90/+v1OqsH
	cjqGl5StGrXuMamv8gcn4LoT5koE+dkryHrKbWexXSYX0PyaFTsp5ZIjlRUH0/A2b1DY457taAN
	I33BgxAmXkPprkv6UpI4rznjNmJSuR22LPbsneJ9HHV8O5AUEdQaKqenmrwNkUR5r2ML5HBlc2c
	BWZvwvuuDoZL5WrSsmVhPZ5/xNN5HZ18YuFDXZ+guR5P/1NlJUOZhy3zTL1fuOxtLth0Nz+18EP
	O2sKnKlHNYdy539kaCwk5/+v6rrsewRKPelW6HoMB4wYzgKPIJ8DE2W0m4o3qTdrLBDKJ5W7AH4
	fTOP3JMj/vgP01ksZPjL3cak3pks3OsTLFyj8CubZvUJcfXnzuA0PNRKrD4Lo6bXjY0LqX1hCtk
	346PwXGDiqrjhjBTrsqh2vLcHi4kBPzpAYkgMvX20Hs0CC5AM/09wICd7WAECMsireAmcu0DY7U
	+/H/M2/70UvL5p5k+NPw3EzFagGuqGBmNg+KmA4zRlq58clypiJKbIJv4+RFllzGmuJVwS813Cl
	VSvwA3hXk
X-Received: by 2002:a17:90b:442d:b0:396:d27c:8696 with SMTP id 98e67ed59e1d1-398babea308mr15440305a91.4.1788210697055;
        Mon, 31 Aug 2026 14:11:37 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa (c-98-47-46-163.hsd1.ca.comcast.net. [98.47.46.163])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e0df264csm52933419c88.14.2026.08.31.14.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 14:11:36 -0700 (PDT)
From: Rishabh Jain <rishabh.jain1198@gmail.com>
To: Mathias Nyman <mathias.nyman@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mario Limonciello <superm1@kernel.org>,
	Michal Pecio <michal.pecio@gmail.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Rishabh Jain <rishabh.jain1198@gmail.com>
Subject: [PATCH v3] usb: pci-quirks: always assert xHCI OS ownership
Date: Mon, 31 Aug 2026 14:11:26 -0700
Message-ID: <20260831211126.23745-1-rishabh.jain1198@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2026083129-justice-egomaniac-01cd@gregkh>
References: <2026083129-justice-egomaniac-01cd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The xHCI ownership protocol requires the OS driver to assert the HC OS
Owned semaphore before using the host controller, then wait for HC BIOS
Owned to clear if firmware owns it.

quirk_usb_handoff_xhci() currently asserts OS Owned only when BIOS Owned
is already set. If firmware leaves BIOS Owned clear, Linux uses the xHC
while both ownership semaphores remain clear.

On an AMD PROM21 xHCI controller (1022:43fc), this caused every S3
resume to terminate Controller Restore State with USBSTS 0x401. Linux
then reset the host controller, both root hubs and the USB Bluetooth
adapter.

The controller entered resume ready and halted with USBSTS 0x1.
Endpoint state, 100 ms save/restore delays, scratchpads, the DCBAA,
device contexts and command, event and transfer rings were verified not
to cause the restore error.

Asserting only HC OS Owned changed USBLEGSUP from 0x00000801 to
0x01000801 and eliminated the restore failure across four S3 cycles,
including a stock-kernel test. Clearing USBLEGCTLSTS was independently
verified to be unnecessary.

Always assert OS Owned when the xHCI Legacy Support capability is
present. Use the existing ownership masks with a single initial register
read/write. Keep the existing BIOS handoff recovery and legacy SMI
cleanup unchanged.

Fixes: 66d4eadd8d06 ("USB: xhci: BIOS handoff and HW initialization.")
Cc: stable@vger.kernel.org
Signed-off-by: Rishabh Jain <rishabh.jain1198@gmail.com>
---
Changes in v3:
- Drop the unnecessary BIOS ownership debug message.
- Drop the redundant self Tested-by tag.

Changes in v2:
- Use XHCI_HC_OS_OWNED instead of byte-offset access.
- Fold the TI/Renesas forced handoff into the ownership-register write.
- Make the BIOS handoff wait unconditional and gate recovery on the initial
  BIOS ownership state.

Additional context:

* Kernel Bugzilla #216470 documents the same USBSTS 0x401/reinitialize
  behavior and its impact on attached USB devices:
  https://bugzilla.kernel.org/show_bug.cgi?id=216470

* Commit a7d57abcc8a5 ("xhci: workaround CSS timeout on AMD SNPS 3.0
  xHC") is related workaround history: it tolerates a distinct AMD CSS
  timeout and resets the controller on resume:
  https://github.com/torvalds/linux/commit/a7d57abcc8a5bdeb53bbf8e87558e8e0a2c2a29d

The external reports do not record their ownership semaphore values but
are included as corroborating failure signatures that this might fix.

 drivers/usb/host/pci-quirks.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
index 0404489c2f6a9..52d41ac5daa85 100644
--- a/drivers/usb/host/pci-quirks.c
+++ b/drivers/usb/host/pci-quirks.c
@@ -1191,25 +1191,22 @@ static void quirk_usb_handoff_xhci(struct pci_dev *pdev)
 	if ((pdev->vendor == PCI_VENDOR_ID_TI && pdev->device == 0x8241) ||
 			(pdev->vendor == PCI_VENDOR_ID_RENESAS
 			 && pdev->device == 0x0014)) {
-		val = (val | XHCI_HC_OS_OWNED) & ~XHCI_HC_BIOS_OWNED;
-		writel(val, base + ext_cap_offset);
+		val &= ~XHCI_HC_BIOS_OWNED;
 	}
 
-	/* If the BIOS owns the HC, signal that the OS wants it, and wait */
-	if (val & XHCI_HC_BIOS_OWNED) {
-		writel(val | XHCI_HC_OS_OWNED, base + ext_cap_offset);
+	val |= XHCI_HC_OS_OWNED;
+	writel(val, base + ext_cap_offset);
 
-		/* Wait for 1 second with 10 microsecond polling interval */
-		timeout = handshake(base + ext_cap_offset, XHCI_HC_BIOS_OWNED,
-				0, 1000000, 10);
+	/* Wait for 1 second with 10 microsecond polling interval */
+	timeout = handshake(base + ext_cap_offset, XHCI_HC_BIOS_OWNED,
+			    0, 1000000, 10);
 
-		/* Assume a buggy BIOS and take HC ownership anyway */
-		if (timeout) {
-			dev_warn(&pdev->dev,
-				 "xHCI BIOS handoff failed (BIOS bug ?) %08x\n",
-				 val);
-			writel(val & ~XHCI_HC_BIOS_OWNED, base + ext_cap_offset);
-		}
+	/* Assume a buggy BIOS and take HC ownership anyway */
+	if (timeout && (val & XHCI_HC_BIOS_OWNED)) {
+		dev_warn(&pdev->dev,
+			 "xHCI BIOS handoff failed (BIOS bug ?) %08x\n",
+			 val);
+		writel(val & ~XHCI_HC_BIOS_OWNED, base + ext_cap_offset);
 	}
 
 	val = readl(base + ext_cap_offset + XHCI_LEGACY_CONTROL_OFFSET);
-- 
2.50.1 (Apple Git-155)

