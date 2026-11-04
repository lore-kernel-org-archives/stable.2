Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793800129;
	b=Pte8M4tCuoteAepamAqo/lCNgQPY/ADrJtSKD8Q+vKt7nU/1b1EjzhvhaPSWuC8vA8av
	 /1JMQbgjBXW9hQBrZsGjCETTWjc6tCAwX7kt8q4CLmj8iMRQKahipSWT3OORvReSjwbh0
	 Bve8AVxfAiPFEdve1U3HrQKaHtzVF9tdzqxTgtW7RQOh7X+CvT+7KraB1AjxubJN0HloR
	 fXxDyzNIVDrC7SSxygLUhkLeDNy2gGby+230PZ0aA4yVRltrGmUT5VHCO2WVb8vApzwF6
	 qG0cBNc0QighAN4HZPNgfpCgrEpL+mfDkxExBiwRru9Ikbqh+DNXyTsZHLyePBuqdiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793800129;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=gCKhCVXJMv9/Bm/v8zaji1RU5Lk+HQKXjmOYbZ5e9vs=;
	b=1jD1mQWzRkH/lwqwSYVDINtGn4D74KjV45qRnEArkn6oiBmuTzmARswcdz+fOsuHvdAW
	 r3FBb00aw6sJs9HzO3g9DzpzScB7jMffEHRWvri77ngJ35WnKY1ht4USZCRhEFyVbgBlz
	 Rblw6QMSCZWXf4K1bM4TQRT7NEUeiI2uIMWzXjOgidUeQuPx45RWwHwPDg4K8R+Y3+rjU
	 d9iyg6sXB4c4hBzLPX4Dqm04AoUvF/AmDd4TsQrxrG40S4daTPyLMLwfgIIFI1FZjk73u
	 /2HxMMgrQc9S2fsnfs6X9fivqhoGfEtjhr4BjV/9I1Eemvgb4QLZyQ0kxdCph9AjhNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="rcaJGYl/";
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1A5606A328
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 13:48:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D1A5606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rcaJGYl/
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3646e6de3e8so52256eec.1
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 05:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793800128; x=1794404928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gCKhCVXJMv9/Bm/v8zaji1RU5Lk+HQKXjmOYbZ5e9vs=;
        b=rcaJGYl/vnAIvZO0CyhbAFybKqCTxJuzw4fe8Y1bSl4/2uUUhPGY8KBYNGQu42I9Np
         oqI/tQH3b9H9zsojusVTaj5t2gLWDfGcuM4iDxz8f/fTai5c6pSALPmHx5R9VykklB6g
         oi2n7HYaKlnFeTXFAGKtyJdJiT8dI0BfXQtbgCbHB2zUWZO02Ra2C/l20yKs2ntJuiCj
         RCNePa3s97qrsK0hMqYlmBUoJI/lJBgP1Jr1eyH6JtDnVzlK55Iid4kzkyeXUnQeXet0
         GonhUOech5zQvk4WM2eeIw6q2tUwoa3l+HICCvBPNvj77SEuRRCnSC+GHg4ekMax+9kv
         scSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793800128; x=1794404928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gCKhCVXJMv9/Bm/v8zaji1RU5Lk+HQKXjmOYbZ5e9vs=;
        b=yuxNb/xpH/jjjzR3H06HBcYPaAFaS0Ey9SL88fWd6CpcvpfbV25ntZQvyIXaFxbDil
         zWcCuWwGb90vXvKy/ELeRgpKBibzu45dIzh7TMCnWG93lPTlFL9imP+FBLqMbS0a/lby
         hGRvsTy1knC02Cxeq12grF+BZv29cqzrpgsDoGNMavFGtx49962LzaFX2QTKS026Gq/O
         u9DVcmL1Xx27yWa1US7IeOvsXG3yz/0FCmJYyT1NHuxuN8LH7CIMmz04S4/9zebzbUGk
         gzR6A/ETfG3/TR+WMmNBJ9mi945J6b4Cqdt8eaJqqtiH9zJi/OdWp6t5/hHPzT7bbqLG
         42gg==
X-Forwarded-Encrypted: i=1; AKwUvBz/oYZvc55KsdyEOJLrndxXqGIIoOUz0RqwBRF/c6Fdk3ebmcEt3FvxJv7LgN1yC3wogekKIxI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+EoJiZ07vKH2d1v6SBVpFzkg5t9DVzpaFbEHCoAOchwvBSMhdg
	StaswiC7Sz4Vy0yNehaynntj8Hau4aOgQf90c+yj52gBTr+7EpfwkI464Uywy11S
