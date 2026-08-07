Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EC843230E
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 11:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786100897; cv=none; b=WDEUPMiPAZa9MgVZcr/XRBQb1nzlHBW6o/Duzf4kxunw/yrIyBV3ffYcrCeCNcHrDsULPfcYngVC2DLTOV/J8HJ/zDo5QI1NRFnkvoOsZfOLb4OnKHku6VWiJAYnV0IM4PfrW0socrV15t3gLOmrfQ4xqmevHLZZzYov67lbkBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786100897; c=relaxed/simple;
	bh=2nAeTl62TZ3E3MzXNkINWnyKUZQFPBcDDBjFIvldhOc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TNUiY7a2lgBrk4qegL+b3mNWpWLpJmGwKqnLWm8t1oCFpz6h+v4yUl8/7jvE+sBcQ49ifCo6hA3F/BsKa6BKZbikv3GuUdae9pDBcvj8Lkom7JO8UhxI23GaiIeS8lgBL3kOfH7GsxdqXMGKroDiEx2jaQ2S3sTaI7Iq27DQkbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=2YVvBvX0; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="2YVvBvX0"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 29A3D1A1499;
	Fri,  7 Aug 2026 11:08:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B1170603F0;
	Fri,  7 Aug 2026 11:08:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DB69D11C3763D;
	Fri,  7 Aug 2026 13:08:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786100887; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=mqTdp4VNGoRNfNcN6pXkPIhNk4PjJ8EowcOKUjQat60=;
	b=2YVvBvX0c3oioWWXGGeaakh67VAm3Hp4nVICyPsUUy/AyI70A3zz7AaAKJY+hA19nrhiSE
	4CI1HGrR3j46aT+6/qeD8fwShgNqbIJODQvtKECGJxLUuz/c+efK+oiNrb+dDbBRr35r16
	I4iDLaZSgh1ldjLo8hTaSy+qqKRCxdx5NWeaUqNES0pHCLPcsvYbyvLLXeVkhFAO43VLyq
	Kd56svtpiPm4xT6kVajwk2wqMaMoYR7sKK/zjb306WiZxOQpk5aVxKc8WsimtKjGmCMpQO
	7BkGr4g+gbvZHPVI4LbsquC5fGxqKt+H2wv5rxpxpF3DPefobZwxHiiJDX/J2Q==
From: "Diogo Ivo (Schneider Electric)" <diogo.ivo@bootlin.com>
Date: Fri, 07 Aug 2026 13:06:58 +0200
Subject: [PATCH v3 2/4] mmc: sdhci_am654: Reset command and data lines on
 failed tuning
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-am654-sdhci-v3-2-acc91d7d7e50@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1437; i=diogo.ivo@bootlin.com;
 h=from:subject:message-id; bh=2nAeTl62TZ3E3MzXNkINWnyKUZQFPBcDDBjFIvldhOc=;
 b=owEBbQKS/ZANAwAKAQa+fFtWXslFAcsmYgBqdbyGMzxaMkvcOzuUmVmUNk2G2sIcOKGEMOFN9
 DiRW0o+T7qJAjMEAAEKAB0WIQTma35o1i1081e8B2UGvnxbVl7JRQUCanW8hgAKCRAGvnxbVl7J
 RRjZD/4tvjsMomCd7Ut/P5EETzl2mVz6INYcBym/HhhD4syP1oGJpTkrGOQvAIbtOJgfbCBGA0l
 vLuZh3+pTSzfjlspDP7M+dyNaWYGeyaZfTHR7szHALRlj6zukXtVeOIrSeWpeTrR6gVFoEapGN1
 5ffaTMcSstGucuDWqcuFYtQhyLfXLF97IqTPGYE8HNFAKJ0dECf2LLS0LjNh5oLZcOHYwcTzFcW
 SQtk2PsLGXT9amPR+MFKnIB/lxsz0FMjgTIx4U2TSI2UMSP3rRsQ/Xneh9ws+u56MuY7SnfnBNm
 WQLy0NbAAid5sTihZ0WPCGiuhsPXByltfzQF3hDrg+C79yx+Zg0jw/6aPfq0onhOwATOkueXeBX
 80ZeQue3OBeKBcBJkwdfjSemLhVnvapZDPZ1pWccCdQNfa7IxByuSuuA/diK8ttNij1NTHVNK/0
 5k99fqBfBdyFoXxD+LlzZGEP6TMNyOMaVJAIj9sIjIOYyUCS6MF6FVH6sXBwl1ddQ2+DzZqwIWl
 Cgs5XwlzZNiCxHOiwBCNmO84Se2qROpjkIdLhpvw01V27XW6XvMEdHYG8ewzlPWV2hRGQ6MAQ0D
 qMwekTkSACKO8GBWns+n/C1Z0FiJkuspVdpkrEVjVqWh1Lm2+PI60v91DmDRe3uaNOQsTEdMhEv
 OMt1GJ7V9m1QSJQ==
X-Developer-Key: i=diogo.ivo@bootlin.com; a=openpgp;
 fpr=E66B7E68D62D74F357BC076506BE7C5B565EC945
X-Last-TLS-Session-Version: TLSv1.3

The CMD/DATA reset after tuning should be performed regardless of
whether tuning succeeded or failed, since tuning data may remain in
the buffer in either case. Move the error return after the reset so
that the controller is always cleaned up.

Fixes: de31f6ab68a3 ("mmc: sdhci_am654: Reset Command and Data line after tuning")
Cc: stable@vger.kernel.org
Signed-off-by: Diogo Ivo (Schneider Electric) <diogo.ivo@bootlin.com>
Reviewed-by: Judith Mendez <jm@ti.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
Changes in v3:
 - Collect R-b from Judith and A-b from Adrian
Changes in v2:
 - No changes
---
 drivers/mmc/host/sdhci_am654.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index 35c3efd92112..0db587e702ac 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -442,15 +442,13 @@ static int sdhci_am654_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	struct sdhci_host *host = mmc_priv(mmc);
 	int err = sdhci_execute_tuning(mmc, opcode);
 
-	if (err)
-		return err;
 	/*
 	 * Tuning data remains in the buffer after tuning.
 	 * Do a command and data reset to get rid of it
 	 */
 	sdhci_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
 
-	return 0;
+	return err;
 }
 
 static u32 sdhci_am654_cqhci_irq(struct sdhci_host *host, u32 intmask)

-- 
2.55.0

