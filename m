Received: from mail-pj2-f0.google.com (mail-pj2-f0.google.com [74.125.227.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9149A2DF701
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 14:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784816925; cv=none; b=kb4EWUOTSlhBlGzNWyHCvBeqhYBTb/MYEggrnUCELuDmyX9nyXgMnoj6uWRZZYK55gjtJBWeVmjZ9dl7zYNVcMVeahQl5cL1lJbiz4xnfSEOaC9f5XPpAfyBMevSNAka+VEtUfjSPNZ2JVWK99Koms1Yrs6XNg2MaxRMwMQMbx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784816925; c=relaxed/simple;
	bh=PKDwq+x+NOmYN7QbKKAajaz0VL8NafGdsM2UBpgp1e4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=luVguGX+IHMoweM9jC9VDBEi7umDMBWOc6TVs5TlUBHbIqppDRm4d1Pg1eohvZXcQkkp0CmAGYYWJvC3B+1vjG+H0HQqkaldqDo2M2Iso2kNEBp2X0vMXg6eP19VMi/c5HTetxfoMoI1w018cp1nWZ2b5YZgdf4dP8N9XRZW968=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kTJIVpIv; arc=none smtp.client-ip=74.125.227.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kTJIVpIv"
Received: by mail-pj2-f0.google.com with SMTP id d9443c01a7336-2cc7a345f51so5805355ad.0
        for <stable@vger.kernel.org>; Thu, 23 Jul 2026 07:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784816921; x=1785421721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=E0Yy60Buxa1oln1foYGDC/ST2/TxbKXJmmCBtwLn+QU=;
        b=kTJIVpIv866zsA4I3x5WsvdGFv7IlGsb7zzeCT+9TTOP4PrsCnOL+ITwJor53qXv20
         C5rX656QB99HuqttNDLTJqTcCn0gGeqITjxdQYPoQatFQ0q7RTe5AGh65CLESb7SjUfF
         Dpq2qvheLhVQDrQHg7gekJ41OeT/JAstb0fSXpjbj7qLjmw2BkmPCv5D94Bh0S0Y+phJ
         MaeEXBdTaqUlj9rLT0dVUwpJShQBEdbvQlcViFWF2V50ZysyGWAirXPrE9Jk5Yk/AZho
         FblyzW7DTEJYTEf1SCTMsn9BlAwK1VgF6N+YaqlnS4maqH1Lvr8F63TlcQKY3XVBBkvN
         xoAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784816921; x=1785421721;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E0Yy60Buxa1oln1foYGDC/ST2/TxbKXJmmCBtwLn+QU=;
        b=MYN16ZOkJLPVV8+YAZ2akuQ9tWSWmbtQeo8BMevndgyBOClSchKHH07czOS74e8AJc
         hXiSwHBlfkUNWDTbfUyn87WOduGVJJiGY4zKOtNCFJX9YVzNBfxK2RWDEimayscWBU/I
         pPwm+nqrsRS5+hQm6OLDtnnM4ymr5F66mL3X92zVQpVKaMBU3bGhg/xD2zu/iHPW5ENL
         uLtktkDADSOPhFzg0o+2Z09jLOeiiaV2p3AFc/uozcqj2z+2XhBmp5zSx4AUuO+mipu7
         wnqzA2Iep+bOdtmgL9E48Kam4XpxT+rAtnbx1N10DxEoaN/e2KuiGVmJKeBbIqYPgYbZ
         Rvcg==
X-Forwarded-Encrypted: i=1; AHgh+RpyGWMJHe1H/wAYmszvUKiRqGqBMgD3s38a3ka/XlvLLtja2fe1xJbbTQ4Mc1jp51WePz9eC5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPZWPnm34QuXEP0ruzKpUET2pJfbzaQJ3ZFXWcn7hUUGO2wddu
	pzpt/dq+hRFE/6VwtxogSRfwW4vl0zlA4fBoWGzXLmPuaZ36oJUHVMyF
X-Gm-Gg: AR+sD129N27aAApRWOdGmDu96NnEBHTOeKzXg7WQJBM/9jCqxZpqq5WR2RdPbHqka2e
	vc7VcZI0YYN+uibkEpJQtRpMux3yMVxVz22PfTweM4V3Qa/HJfWhiJs4uRIhBUEeuqIB6EGGGUq
	gV17iHm6CFIkH9EDBwK7j/laJo74UatBb3kN8UYmBJ45Sj5WaT26pUlrGgP0As0jVHK3ab12fqU
	mMZFJJejpp0qXJQ59Nl2zJ6XSOfv+Ch6Q6SLibaev+a6zwjv5Mf+VTf9Xlm4qfwzKBV2LGp3uoP
	4Ym+fpbIT84jjZVsX0mjwtkQtsZh/R8yCD0PQ9EDR622gAS9256+jvMSrGetQcUd6zeHbiSb+W6
	8BH5D4RMrzDpyBzU6lRurLdSQLoAj+8n2GqN3mH8azoU2jXarVomfBVR857Q3NX+y+9QXiSayaX
	ylQiRFndD0
X-Received: by 2002:a05:6a21:a394:b0:3b2:8685:118b with SMTP id adf61e73a8af0-3c44aff1d71mr3653312637.20.1784816921359;
        Thu, 23 Jul 2026 07:28:41 -0700 (PDT)
Received: from workstation.. ([182.180.105.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147dc9f2f0sm21575371eec.13.2026.07.23.07.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 07:28:41 -0700 (PDT)
From: Ali Tariq <alitariq45892@gmail.com>
To: daire.mcnamara@microchip.com
Cc: lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	minda.chen@starfivetech.com,
	conor.dooley@microchip.com,
	mason.huo@starfivetech.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	alitariq45892@gmail.com
Subject: [PATCH v3 2/2] PCI: plda: Fix resource leaks on error paths in plda_init_interrupts()
Date: Thu, 23 Jul 2026 19:28:24 +0500
Message-Id: <20260723142824.726655-1-alitariq45892@gmail.com>
X-Mailer: git-send-email 2.34.1
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

plda_pcie_irq_domain_deinit() now disposes of the intx_irq and msi_irq
mappings itself before removing their domains, so the msi_irq mapping
failure path can go directly to err_irq_domain_deinit instead of
disposing of port->intx_irq separately first. This removes the need
for the err_dispose_irq_mapping label used in earlier versions of this
patch.

This issue was found by automated review of sashiko-bot

Fixes: 4602c370bdf6 ("PCI: microchip: Move IRQ functions to pcie-plda-host.c")
Fixes: 76c911396807 ("PCI: plda: Add host init/deinit and map bus functions")
Link: https://lore.kernel.org/linux-pci/20260718120701.DF4111F000E9@smtp.kernel.org/
Signed-off-by: Ali Tariq <alitariq45892@gmail.com>
Cc: stable@vger.kernel.org
---
Changes in v3:
- plda_pcie_irq_domain_deinit() now disposes of intx_irq/msi_irq
  mappings itself (see patch 1/2 of this series), so drop the
  separate err_dispose_irq_mapping label and go straight to
  err_irq_domain_deinit on msi_irq mapping failure.
Changes in v2:
- Added PCI subsystem prefix to the subject line, no functional change.
Link to v2: https://lore.kernel.org/linux-pci/20260721131522.594267-1-alitariq45892@gmail.com/
Link to v1: https://lore.kernel.org/linux-pci/20260721130034.560632-1-alitariq45892@gmail.com/
---
 drivers/pci/controller/plda/pcie-plda-host.c | 28 +++++++++++++++-----
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/plda/pcie-plda-host.c b/drivers/pci/controller/plda/pcie-plda-host.c
index 791f5c1cce06..fd1a11b4c8eb 100644
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
+		goto err_irq_domain_deinit;
+	}
 
 	/* Plug the MSI chained handler */
 	irq_set_chained_handler_and_data(port->msi_irq, plda_handle_msi, port);
@@ -485,6 +494,11 @@ int plda_init_interrupts(struct platform_device *pdev,
 	irq_set_chained_handler_and_data(port->irq, plda_handle_event, port);
 
 	return 0;
+
+err_irq_domain_deinit:
+	plda_pcie_irq_domain_deinit(port);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(plda_init_interrupts);
 
-- 
2.34.1

