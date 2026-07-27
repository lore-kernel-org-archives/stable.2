Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3A63F482C
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 09:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785146332; cv=none; b=uOT9Y1f/O1vxRTMwS4GHQRLJcq52MKHUetkwnp2S2JlQNE57yJkltYw5EhmrqUYM3WkePXzHOqmXpqtHmrf3WFNHK2zQY5FV4ukptoNdPSSkoN3fuYCyRtRpB5XYk3rO5J9L/qOE0LsZUun8M2gWTxbcSkPBYsv1WzqIhYs9mMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785146332; c=relaxed/simple;
	bh=P8hhMpjNRcV983i+sVElYGEx+C0vxRqTLXjADo3LM18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n/+vi23of8NNK6WjmJGj1ddiQGnB+1ZvoxmozQvmRnN8Z/Kx51S9uZloypg+6fG3c2f/XPx4YQQnKMPUnyn25LUiGttZM/MXYr6B0IWNk/OPPERN4U3z/TlNw2vHyOOGOJ6Kj9XaaZvJi5gHwjogLQ7+3ebjfD1cXHy69s/W0ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VSAmokq+; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VSAmokq+"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-495757ccbc1so23185405e9.2
        for <stable@vger.kernel.org>; Mon, 27 Jul 2026 02:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785146329; x=1785751129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rn69u0s2jR5Lw99FVWM+6+oX2r8Pt4qR/LxAWSkmIyE=;
        b=VSAmokq+BUSEtKKzqX9nBr2dyGVOv6yLWya3EYkIv6KJBnK46wkxy8Xa3J2U4BKuM7
         +ASU3mWyb/wBs4LkHETY1tDXhRiiYJ0kEW9r2Vlb/X7aukXXaE8Q6vsi8nK0E5ht8c2l
         hNVFIF9hzuxHPGPQpxh1x3XejO9dNzBA6Rx7ApbEZ0uVZnZAi6nWX1GlKNCfO/eHoA4b
         gIsWeimTghl3aq4YSqzoiSbxPdWT0V0/CBzVCk4JBH6rRHH3/KcOxi7lQVd28HUvV36b
         pnqJTc+8SfcgNuXeA74wEGJ/82oQhLnVEHQBJ4N2rqVr8QCNHX0gB+S96oQs5E8CJxLJ
         anRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785146329; x=1785751129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rn69u0s2jR5Lw99FVWM+6+oX2r8Pt4qR/LxAWSkmIyE=;
        b=slwboPwug5Fo/toXVg4njU/xrrvD442n7VQBLOcURdZpxZmxYMLfDLr7r0p1LVy1Lx
         OKGpU3VbLk6epMT6O8QoRbBrcZnBaiRs2wAOjqFrOJk7s8PkjfmwDuhPOu35YwsFYumh
         h0+tw79WAkF9CLaN3g4Qtl7YnBM+0wYQ2UtnPeQs9LjHzGFz0lqfYF4agCzF1qZceXWh
         u/dCDV3c/CXAMwbkWzHSB99nRMtpS/Rfq6mWPxXucRXt1LTeN0xXyQyFjO5nReu/8Bkr
         JNdj8Z7TWfNUI6FL73NKT/zZXItNPb0tvWjyP2jgzuNUMgWR8JQX+h4FHYNoFcEtr9BL
         aGFA==
X-Forwarded-Encrypted: i=1; AHgh+RqNbl7F8Q332rFoGIaIaie8ioYNhFyUJIMww8wTCA+LTRElT4M/vZPqRSOI17eIVEXspJX9zdw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP0vj76gHejFC1elWsIhRXEmVyxQy+hItK5S0RZO2v3nIjNjwq
	PuN9yzlN9Fy6iXIZlcooEJiw1bAR4gjZBUNXiT1EM4+b99g/LnsbAVJ2
X-Gm-Gg: AR+sD11lwd045wSfehicJ9rZVUf0PrShy3Y8rwzWYzWN+baun6w7IHYXQyG6wCyJNH1
	UcMaOZS3tpPNds/jA2vkgEbjL8w33WJOT0HPeCYfTFplt1Q8xeGx4Itm5p76B3peAuE7mGrQNTH
	3HQR8QC54EcbcZs0LGT3VCd4S2a7iAngx68Q25JVrA2URdb9iv9xcYwN5kvZxeD1CwrZ3kgPRCy
	pPdR4N1DmDOBg4SzBSEBLrkb78PWtZ68tByVBIA1LPPKG4sJQoVe8Kc+FYLYcDMnjAs6kq+6pp+
	JcPw/CBKhk3tEJSiIl5bsm6oUFyMqbTDvo4JNr8+3HdDyYoOq9NUMuMOGQsdgqzocZcTocCxDvM
	MH2Jixu3aSsv3Et76lGXv+Qm59AbnNZOKMrUxwtkqx6GaBfzJ2qEpHL5ZqYXD07CewmoV5k5Gqt
	gw2KaOx2ydfm2xHFs6k2lzzmFS2DKjF0Lwy7yrMc2J1o692fAhcSAXH2gx7avBqJUehyY6+1NpW
	mOvsNIgzyYPN/+m
X-Received: by 2002:a05:600c:1906:b0:495:3a52:cd7e with SMTP id 5b1f17b1804b1-496b5700144mr111700305e9.25.1785146329053;
        Mon, 27 Jul 2026 02:58:49 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:8281:5343:33a3:cac0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957b842691sm238346295e9.1.2026.07.27.02.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 02:58:48 -0700 (PDT)
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
Subject: [PATCH v2 2/3] PCI: rzg3s: Propagate platform_get_irq_byname() errors
Date: Mon, 27 Jul 2026 10:58:42 +0100
Message-ID: <20260727095843.116950-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

platform_get_irq_byname() may return specific error codes such as
-EPROBE_DEFER, but rzg3s_pcie_init_irqdomain() replaces all failures
with -EINVAL.

This breaks probe deferral by preventing the driver core from retrying
probe once the interrupt provider becomes available.

Propagate the original error code instead.

Fixes: 7ef502fb35b28 ("PCI: Add Renesas RZ/G3S host controller driver")
Cc: stable@vger.kernel.org
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
v1->v2:
- Added RB tag
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

