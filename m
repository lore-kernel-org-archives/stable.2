Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82688226D05
	for <stable@vger.kernel.org>; Sun, 16 Aug 2026 18:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786904168; cv=none; b=A8v8uG+dcVzWjKcPj4dM7RHSHom0ylL/fLwJZhE369XpmmbTs7gWYQhFBVHctu5c1qjtb5dJ0o3lToOD4eYe28aMM96cxj2M00yTdH2ASubZ7V5VOKMk5Pc9EblTsNtv9B6La0vS+YxU8X5B5mpJoYX/tzm7GI1e1FZ3i9dSzBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786904168; c=relaxed/simple;
	bh=oW8WDtEKirvx0mPOlGeZsjJBr0GaF+eKT6gExnakevs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ta6VO0qEzvDRufHBiZIIy/LgV1oSVOtdwoSpS8Iw4zlXAGcprEXpfj7kI9qY/Oz6oXKqk2E2MngB3+u39RdfGR7ODkZdc3ZLjFMED2tM42hDeAZ4PdQK82OQxHz2K4pho6MAiyClDaJR9/qwhVHZ7Tfsx0P4bvil4nfRC8P6O+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GS0334FR; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GS0334FR"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-392af6bda98so238423a91.0
        for <stable@vger.kernel.org>; Sun, 16 Aug 2026 11:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786904166; x=1787508966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FFfDkrfxwy7hG8CK5T75q58k3ed4tHaImnic4A+OQwE=;
        b=GS0334FR/HauLMhp9YiFZWzxCQI0kCMtwlLhTxMSGuWFHttL8bsyfo9iZMqZYsWyp6
         Roh4rkFqHJEDzNwdhueH2/xHvnmj8CP2vWMxa9lUMI00SLS4HxjIlatE5RaSuoDkr6SN
         ITdML8ltI9PaG1S76RExdS/8zlY8yDjMzkQ626p8JfH1AcZ8/drxL3zacb0v57XdmvqL
         j5+uNjM08UvlLHgfpDXu6CCw7YT9QLlX6ToPGU63fqMc/1EK25JBJ/8cttNhJrU9+g05
         YvYanLyq7DlmgxWaOtQ3Z1f1sqXzXuenuAcfNHUdKTpeu1vw+kVSfCgKmyAivKV/Er1b
         YyVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786904166; x=1787508966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FFfDkrfxwy7hG8CK5T75q58k3ed4tHaImnic4A+OQwE=;
        b=EjwYShaeZEsxmuS0xRt5DuTIeSiG0T9OWe2cJRE3biVAtZ4ZzrGgg/vTF87QRy5wMu
         X+O2wuL/+QyLbiPf8up+w5irFoxgzUfJkatWBK2lnHCO7hpQy/uHLvsXStLxg/iaQZ3D
         gGtjzARr5qGxTZVJ4WPSAlGPfYy5SOCzhmH7tS7T3WMGVZLgaYS66iBOqUb0DjQowAu9
         rSViT3Q7FNtLoSQsE8/7F9eX8oK/fGWc9n8r2eXG6qsrGTErr3aHlv1gAaDVcy7bVLdr
         IydTAzxSrahdrwKDjDSPebJhAMHh3XIoMVxYMvO1gfG/VwonnirqwJDGNmlBWTL4BLKG
         AKCg==
X-Forwarded-Encrypted: i=1; AHgh+RozYFXvHxgIUCaiTTvwqoFVP2VY3xOF/0zLVx9tSsntaDfxJZraj3StfmttdWfQJha3BA4ruEM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs74aAmKi6D2Sn2oiQyjSNjEFRmK/BDIdXcjTkEs1VDvGLe/VW
	RIs+lJqUlU1KqarMpdWaNoBx0pOALuE7QfyFak+z+c1ziR1lma5YNBRQ
