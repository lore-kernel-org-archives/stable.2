Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D9C3B1029
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 19:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790970493; cv=none; b=WB2iyTg3kHEYDgv0LE/7bxXMEt1iToi0Vj6cCOqnKOx3CbHv9stcHIU5gxTN4MbwSule6z+nw79oGDnSKQu79ae9jqIj4SUCtXQouUMeCS6SCU9z4ichC4WBBmWI5X8wFUfch+miBu7BwoqakHSV3rIbt44FKEiBPTrO9QZWicE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790970493; c=relaxed/simple;
	bh=dVHeydcT8I94oZOxgJEEny4BX9c3MRfQNn+UjmvQxaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vB4YYeMvvub9dnGL4WB/WjQzTkPbOBmxk11+cBOkfiYn43e8ztS/nlfOwRMsEedjH4NVUsUajGyEtA1Mco88keC8/noV40ys5vbmDlw2eW5ElcE0iJ9XTmpFR85DnUpjBX2mvOZj2OkiPtmrdDSqaMf6+LSrqo7lsnUa6KvUNCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=apYaozun; arc=none smtp.client-ip=74.125.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="apYaozun"
Received: by mail-qk2-f43.google.com with SMTP id af79cd13be357-93caa7d3af4so314523585a.2
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 12:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790970489; x=1791575289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KZEY2KuFMnZ9k0uAKqAQRBac5uCnzYVHzYqMLMLbH1Y=;
        b=apYaozuncCEUWpAczKzJQLjo8K6ktDjhW1ZL1TltGhD1dg5I083pdjMlJFJvIcEwF8
         B6aoO8owOzMPBTBX1N+SxEKQPkumr3oNCVs/W5h+kdi35JAkHrba03LoX+iHiy82NXPa
         yDxYXBjuY6SELBR7LwIEI2JLF5s0PIHkvBGASCeM6MKNdlMgvRgzbt87HXW94e+NXL43
         OX06hWBd0Qu4gUEGoSV45b321jBWUnGdpLVx4RBUo78Q/fb3DbVMlbd8pF1S5COsFveg
         qSjRq/mBGgI/o1cy3jffbFvCqFYzV3jgHkTI3fJtylOBdBhjY4EXQGuTAILUH4KA5lxy
         WH6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790970489; x=1791575289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KZEY2KuFMnZ9k0uAKqAQRBac5uCnzYVHzYqMLMLbH1Y=;
        b=K5TtTWPD/3L5oJzeXA+Rd59XU2yRmVcdYCeVw0jhjzSers6pswtxSOruzyzWmfOo9R
         F7V4oZ2ShPYWWclyemyWskdEiJ7HEXo9q8fAPZQGGsSWjGpr8kJu89noMa7GvsD8Ni8D
         ptAJH3GHAtgQJy3/9PFuvV3mvuuEE7vkqUX4hhNi+cDNdmvHF+7R3llOjnXvHWlN4bst
         qEz9Um1YVp54QDT4NyRr4OK1KJuizliuQImnSWKQicgHa7LrmD0JMGsA0Zq+PYqrYVMA
         CB7QV0knjdsLbqMDqL4ZRCRmpUcvOWfv4jm4QvJJ/ZngYqEuobRNZqYJPQRwJjbdIvSz
         cqIQ==
X-Forwarded-Encrypted: i=1; AKwUvBzirwRzyQS7wKd5onHps8UxCjuowWaxY+QCnciSJvI8X1ce7q313mnPR2H6V7HKJ+FyLy4Xhg4=@vger.kernel.org
X-Gm-Message-State: AFuF++lvg/EFynh6bGP1e35hsjUP3rgM/UeLkAA2FApDhu9+e/esZQOV
	QBncHivmfvf4rBEudIwryjudvLzt1zX7nM2xb0sYwl4gNuZZl6Frck4=
