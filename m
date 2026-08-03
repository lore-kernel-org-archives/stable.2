Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE8F4137BC;
	Mon,  3 Aug 2026 13:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785764924; cv=none; b=pkjvEiSCWLYP1dVxBTysR/Ob6qQmMMyDawwLLdeKZ87U5m4Cf3ApDso4MflrL2id1nLgbUl7i5pHPkkx28a/r6QFqq5HW0jI0AxYpyu9TbVjBSq/IoRa26PZcQRBzdQ6+YuNH4UMIB6BjdLNXrNofTm/5EoiF1//+S7aLbIaBCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785764924; c=relaxed/simple;
	bh=0u5xWPN4ZdyJWXeSBzxweANkC3ya7SX+Do0ONa+hznA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ioZTtWNgaGlFDDexhetjaYV+gMYh+FV9ba5DF0xhKXpAVY4ZNxUOJaTdS8ao1zja6gruGpWucV5OXCJT2cvLTXhDMLJ8IjdE2wlaqtX1dg8h3FYD8cPij/4/BzFufBMFp2W+1s7CUpDm8SHfEIk6aom03AEwz2iQfrB+mwsiG58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MBnWuyRt; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MBnWuyRt"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 08E281A13D5;
	Mon,  3 Aug 2026 13:48:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CB6BC6029B;
	Mon,  3 Aug 2026 13:48:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2C92511C30CEE;
	Mon,  3 Aug 2026 15:48:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785764914; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=IpVD2kPko+0nHO0HXCDq6LiAOZ8sFT9utJYoi7KDyTE=;
	b=MBnWuyRtTM3qSG+OmvZ1BwItX4sHQGUm/bO2vtb6YMbd+Z0LuOz7MSFdCPNiXVN2zHPYvG
	fmLfA2JtFvQs7cHSGolLUCfxX54aIYWfAvAlCyPvTizr4jDyCyX8FkrULH7qDSpcu6Q15h
	GJxQzWeIc4+6AuZueIaD/oBkvTb1o/TNV+KlA4HK1iHldOPm1+FvOue+CTC98OUrgChVOw
	nIn0hAdOIhuVYaB2d32yLAPT3atN1kEs+9FaMM3OzA4x3Tw09TYkg8GWrOmcr+1wwAxnQp
	M+fvb9+h1GOucnjLb759CEMVcZpaHUjKYqhmOUc0sIF+P2WeUouigCy0THCVNA==
From: "Diogo Ivo (Schneider Electric)" <diogo.ivo@bootlin.com>
Date: Mon, 03 Aug 2026 15:47:33 +0200
Subject: [PATCH v2 3/4] mmc: sdhci_am654: Clear ITAPDLY on tuning failure
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-am654-sdhci-v2-3-a5ee5be86133@bootlin.com>
References: <20260803-am654-sdhci-v2-0-a5ee5be86133@bootlin.com>
In-Reply-To: <20260803-am654-sdhci-v2-0-a5ee5be86133@bootlin.com>
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>, 
 Faiz Abbas <faiz_abbas@ti.com>, Judith Mendez <jm@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Pascal EBERHARD <pascal.eberhard@se.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 "Diogo Ivo (Schneider Electric)" <diogo.ivo@bootlin.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2607; i=diogo.ivo@bootlin.com;
 h=from:subject:message-id; bh=0u5xWPN4ZdyJWXeSBzxweANkC3ya7SX+Do0ONa+hznA=;
 b=owEBbQKS/ZANAwAKAQa+fFtWXslFAcsmYgBqcJwrUFIuDAJGfqhfZdm2aPT4VkvB8WoP6N6La
 dLaxIRhSyeJAjMEAAEKAB0WIQTma35o1i1081e8B2UGvnxbVl7JRQUCanCcKwAKCRAGvnxbVl7J
 RdSLEACHViKchOQOCgDqdScgyy3JnRYaVcyLu/GgdpCdohXigfH0zEMiNsor2oyMN7ySxNNYL8o
 5vQwQhHLxme3GoJbPn84DsQ3LM2vriQ2Epm8aZtgT2c1AVE8UchlslOjS9tMGyHM5eQr+1lBTF+
 Lf+71tIgnreWZsyQGnAuR25ZvWDUMp3owXoBS6YBTJxv1cm6Z8yFBDympyscgpyuGUmf6xYnr9M
 BedWmQvdYLNM66qfM3ulDCNSHFlCACETjrJKtjS8kY9ixjrKdMWyd/z1Gn2mzsVfOp8SkDHR2fy
 6c75mUtK3BjExWeVslsOElc7fY1/5CNLvBey2KFoLM4VIYPq7Xxh+aOCXQixbgbsn8cH7RA5LE9
 1UESJzRfNND2b3d8O4o5Km5avSU5QBwtPNjY8GxDkSJsCPJytuGERoQW+USq7g+0qfEu79BLLjL
 fAcqxt2N13oWMk0jBe+7RQabR16sJz0QchZJmRdKz1z98hEDdJ1HBnZR1snA1xOZYLP80sjsykJ
 hZokjWN/IGKytJ/Pv5Zo8yCZU+EAAZQDl5U43QeKG5vqeJUMv0SRMQzdlLMALauFvkSRJKoc7l4
 lKRi8L/xE5lbfN3nP/MmIWN5mdWd5a/ne7LKuDQA8J8zrYqJPxGUJhVPTftGyT5Uo1Wp+hfLhk9
 GUwmtZul3kKrzzw==