X-Gm-Gg: AR+sD13hXbmNonUYG6vs4IrAq/A8xiabn14wJooEaTpIknruZIabuiys4f5ssI58MPz
	ml9b0Ws1q86ZnI3hvG+JCf6D7rQQXp3fusZGPh9xU2dmSP66jX1ImzWv8JW7J0jkmOu8HeeAsw4
	G4K2rikGhcXWzGvsb1EPbjNr1k+d1bLw6wDc0g5CFYGfqrKw3hPbdIG605xOEnfLU6rZrL88kSR
	YjVgaO4GFgsiCDN38p7pkdtjeZfe06cjbNi6Sp5B82ZCuqCC7VJ28g4Ta58f3/lZZHaUhWrmsUT
	rozrh70b9L1qBucC4wahU+3uQ/92iSfRnI2rvJwPbyqiAkaL96rfpNToYHUuMELuPFV/32YUtVs
	wPoruP3zJTMC+nSUX65aCqc2x0KhoEKf2vW6ftfeXXdgbzI5/Qn4+B1Ro8+oozsPZ/MYuqjNvTZ
	1uI2KC9q1WCQLDCbmd5xKcZxkdLD5BCK3B+hRIwPJDrii/Ltxje48AqsDTMZOlbuIyjSoKE2cNF
	YhHiZcVzrErD0pu59V7i1+kcliqc9bWnAC+Jbzwj8UXZ7FkUNr2UwwefFXNy+qtVTJZp618oKfA
	NjEnLZjwXwYEVuGx
X-Received: by 2002:a17:90b:5444:b0:381:bcfb:e710 with SMTP id 98e67ed59e1d1-3933b8e2befmr14552562a91.3.1786904165699;
        Sun, 16 Aug 2026 11:16:05 -0700 (PDT)
Received: from localhost.localdomain (c-98-47-46-163.hsd1.ca.comcast.net. [98.47.46.163])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141387ed5b1sm55015503c88.8.2026.08.16.11.16.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 16 Aug 2026 11:16:05 -0700 (PDT)
From: Rishabh Jain <rishabh.jain1198@gmail.com>
To: Mathias Nyman <mathias.nyman@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mario Limonciello <superm1@kernel.org>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Rishabh Jain <rishabh.jain1198@gmail.com>
Subject: [PATCH v2] usb: pci-quirks: always assert xHCI OS ownership
Date: Sun, 16 Aug 2026 11:15:19 -0700
Message-ID: <20260816181519.88865-1-rishabh.jain1198@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <69fdc442-a4f2-42e0-80f6-6b35cbc207bf@kernel.org>
References: <69fdc442-a4f2-42e0-80f6-6b35cbc207bf@kernel.org>
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
read/write, and leave a debug breadcrumb when firmware owns the
controller. Keep the existing BIOS handoff recovery and legacy SMI
cleanup unchanged.

Fixes: 66d4eadd8d06 ("USB: xhci: BIOS handoff and HW initialization.")
Tested-by: Rishabh Jain <rishabh.jain1198@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Rishabh Jain <rishabh.jain1198@gmail.com>
---
Ah, agreed, I didn't see XHCI_HC_OS_OWNED is defined! The +3 in v1 was
for selecting byte 3 of USBLEGSUP.

I've simplified v2 to use the existing ownership masks, one initial
read/write (makes sense to batch the writes), and the debug breadcrumb
you suggested.

Changes in v2:
- Use XHCI_HC_OS_OWNED instead of byte-offset access.
- Fold the TI/Renesas forced handoff into the ownership-register write.
- Add a debug breadcrumb when BIOS ownership is initially set.
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

 drivers/usb/host/pci-quirks.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
index 0404489c2f6a..29e635a036a6 100644
--- a/drivers/usb/host/pci-quirks.c
+++ b/drivers/usb/host/pci-quirks.c
@@ -1185,31 +1185,31 @@ static void quirk_usb_handoff_xhci(struct pci_dev *pdev)
 		dev_warn(&pdev->dev, "xHCI controller failing to respond");
 		goto iounmap;
 	}
+
 	val = readl(base + ext_cap_offset);
+	if (val & XHCI_HC_BIOS_OWNED)
+		pci_dbg(pdev, "BIOS owns xHCI HC\n");
 
 	/* Auto handoff never worked for these devices. Force it and continue */
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
