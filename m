Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B833D5660
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 22:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784154629; cv=none; b=io3hrIfsXTFr7OlXffgGPO77naaqZERDWJ+iOuva9GY5elNqTymqGqsv4m+tn1f6RyCD8Bq2+nd/Hrxhrl1seNXe0NCp6IiWFM6lVkxPh1H7yyASnkgJ/gPefcIUz/2cR6mfTlQlKEaRBLWoKBR7QDy3KMXd+UBcdVImeWMpe1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784154629; c=relaxed/simple;
	bh=iG8DxBgPeFTS2wD34Yri/ahbMlagck2D5bkaD14Nv00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VkS8Dqz8OF73JnepRWzakushQ9pPh0xeAXjpAWa1hhy3yCkf1QMjhtd9xhhBUwGwjh7roqVdEsQk1AOWBP0/v3M5y5wrrZJY04oRzL3W/P08VzS5GFvH9vTrlblW4WG7jlTPTE2Ys7PF2I0JYs+2F6dAxaQ4W+ZfpwoRix7aaFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BGSczuAz; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGSczuAz"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-493e4ccccc2so37379605e9.2
        for <stable@vger.kernel.org>; Wed, 15 Jul 2026 15:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784154626; x=1784759426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6z5e6ZRDnBIxpo0diHIfK/ZsB3aIEtSkbb+xJwPFfww=;
        b=BGSczuAzLxnKTwETEr+ztgpd+WHtgkeTzKMRtydSQA/2KfC24VwXNZj9MAOyA22r/4
         Rsk7HXUjDJggdcMDiTKmXQcFXRimSAZmnAB/+ghDaONfxKXAE3aiwuClcBQR6ZQVHu6O
         GjQxWekXehyOzV4anp6kixg1lwu1PL2BaUWa3Is9GImkoHcnk2WP2jc460HgIAFs4Uj+
         yO0GFaO22+y5fPykEYq6ffnW8W60hYho425S+VepTfKyZlUKIEUtvpPem6gKQdvUeDYx
         HqBgTrldZRfZUiwvxThWoZ8ST4RJhbwPRokv2+sNQP6gaBJZ5LPFfnCEyKo3fOVJuK8m
         0CqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784154626; x=1784759426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6z5e6ZRDnBIxpo0diHIfK/ZsB3aIEtSkbb+xJwPFfww=;
        b=EjFCZfW+9H6NLX0coIY6/Eojgk9I9kqOVdwSWnhaUZtbr5gWfAvB2+GKt2N5u7p6mb
         mHA3QqVv0qQDJrlFodwODh0R10oqOLhE6o9WR4/MBblMs6XOFCrSNBdUaWLjU3l68row
         MnbiBcx09tknQ/u8AvpFfTu9AQyRFFv0/bSQUWx0s1+gJvKB5MnERlo8xzC8iu5C+cWz
         +QwdPbJcW72Yd0euKArHUv5FxUyzI0LFqFkd5g2SjOpJz6/HpoNfT4bwA6Tf1v1Rf3eK
         jd+wCJzTmYacmq2GzhTpy3tAo475rDih5/xIGW3P78NAsKQznvtPwm8j8CQoNSZ5FE2S
         bcjw==
X-Forwarded-Encrypted: i=1; AHgh+RpGeH5tA2QAuHVeATgHfT6BrMQdTMK0TQqoFWKYiwvRLGMgIjHjvwCDNcwhXs+/1RZUIdjd8N8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywko0uH+ih7phwen169gpomt9qtUZVHUirJZlLt9zTZVq0uEVW
	H7wqdvAa+ZRyIc/+RoxmhZcWNd3tR7ucwjV+ifxpKsC6v1/EOVU0LcaC
