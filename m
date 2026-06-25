Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB0735F8C5
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 17:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782410170; cv=none; b=Q+SdjCCQjF7ZGJvmdqKTuuCwjrPmH+Qf3v7nnpQADqaf6UiyCpsbNEqNhZLGfSc8errHql8lG4UZb4DR93JncIfeWGuUi4Htn6IyxPWy74slF4jKGPHRtjuuoHX5a93VKyNi7sZZ7USV4XIP38St0MCR02z+5OPkqxKYTgMa9MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782410170; c=relaxed/simple;
	bh=9/hXovOSfVHRUhHpw22A3DwxKoaIGDJKlj/7GrmPcjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mjVzgH0tp1J/IZDHaajZ6mfe9TBVJMTsgKyFOENhungYTxVdT0tXVDyeMYKTzHipGtw+4ylfw4Alej4YGuVSW6VpDw8br7bd/64zLRgAEKPLQ73MUP5nU6hNOECHTgVZHExj70JTs8Sbbra99rL9ej3dLEpLO73mt0F8kLC4vV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LzCDM60v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LzCDM60v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5900F1F00A3A;
	Thu, 25 Jun 2026 17:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782410167;
	bh=cdZR9oAP6r/RMtlmxoPmfyCHQcWZX/jV7+hTF4Uzo8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LzCDM60vgk6v51MNX2MzG3OgQH9RuuGh0Xw7Ix1H5SgYe5CViWtkKh/BK7ieqoxgx
	 7AuTj/YQtNm2KEUHDDXtpVPzGqBFjkHOBM0s6Gzkq4QC06QrsXIxXC2be4pmJWwXO2
	 L4OLTVZi5VnOSdabflXpbHqJyyRmD38PYUBRJCNibshPxXuSjguV+Ll+7n38mwSLeQ
	 XQHyM7s/ri6SLtnPJWWrA3ytLfSg4rMDsXGVrG2PMv1xa4vdf93SGgfyImHwSGnZCe
	 yHp3ZpMZR8g25eC0HnxAdt/CIcofllxieX1zcc4gfgLU5bsgmfIUuBiWM/rI7cZXio
	 JzPMl48r2EmHQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/4] crypto: qat - Replace kzalloc() + copy_from_user() with memdup_user()
Date: Thu, 25 Jun 2026 13:56:02 -0400
Message-ID: <20260625175604.2543972-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260625175604.2543972-1-sashal@kernel.org>
References: <2026062533-verdict-shuffle-1baa@gregkh>
 <20260625175604.2543972-1-sashal@kernel.org>
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
index 82b69e1f725ba2..c74a92c00a9b4f 100644
--- a/drivers/crypto/qat/qat_common/adf_ctl_drv.c
+++ b/drivers/crypto/qat/qat_common/adf_ctl_drv.c
@@ -90,17 +90,10 @@ static int adf_ctl_alloc_resources(struct adf_user_cfg_ctl_data **ctl_data,
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

