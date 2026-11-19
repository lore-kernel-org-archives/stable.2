Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.206.34.216
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795055678;
	b=zfdjLO7IpJHTRMOiG0QhSnId9Y999dY4KhnAa/IOAGIWH9Xtb3b/k8c9XNV71JIp5UXE
	 eT4owWYS2wO0IH+NoFbfFqeHOHj9v2KhrkQu20BEyAMZwqg96cs3Z74m9GXfXEQ3rIp7Q
	 MTWHnV2doc3d3SAiiys/fdU+bvHZV0flO2Wn13JE9rcCkLcR4xMcsK+WcLh4Sxp518Uu/
	 xIQ4XVGbZyMuDlEIDn/HEnoFvq+OF+uciXNaH/jx4EMASrrtdMX0yvaiG8wjKgfjUyyo8
	 dXyN9N3SjEYXwoQFquFC9pyuYhWFaymnA8X6r3oJ0vV8g26jJ5B36DQpWcJzC5Fw4Yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795055678;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=NWIAy970D7IAIWRmiARvWCeNSqOxxJ82zzHx0zDJ14Q=;
	b=O+n2jqhHijJWaSHUm+8ihvIgO+4cTh7OvAWbFCBouv16T69pk4Y1Q1c6G7Cs645zVPxV
	 +lr1LTIdHBxGw+0dnOVCmggSEMdxVq7wkhYhJFjc7iEBnciRNIXvuDnmXOXPP/2WDE/0d
	 k1vv6u6cfAYAYeY8t131fMtJDuhdttV61XGnpDXmpzm9SJEWRcysqD387tfaneGs7fcEU
	 gBMw/bD9AEwUtd+9rjAlAJcd5Nx4cb45aDnPAdky0AdCdjxRnSEEluGsrXN6XDFu+Po+c
	 RacYVeBzIHRAnZ6mhNalCkqYnAUnG8aDDHxXhhucNSbmferi3HM0PW/YjhSeH+q3cYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniontech.com;
	spf=pass smtp.mailfrom=uniontech.com;
	dkim=pass header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b="DP/IhE6E";
	arc=none smtp.remote-ip=54.206.34.216
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8544606A32F;
	Thu, 19 Nov 2026 02:34:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8544606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=DP/IhE6E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1795055651;
	bh=NWIAy970D7IAIWRmiARvWCeNSqOxxJ82zzHx0zDJ14Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=DP/IhE6ECjJ34KRu4qaq4bqvPVKpih9TbpBrVvfhzEuXr5Wl6peWR2k8aodCFEY26
	 XMqQSvNg0wyGGMg1fWjv9fJFQflWOAwcu7mN8eWrNg9DXexi2YSlDWu1usx3/ubzW6
	 VBr/P+ZBPOA6HUx1+ILY4Qa2jaCaXYP7DdCLCP7A=
X-QQ-mid: esmtpsz19t1795055634t6adb41ec
X-QQ-Originating-IP: vqazEmxYwN7coQ0NjV2eFe2g4KowLzF55Anit55aniA=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 19 Nov 2026 10:33:52 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10835884347788854499
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
Subject: [PATCH v2] leds: pwm: Fix active-low brightness with default-state keep
Date: Thu, 19 Nov 2026 10:33:51 +0800
Message-ID: <3EE90AC92BE07EA9+20261119023351.3933065-1-raoxu@uniontech.com>
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
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NcfXIs+Ms1qHq+yLmdm59As9CLDtRYIfqdi56s7XPWKJfr8gk9CFOIes
	ciGUJIV/67u71sw+RJ3dhNK+pmWnngLwTl8gdSeA7w4/h4O1R4BCsGdJsQ13ZN/TwI3YVKt
	YVp0WAcKtZazqbX3RYgTILVhqM6y08XqyDkSjpSvMJivqAdkEHGisokMkvJ74bpcvwc2N9o
	SMYRi2EYHBKFKG9sxm45gixe6gkFNHkh97chGxhkQXHmwD4cPwX43moLQs29wfRZBvcLFhS
	0KZiy/dCtqrXbyy0daQJj55CU/Vv2DjC0B9Ja4eXwH/WqNYACIwoSkL8Pz8Pdc3As+5rlYU
	y17cJOnZQa1XqV+Lxy6VxL2105CvvHrJvvd9NPdPmW/Gky4kjk10/xv8EqdDSLoDo/lTNaO
	3+qWY+6B5w06KFgNC302VNLJH6fDQKLcXpoeawVqXqvNR5HwH2pn1cMJzhW0SMETRuG4h8F
	dwJN/IRCTZI42YLVYVaFfP65bu+NetvUYY1l9LZZLiTbm+gpmO+jcwdcYYKnLaNQRey9ZSw
	4CzlcE7rqaM3y7zJ65ATADzn0Oes2Xwf+2miSEfZVc1ZMdxVsSuCbcaJe+IrxFPmpbz3VxZ
	EslKwPEV1ENPHea/FccTfDuQTsQQcB/AOq0sVDPH7IHRKAsWVnu1HfkZoyQ9w2rzjTXdJjP
	ep/pJ2IzxolxQCmRq//zsw3KDsMXyhLAlJwCwFRDMaUtONvKH8s7DxxWPq2rqZ6tdVbV5k9
	ny00yLKyRQUev0PB1g0ksqc+3KR13UDSbxM1fXfY5Ec1pj1sXFcR631PeoUR/X1Mn2w+eLI
	+OecnEzyjhcL6No0oRDo5HZUFEk7vB9zuAMuSoHTPR+H+ago3kD7MKSrHaMvsFtkkyWdhEQ
	k6OWCOOLZ6jozpEXdjHOhppO4Ovr9mIm3W6OgaMWzWSocQsd1nCkM4CKs3VHqUW6J0NIsUx
	GUlWjW3KYpwJBK69uFfE4tQ6L9OclI/bH846rK6GSPaoGDYgjhEaptTOujFPU7IsRKeq/wm
	OGm2MO94oH0aAb1iZ8KqdiGnBatII=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

