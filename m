Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DAE35BDA4
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 16:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782404705; cv=none; b=iGKxIymrHviLOHnSY+RYwWd/e3Ph578gWI06KzsL6rL0ucbIxX5iY92e7C25HrE2XbeCg8xZt6GVD+zNHdP0BlBUeeMsvA0VT3UHR6iyQ1KxIJ5/cLozyQRq4Md18Uvy2rCWjS8FmOvejUXRZa7A04EcO/ky9i33dZmjqXZkOl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782404705; c=relaxed/simple;
	bh=+UuKqUPjAsse8iqTr0BJdFZzThyHEkkEfUou4yYGSlk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TZy2C7oxFCRC64HWDm7MIAVcnIX70OXM4uO3ubcTip/2Wv1MtNnKQnAK2zPA2Nniiu2pNfkxBUHy+/GaowQCyrMg4iHFznjPiSY3uqlt3SYe01PFmUw1YeUOM6Oo1t7Ah59KTGsYUxvJKXLtE/FvJtHvZfL/cC5K1QMawnbatXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TvyMkwVg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TvyMkwVg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF99B1F00A3D;
	Thu, 25 Jun 2026 16:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782404704;
	bh=F7RdwslqSPn8LnlxtwgBZ3iiht1bM+ig9AK7oEo5Qgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TvyMkwVg2LcS6fi5FVhgJIjCO2OuLD39HVdAhQynhuNmIJbQyQiTxbyHSD5d1M3UT
	 foccOwwJPrF8TmmuF1YossmxJa8UKoaFid7KkXUHjWSBP1JWsi2ytwlRXpgU72G/Mu
	 8GQATUbeJf5/kXonBXJaQiI4ZH+IbskGsGNtI8AbWAwOhthXe8+G7k8jhq6rPJpo+/
	 3HFk6tYUWEjGhGWQ/56Z8NUNCnmbIFQCjbkFZXDiCQEf8NObfJVkbsrOSStgQ5OTk9
	 L2S5NBzzvVdO1k2LxK/PpDHchk3Ph/vr0PQpuBQ/zs2lvptZZN6MS35h1HLoghVkTL
	 qX3vKqU5ygpwQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/4] crypto: qat - Replace kzalloc() + copy_from_user() with memdup_user()
Date: Thu, 25 Jun 2026 12:24:59 -0400
Message-ID: <20260625162501.2500811-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260625162501.2500811-1-sashal@kernel.org>
References: <2026062533-retaliate-surfer-c663@gregkh>
 <20260625162501.2500811-1-sashal@kernel.org>
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
 drivers/crypto/intel/qat/qat_common/adf_ctl_drv.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/crypto/intel/qat/qat_common/adf_ctl_drv.c b/drivers/crypto/intel/qat/qat_common/adf_ctl_drv.c
index 29c4422f243c66..ff47b47e01301c 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_ctl_drv.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_ctl_drv.c
@@ -91,17 +91,10 @@ static int adf_ctl_alloc_resources(struct adf_user_cfg_ctl_data **ctl_data,
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

