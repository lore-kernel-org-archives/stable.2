Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316676;
	b=Vi5EtiUXiKQCSiqdmsqxYlPSuKi2KrXhgbgbJq76sBIsbtoL4yWZZELieiwNf++3Adcp
	 X+R0W/sQuZHGa5rIWl897FvY389soJiuUU7j02uB5DYQyyUl6wrwR2z3d8C7ol4zV0h+E
	 aSvAL+rlboO9RAkkP/8/Dao4SCiIs+cSvOdLXyjkxbB4av+5oLA5wns4kApEICeFHPmYh
	 pF23v6sKiiAHSWB9+fmGK+5T6LF1fZydnfR//B55TK/jSBPGhpRU2iO2w/LCBnEycIzG6
	 RQnFSOGjqi6XElkF8OmMbt8UoYSvuWHiqdZyqNwYjU1XaX3D9H5GfmYR5ie6CjvB73g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316676;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=H4h8OyR6ZwKd2i6OUi/QfzD2ghZki1WfP0wcD4u2kLw=;
	b=Dgn365plNEEAdMFLHUWf1zhrQp7cAWJIV6GEtiCiTTbnVaKnjSNFQf4Lqnd/dmgABDa6
	 ZKIXL4ntRTNnR31x26CrzrUgjiTbt32qmUHdwpfhm6+N/Opae8KKlQvU0wHUXqIVW3UhP
	 mQF9stXu+ZqRJXxPYyHBH7DYV4UZV0TTkvSu4Nowcp/omWuPGpS/WXSqPsNB76fHebE/r
	 DidciCnOg+MuunIzOskKVbnVNES3tL4jmROhUWutre40Y5V570MAc5peTd3GSIgJ6TSSY
	 4Bq12KLG+UrYAbf/OgqcfijOsiptTOIXcDZa7p8nsUkAhd3VjTms12WzqMnV2ejvzsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oOvgObTI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80890606B6DD
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oOvgObTI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0A5B1F0089F;
	Tue, 10 Nov 2026 13:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794316676;
	bh=H4h8OyR6ZwKd2i6OUi/QfzD2ghZki1WfP0wcD4u2kLw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oOvgObTIlLZTMnyLcGA+87O1OvGVvHBO3DF4mVaL47p/5taWREcZ+dRrtUp6RxO8E
	 b/Y0U9bnHp0Zi1TmEmCgwWg8XbVkwuldjw1lgM+pp6vWIdYV+Gb67qL7Ot90KGmF3P
	 T1TzPemNU67toFRIjYunVVJWB37/2s30+kN3zU38WCE5dz+mNv9edOLB+uDmvjslEs
	 nzG8MG6SZz+e4C+yPT2BWXtFP9vlPsOy6vQlOqmlnTmsUnzRZGyUQVDuqpVvKWCvqk
	 qk2U4qEcmHelS6PG7m51/KQFr/9TA1ewXeYJKUWICjWos5Fm+/KkRefhowhbKVmL2s
	 MCXqWj8QycKVg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] crypto: omap - add omap_sham_unregister_algs helper
Date: Tue, 10 Nov 2026 08:17:53 -0500
Message-ID: <20261110131746.1696961-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052928-failed-6.6-be51ea091c65@kernel.org>
References: <20261107052928-failed-6.6-be51ea091c65@kernel.org>
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
Depends on <20261110120434.957099-1-sashal@kernel.org>

 drivers/crypto/omap-sham.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/crypto/omap-sham.c b/drivers/crypto/omap-sham.c
index 17b61e1770bd6..f1aa6996a13ff 100644
--- a/drivers/crypto/omap-sham.c
+++ b/drivers/crypto/omap-sham.c
@@ -2057,6 +2057,20 @@ static const struct attribute_group omap_sham_attr_group = {
 	.attrs = omap_sham_attrs,
 };
 
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
@@ -2180,10 +2194,7 @@ static int omap_sham_probe(struct platform_device *pdev)
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
@@ -2204,19 +2215,13 @@ static int omap_sham_probe(struct platform_device *pdev)
 static int omap_sham_remove(struct platform_device *pdev)
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

