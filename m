Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794499524;
	b=YoGTxvs7jku/umuDoCydYXQJ6joNdhvVQAnbzPXMPfZiwYlobUeAR4+atLc05TYcEHLc
	 kLH6TeVBSScPeFNPNHPzbh9QLpGSp36T9Lc3b2DIToBiymWSP0yTgbLIN/KFpNaceKDJD
	 ZmHwprjU3nQ9MmmFA+B33DHfWvrG0wmWMFS+X9+bI5tKp4X80pTQ1+fInzCOocm/Xe2hK
	 DgLmjq1HZlbNWXmnKkd8tMHj3aa7irlxuAY/VRrqZ0BmuMqvQSk7A6DLYVYDgw6uSlaTL
	 tSPXzaOydef4rPa6JWW3UbTZCAnr0hFam7OfG2KnmP66LkSYXHxMMxg4N/65J/T1XGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794499524;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=tE76MrQH8XJvj1ul1v3QW0sYF6230jiCP1A1lYdk1PE=;
	b=WIgN1eH/4fzvHTSCIo0gh2AkBZdaCcn60LacX7A4Ff7R3qqf7Uh5EiF8WlYgRkzVKDME
	 ra+m4LIdaxlm2RtUsdYK1xlUxTa9JthPZ+4YojZAPVAua2CmqA0Hp8PuAFa6u0Nc74WLu
	 qMQzamyXGFfFnLK1oGV+yHP01bby+0PP53H6m6jsL3P5e4FAeGHw+PSfuYdaeFun1T7KO
	 v02YbhizYhFiGumCn4xkWfD89PwdipYho3oflFQkp0xrqFtvYkIZYOux2j5t1QXPh/RTw
	 ld8VT3rt4xfbaa7s/ChiKDyODuvlJO8B6jYoAHfD8QitLuHIaAszqbmLFWT1nI85fMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="lA/WgH/8";
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7251F606A321
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 16:05:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7251F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lA/WgH/8
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-36e90071735so4787eec.0
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 08:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794499524; x=1795104324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tE76MrQH8XJvj1ul1v3QW0sYF6230jiCP1A1lYdk1PE=;
        b=lA/WgH/8VpTAAvkenjCckrLDv6u+z8zGa6rBI28SHmsRN2iQKYpA17c7IHozKLle+o
         LC0Zv+ldNOygUQfalmvImLv3i7vNbmdfc7vB7E+b7S087kyVhfOjg7hwHi5TH7JZOUO/
         Xz8g+xlOleZCWbZPmGZtldPlHzyHhUvgvf9iwWGJeCAwAujBncP1pOySJpBJQLqVuI+t
         ddfh6Vv4W/1Q5K0lh7Rb6U7e4hKg51jCl3zHSRMO+m2LjOe75YcxlpJc6qZ5TmxFVRTm
         6ERHSpyxJqx464i6bhI59V1EDLIZ9+KpzrTCt921OdiDxdiIIzniWcEUa+ZOttdSJWci
         vJ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794499524; x=1795104324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tE76MrQH8XJvj1ul1v3QW0sYF6230jiCP1A1lYdk1PE=;
        b=HET0V3+VzYwxTmHmk3kBHoAN4IKFA2TNtjNjv/z4PBWRXfZACHFeM7ZznT3CrtU4U4
         slNa4IoDEbYCpFDW5FcO9LeUss5vhmFeO6W1dLzgTw7y0yDiS1Pvl4E5hym9UWpZ7hbI
         7VnrdBpY9Vo/Iv5Iw4cvfsHp1y0H35b3wvNP1gLF0p210udnAVHaTxs8M2FK77ip5T78
         EB14zuBbxVLxcSJT1f0xFOUf5QezPytsws6tSTJR1n9jWW8TrAOmsyzgK7OKtLqgyzGo
         gmVgj35GrZ9aTPVyprp+rYDXS2FFO7quSqOnY6WlzN5myTbiQm8KJEYbyIDOt6jQG4kW
         JCnA==
X-Forwarded-Encrypted: i=1; AL+hErHpl9Se9olGoIpiP8Jmrq3h54bJz6aiTc58T5Q458tTfdIqsxzKfKqtbSyLJFl6XuBaJ7kyaW0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8XrPRimN+Jx01avMxihyxoetLOp9SoYIJJN8+GeK1/O8eXs1iT
	KD7KRV0KTv7cE2Hgwkkr5PwwQGlvR3tNMImCrc7+AeU/L7rETua3kyzp
