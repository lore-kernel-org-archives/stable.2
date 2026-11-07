Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046632;
	b=ns58/MNhc1+MFeamCHfI1JFlDqg67AxIdA2wX60nGGXgckIMYjAji54MS7nzMvnLju6f
	 jq1JKlApdJrMkxAJQm0bKwZ5EVrkk58fgdetYCLphGOl0/S409iukQrE+KssT+mrm+Pft
	 Otw/YVoOCwlH1bi47mOusast/uStr6YnHw16aNOLq93I5/VQukV9Uytapne+ImXVq5af7
	 1aBoFKVUg3xiXC7ND8yYgnULg3oTwN17ta9Ik5ZsJ93PhzzQOoeFPZFZtztQ90quOef1F
	 J/K0BhxMmMskRGPnffhwFH4tJd8/laNC7Wfx9wojCoQsilhHBCwP+mEjeUb94Ra8bzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046632;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=/mP5snaDYiEHvQjcCeYcGDhnNtP7aK6EK+24ThI/L1Q=;
	b=wWWDgWmvSeiqQ45+U0nJnfChTszL7avf02p9ULHCTbRlZEitr270S/6Rk5nb8D+OGCJg
	 dabqWRFepnH9yQ0ieIAz/B2k5mkDsSkrp9iVjPIUP/dCNSDhQd/nRZDtYLbngtakMp34e
	 akJJgGLFlc1NfSgcvfBKiT8urcxOuG8Qg3OMSusVbpwV8XvFwzaggWKGCXjpz3ElJnARy
	 +2XhI5oL+EVr8sANoBaUsTJxJz266yGjDTwEXCN5rmzYZDq6I/Q9f7FAIEghNguSCiqxI
	 4Ac87CZ6iSLroF3/7Y5rmqG76I2wxXflZWbE+0RpNB3lWgX3dgYPryO45WKdU15LGXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G0ezJvjp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B966260A3831
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G0ezJvjp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 368A51F008A4;
	Sat,  7 Nov 2026 10:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046631;
	bh=/mP5snaDYiEHvQjcCeYcGDhnNtP7aK6EK+24ThI/L1Q=;
	h=From:To:Cc:Subject:Date;
	b=G0ezJvjpv+12PED7kTd0JYkuS9pfsy3YapcrfvquYYEhy7WZSs6GzryDP5mkKxxrx
	 JyCni96FIOnIG6AZ3NFiSmoUn9FJb3UtLCJ298YYz2qIfEJ+uPGRWZm9k5p2RCHvx/
	 8Se6ueZZ3T56REEKPjun5t+70ZwaGXlCsONkaxp/xXHifkDGTFuXpqKY1W984tuIiA
	 zEfyitn8AXZoGmMGYrBWGWqPm9ReWPc2NCHurL6HQ7NJSa7ohe2cDWaGRuKyXjrhmc
	 O17Vk3eg3FrT3CmmZLPlNaeLKyrtCj3TiF0VDPmSVJIAXxLdQZz31Al7wmMo9rzCPd
	 uecrTgY0uc91A==
From: Sasha Levin <sashal@kernel.org>
To: lgs201920130244@gmail.com,
	herbert@gondor.apana.org.au
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] crypto: omap-des - fix crypto engine cleanup" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:17:10 -0500
Message-ID: <20261107051710-failed-6.12-5d69ed4cd4f9@kernel.org>
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
git cherry-pick -x 5d69ed4cd4f9c68ff9a6ebb2e8a1079223a4ec6e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051710-failed-6.12-5d69ed4cd4f9@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




