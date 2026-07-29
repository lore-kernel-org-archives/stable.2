Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6245480952;
	Wed, 29 Jul 2026 12:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785328104; cv=none; b=hbUOwN/+W/aH4n6Rus1tYBbTk+hSsyxcchck3LkPBMzEIs3Ruo4i0ROLynDflhD3ZdBoAhQ5rXZBVWA9S+8WtremJpUAzhO85dtwVbV9fyA/+yp94shPqoQuVrR6b02A45yE8WHtRcqmTnnuHvMzWacdPETcigFrFe3oC/OBuZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785328104; c=relaxed/simple;
	bh=CUc/aAlP2rg7uSm23RFsoxSRF8/4wbZLYn+DoGVAVcg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jh3vKiYbMcuvi2X/mMR/8TVg1BBz8IbJkAX9fDf/PkJlZ8FvwnMghCLbBNsbfyG+V4cs67f84u0Vs/q9uaS9VT8Dv6CWBsn2Rvceq14pVlchaDseNbmFDEFbTQBFC7Bv3JyYSzHNrYHf7K2EjIwz6JrUPPaxK68s9Hmllschtew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ct8kfuhG; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ct8kfuhG"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 08AC34E40FD7;
	Wed, 29 Jul 2026 12:28:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D142B6039A;
	Wed, 29 Jul 2026 12:28:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 70FC311C14DD0;
	Wed, 29 Jul 2026 14:28:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785328088; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=U4cC7SFSqtTL9g1/BW0LoxbBIsLu40pyx25taDIRET8=;
	b=ct8kfuhGmtnxEEFoqNJ7yrNtnWD8X2DLwO0IPh1qV5qmDhhh2Vr+RGAeXzNtmHZuNcJUsZ
	5FV7Fcln4Ng/UqxTLvBgWZU0St5BB7IqEtvHIZ1LdQNMx1LrIdgt0cByE9CyyS8LLE6KC0
	6/50lk7LnxSenHkxuFIg0EvIXSQ7CA1wtHQS1TrMdu7bov8JYB/f+x/KOV0cX9HYXZArxI
	Q+QxB8Ig2EaVrunwFwepZJWWAjVWtY1gkfRxD140bBBNmm4LB/n0EYF5YuSuBIcKBbT9nC
	pWqnRn3bs6y7JEmxapXHlk1J7bUzWfO5TW4JsdNTOyLYRtkLWPoEnDXGy/bDxw==
From: "Diogo Ivo (Schneider Electric)" <diogo.ivo@bootlin.com>
Date: Wed, 29 Jul 2026 14:25:42 +0200
Subject: [PATCH 1/3] mmc: sdhci_am654: Reset command and data lines on
 failed tuning
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-am654-sdhci-v1-1-7568108e4b9a@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1248; i=diogo.ivo@bootlin.com;
 h=from:subject:message-id; bh=CUc/aAlP2rg7uSm23RFsoxSRF8/4wbZLYn+DoGVAVcg=;
 b=owEBbQKS/ZANAwAKAQa+fFtWXslFAcsmYgBqafHPPl1ZEr/gDa8mp7f/afviIKzqhDxtwbPyf
 dXgRs2As22JAjMEAAEKAB0WIQTma35o1i1081e8B2UGvnxbVl7JRQUCamnxzwAKCRAGvnxbVl7J
 RbexD/9jNywtdM5za/sABm1KTnVrJHvlwJ7Q2c5cuLaAlUDfaytIPqqUQG0W7Jl/+kzdX09szTn
 nMCMdKDI87Ge+7WU7mx9/tM0cL3Fl1JZ5UgI3zOQP928Gm165To0K4iLRm5R1JN3Pjau+k9akHc
 sBppzhGZy/K7Oy2zP8/BfZuJVN/tfckBt9vUT7/IPe1MdT4PFP4fKoTdSX/3VG+r2VIVAQVKtpt
 4+ElMh60ceACoX6ycffhGkCN++rZoP2CUv6Zq6F8AM5A94zsAldizSrQB3hZKo/r32vqte4aEwA
 PiDZ1FLSwKiqGP+jIf4cZq1gUFjeRS2/+9Wssk5dJMoCrijrotxOQ3oOkejIObOgvcCaPzTAgp7
 NUMGdO4ESDODHXPGmKmPd4k0Yyk1ulhsr8/3HlDdsAtWrr6WVPF0lAEuIWrnpVKQXbVLxZjRK41
 P+p4gyVLDSNJ1G9ummtyFqtKtx1HPNN9xG9n4BPKgwIXV0yhg8rO15kKsIQ044qJZgtpBd5QrST
 eSHnVdWazoNaDRRVoTPQbIzwUWL48glg6KNkEC+MRMAwqDTJglVLSe+FoJ8lruvF8OQoNHsw1P7
 9m2KTyIMd4Ue3NGwQssGvNmGy7G0yFjWXgexL+5Uxw2Aqn9HR99uZkWf0E7ieXTmuQUzgUu7Y6o
 gYp08M3MNyV8YQQ==
X-Developer-Key: i=diogo.ivo@bootlin.com; a=openpgp;
 fpr=E66B7E68D62D74F357BC076506BE7C5B565EC945
X-Last-TLS-Session-Version: TLSv1.3

The CMD/DATA reset after tuning should be performed regardless of
whether tuning succeeded or failed, since tuning data may remain in
the buffer in either case. Move the error return after the reset so
that the controller is always cleaned up.

Fixes: de31f6ab68a3 ("mmc: sdhci_am654: Reset Command and Data line after tuning")
Cc: <stable@vger.kernel.org>
Signed-off-by: Diogo Ivo (Schneider Electric) <diogo.ivo@bootlin.com>
---
 drivers/mmc/host/sdhci_am654.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index d235b0aecfdb..f76aab7e3a16 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -443,15 +443,13 @@ static int sdhci_am654_execute_tuning(struct mmc_host *mmc, u32 opcode)
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

