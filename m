Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D1F420E71;
	Mon,  3 Aug 2026 13:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785764925; cv=none; b=IBg3iRtfcBMSNBbbxQcevhdUZm6H64awEa4v5+nxRwWWq4RuBAvnpOo7ECWPlcFwMGSeQ+JQmei9YQT5T/Y2bKDxv4ErFAY+j1qceoqs+HgPsGxbENAzvENDyKP8szg2464mny8z3vYwDBYWg8cAuNysMru5zWqqHCiTqWa47Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785764925; c=relaxed/simple;
	bh=lT+JEV0aFEKxlgkKQDL+bPnIS/8E0YX9GtsEONosqbE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wed0/3rDNEXkuu8Y/8un3FKduG070NblJM69EK2hc3LUL3TfHpm6RnHVckPC7xtQPLEe2L6PeCFuyqZsbMj4Oc/Il6eBIWhHGTV8jRBjJ3N9u2frroxkom/hUpF5mVlzy2dHCfOuIYWIGHhxCdc/4gLMRaHontVhcdNqoL0Ng/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=u87MwDiA; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="u87MwDiA"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id AC74D4E410C0;
	Mon,  3 Aug 2026 13:48:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7A6336029B;
	Mon,  3 Aug 2026 13:48:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 881E711C30CE9;
	Mon,  3 Aug 2026 15:48:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785764915; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=/I3qV8RwQ6dz6kYeEH/ASz1b7/s47uUjXDhMGIZri18=;
	b=u87MwDiAu2esZx4A5OE0VkYuOMhP7oFrsMDlMavWx4WHHytAhEWgWCL/7RizoVhWqCp3tt
	7mxg0SEbs6JiLpczqFY0rVZTOCwTqX3fJi7aftwaXo968LA5JSXEerY6Ty9MR0XXd/Vpvk
	BdEfYCBtc/LfqXS6NkjZrJ+kXHX6Yns5n3ZrvFfAVIPRkJJC9YsSGg+KqHUC0MBnd/2Lg7
	5ZxBtWetDHo6oLYsTtmfEpIgGv2c1ljcJ7+av/ajXSQDJQC/lEjOUdtaY2vBOm78RQ8cIO
	zAWzM0HkPTzSbjUO2knBjugzJCgMG7lDnkCGzr8Z+JJ7ODUJp9q3SmXCXCemjA==
From: "Diogo Ivo (Schneider Electric)" <diogo.ivo@bootlin.com>
Date: Mon, 03 Aug 2026 15:47:34 +0200
Subject: [PATCH v2 4/4] mmc: sdhci_am654: Fallback to DT-provided itap
 delay on DDR50 tuning failure
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-am654-sdhci-v2-4-a5ee5be86133@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2965; i=diogo.ivo@bootlin.com;
 h=from:subject:message-id; bh=lT+JEV0aFEKxlgkKQDL+bPnIS/8E0YX9GtsEONosqbE=;
 b=owEBbQKS/ZANAwAKAQa+fFtWXslFAcsmYgBqcJwrjEEtYYtxm8RYVAFN64Io/5dCXwPevUzQ3
 qnQJ/FmplyJAjMEAAEKAB0WIQTma35o1i1081e8B2UGvnxbVl7JRQUCanCcKwAKCRAGvnxbVl7J
 RWHzD/4jgRqpP6bdFGHzVxGun+a+5hLMIEtP9Exoq5oCt2rnJjuDKEynT1IgtzpejT01TijSMoN
 xrzyXUxZhOL+RiIth4j4+Zzg1z9JY2KuYrSCFGLfZGLkWWM2fkX6krcOKNNnUyHZyZpU0P7/mRY
 hgvi+QcIE415/7+1r+hGWAdeeXimnPmXXURfVMneDJw4FZevjqSP5A8froqFCXRQ78PM67TvTkn
 d6jUCitF3arduHzvfBzlz35H3HXa6pdo8TgnXGEfD9SA33FGo8KpblZXVI80p8oyBtqyK83wpsK
 wfWABpyk+jBi+ykJ5c5+RX48OKm8vox8bfz6Ma4bAVXm/zC1v+ptI9Vn8V+KI6yqk6WyrwCDsmD
 fbVQzoRGUCpEtbRa4yo9pIVCGTL3IVYekcAPX5BI6ATUX6cUIykTUysA286PH3nm7G5+3gAaEXN
 0MgeQK0yvnbGgfIIPiX3Js4gHfc1kcN3S7BaNvqu6W9Zjs7x5/LjvJ6jCzpy9nTzAQ8M9UhmSqA
 7U09OqpDjfc95cFaTURSk2SlxCr08CpuoxiZjgT5p/jreDlawbnEMYHaetrvd8vkA5xN0KhfeX6
 /EY1KVXSvI8N2ebHUL5wJxdVaC8CyS3f3H0loTXqh/OKmCC8TS7hd09kPgbBnLFvPUn1GsvBaHL
 Z922Ngc1fNXYsjQ==
