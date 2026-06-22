Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDFC390C85;
	Mon, 22 Jun 2026 16:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782144900; cv=none; b=teZZm47SOdRjQ0dPqi9rsuKVE3ZOF8sj3lT2uUjFd16wLbrc2+K0fTTbZYlR88BxOxQ2TJ7JDlW4PBwdsRvLFlANHPofX9J0yMWT3Y6AB2nDEAWdfqcIFZ6fExVtwVMFhDGhOrjKjkO1fEGmQPxyvAjrbimJEa8Ex+n5XLSeVBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782144900; c=relaxed/simple;
	bh=LHRMZYBTSc+/PwXbvymTS/Bzdt9N+vC03ty4d1foyTM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hGfrRsWNRcKepgIqRqeDET6kQ78nVrv5+VVcPhAoqUkMbZDmxk4XE0Y9eCqgsuOVAwmVEmPcGKd8qlhE+401F9ys2yoNhzXz+uhL19nNL5hba8Q/1K516UKdldKS6IJN34LCh+ia8q8UJaRZ5R/yx/xi1wdrRQasPX0O9KK0ImY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nHj2ksWh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aLYiuzJG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nHj2ksWh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aLYiuzJG"
Date: Mon, 22 Jun 2026 16:14:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782144897;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G6c75HylHVvssgHyLR+zBgZ+r5NDND4u4m1Xlc1vAbA=;
	b=nHj2ksWhDbE67GopzusX6s0eZVLHqtudPWarlQ7VpTKDap062NopRzFFqJU5NCDxkjiYJA
	Wuhv46UGJYEga0BlClTiwaN0MOPRUH2Ofhxh20iCfefP8IY27NcoItfH3dcY6BLBFHTX4r
	xOHYsLtIU1YnTrZskQf4qny03NjGG6/q7QUSbnt7alKMpwJujj7H6q2UukgtGGjvz+H6Nn
	Yq02ZtKcH8yaT3Hsg2G/k4vPmizmwqS98Uur5dK5OjuruN9IdnzDwCRXvtoWBZ7chStMga
	LS2O0hDW0lCN21VkMgCCCiCmYBFnz3y0HZM1MCzcO+i4b2+TIh5OgYlnzkv7kA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782144897;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G6c75HylHVvssgHyLR+zBgZ+r5NDND4u4m1Xlc1vAbA=;
	b=aLYiuzJGp9AwFrhTRu0JtOwE36PksqDqjxMfFJhlJkGgVC8bFI1Q+ghtRd/pCOzNENnZfG
	gWe+IuDmJdM9kNCw==
From: "tip-bot2 for Qingshuang Fu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/imgpdc: Fix resource leak, add missing
 chained handler cleanup on remove
Cc: Qingshuang Fu <fuqingshuang@kylinos.cn>, Thomas Gleixner <tglx@kernel.org>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 maz@kernel.org
In-Reply-To: <20260618021352.661773-1-fffsqian@163.com>
References: <20260618021352.661773-1-fffsqian@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178214489522.2745857.11575007289953235839.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     37738fdf2ab1e504d1c63ce5bc0aeb6452d8f057
Gitweb:        https://git.kernel.org/tip/37738fdf2ab1e504d1c63ce5bc0aeb6452d=
8f057
Author:        Qingshuang Fu <fuqingshuang@kylinos.cn>
AuthorDate:    Thu, 18 Jun 2026 10:13:52 +08:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Mon, 22 Jun 2026 18:09:56 +02:00

irqchip/imgpdc: Fix resource leak, add missing chained handler cleanup on rem=
ove

The driver allocates domain generic chips using
irq_alloc_domain_generic_chips() during probe and sets up chained
handlers using irq_set_chained_handler_and_data(). However, on driver
removal, the generic chips are not freed and the chained handlers are
not removed.

The generic chips remain on the global gc_list and may later be accessed by
generic interrupt chip suspend, resume, or shutdown callbacks after the
driver has been removed, potentially resulting in a use-after-free and
kernel crash.

The chained handlers that were installed in probe for peripheral and
syswake interrupts are also left dangling, which can lead to spurious
interrupts accessing freed memory.

Fix these issues by:

  - Setting IRQ_DOMAIN_FLAG_DESTROY_GC flag in domain->flags, so the
    core code automatically removes generic chips when irq_domain_remove()
    is called

  - Clearing all chained handlers with NULL in pdc_intc_remove()

Fixes: b6ef9161e43a ("irq-imgpdc: add ImgTec PDC irqchip driver")
Signed-off-by: Qingshuang Fu <fuqingshuang@kylinos.cn>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260618021352.661773-1-fffsqian@163.com
---
 drivers/irqchip/irq-imgpdc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/irqchip/irq-imgpdc.c b/drivers/irqchip/irq-imgpdc.c
index e9ef2f5..4feef4a 100644
--- a/drivers/irqchip/irq-imgpdc.c
+++ b/drivers/irqchip/irq-imgpdc.c
@@ -378,6 +378,7 @@ static int pdc_intc_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "cannot add IRQ domain\n");
 		return -ENOMEM;
 	}
+	priv->domain->flags |=3D IRQ_DOMAIN_FLAG_DESTROY_GC;
=20
 	/*
 	 * Set up 2 generic irq chips with 2 chip types.
@@ -465,6 +466,11 @@ static void pdc_intc_remove(struct platform_device *pdev)
 {
 	struct pdc_intc_priv *priv =3D platform_get_drvdata(pdev);
=20
+	for (unsigned int i =3D 0; i < priv->nr_perips; ++i)
+		irq_set_chained_handler_and_data(priv->perip_irqs[i], NULL, NULL);
+
+	irq_set_chained_handler_and_data(priv->syswake_irq, NULL, NULL);
+
 	irq_domain_remove(priv->domain);
 }
=20
