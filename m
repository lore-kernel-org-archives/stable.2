Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036DF493651
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 18:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790101869; cv=none; b=PxgG31Nt3LKqKgBwALHsb/Po2gK0hLZ8kX6PxeLYoOZi0vV6ubBkM/YF8DmefmdmnGocoYpf8rqkh+GWlrxc0lJvv9ihmsX9dhndaoxYv4cqfdDFf662lBgK3LW3Xe0bcrvRdsgeRhZANL4GobVeSod78h4gfJWEspAUPBaNQJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790101869; c=relaxed/simple;
	bh=jBwPo//1nv3gpSpwzi0WjJK9WhhmbcedTkUhEtDJo+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bTI5RyS+T15BKYUdAX/xCqSUG3lDCGxqD9qK1tBBQE75+vl7/4yr1mzK5Pe26CYK+GAsN3LWW0uJv+BkKkDoMPHLveyXxpaUNI8LlJVO3jqEyMY3+h8JwaBrpW0Mr4gqukSKl07DrQpXcdPnFMet9VUObSZ/zXMuzQ7IdIU4aZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QeTgkeK+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QeTgkeK+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CC5C1F000FF;
	Tue, 22 Sep 2026 18:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790101867;
	bh=2MVMxScEEr5r6YpPuJq3K+QGv3osxAmn2K6qUBsPl2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QeTgkeK+GnR2mcv0Rji4hfBEnDq5aXYGx1awn6dkFaV2ff8g0f3nzIiaVEqJNXVSa
	 1SK3Pb8pqh4lwCTaqtRXj/Hd2D73K1bpr11tuQeHB0q7FjMV/T9tZSKezpGB1NTDMt
	 AZn1k5JLaSw26Ag796sBxelM0uhfztdHZZNkCoUPBmI8vhQ3/x0nWYH8a8ZMuq34Qu
	 UDyyt/u3LlTQIQEpwlDOXnoUEsbV5CIkjS2dgInuyJh+NakS3Jgczjngh5Cp5Sg7Mk
	 CM7TEVpzGOJD3RRclaldGZ3nt8Fp3Y31lm4qUcrTSxsnNYPWZ1di5EEv+6/H4OyFr8
	 pB6eUM1FMfBig==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yibo Tan <lhfff@tju.edu.cn>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] hwmon: (pwm-fan) Stop RPM timer before freeing tach data
Date: Tue, 22 Sep 2026 14:31:05 -0400
Message-ID: <20260922183105.3661109-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092253-convene-finch-3506@gregkh>
References: <2026092253-convene-finch-3506@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yibo Tan <lhfff@tju.edu.cn>

[ Upstream commit 26d5ff79768548efb1e604bb6e8697c101e06269 ]

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
[ Adapted cleanup changes to the older pwm_fan_cleanup() using del_timer_sync() without pwm_shutdown handling. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/pwm-fan.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index c434db4656e7d..47847aadc4fef 100644
--- a/drivers/hwmon/pwm-fan.c
+++ b/drivers/hwmon/pwm-fan.c
@@ -466,12 +466,18 @@ static void pwm_fan_cleanup(void *__ctx)
 {
 	struct pwm_fan_ctx *ctx = __ctx;
 
-	del_timer_sync(&ctx->rpm_timer);
 	/* Switch off everything */
 	ctx->enable_mode = pwm_disable_reg_disable;
 	pwm_fan_power_off(ctx, true);
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
@@ -614,6 +620,10 @@ static int pwm_fan_probe(struct platform_device *pdev)
 	}
 
 	if (ctx->tach_count > 0) {
+		ret = devm_add_action_or_reset(dev, pwm_fan_timer_cleanup, ctx);
+		if (ret)
+			return ret;
+
 		ctx->sample_start = ktime_get();
 		mod_timer(&ctx->rpm_timer, jiffies + HZ);
 
@@ -655,6 +665,7 @@ static void pwm_fan_shutdown(struct platform_device *pdev)
 {
 	struct pwm_fan_ctx *ctx = platform_get_drvdata(pdev);
 
+	pwm_fan_timer_cleanup(ctx);
 	pwm_fan_cleanup(ctx);
 }
 
-- 
2.53.0

