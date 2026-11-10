Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794317555;
	b=Rrpibfe1qhh4h6Mk3xwZHErdCucEXtHgt6UmySzpr53VaGMDE544W1gGEbpWLIETqj9w
	 pFt1BfU1+DLYZ1DFVyM1EX3y+vsP5mcOWgvzbR7zmY7KQ9BM+otwWp5In4y+q57TMKMZc
	 b+oJxMrNKETzRKcvRqFyxuQ+SGSZmSGiKphQUZi2tQWUBnngsowQuKzH70qeugmqog+/6
	 /7hg9T5cJULK7D96m/8lbOrG56MG+CQu6rEPXruVQgARXTPI+6tKU1J3L25+Alk84CjFC
	 0TQiyGSbWJ9lOvdRd4Txq98qNllrcz9v5hh4WKEiIls8B7tTKW/VM4AOUqZV9oSNZwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794317555;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=eWH7HI8eoypORE3miz0mnUoiGem3MyILwOqm1wLGabA=;
	b=BvNnTS2UQOAk9Zwtc1JBZpR2hKu3T6rU9T/plZqGUq1aateR87o77Irp5m6EVl4iP5aY
	 Q85yvixGEywt8g6/+LTxRR5bG7HB+MLbcYCmK2nksYVCct7rA5W445jhsfzL0GafUVbC0
	 Z0dRhcqZHOQydnwa9ljrMDztV/JFl3xw6Q969ioYe96o5PCPsJJ3LmC4o5eR8hnUtUFuk
	 Il4hqFHIrfZPUvBVWI69xdH+kDyrZqXdi18IYKrg4VmnpS8vZUtuNrjZOk4bMGQwFx/T6
	 1Pn5Gvf5fDMtfwfR/NAoOv7CfDCq0ZE0W5YWVXzVAu+PZM9Wwivaz/szgNn0Dej357Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OYFBWQOd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF31606ACD5
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OYFBWQOd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D24D1F0089F;
	Tue, 10 Nov 2026 13:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794317554;
	bh=eWH7HI8eoypORE3miz0mnUoiGem3MyILwOqm1wLGabA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OYFBWQOdNNWxMvFe72HT5llMqbcwZYedO73UBVy8K3wlK95yjiAt0wTzyIAxVLqRl
	 ozy9ntddfZS9Slssf8dfg+xO0bwDUqTtf6H5dwN4Qx42AeyNDZReSLOpqauL5pW5mv
	 izcSbu7pW5/6TauOE3MYJcgZbczbRi2srZwKIDS04bAbaTGqb0NXLXZZQXlPBECRAU
	 fHGZdgd6U0+kA+hl8/yUyVKnrTIU79876SAYdT5a2JK9xtIhsXz5xImVOIwHJ7v0Xc
	 f2AjDIRRaCjmPlK46MYqjU12Ad6WodW10w+w2w7b3kbjPx620R/odA56/CzB+gTtDD
	 N16jPwSMyGG+A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] crypto: omap - add omap_sham_unregister_algs helper
Date: Tue, 10 Nov 2026 08:32:32 -0500
Message-ID: <20261110133226.1743213-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055912-failed-5.15-be51ea091c65@kernel.org>
References: <20261107055912-failed-5.15-be51ea091c65@kernel.org>
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
Depends on <20261110122229.1112116-1-sashal@kernel.org>

 drivers/crypto/omap-sham.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/crypto/omap-sham.c b/drivers/crypto/omap-sham.c
index cfa448732fc04..d541dd17afc49 100644
--- a/drivers/crypto/omap-sham.c
+++ b/drivers/crypto/omap-sham.c
@@ -2058,6 +2058,20 @@ static struct attribute_group omap_sham_attr_group = {
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
@@ -2205,7 +2216,6 @@ static int omap_sham_probe(struct platform_device *pdev)
 static int omap_sham_remove(struct platform_device *pdev)
 {
 	struct omap_sham_dev *dd;
-	int i, j;
 
 	dd = platform_get_drvdata(pdev);
 	if (!dd)
@@ -2213,12 +2223,7 @@ static int omap_sham_remove(struct platform_device *pdev)
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

