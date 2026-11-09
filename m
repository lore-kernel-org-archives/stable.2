Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.206.34.216
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794214749;
	b=BBNBYmkHcBWIxOFN6XVlz8Wg3imUVF1qnorTEiLLHaSGltEJGioZNa7jBBKdLGn6V4Oz
	 /GNHtMobBCUwz/1o5PpwCXp8rusLPYFfav5XxibkZSkAbzXoF7FG7ydE9fmcu7b/IXAvG
	 slzxosaq93ZiJeF/www55jhzEH/U2s3N4UuhoZOIpda+pR/BixJ+2iGIXmk7/jYmasY73
	 SESnBgm8a26JSojLT4a+d2MBf5oCo/bQiJ8vTM4QRaxYQIbcsY/jdCtfKCOZCknFsNkvy
	 Moe5Xp8Bk2takD2rUyshoW66adTIl6xedRja4CnpGPkEqeY2jmaeHdhtoEKo5R+0Xog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794214749;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=Ry0hvg/7ZvGS+5MJjvgAu1kOtMI7ERoCHasBUkDzBN8=;
	b=pveIMtxvW0FDAL5uD1IklaiZY9fVGE5LEjbdZxsPl7hP3ym1F49/fK5gEPjB9az0NI/R
	 UYWtAy4Dt8Se8II6P8VolUGRnOlm+Flttyn3GB1okxZ1TJRMR31ouYptOK76972DyVBXU
	 PCkl3lm+Bw/JU3MB6KcaYEzXVBjWmgYsgtYTet0CWeMy2BNDdxR+wlhTx3IpbnNUIU0RO
	 uZ8ZFs8uaucEqFMVopYdB/tUnRstM7FbjGHfWVSKVbNSkUO7hFeRMwVYbpqoMNMlXmEhZ
	 liAbENJTkZtTEH3fV+Cs46N/uVxnNyXuiNnbwYdSbngWR1eG1BFMF4MwaXonqxGvNtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniontech.com;
	spf=pass smtp.mailfrom=uniontech.com;
	dkim=pass header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=FjWtxarp;
	arc=none smtp.remote-ip=54.206.34.216
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6A8606A322;
	Mon,  9 Nov 2026 08:59:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD6A8606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=FjWtxarp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1794214723;
	bh=Ry0hvg/7ZvGS+5MJjvgAu1kOtMI7ERoCHasBUkDzBN8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=FjWtxarpGQYLRCOCRQROuFAxa5I+Rx9vIZj1+3+oNNgNb51CtF422YagaZnhVJoXe
	 c+IL1rwqD1xAWjH+kcOmPR/wGjCutcpGKQKZxEablckzByZJZrn/rHcGJXn9tuaYd4
	 JWP+ol0CKL/FplspIceiaxThwKIoA2TaaCJDz7c0=
X-QQ-mid: zesmtpgz1t1794214705t0209eb0c
X-QQ-Originating-IP: D0rEOGTZh2iXiPzAu13irFDdBHXbIhUPCQSjyhIRml4=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 09 Nov 2026 16:58:23 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10624433642065870936
EX-QQ-RecipientCnt: 8
From: raoxu <raoxu@uniontech.com>
To: lee@kernel.org
Cc: pavel@kernel.org,
	griffin@kroah.com,
	Denis.Osterland@diehl.com,
	linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	raoxu@uniontech.com,
	stable@vger.kernel.org
