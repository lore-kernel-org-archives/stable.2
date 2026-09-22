Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FF23C454F
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 15:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790089848; cv=none; b=pq9pwMVf2T+rCMJbCBnu0FDoo7/3HfyoRGrtIBDzmVOtY+aqzmJfrQySojJUzx2X9GGYViZqFSMKtzl+K7+aQxibxtVLsBxfdmUDo8EiP9mei9yvyg1ruaER3c5MYmC3katXbLrdAj9QykLjoWP1B7LX89x0KQMlu5xFM2u+Vx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790089848; c=relaxed/simple;
	bh=ryg1TPGStCrf29xPOU8/vHADx7tQlWbp30jldcU+aII=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mzEElpYo28YwXajI3niRM8EYxIT31+6aby0+sKcE6umXp/jPhvciZgXRNj8IFVPNCT057g8vJQwQlqzw1MLYWM8+tr/VGv2HNyJNVrIrrm+tkwa1WSMNKfUjDD3lrPOlKWd0qJAdC6QlNchUaBWwmtqxHx1Y0P/tdMcschLFuKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oNxtsH8S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oNxtsH8S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE4A91F000FF;
	Tue, 22 Sep 2026 15:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790089847;
	bh=epTMne94jcwVVdOuvThvDxQUWRJKz5uMz4Mdi/w594I=;
	h=Subject:To:Cc:From:Date;
	b=oNxtsH8Sm7FfX5V+/wlaQnOyDUxNIZfjooylulE+Oq3zYtPDOHU5HqlNRV7Yzizre
	 Tt2KCnLXx2EYwF8MVJ0engUwkDLfxWZXJf9UxEd8GugfV//mZh3qHbrnQBDfGQVH7G
	 HBSOZmPVhE3DhHd0jmLVQsF0oBRtTPRATAPK/s9Y=
Subject: FAILED: patch "[PATCH] hwmon: (pwm-fan) Stop RPM timer before freeing tach data" failed to apply to 6.12-stable tree
To: lhfff@tju.edu.cn,linux@roeck-us.net
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Sep 2026 16:55:53 +0200
Message-ID: <2026092253-convene-finch-3506@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x 26d5ff79768548efb1e604bb6e8697c101e06269
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092253-convene-finch-3506@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 26d5ff79768548efb1e604bb6e8697c101e06269 Mon Sep 17 00:00:00 2001
From: Yibo Tan <lhfff@tju.edu.cn>
Date: Fri, 11 Sep 2026 15:18:09 +0800
Subject: [PATCH] hwmon: (pwm-fan) Stop RPM timer before freeing tach data

sample_timer() rearms the RPM timer and accesses the devm-managed
ctx->tachs and ctx->pulses_per_revolution arrays. The cleanup action
which stops the timer is registered before those arrays are allocated.

Since devres releases entries in reverse order, driver detach can free
the arrays before pwm_fan_cleanup() shuts down the timer. A timer expiry
in that window accesses the freed tach data.

With a KASAN kernel, a test-only kprobe delayed entry to
pwm_fan_cleanup() while normal sysfs unbind ran. Each of three runs
reported three four-byte reads and two four-byte writes in sample_timer()
after its backing devm allocations had been freed. The helper did not
invoke the timer callback, cleanup actions or free functions.

With the fix, three matching unbind runs completed without KASAN, BUG,
WARNING, Oops or panic. Instrumentation confirmed that timer retirement
completed before the first timer backing allocation was released.

Split timer retirement from the power cleanup and register its devres
action after the timer backing data and IRQ actions are installed. This
preserves the early power rollback action while ensuring the timer is
retired before its backing data is released. Use timer_shutdown_sync()
because the callback can rearm itself.

Fixes: 01695410d452 ("hwmon: (pwm-fan) Store tach data separately")
Cc: stable@vger.kernel.org
Assisted-by: Codex:GPT-5
Signed-off-by: Yibo Tan <lhfff@tju.edu.cn>
Link: https://patch.msgid.link/20260911071809.130151-1-lhfff@tju.edu.cn
Signed-off-by: Guenter Roeck <linux@roeck-us.net>

diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index 3b87f65bae05..c633d7f6464c 100644
--- a/drivers/hwmon/pwm-fan.c
+++ b/drivers/hwmon/pwm-fan.c
@@ -483,7 +483,6 @@ static void pwm_fan_cleanup(void *__ctx)
 {
 	struct pwm_fan_ctx *ctx = __ctx;
 
-	timer_delete_sync(&ctx->rpm_timer);
 	if (ctx->pwm_shutdown) {
 		ctx->enable_mode = pwm_enable_reg_enable;
 		__set_pwm(ctx, ctx->pwm_shutdown);
@@ -494,6 +493,13 @@ static void pwm_fan_cleanup(void *__ctx)
 	}
 }
 
+static void pwm_fan_timer_cleanup(void *__ctx)
+{
+	struct pwm_fan_ctx *ctx = __ctx;
+
+	timer_shutdown_sync(&ctx->rpm_timer);
+}
+
 static int pwm_fan_probe(struct platform_device *pdev)
 {
 	struct thermal_cooling_device *cdev;
@@ -644,6 +650,10 @@ static int pwm_fan_probe(struct platform_device *pdev)
 	}
 
 	if (ctx->tach_count > 0) {
+		ret = devm_add_action_or_reset(dev, pwm_fan_timer_cleanup, ctx);
+		if (ret)
+			return ret;
+
 		ctx->sample_start = ktime_get();
 		mod_timer(&ctx->rpm_timer, jiffies + HZ);
 
@@ -700,6 +710,7 @@ static void pwm_fan_shutdown(struct platform_device *pdev)
 {
 	struct pwm_fan_ctx *ctx = platform_get_drvdata(pdev);
 
+	pwm_fan_timer_cleanup(ctx);
 	pwm_fan_cleanup(ctx);
 }
 

