Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A544D3F58E6
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 09:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785146334; cv=none; b=KoXyeu3/c9gQTGHFBJ4yZ/aKajMpvAeDP1mmtdhzkySBNLbejUjxYjV/oyn+NWvbmJ9qNCLUoK207IfuecZovIUOoaN5e82ymbX+TOjibZ54LROE6jZ1BTT4F2wRYkiji/YoBYew5QJNzf6F/5OtVLoAOW7nP147Far6eVkuTOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785146334; c=relaxed/simple;
	bh=pw9oD6T8ziDz5AocQMGcjo0IE2svVURl/d7HMaclxQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bMXYT3SxuS4cnJMHvD1swxaqwm/f9UBIrmQE1A+7SHEOzMcaM+n6n87/mofWklDE9+sY3fI8/OOlBzLxEJgc2l6bfu2m4Z8luYmyAjswfNl+ta2LBBaFfwUOy7IMtqagDKTqOdlc42Pm7CqhIFkLEJKbeAAYNxIbq6s8vXwUzoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DrLdeVx5; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DrLdeVx5"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49555a0e68bso12381405e9.2
        for <stable@vger.kernel.org>; Mon, 27 Jul 2026 02:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785146330; x=1785751130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eWJlDdWHxmS1QqPm+cNMQ7ctsiEfAw9CC6zmRyAodTQ=;
        b=DrLdeVx5dL+qr9TOy6BffyKxdqTAxlxPzpCVdg7NAJFv3MdNh5Pagr9YZ1NzFTqnix
         cv+ZdOvf26XckfZ7/51+TkfRya9t+XAYdh7anwBgTZJMYnJOWktPLMZPcQDxZertbc9U
         N3oiOP7MfA6kHad/EQ4rNh68wfHwZe9Cxmr16RFnBW5NupD+2AuZCx+mZDKeRZJTv7NQ
         W3Saj7/E1ugItFbrTnUJAv/cUaiAo2RHCB5qPp8ETz6lpD6J0a83U/PCKJ31qfbyoSui
         kInM9FElS+5IjYkf2JuVgFX5VZ5afnuQVsHrzuc43XNHuBw01zBYRoUxLaSqpjciOaja
         8EMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785146330; x=1785751130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eWJlDdWHxmS1QqPm+cNMQ7ctsiEfAw9CC6zmRyAodTQ=;
        b=o5NB4iXm8z79onytSuPrTODNel0Lnrv/htu3gglk3BgluRChtjetbkULCAfG+3RfLA
         V34ERM6CSQ1WmFXAwI4ooxnGfV1kAa0+YoN79cEPtK3/SI2kwr7AD9bXDM6sDvoKAyFD
         beXTzWQ/drCbro4tJMTfUydD6d9X0bRuXVZRQsjZZB0ILRmzQNNs92U3eCLhn4HEt8gZ
         vdWQJcqEUq6JhQZ11/i621N5yLf0EE/rIfvJMXdIa1RhZOMZgxYlcKPbyf9Mjwh8rCbb
         Kb2Iy+NVNzz1/RiOJGFiklDKq+Jw/zvbhHlbljU638i7V6pXjQIzIawmZVGfpFI2n7CJ
         LHng==
X-Forwarded-Encrypted: i=1; AHgh+Rr7FxO6X2V5phEBaXsxq1xJ35SFVLPMl5OnMJN5Tu2RchYFivPAK1ipQ8dkQgqn1l8YGixOIwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJjVP0xKU7aNLuF8e1NOouSiJ5YERNw4YNkZUBye+9eKtdWngi
	FNs3YIX0l68JfZ229UHbpr7A8zakLS9F5BagtOHgHvNStyBeEfigbm9B
X-Gm-Gg: AR+sD10HzlrbIgQLTo63l2wfPuWzUwe8tci2nMUx3YWtKUF7fQmBC+3TwK8dK+wvC8g
	NmNETnKp29UX7+g8JMRLcQb3r9dXOsqpwPlTgoK1j1LTENhy52BiRJxfuy0ugmr/X7MLHo/e9ze
	9NkX8Mdqs51WrpO8q4uViA9k9qxoPD/aWaywnQPDEYMWWObh9L25gMltPG4NMkpl1EUuIWLdEar
	t9YR5MWwyavJ8rCSu8nQmOdGd8U3CLwIl4TjtuLXlsWG379uQ+go4Waj871rEvXSFU4RGGKN4yN
	Ic055S8ViUTacfA9oydBqLzlQxB0K/R0CKX2aNmHyktFwOOhJMfd8/P93fNfn8c+v6MbDqUr2v7
	IqKKaqbSgp9RKIrnTq9gAzxMbTIoTu008DdOZ1bJBSV/aBXhSQJD1C0QstEAixpUDdD2d/vWwIT
	Ks+HQe1r9GmHzpR3nwo9tuU623OJm/fFYnom92PviSfrdSjy7H01lRqBXgUmzAu4Z0AYb7pOoJG
	lrcnHBNw+QtZHDK
X-Received: by 2002:a05:600c:1c05:b0:495:607e:5ed6 with SMTP id 5b1f17b1804b1-496b6a31f1dmr94038395e9.31.1785146329650;
        Mon, 27 Jul 2026 02:58:49 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:8281:5343:33a3:cac0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957b842691sm238346295e9.1.2026.07.27.02.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 02:58:49 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 3/3] PCI: rzg3s: Fix IRQ domain initialization error handling
Date: Mon, 27 Jul 2026 10:58:43 +0100
Message-ID: <20260727095843.116950-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260727095843.116950-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260727095843.116950-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
v1->v2:
- Restricted the code to max 80 columns.
- Moved calling irq_domain_remove() under err_cleanup_intx label.
---
 drivers/pci/controller/pcie-rzg3s-host.c | 49 +++++++++++++++++-------
 1 file changed, 36 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
index f51b5d7c1998..70f1faf7e422 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -1006,22 +1006,35 @@ static const struct irq_domain_ops rzg3s_pcie_intx_domain_ops = {
 	.xlate = irq_domain_xlate_onetwocell,
 };
 
+static void rzg3s_pcie_clear_intx_handlers(struct rzg3s_pcie_host *host,
+					   int count)
+{
+	while (--count >= 0) {
+		irq_set_chained_handler_and_data(host->intx_irqs[count], NULL,
+						 NULL);
+	}
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
+			goto err_cleanup_intx;
+		}
 
 		host->intx_irqs[i] = irq;
 		irq_set_chained_handler_and_data(irq,
@@ -1033,21 +1046,29 @@ static int rzg3s_pcie_init_irqdomain(struct rzg3s_pcie_host *host)
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
+		goto err_cleanup_intx;
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
+			goto err_cleanup_intx;
 	}
 
 	return 0;
+
+err_cleanup_intx:
+	if (host->intx_domain)
+		irq_domain_remove(host->intx_domain);
+	rzg3s_pcie_clear_intx_handlers(host, i);
+
+	return ret;
 }
 
 static void rzg3s_pcie_teardown_irqdomain(struct rzg3s_pcie_host *host)
@@ -1055,6 +1076,8 @@ static void rzg3s_pcie_teardown_irqdomain(struct rzg3s_pcie_host *host)
 	if (IS_ENABLED(CONFIG_PCI_MSI))
 		rzg3s_pcie_teardown_msi(host);
 
+	rzg3s_pcie_clear_intx_handlers(host, PCI_NUM_INTX);
+
 	irq_domain_remove(host->intx_domain);
 }
 
-- 
2.54.0

