Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A39C47253A
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 14:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785852317; cv=none; b=ekv+6q24Ob2PHr6K4ljBylG/+vXy1e6xpqhX0fPeL0jBMiGbHxTxFE3ObmLIInjfWjc5dkWQMDRVVqffhpKZAZUrZXEmgzWieAVK9yqhCa8g2MuIjU4SwUK+M6q5DsEXkOYUChtz5e5Fq2XH3vPDii0RB2oTTgevJS+3RTOXcfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785852317; c=relaxed/simple;
	bh=d97IpNyJsYB5IVGgs4Li0wWu0NiI/7JE9bvfPe1TDcA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dn1Gzfqr5S2olOmFxclWLy+O3KhLXk3IBVZfkoKj7KOgzbiSWyMfNniaxKNRKBOO4houVqbDHZlggGCnnh/vKwPzhUZToorM7af+RPNK2+KGEv7k77h4S1IwCq89BqL3WVC0fzZrmzDeZx2SVWRcFWTl7+8LriNJqSHJDkdsEE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jf6pF4kc; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jf6pF4kc"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8486ac3f347so1089913b3a.1
        for <stable@vger.kernel.org>; Tue, 04 Aug 2026 07:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785852315; x=1786457115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=di7yb5nKkAVEK5laxIrEVUkFWbaRV9fl/4mdiWB8KDc=;
        b=Jf6pF4kcmxr0Y2UHFL2AhprTlMLaAhkMwtvnILk4rIrrweAQHjrFL7Lsqj/r3nURLf
         VZkQ1Iork3a2NF3dbAI5Akv1JP7dM84al8nlW7KDEzqWDX4FjQZA2b+mlHyffGWrmhLe
         u/H8svpyUGKo9McqVG7fMszLBz3b0UQxZV5dWVfP0jPaCHE6Usl1R/Cbpo85WtJRUeYj
         smAiipjvDvfJok0sAUbKqAWvd6tT+AlE//5DpqLpufiSQV5HO5uwFcfE/Ac56XZjihP3
         yyfv+SF+W1CG3J+rbxqBixDM+xwWrDBklguy52pPK1c2v9G23OVxhrebTXCSI/wQBXoL
         b9iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785852315; x=1786457115;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=di7yb5nKkAVEK5laxIrEVUkFWbaRV9fl/4mdiWB8KDc=;
        b=d24Un8Q1Kjz0oedZjF2y68JOOvOdTJ0wtuK/VCtAh/A4MmVIh5jZGV5GnzNHMom4g+
         z2IqnYeF/srolNsGRlFAMn+DEnIgYOOHCMmWhW1GW5vql4/IJ/9k5aFrz0dDnXP0rB6O
         VIsgwQWuIG2JaIgnvUDjAb2JalLiy+WPkTESPkR0xhPLC7iN/8pqihYLP5pqxMi15min
         FAEgU5oQ0Y8TqvwLS9yhjMNmNozxrrnf00z+j1yPI2OKPW2BsPrZD0Fh+v7hQqr7fr0a
         7E5RnGueeSxAlu6wFy23qv3TkytmS3zll4d4GkAdGfvHwI2ortP62Qyf9fvuDd82oOdY
         DwAQ==
X-Forwarded-Encrypted: i=1; AHgh+RpVrW3v8TGTQeG0hzp6SmKxzGqnORGSeHGPkUyuvUW1h2Va5ZIrVsVldfTQZJL7lp90UN0yqMM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr6MTOxir9C7Lw40syBm92sodD6b68wQw+rhBEVlGrIZXkZ0lP
	SHuNEagrpEUB9wIOqaHo6amV5iDNuiKgjRfOMfAoOGXascfzoOsOmy0=
X-Gm-Gg: AR+sD1189QRH0AAjVVDKxlG9vpFE4d+MCaVEsCVcHBThrMPkNbZwzDlkLRj6BcGhhx/
	mFFCvh7eyylyRtoJsxBoO1nEoJ8LTc6n9GwO8MbVnGheObX9Y1/Se4J97tV3Fm0gZW+Lovl0AUS
	TBs6gdVWZPS+rp28TdAF37mZpdmgMNhGcy7Qf5p0KV8P0Fn49MaYrKrjb9lhi7tbN2DC5vAnssO
	AR350uzcMroom/CiyoGfRXvabEQ+W2FBztbUUuW4sQFcpfF29Q3Ji5uHa8hV6GH0pbfsXAq7hjd
	vnw1GltoVi9Y74dyKtAmXZtEvxZEWNuE4w0/Cmc/bs2feXbwzA6FE1gQRib7zQPH0XtenXv5TO2
	pVAY122Qn1SKhkpyBKlS4tV3pokEBSKLB3NxSDSm5W4K6C9Y731qGYCz3YfP4sgnNHVg0M2vTLY
	xUj/oFLypreGcnqjla3+4tgRydd0vu2KcvjQE0ZgcTPFiINNRYUGQfr3BozBjxstvfqt9OuG/RZ
	OSPnz+cWLbB43mL+4p/siBlaklpOuMJ3JyI8CMuVFEpsNSfAR+QRyOLzF1zNTks1lMEQLEtQiFM
	zilEcPUvkCaIXXHNU8dLHNbk
X-Received: by 2002:a05:6a20:a11b:b0:3bf:ee42:192 with SMTP id adf61e73a8af0-3cb6c773de9mr3807571637.6.1785852315187;
        Tue, 04 Aug 2026 07:05:15 -0700 (PDT)
Received: from localhost.localdomain ([1.226.165.54])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe3963daa7sm5097183a12.5.2026.08.04.07.05.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 04 Aug 2026 07:05:14 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Felipe Balbi <felipe.balbi@linux.intel.com>,
	Raviteja Garimella <raviteja.garimella@broadcom.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] usb: gadget: snps_udc_plat: clean up PHY on probe deferral
Date: Tue,  4 Aug 2026 23:05:10 +0900
Message-ID: <20260804140510.37639-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the referenced extcon device has not registered yet,
extcon_get_edev_by_phandle() returns -EPROBE_DEFER after the driver has
initialized and powered on the PHY. The direct return bypasses the common
cleanup path and leaves both operations unbalanced.

Store the lookup error first and route deferred probing through exit_phy,
while retaining the existing behavior of suppressing the error message for
deferral.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: 1b9f35adb0ff ("usb: gadget: udc: Add Synopsys UDC Platform driver")
Cc: stable@vger.kernel.org
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/usb/gadget/udc/snps_udc_plat.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/udc/snps_udc_plat.c b/drivers/usb/gadget/udc/snps_udc_plat.c
index db842a6de643..0ee3ed185d9c 100644
--- a/drivers/usb/gadget/udc/snps_udc_plat.c
+++ b/drivers/usb/gadget/udc/snps_udc_plat.c
@@ -159,10 +159,9 @@ static int udc_plat_probe(struct platform_device *pdev)
 	if (of_property_present(dev->of_node, "extcon")) {
 		udc->edev = extcon_get_edev_by_phandle(dev, 0);
 		if (IS_ERR(udc->edev)) {
-			if (PTR_ERR(udc->edev) == -EPROBE_DEFER)
-				return -EPROBE_DEFER;
-			dev_err(dev, "Invalid or missing extcon\n");
 			ret = PTR_ERR(udc->edev);
+			if (ret != -EPROBE_DEFER)
+				dev_err(dev, "Invalid or missing extcon\n");
 			goto exit_phy;
 		}
 
-- 
2.47.1

