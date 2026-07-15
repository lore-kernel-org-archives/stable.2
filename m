Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7553D5244
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 22:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784154628; cv=none; b=p0hvrwZfc3cqzC1YyR02OTvjqf5+T/70Pnfs4w/44PN3TnZA+9FKcZRYOYsk9ZX5fPI4Duz7SGpMoQNiqzo6jVXk9QqNbuQHosXlAOcQ1Nl98tjW/h6m4IVXabtOqnt1d7XATWx2QzMkivwQf/D5Q3w62Ay7VC6Gq2xa8xOMNig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784154628; c=relaxed/simple;
	bh=EgzVoeiVIyluF+6tG2YQ8PKK7ioQwBY/YfGkht25UGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M0aZXus9P4E5Auy46YPOLejZQzHcXb+Y3mMtohPckAcOCoBCJQpgJy7n/V7lCI047j3xegsGk/9Ry/PMmVsIIgGZXi6JcDq0xCG/uMZG+o23XlKU3/gobwDdtNUi/IBYTGSN/eIv6v8W0l5Cy6R/zdEJ1mKy932BpPmQ90Mxa4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4qqFVo9; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4qqFVo9"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-493ce08a75bso24405845e9.1
        for <stable@vger.kernel.org>; Wed, 15 Jul 2026 15:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784154625; x=1784759425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cEtteLgNckAc3Sa7DEqz8fG/qXrLZDXlp2czTWgh+CU=;
        b=O4qqFVo93xk9Ja+6Q64ES1sd9MaEQ4U+pGCi6MevCYQkGgZlEsp4xTsV35DPB/Alzf
         o3AK0DLCNYU+1NrB1hwi8izUPrJrdhMny+h+6yE3RKHpwRdOlStw9yjcBdV2woWbyrsv
         dZPpjMhAoMkZNUV79OzuH3pd87QQ+M8QzFzcc76BG/W7J9rfKfNziaafsmKshLaolCjV
         4UCAQ0LD+BuNiK4vVsRyKeMznPKT0iclSF98xp6qhocNfts5vhTAL8QxWnfKTfV0UX3x
         sIzNCZ9TCkgs1fBGvT3XRS90i5XAlpC5Na3FqR7dTwlU6MjAMb56FGv8q8Th2CQgqAW/
         D2VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784154625; x=1784759425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cEtteLgNckAc3Sa7DEqz8fG/qXrLZDXlp2czTWgh+CU=;
        b=M6K5ayNfsssEB4oujJFzvUL6paYYNZykkZhs2jyqN6msxVwaZEuQDnN1qIrfikhqkg
         4C4Ma8MMH9HBuZaUcgpZpLNDgDsEwUGBbOCikxW/BJP8SGQ3Zz9lZ4OuSr2oN5/TPw7N
         MZOZJI1NOHT3LQ20xHRkvxvRoRxJKgvrLlK7gHn0Oz++g/Zi2k1egG9BZQguGppZC73j
         Pjt+0XJTocksexyLKk1onSy1fVcBDtQKTQ++9npB6+x4dvOTK1XVGcsOwtULtSqv+1lm
         6f1Dw7MVkTCW+x3MgZ/cXXTKXTQddEsSHKg6FKe1yTKWePYbB1+mGqfV6zVVAArSneps
         5vpA==
X-Forwarded-Encrypted: i=1; AHgh+RogiUKwZNjryvVZE3GWy9LwOt9ZzOBKchWxCE9HMWoWc+IHkcu7gGgeu4529hP/gdU3M/3pjbs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz43BnI3nNBeEalmlJRYbhsE9XKulmQxmc6sje/1B+ddVcvgnah
	CryrhNJPtJbZKwKA+YKwen6jrWkXx7uVLSUZkrWyK+XIO83Wd1L3sGMp
X-Gm-Gg: AfdE7cnFcnPiCEBRL9Sv0OC8iNp9Ofg0pHE/ouYJOYnhtP5l76Ow/2Dj9mKPHJeGtdX
	GXkx/utCgCKdAe5ntxV6Z/HYRvmdRzsoAXbxcU+zgv69ZhQI3VfJGcV8OMuqK6LnEZ1E/47dfte
	9AFZ83OYajm71JYhBzcgFQNGNBJ/2nqCapJueqUA1D9WDS7ub/k4lzjxwM2VI3HF+Z/zt6apt3V
	m8CVslNdRa+yzFcg99PzY5nhENVtyJaVB8ga3T80pQTVgGfMlEXemQllkdRxpmrGQQQPvGJeEi7
	1LQTp2w7ptM2NR3N3z0rZL/kqij8Buu74seL9WXrb6/TlH+YNsWvoG67R40vNqJOmr+LZJdiOGd
	lPd23XKx/pI4bbZsQMA3rVlTdA8eXefrcO5lF03X6R07hesLrurExJzqz7CNU8DH5SCILPWWhjU
	MoDOMnMa1ywZ8SNxeptoTxaZELRFB3C3oxdMrcKbws1RRXFVzkW1n4aVzvPcMApCcWieZ+tBEaC
	NUuWq8qGQ5WS4lg
X-Received: by 2002:a05:600c:4e53:b0:494:282:106c with SMTP id 5b1f17b1804b1-495158db293mr109153435e9.16.1784154625107;
        Wed, 15 Jul 2026 15:30:25 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:6d4f:b160:7aea:9d1b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49541e9ee07sm14791025e9.15.2026.07.15.15.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 15:30:24 -0700 (PDT)
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
Subject: [PATCH 2/3] PCI: rzg3s: Propagate platform_get_irq_byname() errors
Date: Wed, 15 Jul 2026 23:30:18 +0100
Message-ID: <20260715223019.3002237-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

platform_get_irq_byname() may return specific error codes such as
-EPROBE_DEFER, but rzg3s_pcie_init_irqdomain() replaces all failures
with -EINVAL.

This breaks probe deferral by preventing the driver core from retrying
probe once the interrupt provider becomes available.

Propagate the original error code instead.

Fixes: 7ef502fb35b28 ("PCI: Add Renesas RZ/G3S host controller driver")
Cc: stable@vger.kernel.org
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pci/controller/pcie-rzg3s-host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
index 01488660ab08..f51b5d7c1998 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -1019,7 +1019,7 @@ static int rzg3s_pcie_init_irqdomain(struct rzg3s_pcie_host *host)
 
 		irq = platform_get_irq_byname(pdev, irq_name);
 		if (irq < 0)
-			return dev_err_probe(dev, -EINVAL,
+			return dev_err_probe(dev, irq,
 					     "Failed to parse and map INT%c IRQ\n",
 					     'A' + i);
 
-- 
2.54.0

