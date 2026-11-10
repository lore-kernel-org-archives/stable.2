Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794315559;
	b=H4HOy6cJ5FBzpb4GGD6zmT3EbBE+q7tDIROG1rMxEPPyj/FVyTG6Lex92eB3QNSh+axW
	 ZR5MoFFtMZFEl0myOj6X9MLE5m1/WdXOt8utHQegDoeNdtnUdoLYqBAC2ASlh/6a09sGa
	 4urTy1O04gsCWMBZ8tABQ1F1YQ8om78/XUbcdeCvG7OjxLuQMfZII59Re4rDgsT82BUHD
	 KEW91xEerNnGiSrNDrCxFBKcxhwSVC+F61wus/ZShGpnvu5pofL3OW56REY3Mo3/ldi/Y
	 ZFpeKt7GURTQWe0khqE5elhVproYu0hcTFzvcHEgVCkIVyniuZNi9v3lzUMVne3Ag5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315559;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=2I2iJzPyd/AEFVdKmr8Kv9bzEeBw3Z9xLDXyvyF91b4=;
	b=zt8VWGSsA7nfiqIBl71jE47wiVzYJp4gPHikLNZ7p5ZQZRJ3ezKZ0/nBKq53rJqD3UER
	 tFDbTrdgVPMnvQ8PSGwsdlbJNBpcJxaHtYUiH/xAo/HlKdy8FseMn7rS1oCRTbDhYGkj7
	 TMLwRzV1nKovxT6yhWles4eqDrwncKmZLEUJ85ZRsGTwQL6Em6h+0dqgCVsACvI9RitwZ
	 5MrXigoWy6WRFy9SaicKisEZk/EC4FlKCMh7djUzlCiQAkyQ7gAwxaUdmSa322wT4To1z
	 VGRhZeyldOhrhLyO3Zhc7hmvCHG4VWzet+Va695a7DYnYFoz7AqvWV0axpRiwgvbVlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oY+NUnc6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA56606A76A
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oY+NUnc6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5583E1F0089F;
	Tue, 10 Nov 2026 12:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794315558;
	bh=2I2iJzPyd/AEFVdKmr8Kv9bzEeBw3Z9xLDXyvyF91b4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oY+NUnc6F7QLpm7cIj5ONJzSzZxW+UDc+LakTU7gxtf6+Q+daTNYIEqt1ZtOWWgNT
	 Veyf9iy1L8m7DMegkjLYCCBv/2e4Kmge3of/WN7+5COdOxpieHglCQLL7K/omx3U7S
	 Sq/zBp8tiyEYMiWU5wE1fSUiLV4dx7kM+z6RwuX4aIO3DeXUmuMpriY8oba/zMWqgT
	 SLuRUMvhHPqMgIoL/X6JIeTpDuJXVlJ9IhxI4E04d1QEQkgfdlW62Dksak12Tdox69
	 EDAQ8KOK1jNyUeBZT22epzjW0C/OtVRWSmxK1QY101CkhzlhBRSWqgNzlBMriaSFFR
	 lX5IP2+hofanA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] crypto: omap - add omap_sham_unregister_algs helper
Date: Tue, 10 Nov 2026 07:59:16 -0500
Message-ID: <20261110125910.1551368-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107050702-failed-6.18-be51ea091c65@kernel.org>
References: <20261107050702-failed-6.18-be51ea091c65@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thorsten Blum <thorsten.blum@linux.dev>

[ Upstream commit c3494e6fbb35579a131de11369b658a59b1323e5 ]

Add a new helper omap_sham_unregister_algs() and replace two for loops
in omap_sham_probe() and omap_sham_remove(), which also ensure
->registered is reset to 0.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Stable-dep-of: be51ea091c65 ("crypto: omap-sham - fix crypto engine cleanup")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/omap-sham.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/crypto/omap-sham.c b/drivers/crypto/omap-sham.c
index ff8aac02994a4..7b3612d097700 100644
--- a/drivers/crypto/omap-sham.c
+++ b/drivers/crypto/omap-sham.c
@@ -2041,6 +2041,20 @@ static struct attribute *omap_sham_attrs[] = {
 };
 ATTRIBUTE_GROUPS(omap_sham);
 
+static void omap_sham_unregister_algs(const struct omap_sham_pdata *pdata)
+{
+	struct omap_sham_algs_info *alg_info;
+	int i;
+
+	for (i = pdata->algs_info_size - 1; i >= 0; i--) {
+		alg_info = &pdata->algs_info[i];
+
+		crypto_engine_unregister_ahashes(alg_info->algs_list,
+						 alg_info->registered);
+		alg_info->registered = 0;
+	}
+}
+
 static int omap_sham_probe(struct platform_device *pdev)
 {
 	struct omap_sham_dev *dd;
@@ -2158,10 +2172,7 @@ static int omap_sham_probe(struct platform_device *pdev)
 	return 0;
 
 err_algs:
-	for (i = dd->pdata->algs_info_size - 1; i >= 0; i--)
-		for (j = dd->pdata->algs_info[i].registered - 1; j >= 0; j--)
-			crypto_engine_unregister_ahash(
-					&dd->pdata->algs_info[i].algs_list[j]);
+	omap_sham_unregister_algs(dd->pdata);
 err_engine_start:
 	crypto_engine_exit(dd->engine);
 err_engine:
@@ -2182,19 +2193,13 @@ static int omap_sham_probe(struct platform_device *pdev)
 static void omap_sham_remove(struct platform_device *pdev)
 {
 	struct omap_sham_dev *dd;
-	int i, j;
 
 	dd = platform_get_drvdata(pdev);
 
 	spin_lock_bh(&sham.lock);
 	list_del(&dd->list);
 	spin_unlock_bh(&sham.lock);
-	for (i = dd->pdata->algs_info_size - 1; i >= 0; i--)
-		for (j = dd->pdata->algs_info[i].registered - 1; j >= 0; j--) {
-			crypto_engine_unregister_ahash(
-					&dd->pdata->algs_info[i].algs_list[j]);
-			dd->pdata->algs_info[i].registered--;
-		}
+	omap_sham_unregister_algs(dd->pdata);
 	cancel_work_sync(&dd->done_task);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-- 
2.53.0