X-Gm-Gg: AfdE7cnUAPW1ScMzE5k/EPnxJvk2hjh+1x/YojlTEOSrQ5KXyMjlFHAF85qX6WcCu+I
	uZ9X7g2wMJWKCAiUfDkGnthtfc9kbvGiBwqf7NHNMtTptXUc/Yf5c4wo9/FIusp0XMmq+Z8dHqj
	Wq+W246sGN1EezfNWvvzXh2EO+gRDI/WH3xU3yW41ICA34BsHVUsxS1JMeeaA7O9436pKeHxiMo
	oPYWpYsMRS2UT2OYzKvk36ueKohwJTMyS+Rd1yQp+zbP+ewIwXFrxJrpFXu9+pfb6ASa+pjZIoN
	ld8gSDZ7GxN1O0BX3gawAvUj41s7nSFfIHlZUWWVm4EOtu6SAeK26CfiZOrUxWiLrD1eJrVJktF
	t5OGThEuu/PAgJ3L28BnEdO6HfDEl3P/1SCa8czCUkDGsQfhWH7gzKcRNRGtW+Mec4Rt6sVBmy5
	n3i8s6mBo+L4M3dJO1cysq2k/CXlxcsqP9y429oKeUE2j5sI9YOri7pXPPBJXxw8Qziptu+Ow1Y
	bM7JsioN8PGlxBp
X-Received: by 2002:a05:600c:1d1d:b0:495:3b66:580e with SMTP id 5b1f17b1804b1-49541c5dfc0mr6927505e9.32.1784154625853;
        Wed, 15 Jul 2026 15:30:25 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:6d4f:b160:7aea:9d1b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49541e9ee07sm14791025e9.15.2026.07.15.15.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 15:30:25 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
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
Subject: [PATCH 3/3] PCI: rzg3s: Fix IRQ domain initialization error handling
Date: Wed, 15 Jul 2026 23:30:19 +0100
Message-ID: <20260715223019.3002237-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260715223019.3002237-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260715223019.3002237-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Fix the error path by unwinding the chained handler registration before
returning. Also clear the chained handlers during
rzg3s_pcie_teardown_irqdomain() so that teardown fully mirrors the
initialization sequence.

Fixes: 7ef502fb35b28 ("PCI: Add Renesas RZ/G3S host controller driver")
Cc: stable@vger.kernel.org
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pci/controller/pcie-rzg3s-host.c | 37 +++++++++++++++++-------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
index f51b5d7c1998..5aeb030d43c8 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -1006,22 +1006,30 @@ static const struct irq_domain_ops rzg3s_pcie_intx_domain_ops = {
 	.xlate = irq_domain_xlate_onetwocell,
 };
 
+static void rzg3s_pcie_clear_intx_handlers(struct rzg3s_pcie_host *host, int count)
+{
+	while (--count >= 0)
+		irq_set_chained_handler_and_data(host->intx_irqs[count], NULL, NULL);
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
+			dev_err_probe(dev, ret, "Failed to parse and map INT%c IRQ\n", 'A' + i);
+			goto err_cleanup_intx;
+		}
 
 		host->intx_irqs[i] = irq;
 		irq_set_chained_handler_and_data(irq,
@@ -1033,21 +1041,28 @@ static int rzg3s_pcie_init_irqdomain(struct rzg3s_pcie_host *host)
 						     PCI_NUM_INTX,
 						     &rzg3s_pcie_intx_domain_ops,
 						     host);
-	if (!host->intx_domain)
-		return dev_err_probe(dev, -EINVAL,
-				     "Failed to add irq domain for INTx IRQs\n");
+	if (!host->intx_domain) {
+		ret = -EINVAL;
+		dev_err_probe(dev, ret, "Failed to add irq domain for INTx IRQs\n");
+		goto err_cleanup_intx;
+	}
 	irq_domain_update_bus_token(host->intx_domain, DOMAIN_BUS_WIRED);
 
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
-		int ret = rzg3s_pcie_init_msi(host);
+		ret = rzg3s_pcie_init_msi(host);
 
 		if (ret) {
 			irq_domain_remove(host->intx_domain);
-			return ret;
+			goto err_cleanup_intx;
 		}
 	}
 
 	return 0;
+
+err_cleanup_intx:
+	rzg3s_pcie_clear_intx_handlers(host, i);
+
+	return ret;
 }
 
 static void rzg3s_pcie_teardown_irqdomain(struct rzg3s_pcie_host *host)
@@ -1055,6 +1070,8 @@ static void rzg3s_pcie_teardown_irqdomain(struct rzg3s_pcie_host *host)
 	if (IS_ENABLED(CONFIG_PCI_MSI))
 		rzg3s_pcie_teardown_msi(host);
 
+	rzg3s_pcie_clear_intx_handlers(host, PCI_NUM_INTX);
+
 	irq_domain_remove(host->intx_domain);
 }
 
-- 
2.54.0

