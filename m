Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627D537AA91
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 20:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786478503; cv=none; b=ZAwtIM8qF55ZefoLnFvH2JmiP4ovOdGbW+E6ps1bYbhtj4HNy8oUaLQjKeAfZXcu1rxuh7Qn6A3G6V+ZPywhnMp5RWvbpzbJTLsFAPqi74baAoCugrPOHEeN6xSlWNj97H91qH2ZuY/3SvnN4JeWpODaxrSiBv72z1W3ZfM6SLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786478503; c=relaxed/simple;
	bh=hrmzmVrvGWTP1LsYT+VaNgqVj1es0y60dQVMTGpF/os=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qhDc1uW0f7pIOZ+NHAuB4ZpUtgQoUfS72gs/XeetaFKyJSL7mKeJF/HQcW47uFOZOsT4qUO2b5/1EPzJ4sf2fQEoW0UM6/8zR7b0IJmw4+Rpf0E8gFIEse5Gst2+LQKuS/laGu8Tnm3T2kopwB1Fm76nlTyKmMYYlPgdSZnSybA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=btYJmYUX; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="btYJmYUX"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38e07ebd263so237539a91.1
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 13:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786478502; x=1787083302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lduyi+JxRXbKGNM1YQ1o6cUDvymR9U7AMupOhybXW/k=;
        b=btYJmYUXlpREXv9W0k6m90altQpe8tT5hxMwqseejOyH/T1BTDK5sLWh/2VjerfhSx
         Ca9LPABZeG3nXa46/HA6DYYP+R2nKv3LQl+drsIokbwyQckIoABGoY9BteBaEDFWu6nI
         DOiJDTfimXqaSJnHlqKl1wMD92PbvEH0P4itAAm6jJys8lIDajDl5LcjozvC4fhzxte9
         sXg2YIsRn4Hb/8DlEk8mzk/3MzpUvfGJg6lLWKvCgGrynzHPhIvWhfdDfX+7ey319Dgx
         pehP4/R6QC0EmTQN7lgZQPWj7fBmv+BQPY41IXfIdBxrb66sqLQPqjf3pssd1kjqeQIY
         LhFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786478502; x=1787083302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Lduyi+JxRXbKGNM1YQ1o6cUDvymR9U7AMupOhybXW/k=;
        b=EEOXOYDqONHXi4sqye+WRNgkHBHoWvKC6g9ONZUMNYodYCBamVTclEx+YxeaPk3CMG
         1VkU3ATBWf75E6NL9fC8HGShiKBxrPTdAzPiGgCVsq7jR4/tiCN7d1PM+P5d50aDd3li
         FV61ABw+zAR82vwNSrtrsUpPf1TnMfQu9lTflvAQsp6eUoO+NLtY1C0rBiId3UIJcMA4
         BM1/hLF43OqnmLaN1dy/zIs0XVK8a4SPWVuInArMLILior9SDhELAvEwm93D4lDJjUBS
         Yb4CMWJZJeVQ0fQAi+KHeNxQpTO7x4tvR64tSpdQlt2+njXK4X+EyFUCRKzdYhrtQC3G
         etfw==
X-Forwarded-Encrypted: i=1; AHgh+RokFCOf/xX4Z0DlGeav98Z0u12f8QtRFo1PFziZrd62I6JbkCsnqvCjMIp6nBXJw6o+QvgHmGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDESn4aCXtUeqzZuOepTasJ273eDnofF1DmLb91fBLirBSkZGJ
	cREbs2LDjQqmFLu21jQb1LMZOX2zLUGgIy5ya7ktGGD0t1adiJn8A7cg
X-Gm-Gg: AR+sD10FtcQbGtuE6G/dqARkxfew9wYYbRDTPW/EO5mtcvgOAfYfCM9T1tDvhwR31hu
	ztukQvtbJPCJHlVHno0Gz9H+jZYfF2X/1vljYz4iIqpVMPqhVvesKYR2kFFGJ+lwS1sTsOEekPA
	pTG+2mj6j30Pt0Dn+bKIAUvL0fH5kTcEaD+Gp3dfpkxDOGWuMvsjdgV+YPoLes/2vIqk2FbGGv/
	cxsKr1pZkCTsUvvb0NTACIfPrWVwkrA1f4Q45bPXuHUWvgzNmakP9g3EMg+xAjPXXPjTMaBmTU0
	+K9RuOUOFnCNAnFLDUK1Xg2u6WpKbvKdqGa55UE5KW1MsI1iefQgd31sOu4Eu/IxdlsMVniPhkS
	ppydMz5Jsg3W2ejeqYqhW562OodCJSSakorbB0TAceP/xWdHY14iaY57/HpqovUxXVXZ5kMmeBl
	j2VBN4KN4kfaZWMi2lSlth7GJrW5s1MJtR4QRr2sIakVPNjjdTDQc924ezXsYws3841Bv3MaO8+
	ptQWu9HDHmXNXAHX1VyUq/3Y8JtbrvzgRYEEggGa/DnSFu1leS5U+nW3bEWVfgsOg4LMuQJjjGd
	9mL4q6FB+A==
