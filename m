Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795326575;
	b=HLzUv19OzmlmjwHzyKo6YEgsl79ywcsVQNT0Og3P57cHG6P89fbDWs5PwVOAL3fDPGNs
	 hZaPH+e+b5L4f6/A0bgpW2aRkJI+HgtYaCPI4NNJ2ZMIcbw3TIXj4t2vJ9raTQ6bL0cBc
	 NUd2wiNIwxEVSCBB8fmWZtDXG/LI/SXYkew+ixWg7vsGSifYOxjsxZrkZ96qO0nYRbJoo
	 jY8g5bv66VFvvhpX+xsGYuNgeZpgbTz8NAjYLAXOvtHklqVQhQtf+Fe81Rs2tRpVu7xL7
	 RhHVApO1igrBfOgoiXUJsS0zH74eMhaxUKufETWgdSI944Wdb3FjNVqg3ZicpgKM3DA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795326575;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WtlSXd84ql2VigrMlFs32DKgX7pCmPq/IHLXz0kYT/0=;
	b=tOLYilEBI1eUwE0L/IjcWumasW1HQhHXIiEh0xl7h/JCVL1ddzZQzmVU8pCVfWpqMVr4
	 ePeJXdhk4LT+JjKQDNgJC9x4eONHL7IyDYymWgql2OCZLUQQG4YiPU1rrs9TKPgizECRL
	 w3zEZGLOQClgJjYJBUb/kusdv+8d2CAL1VIPGbgW4PpFgsJukH2MeJtzzqvr17kKA8VlC
	 Fqf6rY0yhLcGzBKCe29+TE+lbysVO3Flynm3g1C3nh6qzpAjW0goLsDlHX3ddOZfcEk1X
	 GSh0dff+hyn6vRbqH9qRwdcjfwKxQd8YpsoCxR5rli5kPwVUwUI5ADGHw16kZHwHTtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xf4+Rhbg;
	arc=none smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265E7606A32A
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 05:49:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 265E7606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xf4+Rhbg
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cde827b7b95so155461a12.0
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 21:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795326574; x=1795931374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WtlSXd84ql2VigrMlFs32DKgX7pCmPq/IHLXz0kYT/0=;
        b=Xf4+RhbgxZWfRcLg7iy2ajKnaKqEpKD9OaJl9VpOQOUep+NhOcssyyU24bYltvfbnh
         q4Mj738M6d2uLCM8uX2oLBz3VKaa+jvU8A//6HV9/SAdI+osCpER4Pc6ENmcXvhz0X5V
         W9Kd547/kkLhwkg56Dr2fLqXVYuZSw96uzJ2cWUiUt0UgkQPHQvYcYSTKasmowC6nL0T
         ECGD7H65HuL9T36JasoUuMfFWyjySm2ERh7ovo84mqpzdXREgJ80eJg/YGjUoFARaZ4a
         i5x3MpcOwHrJ8qVcTaAKcVrU7shExwgrO4L+H2GPLkTNmGHZ5pS7Gss4l0O7ZyhYDed2
         8nzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795326574; x=1795931374;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WtlSXd84ql2VigrMlFs32DKgX7pCmPq/IHLXz0kYT/0=;
        b=HeHBbgKJsT9phbdrzxQpvCJmDJIK/Dg0OKc+25KtVbX1suTaZCl5Yp7gTQozMCHgkb
         iTZwpLlDtsPAWmzb52O+sbsJNMsv/gsGLVcp0fj9NSWwHV1D2/aRXYM7ublQkYv6JQZU
         EQb2Yii7RA0skFvLAKiYtkqScIg2jz3+EhDr8qtNW9h6BsL9A2F1OtFXSbkPfwMzezet
         jVsuToPDJ4h0LNxzY/pOrUOvTDy4DnUkTbU48vZaRt7PDcteRnRxlFTDe3OE4dXCeE3L
         xuXOyyjOzDsfaqU5zn6/lYN+aHn9Twx8THWeNagEL6RrQ6MBgkXIvOQsdbGfyah8MBUM
         Rtgg==
X-Forwarded-Encrypted: i=1; AL+hErGxLK5Qq7s+8ja3NTVHJ1zlyKdapLf7bn01DfRX4mNRZZN1KVCHwxM5ra9WbEmXh7IheGtmsHU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8fQ03CvZCCl2DKsvtrTNXffcloCr0vnf9TzsubpAcSsbnUqr3V
	DPnNzPm0UfAXKidzfUHEPAEoN5IKloccWVODsH1GFN9GQJC+2qTHegzK
