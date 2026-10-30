Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793389026;
	b=d/RpfngtxUcNRg9rbeMkmT2x/TLqsMy1EdRfFoZnn/zXVAc9lZpNP9+q8Fj3TDAxrkKS
	 JL+zxV/+hZyAF3kOPEr1Mw26KPiA2LXfgVdueEAuuvZhwS6Xo2dBMSVyeKM2vBMWvWiWm
	 TX4WuTV72QqpmQK16iDTfv9pVTGL8qHnkq86q4W05NoH7eoM36mfAbNvYn5ivRO99uVkK
	 ITsyBv2RyGKC0Z3bkEU31bVsHYebdouxAyFeooc2Ld1Z4iUOJUhWVC2PDLxjlB07+Q6FF
	 J2R7+GnT/HCx92GI2s0JTnQWR5cQCcSeRDcF+cV6bsN7qQvLVLiQh3HoCvEux4lsNBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793389026;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:To:Cc:Message-ID;
	bh=SAVZhtl45acG7pXv3O1589ijaVBP1M9mCVM0eytdgy4=;
	b=Y9u1DB8qtk1+JFEEAnaEbBXVhIRVUba94nonGIfj6HoUzMxtle64Op3ycULA4agTUqPr
	 acqL5P97R/igvTUrHZjQoIYzBJhrRcC+QYXcFwv2Nz+ZvmbdZpl7lOG1mj3UqL+AColx7
	 I6wGC9iUP+vEkQs5JUMK/lUbeuHR3HEV9OzWR9oTO4Ur4lrvG0Q6ef/6wGWjwlAT4wvep
	 wwky+JQksMCkJihyP9IFBgIWLWhIaXIW/Gpg6Nu0GS9h74wTYmVrE4/GUySKoWyfU6MVQ
	 UVXhO1L5q9hDcHl9q8ZWvw3iyt/WQ7ND0FXArhLTKMINHVPtvbiS8sRno2L1xZr9img==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FfURx7M7;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5F6606A31A
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 19:37:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF5F6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FfURx7M7
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-36a0eecf73fso215173eec.3
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 12:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793389025; x=1793993825; darn=vger.kernel.org;
        h=message-id:cc:to:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SAVZhtl45acG7pXv3O1589ijaVBP1M9mCVM0eytdgy4=;
        b=FfURx7M7snCJy3FJoVpaCRBNec3AB74pIgrzMYoUtGQFRvxSbEaKOLQcSwW1j4xI63
         JtLthT2zf3sJcdoNi/q38OC4ZcPlpJcwDTFG2xN/u5UDkRSs6mEAfD6XlLj2LvcGGff2
         a9/FGWfvVYvjs3qP6rT+Fk1ZqU8A0c+itVXh6gCCfMBnNWDqfKDP1SP3PI9iCHq9IEWj
         e4m+UVqZgFlipLMkAxwEmvSuSOfrHaiNBHP/I1PZoQxHukke5xpu2CP1rYimA0EuScF7
         hSMgZLjU7Y+4VzjGhI5gUuLXb6EtUIqCpAZP1qtR6SuVewLXsoNOFkdQ9bnMtqsDcdGp
         0Itw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793389025; x=1793993825;
        h=message-id:cc:to:subject:date:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SAVZhtl45acG7pXv3O1589ijaVBP1M9mCVM0eytdgy4=;
        b=HCfBmouv4rjuYc4KBXyNo03RfC+VvWSDaW1ijjrrIY08kYuHg3I64hXElVWdeCq5Zb
         lJ3JghoxiAyH7NoFyVgjsbBrM2kRIDroR4lZ9JHfFSsJvcQQ22SP7xxGdWcmuwzg/mlZ
         xYtsxlXzZEGw/XbK7se65ttjj7ZrRTBxoc0tWK4RpDMMajIHlXrvpxOaSOa6oggEAfog
         Yv/XfBFRU/Yeq2WDvKNoIjjK4ccgJH8PKnVEKgvn/ecZvozVziJY56BZgn0nS/pyMwO4
         cYY6zGNHfSpbfbUw41DE5uXz+hN4WRuS/Iz3MvcdgP+9v9XvePRx9R6RT4xIiz9fTTfF
         IsmQ==
X-Forwarded-Encrypted: i=1; AKwUvBwSYq7aOEfl05BDrAgpYRHjknyztUVmlch0qmMKl5wTeC0U0bci2naoWQR4k5dLaVeT07wZN2o=@vger.kernel.org
X-Gm-Message-State: AFq9FYJK6B/F2HGPPakbz5R+Gwe3b4dUszC/mmVfXI13pbPdmdDyv9HJ
	oxpvjy11WrtQS0vrgyiZsrbwtNBQl49/l6BpOuzI6xLmtlguSDolZ26/
X-Gm-Gg: AYBFou2VtbtrUw2V8IPjdOFpH0vK4Ywm4Nkuq4OxGzpqBS7/jht9JkuSGaRCvBk6sED
	Fc9Cl+2PLrhwVFv7mxaX+rvFocKJOmSOlZO0Eqk5IcoY0iCpFzJvanu1AdC0WQcSQC/FN/vXQi0
	W2gPrk/Q/DvLNf1NwQLBczilT8K7gxXln+Vk/BoSONjikD56/x7vfPJ/wm4sdbg9ZpC/QFKSwfh
	DdSG9Iim6YEpwenFAPTMEFFp35HIF1fGl66WADoW6TJdo5tMYq9tmpM0EKMfZ8bCoO3KVZLrfut
	0aqHReXJ18zkJgzI93Uf9H2hNFkFFqUdBODxyKojv/X8x/ZqWaY1gtbmKX4jK8aNjGQRXCJZlt6
	VIcQO10kzcdJVck0uITJXBtGtYD973/Xp2po/6TeUL6w5NRMrH3EEA2xQGLErDqOQYvMF6PMHlA
	2qSHV5JvqSTS5zsqSfT8gnFMVOcZ226ETQ6fI4dy4CWoFf4YRf8lMH83DWhEmp+ELPqoDVyhr29
	cZRpx1x/STcHDAx1w5pFN0lWnhCjwQUTWki9yl/QNq8gOsBfeq+kVTxY4HpM6MWsKSDas4a25Qv
	b7SxhBOgc+ierVuG4nju8chNNFwiiplr7JTRoh6F3+9QdbMExEzjW9UQnqAj0BRXEXZwe1I5rJQ
	PdnBi0XOwgNtj8fpM4EIvB0c3MuOTHkuKLwJbhohpngjJcWs0uEvfti2QhiQ=
