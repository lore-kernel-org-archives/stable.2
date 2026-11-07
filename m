Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048134;
	b=m4dSF00oGC+mesBkOXlz9tjSE9se15FzpU5pIq+pDPYFBv0JHNDj0yVbwU5pL9mRNlzi
	 IjEqmvxRMe/MemD4K4Hu/paRanWr0PpcCGDIE8mMpHldPOfwi74BPqR/6xd0LdRHgVREH
	 CHKvRftWGiueyYe5Bc6hSZAqJVnbSGewH+on1M8mpWAMnt0wJ6KcoqWutiNTLpPmjJ8zX
	 gg83O9K5hC5r/PIYXKq9TqRhiawem6omJKUm4hgaZy1TxEq2GW4qO4PPHuCfLma6p3B73
	 LwWlA5P664F6xusjmkO/JqWtjWZ2RoN84SVsG1XQaiiTJeXt3DIMfxuFfM0ahiBM13A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048134;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=YO9Dwtaw0hlhkco/TtYb1rPdz6jGAQUxnrqUmUexq0k=;
	b=d24XPwCrpAiuVIw8t33A0748lRnwMY2tS6s9xxy7YczOrEPNXRDKlfQNEDjiWl5jGVvg
	 XwqUzS6q6XZczn1lcwaeofm+68ivZU7NYNeZjWc0ILEKfgJQ8FvtpJdAzl+tiIqCdtd4j
	 L7SraHOEa1kth1s3oaVjM1TGJv18NfYyDk6lM3TQGmRFE9oznJ0l+YsHqiNWdp9M90oRy
	 +0NLH81vnAl/dF4wC2cvim+N9fyJ+zKQxjEjrJuDTVfDn379HgTVlipc6kBVKb/2Fh4DX
	 WF7QEKd61W7O5C6fXpbtVR169XdsqKVhgDDue/uAqeJQFLtpRPOfyCJrYS34zXKy5DQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="R+/0HgBJ";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38D1606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R+/0HgBJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EE7A1F0089F;
	Sat,  7 Nov 2026 10:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048133;
	bh=YO9Dwtaw0hlhkco/TtYb1rPdz6jGAQUxnrqUmUexq0k=;
	h=From:To:Cc:Subject:Date;
	b=R+/0HgBJWGbfNSKMsZtPB6HoyNYlMZ0q3BsnpIjqt8Wem5vmXCT41N6ldQ3dDeCrG
	 CEJ8yBRBBMXxXsh/9mvoZtH40oMR75aW9pTCU2U6OT/Qez5aDUsRJB92slbSt1UQD4
	 OsmV3j4HW176cDX+S+h18c2cI3JGynUbK6RjosJBCUM7jsoxREEJgTm5NXJuj1mdgL
	 z8UgssF0Mgk5zfXSlN518C4lLDQKVRbhwzaGF039dJ4pVoTqn8qrrvH/9x/BaqqR8N
	 SO2eigBkcQ5Z3OUuqMvFSS3SamHyqTBGkkfaR9JchIDH2UfH4Q6SLJm/ikEQblu8/z
	 pIzKNT1b71tAg==
From: Sasha Levin <sashal@kernel.org>
To: lgs201920130244@gmail.com,
	herbert@gondor.apana.org.au
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] crypto: omap-sham - fix crypto engine cleanup" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:42:12 -0500
Message-ID: <20261107054212-failed-6.1-be51ea091c65@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x be51ea091c6563158531e8c74e040552fdb1e28c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054212-failed-6.1-be51ea091c65@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




