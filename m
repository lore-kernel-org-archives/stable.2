Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C0238888C
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 05:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788327569; cv=none; b=GZt7N5IR0TMafj7TVrfLANe0DND/H/IADrMaHbc/c+yPn2SnJiIG3FBYntMuNm5ii2XzzuC56n08P8aZ4hfqv3SD1CwkQ2i4r4GdSS2LXME56omWtz6newtzBSSHCz+dRn/eU68b3ADEX6rSoLQHUOID+RUvCP9OoX02cnV2hFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788327569; c=relaxed/simple;
	bh=D2qpkwtyTf3w93woN4RfdqDyYYM4IpV1kr43tBMElaA=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:Message-ID; b=k9oChvSaG4XrLCtLkseDoMn+Q9dNGyPvRKXKYABZ3EL4BUwEfoVpyqykD43Posy8BblDs/6bkuMwVA2ImgXCuFYnzKg66LzHdCPdTJvur+NwH7v+Zl04LN8poiZQ05mko9MIpXmTVjafsbsCRU/JgKUR8aWE/VC6QrllqiKNzAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YIDi+tXW; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YIDi+tXW"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38f57e312ecso113571a91.1
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 22:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788327567; x=1788932367; darn=vger.kernel.org;
        h=message-id:cc:to:subject:date:from:references:in-reply-to:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=H3Gzfs+DJpEpqKw65mjqsmh8Qaprer5Io+JTzhX9dEA=;
        b=YIDi+tXWCmGM7DzM58ZNt9EVTpiKVquzQfLrL3PVJ9WEkowF0OTCZUP6mCalDTJBxO
         UxeLw6KsOvnuRRJf2kIZ7pZToLPTUF+TZRo1+qT0CUBjdtu1OHzLE8RKW3eWDCCMw4gM
         bXkDeSBR2zPMPtZxZti/BlnhOYmLO6WzZ30isEHWDMKgo4YK8rNTxtUvF40r11TpWPPN
         +I2V+ZTScPN8gQhzSjp7cmx7XIlfSx0owFxUzRk11ug+SdPSRUr5zOZ82ZH1uOXrICkD
         Ileue6r9XSS064TBJKDM2+bpbH61LwjFQCguSGkMZ7Z7WWRYfocZRX9Uf+itbKBLYyR+
         lghw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788327567; x=1788932367;
        h=message-id:cc:to:subject:date:from:references:in-reply-to:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H3Gzfs+DJpEpqKw65mjqsmh8Qaprer5Io+JTzhX9dEA=;
        b=FJp5bUUVY0QeeI5Xa7oOqGnoc/325nIKTHKbXCTf7+1umtdu2ksGSPc1jSZWtWl2B5
         lHF4c4aLqrneufah5bHZVq8C3EW00OvFVKsxs/q3nkbEe67nsdqQ0DXSsA8mUJ7TVIs3
         033jmahesrYE4DQzoi+Y9qJj1n/nhnIi3oJZbGDNMCS6x3NBveA1m5StDl/ZvJqS9F1P
         uUNCJH8sikEwE0IqrvddvVxzVLK6EoLDtEfDC0SVzUhGkS7s4mmNvuVe2UrK5uJB2gVC
         klPvhWNPeVomeKuk6dnQc7iRUWXpG/7axajOKjN+HbkH3vsXN4WlEpjfyiMGBhUMKHON
         2pAw==
X-Forwarded-Encrypted: i=1; AKwUvBzEEUCwAxeFCsz+1w4VlNxHcVn0Per5LDzkDTvpE76hgTsCasMsoNngpxcYJTuyeEjl2B2w9SU=@vger.kernel.org
X-Gm-Message-State: AFuF++mfk/x+4AwK5dlPj2AOIt/rHkW8ZmFztSzAdokhW9KibWq3wYM2
	pSLXbysPGW7iQijnGx6uM+gpHqwF34BZTSHgxWYfe1HEVFwt1kC//e5o
