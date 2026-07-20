Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A02444700
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 17:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784567748; cv=none; b=h8W0WcLErUQgjGu1TpwMOyNZeJLS1EqTuxo06C/EH6Wp3Hv01cwU0uhnEPQoIqMSTji9GzB9EiJKuRhms/lXQNXKRKK38dJfItQirnHDFwyKeQWGI9w/nFEwC8Yd2HC5ThQfwUrMf4nPnTxpp8FxDbZIE9EX38h1K6OQxXuS9e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784567748; c=relaxed/simple;
	bh=VRVe5Aly5Q3oOsD6Y7z7f1M7tQjnKQ7zg+ZdyPnhocU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O3HhYUbW6rbMEuzJ5xVlWr5T9B4Bd0kFkTXcLIybZGQDv72KlfGx3iAuJH/xPGJPRxti3ynYRYqbv0w+rcgOEcp44GY/okdTrDtJ7a3CpIjM/aDMgh6OI73sF7LzWJT5HvDfEKeeXUZSM2mU7zqnoY95OzpScoiJ23KrS1DqhLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nNLy82/G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nNLy82/G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0D631F0156B;
	Mon, 20 Jul 2026 17:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784567740;
	bh=2hzu5hVmITW/Sih0xBCVOxix8fqG1B4QECsXmahhego=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nNLy82/G4iO6CxtbtEgfvvMU44RAGVTsdWjSPym+9gDf/vQlTVkVKr1nFMG2nPa3f
	 L5R6qOwtyV3IapFqdieEx+p41VdCh7sCLc9i7EzkRfcsAYEpQ6YIXVEieCdsZ4FQRc
	 LRLqW2UXltCyUP99oac8AP6ShSN5YeSoZ455lupi7zJn3GJPkho3p3ZtCKlmgcMant
	 Tod3mhQUnzXWvhE25MkwlPCBH18cp+Hc2k+smwlEkiZLpGHeGqQSkhuTVb9LjBMKWl
	 TlxGhkLa1xjHrcpxfrh6HJnCrZdQvXNyY1ZAohuE6x10V4SuYcihy821rxGF7kezDm
	 htaJMObeEv0Vw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ashish Kalra <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 4/6] crypto: ccp - Move SEV/SNP Platform initialization to KVM
Date: Mon, 20 Jul 2026 13:15:33 -0400
Message-ID: <20260720171535.2695659-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260720171535.2695659-1-sashal@kernel.org>
References: <2026071538-unmapped-affiliate-9ff5@gregkh>
 <20260720171535.2695659-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ashish Kalra <ashish.kalra@amd.com>

[ Upstream commit 3f8f0133a5fc9b32d0c308530320c3f2430ba5ab ]

SNP initialization is forced during PSP driver probe purely because SNP
can't be initialized if VMs are running.  But the only in-tree user of
SEV/SNP functionality is KVM, and KVM depends on PSP driver for the same.
Forcing SEV/SNP initialization because a hypervisor could be running
legacy non-confidential VMs make no sense.

This patch removes SEV/SNP initialization from the PSP driver probe
time and moves the requirement to initialize SEV/SNP functionality
to KVM if it wants to use SEV/SNP.

Suggested-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Alexey Kardashevskiy <aik@amd.com>
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Stable-dep-of: 08f0e65e784c ("crypto: ccp - Do not initialize SNP for ioctl(SNP_CONFIG)")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/ccp/sev-dev.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 12382f2405608f..07e65672b2c7b9 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -1351,10 +1351,6 @@ static int _sev_platform_init_locked(struct sev_platform_init_args *args)
 	if (sev->state == SEV_STATE_INIT)
 		return 0;
 
-	/*
-	 * Legacy guests cannot be running while SNP_INIT(_EX) is executing,
-	 * so perform SEV-SNP initialization at probe time.
-	 */
 	rc = __sev_snp_init_locked(&args->error);
 	if (rc && rc != -ENODEV) {
 		/*
@@ -2512,9 +2508,7 @@ EXPORT_SYMBOL_GPL(sev_issue_cmd_external_user);
 void sev_pci_init(void)
 {
 	struct sev_device *sev = psp_master->sev_data;
-	struct sev_platform_init_args args = {0};
 	u8 api_major, api_minor, build;
-	int rc;
 
 	if (!sev)
 		return;
@@ -2537,13 +2531,6 @@ void sev_pci_init(void)
 			 api_major, api_minor, build,
 			 sev->api_major, sev->api_minor, sev->build);
 
-	/* Initialize the platform */
-	args.probe = true;
-	rc = sev_platform_init(&args);
-	if (rc)
-		dev_err(sev->dev, "SEV: failed to INIT error %#x, rc %d\n",
-			args.error, rc);
-
 	return;
 
 err:
-- 
2.53.0

