Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046024;
	b=vTlY1341rQjkgdL6uABe+csEuSw/F0nKmGX1MNWspWKxUDXArEsjBumiAEXlwyM75H2Y
	 kKZaDu/6nLXE2TuH2xr4u7Zdjd3PFugEg1JzUBTacXGVskZpIF212ent5zaH7l8bHkMFg
	 cUBh5XtobNJekXK6GBl9n9cChjbP+67rBx0F0Sh5gnQw4Zg29bJ+gS8aD5ZRU+M7rqCS7
	 C39Yyc5jSb4zXl9oBU9VxMateG7Go6CKfYVXIdCDUtKeEQAFVLsX2Z8yxhHTYcYJREsWV
	 UPg5hjR+RENtGb+qc/3M+PKCzdBlazCv5mRD2ZYEovh7QNOrV5YMMPpinehtYmY2s6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046024;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Dnx7HGMuNoEVH8wF06wcr5pSye5FqyKbd3nI649x+uQ=;
	b=Dz+ngidHDQGZLjnpfcUaUm11Kq5Gw612+KQm5MkfP453JiIVTro4ybNM6KBjsWyhH3Ly
	 wgOhsns4a2fcXA9mMZQ8db/DsS3g20r/+7t+FDMsYltkgYFAvT7DusUlEnoKUQ/bTcp20
	 Xsjv6UFyyeO99jwLns3G14KMV8bCfW69LZmBGqpsnyC3qYG+AKTbc3AOue7vgfAS/s/w9
	 +MDHVTiKfOYCQGPVzSO4FR35YYvfUk0JKVN8HJoACbKvwF8p7/QxmmoOPRz0Qp4eegVUZ
	 Dm4jKHVCtn2cGDpI26mOV8Xk1io88NooXXMtOBJKSTOysNCNbiuQjyhM9EFZBhasqZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="cfoS/sy/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB255606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cfoS/sy/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27B8F1F0089F;
	Sat,  7 Nov 2026 10:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046023;
	bh=Dnx7HGMuNoEVH8wF06wcr5pSye5FqyKbd3nI649x+uQ=;
	h=From:To:Cc:Subject:Date;
	b=cfoS/sy/7J3wZz0RNO7CRtZF1PimmNcLyMj4CbDVzowv+6ztiA2X6HiwesArUJkOU
	 mpS/quh7vFoSn4UrfuP3IneLZqGsIkqcv5WCu2ryMqBWIvCMp20342lf0fwLauZj6j
	 m2tXIjSJEgzvLSYIxIssn0yIfaip/oeIqILkoQMCff5WB9xv6o1KKaQgXqnyOLaHxe
	 piOmRGYilSydwZdN+Qh3S4ep17JyFc5j15TNpz6ODlWAeFAbwh1IA9+aWtHx0lOr7Z
	 Ak/YVN266zdL6ff9/Wb3i7LueNa6SICjeqsIMHU7Qvza09z+YliF2VpHxsNyXEOHLQ
	 Fpx/Du0KzdW8A==
From: Sasha Levin <sashal@kernel.org>
To: lgs201920130244@gmail.com,
	herbert@gondor.apana.org.au
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] crypto: omap-sham - fix crypto engine cleanup" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:07:02 -0500
Message-ID: <20261107050702-failed-6.18-be51ea091c65@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x be51ea091c6563158531e8c74e040552fdb1e28c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050702-failed-6.18-be51ea091c65@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From be51ea091c6563158531e8c74e040552fdb1e28c Mon Sep 17 00:00:00 2001
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Sat, 12 Sep 2026 22:46:08 +0800
Subject: [PATCH] crypto: omap-sham - fix crypto engine cleanup

omap_sham_probe() allocates and starts a crypto engine, but the remove
path does not call the matching crypto_engine_exit(). The probe failure
path already performs this cleanup.

crypto_engine_alloc_init() creates a kthread worker for processing
requests. Without crypto_engine_exit() during driver removal, the
worker is left running after the device is removed.

Call crypto_engine_exit() after unregistering the algorithms and before
tearing down the remaining request handling resources. This stops the
engine and destroys its worker.

This issue was found by manual code inspection.

Fixes: 133c3d434d91 ("crypto: omap-sham - convert to use crypto engine")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 drivers/crypto/omap-sham.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/crypto/omap-sham.c b/drivers/crypto/omap-sham.c
index 12d6dc68438a7..5e739415a0102 100644
--- a/drivers/crypto/omap-sham.c
+++ b/drivers/crypto/omap-sham.c
@@ -2129,6 +2129,7 @@ static void omap_sham_remove(struct platform_device *pdev)
 	list_del(&dd->list);
 	spin_unlock_bh(&sham.lock);
 	omap_sham_unregister_algs(dd->pdata);
+	crypto_engine_exit(dd->engine);
 	cancel_work_sync(&dd->done_task);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-- 
2.53.0




