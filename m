Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794313363;
	b=P48JCFKXSVR+qAShQyHq+GNGZFRTNMuJ1vObRSw90LDpUZMRyAXrhKqLKLu78eTAhVg+
	 CDJ1C9Kb8samKxOQPpaKgEe6/o+FeAbhvrpdQsA96lbJx1SYWdvN8n2fdEieUO1mS0FpX
	 0U3r8gY4t6qtE7pKCqMdiVOzQBqeZSgAxEbQG+BX4a11Wvw9a8Kcq8qANgdMzuE37NJGO
	 sb3TKc7Qla8DPXAr/ceq/dKyqPLVPEJrRoCFYOR1HYK0yRM5EnWhR2PzDZMuvFJ40sB6s
	 SHhZ3L6BpJKn9KIW0eKWlKb8DYkV61Hwn1Mh2zLFsNc91MA/RlhmMUO8c0fKQAKpiog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794313363;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=+VMmD2OLSiDzBMu8mqUntftzZxOcDGuFUhEr/ttVZis=;
	b=dlZNEeMZXGcEVrhJxatwu+djfisO+ysBk+p1O7ekjpmwLmDVUj4h6hpWX/ScZF1Df4Ss
	 ia/hjDUEl/KlsMZabSvSiu1HSgCue3nwbJ0D7EEBBr9VZSeXP+KAAMLYCWYBtRbw8x5zX
	 CsSiUjb6mYzSabM/0gHfafpQXVyuvD1dUiLg+BiUYQM6O4rhXdOl0IPzU+W2Bq47OVfJ+
	 x+bCNyIu1urMN7jVZjAtv/A0d8ziiH8sOc4PHXqx/TMNhk5zQPT+m7ofU9CA7jDvhYo8t
	 ajTtH7lQsiz14l+yLn2vwjqeAi8zOR9SGQTx2NOBecstMx5iVZ8teALVi0yMb2lcL0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gu6WNOfC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C107B60A2607
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gu6WNOfC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE1E91F008A1;
	Tue, 10 Nov 2026 12:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794313362;
	bh=+VMmD2OLSiDzBMu8mqUntftzZxOcDGuFUhEr/ttVZis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gu6WNOfC3P/i4dpMB85zcDiNQ7nO3Zb3onIBFd1Yr0NCAIxMAGwkPVRJAsyqtSq5s
	 H52ItmzHHaaAk0lV0zz/FDpSekILL2MQ9N9RoF7QEmsgdYmEv+0Jig2Qv2i+hU7X8t
	 dl+6/6ed6dUG+0enDd3ZVzCXCn5FJltalJoFS5R2QJEEPeAt0RuIqyn/X2+4+2PmDP
	 Kbuq6WQq0Qt3f8V4FkterSHiwSBx1Vg0cm4uc0ugbgXu3kS+x02M0fOlSltJMP4+X2
	 JF4/AvqAqKSM7yTEuopuDn29RMCIXEBEbaKBPHaQQ/YoHkil7gphTZAtIDc7tdUhw2
	 EX28L+Qbyp+Gw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 6/6] crypto: omap-des - fix crypto engine cleanup
Date: Tue, 10 Nov 2026 07:22:36 -0500
Message-ID: <20261110122229.1112116-6-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110122229.1112116-1-sashal@kernel.org>
References: <20261107055909-failed-5.15-5d69ed4cd4f9@kernel.org>
 <20261110122229.1112116-1-sashal@kernel.org>
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

From: Guangshuo Li <lgs201920130244@gmail.com>

[ Upstream commit 5d69ed4cd4f9c68ff9a6ebb2e8a1079223a4ec6e ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/omap-des.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/crypto/omap-des.c b/drivers/crypto/omap-des.c
index 84e3e69a406fd..ad09560c9f4f4 100644
--- a/drivers/crypto/omap-des.c
+++ b/drivers/crypto/omap-des.c
@@ -1098,6 +1098,8 @@ static int omap_des_remove(struct platform_device *pdev)
 			crypto_engine_unregister_skcipher(
 					&dd->pdata->algs_info[i].algs_list[j]);
 
+	crypto_engine_exit(dd->engine);
+
 	cancel_work_sync(&dd->done_task);
 	omap_des_dma_cleanup(dd);
 	pm_runtime_disable(dd->dev);
-- 
2.53.0

