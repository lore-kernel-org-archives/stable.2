Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E15479871;
	Wed, 29 Jul 2026 12:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785328107; cv=none; b=RhURAA+VIjUZtIjcPSWOLGRdVBU0KLGQU3xstSGVDOmgQ2yfbGJ/VU17/XMQx94glaoT6BsFu+9uOUWy0M1hEDTFv+hjMmBePFBicRHzKoTP/IP+qogP35dgWP5I4fRutLJSQ6joAu5F1q6U3nY3ioiR9RkAmoSd2o3i4Ud79/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785328107; c=relaxed/simple;
	bh=oRrUTYWgMVtYtvO+yjVrNdlmthvRQeQ9FVYDf8+4kJA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q2O0t6bmP0G1lfe7Wyx33qwFgb2fnvJf8h2ds3jz1Q0oofOzypxJulxn2PSF7PanjU09dDENVihg7Pn+7H2qFQiYHCs/isq5/oFb95TGGeMprVTIJ4+lNIbzkE/XvGnzvkgO/oNfQq6eczB4bKffWSRg1yJY5kWvsmHoPMLxyjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lhzGuDQ8; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lhzGuDQ8"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 754B21A1304;
	Wed, 29 Jul 2026 12:28:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4A6EC6039A;
	Wed, 29 Jul 2026 12:28:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BF41711C14DCE;
	Wed, 29 Jul 2026 14:28:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785328092; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=62401MNJZd+NmwPO/Zom0O45zUQA8pu5GRnhVjurZNY=;
	b=lhzGuDQ8XOwq2z0owD5QZ53Wkcv+/B7Pc94F+tfdSZq677xcZ+CndNeIGYDJCvz4ubtcHf
	GxvR3AYcay/FozXA7tQ/snLTXsuOPln360Mp7l80tf9Nq14RLICgDCi+qAO5rOcgoyAfDn
	OX4pg2PN8/swPJX5MazSrguRgRFzf2Io78zlSNt5eekW0HO9nm2C7pSwsyfzL6FAtMs8Az
	e2fJrqDovncn/zJteFhwzef54U307jtc8+HPZKvngCP3bu+eoQybT+fw44lMpUlHf5li+R
	Wbag7s/su2Y5qXhwLL9Uw+C6XnFeByjEp2Fv0WizpbMyecdhwvkDwJP2WqUEYw==
From: "Diogo Ivo (Schneider Electric)" <diogo.ivo@bootlin.com>
Date: Wed, 29 Jul 2026 14:25:44 +0200
Subject: [PATCH 3/3] mmc: sdhci_am654: Fallback to DT-provided itap delay
 on DDR50 tuning failure
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-am654-sdhci-v1-3-7568108e4b9a@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1890; i=diogo.ivo@bootlin.com;
 h=from:subject:message-id; bh=oRrUTYWgMVtYtvO+yjVrNdlmthvRQeQ9FVYDf8+4kJA=;
 b=owEBbQKS/ZANAwAKAQa+fFtWXslFAcsmYgBqafHPYfhalSO375YP6WpjElK/d1l+8DRDP+EaB
 T8SKB1YeReJAjMEAAEKAB0WIQTma35o1i1081e8B2UGvnxbVl7JRQUCamnxzwAKCRAGvnxbVl7J
 Rer3D/9x479kR3xhmBc1TdtzLVowHEdBrwyjMtU2pgWQKzSCUCx/Yurlv/q8sLGkUteN15p+93Z
 5JcQBdfK+Up8q1KqOarSJv6rBPcRtQsaTjVF+9R3P2lFZKk7s2c4HCydhfIR7Xl9dJbvorPt2Fp
 Z9geeHg1eWsQRnZoHIV93UyoQZ6SD+7hgReQ713+BMzzMRVk9kw9VRmj+Duh4BEGQRqHNZPygSm
 o+qeHuxNXEkhtPvJqmJa9v62MBKZkJsjqnQ1x94CV0vsovfe4VjZ6oOblG9RcyDiyYHhQU5Ws6e
 cYXBvfqNzgE/+xB7lvX5l9nWOZklr/tnoITQrp0crozO84uC2dNxX54xeX3iSMKMzmfvvKmfE06
 rONBjmd0hcp+FiYPzzqeyJQBjFep0NrYlzmpq3TkGMlA2b93M77jgPie5tnDkdnivMMJyM/XXx1
 BwwKaRZx+cxIUc+BwNruCoMgVs9aPy8N8Za6tA17zduKi9ewTbHwgwoschbRCfI0qfdpKrjU9IG
 6z9pqq6gHmwzlQupu5STN2EwoZGfnh/lKqOLFe8bGsoFkjoCvQQb+acHNz3AMiOxWbobfB8Tjvt
 aRjqSfPH/nMe3Abz+FuYk5BOZ9oeoQ3rZS9eDLHTnX4M0Y+VkxJe49TPgYV1CJW4fBItOYzb3za
 kEOkRcZye5hqrwQ==
X-Developer-Key: i=diogo.ivo@bootlin.com; a=openpgp;
 fpr=E66B7E68D62D74F357BC076506BE7C5B565EC945
X-Last-TLS-Session-Version: TLSv1.3

DDR50 mode is not required to support the tuning command CMD19, meaning
that calibration may fail on cards that do not implement it, in which
case a known-good itap delay value should be programmed into the host
controller.

Do this by reading the (already defined) itap delay DT property for DDR50
and, if tuning fails for this mode, fall back to the DT-provided itap delay
value.

Fixes: 901d16e46296 ("mmc: sdhci_am654: Add retry tuning")
Cc: <stable@vger.kernel.org>
Signed-off-by: Diogo Ivo (Schneider Electric) <diogo.ivo@bootlin.com>
---
 drivers/mmc/host/sdhci_am654.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index 806544db0128..a7c64c5ac636 100644
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
@@ -580,9 +580,15 @@ static int sdhci_am654_platform_execute_tuning(struct sdhci_host *host,
 	} while (++sdhci_am654->tuning_loop < RETRY_TUNING_MAX);
 
 	if (itapdly < 0) {
-		dev_err(dev, "Failed to find itapdly, fail tuning\n");
-		/* Explicitly clear ITAPDLY */
-		sdhci_am654_write_itapdly(sdhci_am654, 0, 0);
+		if (timing == MMC_TIMING_UHS_DDR50) {
+			sdhci_am654_write_itapdly(sdhci_am654,
+						  sdhci_am654->itap_del_sel[timing],
+						  sdhci_am654->itap_del_ena[timing]);
+		} else {
+			dev_err(dev, "Failed to find itapdly, fail tuning\n");
+			/* Explicitly clear ITAPDLY */
+			sdhci_am654_write_itapdly(sdhci_am654, 0, 0);
+		}
 		return -1;
 	}
 

-- 
2.55.0

