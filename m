Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792510891;
	b=NJl/wBgu6J9CxiWGxQNfP2/P2ApkbNr6BE+8Puivms5gx3ZtGL8rzkAd/FX6EIJUlKis
	 cqKR4xiNw1t5ujwWG1feuO2VKIBlXV6r0+TNpCKF7Y/qqNeCJTw6/fRa7gl4/O0tqAv7Q
	 fSKSoGANzo3Gdw6+cQd4qWzK6/UJt5x0ab1KmbVdGfcOwAzcTp9rkVKL1Op7hH7Ra6tjj
	 TrWIQOmkrTG+yqfGFDCAIbHhpeyDaJkG/dEeKyqutOlQ0t0Xi2BvjjqwrtDJtv0XqCTjL
	 0LhlIjJzeVZEjWGz6vz3FGiY78a+XcVrNEnn6IjwhPLLz78AUffRRBAD/QSw6EiyLXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792510891;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=1cAWdrIjWIMcTgBz2maEyJC2O8dthVuXFce2HuKPJcg=;
	b=QqE8MW0/YJwqAEnZofSEOko41QU2RRwKZ84aZAyd/ZN1jrrujrmmSawh7pSye/Y2NUzI
	 xg6DYa8jcnoWC7uyvFWnoR3I2OyPpfeaEsoE4i6+o7Fk/torVY6BV6BN/0O82aT6kwQfl
	 Lpf+Q73wtuBkHz/i+wCxjl72GY4fITjkIGtSn4JRgLP2erkWFvP0FtX4kAuD0NTXb1BFG
	 UBO07hm94tdovKi+weaBeYKUlW7JTtnljcCAWycXAK+XIW9PGS7vmNioZmEYPocDqulYL
	 YADdMGsk0SLCBMhOSAK6rmwu0mxIzvUQAvit9sJdCzPUJmOKN/z6ikTLZ2nQ1xPFX3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IRZi3v92;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755AE60A263A
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 15:41:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 755AE60A263A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IRZi3v92
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49d05d51553so23788075e9.2
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 08:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792510890; x=1793115690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1cAWdrIjWIMcTgBz2maEyJC2O8dthVuXFce2HuKPJcg=;
        b=IRZi3v92SLh3anZ/+FWsWLLdFcePDMCweX8DwRWH2iZnmCqhAXz/Nk37dhAVFpJycl
         h26hSpdt49BmA92NT+ZTLboHYGTdCc41Hq8++KyVooTVettCEr+5p0S2tWlAd+PXRvLt
         cE5lGwLAULKAl7Iwi6dOapz8bflOPjuWLxNU34Ghpv7CzAtugjaU+/UMLeu0Hfz4IWCA
         xmYU6vI5FEFNxDYZWTTFlFVKW8xEK0iP4EZtTHNiEeeeJqdbIwSzEaA5PASG+wEvN2ke
         4aZMi9HqliaeEtNFlUg4KzGPzF8L+kfhWZt9Lw7zTtoEr50Gt76z3hvQiFsJub3SW587
         hMLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792510890; x=1793115690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1cAWdrIjWIMcTgBz2maEyJC2O8dthVuXFce2HuKPJcg=;
        b=pZ7uBmjHlpg2z5mEzDj7rn9EGOuhGbQ/K/b9OqzsEvjNjIOznR9Qb0dknO07F/3yYI
         uAfOS1I1e66MLS3du7jaaMnXv46ypkyj2HPtdffNYbMoYz6GvIkFdMc/e3i+e7FriQnf
         4suFsAqJoTzNsGL5IIm3jjn/r49n2O5qGAkNVdBaC9dCSxzemJ/JRx83nc4NQTlHcmRT
         gUdJXI1tDuvzhHlZECMBUZle+sAIedsdckRNGRokBlO6FrqD2K1fz1WV4szzJ96FwEQb
         q/+wYz5CFGBZcCibJi7txDGwxd5er49SgIzhl8SL+A9FNt0IRlUV4tOnDx68jiYBrNiU
         XChw==
