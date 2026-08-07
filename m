Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29896431A50;
	Fri,  7 Aug 2026 11:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786100906; cv=none; b=raN3GCSKpAt4Vn2iH0CUvRcxELCl4ty62sJd3C82Dgqnx1NWclqy4PQ6qpHlskO3PbQOAQIO8OgrL2o16gU7Ehpkw/SBIFaoX++2NOlzC6fHp18fM7WG7tjBcHgFYvmLtk1/Yp/Cf5JbrTRB3iuHDXqj90Yzb76Gx3L+XdxR52g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786100906; c=relaxed/simple;
	bh=MvKTpSoJLS1Tsv+qqpUwBPeZzzuUxhGSfRJPoMvJk0Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R2Y4Ci1TLlQFpnj1Kk4Lq0lGpkzLNkJsmkIfK4tXN/CsiHz8gUgNJ//0e6a3cxidrAqhsrAN82Jsa9fonXOS+wdboSIm9inSDppnLQc31UP/AwKlJbQARrqYgVoY5LctGMq7OuFTIfQRn8IYhKGZtZcuSN89IX0zm+QCAEly36o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=zGvm/e/W; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="zGvm/e/W"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id A4F4C1A1499;
	Fri,  7 Aug 2026 11:08:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3C114603F0;
	Fri,  7 Aug 2026 11:08:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 70A8B11C3763E;
	Fri,  7 Aug 2026 13:08:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786100898; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=VEzqHnAEn0wyInSm191WpGS97AIDyDdPo22NJJAP/hQ=;
	b=zGvm/e/W71cR2mJh6o7Age4WAOCZE6WvXJNuF1Yq8KRepHRkZC8ALTCaMmVr64cOSf5HoC
	wz194KcZjbmggWB11OoMymWlZ5f4Zr4f9MSgwsVKB2JzWjK3NsObVBMot3rzQj8J/ptNd4
	XBToab/8BAS/1K8RQiFj4ouv0OaBZRPILP4MUj3quC2t5ud0UlyZKgsjm85m01TWP973ur
	QT+w63tslBF1PH1eT14Ll3ay8Ne1p8dDidlB2LVwTI0EMLjd3WIOOO8vBdRA64NctkPkp7
	U/4xsftwgQ29ibaxMTEH2YsYpttGD7dYevAQk/IFPh1nuNWCfa+o47jhzyeOBQ==
From: "Diogo Ivo (Schneider Electric)" <diogo.ivo@bootlin.com>
Date: Fri, 07 Aug 2026 13:07:00 +0200
Subject: [PATCH v3 4/4] mmc: sdhci_am654: Fallback to DT-provided itap
 delay on DDR50 tuning failure
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-am654-sdhci-v3-4-acc91d7d7e50@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3181; i=diogo.ivo@bootlin.com;
 h=from:subject:message-id; bh=MvKTpSoJLS1Tsv+qqpUwBPeZzzuUxhGSfRJPoMvJk0Q=;
 b=owEBbQKS/ZANAwAKAQa+fFtWXslFAcsmYgBqdbyGc3ZTfUhOBFOtcf85baIPzhGb4E/jZRrW3
 aqoi0bATwSJAjMEAAEKAB0WIQTma35o1i1081e8B2UGvnxbVl7JRQUCanW8hgAKCRAGvnxbVl7J
 RbXaD/0bsagFKXUd69puBmGUAdHR+4exOXztDZ9SVQbWFrA5Z1REaDFuOK/mUGyu89Ayz/Q6NSJ
 NZ7hffgGyyqM7WQlgVS3AiGzRS6bZaqonLg+vigkTGhTk5abCqK54RZC7SF5/GEYTNs1q/FHjLW
 1lewZ2RCIv+MMCrmFJ4wCjFpqHE2198nDBP3ED+iduIO5XTIV6iQgyXbkeSCJemKabrMhR3Uszr
 Z58FmTzgQLG2hG3NPkkleBBHxWIk4j3eFmuJwztxddOouEio5IDOW3irCRdmMblt7if7o5X1VDq
 rm/8j02R3iRzzBZh+G30ybMGhRjTioQ3KGVQ7pBMH0M7WhgGbvCHv/3IKtAZhn8L2U5kGYDin0I
 n67T7Cbbommr2U2LbNvH6+/Ft3lsnmCzrpNj77VD9V0p/b8CzxwpuROi4FVijcA5yDKbU+HneVV
 29zl4zX9zK6OHIjOuH4CLJSB0m8jov4Q5mNNLEn4v1FDhVXFOc5V8oCemRYAHUSqs3VHZRJq/uZ
 QG3LtX2R3gWxJt5AYeuZFG/n8jsh8Fw/W69OOHLTn7VPvEbkKR//SIsJt712qOs+OFqrK3XFhOH
 kjVMzZeSS3cf9iiMpGs4vKS5+8VEleAWp7zAl9Y2lTuOVhcJl/bN3013wcwHi2dV2qIQ0bB+P75
 Lds9ltLZUFywRrQ==
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
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
Changes in v3:
 - Collect A-b from Adrian
 - Add debug print when applying DT fallback values

Changes in v2:
 - As suggested by Sashiko save values read from DT for DDR50 in separate
   variables in order to keep them across multiple tuning cycles without
   overwriting them.
---
 drivers/mmc/host/sdhci_am654.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index 8ce10422bba0..8edfab5012ed 100644
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
@@ -579,10 +581,19 @@ static int sdhci_am654_platform_execute_tuning(struct sdhci_host *host,
 	} while (++tuning_loop < RETRY_TUNING_MAX);
 
 	if (itapdly < 0) {
-		dev_err(dev, "Failed to find itapdly, fail tuning\n");
-		sdhci_am654_write_itapdly(sdhci_am654, 0, 0);
-		sdhci_am654->itap_del_ena[timing] = 0;
-		sdhci_am654->itap_del_sel[timing] = 0;
+		if (timing == MMC_TIMING_UHS_DDR50) {
+			dev_dbg(dev, "Failed DDR50 tuning, fallback to DT ITAP\n");
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
 
@@ -758,6 +769,11 @@ static int sdhci_am654_get_otap_delay(struct sdhci_host *host,
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