From: Xu Rao <raoxu@uniontech.com>

With default-state set to "keep", led_pwm_add() derives the initial
brightness from the PWM duty cycle without accounting for active-low
LEDs. However, led_pwm_set() inverts the duty cycle for these LEDs.

For an enabled active-low PWM, zero duty corresponds to maximum LED
brightness, while full duty corresponds to off. The current calculation
reports the opposite values. This exposes an incorrect cached brightness
to userspace and can restore the wrong value after suspend. With an
optional enable GPIO, the cached brightness also determines the initial
GPIO value.

Invert the computed brightness for active-low LEDs, matching the
conversion in led_pwm_set(). Only derive brightness when the PWM is
enabled; otherwise retain the initial LED_OFF value rather than infer
nonzero brightness from an unused duty cycle. The output level of a
disabled PWM is not guaranteed by the PWM API, so this does not claim
to determine its physical LED state.

For an enabled PWM, reject a duty cycle greater than the period before
the conversion to prevent an out-of-range brightness or underflow during
inversion. Check enabled first, consistent with the PWM core ignoring
the other state fields for a disabled PWM. Keep the existing zero-period
fallback to default-state off.

For a valid nonzero-period keep state, do not reprogram the PWM. The
optional enable GPIO is still initialized from the cached brightness,
so retaining LED_OFF for a disabled PWM also deasserts that GPIO.

Fixes: 3d3d65bd2764 ("leds: pwm: add support for default-state device property")
Cc: stable@vger.kernel.org
Signed-off-by: Xu Rao <raoxu@uniontech.com>
---
Changes in v2:
- Move the AI-assistance disclosure below this separator, as requested
  by Lee Jones.
- Do not infer brightness from a disabled PWM's duty cycle; retain the
  initial LED_OFF value for both active-high and active-low LEDs.
- Validate the duty cycle only for an enabled PWM, consistent with the
  PWM core's state validation rules.
- Keep the existing zero-period fallback to default-state off.

The PWM API does not guarantee the output level of a disabled PWM.
Retaining LED_OFF is conservative bookkeeping, not a measurement of the
physical LED state. The optional enable GPIO is still set from this
cached brightness, so it will be deasserted for a disabled PWM.

For an enabled PWM with duty_cycle greater than period, this revision
returns -EINVAL rather than clamping an unknown state. This fails probe
for the pwm-leds device, including any sibling LEDs, and is a deliberate
choice to avoid deriving brightness from an invalid enabled state.

Validation:
- W=1 build of drivers/leds/leds-pwm.o with CONFIG_LEDS_PWM=y passed.
- Source-extracted initialization tests passed for 6,004 combinations
  of enabled/disabled, active-high/active-low and duty values, plus the
  existing zero-period fallback. These use stubs, not actual hardware.
- With period=1000 and max_brightness=255, active-low tests include:
    disabled, duty=1500: success, brightness=0
    disabled, duty=0:    success, brightness=0
    enabled, duty=1500:  -EINVAL
    enabled, duty=0:     success, brightness=255
    enabled, duty=1000:  success, brightness=0
- Physical LED, enable-GPIO and suspend/resume tests remain outstanding.

OpenCode AI assistance was used for source review, preparation of this
revision and test scaffolding. No hardware Tested-by is claimed.

 drivers/leds/leds-pwm.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/leds/leds-pwm.c b/drivers/leds/leds-pwm.c
index 3e5eda8590bb..f06eecf7f5c0 100644
--- a/drivers/leds/leds-pwm.c
+++ b/drivers/leds/leds-pwm.c
@@ -128,9 +128,20 @@ static int led_pwm_add(struct device *dev, struct led_pwm_priv *priv,
 		{
 		uint64_t brightness;
 
+		/* A disabled PWM's duty cycle does not describe its output. */
+		if (!led_data->pwmstate.enabled)
+			break;
+
+		if (led_data->pwmstate.duty_cycle > led_data->pwmstate.period)
+			return dev_err_probe(dev, -EINVAL,
+					     "PWM duty cycle exceeds period for %s\n",
+					     led->name);
+
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
