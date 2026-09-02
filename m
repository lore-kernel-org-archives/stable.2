Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1FF4315A
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 01:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788312259; cv=none; b=Z6DdyQZb95jv7m2XTRz3WgrDL48q7dyh0t/pURTWhMUSEnzN2VAhwrN61qQ2c0ffxpENvYqjJfWNUVTQekZgby387W6JN5sFTZVYerbmhrwH+XhPhHdMHfIPaFUsRqDydP678JG5deC4NDxdP5xPkPXHTzWaUEcDvOp/iOVA8j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788312259; c=relaxed/simple;
	bh=OE6zUP8LM9A08GqXAFXgldNPvFoJM+cZir5oxvqX3BY=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:Message-ID; b=fb8DMAoIQ0geheXr93q5/OOGDKmKfIPPXhJvHQ8sv4U6p8nAfskZtwJRvM0HJLydiM11MtohOr0+cnP4G3muJasUrWiuUURP+hGMzror5JASCuTnwuvu8t3aM3MaZGKSCKvBEGtxsw9h5hMrSYAI1UAS9SuB9b49tmMLvHl5KVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DsgzYn/w; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DsgzYn/w"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cc1c9b7c1e4so40814a12.2
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 18:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788312257; x=1788917057; darn=vger.kernel.org;
        h=message-id:cc:to:subject:date:from:references:in-reply-to:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=bM1Ama1SqfILo+ToLsEHyErile10Oj26qImjJshC1qs=;
        b=DsgzYn/wuefapijPc71p3n7AHTBmxfKBzVRr22kfXP1DoWuk69WPTMyZ4a8BUDo7S2
         X1Diuo5K1+Hrljreyn1iJJy1x0qARfG1eULyPxsflt0Li24+mkR9/0gLwHQElqJmHF+I
         ArW9X6o2nvM3RT0TT1dpCgg6JgTxACdmkC+O++72ryxzw7yVa2GJ8b/fvKXznjUFNJln
         IoyaozYUsBbeUV6jRyw6mWfZnqsfIhjHvxNaVFx3AS8oRiSTtpQ4iUIGQFKfrgBw6vkz
         5TJ2arB0y0kVrq9ZVEU7jXkcXlXR244XbrueApe+2BMqaUYkMr18tn0NynTD/CLR3zxi
         wEuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788312257; x=1788917057;
        h=message-id:cc:to:subject:date:from:references:in-reply-to:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bM1Ama1SqfILo+ToLsEHyErile10Oj26qImjJshC1qs=;
        b=HE9pNUQvdf73sazVUyjdLaTEub+njVJQFFdIdbfCeg3ZAOUAJdz6YSg1TkU6Dx+/zz
         INkRObs0Wn54C9MBsoiqqVZrInPPwyPlynbMwOcLNjcUwLnTx0Q2zOgjEM1nRtiMcmVg
         XeVNWUYE23BwAlNw/tVyMoVVjsWzG9zUIsrZN+V55oY3qYl/sPBJPNhcCuZXerw8GLWz
         MfK3tKt3E0BONf8sDwq0EsLKyvswdmd5aZ8h7OmVV/GKqEhXZ2UGieb9pZOUzvsEBUgR
         9t0xWMqdTxOsyD3xicMY3yLNSegeApzO+flDJOGO5Ivj1o3aB2lR77XrDciTvc+0EfJb
         RZgQ==
X-Forwarded-Encrypted: i=1; AKwUvBwCmAjM7Dr3pHmIVCjY6NqEHUtJ0mrIPAIefOnws+17IoZjNs7BMNo0iC/TfnONj6+nUekSL2o=@vger.kernel.org
X-Gm-Message-State: AFuF++lTdKmOq8Vx3BkEyi+3m1ZNQuZNS3KvG9DxBkBWWoYVaI8ZJDt3
	uddLNJxN9D+4EdqSvG/sBEAkRI0gQ7kZxsAk90mXhYPvGJwixKmC8xSO
X-Gm-Gg: AYBFou1izbdvfyKHdH89dwZHSABPWPwHfBXrAT/cZX38FP4v/N8KcIr1pjzQN2Ey6vI
	yZKrUu/gcNEOinRh62uf3WRwEe77ujdjg0+RMMFA2ZMhnXzFC+9WH0FtkMlT2Ki4ljsVYD8AN7g
	nHYDGozj5T/AO6wvCfarlBGvDFod5AUXfwLzPSZ5N6sEUk6Wxp48Ey6LbGpPtg7Xz/Trf67vZjt
	Nv3rxARqTjlO7G7ZfGNvP+6tpTmMnjGWBnR+qq5HS49FmNf5XrX1DXe047Ouqw/39z44PGL/DtQ
	DUndyu4Nz6neCWAO/GsgdWEqBwcoZ5TObRRr4hD4ElT3V5yxR183N6D/C6+4RAaOnGbK4H3SAqN
	/WSKmnQuaW4sKVewz/ERLI9xHOs81nbvYY60dDepctC6mWzlYwNxqeOXlzBzJLnrNg5pg3xic5F
	UyztuIYR9kDoiWUkg0xzd5767h/JGAX4lOBeNp9HBrHCGadQ4RJMzKPQdvArBfPc3PR5M4GPUmp
	swzYxk1TNM6c6vm8rqTp3jtL4UzKea3MXt/n5svFwWHjJwpFSpzSq3xRzh2GZ4l4vhN6fm4JoLa
	r8/T5YPdcOZBWi3KGmgz1ymPq1gCNOSa8L77jynzxS3CaEeYtdKFdT1aaWUS/q+kAhMdTZT3eOv
	4zpf4n+/f
