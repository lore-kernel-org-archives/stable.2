Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050172;
	b=L3EpAvpm7y4sT6AeFSyugRopOpl2iX+kgcuaJZld3ZcqeLuX6XHzehVSrqWCSnT3br5n
	 I9wiSxE5Ffu0pOcvN7/kIgw7EVlBQG3Zm2K5zgfgigkOFap7FIIPxc2FKZoR1IjbQhHlx
	 vZABMwPQ+D5GYYoA7ibB9G5tq9CBbJOy4PaJxO5HXX+FCPbc6YnB8gLaijhguEAUcjxbF
	 I14tz7IbzhFNzDeUhhNHBWmQxjBwe+o+H2AWi6FjiJ03QkrJYTSxYMkhya4xUQiNuJ02o
	 Xg0X2cBoucV2BBkTt2lRMIR/xS5cFbdXxIXGDqdkDfJKjMfYvXwLXCGKjP+RafTPPUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050172;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=C40/w9roYf81ETyCl3mL0Y99uWxWva2Nrwl9dcNdkY0=;
	b=3kjTiK/LiurHP+kl9E1scz1TdzmR0kfw7hM//MPYAV3QbiGr8c10SCpH11lhC+/URD0M
	 fc2pkK0P8OuWoDtzQAXeSmweo/GKKaBdqt3nQvfFG8ox9bibl1MMx8d2QJJAvByUXGkPX
	 nXkaQEwerIdRDp0l0Kk8r3tfuO5UjGyUoNpaFafuRHsCkmLOKWCrRIKWehjWg/lZrzKeC
	 C8O+L35Tyy/d4FJrq3IoRNeTsRfdYzgf/UmP+zOdASCjDV8MUoWg5jJHq8bN58P4ZuPZb
	 ebmskYkm1J3GvRiWZRmQCrayszdIMFj2gKEsJrZPVsEwBbsg4ZatwomGZlY38bIJwLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WGEvH5mD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBF0606A330
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WGEvH5mD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B7861F0089F;
	Sat,  7 Nov 2026 11:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050171;
	bh=C40/w9roYf81ETyCl3mL0Y99uWxWva2Nrwl9dcNdkY0=;
	h=From:To:Cc:Subject:Date;
	b=WGEvH5mDvI0SvxYRJrdarig87LHaAzYSt7BsBnn3cywdLGV8Muuw4DVVIJ6rx/8eO
	 1sen2BAGv1E6ahhvzGHsS315mEpTCioXgjzNmz0tnqiWcxmHWKZXm6/MVWk6LgjjTl
	 TLaspBXuKYK33LdzxdsKTMush0d8QU2lBYks8Cw2pu70LgEHkscr4zGA5Z9tfB2odI
	 9xJj3SKvHCAClo66QKcP/bFXoebqKdqD9zQ70Kip1euL+HpoECLO7O84Sp1Nz3j2nE
	 gB/hDZwhLkLfliOVml5aF6kRQA7hxMrsECnCiRNF9VHDBiFSqJPRlOuEgTL0SM9C9j
	 6rymw4MxoBR0g==
From: Sasha Levin <sashal@kernel.org>
To: lgs201920130244@gmail.com,
	herbert@gondor.apana.org.au
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] crypto: omap-des - fix crypto engine cleanup" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:16:09 -0500
Message-ID: <20261107061609-failed-5.10-5d69ed4cd4f9@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 5d69ed4cd4f9c68ff9a6ebb2e8a1079223a4ec6e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061609-failed-5.10-5d69ed4cd4f9@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 5d69ed4cd4f9c68ff9a6ebb2e8a1079223a4ec6e Mon Sep 17 00:00:00 2001
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Sat, 12 Sep 2026 22:41:16 +0800
Subject: [PATCH] crypto: omap-des - fix crypto engine cleanup

omap_des_probe() allocates and starts a crypto engine, but the remove
path does not call the matching crypto_engine_exit(). The probe failure
path already performs this cleanup.

crypto_engine_alloc_init() creates a kthread worker for processing
requests. Without crypto_engine_exit() during driver removal, the
worker is left running after the device is removed.

Call crypto_engine_exit() after unregistering the algorithms and before
tearing down the remaining request handling resources. This stops the
engine and destroys its worker.

This issue was found by manual code inspection.

Fixes: f1b77aaca85a ("crypto: omap-des - Integrate with the crypto engine framework")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 drivers/crypto/omap-des.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/crypto/omap-des.c b/drivers/crypto/omap-des.c
index 3b7104cb4487b..4b5a8d13f505e 100644
--- a/drivers/crypto/omap-des.c
+++ b/drivers/crypto/omap-des.c
@@ -1082,6 +1082,8 @@ static void omap_des_remove(struct platform_device *pdev)
 
 	omap_des_unregister_algs(dd->pdata);
 
+	crypto_engine_exit(dd->engine);
+
 	cancel_work_sync(&dd->done_task);
 	omap_des_dma_cleanup(dd);
 	pm_runtime_disable(dd->dev);
-- 
2.53.0




