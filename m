Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9365F43F4AB
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 17:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784567744; cv=none; b=OHRYwcS0mvdLeJsSO00F/w7tpUvusEwXTFhOO9EAC0EdDg/bcJg4y8UDWO1xZEeLzI9IpCl1SRPWyabv06myKBhIg6Z37aenN4rEAApV44ddeLvCsF5l1Ye40MCFnkEg8uIKbujsh+8Egvwp88oKunbob4G4tqzPJ8JIiHKAb/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784567744; c=relaxed/simple;
	bh=eUP4vQSAODMyzS9ImWstV9IU/oanwZzM9Z0UUtwP6o8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m1gQVPUB5tU8nCt3qzjzgt9af31EB0b8HgMlTiXeN0HZzwqV9UtU6ouFLnYF0RzsFFR0WpcG8euTWDprlvw8mtmnwXyQiBNBPL2ERa4RdkNii79s7i8rF5IMsBqjwbimNUS/tQ/Vp7BXswDIJXlR4TKA5QCptzwBeZYi9ktmxYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UsCPx0co; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UsCPx0co"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE9DD1F01559;
	Mon, 20 Jul 2026 17:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784567738;
	bh=4fBL7ePbZkDQo4wnoiQoPGNb2X2gCUiB3vQWaTaSYm4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UsCPx0cow7uZXYwOGbUasryXPDQmkEdv+7hH9XkPH6I8ALogx+lOwDIA3bb93egy2
	 HjKIUiDM68HdVuHCW8BtDPXGSOERWsoSUs2IVYYg3iTfZ58LKp2V6EZGYUp+4w/eq5
	 EFqTDoZkw0plabewTW6fdYR482/B35jlK4jr8OOjMZ3X8oGTXghzysXqgn1Qh8vs8K
	 u6LMxm1RGFt7X9UeeHos5tJ0e2cHBh8iu1h2iTcAUM/qVzbiKvz4/fNrjVOVVli7Ha
	 BbqnefuzAnefs3zXSdxQ5Y7ylxiUoacBANleB4j1RenInaAXuk6uBOffK8+lsU9Tn/
	 JcqFAcn9BlttA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ashish Kalra <ashish.kalra@amd.com>,
	Dionna Glaze <dionnaglaze@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/6] crypto: ccp - Reset TMR size at SNP Shutdown
Date: Mon, 20 Jul 2026 13:15:31 -0400
Message-ID: <20260720171535.2695659-2-sashal@kernel.org>
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

[ Upstream commit 65a895a44e641fe47f3419b064288d1d713024a5 ]

Implicit SNP initialization as part of some SNP ioctls modify TMR size
to be SNP compliant which followed by SNP shutdown will leave the
TMR size modified and then subsequently cause SEV only initialization
to fail, hence, reset TMR size to default at SNP Shutdown.

Acked-by: Dionna Glaze <dionnaglaze@google.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Stable-dep-of: 08f0e65e784c ("crypto: ccp - Do not initialize SNP for ioctl(SNP_CONFIG)")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/ccp/sev-dev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 6f9829448f5db7..0a3ee7e05af2c5 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -1791,6 +1791,9 @@ static int __sev_snp_shutdown_locked(int *error, bool panic)
 	sev->snp_initialized = false;
 	dev_dbg(sev->dev, "SEV-SNP firmware shutdown\n");
 
+	/* Reset TMR size back to default */
+	sev_es_tmr_size = SEV_TMR_SIZE;
+
 	return ret;
 }
 
-- 
2.53.0