X-Gm-Gg: AYBFou1285R513XoQJmC47owzSG69E+7esH7ZTyaekcdN79QqnItkvNEW5xuctX3KRx
	XGzWroVhc0HDewQzX1PI/9HFmOJarMq6nboI8blg/AffS66OPb4oKT/6FrOWgGLUD7cR6+UOSnP
	LzT14Fx5G5SXMN1hfk5m9W9LTEHjfUTPYPL9cOjxkJaL4Xc5xZHdgXAZhWd8ZOjSKufs6yqowII
	2U/3lEy7jiSuW/ZybViXo6rOsaQR1W1iu1sMnIw8d+TPgSqSQdo28ZT+uZVs+G0AHaI3OWnB0gg
	JjsUfqkRHmzzlbVSQlX0QVNNrkF3sn8agQctenJlKPO+flJC0Uuiihl8tmYyYAXO3gVpTXZVPnh
	/jhACEdWgYpaM8VzkES6Qb/tOJoPg40Dc8IspZQV0RPDvQcTFxUQ/vFTe5xQh7ordO/rJsZ5a5r
	NehVvssm19p7taZJVwHWvVFYBNGKRIvQ04xYZDF5vVtuAILhzmexNn867w4+t+2poUuwtTjacHq
	6Y0LBwhZ7MxOjcW0JJlsSzh6kOl3MzxYO3t3NFUuDeoWZ/f6tSW+LAu8bnREqoHdjsY6kmM4UCY
	k3socb0orsxlqxwNgaTNKmVcSI5qQ2X22pQk2tVVmQ==
X-Received: by 2002:a05:693c:8113:b0:35f:ea17:d171 with SMTP id 5a478bee46e88-37684ceea1emr10292277eec.2.1794499523507;
        Thu, 12 Nov 2026 08:05:23 -0800 (PST)
Received: from CRASHEDROM.localdomain ([142.249.36.161])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37922d49049sm613673eec.1.2026.11.12.08.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 08:05:21 -0800 (PST)
From: Chengyu Liu <lui2012qwq@gmail.com>
To: linux-usb@vger.kernel.org
Cc: b-liu@ti.com,
	gregkh@linuxfoundation.org,
	nkapron@google.com,
	tony@atomide.com,
	bigeasy@linutronix.de,
	balbi@ti.com,
	shimoda.yoshihiro@renesas.com,
	robert.jarzmik@free.fr,
	Chengyu Liu <lui2012qwq@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 4/4] usb: phy: gpio-vbus: free the interrupt before cancelling the work
Date: Fri, 13 Nov 2026 00:04:48 +0800
Message-Id: <20261112160448.41566-5-lui2012qwq@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261112160448.41566-1-lui2012qwq@gmail.com>
References: <20261112160448.41566-1-lui2012qwq@gmail.com>
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

gpio_vbus_remove() cancels gpio_vbus->work while the VBUS sensing GPIO
interrupt is still live: it is devm-managed and freed only at detach,
and gpio_vbus_irq() schedules the work with a 100 ms debounce delay.
A plug event landing after the cancel re-arms the work, and its timer
then fires on the freed gpio_vbus_data.

Free the interrupt first, which also waits for any running handler,
so nothing can re-arm the work past the cancel.

Found by static analysis and confirmed with a KASAN reproducer:
slab-use-after-free write in __run_timer_base() within one debounce
interval of unregistering the device while its VBUS GPIO is toggled
(object allocated by gpio_vbus_probe() via devm_kmalloc(), freed by
devres_release_all() at unbind).

Fixes: c2344f13b59e ("USB: gpio_vbus: add delayed vbus_session calls")
Cc: stable@vger.kernel.org
Signed-off-by: Chengyu Liu <lui2012qwq@gmail.com>
---
The reproducer instantiates the unmodified driver on a gpio-sim
chip in QEMU and toggles the line while the device is unregistered;
it widens the remove()-to-detach window with a 500 ms sleep, logic
otherwise unmodified.  Repeated runs: 5/5 KASAN splats without the
fix, 0/5 with it.  The KASAN report and the reproducer kit follow
in this thread.  Also build-tested on x86_64 (USB_GPIO_VBUS).
Fix written with AI assistance.

 drivers/usb/phy/phy-gpio-vbus-usb.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/usb/phy/phy-gpio-vbus-usb.c b/drivers/usb/phy/phy-gpio-vbus-usb.c
index 60b7c1219dd2..82d2301c3804 100644
--- a/drivers/usb/phy/phy-gpio-vbus-usb.c
+++ b/drivers/usb/phy/phy-gpio-vbus-usb.c
@@ -325,6 +325,14 @@ static void gpio_vbus_remove(struct platform_device *pdev)
 	struct gpio_vbus_data *gpio_vbus = platform_get_drvdata(pdev);
 
 	device_init_wakeup(&pdev->dev, 0);
+
+	/*
+	 * The VBUS sensing GPIO interrupt is devm-managed and freed only
+	 * at detach, and its handler schedules the work with a 100ms
+	 * delay; free the interrupt before cancelling the work so a
+	 * late plug event cannot re-arm it past the cancel.
+	 */
+	devm_free_irq(&pdev->dev, gpio_vbus->irq, pdev);
 	cancel_delayed_work_sync(&gpio_vbus->work);
 
 	usb_remove_phy(&gpio_vbus->phy);
-- 
2.25.1