X-Received: by 2002:a17:90b:4c89:b0:38e:5b59:c2ff with SMTP id 98e67ed59e1d1-392ec396095mr5951201a91.3.1786478501719;
        Tue, 11 Aug 2026 13:01:41 -0700 (PDT)
Received: from iku.example.org ([2401:4900:1c07:ceae:5da9:e5f2:ea74:b6c3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31cf6791351sm2216447eec.23.2026.08.11.13.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 13:01:40 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 3/3] PCI: rzg3s: Fix IRQ domain initialization error handling
Date: Tue, 11 Aug 2026 21:00:13 +0100
Message-ID: <20260811200013.185956-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260811200013.185956-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260811200013.185956-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

rzg3s_pcie_init_irqdomain() installs chained handlers for the INTx
parent interrupts before creating the INTx irqdomain and initializing
MSI support.

If any subsequent step fails, such as obtaining an INTx IRQ,
creating the irqdomain, or initializing MSI, the error path returns
without removing any chained handlers that were already installed.
This leaves stale handler and data pointers attached to the parent
interrupts.

Add a helper to tear down the INTx IRQ setup, including removing the IRQ
domain and clearing the chained handlers. Use it to unwind partially
completed initialization and from the normal IRQ domain teardown path.

Fixes: 7ef502fb35b28 ("PCI: Add Renesas RZ/G3S host controller driver")
Cc: stable@vger.kernel.org
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v2->v3:
- Added rzg3s_pcie_teardown_intx() helper to remove the irqdomain
  and clear chained handlers.
- Updated commit message.

v1->v2:
- Restricted the code to max 80 columns.
- Moved calling irq_domain_remove() under err_cleanup_intx label.
---
 drivers/pci/controller/pcie-rzg3s-host.c | 50 +++++++++++++++++-------
 1 file changed, 36 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
index f51b5d7c1998..3f7393c49a08 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -1006,22 +1006,38 @@ static const struct irq_domain_ops rzg3s_pcie_intx_domain_ops = {
 	.xlate = irq_domain_xlate_onetwocell,
 };
 
+static void rzg3s_pcie_teardown_intx(struct rzg3s_pcie_host *host,
+				     int count)
+{
+	while (--count >= 0) {
+		irq_set_chained_handler_and_data(host->intx_irqs[count], NULL,
+						 NULL);
+	}
+
+	if (host->intx_domain)
+		irq_domain_remove(host->intx_domain);
+}
+
 static int rzg3s_pcie_init_irqdomain(struct rzg3s_pcie_host *host)
 {
 	struct device *dev = host->dev;
 	struct platform_device *pdev = to_platform_device(dev);
+	int i, ret;
 
-	for (int i = 0; i < PCI_NUM_INTX; i++) {
+	for (i = 0; i < PCI_NUM_INTX; i++) {
 		char irq_name[5] = {0};
 		int irq;
 
 		scnprintf(irq_name, ARRAY_SIZE(irq_name), "int%c", 'a' + i);
 
 		irq = platform_get_irq_byname(pdev, irq_name);
-		if (irq < 0)
-			return dev_err_probe(dev, irq,
-					     "Failed to parse and map INT%c IRQ\n",
-					     'A' + i);
+		if (irq < 0) {
+			ret = irq;
+			dev_err_probe(dev, ret,
+				      "Failed to parse and map INT%c IRQ\n",
+				      'A' + i);
+			goto teardown_intx;
+		}
 
 		host->intx_irqs[i] = irq;
 		irq_set_chained_handler_and_data(irq,
@@ -1033,21 +1049,27 @@ static int rzg3s_pcie_init_irqdomain(struct rzg3s_pcie_host *host)
 						     PCI_NUM_INTX,
 						     &rzg3s_pcie_intx_domain_ops,
 						     host);
-	if (!host->intx_domain)
-		return dev_err_probe(dev, -EINVAL,
-				     "Failed to add irq domain for INTx IRQs\n");
+	if (!host->intx_domain) {
+		ret = -EINVAL;
+		dev_err_probe(dev, ret,
+			      "Failed to add irq domain for INTx IRQs\n");
+		goto teardown_intx;
+	}
 	irq_domain_update_bus_token(host->intx_domain, DOMAIN_BUS_WIRED);
 
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
-		int ret = rzg3s_pcie_init_msi(host);
+		ret = rzg3s_pcie_init_msi(host);
 
-		if (ret) {
-			irq_domain_remove(host->intx_domain);
-			return ret;
-		}
+		if (ret)
+			goto teardown_intx;
 	}
 
 	return 0;
+
+teardown_intx:
+	rzg3s_pcie_teardown_intx(host, i);
+
+	return ret;
 }
 
 static void rzg3s_pcie_teardown_irqdomain(struct rzg3s_pcie_host *host)
@@ -1055,7 +1077,7 @@ static void rzg3s_pcie_teardown_irqdomain(struct rzg3s_pcie_host *host)
 	if (IS_ENABLED(CONFIG_PCI_MSI))
 		rzg3s_pcie_teardown_msi(host);
 
-	irq_domain_remove(host->intx_domain);
+	rzg3s_pcie_teardown_intx(host, PCI_NUM_INTX);
 }
 
 static int rzg3s_pcie_set_max_link_speed(struct rzg3s_pcie_host *host)
-- 
2.43.0

