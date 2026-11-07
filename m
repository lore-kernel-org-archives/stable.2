Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047370;
	b=KN1Fb1gmsgZTPE1m0bh4DGq+LXuFcBJ3cZ+4dRvd8/UtIA5fWM+kMdzExn7ivLGrjErh
	 OOXP0w3wRqyclic7zHozx6lTrU0SDL/OP4UiLxyBKuaUYrdKcZTfbs/yo+zqQNnw69WMx
	 +8XJMbV+HqJdQHQCvzL+pKKn4BEIY3595z3Y0rtwS7qvhJcIl+7IPmpTgGmPtfxlbz+fK
	 r+vT1A6e9/zBeztDXhzHBVyeyMOR6nBDAgjYM7lIIKpvMs1N5b8Ue6OmjwaFLEMLwfZKW
	 16RPctCdJSsc9v+/l4zpfpb/7k2kMLhObePEvjbmO4PWDXrGqmUAe1fmhGFyIVfYNXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047370;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=IINOrFJ6V2+3mCtF6VfOD5OP8IfD/fgxTFeN8oPqIbI=;
	b=nuVjpGoUAYcyH1kXnlR4J5mJ1oNEjqJaRnPbmPkw4bFgonTTkp9/FjY47Csm3YsHhQPD
	 +qVd7Xc72MHNq9oWH675qe5Rqbtyh1Nwo+zAcTjy/AiIoCyhyAwp81wqIgk6BDiTQiRrX
	 cqjtY8sq0U9838kGS37BueLCyYCzrM4OYC1I4TRamOovVa5yk3fxiEmmoWEr/SVwMW53j
	 ofuvXTrvsnlNi/CsL1qjF8cMju1fUYEB6ECAT07Yyxs7Bqm5edTVE+XpZ0XKG2vL0MNcH
	 //qvZ7EiUfie5IMiV8e5Hka3KXksR4/nxsLomzdY7SGO21WAzk2ylZqtvWebqQyiisw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nag1xYdV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D182D606A32E
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nag1xYdV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D3D71F0089F;
	Sat,  7 Nov 2026 10:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047369;
	bh=IINOrFJ6V2+3mCtF6VfOD5OP8IfD/fgxTFeN8oPqIbI=;
	h=From:To:Cc:Subject:Date;
	b=nag1xYdVuM9DbTiOSprxbu88osamumTt8NabaeJqzu727JSTYO7t+XsE7p4ENJKiQ
	 gZ2XKG8h1nrV55o2TgHHu5mYhTu5eTen8+jVXz5SyPrbyMx+YjJdAVisPaofAs+kx7
	 nJ5JHxsaW4OpK3grfSLjj+dpnrx3fNf6c1/gFydSIDAeqhPXTNjgy3Wimj2ghNpjhx
	 fOHQPjNXuJk4MtoahlkY/xJO/fBPw0UgpVC3uVhixnqvW6pbKxIiOd24Ri4Zx/7yny
	 ClVxbuOSIpyi8oLPO+JnpS7BrpdrKgWSeF+i6D4INepaZVeebqefLCqg0jrc6ykZD/
	 UlG97c1fs3Xdw==
From: Sasha Levin <sashal@kernel.org>
To: lgs201920130244@gmail.com,
	herbert@gondor.apana.org.au
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] crypto: omap-sham - fix crypto engine cleanup" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:29:28 -0500
Message-ID: <20261107052928-failed-6.6-be51ea091c65@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x be51ea091c6563158531e8c74e040552fdb1e28c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052928-failed-6.6-be51ea091c65@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




