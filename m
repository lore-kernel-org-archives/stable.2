Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792594250;
	b=g/ufMd7SSsW0tj3tNyEE8xpPTADiIAWlRBRmV7WCitmid2Rfy1yqvsA1ApIvsAspGH7C
	 cdkrMB0DZ+982uLcAuYwyApOniuYV0AlDXHjFT11Jlpa9xFgSjm6NleXnDBQtIV+zNJGq
	 lU41mYwN5qPYOIQrIHwaguqli3Bp57zBLVJUwp/CmpwEOr1VhURVvKa69nBOelTahb4LI
	 Q6fDWmgQapCLpQNINafjiQfVYGYUZIcy9cgIDrq/1xpA+VMCGWMQzxeIT04F142FqYPfH
	 f9EUpSMiTWgD6MQ50G/64aHQsj4YhisCOnNJMWWhql2SPxHWx1Bswnr3YG7XwgixTSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792594250;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=qiDp5PBuAWD81kWqOjTWbSIw+rwX2XGFqa8uQWAqVo8=;
	b=fRTN5dLhuxyFcLVQ9OTUtN0E+hC5uouyYRZvun5I2sLWVxyJVfX+9SsAeZlXvsVmmEks
	 11AW/vqr+PTW84mpTIJFfXpsHXd8B0yDZefBYd/KbxpHK8rzXBIty3SL4xxfqSzN/yWOt
	 O7S3Ip5Oq9L6KoWIdpttj3yCvPD8lnpSj3nm8ZzB5MAxj+JcqplsttTFFTRk1HpSeDyfb
	 wBqXd/W7MP1HjvjPAkQfRHtSo8hA3OYJAVOC6LP5IUSEcvYaRELVCDVWPS4y6rg1pnsV4
	 Gzo7X7PWA2bQEGMmpZ45M9/pd/2kDxEMeFn0D7/k0KlMyx/pvCTDUuRIEL7GtnB2g/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=du+DUL42;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8887B606A319
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 14:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=du+DUL42
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D574D1F000C2;
	Wed, 21 Oct 2026 14:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792594250;
	bh=qiDp5PBuAWD81kWqOjTWbSIw+rwX2XGFqa8uQWAqVo8=;
	h=Subject:To:Cc:From:Date;
	b=du+DUL42hwVTn1nWXTvN9trAfCdc3cyVsXXlLXjFMJiotQs/tGqz2nvkC902/h42B
	 /sjI/LGY3GixJT5ZOrYFRcuezdLH6WM6wo+juzGbLUmyNSVtCDMyY0ZbvN9BNcC06f
	 Psi/WWGN/ZIki0K1hbGmpodmaMBDYBJw9pwtCjsU=
Subject: FAILED: patch "[PATCH] i2c: viai2c-wmt: Fix clock leak in wmt_i2c_probe()" failed to apply to 6.6-stable tree
To: vulab@iscas.ac.cn,andi.shyti@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 21 Oct 2026 16:43:01 +0200
Message-ID: <2026102101-diffusive-dawn-53e3@gregkh>
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


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x aaabefc79b0ff0018e8e3832169bbe359d0551fc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102101-diffusive-dawn-53e3@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

