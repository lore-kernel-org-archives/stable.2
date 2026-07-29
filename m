Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2E048094D
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 12:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785328102; cv=none; b=UG/ZQFkUWDThi4L42pSbvPzMGzizeO8tj5k8ELEc3pEymRjZ3m/7ghn/swahS+iR2r6Z/8Ke1y3gvTkN3dTt9RLvFWLh9QMz9mMctcIkXQ+cVtgJpjdIiCOUhBVFJTwUqeSOXuGDxQDLTyuyvsZie4e4jZBdl4BO4XIUgQJPMbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785328102; c=relaxed/simple;
	bh=OaQECTvq8DlTEMy7Li4rKqrFc0cNFuieTzFENUed5L0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d6twiK25x3g6cA+ZtRXEFLiPXJ8J2Vl40U3IAXZ66aWjKwUpWJx1bz68Zz3quhlyAerkccSP4sIcs0bdx6NIQNnNacVRaiBQhSBGewV0GGd7f7pkQ3mpd/JvinSRgq1x0dQRL1+vTmJUfbZBurBdVGrM9VEZm22d9HF2NC9fA+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=wG4JY0gi; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="wG4JY0gi"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id A42911A1302;
	Wed, 29 Jul 2026 12:28:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 796506039A;
	Wed, 29 Jul 2026 12:28:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 51C6411C14DBC;
	Wed, 29 Jul 2026 14:28:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785328090; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ly0Na/ui4PywvObFlStWP4jBCuUGyGQnyCh8Cv9fak0=;
	b=wG4JY0giOkyFHGo3Z2UYZ17RfOk6KQIdPUXLvsuuoXsZs9M6ghO1/EEC2wKdc9Z5RysmnJ
	wHavKdGF1JXVr5q4Hs092wWJL/V+jc3jVKZAeYKkxai/nAID6ncueYtikk6R01tF9BdiMs
	Rcx4B92UmtE0psvT9fQYemx2yGJ7X+Zkb+Y+UH3UgqMBDv/8gj65YPv6vCDePT/yx4Yliv
	oN9uo9HRZhRzd6FvKZB9c2D7ehpKManUWVDHWY80dt7/sG/euQFqxsTb4W/sw5A4k6tOlN
	YSOJfmLHDeh3gp7XcrgjN3yqsNqo08DNT1XzNnnTKfX+cMZLJaixeR8/KM4kRg==
From: "Diogo Ivo (Schneider Electric)" <diogo.ivo@bootlin.com>
Date: Wed, 29 Jul 2026 14:25:43 +0200
Subject: [PATCH 2/3] mmc: sdhci_am654: Clear ITAPDLY on tuning failure
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-am654-sdhci-v1-2-7568108e4b9a@bootlin.com>
References: <20260729-am654-sdhci-v1-0-7568108e4b9a@bootlin.com>
In-Reply-To: <20260729-am654-sdhci-v1-0-7568108e4b9a@bootlin.com>
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>, 
 Faiz Abbas <faiz_abbas@ti.com>, Judith Mendez <jm@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Pascal EBERHARD <pascal.eberhard@se.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 "Diogo Ivo (Schneider Electric)" <diogo.ivo@bootlin.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1899; i=diogo.ivo@bootlin.com;
 h=from:subject:message-id; bh=OaQECTvq8DlTEMy7Li4rKqrFc0cNFuieTzFENUed5L0=;
 b=owEBbQKS/ZANAwAKAQa+fFtWXslFAcsmYgBqafHP8ZXrfyE2Vd+HyEWgAQUXRX+w6LF3TbSQC
 pVXFt6Z8cSJAjMEAAEKAB0WIQTma35o1i1081e8B2UGvnxbVl7JRQUCamnxzwAKCRAGvnxbVl7J
 RcdyD/0dASDaJZZSh7icCbAWDLNMgQus9/aPqxKksW4hYcXxM+CL9PUOGFPG+aVcaJHY/uWecA6
 JhGUNf04KtvPKuCM2DDA08HIW1h17QTJFQKoxT7prJsLt8b/pFWGyL1TTd8g1vTNO4PndOihTY0
 ZtfGpIbZKynI3J5xXioW07RjHTM4r/tER/gk/2NsPbpsMCFGVGYQulENYBVcl0y+v6Q+/Msoitk
 td5ohbf/QY71B0hoqxOmPgWXPwFrYz1lQevvSBhJsip/9jRvrUN9Kj5VcEpFOranF+T5eDZ0XTS
 km139v4KBAX+Kcv2M4GhmtcCXKWp3z/x1WCnfdi7HzjhN7VE5E/Vz3aWYePyU0tngTFm1vCA5t/
 DSembX8AHlAxzjSEBdKLvuQH8CRMt0+FwUHrA8qvT0JCYHaLe/EjESC9Oli9yX/+SORHVxAWhCZ
 2pBQdQ5TeR85yg3ntBaeawvj8teL852K2OjL14cI+i1LrtqHo9YM+06Klg/Bo+UI6lZR6gsyM1Z
 vkRYjk3NGB6jBhGP8iMMEt4eIZWc0mfUiaLJ6wrvcDr/7MlPTXYg4ODschFwxCL+F5N2Ten0kIs
 MTRT6DBYc/w21sDrApLFnrNQhFuh3k0QUJLDxFexEiKrvxrum/d9XNpw7t3Wt+ysyMxSJm06JlB
 +KtDv3iTTencpiw==
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
 drivers/mmc/host/sdhci_am654.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index f76aab7e3a16..806544db0128 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -537,11 +537,8 @@ static int sdhci_am654_do_tuning(struct sdhci_host *host,
 
 	memset(fail_window, 0, sizeof(fail_window));
 
-	/* Enable ITAPDLY */
-	sdhci_am654->itap_del_ena[timing] = 0x1;
-
 	for (itap = 0; itap < ITAPDLY_LENGTH; itap++) {
-		sdhci_am654_write_itapdly(sdhci_am654, itap, sdhci_am654->itap_del_ena[timing]);
+		sdhci_am654_write_itapdly(sdhci_am654, itap, 0x1);
 
 		curr_pass = !mmc_send_tuning(host->mmc, opcode, NULL);
 
@@ -584,10 +581,15 @@ static int sdhci_am654_platform_execute_tuning(struct sdhci_host *host,
 
 	if (itapdly < 0) {
 		dev_err(dev, "Failed to find itapdly, fail tuning\n");
+		/* Explicitly clear ITAPDLY */
+		sdhci_am654_write_itapdly(sdhci_am654, 0, 0);
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

