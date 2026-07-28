Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FE53BB670;
	Tue, 28 Jul 2026 07:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785225344; cv=none; b=JtZc0LHagqAJ71MsTerisdgcY4zLBp7LBbOtXai4By2t+7EGzbdFUz4sE4fO8p9KgTJ0hxEPXzSxaiGqarHDvpwpMiE1+Cxmn1nkP1hLuGGtOj8OfSrUgbtoug+j4UtioRnhuvmf/aTHIE84zu9iRiHcruKXR76eDykppT/ERQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785225344; c=relaxed/simple;
	bh=QwYLI3gD/awv6HGUpYQr6yoYuEJKQSsxtz71+uMA3M0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eZpn1Ok3fycll+s4M5WCelR9BAGRzcsyvX3Bd0xY4rPH5BwORxgO7PQ8+MHFcLlSyKgGUq4PrttVi88jwGlkcnWzBfpTGmiVNKXkazjM3NPISxTI9mYRRkYGx/Bu4raOAEZAH/pmJspVdIb3V2uJdTdMKQjvtSaKPs+gJtRwgXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=AlYGC2tl; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="AlYGC2tl"
Received: from LAPTOP-99KJFSET (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 47d71b719;
	Tue, 28 Jul 2026 15:55:34 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: linux@roeck-us.net
Cc: jianhao.xu@seu.edu.cn,
	andrew@codeconstruct.com.au,
	avifishman70@gmail.com,
	tmaimon77@gmail.com,
	tali.perry1@gmail.com,
	venture@google.com,
	yuenn@google.com,
	benjaminfair@google.com,
	openbmc@lists.ozlabs.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hongyan Xu <getshell@seu.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH] hwmon: (npcm750-pwm-fan): stop fan timer on device detach
Date: Tue, 28 Jul 2026 15:55:35 +0800
Message-ID: <20260728075535.251-1-getshell@seu.edu.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9fa7b8ceed03a1kunmfbb65e04e62e0
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDShoZVk0YHk4ZGk8ZQh0dGVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSU
	hOQ0NVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=AlYGC2tlucu/O+RmbyaNzfVx7smNgXh3Fa1uKHlg0pkdjbks1+sIygU9+qaNZFExLqZild3X9MgcCKju1h46inNFUgtsqOzuPqYtmfR7Vdt3X/5w1URTXI3aSs4un/e0QX+yB/nsVhmyhWzjmk6kdUxuWl5lG1+ifIsYysK+tlk=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=FbP7deSyGw94JeB8LJES1uFqlV1FifhDthAcN0fzQDs=;
	h=date:mime-version:subject:message-id:from;

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
---
 drivers/hwmon/npcm750-pwm-fan.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/npcm750-pwm-fan.c b/drivers/hwmon/npcm750-pwm-fan.c
index aea0b8659f5..6503d28ed7b 100644
--- a/drivers/hwmon/npcm750-pwm-fan.c
+++ b/drivers/hwmon/npcm750-pwm-fan.c
@@ -358,6 +358,13 @@ static void npcm7xx_fan_polling(struct timer_list *t)
 	add_timer(&data->fan_timer);
 }
 
+static void npcm7xx_fan_cleanup(void *data)
+{
+	struct npcm7xx_pwm_fan_data *fan_data = data;
+
+	timer_shutdown_sync(&fan_data->fan_timer);
+}
+
 static inline void npcm7xx_fan_compute(struct npcm7xx_pwm_fan_data *data,
 				       u8 fan, u8 cmp, u8 fan_id, u8 flag_int,
 				       u8 flag_mode, u8 flag_clear)
@@ -1016,10 +1023,16 @@ static int npcm7xx_pwm_fan_probe(struct platform_device *pdev)
 	for (i = 0; i < NPCM7XX_FAN_MAX_CHN_NUM; i++) {
 		if (data->fan_present[i]) {
 			/* fan timer initialization */
-			data->fan_timer.expires = jiffies +
-				msecs_to_jiffies(NPCM7XX_FAN_POLL_TIMER_200MS);
 			timer_setup(&data->fan_timer,
 				    npcm7xx_fan_polling, 0);
+			ret = devm_add_action_or_reset(dev,
+						       npcm7xx_fan_cleanup,
+						       data);
+			if (ret)
+				return ret;
+
+			data->fan_timer.expires = jiffies +
+				msecs_to_jiffies(NPCM7XX_FAN_POLL_TIMER_200MS);
 			add_timer(&data->fan_timer);
 			break;
 		}
-- 
2.50.1.windows.1
