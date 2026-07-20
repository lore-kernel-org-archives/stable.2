Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3803B993B
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 17:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784567744; cv=none; b=kYSvbt7ptmjp75knUUga9qm3rPcNiR45qEhO1vyWUsAV3xcZuLkxPbiZCGCb8m1/yjKhPbTjXOsy921up+41h3QTEtVM7eBBwFUytkDgkJmiPDedMxpKnIXvxsT9WbZY5fncjCRjxA9KZfvVH9iotwu81mHHWxD+i4sVqwcF63g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784567744; c=relaxed/simple;
	bh=0micAVWj7+3P/MKi4V7QcRbVUzLn2lu80Nml1Y55UI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kfaB/YsNnwLHrsOoyslnvtT58UyFRikXGC9+Ew/GAwygDAVH7ohyZn5Bn9bt//2Eystiw9BfygVI92WD14FmnpJAEdp0W2+Pr7HviflcFrVRaMEyry30whh8cwW/yVyb8KH7EpOnF7teQkk4aS3ISTPel8Xt1YHMDl3luS7ulD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MqUNPyeC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MqUNPyeC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB9271F00AC4;
	Mon, 20 Jul 2026 17:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784567739;
	bh=ZjhKZTMrbCFcVVyvhxWt0zAMxa/4qdZKtU3+eNeGbOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MqUNPyeCN2BPCj1MyCW2qVPoPDbdgj9+flP7G7lRO/UpdEinqOV8/GS1JFo60hPuY
	 o2QX/r+PMJbzuhWf7g5ooSpmIvL1AsmqL9ttOtR65COxQxFc0grasZ2GNZCQPB+n6B
	 fAfVefB4bmG4kGQ+bna7e6EG8T2B2hf5mzJn8sjQPJhxOMnTJUr9uYf6kIY0IVxxf+
	 UapgOldqYgMP7otQJzz4NjsKvZlqRQnpUfFD/ERe/D0qkigApI8ISCdIRKzqcgyQxW
	 m6X3nB58gPDtZXaPftOlpqkjt8UyVzut8wIScWUXh7SWuxC5iUcEXzCs3VovtJu5aG
	 B+sSx7eIExRhQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ashish Kalra <ashish.kalra@amd.com>,
	Dionna Glaze <dionnaglaze@google.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/6] crypto: ccp - Register SNP panic notifier only if SNP is enabled
Date: Mon, 20 Jul 2026 13:15:32 -0400
Message-ID: <20260720171535.2695659-3-sashal@kernel.org>
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

[ Upstream commit 19860c3274fb209e36ebcba562dc5da301a53cb3 ]

Currently, the SNP panic notifier is registered on module initialization
regardless of whether SNP is being enabled or initialized.

Instead, register the SNP panic notifier only when SNP is actually
initialized and unregister the notifier when SNP is shutdown.

Reviewed-by: Dionna Glaze <dionnaglaze@google.com>
Reviewed-by: Alexey Kardashevskiy <aik@amd.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Stable-dep-of: 08f0e65e784c ("crypto: ccp - Do not initialize SNP for ioctl(SNP_CONFIG)")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/ccp/sev-dev.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 0a3ee7e05af2c5..12382f2405608f 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -105,6 +105,13 @@ static void *sev_init_ex_buffer;
 
 static void __sev_firmware_shutdown(struct sev_device *sev, bool panic);
 
+static int snp_shutdown_on_panic(struct notifier_block *nb,
+				 unsigned long reason, void *arg);
+
+static struct notifier_block snp_panic_notifier = {
+	.notifier_call = snp_shutdown_on_panic,
+};
+
 static inline bool sev_version_greater_or_equal(u8 maj, u8 min)
 {
 	struct sev_device *sev = psp_master->sev_data;
@@ -1195,6 +1202,9 @@ static int __sev_snp_init_locked(int *error)
 	dev_info(sev->dev, "SEV-SNP API:%d.%d build:%d\n", sev->api_major,
 		 sev->api_minor, sev->build);
 
+	atomic_notifier_chain_register(&panic_notifier_list,
+				       &snp_panic_notifier);
+
 	sev_es_tmr_size = SNP_TMR_SIZE;
 
 	return 0;
@@ -1791,6 +1801,9 @@ static int __sev_snp_shutdown_locked(int *error, bool panic)
 	sev->snp_initialized = false;
 	dev_dbg(sev->dev, "SEV-SNP firmware shutdown\n");
 
+	atomic_notifier_chain_unregister(&panic_notifier_list,
+					 &snp_panic_notifier);
+
 	/* Reset TMR size back to default */
 	sev_es_tmr_size = SEV_TMR_SIZE;
 
@@ -2486,10 +2499,6 @@ static int snp_shutdown_on_panic(struct notifier_block *nb,
 	return NOTIFY_DONE;
 }
 
-static struct notifier_block snp_panic_notifier = {
-	.notifier_call = snp_shutdown_on_panic,
-};
-
 int sev_issue_cmd_external_user(struct file *filep, unsigned int cmd,
 				void *data, int *error)
 {
@@ -2535,8 +2544,6 @@ void sev_pci_init(void)
 		dev_err(sev->dev, "SEV: failed to INIT error %#x, rc %d\n",
 			args.error, rc);
 
-	atomic_notifier_chain_register(&panic_notifier_list,
-				       &snp_panic_notifier);
 	return;
 
 err:
@@ -2553,7 +2560,4 @@ void sev_pci_exit(void)
 		return;
 
 	sev_firmware_shutdown(sev);
-
-	atomic_notifier_chain_unregister(&panic_notifier_list,
-					 &snp_panic_notifier);
 }
-- 
2.53.0

