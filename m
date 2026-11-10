Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316677;
	b=ogEex/Tj1LviQl5DkI39BwkJORKGU2L3XFCBsYXbKeCQVuzT3azwxalcAGccLTeeGn4k
	 kSYSlFMP3GgooTkhL/tHO9Ge1NeVd5oX1EeIOrNvAago/LecKBZ5FgOXNJkr7KXsfd+B6
	 eDUEP2j0wsqE6tP+2FIaqSIxexQdn3QYp4UME0YY8foF9XGlxbRbXF9GNKkn4Pdl+nIL2
	 be/9wnfFnnAgHQkXaP30/QoA3ny6HKKnF7ET0QHdKEovuFNm3FiLzLANwE1tTqUp9wNSi
	 j1vq1tFeXf6SOAYQmONlRhqnHC3/Fdof9DdIc9++ixm5DzFOhRhEjzWmdgTOg3ZI0Uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316677;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=9qKONuwmndGO48uuneCTs7oyk9EhUV0ajOAkOlUlsW4=;
	b=zrOlqucgY5J7Shh0GEd4v0d9KHBg/kSy4C5YhcZ2H1itLW52LhH61CoqCdJo3N9jLr7I
	 9Iggl7WegkzpHQjAEcKHrr9aMdrtZwidiqSlHmRXuXBp41SSrIidw5Svy0kdhkg9/z/uO
	 XXVqwvZL6k+mmAMrGxTTfqhYX+LjhFPgkySNHSo1iWni3ayzMVk0Z9ys8aSYIK4W0qZ10
	 VMUKGIhVj6jD9bY6QAvprLeHWjEonMlKnrtHnWIuhL3axS0mke6i7jljp6LuvWb7RriCL
	 N50PJJYP5lPb6aPDXZLnrYMNZW84SKGhwR8zQ8ZDERKQSSVT5BZEpSNlDrybI8+rhAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hSJJ2ctE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DE46072A36
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hSJJ2ctE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A45661F008A3;
	Tue, 10 Nov 2026 13:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794316677;
	bh=9qKONuwmndGO48uuneCTs7oyk9EhUV0ajOAkOlUlsW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hSJJ2ctEvAoZWgsxO4oaxETazLZP7yuEAfZjM3GnA5pVvXo9MUeif+ydy/fPgMbpQ
	 xNCu3aAkYeTjjoIqt/4zNWBmzooDddAjxWMQgZ/f4bzsl4JMLaM9yVOStGJAUgdZn9
	 SvzzGun5dZGAcVW7MQs6QiaJ8Bl3b4DPDx8IKFEZPW6PAjqfFI5YALKeaWSTt+pXWm
	 71kmPVB5IPiDdBavrH1ffV+qJZMYx6Do2vqSYi+tgt38sbKM2ybyEwXaEy+PI7pEju
	 AvGNf69nCEnRE4k6/tY8Nh8Apq+S2p6LVsLciz6VGkBSjYFFAFeVfUVq0efOvc+Bci
	 xI2IdRgaeHQmg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] crypto: omap-sham - fix crypto engine cleanup
Date: Tue, 10 Nov 2026 08:17:54 -0500
Message-ID: <20261110131746.1696961-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110131746.1696961-1-sashal@kernel.org>
References: <20261107052928-failed-6.6-be51ea091c65@kernel.org>
 <20261110131746.1696961-1-sashal@kernel.org>
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
index f1aa6996a13ff..19b0e7e6255ec 100644
--- a/drivers/crypto/omap-sham.c
+++ b/drivers/crypto/omap-sham.c
@@ -2222,6 +2222,7 @@ static int omap_sham_remove(struct platform_device *pdev)
 	list_del(&dd->list);
 	spin_unlock_bh(&sham.lock);
 	omap_sham_unregister_algs(dd->pdata);
+	crypto_engine_exit(dd->engine);
 	cancel_work_sync(&dd->done_task);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-- 
2.53.0

