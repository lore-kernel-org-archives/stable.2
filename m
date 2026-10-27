Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793093043;
	b=QH6QvqF9P4iG9E97sJg2ryo6d5y/g3oNidEIZPTO3FuaDGpHe4iqmn0iFbp6lEzGOS7D
	 BKU7KK6NesDTpTebleHKI0pxwfCMA7Bvij7viMx5fsdPXoDz5BCeqZrN7gjlUzwfMeLTH
	 ALruNaESuGNtDOVRjJjiw0qPITmgm88vtEIPUxx7GkXdmXO80zmiUhEE/J2wUj9jXkvhc
	 KjVGUq3PIe1mtFhlOvoW8QDQnQryQ0QC4G3XkUzzaCrHtak/ziV0UIfU8RCFfnzBMOnt+
	 iQcitU4LGFwToEPxryW+RX4n77R8G/mxEFTC9lJJTewYtsPq+gJbDkHNfzVLm2y0jPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793093043;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=WLkKoU5R3LHdPira5kz28Ro+cd4O9pFbGAyyb+5Mdx8=;
	b=jNDGuXqEGnei/a8ZEMfVb6fsRWl2wm7qNMkGfn+ZA2qbE58988Ymefo0h/7PntIR8v7I
	 jrIEbPv8JCtiK5PspAah/VaxsmFT30OJJgOtGO6hqJ677JhsqAiRdEmSGYVeCY9IprvxP
	 vOynDxu0qwa6ojQunlYD8maztvSAoYgq6b6WAzBdjpiTQfWocRJxNccZsyNcWI8eBhViQ
	 /v8bVRs+EVdh2izaMBLy1LmUjNgyKQFK6sG93Q3y0CJIR5Fp4SGUpKhl0nsSNDHsz7hZG
	 5RJsqf3NbnM/JJ5F/OqZiPh+XhCYqSoRSSEnQwBLMaW6BRW5LFNDy+9fcPTmwtMphvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b="Jk/gTw+A";
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C935606A31B;
	Tue, 27 Oct 2026 09:23:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C935606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=Jk/gTw+A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=Jk/gTw+AggaLGn34N0TM+Z3flUE5p1of/k7MgVKx54CMXvo0624mznfQlbo6YZ5CjDxy1nmAwZK56
	 JMeAquVV7wBg6luWM9PyRkVSZw6W1rbfxUX7Vl8h1b+WjBsBMftVRFOrWgyUr1BtpI2AttQ0DL6s5p
	 8TEzamIcu9jgTf6U=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee16ae06dad3db-32e69;
	Tue, 27 Oct 2026 17:23:57 +0800 (CST)
X-RM-TRANSID:2ee16ae06dad3db-32e69
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from FHA-W6400298 (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee46ae06dabdee-0e531;
	Tue, 27 Oct 2026 17:23:57 +0800 (CST)
X-RM-TRANSID:2ee46ae06dabdee-0e531
From: Tang Bin <tangbin@cmss.chinamobile.com>
To: gregkh@linuxfoundation.org
Cc: stern@rowland.harvard.edu,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tangbin@cmss.chinamobile.com,
	stable@vger.kernel.org
Subject: [PATCH v2] USB: ohci-spear: check clk_prepare_enable in probe
Date: Tue, 27 Oct 2026 17:23:54 +0800
Message-ID: <20261027092354.1761-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <2026102645-dinginess-vowed-0d5c@gregkh>
References: <2026102645-dinginess-vowed-0d5c@gregkh>
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

spear_ohci_hcd_drv_probe() ignored the return of
clk_prepare_enable(sohci_p->clk). On failure usb_add_hcd() runs unclocked
and the error path clk_disable_unprepare() would unbalance the count. Check
the return and bail to err_put_hcd on failure.

Fixes: 1cc6ac59ffaa ("USB: OHCI: make ohci-spear a separate driver")
Cc: stable@vger.kernel.org
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
Changes in v2:
- Added Cc: stable@vger.kernel.org as suggested by Greg KH.
- Found by code inspection comparing with ehci-spear.c (which already has this fix).
- Compile-tested only, no physical hardware available.

 drivers/usb/host/ohci-spear.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/ohci-spear.c b/drivers/usb/host/ohci-spear.c
index 5aeabb051..9d93b3f86 100644
--- a/drivers/usb/host/ohci-spear.c
+++ b/drivers/usb/host/ohci-spear.c
@@ -80,7 +80,9 @@ static int spear_ohci_hcd_drv_probe(struct platform_device *pdev)
 	sohci_p = to_spear_ohci(hcd);
 	sohci_p->clk = usbh_clk;
 
-	clk_prepare_enable(sohci_p->clk);
+	retval = clk_prepare_enable(sohci_p->clk);
+	if (retval)
+		goto err_put_hcd;
 
 	retval = usb_add_hcd(hcd, irq, 0);
 	if (retval == 0) {
-- 
2.52.0.windows.1



