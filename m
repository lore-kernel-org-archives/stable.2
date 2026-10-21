Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792594256;
	b=4GUH4x9pMCUrRuL0WLQQ5YXpVd0L4IKwS8pnZS5Os4/bYAgzZZTFRgL88VkC+XpoMqvF
	 +ynsl8IP9AEGDHQxiaFL1Nsvs8MgTJkPdlcNo+m5oQK9xHAymwIDQW5vqFau19j24Oq+J
	 ttB+tqk6IboHo6GkKejddNViVdkNfYViINGwfQKBIPEfOpc4trnTq+KWYWjTTTsa23FHv
	 22BnyF8U+jTIxEbRwktkyiqnXlYeAOMJz5f5JTxd4D8Fiws67ooc37xBvf4CnkiqnSEiP
	 zdW2y7ha7EE8zcQKoWKj0jFIIzOYpI+iSb+bqcy/VWizDzuRBsrJgpxK1FKR6r+/5Sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792594256;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=OxIGBjxlCzHQNUAKDgppo800bjW7XmCXCSGSkbx7Aew=;
	b=RtHT1TD/yFeJzzfngz1/9u/S7v0DaSO4m4oO2uB3+p/pINjiNb7eIsc2QExIAnyVmP6H
	 Bvzmcy4ySWy6Ldcu0+YZyU1j+XxOFCgVf+XZ8RIHC1FoEZcDHT5Ktg+5D1dyy4KUuv+Ol
	 ceWkYnOUqTC1YVc4i68Y3FxdLnpiQyiHu09ybBDvWcftnhi9iqnZSlOEY6h/E2i7Ksc0/
	 ACPh1b8iQF/v69s0dC+CegDxyOSpOfkWSA2BCQmq2VSPRcV5+uKp9Pd7mv5O2+dxY7g+z
	 +kqKFrLximalyrE0hfjxPNCU3uKiI55dZXPcIJ5i2qpc5E+W+dfLuqZcC1lv5RQDJZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=OlTEV9zT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CEF606A329
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 14:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=OlTEV9zT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BFAD1F000C5;
	Wed, 21 Oct 2026 14:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792594256;
	bh=OxIGBjxlCzHQNUAKDgppo800bjW7XmCXCSGSkbx7Aew=;
	h=Subject:To:Cc:From:Date;
	b=OlTEV9zTZ0318dok+2mFw4j8JBoLfJuR7TcE2aeQEi3kqadIkW+UiIKRaJYWMeAZn
	 E4WGzeGx9pFYY9D1BObF4H0uU+MhKBAwGrAoQXZ5y9xRRV10jiTUlOjBJRLTFrxNGN
	 tc7M+2evxMeBrFThOF9SaOnZMSQNHY9nApuYKsMY=
Subject: FAILED: patch "[PATCH] i2c: viai2c-wmt: Fix clock leak in wmt_i2c_probe()" failed to apply to 6.12-stable tree
To: vulab@iscas.ac.cn,andi.shyti@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 21 Oct 2026 16:43:01 +0200
Message-ID: <2026102101-rebirth-zealous-7d04@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x aaabefc79b0ff0018e8e3832169bbe359d0551fc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102101-rebirth-zealous-7d04@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From aaabefc79b0ff0018e8e3832169bbe359d0551fc Mon Sep 17 00:00:00 2001
From: Wentao Liang <vulab@iscas.ac.cn>
Date: Wed, 16 Sep 2026 07:06:31 +0000
Subject: [PATCH] i2c: viai2c-wmt: Fix clock leak in wmt_i2c_probe()

In wmt_i2c_probe(), i2c->clk is acquired using of_clk_get(). If any
subsequent operation fails or when the module is unloaded, the clock
reference count is never decremented via clk_put(), leading to a
resource leak.

Switch to devm_clk_get() so that the clock is automatically managed
and released.

Fixes: 560746eb79d3 ("i2c: vt8500: Add support for I2C bus on Wondermedia SoCs")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Link: https://patch.msgid.link/20260916070631.1965713-1-vulab@iscas.ac.cn

diff --git a/drivers/i2c/busses/i2c-viai2c-wmt.c b/drivers/i2c/busses/i2c-viai2c-wmt.c
index d3dda7534b0a..c10b4fd9b553 100644
--- a/drivers/i2c/busses/i2c-viai2c-wmt.c
+++ b/drivers/i2c/busses/i2c-viai2c-wmt.c
@@ -116,7 +116,7 @@ static int wmt_i2c_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
-	i2c->clk = of_clk_get(np, 0);
+	i2c->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(i2c->clk))
 		return dev_err_probe(&pdev->dev, PTR_ERR(i2c->clk),
 				     "unable to request clock\n");

