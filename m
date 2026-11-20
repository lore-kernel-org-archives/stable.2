Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795196127;
	b=ClNVBIPCF7/qh3Jw5mlOt/hsnv0XdNKHb+y4cVfwmeI8FIINlrIRcS0azDf7VG0UCEWI
	 YLJYOdfPt9yIARL9ka4O4me2SF7vo9/XuO9UavRhK7T5f0ehw8cA7FkU2Dzse9GCqFyhY
	 ITN+WfwJ2B9ah83ICrFx8zuZidfphUNJFurTOMPXJiEsHiJkjzaQ3ZkST3owoBQ4MaeT6
	 2UADGJKeVwBRnjFYeDMIZ4IzXUSmBqaKdWVN93F0wEL+CniRpB2EPqry5T+2jNAHmMhjW
	 fs/tv/aIdZdzKwFrYM7D2s4mfhvmR6ysJlWmqrz8s/AUn3Txh6Dnwt5afQbDLcR+c6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795196127;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-HM-Tid:
	 X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=hEdO69vVL5rwCpel8UiCyiJqyc8aP/573OWZYMkPaAo=;
	b=fmiOOVZJEbbuFtXOKm9ar8vUxj66OU8FwWog3PQU9EqRKlpAHO/6y9I+3sPrSB9AOiYP
	 YJ9DACvDFa3Uo+NZihVp3a3LE1ud7A9bkw5NMUPjSmI1F+Lr4ZNeXB/PPcQrvkXwxm1lc
	 TYA7YYczAoFVx/R2EE2K9go5Nqlv36j7qmBZchg1hgEtpYpkh22rg9UZihzN7q4T1njw2
	 UwKnGiTWMuaSAaUwraAMn2xvGTPZfY2qn7+QQ8nPXgbmmqqCSIH5Oh7sDCfllrxQoShzN
	 QiAB3u7zxiBVkjMmkoM0k4H2bRsUQQplqgxt794UH1sMqNYGKswmgjBno2up8l2K0FA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sdu.edu.cn;
	spf=pass smtp.mailfrom=mail.sdu.edu.cn;
	dkim=pass header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b="UaDEIKq/";
	arc=none smtp.remote-ip=45.254.49.197
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995C960A2610;
	Fri, 20 Nov 2026 17:35:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 995C960A2610
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=UaDEIKq/
Received: from lgs.. (unknown [101.76.249.61])
	by smtp.qiye.163.com (Hmail) with ESMTP id 5573c0abc;
	Sat, 21 Nov 2026 01:35:21 +0800 (GMT+08:00)
From: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
To: James Morse <james.morse@arm.com>,
	Ben Horgan <ben.horgan@arm.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Fenghua Yu <fenghuay@nvidia.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] resctrl: mpam: Fix potential per-CPU data leak on probe failure
Date: Sat, 21 Nov 2026 01:35:18 +0800
Message-ID: <20261120173519.3923924-1-liguangshuo@mail.sdu.edu.cn>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1fa06efde03a1kunm98e3e691238b77
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZGB9MVh8ZTB0YThoYSU1OGVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0
	NMVUpLS1VLWQY+
DKIM-Signature: a=rsa-sha256;
	b=UaDEIKq/cgqGyzDB5Vooo8BjZBjXwDYuRLBCocMmLicUQSuLdNN3I4K/8Jm3ihCtBtSIEgxRYj1POm7hKpYXKWpj5CAXplAz6YJPgo1VqtHpLdtH/LaRQa/gPHO2REZv0S0qRMFf6W0gBa0HQnDjM/dd8qsNAd3j/oM+hnMtobs=; c=relaxed/relaxed; s=default; d=mail.sdu.edu.cn; v=1;
	bh=hEdO69vVL5rwCpel8UiCyiJqyc8aP/573OWZYMkPaAo=;
	h=date:mime-version:subject:message-id:from;

The PPI device IDs are allocated separately from the MSC. If subsequent
resource discovery fails, probe destroys the MSC without freeing its
per-CPU allocation.

Use devm_alloc_percpu() so the device releases the allocation when probe
fails. Its cleanup remains valid even if the MSC is freed beforehand.

This issue was found by our static analysis tool under development.

Fixes: 49aa621c4dca ("arm_mpam: Register and enable IRQs")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
---
 drivers/resctrl/mpam_devices.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index c067b6d57d71..3e89f9183041 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -2351,7 +2351,7 @@ static int __setup_ppi(struct mpam_msc *msc)
 {
 	int cpu;
 
-	msc->error_dev_id = alloc_percpu(struct mpam_msc *);
+	msc->error_dev_id = devm_alloc_percpu(&msc->pdev->dev, struct mpam_msc *);
 	if (!msc->error_dev_id)
 		return -ENOMEM;
 

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
