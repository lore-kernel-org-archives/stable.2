Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF1237AA91
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 20:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786478491; cv=none; b=ih7bGqQWrBkw3OUaPjc8D0TiWn1UZVGTH4yQKZIgbHF82iqnwZnNJ8HhKE7BtHoMdCO5mYI/1SmsTmnWqU5CK0PaW7smrIwgbSRWTqZF5TQnJL43g86T1PXMLY6AeKXNBFTznnT91W5vek7cnqPyzKKMc/ESsPpFXbatr5jsKic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786478491; c=relaxed/simple;
	bh=M/Ozed0nksdp37DPAu/RhSqJymREkLvE40C3ZrkbZrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UcAdJYiKtwZ4vPpbz3GxSsG1F5xznJkPpLPVVpy4i1HuQuWVKKg7m8SiHhGriCjMWl9ZOmjOrON2z8LIvqWHclw5TV23vtmhmS3jVNyzkd4OWnO4R0oSZx4PkTiOy8NDIdv81oy2Y3z7cKWXaxafCeFKaN2Ujtcux1BTRvTK7zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S7lCBjCe; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7lCBjCe"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-ca80d708489so203120a12.1
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 13:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786478490; x=1787083290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wMP0hddgxDRJDSmMUhN6Ff8CjFaNmUc5wsXEddg84DA=;
        b=S7lCBjCesVWhqzZW1QlBnGRkXtEHCVVxO1tstZdmNcc+oYVLlqZOILxg+FOZWvmcBP
         HB6P5h/ZIDUrmDmCMkWKjal87pSxdbp5+GjUsGEg9vtjZ6bBWUfbR0GijLjiYBrUzDFV
         klvVVZBMqBHAcjPWNBFOnqOeGFtSQ/Ptc2lXfsBTlWksq/Sa+8B3TTFjZ3dgs1+SNIsu
         W2+JGPCUT4+K6zhvVGInfNfXjy2Yvc1hT6r2Cchea6EYBmWNR+bJOvj5tOlyTXT8iGfA
         tbYGu/GAyh/fczgGFwQza3bkvU+zC99Eggj1/0ZGFVNW/RQf29EILtwHzhZGcbC6vNLs
         92TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786478490; x=1787083290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wMP0hddgxDRJDSmMUhN6Ff8CjFaNmUc5wsXEddg84DA=;
        b=hJ7md+xuKUjmJVOVkKXJyfTPm9XPIi6xdIcn8tRJTTuKPeB4pfON13v/OfBpMKLRVG
         CQhgPJyCoYmfQT1n0qo5xVEakKkr4EI0ZN5WfrlfeuAm/FwxRU1kmN8/Wm6PwiKfFGwK
         LZvblT8rD94U3349Zcy473eWsgznxk/EG1/+ht+pRkmHfC4cerOQx2gj0k0OTcC7gUI3
         y1ihnPy5jLdL8gGGJY7U/vWx23MXDp9GeHUHF6JIW2lQ0vFolxewfJCLF7FMEiHa5VXn
         m9iAw6rH2RQqih0OWucNwGxDwR9xzQuY59QYpqoWBx8VVMBwx6rWNMp6mCfYot6I67aK
         vm0A==
X-Forwarded-Encrypted: i=1; AHgh+RpAMnSA2GcVhOkrO9ZAXtPV9BxRIHEO2/K6Xwrja3RgH1uEEhtVg/dQhMvuJbASIh1jOar/S0c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0L3myKbV8dxEUjDL2zE/eON4ezPy301tkh6WgiuJ/01wMgxRG
	cXDK692PfwdtOCKpKeL2YT9Z0edYxLsVWXoN3eYb8NL7Lmc9nW30COOTEcMMJA==
X-Gm-Gg: AR+sD10EX1F9vvsF6/rw6O6kNmc8NcxPWgKrDK0Ay4JD9o56d5h6PQsdHyfAalJHCeK
	QOh6BYFwb2g10D8FgRtQ4854kOpJBRBojOcu2cybfgrd40UMfEXfssW8ehTHC4YoQ3MmW2J13vr
	8vbRAGuu/KIZLwqoZi1Nmg/ShXGpt8faP6kHT737RoX0InF8xFZjbkMlnNoRo4epQ7D3h1tN2YL
	2UIAMeSfBLx/NKjJvr6vXPeaAw7Avb8ZjnkeH50dyYs053cDHQtCw5MrasQLbNJWuIm7x7JNc4S
	F6NNGYnS1DSd1rl+4/iwO2UESqCMRbOMPA65u+D9IwBGT1mZipVrkUcnENsfyE96Z6KhIyeeLBo
	vV+1+cw2d0Fp3rcw+MSB+6Xzy0SPhtvYJp9mJrQlvkXSvOYVXmAIqMWpwD818eypf3tBYI3N7a1
	pTgZ6QOx/vwjqKjsyHU0i0XN7X60C3giBDbDqMgeHIpLbxOhtnSjRq1iEejEdJgqhttI7GuJF+q
	y6Zeyh74QrbnPY698Vq3SJJVWb6y3VSAr48exMD67AnB6BWaNxp857QzwuKdte9u2I7MUWQd01b
	Y5PCDiIiPQ==
X-Received: by 2002:a05:6a21:3117:b0:3bf:b7e8:68ab with SMTP id adf61e73a8af0-3cc377db1cemr3874600637.2.1786478489770;
        Tue, 11 Aug 2026 13:01:29 -0700 (PDT)
Received: from iku.example.org ([2401:4900:1c07:ceae:5da9:e5f2:ea74:b6c3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31cf6791351sm2216447eec.23.2026.08.11.13.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 13:01:29 -0700 (PDT)
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
Subject: [PATCH v3 1/3] PCI: rzg3s: Disable refclk on probe failure
Date: Tue, 11 Aug 2026 21:00:11 +0100
Message-ID: <20260811200013.185956-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
v2->v3:
- No change

v1->v2:
- Added RB tag
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
2.43.0