X-Gm-Gg: AYBFou1wWoDNtw0YZQbYuc+WAShBHRevZAHaEwsLZI3OKlT3GDaUoUe8mVb1MTYrVJv
	x2+YuBbDp7vVH7fTRgHWBExE+cseJLw4NPyXwNR8O13jFLcK7hL0k6yXwQDC42fgk+FceEiw8Zi
	MnkTV4Wxz1spbe6RWiaTOA3f5Si6wHDxVZVjoCozs/SJIS2XkL29zoeMwk6vs54TK8k8Jk7ruWx
	JDgvKScsBQTYW/k7YnOjJKllEQX/Nssj691p0xqEtNqWdJ1VhYXA8P1PLkLXDUhss5uho/SmUPw
	0CDQLu/cwZtpP3IEGTUEJGN6oD27HvB0sU09AjPqRtkPMVJFCkqsYbPGRGJVzaz0jO5cPtn6uch
	rHqnPpMrYJkd5mUOK4Oc4OnguKuMBQvTDLK0CTQuC51lLAg3nhKsgzFs+D2O6GF4wPkDiBiN/jT
	0iH/xQyFe0x8G09bj/MhPFx1uUDqzE75ZWmFthgelnGzr6NB4x9y7WCGPyY7s4kjck22KI31kbG
	zROKcpRQC5DE07+ba4NicS5iuiYvnvjDYgYmpMwY+hZTu9CWTno5PYZChRuHIy2I6t9wiV67lri
	nalx/DziFa2kS6tRg0hfj9ckBuTs3Fg4T5GCOL4=
X-Received: by 2002:a05:620a:1a24:b0:93c:ab1c:fc2 with SMTP id af79cd13be357-93cf18b1773mr713989785a.33.1790970488621;
        Fri, 02 Oct 2026 12:48:08 -0700 (PDT)
Received: from i4-gl-tmk5904-1.ad.psu.edu ([130.203.156.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93cca2ed5e2sm296846985a.47.2026.10.02.12.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 12:48:07 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Christophe Leroy <chleroy@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	Ijae Kim <ae878000@gmail.com>,
	mhun512@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] soc: fsl: dpio: Free the IRQ before releasing the I/O object
Date: Fri,  2 Oct 2026 15:48:02 -0400
Message-ID: <20261002194802.375497-3-mhun512@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261002194802.375497-1-mhun512@gmail.com>
References: <20261002194802.375497-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DPIO interrupt handler accesses priv->io, but dpaa2_dpio_remove()
releases that object before tearing down the interrupts. The IRQ was
requested with devm_request_irq(), and unregister_dpio_irq_handlers()
only clears its affinity hint. fsl_mc_free_irqs() returns IRQ resources
to the MC resource pool without freeing the handler. An interrupt can
therefore access the freed I/O object before devres releases the IRQ.

Explicitly free the managed IRQ in unregister_dpio_irq_handlers() before
returning its resource to the pool, and perform IRQ teardown before
releasing the I/O object. This also waits for an in-flight handler while
the object is still valid.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: 993fec7e11ca ("bus: fsl-mc: dpio: add the DPAA2 DPIO object driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
Changes in v2:
- Move devm_free_irq() into unregister_dpio_irq_handlers(), as suggested
  by Ioana Ciornei, to keep IRQ registration and unregistration in sync.
- Base this patch on the probe cleanup fix in patch 1, which removes the
  unregister call from the probe error path.
- Add Cc: stable@vger.kernel.org.

 drivers/soc/fsl/dpio/dpio-driver.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/fsl/dpio/dpio-driver.c b/drivers/soc/fsl/dpio/dpio-driver.c
index 8d31346..d8f28fb 100644
--- a/drivers/soc/fsl/dpio/dpio-driver.c
+++ b/drivers/soc/fsl/dpio/dpio-driver.c
@@ -88,6 +88,7 @@ static void unregister_dpio_irq_handlers(struct fsl_mc_device *dpio_dev)
 
 	/* clear the affinity hint */
 	irq_set_affinity_hint(irq->virq, NULL);
+	devm_free_irq(&dpio_dev->dev, irq->virq, &dpio_dev->dev);
 }
 
 static int register_dpio_irq_handlers(struct fsl_mc_device *dpio_dev, int cpu)
@@ -276,10 +277,10 @@ static void dpaa2_dpio_remove(struct fsl_mc_device *dpio_dev)
 	priv = dev_get_drvdata(dev);
 	cpu = dpaa2_io_get_cpu(priv->io);
 
-	dpaa2_io_down(priv->io);
-
 	dpio_teardown_irqs(dpio_dev);
 
+	dpaa2_io_down(priv->io);
+
 	cpumask_set_cpu(cpu, cpus_unused_mask);
 
 	err = dpio_open(dpio_dev->mc_io, 0, dpio_dev->obj_desc.id,
-- 
2.53.0

