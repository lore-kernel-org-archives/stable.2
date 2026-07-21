Received: from mail-wm2-f2.google.com (mail-wm2-f2.google.com [74.125.225.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C82335A39F
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 13:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784639767; cv=none; b=BH0pkw+KZFwzAexl5MmNMBXg1gRlJJJB+XQb+iFfU/yCrv7Qazm/YGAiyQKZBCN8wL3yBGXIpD8mfjF/0nNsfezoOjTOl6JnZGzZh9RWSwZ9XNdp1D2fQzt6Ely9Njp6WTtawTt2OzXV3UDRZ2RLSyt7pEWMELxCBBrWaS+XlX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784639767; c=relaxed/simple;
	bh=ShlZ5obsck/3HU07BN59h2dm0lLPILvV9svgtTgtavw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gb6hb3LGXShX+hRlT3z8IkPfWLU5xayYYJezoL8PmrRHPF/2ruNWGCXZS+zJcVNPZoAAyq15VQEJH/XxA6VGyw6v32CMGjHg0NwruE3+JRpiEaXBw2mRMdtUKvo88X58owkv+4SCHjzBLFkxOELhmGxcfIXa7PWTNyeV8CZPsMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UBKMs7P0; arc=none smtp.client-ip=74.125.225.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBKMs7P0"
Received: by mail-wm2-f2.google.com with SMTP id 5b1f17b1804b1-4926d058720so18725675e9.0
        for <stable@vger.kernel.org>; Tue, 21 Jul 2026 06:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784639764; x=1785244564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xYmx6dayCLYwlqwxf5du5VlxFHj5ZAoU7EJ7K2Lsb+c=;
        b=UBKMs7P0P+m/F31Vw7CO1T4pyGA28yb4aAB1RrPettYhH15QOxQwyiOrMYcS2jM91Z
         1DMsJYoBgfDgPI2kF+ADYPn9GgmC3mMPqphih89Atdd6aWLyNvBgyUDas1MKGbwFHgPe
         exRjeFFoD5Wh7l+nnIoQzyjQLIlGXOGXHL2HchSewrskPgBguswgLOydtQQ8yZ8afzc0
         3v+yd8x04xIe5vN/q5r1+VZdRgB4Y2cyWWLdluuJPEk637sh9QZsI9uEMfzvazEixXHV
         V6QoQwKukbL0Ynklfi5pCajHnt7/pIkvA8vw3afFV/sBAI7JqG/XrJQEUQcgaHDSGu5M
         U8yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784639764; x=1785244564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xYmx6dayCLYwlqwxf5du5VlxFHj5ZAoU7EJ7K2Lsb+c=;
        b=UsEI8YrOu4T/KJg7UN4IV/YhX6YS2mTJWiX3kz/AeyKhggHnBJ+UtdHxFmeIU739tD
         nw7TozGF+pizHqtTip3xGHqQrjNQCPp+qvk2gigGxV4g7SeKfmc0QaFxYAydR8H828pS
         Mhg0xFi5AM1STRkhKc+vSgMXCtPktdVtuFERDCzYCtbxY17t1M2OMvKqVTTvyc/WEVia
         Rv1+okCGl/rOGpZOWfH7CUkQcOsbEyhe++J/277nAbVESn78CK1I5wIbujYY0MqM6anQ
         4wHenCoa5RLEgx9soSYWNc7s5qpK0X4PstGyrjYMlKm2AbDLEOMkBofCCNg7+f1gsjRy
         0VrQ==
X-Forwarded-Encrypted: i=1; AHgh+RpMQVBSdG/iEow78OX2rP4+FHecrpyJ15DvMEpHxTeWjY07b27akP9Xa0b4y94VFi7xyZuKLpY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhqwqkXiN5036eQvMN9gnQRh/H25JfMy2lgsMpqfM/PWUFXoxV
	YWsSi37Ej5n40YozRIs4nD0uoArXbRHpl4JIpWZYYRDknxutD23WplNY
X-Gm-Gg: AfdE7cl83f1LLV5guZ/azfbytTVANbf6fqQN4jCvx5kAOVjkQvvwzkTkKFlHxljWqse
	vDvHB6Uf1M2in0HHUcWmnmHcpmDsDhL6+qcizr0m+w+u0s/wjvJWJfnvK2qhnIihLRo+7683gOc
	jF3x31yE7jknom4oCOf4fN8lKNSsyXoE0Il/EA7RNFdNPr5ReqQbHotWxO59X0BdknJceXp5r48
	mPsUnrQNWfLmdcdQ93UwdklY/uc/CYvxnlLvzkZ3bUg9VVWzI8G1rLuMb9hWYafMmlT18eDmtqB
	MlWouYcSnO3rMTBL7KH7yo8NstATsLPhYLZujsjb3hhJEr55mIJd0jQD1LM/DSiLmFNPgsqfM40
	KefQ7I/LKry3FvNgZro8mcPCRHzk/7wWcyg/X5k6FbUoWmv9F8FmR8eLblTPVPJ4ELuLmtgQi/W
	Rs94HacvYD
X-Received: by 2002:a05:600c:c097:b0:495:5a91:8027 with SMTP id 5b1f17b1804b1-4955a9182a8mr118618585e9.5.1784639760966;
        Tue, 21 Jul 2026 06:16:00 -0700 (PDT)
Received: from workstation.. ([182.180.105.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956547323bsm70923635e9.4.2026.07.21.06.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 06:16:00 -0700 (PDT)
From: Ali Tariq <alitariq45892@gmail.com>
To: Daire McNamara <daire.mcnamara@microchip.com>
Cc: Ali Tariq <alitariq45892@gmail.com>,
	stable@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Minda Chen <minda.chen@starfivetech.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Mason Huo <mason.huo@starfivetech.com>,
	linux-pci@vger.kernel.org (open list:PCI DRIVER FOR PLDA PCIE IP),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] PCI: plda: Fix resource leaks on error paths in plda_init_interrupts()
Date: Tue, 21 Jul 2026 18:15:22 +0500
Message-Id: <20260721131522.594267-1-alitariq45892@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260721130034.560632-1-alitariq45892@gmail.com>
References: <20260721130034.560632-1-alitariq45892@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

plda_init_interrupts() initializes IRQ domains and creates IRQ mapping but
does not unwind them when later step fails.

If platform_get_irq() or either irq_create_mapping() fails
in plda_init_interrupts(), the domains are never deinitialized. If
irq_create_mapping() fails, port->intx_irq stays initialized.

Add shared error handling labels for error paths to deinitialize IRQ
mappings and IRQ domains.

This issue was found by automated review of sashiko-bot

Fixes: 4602c370bdf6 ("PCI: microchip: Move IRQ functions to pcie-plda-host.c")
Fixes: 76c911396807 ("PCI: plda: Add host init/deinit and map bus functions")
Link: https://lore.kernel.org/linux-pci/20260718120701.DF4111F000E9@smtp.kernel.org/
Signed-off-by: Ali Tariq <alitariq45892@gmail.com>
Cc: stable@vger.kernel.org
---
Changes in v2:
- Added PCI subsystem prefix to the subject line, no functional change.
---
 drivers/pci/controller/plda/pcie-plda-host.c | 30 +++++++++++++++-----
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/plda/pcie-plda-host.c b/drivers/pci/controller/plda/pcie-plda-host.c
index cda8fdb088fd..a2d7079aec73 100644
--- a/drivers/pci/controller/plda/pcie-plda-host.c
+++ b/drivers/pci/controller/plda/pcie-plda-host.c
@@ -419,6 +419,8 @@ static int plda_pcie_init_irq_domains(struct plda_pcie_rp *port)
 	return plda_allocate_msi_domains(port);
 }
 
+static void plda_pcie_irq_domain_deinit(struct plda_pcie_rp *pcie);
+
 int plda_init_interrupts(struct platform_device *pdev,
 			 struct plda_pcie_rp *port,
 			 const struct plda_event *event)
@@ -440,14 +442,17 @@ int plda_init_interrupts(struct platform_device *pdev,
 	}
 
 	port->irq = platform_get_irq(pdev, 0);
-	if (port->irq < 0)
-		return -ENODEV;
+	if (port->irq < 0) {
+		ret = -ENODEV;
+		goto err_irq_domain_deinit;
+	}
 
 	for_each_set_bit(i, &port->events_bitmap, port->num_events) {
 		event_irq = irq_create_mapping(port->event_domain, i);
 		if (!event_irq) {
 			dev_err(dev, "failed to map hwirq %d\n", i);
-			return -ENXIO;
+			ret = -ENXIO;
+			goto err_irq_domain_deinit;
 		}
 
 		if (event->request_event_irq)
@@ -459,7 +464,7 @@ int plda_init_interrupts(struct platform_device *pdev,
 
 		if (ret) {
 			dev_err(dev, "failed to request IRQ %d\n", event_irq);
-			return ret;
+			goto err_irq_domain_deinit;
 		}
 	}
 
@@ -467,7 +472,8 @@ int plda_init_interrupts(struct platform_device *pdev,
 					    event->intx_event);
 	if (!port->intx_irq) {
 		dev_err(dev, "failed to map INTx interrupt\n");
-		return -ENXIO;
+		ret = -ENXIO;
+		goto err_irq_domain_deinit;
 	}
 
 	/* Plug the INTx chained handler */
@@ -475,8 +481,11 @@ int plda_init_interrupts(struct platform_device *pdev,
 
 	port->msi_irq = irq_create_mapping(port->event_domain,
 					   event->msi_event);
-	if (!port->msi_irq)
-		return -ENXIO;
+	if (!port->msi_irq) {
+		dev_err(dev, "failed to map MSI interrupt\n");
+		ret = -ENXIO;
+		goto err_dispose_irq_mapping;
+	}
 
 	/* Plug the MSI chained handler */
 	irq_set_chained_handler_and_data(port->msi_irq, plda_handle_msi, port);
@@ -485,6 +494,13 @@ int plda_init_interrupts(struct platform_device *pdev,
 	irq_set_chained_handler_and_data(port->irq, plda_handle_event, port);
 
 	return 0;
+
+err_dispose_irq_mapping:
+	irq_dispose_mapping(port->intx_irq);
+err_irq_domain_deinit:
+	plda_pcie_irq_domain_deinit(port);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(plda_init_interrupts);
 
-- 
2.34.1

