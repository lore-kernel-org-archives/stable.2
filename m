Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046630;
	b=X9ndQdcl+wU9hll8RqW/uY8A2jCCA6renOlaj14GGGlJgyz7g0P8xzRMekb1EMaRHBtV
	 mwag22sH+6TNNKT4bQCO/leLTRrzLMGgfXlRs1EphXjk676xAdFLou98yHjDVYRTZlaDF
	 V+LMHrOFMbMheQBSQUfEq+jIWcspGBVTt3Rx27XoRzsRwTKmYWQ42xdW9AMWn6ReWtKZc
	 OcIHnvBXQjEca7l+IbGCVWbEN81PRPuDvVdd/YgZdJzOFgRQXlD8hZL33Pid192Z+BIkn
	 38HpMlif+q+cSSFpSopUU1kaVa2mSSEnU/K6J3nJhFRECGQVytJK3RvIemHUvHY2i3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046630;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ichDEStHTNnBCSRKla3r7OSDfA5BZ8JXoxdLc51to04=;
	b=bFkuzeUabFe/B0ne2Efncwpi3wk1lXuJAt184dw3/S/q68R0Y/5XkSCVLnGLhAhGZVNB
	 mXGF38ZoYIDYUmTxG8smgVGoyE5LDcC/L/4q0YzVDahn7YJyOWyMbw8rmA0rEJIJCAYJD
	 lrCl6BCpOdbidHfO8xN8U6MRl28VbytCiTK42yEWwjiQGTXvgMC82RZEBqlzkccn6LyHG
	 lRXPZRzIp9+ZBIZyaTjbDpox+8Yn8RZsBQPJDUDEzvhIQQcyjpkFXtwN+0Fz5DUdNFXI+
	 WCUrndt9nrJ5vaAxQdUE1vY703DEHDAn2gNIZD0HEg77ACJKwAjuYjBgksMkfgXT3MA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kXaaAFbi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF3160A3824
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kXaaAFbi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24DA01F008BF;
	Sat,  7 Nov 2026 10:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046629;
	bh=ichDEStHTNnBCSRKla3r7OSDfA5BZ8JXoxdLc51to04=;
	h=From:To:Cc:Subject:Date;
	b=kXaaAFbiG7HLo+i5r5No11ghzrJn+NYikZThT3jSACWAr16D5OJcvF/sTLi16tmGZ
	 z6n4VU7SlhplB6cSlBz2PF4Zsd8LXoWZGiJz89QZkV6sgU//+/407ckKctIrAO+A1G
	 DSpBxjEZxb0PAzf2B2Zrft/pghpvPlhBqVCzTTIK5/4ppDyQRi8iS0qNlf6Xf+TU9J
	 izJ/crcqt4THblwuXeOmD+TBgtEiB4FDDz0Y4Q+nGVV4WCOzbL8hYYTI0ME5s9Lc0D
	 VO8/5PZHsGnr1tyRVtDPt0g9Uijw/viXoYU96J3ZWyGlRgBROD6hnJCduhlU3wXFlK
	 wh01vhCIBtojg==
From: Sasha Levin <sashal@kernel.org>
To: lgs201920130244@gmail.com,
	herbert@gondor.apana.org.au
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] crypto: omap-sham - fix crypto engine cleanup" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:17:08 -0500
Message-ID: <20261107051708-failed-6.12-be51ea091c65@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x be51ea091c6563158531e8c74e040552fdb1e28c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051708-failed-6.12-be51ea091c65@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




