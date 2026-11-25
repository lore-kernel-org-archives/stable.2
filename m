Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795604531;
	b=LsdyTyNjxIVKSLA+UXkATm2ARiN3z4OQSd7QXhr7wZzuJbZrKl/W3QX1hme5d+85q/LV
	 7GKd9FEio5BKMxSavExS503x98031PQ/mnpjbeeQSiGSZuc8oLksh8yAhz+z+Xish7GNa
	 e2DjVKH9wk22/PmcSrOkQuDIigtyJuwIE7YjgDSDvHG6X/NtEBBQYujDE10R+kSvBHpT6
	 DIuQP7xc/0iM/meGYidTYfV2M6kt5Pnlv+rVS+HjDvTSDS/iTc1xmxK7W0wi6ZjwxBXxN
	 ghkh1OzsXPKF3QY0I2gy3Aur/x8O7j5P0RXzo9r7Sj97P56irl2k2K1e3dHaReLl9CQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795604531;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=nwWZyN32fDnpYpVTQ60sGaYgTb7TV+Mjh2IUELOfSmA=;
	b=eXmr6LOVf3+a6Qt4VeAj49kyChZGuI8BJfg39QynZ0/yI7VuR7Raifq8DBVFPeakE/bb
	 mZ96XauWtQ5qRCORWeAtGMgrwf6GswXGd8xigFUwJQq0VnJdLn2Jmem16Uestl1avQXj/
	 QHdrSZVfN3BTdCCyKZIQlDjGWmm5ucNzccmcReSYSiSKSKrrwVh/Q9YRh68+8gY3IYgCH
	 tX2EEqB+3vHy/rSgjQN1Jmeqx937ir1TbUHP23MySGp3ZUW5ZG0eynqbtBlpY0l9NxRJ9
	 yeBj9HDfdYord3ciIXFSdpuFzaBuDBqUYfxGSYaHnQpEepyh/3rdyqgg2+voLl/S9xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=1J58TLyN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C80B606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 11:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=1J58TLyN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DFCD1F000C4;
	Wed, 25 Nov 2026 11:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795604531;
	bh=nwWZyN32fDnpYpVTQ60sGaYgTb7TV+Mjh2IUELOfSmA=;
	h=Subject:To:Cc:From:Date;
	b=1J58TLyNi4XGGCNDfNbg8/H0LdUAVGbnzlmICOdH5ar+o4CtBmnUfivXPb9kJzaIF
	 of4wRONiDnV5nnXch4tV7xPNl7MPu3Ch+YXzlLFfBz65ymin7ymK3s7v8KQXV41Uxr
	 TQQNod3eY+E7V4N3Q+BEqWtndyDHkImTBZbN8Zg0=
Subject: FAILED: patch "[PATCH] gpio: mvebu: fix sleeping-while-atomic in" failed to apply to 6.18-stable tree
To: bartosz.golaszewski@oss.qualcomm.com,linusw@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:42:17 +0100
Message-ID: <2026112517-rival-mantis-1c17@gregkh>
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


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 42269cdb3d3b46ba6e80f31d0e00d0bdcff1d8d4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112517-rival-mantis-1c17@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 42269cdb3d3b46ba6e80f31d0e00d0bdcff1d8d4 Mon Sep 17 00:00:00 2001
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 11:34:36 +0100
Subject: [PATCH] gpio: mvebu: fix sleeping-while-atomic in
 mvebu_gpio_level_irq_mask()

mvebu_gpio_write_level_mask() is called with a raw spinlock taken but
the underlying regmap uses a standard spinlock which can sleep on
RT_PREEMPT kernels. Add the .use_raw_spinlock attribute to the
appropriate regmap config.

Cc: stable@vger.kernel.org
Fixes: 2233bf7a92e7 ("gpio: mvebu: switch to regmap for register access")
Fixes: 4d305c227312 ("gpio: mvebu: name regmaps to fix debugfs collisions")
Closes: https://sashiko.dev/#/bug/linux-6bee0c4f-384c-494c-868e-07c420195d13
Reviewed-by: Linus Walleij <linusw@kernel.org>
Link: https://patch.msgid.link/20261109-gpio-mvebu-sleeping-while-atomic-v2-1-41f070421e70@oss.qualcomm.com
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index 267e6d5bacd0..92ce02441cc9 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -603,6 +603,7 @@ static const struct regmap_config mvebu_gpio_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
+	.use_raw_spinlock = true,
 };
 
 static const struct regmap_config mvebu_gpio_percpu_regmap_config = {
@@ -610,6 +611,7 @@ static const struct regmap_config mvebu_gpio_percpu_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
+	.use_raw_spinlock = true,
 };
 
 static const struct regmap_config mvebu_pwm_regmap_config = {

