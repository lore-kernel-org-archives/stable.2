Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8663F494835
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 18:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790102450; cv=none; b=nIVcLxxCpeDDGkuMJEOZHs5WXzoLP+JyArXhghuFw7eHUB327YK1thM+nXJc48jaEL0HGJ9v3rFS5QVVqnO5NfYt+uxTT+ymDALRKEOqYKwBFmW30Im5qp9Nme3uhX0E1PjfFVlc17UQe3UJYL3CDyQYORKLRXxXP2w96oWSEM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790102450; c=relaxed/simple;
	bh=4qrutqATbNF86wPThifHYWbladvv+DQbCwx/E2LflEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PkKKicVkAbhVkOYRGqCHBKVT0nq9+mqvFe3avMJw3PWISoQ36bUK5rbga4RD11y1XSPawoxherztn0r84/WuF9d4sV1/POD274oIqL+qqtoUq08t/WRHTl7M+2AVd/LDV8Yqqu5n1Dp8/FASB3ij7jmUbKAw+Z+FxqpCQR49J8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ACf8Ne7k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ACf8Ne7k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCE8A1F000FF;
	Tue, 22 Sep 2026 18:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790102447;
	bh=WkmmHACeLJFqWw0MH2W1q15T2KgehouT7ZXnypSKPkU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ACf8Ne7kq31AICk0rAwbqNT3k2a7uPxCk64/Jdyo0ltBbkNMoUel6Knw8a4OCDGAE
	 GNFhFhqXqPiqNu1qWqGQjPSlapOxaxdO7ssGDMhtNofXf29jCyl15aFWl5awJTU3wo
	 7SjJebEcm6xY33mo+SsCeiPCFOARLGIUVdyTf5nyWG6HzdzIrF1eC+uTX8PGYLvfB8
	 hSNicVgzYqUA3C8fUfgiEeEdWOB0EK6pP+XwewXtQZXTja0B0KL9n82pUSkSYrhgk2
	 KjWyuIW+sXnkAn9In0bpBo3QisuXqpk85kJy+OuK/xvw8BA/PFHspvCATooQ5vB/ZT
	 dgFJyZ0FHMK1g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yibo Tan <lhfff@tju.edu.cn>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] hwmon: (pwm-fan) Stop RPM timer before freeing tach data
Date: Tue, 22 Sep 2026 14:40:45 -0400
Message-ID: <20260922184045.3744020-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092254-carat-drift-7011@gregkh>
References: <2026092254-carat-drift-7011@gregkh>
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
index b67bc9e833c01..90254f8eb56f6 100644
--- a/drivers/hwmon/pwm-fan.c
+++ b/drivers/hwmon/pwm-fan.c
@@ -466,12 +466,18 @@ static void pwm_fan_cleanup(void *__ctx)
 {
 	struct pwm_fan_ctx *ctx = __ctx;
 
-	del_timer_sync(&ctx->rpm_timer);
 	/* Switch off everything */
 	ctx->enable_mode = pwm_disable_reg_disable;
 	pwm_fan_power_off(ctx);
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
@@ -606,6 +612,10 @@ static int pwm_fan_probe(struct platform_device *pdev)
 	}
 
 	if (ctx->tach_count > 0) {
+		ret = devm_add_action_or_reset(dev, pwm_fan_timer_cleanup, ctx);
+		if (ret)
+			return ret;
+
 		ctx->sample_start = ktime_get();
 		mod_timer(&ctx->rpm_timer, jiffies + HZ);
 
@@ -647,6 +657,7 @@ static void pwm_fan_shutdown(struct platform_device *pdev)
 {
 	struct pwm_fan_ctx *ctx = platform_get_drvdata(pdev);
 
+	pwm_fan_timer_cleanup(ctx);
 	pwm_fan_cleanup(ctx);
 }
 
-- 
2.53.0

