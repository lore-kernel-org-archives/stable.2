Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794315560;
	b=CC82vtjQiTAcyD4MXTj76LrcFwHLUv5FffoVs0/xlfVhQxu2f4UjyIRI1WILgz/49Js5
	 hpxRQNgtWMGMlN0WqdM0wd4rLxAXWjAc3629mGzPg+zh62XxVGz6BNHYyVMRcTCKFWHVV
	 Ya4u3Mix4hnMUxRv6T1WL8/xCa1R+XhEYFowSQDbj6toKAjPIE01HslAndHutZO8F7Kq7
	 cYncGkBVkE8guxQZAAc0YCzb/DvPdEcn2EqsHtO5/FeiXZXJso2HRXXKKWLSajlYv8Td6
	 F6NhfCsBm5/lffNMmUY4s1OM1pTEPacwOePLlZHNCnqngIhnQgKaZF1Grx36lD4kjGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315560;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=l3ZOOtIpP2N2uZuD73F+41ENnWVsK56IKWEhvw1L3I4=;
	b=C/fHNn4DOvMM07d5kClDP1x+muO2krpOh/yD/a86xzyEC7tZFEyYM+73wq0sWSl7FmNR
	 xXxPWAIPvF2FWxeZWrFfi45AN+stjlt2W+4FgyhqquYUFSJ7To5Nsi9QbDocKyAN6tZvZ
	 g2ygaQ0JeAazYqotB9TrN/dphx9oiaMpVOVeNs7DC8tsg9VodBLbTP3NLxfGzpjxPfjLq
	 raK+X8HCWLrlHOuZxgbDVK9VkzzV421u/Vyct9I8qQOm3uNkHiaWPr/c8XUp/pr+ks4KH
	 fpgnQQUeNx1SyW4oF6fJyugtR3QO+OdQNl+p+TlbvkphEBDTuJ6yXUYSM+//Ux/EzPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cnxftQdr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5C6606D5C8
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cnxftQdr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29A841F008A5;
	Tue, 10 Nov 2026 12:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794315559;
	bh=l3ZOOtIpP2N2uZuD73F+41ENnWVsK56IKWEhvw1L3I4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cnxftQdrneowMwXavT/OHArY7oe/clcMzIkPXrdDPGylcnS+R85rDT3+ql3Y1DZS7
	 ThR0UjJE0MDdBiGTmkL/ZuYi+f/FN/9+k34LRL0NTvLk1zer5RH7Xf/giCsnEcoXiO
	 A7x6r1EW6QMGq/L0wvo5FwhLBOvTJmRGabJtbr7GQMfAa430iznjwfIsq9LFPBaH5P
	 IHqyFbg1NUudByGVbkzb5/BBxDdQQiqocFB3RPhvo+odqTBaH+giQzIKZExeQrdCMg
	 YkZNd8GRfrzINXYqC3MHbtIOjXGnUPF5OzP3W8Hy6d4refHFzQlN3F7thlxOiDOTCH
	 DKk4i6vLWLdug==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] crypto: omap-sham - fix crypto engine cleanup
Date: Tue, 10 Nov 2026 07:59:17 -0500
Message-ID: <20261110125910.1551368-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110125910.1551368-1-sashal@kernel.org>
References: <20261107050702-failed-6.18-be51ea091c65@kernel.org>
 <20261110125910.1551368-1-sashal@kernel.org>
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

[ Upstream commit be51ea091c6563158531e8c74e040552fdb1e28c ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/omap-sham.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/crypto/omap-sham.c b/drivers/crypto/omap-sham.c
index 7b3612d097700..2cda2e05ab42c 100644
--- a/drivers/crypto/omap-sham.c
+++ b/drivers/crypto/omap-sham.c
@@ -2200,6 +2200,7 @@ static void omap_sham_remove(struct platform_device *pdev)
 	list_del(&dd->list);
 	spin_unlock_bh(&sham.lock);
 	omap_sham_unregister_algs(dd->pdata);
+	crypto_engine_exit(dd->engine);
 	cancel_work_sync(&dd->done_task);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-- 
2.53.0