X-Forwarded-Encrypted: i=1; AKwUvBwoQhh9dFEPH8zuScWvpFHY648sMF7kS4h1QA4Bk/3PQNcrKxfbaM8mzV7RftTFds25xOha5Bk=@vger.kernel.org
X-Gm-Message-State: AFq9FYL7K7MKH0M2/ox8n30zCp0G0UfVkY3EWZi2N2YXkkTNbNTlQxE6
	7JGaTPW6LCtuUBsQgKfY7GNyzW7ZOCxShQ6EZMzHBl8sqOpsO/FgnAk=
X-Gm-Gg: AYBFou3zGVcYFZn/jv69mFAj5c/IkERWdZ2/sJdzf8gsYe3y2yutqH2lBw0bfR/c4el
	GKFdOi/rjOSTpvjthTuReABYi3qonJI3HtqdPDFRIMTMRcuZlHSqi4tk7m23AVY81jXbicadM+Q
	K8OgIZp0iyINL3mbGcaRa81HEwozKO8s2Y3o4HIGOSG4BfF1z2pVPFH/mSWd7FApoycJeKEAp14
	tXEUYs6LV2WhTPM2dWIqg+IOQx2kXYxN+qbPrM/zLUrwUyqL1La36/WH8ioAEyaBDp5nIVS34rw
	Z8f9kjPnanFSL8+4gbC3DZHwET2EmeIcUeZz0ssyAtUu68rMuUIq4E4rhH/T7k8oBMHxbkq7NoT
	OrDvloMA7FR7xaawZfQQ5bAPi6LPFyPb7mvsbW9ZRX6KQPUg4Ch47W86fQKvl/eiDWXGmQNv6tq
	YDzLRRLqXGYCOnx+YCITRIpJk6s4A3hdV4wtu0LO3oFJHB3nsVhw==
X-Received: by 2002:a05:600c:4e8a:b0:4a1:cedc:ab51 with SMTP id 5b1f17b1804b1-4a1d76315d7mr258936185e9.35.1792510889761;
        Tue, 20 Oct 2026 08:41:29 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1cca31234sm256606155e9.4.2026.10.20.08.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 08:41:28 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Chanwoo Choi <cw00.choi@samsung.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>
Cc: Kyungmin Park <kyungmin.park@samsung.com>,
	Seung-Woo Kim <sw0312.kim@samsung.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH 5/5] extcon: sm5502: cancel wq_detcable on driver unbind
Date: Tue, 20 Oct 2026 15:41:19 +0000
Message-ID: <20261020154119.2568395-6-tristmd@gmail.com>
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

sm5502_muic_i2c_probe() schedules a delayed work (wq_detcable) for
post-boot cable state detection but the driver has no .remove callback
and never cancels it.  If the device is unbound before the work fires,
the callback dereferences freed memory.

Use devm_delayed_work_autocancel() so the work is automatically
cancelled when the device is removed.

Fixes: e1954452f500 ("extcon: sm5502: Detect cable state after completing platform booting")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/extcon/extcon-sm5502.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/extcon/extcon-sm5502.c b/drivers/extcon/extcon-sm5502.c
index c8c4b9ef72aa1..5257cb3ca2266 100644
--- a/drivers/extcon/extcon-sm5502.c
+++ b/drivers/extcon/extcon-sm5502.c
@@ -6,6 +6,7 @@
  * Author: Chanwoo Choi <cw00.choi@samsung.com>
  */
 
+#include <linux/devm-helpers.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
@@ -763,7 +764,10 @@ static int sm5022_muic_i2c_probe(struct i2c_client *i2c)
 	 * After completing the booting of platform, the extcon provider
 	 * driver should notify cable state to upper layer.
 	 */
-	INIT_DELAYED_WORK(&info->wq_detcable, sm5502_muic_detect_cable_wq);
+	ret = devm_delayed_work_autocancel(&i2c->dev, &info->wq_detcable,
+					   sm5502_muic_detect_cable_wq);
+	if (ret)
+		return ret;
 	queue_delayed_work(system_power_efficient_wq, &info->wq_detcable,
 			msecs_to_jiffies(DELAY_MS_DEFAULT));
 
-- 
2.47.3

