Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48581A0B0E
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 18:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782412934; cv=none; b=hYongRQo1dIAntPb4ub2wXHCNV0SQMmw2wr5bR3fhiKP41BbN4Yrm63b91R4TNb6faspbsP/ro06WnvP3M84R+GZgli9kvznLJSdWnA05VB+x/pepzxnViDMlKq+JZTWZE8kqy1YiBzW5ELUpFkVVljvj/tpA+YgrEO6clGQ4Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782412934; c=relaxed/simple;
	bh=azEgAQHFZzJ5p5nTHIjRqhFQgYRqu3/8cKQ6UmQiOMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A6PHTLmX7EAobhZmTIWMxVV/IQaflE64qOaZin7N+WsjkyePDwXJa6fqZXlyFppTqygLUpmAP6L4dTvFABhwdIqcJk/UqIlCXaw4SGLXnjkjst4WCU/znHQBWwUOMoacQJn5IRGpU0TNZFTTzXxoKa7vi7Fr0GX2q5V9KTHgx+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a4gnh6qw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a4gnh6qw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4E7D1F00A3D;
	Thu, 25 Jun 2026 18:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782412933;
	bh=fOPm/r4DM2U+YyywV8wN3i2KvZpVgAxFE++at3MZsxE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a4gnh6qwYZ92T0cSXlk0PKYDSQvMMa4pi4KdrEqVjrlDWwUvhhd7PCKEKIfYEqQSf
	 Tye+G/B0Unu139XbrMJMdpJsIscfykRXSDtIVQgJgUbYqm//Fm+1KqsY6N9DWn2zJG
	 s3pVanM36WiCgM/1y6zSunDCrK/CzI4x1wPbhHyxEsL+K56OaXrD7OxiN8hiJP4Hzr
	 OXxh7AyDIxcwP9/Kj3QjdESXor3/SXH2zZM2dJvWlML8z+ABlx1Ndgwcjo6X2o625i
	 eFCpEHgoehYw0NOEMFSTnt1kj+eMse5D59KYl3nUqwzC3lxA8ZM1w5H8K4WJx74M2A
	 v55rqe8UyIPMQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/4] crypto: qat - Replace kzalloc() + copy_from_user() with memdup_user()
Date: Thu, 25 Jun 2026 14:42:08 -0400
Message-ID: <20260625184210.2600469-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260625184210.2600469-1-sashal@kernel.org>
References: <2026062534-vendetta-rice-1545@gregkh>
 <20260625184210.2600469-1-sashal@kernel.org>
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
index 6f64aa6931461d..3aa1e93eaf4f8f 100644
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