X-Gm-Gg: AZFdTZcw8zN8MmaO0t2UtsjwPBnt2P5Xdl1aWUWbUypYPMn7Q8C9veCG+pznl3Lj/KY
	AMkgzYESP7WfPyFPwU3q+Ymvb+TwUa0yQ++husp6VECd1wwMj9/Jw/XOFRfC47/gbN/d7dXtiMb
	P5LHnCRa8qMyDFzo6jT92Oka86REEL2qCnYnvSeiPWFaJIHYQ5p5iN/FsxqFAjbw9+2FQsMuKUx
	D95o1lSy5e+BtSKeF+8zgXdELIvFh05YK5nthxuDcucnxpbFwzCmricFkPKIQs6hYAG4/s9METD
	HlEQsFHUlmN0NzyDXyomsnHQqdWASHM+g6MTudU3ZYf6tjjsOPbbB9YLtFlFTP++vQ8ZD7gUrCk
	zG0oEfZ4/OmAGtxZb/JliUNu6hT2w/Xl6KXDLlUWpjF5vHvaCJ3cYkSCK8EMeFUT271FOQQic//
	WyG7BM16lay8p8jEZaBMoeoMfk+iUSr5AXyyNuCoeoiYaQjU6RvE77RqmgPHZ6SkfWZ5KSd6cnA
	5P2NeMqhxFf35IYr9l7eRyoieEizgEFxiHvoMjYD+cWv3temMdjiCmyeehfbhtAn8dQsqsFcQeK
	bKLL3t8MXNLuwvW5or8rOPdUiwSKPr5IPu74SMO/CqfALw9EALo7ctTUcLgXKa7cD9bPwkB+vIU
	b9GHn6ygP/9h3PWT8IoyVgVHJFtQpE6H+UqhnIujB19Axp9dYZq2xfwVOBZTFyeWf0i83CTjqmu
	onTw==
X-Received: by 2002:a17:90b:3810:b0:3b1:bee2:223d with SMTP id 98e67ed59e1d1-3b41c9bc27emr7446448a91.53.1795326574357;
        Sat, 21 Nov 2026 21:49:34 -0800 (PST)
Received: from ryzen.lan ([2601:644:8000:37f::e34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41aab4729sm11150732a91.0.2026.11.21.21.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 21:49:32 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: Mathias Nyman <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] usb: xhci-pci: don't perform Soft Retry on the AMD X470 chipset host
Date: Sat, 21 Nov 2026 21:49:22 -0800
Message-ID: <20261122054922.50251-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.56.1
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

Commit a4a251f8c235 ("usb: xhci: do not perform Soft Retry for some xHCI
hosts") disabled Soft Retry on the 300 series Promontory hosts, which
fail to resume an endpoint after it. The X470 chipset host (1022:43d0)
has the same problem.

With an RT3070 USB Wi-Fi adapter (rt2800usb) on an X470 port, the
bulk IN endpoint sees one USB Transaction Error while the interface is
brought up. xhci soft-retries it with a Reset Endpoint command that
preserves the transfer state, the endpoint context reads back as
running, and no transfer completes on it again: the adapter receives
frames (its RX FIFO overflow counter climbs) but none reach the host.
Booting with xhci_hcd.quirks=0x10000000000 (XHCI_NO_SOFT_RETRY) lets
the URB complete with an error instead, rt2x00usb resubmits it and
reception keeps working.

Cc: stable@vger.kernel.org
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/usb/host/xhci-pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index e278db940a58..0a8b5b04e324 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -88,6 +88,7 @@
 #define PCI_DEVICE_ID_AMD_PROMONTORYA_3			0x43ba
 #define PCI_DEVICE_ID_AMD_PROMONTORYA_2			0x43bb
 #define PCI_DEVICE_ID_AMD_PROMONTORYA_1			0x43bc
+#define PCI_DEVICE_ID_AMD_X470_XHCI			0x43d0
 
 #define PCI_DEVICE_ID_ATI_NAVI10_7316_XHCI		0x7316
 
@@ -493,7 +494,8 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 
 	if (pdev->vendor == PCI_VENDOR_ID_AMD &&
 	    (pdev->device == PCI_DEVICE_ID_AMD_PROMONTORYA_2 ||
-	     pdev->device == PCI_DEVICE_ID_AMD_PROMONTORYA_4))
+	     pdev->device == PCI_DEVICE_ID_AMD_PROMONTORYA_4 ||
+	     pdev->device == PCI_DEVICE_ID_AMD_X470_XHCI))
 		xhci->quirks |= XHCI_NO_SOFT_RETRY;
 
 	if (pdev->vendor == PCI_VENDOR_ID_ZHAOXIN) {
-- 
2.56.1

