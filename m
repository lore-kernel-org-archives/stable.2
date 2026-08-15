Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91871D798E
	for <stable@vger.kernel.org>; Sat, 15 Aug 2026 01:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786758339; cv=none; b=SGpTHekoWWHwxEQ1s4EhfOsyZVoYSD1AWC4Zv2G5LaXaDGv1tSTi1wpqvlc2TIUqpenZzLEiCwJdv+mCUGrFnPfzVvn58vzCXzedIX1H4a3Cew+hnyN55JkdBqjZ4pIuiLaX1mNIb/3tyq785t51nw/BP/8pp9Zak4TH2WkEdKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786758339; c=relaxed/simple;
	bh=kr+DDiC7lwoKjoLKWh3UYa7mUtn9pf/hNo4vbGKht+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ok0zFDSRlRroUWbXsBup/GEosrLWD/gH4S75axfkQpN3OmVOyeyiVpMod8ufD3Vo2w+rLI0gm75kgM3GwxnHpqjmR+j2iS3gowIzHdVbSlqP659xdvI91JwSdelIqc1nVz6Jz0Ubf3o/s7LyeMKSkflxufPMlbjqcKli/HeQUVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=erjEL8J6; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="erjEL8J6"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ccdce28edeso2593535ad.0
        for <stable@vger.kernel.org>; Fri, 14 Aug 2026 18:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786758337; x=1787363137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2rUTBjQcy9ZWD15hkohvAODksdiIkTujMyPdVWOGcaE=;
        b=erjEL8J61hrVrmwq2Ld/qdYGrjDQGFOz6/ZJ7Lhcf6ji6cWQ/zDKzzvNfs3aDuEa/W
         FHH9Hwl8Ga0s3lFEW7dcGprJChfGxeWEgqfQw7lI62Y9Chl614ecNvtYrSHRk4Sgqxc8
         /QWPBRWTYQ54/Y0bQNkwPbbjITOF5mmfpxRcGRp3pTI3of3eXkB09ZlleKRSnDRqozGd
         p9y2Ov6Hq9kfbLnxVq4yJbPTiyA887vKbfidj1R55TR+OnaAA6kDlPSULcUEaivfSYB4
         OM/REwqwTuzjl3ALCplwqnbtJ2N2rQClxp0KFOZMANKeleGzYenw1p3hkSNnzBuIMlUL
         GTSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786758337; x=1787363137;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2rUTBjQcy9ZWD15hkohvAODksdiIkTujMyPdVWOGcaE=;
        b=hgPJcvVb9Wz8gs1HKRWX/rl0vePbR/5v1L6yNGdO7Uof/q+as1tQqDzZyCzXneOVer
         olj5uBh8QnMrgzXd97JoNaB3bojAwiyIpiKExm9xQYc7eDVD+PWKzqn1Kv2FnukoAdoc
         VAaqdcPvznm9fWkh6q3mPyyUVzC8yf9Gs+rgCKmj4oAe6CXghfiER/B2Poe9w/wSRDwe
         z01cxNsLIDQuvE5Ebo4BaGIp+mdEplpi39CTyb7xmKOYLTDywRJWC8YCU657P9MP8KHV
         LRCAcw5j0UV+/e8qBCU91vAJiOY9BLA3ks/nmrg0+eNtMQ7iLhHr2wayTU2qCxExeT3K
         t0AA==
X-Forwarded-Encrypted: i=1; AHgh+RrnfmVKeJJKWKB08zyoGKGf3R0XFNqww2cGlrsHruUV2seRi78cRxkL3+H+FChYyQufr3FI3T8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSrH92KzVvI5XyTTD1t0DUZb7h8wSJAIXyxUyCcu8sJnR0bw2V
	QtLMdEgcAi6MROYWv4vSpBYfbbCr7OY7eMrWpbuXnenu/tmg44qqNE+n