X-Received: by 2002:a05:7022:c90:b0:127:def:dd72 with SMTP id a92af1059eb24-1ac5914348dmr5687886c88.2.1793389024873;
        Fri, 30 Oct 2026 12:37:04 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa (c-98-47-46-163.hsd1.ca.comcast.net. [98.47.46.163])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1a136537sm8425848c88.18.2026.10.30.12.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 12:37:04 -0700 (PDT)
From: Rishabh Jain <rishabh.jain1198@gmail.com>
Date: Fri, 30 Oct 2026 12:36:47 -0700
Subject: [PATCH v6] usb: pci-quirks: always assert xHCI OS ownership
To: Mathias Nyman <mathias.nyman@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
    Mario Limonciello <superm1@kernel.org>,
    Michal Pecio <michal.pecio@gmail.com>,
    McKenna Fan <blue_sun@tuta.io>,
    Quinn Schive <quinnschive@hotmail.com>,
    Bruno Filipe <bmilreu@gmail.com>,
    Maciej Zonski <me@zonni.pl>,
    linux-usb@vger.kernel.org,
    linux-kernel@vger.kernel.org,
    stable@vger.kernel.org,
    Rishabh Jain <rishabh.jain1198@gmail.com>
Message-ID: <179338900780.73175.16604680938007633313@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list

The xHCI ownership protocol requires the OS driver to assert the HC OS
Owned semaphore before using the host controller, then wait for HC BIOS
Owned to clear if firmware owns it.

quirk_usb_handoff_xhci() currently asserts OS Owned only when BIOS Owned
is already set. If firmware leaves BIOS Owned clear, Linux uses the xHC
while both ownership semaphores remain clear.

The timeout fallback also clears BIOS Owned using the original register
value, which can clear OS Owned at the same time.

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
using a test module that set the HC OS Owned semaphore. The same test
was repeated after review with the same result. Clearing USBLEGCTLSTS
was independently verified to be unnecessary.

Always assert OS Owned for controllers using the standard xHCI handoff,
and leave the existing TI/Renesas forced handoff unchanged. Keep OS
Owned asserted after the standard handoff, including when forcing BIOS
Owned clear after a timeout, to prevent firmware from reclaiming the
controller during subsequent suspends.

Fixes: 66d4eadd8d06 ("USB: xhci: BIOS handoff and HW initialization.")
Cc: stable@vger.kernel.org
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Tested-by: McKenna Fan <blue_sun@tuta.io>
Tested-by: Quinn Schive <quinnschive@hotmail.com>
Tested-by: Bruno Filipe <bmilreu@gmail.com>
Tested-by: Maciej Zonski <me@zonni.pl>
Signed-off-by: Rishabh Jain <rishabh.jain1198@gmail.com>
---
Sorry for threading the earlier revisions together.

Changes in v6:
- Rebase onto current Linus mainline; no code changes from v5.
- Collect the Reviewed-by and Tested-by tags.
- Send as a new thread.
- Move AI disclosure here following removal of the Assisted-by tag.

An LLM assisted with the investigation, patch, and submission text.

v5:
https://lore.kernel.org/r/178832755831.50581.1058201741431375556@gmail.com/

 drivers/usb/host/pci-quirks.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
index f670e7aab984..1dbfd697a582 100644
--- a/drivers/usb/host/pci-quirks.c
+++ b/drivers/usb/host/pci-quirks.c
@@ -1195,10 +1195,11 @@ static void quirk_usb_handoff_xhci(struct pci_dev *pdev)
 			 && pdev->device == 0x0014)) {
 		val = (val | XHCI_HC_OS_OWNED) & ~XHCI_HC_BIOS_OWNED;
 		writel(val, base + ext_cap_offset);
-	}
-
-	/* If the BIOS owns the HC, signal that the OS wants it, and wait */
-	if (val & XHCI_HC_BIOS_OWNED) {
+	} else {
+		/*
+		 * Perform the standard handoff and leave OS ownership set to
+		 * keep the BIOS at bay during subsequent suspends.
+		 */
 		writel(val | XHCI_HC_OS_OWNED, base + ext_cap_offset);
 
 		/* Wait for 1 second with 10 microsecond polling interval */
@@ -1210,7 +1211,9 @@ static void quirk_usb_handoff_xhci(struct pci_dev *pdev)
 			dev_warn(&pdev->dev,
 				 "xHCI BIOS handoff failed (BIOS bug ?) %08x\n",
 				 val);
-			writel(val & ~XHCI_HC_BIOS_OWNED, base + ext_cap_offset);
+			writel((val | XHCI_HC_OS_OWNED) &
+			       ~XHCI_HC_BIOS_OWNED,
+			       base + ext_cap_offset);
 		}
 	}
 

base-commit: abf8c33470f78e2226ee3dcdc69004660020ab47
-- 
2.50.1 (Apple Git-155)

