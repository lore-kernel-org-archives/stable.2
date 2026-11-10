Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794317165;
	b=XFf9YS+M86xjSEg4lbf0EoU7ZsztyHz0miEUrokAdjB1acnk+I4PJ9gTE04qoz4K/Y1v
	 gpslUo6PP/pjMoBXwYrI9Vvw2FkvwHCR7Zp4Y4AyjNKjYOU+tJCOpuHhfLmRxzOtvvGUo
	 HuLDG/l205mbEXXlEqoeEEbrIlS4Gc5X/w9/TuKkVtbQzzo2Uejlc4Z3pkIBucaPlkm7q
	 msWZenfyt0/LB+vvhTKpR1tUbg8H36AwfvEs8oKJI2aYJ2bQAREOaALtLPes0MN0ckBZk
	 EsQs0NDORvh7dOaG9CJhJHoRL9xSOzgU6D6a3uogbHwzyZn2yXWg9U2J2TvLt9IklBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794317165;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Z0B4tOBn0hBBOLh/fvOGtSSsUM4o/cBqaLIbRWZPaXQ=;
	b=ipezBBlkhSD5Ky2/z80DKTp9ox40FYjZACyQpBxXBMBKRIsrer7a23P0Qm3cl6k3lKzi
	 gweF8d0k5mhrdvBRjWwG4djbIMYF0ulwUUvmSVs/29Q6wWldZOEiXFcdGvwlnPANco+XT
	 q1e2AIrzZi+hd/L0rEQ1mPYzuX4e09Emp5/hmUuEuiqmlXKlqP84NuCsllsjjJQfVlKOf
	 Ch2F/V95F8j9lePTYV0nuOrmwvjBJ5fGT9dxrcwsbDNLRWLyg/wDs3xMUWuPesutdRjDw
	 I5Ic4dwdLL9Pa/Q+Rsa9h3EHhJbbGuYHsIn2uM5WIiaa8CZ55l/jhAv7EoAJtAPl6Ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oDDhJGgv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344326072A35
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oDDhJGgv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F6141F0089F;
	Tue, 10 Nov 2026 13:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794317165;
	bh=Z0B4tOBn0hBBOLh/fvOGtSSsUM4o/cBqaLIbRWZPaXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oDDhJGgvjKNhP37B0nXIGcInrPAWvaecYhdzZfwrbxJdLKFBryEvUmQVvQYnWJyls
	 MqZRBYNNyzNpBfjQT920Fl/fSWALtShtMROPEf7rRoI2O8PwjiY34Ewfe0LBbonRG8
	 pdQm01jDOte2R+mFGamxVCAU8l7EnH4W+IhXiBupekk4Bw9RDfNpy1d7CmdBBIQgNP
	 CgMC/F3h3CtDJcn9kGHQV3nvON089Ygx2aHSoFmrvFRLsb/1d8dY+u/vRmacEjSUaO
	 RBfWU8JLzAHvwnkLL2Qx89hK27mvNyQ2NEsYc9o3B9+LL2SNhBh2DZI4q9IPHO1Lye
	 2t2jLe4zDxoKg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] crypto: omap - add omap_sham_unregister_algs helper
Date: Tue, 10 Nov 2026 08:26:02 -0500
Message-ID: <20261110132556.1723904-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054212-failed-6.1-be51ea091c65@kernel.org>
References: <20261107054212-failed-6.1-be51ea091c65@kernel.org>
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
Depends on <20261110121355.981467-1-sashal@kernel.org>

 drivers/crypto/omap-sham.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/crypto/omap-sham.c b/drivers/crypto/omap-sham.c
index 225368f10442c..cc11bcc10e279 100644
--- a/drivers/crypto/omap-sham.c
+++ b/drivers/crypto/omap-sham.c
@@ -2058,6 +2058,20 @@ static const struct attribute_group omap_sham_attr_group = {
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
@@ -2181,10 +2195,7 @@ static int omap_sham_probe(struct platform_device *pdev)
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
@@ -2205,19 +2216,13 @@ static int omap_sham_probe(struct platform_device *pdev)
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

