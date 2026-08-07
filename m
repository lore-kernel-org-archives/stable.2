Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15CE4322E5;
	Fri,  7 Aug 2026 11:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786100902; cv=none; b=dvmNrvD9upsGuTdDNlkOw1hhz+KoFU2YvOpDlhR1KByb4hCNyA1uqubiul1gtCU8snj2YtrxOstoOLS4FqjpNpXV4WtogUmoXkQdNuf742r4CSeNrHlRwQ6f+xD6hqk7BKx/qoMZYhYOCnEH6M4YOaEDldVvE6De9eGDtZkEcDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786100902; c=relaxed/simple;
	bh=30w+kpGh9AnDjqMH4hZYwCCOGX/oL0j1bvmiA3bbbX8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d7N7C9Os//aSUUu1eClC2LSXR675V6/OPd2ujAfWi5/3OOQ3xnbwC8YCILu0Sci1Pd8LzFalqVFn07iEii/RJfUVQU/r5bJevIJoPbvQxi9Rpy51y3MRU7zHvCJVAPGvnGuOm+1xLALoR2OOk8gtDMiPKivxWco/RNNncnwn4To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CK2D6kEy; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CK2D6kEy"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 4C42C4E41138;
	Fri,  7 Aug 2026 11:08:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E0EC8603F0;
	Fri,  7 Aug 2026 11:08:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3C93C11C37643;
	Fri,  7 Aug 2026 13:08:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786100893; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=lPfb7vESp6jqo92rJ1VcUPSee+8qeHzCzuXzKQdueN4=;
	b=CK2D6kEyN5j+jTUWkUU4PdW6XlIhEFuj3Ot0RLqj59GUSF3d9ZJ6O7QokoCyKeZp9o2N2+
	I5216Ju7hGrLjOFgmGzATnk9lKK0vm4aFH8zdbLi11y2wr5LNm4VdkTq8WWjZCPgB7aIO2
	ZLCgNMzrzq7b47mQ/NAuMUhi2Zahi9YtBH0PqOpvh689BCnmtqhsbL2WYy5kQMktCVVxVF
	YPR63vdtTCB3VRCCJ2WoTBOV99IDKLe3j/ezhMORUO9wISjQKZkcPs6fOPT9dFxLrF/kyv
	uAQv0UaJGfOovo2bm28K8XT0LsikfvCxuY2iaq/LzQc0nPJLoFXHrdnw2q1sww==
From: "Diogo Ivo (Schneider Electric)" <diogo.ivo@bootlin.com>
Date: Fri, 07 Aug 2026 13:06:59 +0200
Subject: [PATCH v3 3/4] mmc: sdhci_am654: Clear ITAPDLY on tuning failure
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-am654-sdhci-v3-3-acc91d7d7e50@bootlin.com>
References: <20260807-am654-sdhci-v3-0-acc91d7d7e50@bootlin.com>
In-Reply-To: <20260807-am654-sdhci-v3-0-acc91d7d7e50@bootlin.com>
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>, 
 Faiz Abbas <faiz_abbas@ti.com>, Judith Mendez <jm@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Pascal EBERHARD <pascal.eberhard@se.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 "Diogo Ivo (Schneider Electric)" <diogo.ivo@bootlin.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2760; i=diogo.ivo@bootlin.com;
 h=from:subject:message-id; bh=30w+kpGh9AnDjqMH4hZYwCCOGX/oL0j1bvmiA3bbbX8=;
 b=owEBbQKS/ZANAwAKAQa+fFtWXslFAcsmYgBqdbyGDmYPlvTreHeSXJu3CBMcJO5quUb0RQBKZ
 ZhKJxnRDs6JAjMEAAEKAB0WIQTma35o1i1081e8B2UGvnxbVl7JRQUCanW8hgAKCRAGvnxbVl7J
 RbBED/9vqFR5CYwi8IGJY4JMj6gNzGU10N4iCWYR+zRTAptVSQvB5wUlbelBfDYsPxhe2qqVMRV
 E2EKuXwJ4sArXlCsthjCKS6iRqDOYpDoXrhQLVNoAvIi58MygwCsXTSmuAqWT2iEJCZnOadPM74
 aqchFOMVduym5uaCG0QYty5Lfuo61LJu/KOgnKNUYkgblPpAaTUyiyhqanXqO+fHH8Ja2Q8SxLC
 zkFdRWmzSbKXx/++22BDvhCA3oQmfpkKZpau/M/a2DhQ4JEEVmLZQETsnSiWo5bYQoUvjT3RyA2
 /b+NxoksldMKJ1J3nifjazvHxSKbWNYRm30B2ALuTPN9szVUV7QEdnRI6sI5CjM3SKYk3UzP9FP
 1dNha7oJWZY+otuMBla9xJzezP+hMVwcELDdWl1Q6oXgeebrUHWzIVf4NK7f/W+6lu70F+GNNqO
 0ax6b4hpr4J1ksdO78go0mgVZ+vD0frvp0PrFeD2R+9we7bykIgZNU4BRdOC4xOxUCDPrQ+A95f
 QwQ13jgV9u7Fbnfa8pMjFfB5BlZ5oDDq+oB48GghSMOcErULqs7pU1MwRzxfKNGVkFIXTFanKxl
 ApQeXBIG2epYXcpi61oGEdNgrwNoy4yfSV0xtuxq+N8IkPh15D8ZYIaFKzRknold/gnbnXMt49A
 gTEdd/vjw2+AQkQ==
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
Cc: stable@vger.kernel.org
Signed-off-by: Diogo Ivo (Schneider Electric) <diogo.ivo@bootlin.com>
Reviewed-by: Judith Mendez <jm@ti.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
Changes in v3:
 - Collect R-b from Judith and A-b from Adrian
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

