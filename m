Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0F037E5EA
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 22:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784154627; cv=none; b=Le+QGBvVHzalcZLN3RgHqcHaiccAbipBstmBHyy3tT6UnTdiZacv/qk54TVYjBI8IQt4yMQe02S57xfl890YUJx91mZLb+k+aF5B2rODT+xTwaTPGHdsDVN57AgPPw0p1Mryl4X4KUgLH6B4opmuN0ePm9eDqk+QNWsDhxcqSKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784154627; c=relaxed/simple;
	bh=hR7PWAXiXwEEwFIet49TpDy0cQALd3XIah84ihqGwyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZUP//q/oF3+iR0aW3PPzqDgSF6mlLOQ+bzayOtbWGyXsvJKz7F5bmgaUHjjgzY02oSXcuiieqoXKWWRLNTCxVVes94XwifOUcZP8IgpKWDifYKzrCbHMh/LR6B6PPGammc6OmcfUq8SrzcOWXnxahQt32VsZMJJ4hy6/EuVun8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hMOVTl/s; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMOVTl/s"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-493b966dd74so24083175e9.3
        for <stable@vger.kernel.org>; Wed, 15 Jul 2026 15:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784154624; x=1784759424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G4ripfAJqWHIXdYXUM5+uu7AjPtdQOgQwww925KypIE=;
        b=hMOVTl/s1GCb1jmAoqpSGG1IP95cd2y4F+1Srj+2Zz57cayLKBmMkL3y/VbvuT/yGQ
         9vd3E4YqOyVw/ZRkTG7tefZWlAFzG5H+wRkdl0amvJPrD+YWTpcK9CZr42ERipetzVgO
         YXAQMdo1H2nTIRDu11xSL60ynNmKla3ss11Kz+9Vmv4iszaYqeaRysJHN15s/iwDccYl
         ts8g/WaIPHfu4SGY6fueTLRybmzrwrscGy4rSgMREO59TI3LSe01Tvmb5DASpOPUJmWE
         olCohkhTDVHwnQDLHCHpDpQuFZn9T7xQbkboP925/ZxfQ9yJ+GFo7AloRaa5mhbVIOYM
         UPAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784154624; x=1784759424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=G4ripfAJqWHIXdYXUM5+uu7AjPtdQOgQwww925KypIE=;
        b=MSsR9RvUFgr14sXPJMePffleZLV70PmRMLoCFgexijOzDmDcwqKsFjJpxNjO77ZVol
         VMncttnTPddnIODAIvvYo8UuIaJ6B5Au+VCJCeDgesEB7oW/5fDPj4kzds8hnVs7DWwO
         SU5s+TtzCKVPg1oo661I8Mko8Ashl4CzI/FVFu/3aa0SiRFdIrpftgnZ7yof0ya/wOgD
         +g+8Zxsbh8VEVWU/UWVy6TUQOL7ecUOA3nVUZ6cxZSajxKfIMpN4C5uFgI26G+Do3yY4
         FLA6/Ba6WEn75A85Q4zFgYkfTRLTbiM/vhOPxzyWJirIlumY0HLqLek435Rilq4ByOri
         pXfA==
X-Forwarded-Encrypted: i=1; AHgh+Ro3P6eX4ilSJZOa72W15/XA+eLRN9LCU5gNnemmDCWlEwbDPKj9ITvpsSeLFGEeJm/pdkTLwSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNWjp7cQTJ4wj2ds8+RTF03fyV2QR/J3Mc7bn63XLmgvTeUXYu
	mnOOve07bsRDkJTxxABNIGltrLkFwGNxn3CLcBZMZZrJXZrLpmhS62Pu
X-Gm-Gg: AfdE7cmsJVwpxoS6DrwyjKcpYIAI7AtLHjLPQ/4dMssK0e1EfHVrsN/Chk89k3XFjXb
	L75fc7gGAxrzhTQS4/eW1Aw4paGleA9x+aLTCHKPbGCzQcuyoHj7QQK6rSlI4w1BCX6aE/WW7zH
	gmROVLdJoDdJgROdA1dtRsWgVOJ8WP1tW/iQCaLUjI8h/lFE+YT9Fbbnh0LnAfQV55A7yq8iShj
	oqxK4elS/Jeaf26LLbFWcQxBqbzkv+MIccZrT4mPoT5DTd5sAF/ufQBj4Om1Q+w63cJXlTbW1M5
	J4TZ19YC0IO3Qs274Pq28ckn3UWmJJVL6SGTFqWV8xohnsp0z9Yx4/j59vo9vARixfud03dL4Ih
	QBhIRZ8fpW650+W5EYAA72rVH7C4EcTyoN0L8BjhrtmZ3JXBieLDnyaKcpq48DYUtkZPEyhtYpU
	7vLxJW4QjYpwBkV3hRHmOxt6XWtLPHyq+rPZfRpTMV0POgHnnl9WfGPtwMw+J3+h/G4NAPg1u6R
	Hx35+j3mOAV+cseK4bsDA1aWAw=
X-Received: by 2002:a7b:c38b:0:b0:493:c4e1:40a6 with SMTP id 5b1f17b1804b1-4953c28b6bdmr37737615e9.32.1784154624276;
        Wed, 15 Jul 2026 15:30:24 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:6d4f:b160:7aea:9d1b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49541e9ee07sm14791025e9.15.2026.07.15.15.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 15:30:23 -0700 (PDT)
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
Subject: [PATCH 1/3] PCI: rzg3s: Disable refclk on probe failure
Date: Wed, 15 Jul 2026 23:30:17 +0100
Message-ID: <20260715223019.3002237-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

rzg3s_pcie_host_init_port() enables the PCIe reference clock using
clk_prepare_enable(), but if rzg3s_pcie_probe() subsequently fails, for
example because pci_host_probe() returns an error, the probe error path
only releases the clock handle with clk_put().

Balance clk_prepare_enable() by calling clk_disable_unprepare() in the
probe cleanup path before releasing the clock, ensuring the reference
clock is properly disabled on probe failure.

Fixes: 7ef502fb35b28 ("PCI: Add Renesas RZ/G3S host controller driver")
Cc: stable@vger.kernel.org
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pci/controller/pcie-rzg3s-host.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
index a1a78bdb7af1..01488660ab08 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -1897,6 +1897,7 @@ static int rzg3s_pcie_probe(struct platform_device *pdev)
 	return 0;
 
 host_probe_teardown:
+	clk_disable_unprepare(host->port.refclk);
 	rzg3s_pcie_teardown_irqdomain(host);
 	host->data->config_deinit(host);
 rpm_put:
-- 
2.54.0

