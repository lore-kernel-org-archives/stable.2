Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766E22F7F12
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 02:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782440715; cv=none; b=X9otl51bXNd8b+U3yuiD09ENi5n9tqE/bX5rdE/LOqrol8tiwfLLA1LX/iNhh2iizOVBy/hGIsBAAA+TO+RrN/AdG/Iw5Gzd+aSwqGD0SjrqGYGZYmjqYVEAnBw3ZC5tPf7z+gnzr/k6YNTB4NjfITyCgRA1xSsF3PIfFMiVzgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782440715; c=relaxed/simple;
	bh=Vv3ERcPlveoJgVcNLPvMr1QYGpJp1B1GrjA93zjoK+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JoQlWkmMSpV5Ri4or8J25LfzWnyUSlCDYAamdgeBcOZ57qP3hv/utsuY1Tff/KZglEGgdQOr0CUPF6wESbKRy5MvAsjbK/8ndSGryowJdr7HwH3pL4gBDeMQ1rPUxHiPrd9P+hN3Im8U8bsCP0JBDPpfawWGVizmCL4BbbEsUww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JxIo4ZxT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JxIo4ZxT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEA731F00A3A;
	Fri, 26 Jun 2026 02:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782440714;
	bh=3F7sIy7abS9doLi/+eZfPDTqfDA1eA3Erl7Y3JUNKGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JxIo4ZxTtsxgo8zkHIuiFAzWnE0DABYTUH3uLsEhgrzTnKTVrS+aw5HfiJXbaxcmc
	 cKOKvI8TzW/z7aDotcnQcef4FvzzOYvXJVPkYTfj3wh9x4BrhBiduhUVa4Pi1k+RTV
	 35YVxq4khnolO8tuMUSPn9NNzhBBt4ND4Eqf87tjz+gvd2CJif9vy9bPeVexTyJON2
	 hSpwHIm9ybAY7WuqUS40YW9ZnyrkSaE2lZVARmNFN7DwsdniOsZIUiaHA/nyyWefDc
	 ha26UTTBXPto0TToJbeTLxEc2XlpW+Xam9+VK49CTKrReBq5pH7LSTomi86soI+oFM
	 bfgcRLD5bzQGg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/4] crypto: qat - Replace kzalloc() + copy_from_user() with memdup_user()
Date: Thu, 25 Jun 2026 22:25:09 -0400
Message-ID: <20260626022511.2700937-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260626022511.2700937-1-sashal@kernel.org>
References: <2026062535-sprawl-tile-e5e9@gregkh>
 <20260626022511.2700937-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thorsten Blum <thorsten.blum@linux.dev>

[ Upstream commit 1e26339703e2afd397037defa798682b2b93dcc0 ]

Replace kzalloc() followed by copy_from_user() with memdup_user() to
improve and simplify adf_ctl_alloc_resources(). memdup_user() returns
either -ENOMEM or -EFAULT (instead of -EIO) if an error occurs.

Remove the unnecessary device id initialization, since memdup_user()
(like copy_from_user()) immediately overwrites it.

No functional changes intended other than returning the more idiomatic
error code -EFAULT.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Stable-dep-of: d237230728c5 ("crypto: qat - remove unused character device and IOCTLs")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/qat/qat_common/adf_ctl_drv.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/crypto/qat/qat_common/adf_ctl_drv.c b/drivers/crypto/qat/qat_common/adf_ctl_drv.c
index eb9b3be9d8ebed..cd2ab4e9c7c4e6 100644
--- a/drivers/crypto/qat/qat_common/adf_ctl_drv.c
+++ b/drivers/crypto/qat/qat_common/adf_ctl_drv.c
@@ -87,17 +87,10 @@ static int adf_ctl_alloc_resources(struct adf_user_cfg_ctl_data **ctl_data,
 {
 	struct adf_user_cfg_ctl_data *cfg_data;
 
-	cfg_data = kzalloc(sizeof(*cfg_data), GFP_KERNEL);
-	if (!cfg_data)
-		return -ENOMEM;
-
-	/* Initialize device id to NO DEVICE as 0 is a valid device id */
-	cfg_data->device_id = ADF_CFG_NO_DEVICE;
-
-	if (copy_from_user(cfg_data, (void __user *)arg, sizeof(*cfg_data))) {
+	cfg_data = memdup_user((void __user *)arg, sizeof(*cfg_data));
+	if (IS_ERR(cfg_data)) {
 		pr_err("QAT: failed to copy from user cfg_data.\n");
-		kfree(cfg_data);
-		return -EIO;
+		return PTR_ERR(cfg_data);
 	}
 
 	*ctl_data = cfg_data;
-- 
2.53.0

