Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6927244AB61
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 11:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785931065; cv=none; b=mruVeGXNk8726nWdqT0CFEmf/iqBwCEw88uvDY2mJXwUXmh2lCHsYTbJq2uzX5taIsKKnvwRnEeFDzKvIVODVIhnJhEL+O6gVUS3QE8fsKqAHhg320jI0Lnn17sziK4DEEIKVW3yOpSWfFZt0dKeOU9eKhu2F58txtGBibOSUfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785931065; c=relaxed/simple;
	bh=k+Q+SuN2oeeQ9jR2W9OP+7J/dHNNPENY2QjdfZwSgjs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GU51IQJLf1fOSc/LvQkj51Tqy38l8p91D5cK30mW9XvtkUsu4EkJegmIp01/kaVDJpSJIWCcekH21ZvmoGMiK236hGfTRxruUgi/oOodMTbQ2jdjQCsYRssVf/XBbgCjXW2CTF7kWCXb0QrdewPPhP7km2Xm9lBgz7ogs2lriJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d3u4Oi7C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d3u4Oi7C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA6CC1F000E9;
	Wed,  5 Aug 2026 11:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785931064;
	bh=vNWRZkujm5oGkkShUj7IJroJEcqrEwPsNOoQkXd/RwI=;
	h=Subject:To:Cc:From:Date;
	b=d3u4Oi7C5GkyZGOvAE8HOmGKes3elrfa6BNe9BDcuEMKf4RpSOpLEzR5IyGHki883
	 1IjYueN2V+WIDjVJIop42iB1iWtx7IlJPb2ANDGvwRWpYpzXQ/0RA3Mgk9ToYcfk1H
	 oXrGPujo3prnhrdTeCTsJfZif9aMph0nBU0wgQJY=
Subject: FAILED: patch "[PATCH] hwmon: (npcm750-pwm-fan): stop fan timer on device detach" failed to apply to 5.10-stable tree
To: getshell@seu.edu.cn,linux@roeck-us.net
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 13:51:03 +0200
Message-ID: <2026080503-visor-oboe-4814@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x f27f6976ea269219c1259a7c2f8c6dfe782540a3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080503-visor-oboe-4814@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f27f6976ea269219c1259a7c2f8c6dfe782540a3 Mon Sep 17 00:00:00 2001
From: Hongyan Xu <getshell@seu.edu.cn>
Date: Wed, 29 Jul 2026 18:01:16 +0800
Subject: [PATCH] hwmon: (npcm750-pwm-fan): stop fan timer on device detach

When a fan tach channel is present, npcm7xx_pwm_fan_probe() starts
fan_timer. The timer callback polls tach state and rearms the timer, but
the driver has no remove callback or devm cleanup action to stop it. On
device detach, the devm-managed driver data and I/O mappings can be
released while the timer is still pending or running.

Register a devm cleanup action before starting the timer and shut the
timer down synchronously from that action.

This issue was found by a static analysis tool.

Fixes: f1fd4a4db777 ("hwmon: Add NPCM7xx PWM and Fan driver")
Cc: stable@vger.kernel.org
Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
Link: https://lore.kernel.org/r/20260729100116.790-1-getshell@seu.edu.cn
Signed-off-by: Guenter Roeck <linux@roeck-us.net>

diff --git a/drivers/hwmon/npcm750-pwm-fan.c b/drivers/hwmon/npcm750-pwm-fan.c
index aea0b8659f5f..6ff2a6bc06c1 100644
--- a/drivers/hwmon/npcm750-pwm-fan.c
+++ b/drivers/hwmon/npcm750-pwm-fan.c
@@ -358,6 +358,11 @@ static void npcm7xx_fan_polling(struct timer_list *t)
 	add_timer(&data->fan_timer);
 }
 
+static void npcm7xx_fan_cleanup(void *timer)
+{
+	timer_shutdown_sync(timer);
+}
+
 static inline void npcm7xx_fan_compute(struct npcm7xx_pwm_fan_data *data,
 				       u8 fan, u8 cmp, u8 fan_id, u8 flag_int,
 				       u8 flag_mode, u8 flag_clear)
@@ -1020,6 +1025,12 @@ static int npcm7xx_pwm_fan_probe(struct platform_device *pdev)
 				msecs_to_jiffies(NPCM7XX_FAN_POLL_TIMER_200MS);
 			timer_setup(&data->fan_timer,
 				    npcm7xx_fan_polling, 0);
+			ret = devm_add_action_or_reset(dev,
+						       npcm7xx_fan_cleanup,
+						       &data->fan_timer);
+			if (ret)
+				return ret;
+
 			add_timer(&data->fan_timer);
 			break;
 		}