X-Gm-Gg: AYBFou0q4y1mtso3lL9XiEtSP8hSK+dhyE2gD7+CWqM7+9HSDjkKgKLiJR2YsOb12oC
	uMs3UFbD+xVvMZzurIGA/ycblDwt3m36NaU8e3BOlClmVvhG173em6VhIb+9tfqpvrTBmC7RsCt
	cF+M1Ox1bkkWRGrpekDejD67vU2m9Xo1MuSkwiE3TLbIH/4uAZig+lQqGwb2gTFRyylUqoQD0t9
	de5CtEYvvDBg6Xle1cwIHDT2j2G+qbC6n5WDUgSgaVo6f8N5BPSubyUosUFhUm4EETM4RIrhsI0
	28nYawmFyn5c1BGg/LvORe3K4Y2aUjohe1FRxWFQYBjh/cDvZRfrJURpymkR5quZ7eHjaOS5DzU
	W1iJx9YqfMsiilxNFkRi0ngJ1xPkebEJG4YcIRZKCPYa2P6Oy0SvpWouFfQfUgPL6wT05CxUA5V
	Md6klJ95itA5+n4NGZG5wWITgiVMsqt7vtPLjQ6TpojssPo1N2KKFGMUUtiYqt7rGaxKKJEAYGd
	x7EAU41ra7TrBDlOV+EMlfBFMB0AAUkY3hR8TKfXBVX0fhE1U3fjkhCArGVrZr9GF1MU6cMPBLa
	ALDkiQZ3cfNYyzU0tKPMFoGKObDjQktef2a5Xba9VbF17kJ7vuoXqbGdxRi8ni1Kvcev+qnyZw6
	8AI1ox5x/p0xzZNh+GQU=
X-Received: by 2002:a17:90b:4408:b0:396:63a8:699b with SMTP id 98e67ed59e1d1-39aedebbbacmr2123907a91.1.1788327566984;
        Tue, 01 Sep 2026 22:39:26 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa (c-98-47-46-163.hsd1.ca.comcast.net. [98.47.46.163])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1430e9eb4dasm5213580c88.2.2026.09.01.22.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 22:39:26 -0700 (PDT)
In-Reply-To: <20260902052631.75c6068b.michal.pecio@gmail.com>
References: <20260902052631.75c6068b.michal.pecio@gmail.com>
From: Rishabh Jain <rishabh.jain1198@gmail.com>
Date: Tue, 01 Sep 2026 22:39:18 -0700
Subject: [PATCH v5] usb: pci-quirks: always assert xHCI OS ownership
To: Mathias Nyman <mathias.nyman@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
    Mario Limonciello <superm1@kernel.org>,
    Michal Pecio <michal.pecio@gmail.com>,
    linux-usb@vger.kernel.org,
    linux-kernel@vger.kernel.org,
    stable@vger.kernel.org,
    Rishabh Jain <rishabh.jain1198@gmail.com>
Message-ID: <178832755831.50581.1058201741431375556@gmail.com>
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
Assisted-by: LLM
Signed-off-by: Rishabh Jain <rishabh.jain1198@gmail.com>
---
I kept val unchanged for the error log, restored the original handshake
formatting, and explicitly preserve OS Owned when forcing BIOS Owned
clear after a timeout. Documented timeout issue in commit message.

I repeated the same S3 test on the unmodified
7.1.8-ogc1.1.fc44.x86_64 distribution kernel using the test module, with
the same successful result.

Changes in v5:
- Preserve the original ownership value for error logging.
- Restore the original handshake formatting.
- Explicitly retain OS Owned in the timeout fallback.

 drivers/usb/host/pci-quirks.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
index 0404489c2f6a..2b12a35e6f10 100644
--- a/drivers/usb/host/pci-quirks.c
+++ b/drivers/usb/host/pci-quirks.c
@@ -1193,10 +1193,11 @@ static void quirk_usb_handoff_xhci(struct pci_dev *pdev)
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
@@ -1208,7 +1209,9 @@ static void quirk_usb_handoff_xhci(struct pci_dev *pdev)
 			dev_warn(&pdev->dev,
 				 "xHCI BIOS handoff failed (BIOS bug ?) %08x\n",
 				 val);
-			writel(val & ~XHCI_HC_BIOS_OWNED, base + ext_cap_offset);
+			writel((val | XHCI_HC_OS_OWNED) &
+			       ~XHCI_HC_BIOS_OWNED,
+			       base + ext_cap_offset);
 		}
 	}
 
-- 
2.50.1 (Apple Git-155)

