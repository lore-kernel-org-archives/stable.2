Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792895242;
	b=fpe2Z8CrsaJ9R5KvAHYlHKwbgDamwsjRuUPv6eYCvB+LsljAQceER9/TqqYLUxgiFL3h
	 vs9KlpWutj5tDbHeDWSa7rFpVxUq+vYNaNymKxeXD6F0feQTLrsJwrhesgGRrSm7i0e9i
	 RuDESecstUSIh3ss4R3gLvbDo9gt2om1C80onDeTvDnkwda/UOS2w0fGXhFkTYW0rszGr
	 OCr9wLT9P04a8PqeRQV0E1zJFzxHeNPZcP5q22DBGf7jo7BCf8E98BrAnZJlB8Evv2MaU
	 kyv5aGnKXX7tDQt3NdUg5P6qQUmvXCzoao3ApCb7KeuDfacs4OKm3jWofKcGa3WiBJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792895242;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ILnphfN7B6opEr27AV5yqaLcUyXkLPZvSA1w4t2wHN8=;
	b=3pc5b+Afy0cOJ1dRKfx/RNy7yImhPzkD4GS+p4SVZvBHVA1A8KDyxAfIi/MbUWGLsELg
	 JZ6u87Z8jOvtw/D/A/I5OB25t0GXXG/XBXOY5FtcBHHQVhiBU/rdTouRhupqS4zTIbzLl
	 wdYmnN+WU9MH4usv5GNFhTZAN3Ew1UscjU8gbuhYG61ECE2mNljMirzEN5Gdp8I+iG83U
	 fB12GkMU0mIy2sOlwVQxVhLecU3K1rQdc9Rd0O5ec8Z7jHhgHQUMY0QSaT+JS7JZmEIaL
	 PbRyqMo6pBdhnoaioveHG2XVV3lNywvgaAI47Um16rpvn210gGAmKXopbm2KdgDuICg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RaXn1+ak;
	arc=none smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9988606A31B
	for <stable@vger.kernel.org>; Sun, 25 Oct 2026 02:27:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9988606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RaXn1+ak
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-ccce6d9abfeso1270181a12.1
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 19:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792895241; x=1793500041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ILnphfN7B6opEr27AV5yqaLcUyXkLPZvSA1w4t2wHN8=;
        b=RaXn1+akRAg/67j9inzsGfdYM4IjBVcMsg1U1Ef8LmhifXBuKl0E7FMZdagML6aWjE
         5qdq112ofBvQVY8tjaSUL74pF1Wp2c6pok4LvL0e8Bt9B4XI2NBPNkceIAwG+EZoengE
         dDsLsEeQF1yDZkv9uwn+oN2wOCGxuHAjbILMRPgCXYDJvnn2/EXsGJGwvbpCj1cE6fqN
         T+1D7o+V7nHc/QMOn9BvWMdCjkFBeXESL9iaL1lFGRBOxFBhf8LicHyROAEH8bEO4P7e
         LS/r8yHRKAwP50hv4Une7jh7Xq3Ze40M5tGBjQnJUGxRgpfC9WPsr2Z1phNP0AU39U00
         kGfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792895241; x=1793500041;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ILnphfN7B6opEr27AV5yqaLcUyXkLPZvSA1w4t2wHN8=;
        b=iL6/ZJKBngPwD9KSEDgf+gzYg/+jNKhYiV/NfzkB8RJUPZOs1UdUvgfCue45EdCPUQ
         v7dt9FvNlWR68o8Sxd4J/sLcDsqfWxf/7lF8x2gcbIubIJ4kKaFGgCXA8xOgJzrNKLTC
         12t8b6/Ez7QGHCWpe1G+L37tZyCYi4iVM28JNgekQuthBDWoM82TEc+Ta7I19ELGLcbE
         391bsF8jPX1cZ7+PL8hH9WHZQjHFR+BNoshbE1IrnJQR3Gdyot6+b/v0VvdJ0EPI4mg7
         n7QcAOMjvcpqYgTavLQ3wW6Uum2MVDAiiARatbDdrzNgv6IkXjujH+Yq8GZJdH728+2D
         u1Pw==
X-Forwarded-Encrypted: i=1; AKwUvByvbW3TAyL05yTIq1hYhgTg/Ct348eZQxFcB1GK4jxtZdvz1E/0Q6fXgx1L9Mto40BX6nLmnZU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJhjghjgamzRd9+zhTpQAG+Yf49PlfZdh65jzXFrhKVdwSUm2Ro
	b02i1i5D37LtEJ4vF01Kol2RbrJ4ak+D4wVM56J4sUi5X8F/T3gfUWVUdbhRTiVNx3I=
