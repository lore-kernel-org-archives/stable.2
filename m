Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049154;
	b=eZiwCZq4GrAc2koH0TGDgI7gIJ5n+Fqm5ODeaEg6ifKWm5k08YkzFfrd4wXvya97wOXV
	 VqRg+2FM4VZDnP/SMhdpM05hU2cDFeYNVqfQfF+c+xWJV70F0egsPJoSOTCJY1kDXsjMM
	 +fOs4+PnYKDrB+Jynx4cOOb6AObhDr/5WxS78oD84+PPIiCZyp7UQC0nUakn+Fnv9CGdN
	 8GCWYRB1SVVE6umEcSSRO+501bhgS5gAyoeDGv40s6mvpBVf3tD7CTEGo+njH0bENiSFi
	 xrdGJby66EtPwa6KU4J4uW9C5fGf6flcZUMNdO8jLPUkS7JXkpEh4CGMOUtmPNQjJlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049154;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=x79g2gdU6nk0h4/PhIJG84gAKIvmKduOOUfzTi+PoKs=;
	b=lzTyaNxbcgWL4Trfey1YQXvZege2NY0MSpeCQ1EvEva6xliiocC5HqjGIECFgkgj2MHG
	 tsFK/snyg0IaHYZXk4Mg/eRVmHfzt5taK8+CzHfGUKE7hvtzehIL2IkR14AHGdqdL2H4q
	 ecS05GGTpHsbdu44zbNi1L9w0hvzTui7BWMFx0amtrenNZ7FX5/LJVDlyCAEEho5NyRmt
	 EXPPCdFUOB5HrbceGeQokXlAMORdzDquO1X0FqMCNdeIIeeFcxohNL7evxRLJsfV/a6PG
	 mq97l2VhtvFJys8jlinwJWuc3zxVTCPRIYwBygCKd9ClCGJThVUn7981PxgM1aiJZCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hTmCGDhz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E265606A332
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hTmCGDhz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B0421F008A3;
	Sat,  7 Nov 2026 10:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049154;
	bh=x79g2gdU6nk0h4/PhIJG84gAKIvmKduOOUfzTi+PoKs=;
	h=From:To:Cc:Subject:Date;
	b=hTmCGDhzUuyizWBKE3E5lS+m05HSo7rGteVqOThPoEWmXM504slT/Tfq7MF+aYOWE
	 rr0si6++v5PVgF+mxdYKczS0Mh/w8qtAv5ZuSAZbcf79IwmvQnx2ev9AnuFj1q1v01
	 jVODiNdx0A+AgmjoUrbGql55NM6hi1BwBUREY5VNQsiI5rIMZK/9eylt7lWuzR3WOq
	 Fl9OKX/V7xF3d84KGQbYkig0xeBzu6gn+mjNoqB05euYjEEioJHSdOc8JXUtV1UnS+
	 GK1jmeyZ5Z5n0vacTJKg2JGFw0pG0qvssZLNyUqZEuYqIyzpz2hbI86lOTZjlzJx8W
	 +PMfQT5zaz9Ow==
From: Sasha Levin <sashal@kernel.org>
To: lgs201920130244@gmail.com,
	herbert@gondor.apana.org.au
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] crypto: omap-sham - fix crypto engine cleanup" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 05:59:12 -0500
Message-ID: <20261107055912-failed-5.15-be51ea091c65@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x be51ea091c6563158531e8c74e040552fdb1e28c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055912-failed-5.15-be51ea091c65@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




