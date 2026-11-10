Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316165;
	b=EEjYHaFp2YB53kJ9LQ2TDDG1VuUNOcAsK47GYTXAR+5Az90asmiVIxjq6v/a3d47//LY
	 h4HQSGnLY+gZGSG5unaDvTbmmANs+cbP+wQxwQLUZ4XFaVDsoFAEUdCN4LvJpIrgkeGLK
	 vhiz5+6APthm2ussMpBlyds8nyvku8i39Pgtd8xBe7LRwWJChk6nBo5EzCAAs3WYv0Y07
	 qGKnS1t97/tn/WNlpPvUyWbmm/X4AzYlTt+OF9bDw4wr+NKH6wgtP6G1SpsXhH8J43Dld
	 +t7+2wuvUmh+krutMV5ADdcl6YiH6yyOLarm33v7f4AUvlyO2CCNPNSW6jTDJVTbaSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316165;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=NgVeZJzInmUaoZjKHvgGayn898M13kdK2jIiZPGJUHY=;
	b=15uzf/UUNWKMNJJEmG6zhvBqUpcCLYGAEHx6ms1XB2liRH35UPvFOgHxRaJRu5qzlU63
	 jUwZVpX5/Frtdma5q4f2GSYHsWXIa4KCqEnW2PmvxWDh8Dv2v9a3kOcXueCB8g8e/EDIW
	 myIGlsdfr5qxvuXb+hwSE2DuKPtNB09qb60XdJVuKe7wS2hUZvjg+WyMXXZNnSUEQ//Yz
	 kHdvaFhVInOWjspZF/fgH+m93xyn8ZdegwK5YayIHMb6Iq+8t/xmpzy5tC684+Yy1jG+8
	 YldAXn6lUjxs7mzQe5HHUN/1IXPhO3Tv5ZXbJbL0cUil9+1tjYxWvCBmVz+48kQe+Xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GnRl1x1S;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AC2606A338
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GnRl1x1S
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B4CA1F008A3;
	Tue, 10 Nov 2026 13:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794316164;
	bh=NgVeZJzInmUaoZjKHvgGayn898M13kdK2jIiZPGJUHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GnRl1x1SdrmqHXH7kAKUusQ8D5vYy+B9BePOw8sIUu4KKOEB3Rt3W5h0A5SU60k8s
	 YDer+NqB9pXOtYCnib1lij3SRGnRojy4OK2LnbDEd9O1i0P0kdUH7r33UW/6yocExn
	 ZWVT+V3WItHd+iupgjd1ux78TBmAvKc0UY+Pbxqoj0sfkDRZPPHtiATc4Se5NL61UD
	 L7xG3FqI8alYwz5WTPD9W639UaR+23JROD0fAVQ9WZ/bmMIRS/gyBaD2t7AJ38fm53
	 CZpqVkey4m7emU+XenrjBWH2f/ump948OOOeACiMdXV82gVBq3qf5p0S0rydeV4y+L
	 /uf+6IpE15jrQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] crypto: omap - add omap_sham_unregister_algs helper
Date: Tue, 10 Nov 2026 08:09:21 -0500
Message-ID: <20261110130914.1637426-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051708-failed-6.12-be51ea091c65@kernel.org>
References: <20261107051708-failed-6.12-be51ea091c65@kernel.org>
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
Depends on <20261110115837.921428-1-sashal@kernel.org>

 drivers/crypto/omap-sham.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/crypto/omap-sham.c b/drivers/crypto/omap-sham.c
index d17654c0410f6..51842cf61995a 100644
--- a/drivers/crypto/omap-sham.c
+++ b/drivers/crypto/omap-sham.c
@@ -2045,6 +2045,20 @@ static const struct attribute_group omap_sham_attr_group = {
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
@@ -2168,10 +2182,7 @@ static int omap_sham_probe(struct platform_device *pdev)
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
@@ -2192,19 +2203,13 @@ static int omap_sham_probe(struct platform_device *pdev)
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

