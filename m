Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3B42882B7
	for <stable@vger.kernel.org>; Sat, 18 Jul 2026 11:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784375495; cv=none; b=g8hug+x2Iu5RMqdcIrv6Z3ons+dSazk/U+MMmDtMUZE8CWYCcIN1nTG2xZvHreTlnUW8eaWevHzN+9GItQUdfs+xPZmoepjQCzV6Q9jmX1latLvk619aC/ABx89NFEIUIxUrPMVKnbDoaB+j3CzxlAjAcqdbRDK9ZJ8JUNAHfXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784375495; c=relaxed/simple;
	bh=puskvRfJAlqS2JQQP5Fdxyq7utIPHjlRxpbqCYyxiNU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p/iq9LZwtPn9sDcr18Wx+/bjTw3NIwHG5D3X5me/K+r4bC1J6MNbOVm7dWNT/gcM6sJwz4u1dMs/WBRS9s5kvsG6q8aeVY4wInSM+yf0XtTOBM/g05bYdzTXORQo//L76+DqxdDXzMeit7x86O7mMCN0nZODVm+WG24oNitcWA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I40V3pyr; arc=none smtp.client-ip=74.125.225.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I40V3pyr"
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-47f6c54e841so155086f8f.0
        for <stable@vger.kernel.org>; Sat, 18 Jul 2026 04:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784375492; x=1784980292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=G/wgnKWNJl2PQ3MHBb+pT75nTWY+yYJVOgbAOO2hiXw=;
        b=I40V3pyrna5j2VApqP12vVUq3pjwE0Jo2eM8Rnge/vQw6fyy5YMpz/JU919kbibO9y
         SoQMu2qjLR9QEEPuDrwFI0Zi4+LS7w171vpi5utIFnThzwEmMgrlxW6gRyPxf1yt+W5L
         NiPkWDGB+CukQrcfK1EgO1VaYgSQ9bhxVTgu7tufAfqGTYq9d+N+nSn+oY1cNZUiY2N5
         fKKulnX43cCgzWG0zNTVqgAoP1RJOfe0dYTcwrLlibDsHb3WmKPSSn1OmkkgkkkEZPqz
         0S+gAg93nfTIhAdwhl1NF52MfU9Co0MMQHfGQKra1xwRfbjicWaV+kTDhMRq2/BsC3rl
         p6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784375492; x=1784980292;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G/wgnKWNJl2PQ3MHBb+pT75nTWY+yYJVOgbAOO2hiXw=;
        b=bTyGGtXY7fdSfZIo7vmCLSUb6p8KgyVrB6BoXIgSCJLUggLM24/FPhBM7yhBz2tOA6
         4UI9l24FBSO/cDs+T/XRTPrsJv9V6B04rb1pCl6hkSFP6HIcYk/JXldmjkGw5yQnUdLa
         HS2ff1f2SwG1V/rj7eUq3RPHc50agqlrMQD7N9/Hb71kjNFYwwZyVdXHT8Ng+gmwHVOc
         K5FFSdSkW0EyXmHBtJWQ1kgpcgmmb/vcnQJWnX+/Kw5OZoSJuCSP17nNQpyCHspt2kJf
         f88+7xsIcRDfuDf1gmiMLMMYAP58w+8Sdstlx8LB6nBF4qKkKvJ2hqziKjfXBtB/pHZj
         T7hA==
X-Forwarded-Encrypted: i=1; AHgh+RoBnP+7/VEPfSFcdDDzf1oipLlCzW0VR98ybE2OhFWuUFFyZFi+A0XwtCnVYET37Vpy5vvOXQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YycnXCLnH4iNv2jIsF4G6DkUW6nacvjg6o1kqEu7xTJ8gDJN3ao
	rFitm2tF4UTAZImDsZ8CRIHtiQQQxTOw377JGD8oQtO3OqHCaKfDIEH+