Subject: [PATCH] leds: pwm: Fix active-low brightness with default-state keep
Date: Mon,  9 Nov 2026 16:58:22 +0800
Message-ID: <9524E319B9AF9D1A+20261109085822.3755803-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: Ndw/mc8X39ObNJ1UWdOrfa1vxiINxy2GaUzWAH88ZNWCH5ChWve6hLOm
	s+oP3xHmubqaqJevmq/QrB0JVxmdXAFAeR2tNsL9rBhkpDmeTSJf6M9O8izY4u2kiwjuIsc
	JcGM7EXLkAEixrDZ14TunWRyR+nMVKGuuO7cqpwBnf/ddn4qrmG/8B6m2vTDz+MG3ptpStb
	SS4C7Rar+fcq+J99k0bcAsrlJ9aazPbdq9AjQyeaKD9jseTVqTNxvO8H6CMzhRVwZvMfStR
	mpAw8oOOm2PTiYK711GfAD9io3WWgEbIf/kkXIYAJElSXOPyU+SiIZNICeNPQoqQK5yK8Ce
	bvrKD0Kd1DuaxHtKS1fOoSymIa6ujDlYtjV07ThJ85KIv36BY8jzOOvnED1YFZ9hvu7TQnx
	uAnVztZAUsEJ+e1sVWjf8K1UaArVgBAOidvAMWgwwPeDp9DtCwK+dbJXcu1BzX3JWv32g/O
	oulJhA+S8g2MV+yAqN98hOqoA4zY/1o29Gh12LaWNC8e9JrUwukS2FyTIayavva8vt7cawU
	25ix6YP3Q7TD8QPBmOMT+mEgLk7eTri4DYr00N+XpHxwsyxOsFtmWnHmtHX/h3b69xQnSZA
	Ii087HX4apOriJ6CQbD3KeLDL3GPjkxl9B+IuIr43KKxTVcbuV19dgsw9/TZXpbWZP+tv64
	UoFRuCXPWSGoIpeG3fXUtPuAEhuxCsZTP3nJuHiy7ss63FBe/vpkZTX5xN/b78wjwrOlAi5
	srYnC4R3KcRTzzJGyQ6/uU4AONU0ZuQjb9OZowH8ah5TWiu39ipE+OSsvrrhElmwf9md/FS
	gTeIaW9wDnExkZKwSs2tQKn0Aiu2cea7v13/5hMsGvzRozcGfJCzYX5hCKClHmlfBBi6i/X
	WzCOeu9Ga8EHbk2/PU5OHPo04mvQ9ClY0clckOTYbDknO1ZuE/++mykIsrunLJV7voLTi8i
	oTsbySQfDqfrg27YT12bzA1i5pp6Tt5BXmIJoAIBDVGuY8DxRQCII/p0+YbMnbKIsvC9pmk
	K925GYL69f5wLZj1UNuAg+Hz1KDW2TuWwdo4QJ7nfwZv/wCLpr7AnnNnw4NbU=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

From: Xu Rao <raoxu@uniontech.com>

With default-state set to "keep", led_pwm_add() derives the initial
brightness from the PWM duty cycle without accounting for active-low
LEDs. However, led_pwm_set() inverts the duty cycle for these LEDs.

For an enabled active-low PWM with zero duty cycle, the LED is fully
on but its cached brightness is set to zero. Conversely, a full duty
cycle is reported as maximum brightness instead of off. This exposes
an incorrect brightness to userspace and can restore the wrong value
after suspend. With an optional enable GPIO, the incorrect brightness
also causes the wrong initial GPIO level to be selected.

Invert the computed brightness for active-low LEDs, matching the
conversion used by led_pwm_set() while leaving the PWM state intact.

The supplied fix was reviewed and this commit message prepared with
OpenCode AI assistance.

Fixes: 3d3d65bd2764 ("leds: pwm: add support for default-state device property")
Signed-off-by: Xu Rao <raoxu@uniontech.com>
Cc: stable@vger.kernel.org
---
 drivers/leds/leds-pwm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/leds/leds-pwm.c b/drivers/leds/leds-pwm.c
index 6c1f2f50ff85..da307767dbe8 100644
--- a/drivers/leds/leds-pwm.c
+++ b/drivers/leds/leds-pwm.c
@@ -131,6 +131,8 @@ static int led_pwm_add(struct device *dev, struct led_pwm_priv *priv,
 		brightness = led->max_brightness;
 		brightness *= led_data->pwmstate.duty_cycle;
 		do_div(brightness, led_data->pwmstate.period);
+		if (led_data->active_low)
+			brightness = led->max_brightness - brightness;
 		led_data->cdev.brightness = brightness;
 		}
 		break;
--
2.50.1

