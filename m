Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795604522;
	b=0aqKWwFnfqk7A0RVvLpKJWy4FyDfVEv3I088wIIdKW4SsOFm/UCnfNvIKpyQbEQgkFBe
	 tKfdmQFHydtFIu6p4F5YwyEWSdjbnS2NEaHHIvkjFzh8G/MfJr6EE/eThGd+S5DUiC2lT
	 M9tX3Upiq5GGGBTgxkuhTrGjJF3EPytprKT+cfH6QyV03D3XIfVN6MaGeRhEqObw7BV1E
	 qE/C3AmpieF3/9mwPuJl1J7IlgjBtLe3ft+rDgDp+LBbzSIv50I7FhctxHv7UVvS375im
	 M4PVDjVn2yV+VkWEQRk2VA/UY3bk2L7tcAYBgR5uFN1QMSEReJIk//CUmyNIymV30kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795604522;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=cVZOEPngsjUdFzE5gWE+fCrbgYmQFHqE6ecX8miOsRg=;
	b=CbbJI74m0NjZeKf2lmuQgFDVnhymLqfYP72xAllP+phAZxfLSimQggP/xKFcHzoxjcgk
	 z74fakTFb7Y+MrZQWb7wSO7SUwa8S87SElyv4i1lUgerTytEDGdZtWN+qnQ4FmfkQa27E
	 AFR9IO2ZbnvxsCGjGmJzsyADT76YkTPPjBeDvedgDYGS2OMZ43tiHsKlPZEl8Q/gjwIWV
	 llu7ZjqouTNCO5kwOTi9vnd1oj7yFEuZPA6zcX667ST8W0P1YXR7tvkCAtpzCtrnxhPMP
	 3eVFg8XAAbTnUuiPfiDj3o3CT2kIt1NHIQuVOpI5gbn2bAht0+WWc/15a0ZTqFb6WEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=RB3ZdNdc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB12606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 11:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=RB3ZdNdc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6F081F000C4;
	Wed, 25 Nov 2026 11:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795604522;
	bh=cVZOEPngsjUdFzE5gWE+fCrbgYmQFHqE6ecX8miOsRg=;
	h=Subject:To:Cc:From:Date;
	b=RB3ZdNdcfHGzo9XiQ5gCUnpJWI+lzOcmYOLB/9leeSCM0GyvWnrBiKJwqkzbfP74X
	 0sZyd3tlGIcWEtJ73OAKIF00Pc6lWZkZMucl4LYfeMzerQXCjJWEwj/T97AtxCCXzK
	 +BD42e17JoWTwEV/+Ercw5AtsvNJmx3K2I7dx690=
Subject: FAILED: patch "[PATCH] gpio: mvebu: fix sleeping-while-atomic in" failed to apply to 7.3-stable tree
To: bartosz.golaszewski@oss.qualcomm.com,linusw@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:42:16 +0100
Message-ID: <2026112516-citation-stage-72ea@gregkh>
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


The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x 42269cdb3d3b46ba6e80f31d0e00d0bdcff1d8d4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112516-citation-stage-72ea@gregkh' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

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

