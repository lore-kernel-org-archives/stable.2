Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2482EBDFA
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 15:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784562966; cv=none; b=Kr9xZX0rLyVLTnJxgOaWdv3D4u+ioh+/o23oHi6akSkMp+ie9Ee6R6EX0K2OE7jM071otYHcN5J/4ZnKMg7PGpMC2F4tp1v6Y2A30ayRD+ovRP1Vp3iwfD3brg/dHBskdaF5IxRLKDanhQdYfb0qT8L5OX/7pY+h2hDacQ+/b+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784562966; c=relaxed/simple;
	bh=6Y8Dl+17N0Z3v/2dJO6rPx3yulWpSt73onos8GEJ/ss=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=EgYJoiyJKHIsSCCcu/AdicjSp/WzCMRlGn4PoGt6AFbONckxw49Eh3F3LvNm0nab3OEQf2GCiRpa5iwKWUYXS1CkRNCLdliTXARX1qGS9lO2WKYP3E2bu42LbEaYiCJUVAjm6P7tQ/jrNxKII1H4DlfAFoD+IICktClNgsPIiso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hdvbyFLx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hdvbyFLx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 954BF1F000E9;
	Mon, 20 Jul 2026 15:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784562965;
	bh=/Yv4B4u7YGYT9raS0DIRHjaCf83ne0o29WBtTd4P0CU=;
	h=Subject:To:Cc:From:Date;
	b=hdvbyFLx5mHjBz0uR27nzz8uUblC1NyKzvaM5Xw+njoYaJzLI3exw+D5je7t5cbt8
	 GlBbQcFAGYBCIxbHOk342CrJIwFYtKWLnHBq4CklsUhr+lfOaEUWMJ3zkAudQg5jfA
	 EaLTy/osLj/roFZXY8pO9pfTh63PxmyOJehFYilQ=
Subject: FAILED: patch "[PATCH] gpio: tegra: do not call pinctrl for GPIO direction" failed to apply to 5.15-stable tree
To: runyu.xiao@seu.edu.cn,bartosz.golaszewski@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 17:50:48 +0200
Message-ID: <2026072048-grudge-mongoose-71aa@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x d3e91a95b2b0fc6336dbf3ec90d831a1654d2720
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072048-grudge-mongoose-71aa@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d3e91a95b2b0fc6336dbf3ec90d831a1654d2720 Mon Sep 17 00:00:00 2001
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
Date: Fri, 19 Jun 2026 23:24:39 +0800
Subject: [PATCH] gpio: tegra: do not call pinctrl for GPIO direction

tegra_gpio_direction_input() and tegra_gpio_direction_output() already
program the GPIO controller direction registers directly. The additional
pinctrl_gpio_direction_input/output() calls do not add a Tegra pinctrl
operation, because the Tegra pinmux ops provide GPIO request/free
handling but no gpio_set_direction hook.

The extra call still enters the pinctrl core and takes pctldev->mutex.
Shared GPIO users can call the direction path while holding their
per-line spinlock, so this otherwise redundant pinctrl direction call can
sleep in an atomic context.

This was found by our static analysis tool and then confirmed by manual
review of tegra_gpio_probe(), the Tegra GPIO direction callbacks and the
Tegra pinctrl ops. The reviewed path has a default non-sleeping
struct gpio_chip while the direction callback still enters the pinctrl
mutex path.

A directed runtime validation kept the same non-sleeping chip registration
and drove:

  gpio_shared_proxy_direction_output()
  gpiod_direction_output_raw_commit()
  tegra_gpio_direction_output()
  pinctrl_gpio_direction_output()

Lockdep reported a sleep-in-atomic warning with the shared GPIO spinlock
held and pinctrl_get_device_gpio_range() plus tegra_gpio_direction_output()
on the stack.

Do not mark the whole chip as can_sleep to paper over this: can_sleep
describes whether get()/set() may sleep, and Tegra value access is MMIO.
Remove the redundant pinctrl direction calls and keep pinctrl involvement
in the existing request/free path.

Fixes: 11da90541283 ("gpio: tegra: Fix offset of pinctrl calls")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
Link: https://patch.msgid.link/20260619152439.1239561-1-runyu.xiao@seu.edu.cn
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

diff --git a/drivers/gpio/gpio-tegra.c b/drivers/gpio/gpio-tegra.c
index df06b56a2ade..fa6c8ee92093 100644
--- a/drivers/gpio/gpio-tegra.c
+++ b/drivers/gpio/gpio-tegra.c
@@ -172,18 +172,11 @@ static int tegra_gpio_direction_input(struct gpio_chip *chip,
 				      unsigned int offset)
 {
 	struct tegra_gpio_info *tgi = gpiochip_get_data(chip);
-	int ret;
 
 	tegra_gpio_mask_write(tgi, GPIO_MSK_OE(tgi, offset), offset, 0);
 	tegra_gpio_enable(tgi, offset);
 
-	ret = pinctrl_gpio_direction_input(chip, offset);
-	if (ret < 0)
-		dev_err(tgi->dev,
-			"Failed to set pinctrl input direction of GPIO %d: %d",
-			 chip->base + offset, ret);
-
-	return ret;
+	return 0;
 }
 
 static int tegra_gpio_direction_output(struct gpio_chip *chip,
@@ -191,19 +184,12 @@ static int tegra_gpio_direction_output(struct gpio_chip *chip,
 				       int value)
 {
 	struct tegra_gpio_info *tgi = gpiochip_get_data(chip);
-	int ret;
 
 	tegra_gpio_set(chip, offset, value);
 	tegra_gpio_mask_write(tgi, GPIO_MSK_OE(tgi, offset), offset, 1);
 	tegra_gpio_enable(tgi, offset);
 
-	ret = pinctrl_gpio_direction_output(chip, offset);
-	if (ret < 0)
-		dev_err(tgi->dev,
-			"Failed to set pinctrl output direction of GPIO %d: %d",
-			 chip->base + offset, ret);
-
-	return ret;
+	return 0;
 }
 
 static int tegra_gpio_get_direction(struct gpio_chip *chip,