X-Gm-Gg: AYBFou0oPD9/gJr3Tdweedgkr+bOBWvsxVQA8eFuL9xzPl3AWsw3yAQUw7b2Q5QgTNY
	RsIG9TGnUz+GvTVFEpgDQR4tLeqNglViCwsc/1T/tYCmHm+PFyuJ+cwIszXnWgg8xaiQQA0wsDu
	U41kyMwbuYDA+SBSPakBgTnAIUlG6aHd+8Q4weski7p26qkrQZnKvlj25mwcdO8O8CEpZi3URnQ
	n80Fk5ux2ZSAXawImwpLiYFO9JjBrD989ccpJmsfaF8M0ZNJ8qsn4PKmGhdDobK4+0VOkQzcJgQ
	EDFdF744zHe9FhUPnxKlHDEJPs+tVWZck+3Ba9Rio6jPQ0hAbNn37nURO/jyS6LUHloBcuPZ6iN
	RKJVZRuX2zt8hxohcGVvQEzNat6uZnunUVI1iwK3wB1cYl9WvOgwePk87R3rN+enswK2BEDND1X
	pl4lkYw10mPtanusTiI8NizIAOuh77TtFFnEQOJGmOYQvUEl/jVNLleG+lpbWgkLmWuRw9x2BZU
	rESgCoCranBUyZG1cVrBz02IAeQskI9THpixZ/KkdM9YDCBeUm0q0DWeeIxFYRyX+ygvoeDAdrq
	1oc2+xQ=
X-Received: by 2002:a17:90b:3143:b0:3ac:da41:ef7e with SMTP id 98e67ed59e1d1-3adeafd27aamr2667251a91.52.1792895240980;
        Sat, 24 Oct 2026 19:27:20 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:6216:1250::1d3:c4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebad6306sm3064944a91.2.2026.10.24.19.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 19:27:19 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: linux-media@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	stable@vger.kernel.org,
	Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Zhangfei Gao <zhangfei.gao@linaro.org>,
	Guoxiong Yan <yanguoxiong@huawei.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] media: rc: ir-hix5hd2: set up device data before requesting the IRQ
Date: Sun, 25 Oct 2026 10:27:02 +0800
Message-ID: <20261025022706.1905466-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
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

The hix5hd2 IR interrupt handler passes priv->rdev to the
ir_raw_event_*() helpers, which dereference it immediately, and
devm_request_irq() unmasks the line as soon as it is called, so the
handler can run before probe() returns.

hix5hd2_ir_probe() has requested the IRQ before assigning priv->rdev
since the driver was introduced, so an interrupt already pending when
the line is requested, e.g. decoded symbols left by the boot firmware,
would pass a NULL rc_dev to ir_raw_event_store().

On Hi3716CV200 the handler ran 8 ms after the device was bound and took
a NULL-pointer fault in ir_raw_event_store() from interrupt context; on
Hi3798MV200H the same fault killed every boot 25 s into startup.

Request the IRQ only after the device data is set up.

The same ordering was fixed for talitos in commit 666d66df2525 ("crypto:
talitos - init tasklets before requesting IRQs") and for bgmac in commit
ac1f6e58cb77 ("net: bgmac: enable interrupts only after NAPI is ready").

Fixes: a84fcdaa9058 ("[media] rc: Introduce hix5hd2 IR transmitter driver")
Cc: stable@vger.kernel.org
Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/media/rc/ir-hix5hd2.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/rc/ir-hix5hd2.c b/drivers/media/rc/ir-hix5hd2.c
index 1b061e4a3dcf..c3b984a0c2e4 100644
--- a/drivers/media/rc/ir-hix5hd2.c
+++ b/drivers/media/rc/ir-hix5hd2.c
@@ -316,6 +316,10 @@ static int hix5hd2_ir_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto clkerr;
 
+	priv->rdev = rdev;
+	priv->dev = dev;
+	platform_set_drvdata(pdev, priv);
+
 	if (devm_request_irq(dev, priv->irq, hix5hd2_ir_rx_interrupt,
 			     0, pdev->name, priv) < 0) {
 		dev_err(dev, "IRQ %d register failed\n", priv->irq);
@@ -323,10 +327,6 @@ static int hix5hd2_ir_probe(struct platform_device *pdev)
 		goto regerr;
 	}
 
-	priv->rdev = rdev;
-	priv->dev = dev;
-	platform_set_drvdata(pdev, priv);
-
 	return ret;
 
 regerr:
-- 
2.53.0

