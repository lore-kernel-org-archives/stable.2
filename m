Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794212819;
	b=isHdZzOPn/BRT34voPW0cuyUn2/3ZOM5m0rAwPWJ1vryUB+2wdM2qTTzWipSuVyLLC8f
	 EqiLKxw2EaZL6QhclW7Onc1DrL0fGJwnuYDfsIki/GADKRmusx6PHUZO25B4dAOZLWGzc
	 ESpbjBdQCHotHBsEMpMnpKMF9WsvSAoWV1k2eqPZqjytJoQsuTr46t/U7zA7sM3FxLD55
	 BvugrcQl32CFqSHSe75F7ruOSewIP53ze8vkrO17sTP1aFd8yaQgS0TNMuHntonbufjTj
	 WXogJC6Jb1KWtJ7fL/3mhBjw6irCzWkHQJULCSMwlSdqTpTjxjsxuIbf9O5UV5qxb3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794212819;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=IWGbInK1jdqWzqaTB9EgR+W+5CoWAJO2TLJFxQVt21I=;
	b=lSxNMtozvIT9Hu2fuzj0A/ddcvQgsMOmqb5GiTmxtf5KZlRjtOv67HeIDmZX3QCSq5wl
	 FGn2x1Ga+TKIf6AmQP5/WaaqEPFyMXDISBGdAglPNRE4shw3ayYuqVC6TVYeGS3tU7ful
	 OQ/6B77gzFXyPDri1Su5NyuodRq8v/W92Alm+GOo3A7dYoFZC4m+XahIl54EeBA7uYqxE
	 gQnVp+HhY9YZydgPvvarNJwdEkn4jbmC5Wi84TKZqQxrnqELHdln/9rbNtJJxK4bWeTzt
	 LfxkzKPQLbfN13pSu3pHPSD7Cn8Hb6egbzsDea2rkHYpTEEbro3H/+rkOFSkY5Jkahw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oWP+Rohp;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BB5606A336
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 08:26:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3BB5606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oWP+Rohp
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48e09aa5264so313902f8f.2
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 00:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794212817; x=1794817617; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IWGbInK1jdqWzqaTB9EgR+W+5CoWAJO2TLJFxQVt21I=;
        b=oWP+Rohp/ZJqGkQ+oORUcfZmPncX/8Tq39EQaGWxPWIS52HRy425y5lFRzPPC3Chpl
         /R7Jba9ogvC+/fZs6IAAZLC3jvceX5rU0N7ivWgRMFm8SIrKMTFw+1zt0ASAEIaa5JAu
         UiwHcK/EI2ZqUTaK8ufuyQaNuPAmmgTyJ62mcVKWNy4xbc1yJKoEzMxYi1VmdnGuwMKF
         0lpR5fsyxrbB5W39WxkLI46qF1McQOggOviPNfVmhqipl5VHYpLizq1dXBzyHZIs8QOV
         7ekEv63CMreUCjyBhkEpfNMx5f2L/Yxte8iqYzHEvOv2NaGv2E2dLtPqZ4wEAyPxeMF5
         uCnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794212817; x=1794817617;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=IWGbInK1jdqWzqaTB9EgR+W+5CoWAJO2TLJFxQVt21I=;
        b=rIH9pvo3ci/5t/ZnZlLZUq6wq5FrUghG9FZhLZUqqM06ZD6GS7TZjJlpRz0zZjx9GF
         dnWgtn8snA2TRKjYmT/WNaZGWfz2n+Cz43k4ZUglgEGql6u4hbR1JXSiHIlGC+95PkMb
         Vs7MkCVX7csy0QMmJpxjCT5wycK7lqtrgp7kBJJPl8uMsLMT3srS+y+XASz6yRBS4VTz
         En8OaiaKdSV+QiO5OMu0/4RVehGqJ4MKFaP2OktAjDEHPYn6d79Kqwwq1iVO1qauUV+e
         5/y/+5briqrMavn5JLtJmzbAIips5pHsvbVHkxMmh+8KukDwGk5vtYQEoZCbc4NrZGb9
         xu/g==
