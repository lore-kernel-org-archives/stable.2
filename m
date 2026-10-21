Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792594259;
	b=XKRbtXJydQwN3ervGfCCvfA6M7V/6OHu+Hox3365zWrojgXkI1v1i2GW7tonm0BiOAbn
	 KBUkgGl+JsFzanc0OesjnipiTggVc571P8+cKI3YDC+QFZFzhgIiBgESlXjbzVoLsfS93
	 VsYhH50Ozo8BzulKFIf/+PYcQiZhDNwxHJGYke25hnWLLOs8HhtKCg+cmDSFG4bt3n7Km
	 RuFNak1kmyP1b+Wvq9nesTBKSkk1s/ZqBnNDkCD4kR0FixazoL6HOml/caEmFZz5GW/VA
	 zH6wkdu+S94mda/ZhFD1LNHRfgln/y/wrF51IH9KvRS9n9PozHKKVOv6CMzV40Ci/0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792594259;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=wsI/CfQTpLvzWOyvI4e9MwAf6BBw3xAacNQluOHekX4=;
	b=bXyIAVLHirPC4DS8qUOuEwNT+bTiNfJabmySNdIHkoLqiP0QIaOVDUylp+03/UeEJGU7
	 xa6P8cf5Xb22t98bvur5WQKNqt1dL/+LTgONxe0yXBrJ9IM/tb1CYJvDfbmnjfPTx91xj
	 9qY3yILuDORFgfF3GGtkJAsGj72n7OwBxD3I7orwT0rOU6BTtgY6ZRukjjaKzbOR6TMXj
	 mkYh/1qPaTMagUPfsOr1/mZgqxCDjNJibvTnQmSznUiUfrDIHJiIX+nQl2hG3WDgLm7rH
	 CViur0L3LMbyfAh4YJyOeWOIOq8OyU1NZDOK0ePeSq8goO0iD3MEdnhUfvBtGc7CmMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ccXUtDjK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5E3606A319
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 14:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ccXUtDjK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A9B11F000C3;
	Wed, 21 Oct 2026 14:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792594258;
	bh=wsI/CfQTpLvzWOyvI4e9MwAf6BBw3xAacNQluOHekX4=;
	h=Subject:To:Cc:From:Date;
	b=ccXUtDjK0a6zhVMuhdEhuJ2r3TXl1vfaWHhOYr7vNWK7o9VhFotNRTHUOXPLPVV2a
	 NrEq8j/PV7r01b9pD/q2/Ev2iZlP8jFx6q01rMH4oiyZkvQSc34YhC0Xv1p/XjN4ya
	 wt+JlcKi9l0XVr2JK9etY59LwEpXmO+FgCtldj74=
Subject: FAILED: patch "[PATCH] i2c: viai2c-wmt: Fix clock leak in wmt_i2c_probe()" failed to apply to 5.10-stable tree
To: vulab@iscas.ac.cn,andi.shyti@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 21 Oct 2026 16:43:02 +0200
Message-ID: <2026102102-plasma-vividly-b482@gregkh>
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


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x aaabefc79b0ff0018e8e3832169bbe359d0551fc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102102-plasma-vividly-b482@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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