X-Developer-Key: i=diogo.ivo@bootlin.com; a=openpgp;
 fpr=E66B7E68D62D74F357BC076506BE7C5B565EC945
X-Last-TLS-Session-Version: TLSv1.3

DDR50 mode is not required to support the tuning command CMD19, meaning
that calibration may fail on cards that do not implement it, in which
case a known-good itap delay value should be programmed into the host
controller.

Do this by reading the (already defined) itap delay DT property for DDR50
and, if tuning fails for this mode, fall back to the DT-provided itap delay
value. If the DT does not provide a value for DDR50 fallback then this
simply disables using itapdly.

Fixes: 901d16e46296 ("mmc: sdhci_am654: Add retry tuning")
Cc: <stable@vger.kernel.org>
Signed-off-by: Diogo Ivo (Schneider Electric) <diogo.ivo@bootlin.com>
---
Changes in v2:
 - As suggested by Sashiko save values read from DT for DDR50 in separate
   variables in order to keep them across multiple tuning cycles without
   overwriting them.
---
 drivers/mmc/host/sdhci_am654.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index 8ce10422bba0..27ef79420eba 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -126,7 +126,7 @@ static const struct timing_data td[] = {
 				   NULL,
 				   MMC_CAP_UHS_SDR104},
 	[MMC_TIMING_UHS_DDR50]	= {"ti,otap-del-sel-ddr50",
-				   NULL,
+				   "ti,itap-del-sel-ddr50",
 				   MMC_CAP_UHS_DDR50},
 	[MMC_TIMING_MMC_DDR52]	= {"ti,otap-del-sel-ddr52",
 				   "ti,itap-del-sel-ddr52",
@@ -144,6 +144,8 @@ struct sdhci_am654_data {
 	u32 otap_del_sel[ARRAY_SIZE(td)];
 	u32 itap_del_sel[ARRAY_SIZE(td)];
 	u32 itap_del_ena[ARRAY_SIZE(td)];
+	u32 itap_del_sel_dt_ddr50;
+	u32 itap_del_ena_dt_ddr50;
 	int clkbuf_sel;
 	int trm_icp;
 	int drv_strength;
@@ -579,10 +581,18 @@ static int sdhci_am654_platform_execute_tuning(struct sdhci_host *host,
 	} while (++tuning_loop < RETRY_TUNING_MAX);
 
 	if (itapdly < 0) {
-		dev_err(dev, "Failed to find itapdly, fail tuning\n");
-		sdhci_am654_write_itapdly(sdhci_am654, 0, 0);
-		sdhci_am654->itap_del_ena[timing] = 0;
-		sdhci_am654->itap_del_sel[timing] = 0;
+		if (timing == MMC_TIMING_UHS_DDR50) {
+			sdhci_am654->itap_del_sel[timing] = sdhci_am654->itap_del_sel_dt_ddr50;
+			sdhci_am654->itap_del_ena[timing] = sdhci_am654->itap_del_ena_dt_ddr50;
+		} else {
+			dev_err(dev, "Failed to find itapdly, fail tuning\n");
+			sdhci_am654->itap_del_ena[timing] = 0;
+			sdhci_am654->itap_del_sel[timing] = 0;
+		}
+
+		sdhci_am654_write_itapdly(sdhci_am654,
+					  sdhci_am654->itap_del_sel[timing],
+					  sdhci_am654->itap_del_ena[timing]);
 		return -1;
 	}
 
@@ -758,6 +768,11 @@ static int sdhci_am654_get_otap_delay(struct sdhci_host *host,
 		}
 	}
 
+	sdhci_am654->itap_del_sel_dt_ddr50 =
+		sdhci_am654->itap_del_sel[MMC_TIMING_UHS_DDR50];
+	sdhci_am654->itap_del_ena_dt_ddr50 =
+		sdhci_am654->itap_del_ena[MMC_TIMING_UHS_DDR50];
+
 	return 0;
 }
 

-- 
2.55.0