X-Forwarded-Encrypted: i=1; AL+hErGqhUCq8IIW9yoj5BnESA3FzLLUCAU+HKbM9ygmpqdnRr9dPFsP/denMXnnX++8EMGftCFwDXU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8mAZ6o0sAOoRjX8BnQ/9bk8eQ5hVzUt272LRVEFCXsacCQBTmm
	9A3fj13Pr5FjVZs/D50VahWqELZWzt+U7N90aSpvHR9JvhH7F9NB6xi/
X-Gm-Gg: AYBFou3+jrgGfCOtevf2GaBiCTA6f6N2raOeIZiTkMAnnnlMicysri4M9pySIvw8ZBU
	77/fc+Z/g+nS4uaq9lxy9vGrQXkmeKMzsZ873nkUTvxnkUJqQ/B7gaHXiqofUVipHRow2b8O02C
	dQqClEImgSBibfEmpL3AKAPsiJ3U1hzveRXZ2x/jcySrHFh5NLK6HY0DFZTfDuRcB7NXv8TqTW2
	1LLX0VPhF9XiC7Wm9GOz1RotwB2rcooFjd31IbfeSr1EAtthyd/W03f1JwIoQhc+G1iR0IFAbIU
	RppligIuhnHhjzi/PtnDR0do/9dQR/45ke5FQoLv0s4mZnZGumtveO5j+Kyz5sM9cyI7nVpL4EI
	WoB15sZ2J8tU8Pt8tSFIZVCl7Rwp6n5glBZ4wG35Tk7pt+9zawbGQW+QCaEZ4V/s4SmMfb+VZdZ
	jbPPc2k9JtWDb8KRjgwgGAZ3bRlbQhqpMeOoRdoPcw5SSrGU4Vpsx6bZ/Uxq5VPNxDInc4VY+vP
	2ZHj7sup7QkWCBmrK0zyLmySfuT+L4vvs+D/73BAN4tLWzaq4imK28NRCZpNicRrW+EnZTryfbY
	4H7Y+3t7BBx3+Pkac0+cpIMk1ORhplWIFkp60ZSVrw==
X-Received: by 2002:a05:6000:4b0f:b0:492:dddc:64c3 with SMTP id ffacd0b85a97d-49583deb6d6mr5829208f8f.41.1794212816806;
        Mon, 09 Nov 2026 00:26:56 -0800 (PST)
Received: from [192.168.10.105] ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-495b90701c7sm10520949f8f.10.2026.11.09.00.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 00:26:56 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Date: Mon, 09 Nov 2026 08:26:52 +0000
Subject: [PATCH] watchdog: gunyah_wdt: Re-enable the watchdog on resume
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-gunyah-wdt-resume-v1-1-fbd84545ce92@gmail.com>
X-B4-Tracking: v=1; b=H4sIAMuD8WoC/yXMyw6CMBBG4Vchs3YSWi8JvopxUYZfGBOr6VCEE
 N7dqstvcc5KhqQwOlcrJUxq+owFbleRDCH2YO2Kydf+5FzdcJ/jEgZ+dyMnWH6A/bEN0ogc9gF
 UulfCTeff83L923J7h4zfEW3bB7URElB1AAAA
X-Change-ID: 20261109-gunyah-wdt-resume-25bac9cc43ae
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, 
 Hrishabh Rajput <hrishabh.rajput@oss.qualcomm.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Pavankumar Kondeti <pavan.kondeti@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Stanislav Aleksandrov <lightofmysoul@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794212814; l=3385;
 i=lightofmysoul@gmail.com; s=20261108; h=from:subject:message-id;
 bh=JhBHgp9sr8F6eF0LAjuuKHo+Dq8rxxMvSwyeg83jF/c=;
 b=ql8wh3203NCheD2G7gbJkVZlyVz94Lq19rmDLGGQXmLsGxxXzrNYlSbxL6ypH2s0BQ2gF1EVT
 IX7uthTFwsADMsIVAQSWkq77pwMbZ+82PV+GrQp+s6yAdIRlgcFvv2k
X-Developer-Key: i=lightofmysoul@gmail.com; a=ed25519;
 pk=jeRUlfmkhE53CJPoeIIXgu7rTE0ybDRH0HQrEwbydzg=