X-Gm-Gg: AYBFou1CmvaPTL0V1pg53bZ+4de9q5i1Anm0k2/qsE4N2sQOeS8IutsLPdoWMIrIT7J
	8wi0PJ0Ppl2//D/Pbd8o+97ERQhnKoKgrokNvI6dmWNztctwBEI8ZvcZ+WFGSVjnXrdvaV2bqr4
	yUa/DqBHUzb+BtilBIQy9T/4Y4zajYmbRmmS9eTrdLME5zGgJyAaULRyvVWAg1xeK3enV5nU5im
	0KRc9GfeNU0SPJkn2W+AoH+LCPiihqL5FMPQsUAT17JHMeO+V3Tm8h6ROrkFXl51f0OnMT7GZoR
	OOqCmIL9NTxNzl2VyT0zb0lpZCL5KH2Dhnpj3wHkAMWwz2v42pSyWgOMge+tdoeZ18j1Rm/5T20
	cmo1U+py8rRBkGldE7Lg2hSL+xBHpAMqz2INt81GIrtADIYMl3xoByA8s7fXseVYgrC+OtYMy5F
	JQ05UsqD/7Xqo4Ds/bHrvNQMJ3MWxKTZ8pfGe910lxoX1kBTneuA8vFJUVQWwsPKZ97DDv7eUto
	F4m7h1UwOpYj/m/ME+oBV5rRSukChlthJmBKA9HYxK6BiB6wrrFbTgdAdvdN5gENcIKo16dBq2w
	FaIFosk6nusTrTo2PlFuj2RwHjeEOQRQzZ+aiZLyBg==
X-Received: by 2002:a05:7301:144b:b0:35e:d21c:f33e with SMTP id 5a478bee46e88-36a4220aab3mr34973632eec.1.1793800128103;
        Wed, 04 Nov 2026 05:48:48 -0800 (PST)
Received: from CRASHEDROM.localdomain ([142.249.36.161])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38f53a6sm7148327eec.15.2026.11.04.05.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 05:48:47 -0800 (PST)
From: Chengyu Liu <lui2012qwq@gmail.com>
To: broonie@kernel.org
Cc: lgirdwood@gmail.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Chengyu Liu <lui2012qwq@gmail.com>
Subject: [PATCH v2] regulator: disable disable_work for good in regulator_unregister()
Date: Wed,  4 Nov 2026 21:48:38 +0800
Message-Id: <20261104134838.326041-1-lui2012qwq@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261103174911.1600930-1-lui2012qwq@gmail.com>
References: <20261103174911.1600930-1-lui2012qwq@gmail.com>
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

regulator_unregister() stops rdev->disable_work with
flush_work(&dw->work), which is a no-op for a delayed_work pending on
the timer wheel: flush_work() only waits for a queued or running work
item.  A disable deferred by a consumer's regulator_disable_deferred()
therefore survives the provider's unbind, and regulator_disable_work()
fires after device_unregister() has freed the rdev, dereferencing it
via container_of().  Use-after-free.

The in-tree users are ASoC DAPM regulator widgets with a 20 ms
power-down delay (sound/soc/soc-dapm.c): the window is the entire
deferral period, not a race between adjacent instructions.

Use disable_delayed_work_sync(): it dequeues a timer-pending instance
and waits for a running callback, and keeps the work disabled so a
concurrent regulator_disable_deferred() cannot re-arm it while the
teardown proceeds.

Found by static analysis.

Cc: stable@vger.kernel.org
Signed-off-by: Chengyu Liu <lui2012qwq@gmail.com>
---
v2: switch to disable_delayed_work_sync() (Mark Brown): also keeps the
    work disabled so nothing can re-arm it past the teardown.

 drivers/regulator/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 6a4008f387b5..4ba0457c4747 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -6300,7 +6300,7 @@ void regulator_unregister(struct regulator_dev *rdev)
 		regulator_put(rdev->supply);
 	}
 
-	flush_work(&rdev->disable_work.work);
+	disable_delayed_work_sync(&rdev->disable_work);
 
 	mutex_lock(&regulator_list_mutex);
 
-- 
2.25.1

