Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB1F22370A
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 02:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791166203; cv=none; b=MPlkPcEVuUUUNCLO67kdc4jHtgQxKPmEH3QSjJ9ilF7iAqPwWGo8UKX8Dm1mNs6Xp4vGV/bFElQMNpWgKPd+ZwiM73rdn1bb6hV/5fpzuOFq4Gtv2y7ZXO+kb/o5Tf8DEUs6+XD6cbLoN+9IyosUkJnlFzcdSUv94zIqMf2Rajo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791166203; c=relaxed/simple;
	bh=3LxBqxDesbMGsXZXW6uNgZXjNDljQeDpexjRPYSjNkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AfqeLh0M1vFWHEPFZj98cSDSr3BwoBiEnxJ6RwqhNoVpH9nR36Q4Rvdj1L0t5NpXPANZRCAFomxexoEHve/7HXG86/P94lIWqVXi6TCj0fRNbPxLyJ0QzF4xVKQmn3XS/a6033mQB3ozTdmdlclgOR2SBeHhuhFjQD2egzyNGPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=igSnD1ZO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="igSnD1ZO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09DA21F00893;
	Mon,  5 Oct 2026 02:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791166202;
	bh=m+tqfCCSBod2RGNhYDCWrLm4jcIvI/f7GRqdtaqmTR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=igSnD1ZO6xLT7CsLMtkQMDsvuZ9WC1wEi8+u+UsK01YZWBQkOvPioyp18W/FzuoI6
	 PDqVlSd2Y52gUVFQFq9SXtTPz6F5p7gdApF3tjRqIw64ATmT9DieimK6ie//uChEYM
	 Gc8HIMx8r6hHFVZAyX5ADkcSyNvngb/+quuElg0wqH3qepQxizMXl3DCVHL4zEaBVo
	 2UFW/9emrsCnYvT60YVqi7VEFG/1Xg66iAoiFPltAHg/efQ9z3gNDobu6EL/Z4iPcQ
	 HKP05AZYy/sC24JI9PJTeghkyt508n2GedYakX/2vpPKF1aHqYyU1/CY86TkJ2YsWG
	 eO1dy06RMRqAw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/3] wifi: wl12xx: Drop if with an always false condition
Date: Sun,  4 Oct 2026 22:09:56 -0400
Message-ID: <20261005020518.1103315-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100447-retainer-dude-dd4a@gregkh>
References: <2026100447-retainer-dude-dd4a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit 69ddcea564437ce4b0d5143f37a9154fcef8d3d2 ]

The remove callback is only called after probe completed successfully.
In this case platform_set_drvdata() was called with a non-NULL argument
(in wlcore_probe()) and so wl is never NULL.

This is a preparation for making platform remove callbacks return void.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/20220715224619.ht7bbzzrmysielm7@pengutronix.de
Stable-dep-of: a8b8881d0c1a ("wifi: wlcore: Fix runtime PM leak in wlcore_remove()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ti/wl12xx/main.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/wireless/ti/wl12xx/main.c b/drivers/net/wireless/ti/wl12xx/main.c
index c6da0cfb4afbe..d06a2c4194479 100644
--- a/drivers/net/wireless/ti/wl12xx/main.c
+++ b/drivers/net/wireless/ti/wl12xx/main.c
@@ -1924,13 +1924,10 @@ static int wl12xx_remove(struct platform_device *pdev)
 	struct wl1271 *wl = platform_get_drvdata(pdev);
 	struct wl12xx_priv *priv;
 
-	if (!wl)
-		goto out;
 	priv = wl->priv;
 
 	kfree(priv->rx_mem_addr);
 
-out:
 	return wlcore_remove(pdev);
 }
 
-- 
2.53.0

