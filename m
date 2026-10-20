Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792510886;
	b=p9m/ls1HnGFKd5e5HLRXuH81fKYEofxUcXBtllsz+IHmcSs0TyUm6lxhXtHssFNKQB23
	 ZGTkB654s3rdSti2o086f3DMKQGdBUvxboSwdYG8G1Mv5nSXokYqcwu2FqpoxPYVa86U5
	 9bPaJ/iJg7z9oiAnQZURhO6iJYC8nkj4WLu2MohZmd/q+I0bLBPhhl6CU8FDQb/umKvay
	 13l+24WYVTJoGvmKhYJrdNEpJbyH7HS5rhrJSaOzmdu93AoDInrhtGAAdkAwBnc0PG+xf
	 l0nN5o2p581G0D7kGuQU/ad1QmSHSU42BvTdzh+NtYjlyeZgRzxVhw6lAloVIZI8t2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792510886;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=I4BFOLPby+9IaiXUcXIrSNoWr2vqcdZumYeXf9DjvkA=;
	b=dlLiGlVGU3dUurbx4zXP4gX+nRYl2wymAYO3ChitX0kSXo5Qiq0mYkrQkBL8Tx+Ft5Y2
	 bF+3G4qqjfBd3b5ZkTZP9et87yQs7WvDcAwv0QQ95/7jMHDz6SV9rQCa+vV+PZEv+KIdH
	 5RpRetacBHZZTPUwXJKziqahwOvAVMQ1QsLAUInd8wvJ9foWxgNsOpzfuAi89n6NkGq8R
	 hhKRhvP7O/5ng1Ruc/Nf8TVE6CzS46ZQKvi4+2YTZH24ax/70ckr1j7h36HKd7yBnnbGw
	 Ag2YSar/k8dIn403a711mCQrPHodMBQr0cTBTsdNmwoWj9Uv9iW3SjVhSfI5bU0Z/0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nqZn9Gb8;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C1B606A326
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 15:41:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01C1B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nqZn9Gb8
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a1cef0439aso37338605e9.0
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 08:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792510884; x=1793115684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I4BFOLPby+9IaiXUcXIrSNoWr2vqcdZumYeXf9DjvkA=;
        b=nqZn9Gb8gXLFutDCN7T6sIcSbt+oJB5yqG0AmRok0ac3RqqCnqyVCe6sI+CaMmfxd/
         D25iDWH8Os2QvQkWKqEhgOwRGchPnMtrHg4i9k725HrzbVR8SYStH6sWnyRYA6lP2/Vi
         eowvYdRFDAdcCnQ3W3fP/TWa+FLYq320z6yWst+KFoisKbxJHeOYvzWBSb/YIh0n6Ylu
         vinWlpdHZUnQFo25+q6h5R/bGJicJVO6A62k16yv6hjOvQKltZWd1wp7hpCVjRyy79yo
         Ai5/sYUXqXGnSjV0ZzTQfO1e1nWIF4QX9S1vBNJfIXPMqEJF6MROYONHJUmO+HbFFuwP
         ruKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792510884; x=1793115684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=I4BFOLPby+9IaiXUcXIrSNoWr2vqcdZumYeXf9DjvkA=;
        b=pCIMANH6bfuPdXF+XtPe42BOhURxesK1m5j9G9YBolhDAJZNs1YzYo1t1RWoN/zRdc
         6E4hM6d9v9zdUkS0JTpjn7Mqk1gcvieywRMBEWn2SspytYeagr4nWhOM0fpByQjadONp
         quiCnQCs30a41meYHhVZU7XR1WD+GXpK4WcbniHZlUhLgkHp5W/aHxuJvqQ2Z+3cujaW
         TgtlhfQH96m+//FKpbqnL+rfUCPchyXMzmgpWRX4IdTYz/5ByADlbUHOjxbNTCrH6jGv
         8f1gIh2gp0JizpQq2LxtJ4RB9jqHlPV+XONEPqDdBAMqSQEAxBmz2Nmmzo8i3JyDaSVg
         ihwA==
