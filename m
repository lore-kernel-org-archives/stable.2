Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F8B4A5EA4
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 19:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790106230; cv=none; b=RQgC9gjfrAP/NIQJwyphHhu0/yQvn3189Ex3Hw9EHOW1qTGLXh3q27Bg0DpBH0lmuQNH8LjSQ/mZj2pPRetf2o/5ESm8E+px0VwNpRNM9YOwBHHWzMdJy1b6KRw9EnDQ3thUGN1TNY0iKxpFSqo3kKsgC4KcySjo2AfIVeghnuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790106230; c=relaxed/simple;
	bh=yj0xSGB2uWooKTiU0NsS6Vek7OLKQ2odKoPawS1eqZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B4BBb62uz7JRBUu5qdbSt1ICapDFxNt/wBbsLsvJ227zOk7cM/h4vdf4+EEMSvYJAxLuoIME+uRmZd/SUUBOWUlNj844GK4pqS6BW5u0n4g03L6ee9lA8kbx4o9/6uP310SRE+1VF4kHKN9Df5awPWdxldi41QSj+kr5CUBLVRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+7vHvTc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+7vHvTc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5010B1F000FF;
	Tue, 22 Sep 2026 19:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790106228;
	bh=r+5mQkfZvZFrhLSJD9Z7ZquDA9cQOMs7529isHu1yI0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W+7vHvTclBIE9YlgTIS5tbbs+xda0sXFEWtKSrEau4F0zQioSTLm6/XDa5unGr2p+
	 dcBslHd+jMOuF6XQZqPdlVirRxdT4SttdVf+FQ6y00KgMZx/wkHZe6KbHCUNeilPtd
	 ADBaCBCBrR19Xh2eFzsFRL806EWl7xn3JNdmRaETHUpZ7a9tneDqXvKpmhKtpamTsd
	 Ixv7dDqQZee0eh7/FbvmR9ySPZg/v3svdfnAnuj26+NQmy/wa4VUVg6mK+49L/4KO3
	 b9aOV+9Wa/5NGDRptZ+VuaFp/VoIyKIQa0IX0t/BqkYdKjtWZhPsUA/uCrLuiqjZqh
	 p6JuzjJQ0V2Tg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yibo Tan <lhfff@tju.edu.cn>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] hwmon: (pwm-fan) Stop RPM timer before freeing tach data
Date: Tue, 22 Sep 2026 15:43:46 -0400
Message-ID: <20260922194346.51836-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092256-reword-critter-a4b6@gregkh>
References: <2026092256-reword-critter-a4b6@gregkh>
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
[ adapted cleanup changes to the older pwm_fan_pwm_disable() and pwm_fan_shutdown() implementations. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/pwm-fan.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index f12b9a28a232d..05ba32d44230e 100644
--- a/drivers/hwmon/pwm-fan.c
+++ b/drivers/hwmon/pwm-fan.c
@@ -291,7 +291,13 @@ static void pwm_fan_pwm_disable(void *__ctx)
 
 	ctx->pwm_state.enabled = false;
 	pwm_apply_state(ctx->pwm, &ctx->pwm_state);
-	del_timer_sync(&ctx->rpm_timer);
+}
+
+static void pwm_fan_timer_cleanup(void *__ctx)
+{
+	struct pwm_fan_ctx *ctx = __ctx;
+
+	timer_shutdown_sync(&ctx->rpm_timer);
 }
 
 static int pwm_fan_probe(struct platform_device *pdev)
@@ -424,6 +430,10 @@ static int pwm_fan_probe(struct platform_device *pdev)
 	}
 
 	if (ctx->tach_count > 0) {
+		ret = devm_add_action_or_reset(dev, pwm_fan_timer_cleanup, ctx);
+		if (ret)
+			return ret;
+
 		ctx->sample_start = ktime_get();
 		mod_timer(&ctx->rpm_timer, jiffies + HZ);
 
@@ -490,6 +500,9 @@ static int pwm_fan_disable(struct device *dev)
 
 static void pwm_fan_shutdown(struct platform_device *pdev)
 {
+	struct pwm_fan_ctx *ctx = platform_get_drvdata(pdev);
+
+	pwm_fan_timer_cleanup(ctx);
 	pwm_fan_disable(&pdev->dev);
 }
 
-- 
2.53.0