X-Received: by 2002:a17:90b:5828:b0:390:af7c:fe5e with SMTP id 98e67ed59e1d1-39aedf2714amr1010525a91.2.1788312256977;
        Tue, 01 Sep 2026 18:24:16 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa (c-98-47-46-163.hsd1.ca.comcast.net. [98.47.46.163])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32f07b79898sm2053080eec.15.2026.09.01.18.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 18:24:16 -0700 (PDT)
In-Reply-To: <20260831211126.23745-1-rishabh.jain1198@gmail.com>
References: <20260831211126.23745-1-rishabh.jain1198@gmail.com>
From: Rishabh Jain <rishabh.jain1198@gmail.com>
Date: Tue, 01 Sep 2026 18:24:07 -0700
Subject: [PATCH v4] usb: pci-quirks: always assert xHCI OS ownership
To: Mathias Nyman <mathias.nyman@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
    Mario Limonciello <superm1@kernel.org>,
    Michal Pecio <michal.pecio@gmail.com>,
    linux-usb@vger.kernel.org,
    linux-kernel@vger.kernel.org,
    stable@vger.kernel.org,
    Rishabh Jain <rishabh.jain1198@gmail.com>
Message-ID: <178831224746.44206.8934470315568179153@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

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

Across four S3 cycles, asserting only HC OS Owned changed USBLEGSUP from
0x00000801 to 0x01000801 and eliminated the restore failure. Testing
included the unmodified 7.1.8-ogc1.1.fc44.x86_64 distribution kernel
using a test module that set the HC OS Owned semaphore. Clearing
USBLEGCTLSTS was independently verified to be unnecessary.

Always assert OS Owned for controllers using the standard xHCI handoff,
and leave the existing TI/Renesas forced handoff unchanged. Keep OS
Owned asserted after the standard handoff to prevent firmware from
reclaiming the controller during subsequent suspends.

Fixes: 66d4eadd8d06 ("USB: xhci: BIOS handoff and HW initialization.")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Rishabh Jain <rishabh.jain1198@gmail.com>
---
Thanks for the review.

By "stock-kernel test", I meant that the register change was tested on
the unmodified 7.1.8-ogc1.1.fc44.x86_64 distribution kernel using a test
module that set the HC OS Owned semaphore.

Sorry, I missed the AI assistant guidelines. Fixed now.

The TI/Renesas forced-handoff path is restored unchanged. This revision
only changes the standard handoff path. I left the byte-access change
out of this patch.

Changes in v4:
- Preserve the existing TI/Renesas forced-handoff path.
- Limit the ownership change to the standard handoff path.

 drivers/usb/host/pci-quirks.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
index 0404489c2f6a..fa9b5db4d115 100644
--- a/drivers/usb/host/pci-quirks.c
+++ b/drivers/usb/host/pci-quirks.c
@@ -1193,22 +1193,25 @@ static void quirk_usb_handoff_xhci(struct pci_dev *pdev)
 			 && pdev->device == 0x0014)) {
 		val = (val | XHCI_HC_OS_OWNED) & ~XHCI_HC_BIOS_OWNED;
 		writel(val, base + ext_cap_offset);
-	}
-
-	/* If the BIOS owns the HC, signal that the OS wants it, and wait */
-	if (val & XHCI_HC_BIOS_OWNED) {
-		writel(val | XHCI_HC_OS_OWNED, base + ext_cap_offset);
+	} else {
+		/*
+		 * Perform the standard handoff and leave OS ownership set to
+		 * keep the BIOS at bay during subsequent suspends.
+		 */
+		val |= XHCI_HC_OS_OWNED;
+		writel(val, base + ext_cap_offset);
 
 		/* Wait for 1 second with 10 microsecond polling interval */
 		timeout = handshake(base + ext_cap_offset, XHCI_HC_BIOS_OWNED,
-				0, 1000000, 10);
+				    0, 1000000, 10);
 
 		/* Assume a buggy BIOS and take HC ownership anyway */
 		if (timeout) {
 			dev_warn(&pdev->dev,
 				 "xHCI BIOS handoff failed (BIOS bug ?) %08x\n",
 				 val);
-			writel(val & ~XHCI_HC_BIOS_OWNED, base + ext_cap_offset);
+			writel(val & ~XHCI_HC_BIOS_OWNED,
+			       base + ext_cap_offset);
 		}
 	}
 
-- 
2.50.1 (Apple Git-155)

