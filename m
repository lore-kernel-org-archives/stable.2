Received: from mail-wr2-f2.google.com (mail-wr2-f2.google.com [74.125.225.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E101FF1C7
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 13:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784638878; cv=none; b=qIt84puNczlAU3p13/5COtvdzbjBIS859Ic+16rFoEsys36/j5/hzCGtWPb+vWrhdcEl8d7weYFTRlS1Ryt2/Xuq9QsbsoOhpGDnx6YBaPZyI4rlufe6JFIQWc3lalPA/RIomSvF6wpiCCGnPcWfGiSkXu0zaw8coirzA+bYK5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784638878; c=relaxed/simple;
	bh=KuuEpbTst1n9P77orwaO7ugukPK7pW0UmKogjRLG0ZA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KO/cq8UaeEXf+kSSkLQk3Ad5SDtG8iffjleg3AkLi9IqJXR0fkveuZE5cBLG4BLvy9g8xtX41yCJZAEo0OQuYwYF3meb4Vgvc/EO11oB571/tRdI3qzun9GqbUdyqYI6R48ol84XsB7DaJ+qqiix20Vqt+/zf/Nv8KfeOUoRt+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VEGrUJrb; arc=none smtp.client-ip=74.125.225.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VEGrUJrb"
Received: by mail-wr2-f2.google.com with SMTP id ffacd0b85a97d-47301772842so2875735f8f.0
        for <stable@vger.kernel.org>; Tue, 21 Jul 2026 06:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784638875; x=1785243675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dXsaj5sMjmALSo9ZqMQjjSEH9mwAn1wAoVJp06uCuZg=;
        b=VEGrUJrbw4o0FBqf8pal+OOgUEfttjaDOYMVj9loWmtsmi3SIXmUF2hoydZJYdFFmy
         kY0w5vSUtZGIKLw0S5LFLFkqJRGg251zzVu47VjGj3fam0POAhWQSQwcixFr/GvVynVD
         ds0EZhVVhADcfHXxH8l6ClizKQ8kBd7ToY9WrDBJw017F3vle9+1nyki2uWLv5tmaRMD
         s9eqvoGp7k3Ojvw9PHanHOa9gZQUYnj3d3qFjMg78xQbWv0mRnKqPjsWwg5a6vEG9BMH
         Dxgxt+9rvXuOF0WvMS8ME0qHeNINLRwal8s0kekMybkVx8HXhCpQaMsiDVrJjSkt8Jm8
         18eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784638875; x=1785243675;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dXsaj5sMjmALSo9ZqMQjjSEH9mwAn1wAoVJp06uCuZg=;
        b=bqHBc4lRA4JEBnS4C7CJjDj+8WY1ZHpswe/4ubD5MANG+zbtzMH2Yg79Fr3oh97t19
         C7ofKeEE94WIgAZcuuPkvEpAt9NAbfaLWqwjUC99WEHcj4rYYBj06U/Ce2l79u2vgpvz
         w7iUirFYM9/ot0hVwJnAyV11BWdMTL3upaSE6QmDEtC9OsOIGN0rztsrZrjKVomOOqC9
         eZxFgajPdZHDkUB4nHppiFudZVV/m3WpBCkWIN8kPllXsE63cQA+ZQnofgv16Y7szd/H
         FbZb6U5iSaQgqxc7vDwj6TOi+DvhmZYNZy+2xCGziBP+G2L4HfaHvAmhO9rQL5B5SMLt
         GaCg==
X-Forwarded-Encrypted: i=1; AHgh+Rq3Er7l/ceTpDPK8McXbbfkXzog2coj71y93K9Y+J9sQqgFZL70Sch0EGXmeh0r9e4rj2boPmY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7lPy6lJxTzEZLM1oFmpwNY93FkUqvlrJzztnHln+8LSx3xNTV
	K9SrrkT5EuGAwNzSeO2evRrRaSgyAT7ykWnZrmgNmQ1QUOpDu8bsbFpB
X-Gm-Gg: AR+sD12WbPQTid/8oKRPodGDvuk+GZWgNe/kvthksvEaaOWz7sI4Ijpd/yzb/9B2ChA
	1dI8UOFeUfY4ZNHjLABZ7MFxnL6TwgQQJOSkKOpycbNkT02qGRC7nYaC1sAZynrtIIcS7qjIvH+
	vml2M1c416ISkNDZ9K4emRxwOIn5fai7wGohGefVQXfo6JZlRg5o+2S8fDjmdQHpbSYPRYKIEFK
	RCbY5B4DUUAjKO48RNwapTICXr0vYo1+eb/Mc6IDEoIjtTfTd02HvWHSjwvEcA7U+bDIJMlpr30
	htl4q2upR342Vc80JpS/+CEeh5IgFv08Ot9xfFpnar5AsqFmhyibxA37HkR+CWPbu/DrT840AZZ
	LN+mQDonh7N7+3kwo85BX4it/EQW+d4s60eD5yGWIt4+kKlc1u++ucs4uZknCtyw/cL94vrbn5f
	02q+5ZJUI=
X-Received: by 2002:a5d:59c1:0:b0:47f:77e4:37cc with SMTP id ffacd0b85a97d-47f77e437f6mr11752032f8f.1.1784638874842;
        Tue, 21 Jul 2026 06:01:14 -0700 (PDT)
Received: from workstation.. ([110.93.227.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e519f4sm37252791f8f.14.2026.07.21.06.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 06:01:14 -0700 (PDT)
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
Subject: [PATCH] Fix resource leaks on error paths in plda_init_interrupts()
Date: Tue, 21 Jul 2026 18:00:34 +0500
Message-Id: <20260721130034.560632-1-alitariq45892@gmail.com>
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

Add shared error handling labels for error paths to deinitialize IRQ
mappings and IRQ domains.

This issue was found by automated review of sashiko-bot

Fixes: 4602c370bdf6 ("PCI: microchip: Move IRQ functions to pcie-plda-host.c")
Fixes: 76c911396807 ("PCI: plda: Add host init/deinit and map bus functions")
Link: https://lore.kernel.org/linux-pci/20260718120701.DF4111F000E9@smtp.kernel.org/
Signed-off-by: Ali Tariq <alitariq45892@gmail.com>
Cc: stable@vger.kernel.org
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