gunyah_wdt_suspend() disables an active watchdog, and
gunyah_wdt_resume() enables it again with gunyah_wdt_start(). start()
first disables the watchdog, which fails with -EINVAL when it is
already disabled. start() ignores that only while the watchdog is
inactive, but on resume it is still active for the watchdog core, so
start() returns before it enables the watchdog:

  gunyah-wdt gunyah-wdt: gunyah_wdt_start: Failed to stop gunyah wdt -22

So after every system suspend, the watchdog is left disabled.

Move setting the timeout and enabling the watchdog into
gunyah_wdt_enable(), and call it on resume, where the watchdog is
already disabled.

Tested on the Samsung Galaxy XR (Qualcomm Halliday) with s2idle and
deep suspend.

Fixes: ca316e145c35 ("watchdog: Add driver for Gunyah Watchdog")
Cc: stable@vger.kernel.org
Signed-off-by: Stanislav Aleksandrov <lightofmysoul@gmail.com>
---
gunyah_wdt binds on the Samsung Galaxy XR (Qualcomm Halliday) with this
SCM patch:
https://lore.kernel.org/r/20261109-qcom-scm-gunyah-uid-v1-1-2776343f9a3b@gmail.com

This work was made together with Claude.
Reviewed and tested on my Galaxy XR. Without this patch the watchdog
doesn't bite after a suspend. With it, it bites again after both s2idle
and deep suspend.
---
 drivers/watchdog/gunyah_wdt.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/watchdog/gunyah_wdt.c b/drivers/watchdog/gunyah_wdt.c
index 557a78306d18..348c7ccddde0 100644
--- a/drivers/watchdog/gunyah_wdt.c
+++ b/drivers/watchdog/gunyah_wdt.c
@@ -62,19 +62,12 @@ static int gunyah_wdt_call(unsigned long func_id, unsigned long arg1,
 	return gunyah_error_remap(res.a0);
 }
 
-static int gunyah_wdt_start(struct watchdog_device *wdd)
+static int gunyah_wdt_enable(struct watchdog_device *wdd)
 {
-	unsigned int timeout_ms;
+	unsigned int timeout_ms = wdd->timeout * 1000;
 	struct device *dev = wdd->parent;
 	int ret;
 
-	ret = gunyah_wdt_call(GUNYAH_WDT_CONTROL, WDT_CTRL_DISABLE, 0);
-	if (ret && watchdog_active(wdd)) {
-		dev_err(dev, "%s: Failed to stop gunyah wdt %d\n", __func__, ret);
-		return ret;
-	}
-
-	timeout_ms = wdd->timeout * 1000;
 	ret = gunyah_wdt_call(GUNYAH_WDT_SET_TIME, timeout_ms, timeout_ms);
 	if (ret) {
 		dev_err(dev, "%s: Failed to set timeout for gunyah wdt %d\n",
@@ -89,6 +82,20 @@ static int gunyah_wdt_start(struct watchdog_device *wdd)
 	return ret;
 }
 
+static int gunyah_wdt_start(struct watchdog_device *wdd)
+{
+	struct device *dev = wdd->parent;
+	int ret;
+
+	ret = gunyah_wdt_call(GUNYAH_WDT_CONTROL, WDT_CTRL_DISABLE, 0);
+	if (ret && watchdog_active(wdd)) {
+		dev_err(dev, "%s: Failed to stop gunyah wdt %d\n", __func__, ret);
+		return ret;
+	}
+
+	return gunyah_wdt_enable(wdd);
+}
+
 static int gunyah_wdt_stop(struct watchdog_device *wdd)
 {
 	return gunyah_wdt_call(GUNYAH_WDT_CONTROL, WDT_CTRL_DISABLE, 0);
@@ -224,7 +231,7 @@ static int gunyah_wdt_resume(struct device *dev)
 	struct watchdog_device *wdd = dev_get_drvdata(dev);
 
 	if (watchdog_active(wdd))
-		gunyah_wdt_start(wdd);
+		gunyah_wdt_enable(wdd);
 
 	return 0;
 }

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261109-gunyah-wdt-resume-25bac9cc43ae

Best regards,
--  
Stanislav Aleksandrov <lightofmysoul@gmail.com>