X-Gm-Gg: AfdE7ck+kKhIt0MhfniCVUr42S8tRfpWwA9fGHMDPVrXRmFqELGYkcFiUsR9fkQTuPJ
	qz1fOoS+UQpXLVFAQmXjJMkEsVAb0Z4qtg9hr+/rZ+PclGVX00cbgTc1p1TNTVzunKfuH53ZwcN
	2JdqUcmcgx04kklDaWLdXyE7oXKlahG6sTfDVQzIHh7sTzwQVzjZ2rglGPJRi5BEYsVfB3nvc6C
	ns7WyxKZBRCI2sStrVZoTmS2fbhJmoRynb1mZEccqPKS8hUQ9fhhS1PiJy9oyviSEFS7QUBNcbF
	+byDWdTwsq25qj0awDJQvU4WS4bp4iHTqXyg1tFYMNnoeAyFBgQ/1mWVVChx4hGQ3/NYT/a7SLo
	ztKgPvt9eh7aXwonawxnBKxD8eAK2Mxxie+BNHfpdBb9XhopSvake6Aqw0Phdyo+X4t4UcEiXs/
	3u132mTmJU9keUE1hqxK4=
X-Received: by 2002:a05:600c:3590:b0:490:e5c1:b8b9 with SMTP id 5b1f17b1804b1-4954a8e3616mr72865385e9.0.1784375491599;
        Sat, 18 Jul 2026 04:51:31 -0700 (PDT)
Received: from workstation.. ([202.163.123.30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-495499f3f99sm112545925e9.0.2026.07.18.04.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 04:51:31 -0700 (PDT)
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
	Mason Huo <mason.huo@starfivetech.com>,
	linux-pci@vger.kernel.org (open list:PCI DRIVER FOR PLDA PCIE IP),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] PCI: plda: Fix use-after-free of event IRQs during teardown
Date: Sat, 18 Jul 2026 16:50:22 +0500
Message-Id: <20260718115022.231990-1-alitariq45892@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

plda_pcie_irq_domain_deinit() removes pcie->event_domain via
irq_domain_remove(), but the per-event IRQs mapped from that domain
are requested with devm_request_irq() in plda_init_interrupts(). The
actual free_irq() for a devm-managed IRQ is deferred by devres until
after the calling probe()/remove() function returns.

This means irq_domain_remove() can free the domain's internal data
before the deferred free_irq() for IRQs still mapped into it has run.
When devres later processes that deferred cleanup, it can end up
dereferencing the already-freed domain.

Free each event IRQ explicitly with devm_free_irq() before removing
the domain. This triggers the free immediately and removes the IRQ
from the devres tracking list, so devres will not attempt to free it
a second time later.

This is a pre-existing issue, flagged by automated review during work
on an earlier, unrelated patch to this driver.

Build-tested and boot-tested on StarFive VisionFive v1.2A board

Fixes: 76c911396807 ("PCI: plda: Add host init/deinit and map bus functions")
Link: https://lore.kernel.org/linux-pci/20260714115343.4D49E1F000E9@smtp.kernel.org/
Signed-off-by: Ali Tariq <alitariq45892@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/pci/controller/plda/pcie-plda-host.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/controller/plda/pcie-plda-host.c b/drivers/pci/controller/plda/pcie-plda-host.c
index f9a34f323ad8..cda8fdb088fd 100644
--- a/drivers/pci/controller/plda/pcie-plda-host.c
+++ b/drivers/pci/controller/plda/pcie-plda-host.c
@@ -559,10 +559,18 @@ EXPORT_SYMBOL_GPL(plda_pcie_setup_iomems);
 
 static void plda_pcie_irq_domain_deinit(struct plda_pcie_rp *pcie)
 {
+	u32 i, event_irq;
+
 	irq_set_chained_handler_and_data(pcie->irq, NULL, NULL);
 	irq_set_chained_handler_and_data(pcie->msi_irq, NULL, NULL);
 	irq_set_chained_handler_and_data(pcie->intx_irq, NULL, NULL);
 
+	for_each_set_bit(i, &pcie->events_bitmap, pcie->num_events) {
+		event_irq = irq_find_mapping(pcie->event_domain, i);
+		if (event_irq)
+			devm_free_irq(pcie->dev, event_irq, pcie);
+	}
+
 	irq_domain_remove(pcie->msi.dev_domain);
 
 	irq_domain_remove(pcie->intx_domain);
-- 
2.34.1