X-Gm-Gg: AR+sD10O6SKl62OutWkZqJS3Il/1BtdQaOGN55g7r/lMl46o9gLmONza2fLFCGQQwv6
	6PT+Ys9URjZaFhCm/88xu0LivbE+JwcqxGrCoOPh8DiEsvKMyAVpsa0+LTbOQVnDMKXJb0Q3OO6
	+uJhB3j2NRHMMwoOtWCxdY9WT8BeWUKkrg2NRNfSGxid2ABcSXpoP8M03X5qmEaE0ChATmueOqk
	h1SWD161J2udEPxMQ6ik6MlPmTSDiNypgS8o9GOqW4go9FrLBiUpQwJ5TKHzFPWBOYC/N4TNBvv
	Oo5GpSqrL0FuT4pTWxzB/AlE6zZZkPk9O59yxxwkYr/kM3KP21LVBxHbqm2HYDxkn13CJzC4O6r
	HHSz61+jd91fsvdqvCe+OeDLv5sAC0d/M0DbH8KsIsg/wgyy7gu4DshqGPRw7aCRkoVx/c5xKqk
	mZZYIHLqtC0PhfZn0IrvUus9bWF7H1/X+G3uWbfkzn5hp9TopIHV0UvNzn36I+/Xb5LLtFcjuAO
	IY4KlsCZ14/irY2+ZV8pxsZC2cCs87+SpxxIkqcxFJ8OhZBPqK142+L1e54VBYBVYn0lWg0bjnB
	vWm6qmvr/XnlGWMQ
X-Received: by 2002:a17:90b:1d44:b0:38f:57f0:1f51 with SMTP id 98e67ed59e1d1-3933b84ddd6mr7357225a91.0.1786758337093;
        Fri, 14 Aug 2026 18:45:37 -0700 (PDT)
Received: from localhost.localdomain (c-98-47-46-163.hsd1.ca.comcast.net. [98.47.46.163])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1413889d914sm14230840c88.13.2026.08.14.18.45.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 14 Aug 2026 18:45:36 -0700 (PDT)
From: Rishabh Jain <rishabh.jain1198@gmail.com>
To: Mathias Nyman <mathias.nyman@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mario Limonciello <superm1@kernel.org>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Rishabh Jain <rishabh.jain1198@gmail.com>
Subject: [PATCH] usb: pci-quirks: always assert xHCI OS ownership
Date: Fri, 14 Aug 2026 18:45:34 -0700
Message-ID: <20260815014534.77850-1-rishabh.jain1198@gmail.com>
X-Mailer: git-send-email 2.50.1
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
present. Use the independently accessible ownership byte so firmware
can update BIOS Owned without racing a 32-bit read-modify-write. Keep
the existing BIOS handoff wait and legacy SMI cleanup unchanged.

Fixes: 66d4eadd8d06 ("USB: xhci: BIOS handoff and HW initialization.")
Tested-by: Rishabh Jain <rishabh.jain1198@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Rishabh Jain <rishabh.jain1198@gmail.com>
---
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

drivers/usb/host/pci-quirks.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
index 0404489c2f6a..d76a4791b8f5 100644
--- a/drivers/usb/host/pci-quirks.c
+++ b/drivers/usb/host/pci-quirks.c
@@ -1185,6 +1185,14 @@ static void quirk_usb_handoff_xhci(struct pci_dev *pdev)
 		dev_warn(&pdev->dev, "xHCI controller failing to respond");
 		goto iounmap;
 	}
+
+	/*
+	 * The OS ownership semaphore must be asserted while the OS owns the
+	 * xHC, even if firmware did not assert the BIOS ownership semaphore.
+	 * Update only the OS ownership byte to avoid racing with firmware.
+	 */
+	writeb(readb(base + ext_cap_offset + 3) | BIT(0),
+	       base + ext_cap_offset + 3);
 	val = readl(base + ext_cap_offset);
 
 	/* Auto handoff never worked for these devices. Force it and continue */
@@ -1195,10 +1203,8 @@ static void quirk_usb_handoff_xhci(struct pci_dev *pdev)
 		writel(val, base + ext_cap_offset);
 	}
 
-	/* If the BIOS owns the HC, signal that the OS wants it, and wait */
+	/* If the BIOS owns the HC, wait for it to hand over control */
 	if (val & XHCI_HC_BIOS_OWNED) {
-		writel(val | XHCI_HC_OS_OWNED, base + ext_cap_offset);
-
 		/* Wait for 1 second with 10 microsecond polling interval */
 		timeout = handshake(base + ext_cap_offset, XHCI_HC_BIOS_OWNED,
 				0, 1000000, 10);
-- 
2.50.1 (Apple Git-155)