X-Developer-Key: i=diogo.ivo@bootlin.com; a=openpgp;
 fpr=E66B7E68D62D74F357BC076506BE7C5B565EC945
X-Last-TLS-Session-Version: TLSv1.3

When tuning fails, stale ITAPDLY values can persist and interfere with
subsequent I/O accesses, for example in DDR50 mode in cards with no tuning
support. Move the ITAPDLY enable setting out of the tuning loop to after
successful tuning, and explicitly clear ITAPDLY (delay and enable) when
tuning fails so that we are sure only working values are actually left in
hardware.

Fixes: 901d16e46296 ("mmc: sdhci_am654: Add retry tuning")
Cc: <stable@vger.kernel.org>
Signed-off-by: Diogo Ivo (Schneider Electric) <diogo.ivo@bootlin.com>
---
Changes in v2:
 - As suggested by Sashiko clear the values in itap_del_sel[] and itap_del_ena[]
   so that they agree with what is written in HW and subsequent runtime_suspend()
   and runtime_resume() can never write stale values.
 - Remove now unused timing variable
---
 drivers/mmc/host/sdhci_am654.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index 0db587e702ac..8ce10422bba0 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -527,7 +527,6 @@ static int sdhci_am654_do_tuning(struct sdhci_host *host,
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
-	unsigned char timing = host->mmc->ios.timing;
 	struct window fail_window[ITAPDLY_LENGTH];
 	struct device *dev = mmc_dev(host->mmc);
 	u8 curr_pass, itap;
@@ -536,11 +535,8 @@ static int sdhci_am654_do_tuning(struct sdhci_host *host,
 
 	memset(fail_window, 0, sizeof(fail_window));
 
-	/* Enable ITAPDLY */
-	sdhci_am654->itap_del_ena[timing] = 0x1;
-
 	for (itap = 0; itap < ITAPDLY_LENGTH; itap++) {
-		sdhci_am654_write_itapdly(sdhci_am654, itap, sdhci_am654->itap_del_ena[timing]);
+		sdhci_am654_write_itapdly(sdhci_am654, itap, 0x1);
 
 		curr_pass = !mmc_send_tuning(host->mmc, opcode, NULL);
 
@@ -584,10 +580,16 @@ static int sdhci_am654_platform_execute_tuning(struct sdhci_host *host,
 
 	if (itapdly < 0) {
 		dev_err(dev, "Failed to find itapdly, fail tuning\n");
+		sdhci_am654_write_itapdly(sdhci_am654, 0, 0);
+		sdhci_am654->itap_del_ena[timing] = 0;
+		sdhci_am654->itap_del_sel[timing] = 0;
 		return -1;
 	}
 
 	dev_dbg(dev, "Passed tuning, final itapdly=%d\n", itapdly);
+
+	/* Enable ITAPDLY */
+	sdhci_am654->itap_del_ena[timing] = 0x1;
 	sdhci_am654_write_itapdly(sdhci_am654, itapdly, sdhci_am654->itap_del_ena[timing]);
 	/* Save ITAPDLY */
 	sdhci_am654->itap_del_sel[timing] = itapdly;

-- 
2.55.0

