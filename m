Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691564137A7;
	Mon,  3 Aug 2026 13:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785764922; cv=none; b=mcXyt7jHzr5qcWpH3wKp7ZbdUmr9qEpmnUgkd0eFcVMVFgROrOnQostWB9DZRpi08L8aszcVfGYOn+Mch2yZeLv3zs42Mc7H0hDa6rgA1vgNzU4BlDN15cV47pXRL2nWqZVvXgwK68tdYH0rmj1FOIJVdV+i4J6VZ9njnTKr7lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785764922; c=relaxed/simple;
	bh=rT3ptH86bpnU2R6as/GdHwEJ4HgXlvnNme2/S1QBSYI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fI23PBsGOLqeRAomz0LQyc4xkuVZXLoYosUGylE3TN2beQuLuZtJNl46JbYZ1HwDofNJurd0q9vFD/nXc1D/gtsAEPpvGiBFiyGr5BwOcubBGAuEO+0tIcJGKJppHYOjYUn0kxCV9S+Rr8EQORy8pzp/3PNxOet+i7iX2PjmvxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=V5UwCJBy; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="V5UwCJBy"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id DE0911A13D4;
	Mon,  3 Aug 2026 13:48:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B31396029B;
	Mon,  3 Aug 2026 13:48:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0E82311C30CED;
	Mon,  3 Aug 2026 15:48:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785764912; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=o1LbfpViHVmYy3GskUHEMq4YaozXQDfyR2Qm33eTSZg=;
	b=V5UwCJByvZ900FvGzqtDlhv52eGHVAHQYWcC1OmoE1BBpwiQAuNJ3/atoKHP+HufabccOf
	OFZ4KLJexEb/knLiQOvxrk4ykMz5R7P3x7U3U7jJ+VhZsGUuE+0ukpa2Yxca/Q8Q8ZGa8g
	N70qWs/qbAAPLnIujbHjZEmoPmzi0bHjym1PPVFIDxZMcGeejOgpiTJ4epCYmlq0qNjuN0
	1J/5R0Lag4HLD2We4OWIWrEBiPmdhe6pchmH6Xy7BnSGJwV2f0vEeWoMf1zsocuIl64pk6
	g5JhYGtVgSIaFT+Nrwq7FW4DUvWCYrtrPzEH2ZlEVaXPShjRCO+cTCZcf2gwQA==
From: "Diogo Ivo (Schneider Electric)" <diogo.ivo@bootlin.com>
Date: Mon, 03 Aug 2026 15:47:32 +0200
Subject: [PATCH v2 2/4] mmc: sdhci_am654: Reset command and data lines on
 failed tuning
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-am654-sdhci-v2-2-a5ee5be86133@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1284; i=diogo.ivo@bootlin.com;
 h=from:subject:message-id; bh=rT3ptH86bpnU2R6as/GdHwEJ4HgXlvnNme2/S1QBSYI=;
 b=owEBbQKS/ZANAwAKAQa+fFtWXslFAcsmYgBqcJwr+x7Rp2jL97wzdyOsd8yHl3JFQm3htYHIj
 7ALqN+3O5mJAjMEAAEKAB0WIQTma35o1i1081e8B2UGvnxbVl7JRQUCanCcKwAKCRAGvnxbVl7J
 RXDID/4te5nj9A8f27J2h7fwZB1v1GHuq00DqSIeQUyzN/OnfaGCHnS6/TirT9YPNhNGMtqzVSY
 5cDWBD7CAilN4/up29G2gUQeWes31hq9JYiuBV2uU/29fNiL2A+nWQlolo1jWLsujcOPQPp4JeU
 AcqJTVlZNHbiOBjpqKjj7Aqni2CzpdZLfoxbaRuaEaobOf3HV4LSnLMNy6Vmy3J9GALZLAtJ+YH
 Uu4VyBdwGMUvkXGP35DarTjB0z6yOEzGCxvOpzOqXsYfFioJfAxjUR/04HjjrSdgQ3bdLVi8h2E
 cQQbHt3rHDQIxnGar3IHNmMNQ4qtvOZweRIdmwXWxISwytjgaMUx/a3Ze73DGQ7IuY6P2DCupBQ
 /xWjqoK7LRhp2P90lIcjpkFGu1uhvEDqmnR7VY8OMrtzv/6ySecb9HYTrHaOn0y1KEWSufmPk8a
 vHHHYLtG35wAoUE8OIMpCI6f5gcZsBpAroddlIP7kf3VUZyglVzT9uYSGekbVipFs2K82qBwQ4J
 REuQF1rhWM33eLGLDMqi58bGXk3OK96tNOJ4/m9VUbr3gA9yd1qq31XhSRSxjMH9zSYyQjmTpTi
 dU3t/Br1HzaMMvQZKJLZNGigqpC0agnU4pypDFjvtd4KD1VUTxGCxHYoxIdoLr4PGMi6r8uVWcq
 CgsrjjMDzatMOGg==
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

