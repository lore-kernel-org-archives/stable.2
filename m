Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792594262;
	b=Pqkh2abuVQowr2u7VMmNe9zu6HSlI6sthQomGMwqHzmI8QSw2+jI5Z4GeYr4WQd1BwZp
	 I9IVmzVR+86oPUsb3dxBf90qmqrtKnUnOPxQ6XKW/NHfYn+1LMEJexWn8MWjnPVeNs06K
	 ppGSJ/rgMDN41aGCmAEKv93CRHvy+zICugfcD8DzH+xoi1JP0ywU96rIz4kfYYOrZj3Qc
	 Sk7YzpsD1Cf9371KkamthQtSBfzC629S3c+IJWIf+QrM3C7qRArZT0AEhAMTUNbIqEQ2P
	 cRJpC0Bm/E/+dw25EOqVUYi9uup3wtLYDWzvLRce8tiD7A9uwa4zziOIPwlClFw02Mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792594262;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=5ZyrN70pIIZSOdyjVnRNE/80t0rqv6XKlTOUdWsuyB8=;
	b=OdNviOFbwODrkH4GSI5IQ5csina6RXpzJ3SZpYD4yVDOB24OItiQaAzA1sMscqmICcUM
	 cMDqiN8jHv1kYuL2KOLe7PnrlNhskHzgROmmoMjYz2Tk/G5kVL3zAtDpr0uEmiyU9GKCg
	 I1sR7QixEy6bNeDqWnT/Y07WldLO4wpPmM4MS1E6fsXii0cFxkQ+MsLycjHOjbeF3HFBV
	 +pnzHSTBIv+PpRSnjTtOQTamZhjMv852tenJyK2crBiodBob3qBlSj9uO930e9uUiGo41
	 Ca2fgMf6oYWYNwsQJ1mlgWKC5tkMc6GVgX7EBD1tu/ABgXQODUMVpqrhMxHqRrehEoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=SRPAxZt9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D9B606A31D
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 14:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=SRPAxZt9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F1931F000C1;
	Wed, 21 Oct 2026 14:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792594261;
	bh=5ZyrN70pIIZSOdyjVnRNE/80t0rqv6XKlTOUdWsuyB8=;
	h=Subject:To:Cc:From:Date;
	b=SRPAxZt98QvOK+9a63kMZDLO91qMUmvitBp/btTrdj9vHGRZEaS1JKii3r4rA4Y8F
	 LBqrxmNzQDkVNhOAMKw9qeEcIvNKg/XEobYubU1JC/4JpE7vHLlHD3Bl8mKXgerftO
	 WKgCSC/Fl1k+kJToEEeqMBkQney0bQ8ruNLL318A=
Subject: FAILED: patch "[PATCH] i2c: viai2c-wmt: Fix clock leak in wmt_i2c_probe()" failed to apply to 5.15-stable tree
To: vulab@iscas.ac.cn,andi.shyti@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 21 Oct 2026 16:43:02 +0200
Message-ID: <2026102102-unafraid-triumph-de54@gregkh>
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


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x aaabefc79b0ff0018e8e3832169bbe359d0551fc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102102-unafraid-triumph-de54@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

