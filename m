Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C3B365A03
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 06:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791182451; cv=none; b=uqwyldLgUoQmafPMq3c8ZmQnxRPzT2reThS+o33LmgAQzWDCgQ4ozES1VUaYWnUWoCd1oFyPyzs14oT6zSpmWtvm5C0eotlsgxhZMVmcnXoXDa3iZPfxi/r0qapnlOBzWx2a6jN+gYZcu8zvFVnXxV2FajqcD5asasmrccwg8ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791182451; c=relaxed/simple;
	bh=3LxBqxDesbMGsXZXW6uNgZXjNDljQeDpexjRPYSjNkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PLwl3XWplII1oKqoQtMPMLtEi6DoSqKIag8SNvVC26euDAN3DDCclTzrbhHdACyAHMN417Ee4rzCn2kM/CHHmwfy5/YuqbqGhBaR3ZUKBY/KTSOYVIDAgg4vbmxtyRU2+pqdUhLD8eYWiq22JzxbZXgUjwxiPCYGbo+nhh6n2ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EW6anBW5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EW6anBW5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA23B1F000FF;
	Mon,  5 Oct 2026 06:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791182449;
	bh=m+tqfCCSBod2RGNhYDCWrLm4jcIvI/f7GRqdtaqmTR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EW6anBW59vvkMy+tpKRmhLffyPZsKydQiscdAl12B+osW5gW3KA47t9AkceMMCFUD
	 KzaB90RtwEMtWkeCNK+6FN29PH9FaqQQ+oL0mCR3QUVmc2HSmY4venv3TgUInPLz33
	 NYnN4qY4IRobe8locohwKjePXrWP6gg3dBd1fE6JbnZinvFBePuYrXLFM//Z0AH05A
	 786lJ4mKEfHcdm+VsW3q7+cu5AbecmmkFS7ZmShDjgNlQnNRfCcjvdII7+IiImfSMX
	 5byxTHBArWydSJu743cYEFfjAQUZPBH4gzDtmXUjeinfa8y8qgu8XgRUn+65FSSZ2c
	 z8W+qXuOtWJdg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/3] wifi: wl12xx: Drop if with an always false condition
Date: Mon,  5 Oct 2026 02:40:44 -0400
Message-ID: <20261005062850.1329066-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100447-glade-qualifier-5a63@gregkh>
References: <2026100447-glade-qualifier-5a63@gregkh>
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

