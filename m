Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794317556;
	b=QwVJKMN7CsmdR2IpG1ZMRQONAK+Y27FtggodP+3MO7eVI0QnxFtHktGGi8cJXQmOmRuM
	 C853+xpG80Dl5v81noagXyjpslBa+yFgplauK33bAdoDyBDGkxG7xGKSO5EZ7TM7nTD+G
	 +cWeN2VJ4GPBvjWAmRDise0Ad63TwxzffpWQlEDfjrUCsDXikKeiLyKR/BBEnqzfw508Y
	 6ovJl22cUVndmdPuanDgFGYTybBj6u5RtD1QTBf7KvCKsuu/z7pUU+zM8X4OlKU5neI9a
	 Qblz832rwA47+ScVjvey7rJHOnGvc4vReXrLJoZwsmMs/zpBNjPdgoGzfypZHiJ5t2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794317556;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=gmobt+ly2qXTYRWa4NxET54RUy3FVuN+bYFaqXxD1jw=;
	b=LZcrbxvKeCkZlvj2aT3Bmi3N4wir6qHixLVYr/wh4b7LIx3jaSM1ZVVOhCCX1ifHarEZ
	 QjbQeuqAIjXj7dnfBBpecVgPfCMks5VaMBFoXUbLZ5lO2Bn7rHFXuohNoGTqFcMnLCN+/
	 2ugF2E4qibulSwNVruU+gJWAgAZCyT5yi5XX2NMxVS7N47zHGEW9hahoVxa7045d44xa4
	 TdwEt9muLJVFITKlZqfJEDaWEkl7o405yQHNTrDINz84d7Y6Nm5bYZGMv7N10SoYNY0H8
	 YiSzSM7nJnJNKfffwoCtvgYjGGMSzjZqSEHUhBzxOdSwwDLE6dp8MhG0bIp2MnBbaXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UoduDSOl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C08606B1BD
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UoduDSOl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 192581F008A1;
	Tue, 10 Nov 2026 13:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794317555;
	bh=gmobt+ly2qXTYRWa4NxET54RUy3FVuN+bYFaqXxD1jw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UoduDSOlnGYkK0mUT/8qry9kxqf0+vTPF8uPQU5Sz89rOrctGNx6xUkwgy6TFR4gt
	 c9/KJJU9kVke9JNXDozPwnUG8qR36nM6WhBV+XZqu86/FUcxoopt9ON8cknDBYJowz
	 DNZdLSJ5xSGNzywcBagKID+oVqNzHD/Yv22WgyQFYQEbgul/NLXxbCL+7GmnaIGT3Z
	 nLg8TMQRZ9nAXHTIiPbJpSp/J2Y+sADXCoftOdmOf+y+sywA6U9QsbXZDj8XGlR6nt
	 LAsAASn5LUyDyhM6IVsJKo9MAk/Em0/VI7CN8fUV0ijE2759ZMKHciY3PUIKVVcjmx
	 8+GPQySklhB9Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] crypto: omap-sham - fix crypto engine cleanup
Date: Tue, 10 Nov 2026 08:32:33 -0500
Message-ID: <20261110133226.1743213-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110133226.1743213-1-sashal@kernel.org>
References: <20261107055912-failed-5.15-be51ea091c65@kernel.org>
 <20261110133226.1743213-1-sashal@kernel.org>
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
index d541dd17afc49..7120539cd9229 100644
--- a/drivers/crypto/omap-sham.c
+++ b/drivers/crypto/omap-sham.c
@@ -2224,6 +2224,7 @@ static int omap_sham_remove(struct platform_device *pdev)
 	list_del(&dd->list);
 	spin_unlock_bh(&sham.lock);
 	omap_sham_unregister_algs(dd->pdata);
+	crypto_engine_exit(dd->engine);
 	cancel_work_sync(&dd->done_task);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-- 
2.53.0