X-Forwarded-Encrypted: i=1; AKwUvBxZj/aTLRMhWrT0sBVazB5PM2OOwbYcgvE15S4cmZ8V9EBOtjA8LWEWzLkjTu3K1Vyg5h95Z6o=@vger.kernel.org
X-Gm-Message-State: AFq9FYLSN1wFeavPTVixysxcjJEGX4jwsozCF1h3FXY1/p6gvUknS5c/
	cnJuLdFP5vUqB1HkY1YGWjt2xwIdjPt1NY+XeVJ63zj+dvtTgLzYLeo=
X-Gm-Gg: AYBFou3dKu0Du+CAnb0/t+ArFVDG3b4yc/smUsM6mL6dlFqMQ9dkdRD57A9dPehcee6
	TuH1mSQt4wvdZscT2/VAKw2mr0GZ/FcQgSBbZH/udYFYi8g8WsN195qJkz22qLIfqoNaIfqSxzy
	PtBwWrTzXNjM3s3hgMxnRmz6XZ2PK/gjV9W96o9hBpbt318hP4Iv5FaM+AgV6MM5exAaNnGUxu4
	sptLRoww69RQSw9WwS6BjNshK7GC70ansAAD9Y2Jck6HezpIDRYWb++m4FZNCxXOK1v3+kGO3xJ
	XJhoBnfPcVKrY40wY2fGpI3CNm21QP6tCadm9suexrj/nJmBLMvYAMkXCmcmp9SwiivE3pdc9OE
	+v8p+6Flqm7eIMIjSZ+uDSa59dmxG0ylznNyEin+gctCfCAtNm3a57FRi3snFx7LDtHi+cOJ97D
	NYwgn3Erb/KZMsIZfqlnqUesKXMCWTlqWbi5xjWNfjALtSLxxGoQ==
X-Received: by 2002:a05:600c:8b6a:b0:4a1:f89f:35fd with SMTP id 5b1f17b1804b1-4a1f89f3764mr37513285e9.24.1792510884253;
        Tue, 20 Oct 2026 08:41:24 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1cca31234sm256606155e9.4.2026.10.20.08.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 08:41:23 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Chanwoo Choi <cw00.choi@samsung.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>
Cc: Kyungmin Park <kyungmin.park@samsung.com>,
	Seung-Woo Kim <sw0312.kim@samsung.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH 2/5] extcon: max77693: cancel wq_detcable on driver unbind
Date: Tue, 20 Oct 2026 15:41:16 +0000
Message-ID: <20261020154119.2568395-3-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261020154119.2568395-1-tristmd@gmail.com>
References: <20261020154119.2568395-1-tristmd@gmail.com>
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

From: Tristan Madani <tristan@talencesecurity.com>

The driver schedules wq_detcable as a delayed work during probe but
never cancels it.  If the device is unbound before the work fires, the
callback dereferences freed memory because the driver data is managed
by devm.

Use devm_delayed_work_autocancel() so the work is automatically
cancelled when the device is removed, matching the existing irq_work
conversion done in the same driver.

Fixes: 297620fd1e14 ("extcon: max77693: Check the state/type of cable after boot completed")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/extcon/extcon-max77693.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/extcon/extcon-max77693.c b/drivers/extcon/extcon-max77693.c
index 2c567e0b7b7f0..a76084e4d5512 100644
--- a/drivers/extcon/extcon-max77693.c
+++ b/drivers/extcon/extcon-max77693.c
@@ -1251,7 +1251,10 @@ static int max77693_muic_probe(struct platform_device *pdev)
 	 * After completing the booting of platform, the extcon provider
 	 * driver should notify cable state to upper layer.
 	 */
-	INIT_DELAYED_WORK(&info->wq_detcable, max77693_muic_detect_cable_wq);
+	ret = devm_delayed_work_autocancel(&pdev->dev, &info->wq_detcable,
+					   max77693_muic_detect_cable_wq);
+	if (ret)
+		return ret;
 	queue_delayed_work(system_power_efficient_wq, &info->wq_detcable,
 			delay_jiffies);
 
-- 
2.47.3

