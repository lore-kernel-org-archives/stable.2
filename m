Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794467038;
	b=joarKfcGCH6bq2NbtULqclDNxAbAW3uXdrWyz7a3pF1FmoaDGKc+neLTUu9tcgfvIAEy
	 VfDbpXqF8Zmv9HP4rWmZaw7gFG0heN4+B+szT2+5YdA7y2EMyMTVxTem0puXyhr4X0msk
	 GWHaTcujvQydORPkfvayfkig6Ncplth8OS9Sd0h371ULpUQOZxHIZWqzbbThzMSBMUpRR
	 d9a0W4nzuD4UuKuYJbG5GehIKUk4jp10Fy9/JXwQT+vyHjAhZjHlJS20UILl5xL9a+Y5W
	 XnOR+nZ0cBgR//LfUFLkFT34u7Hw4ipFgjEoDfezcs7K25WcubR4/OWJy8ACo6nV2jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794467038;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cvZvlspgGpI+sbuDThI8s9gyv6s5j58IUQpjPB+IafU=;
	b=tMEowV+y85BJFy3JbVx460xs1Z5dufR0OFgf9w0aexgp6axBJ//xfLu9DwYCqYRYXs+D
	 SYcb/HwesKpmrUblx23Cf2WWtG84LGTKd1c3WPiFFieEk4r7BIaS/TPOuzWAdMfq1JWmh
	 wxH3ZghijvQ/IsFb7SLpoEPV/ewiYeQXjBgSgY3vQ5TE6EM1wAXvcGyWZH3M6GoDm7va2
	 55rTT6yjtgpIOQTTolmWMcwS/zKak42zlhKIGCz6Ikk2ZBV6ukFWB3noopHIWvulXZlTw
	 jDes4K05I6EWVA5poTm63DGJUgad9pGk60vP2VNn234PGPADiEYO7OCyeM8nHvRwa8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0qxLjXek;
	arc=none smtp.remote-ip=209.85.222.171
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899F1606A332
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 07:03:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 899F1606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0qxLjXek
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-93f30660e69so329161185a.0
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 23:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794467037; x=1795071837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cvZvlspgGpI+sbuDThI8s9gyv6s5j58IUQpjPB+IafU=;
        b=0qxLjXekTfmT5hXG9x3NrRSfhEuel/pLbNlWQvJv248mLJCEXDA1/maWn/8W3EEUSV
         jFPR1SHN0mrVZk6wd5aQ7QElQnxdZ88G2kvmKe6vsiyYC7wN39ULciRHEr2MOJ6FY0eL
         dsHZzVqlcS91yb/vBn+e1X+8I4LiKr9KT2awMSi6enbXhucN5qjKdJk+OOnAMquqMHcD
         urTZKauyMLz9v8s7vTxe3cdB8yy/IsijgcRtj8jIK0oPJ9yL3pFDsX+W0H+AokKf/15y
         us8t98GVk3Xx8MORFn2MUUnnB2DNuDKhuZHHUibPkI2kolhyAZ+28YB+BGa2o03e6Ihz
         392Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794467037; x=1795071837;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cvZvlspgGpI+sbuDThI8s9gyv6s5j58IUQpjPB+IafU=;
        b=tEZqqq+ZfGfR57VSvVkl8BpQ9Z1gS4WfkMKBIHQS9n9fx4KezDr6MlEKZWvFCLUsHt
         dP/tdWEAl7voPETtcPWhBOf90UzzBc5QLAm+2yFPje+q9s6W3FqCxJau5C3abe7Qn+m6
         CGrIvwQrmNeUx7PfyQ8AOmtYa6JBSdpzSP+umTfeWI+Hk6Vb+zhMRU2lgyrfndhpPFRN
         NkF70S6PpCA6uxSb4cS2s57UokmvvoK4+HkHKIBInmXd+GmEIZXIMeuPXXzjC7dxeKWL
         UyZaFpA9qcRUK6d51IbtvYMa/ha5Er3z41qdfRnvBQLnvzCmCtsO/BobLA88/MQ6a2oC
         CAtg==
X-Forwarded-Encrypted: i=1; AL+hErEuRP8549iQVjSupyb24oX4O8axXDmv/7RBnujJtJgRdTrJAwUQ7eOA+KrK4veP8jjlT6SbgP4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/dIpBVIC8paWi4Wo3WBlbKTmBNzLtG7URUHn1MrhWeDIZZKi7c
	ZdQsfxcarvMRCQfRJR4hHaLNgxtoJunE+b6jB4/cGinDyjnEU0e7Ev4=
X-Gm-Gg: AYBFou1j+MstmZCXFt36pE8RpfMBOjNntqgM/ZDEoByc2dbUHv+iTi+DDzeZMytOYCH
	Xr+i8ekiSuufx7Zvppvd3CzcuMDomwbDxVa+x+xlgAxH7k9btbDS0npfrhboyVm/79AhHOczm7N
	emyga1FYs8Ei4V3HVgaVTagD/tLvEvb9v5lk6suldEEECv6alTRzcCnBbqFvUKepKN6r5RZ4QE/
	e4fqnUENTI2k4VOUbKyADZlwLb00HFVMFc7J3iPzAbychHd4ldA93PURuTxF/2JM19Wreb2/Hp8
	brJvy8IUYoaAjhLgydcxujvQFoS/VjgnwJMrMmDCxjU7TWF1CV7hD5hzYVOiEzyA2Gsy/liRm6s
	N7XPqSsw43dupy63w8njRaDmPsZKX1fdD+qW4UbtgOtDMrutqCXEPmKUGKnYON3G7pMRNrnV7yW
	VxOGWN134AiEIPW2nmLBT0inzsLydgHX0WPBowdUWwQ3YwJqsCbpn9vuVUX/d6jMwYnFXNX4Szy
	gnAkFwiJ4CS2iWTicW4L9Y1LXjrWSOd264qxKBeG3P2s01bVoBVBRyCP1Q9h3AJ9+3k/fJINE/P
	/i+lLrILi4QX0iR7+Y2vSNiB0O6420mf2G+hKHbvmG6G1xRRWjwMHZkZSBnbPXouxDnXjhUcSOF
	j1HKaaPjjrdDPpb8Vnkz5N35nMC8TS/o7QKEY1nn9Y/Ci9iWzFKAIMzHHHc044EJef8+pgjudxn
	cpmJk89fjdgsxT+79gjuv4t7og0sd/eB/j
X-Received: by 2002:a05:620a:600c:b0:93e:d364:c9fc with SMTP id af79cd13be357-947afb90a8dmr714407485a.5.1794467037587;
        Wed, 11 Nov 2026 23:03:57 -0800 (PST)
Received: from localhost.localdomain (h16.44.55.139.dynamic.ip.windstream.net. [139.55.44.16])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e619affsm660698385a.4.2026.11.11.23.03.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 23:03:56 -0800 (PST)
From: Myeonghun Pak <mhun512@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] extcon: ptn5150: request the IRQ after the resources its work uses
Date: Thu, 12 Nov 2026 02:03:55 -0500
Message-ID: <20261112070355.38837-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
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

The IRQ is requested before the work cleanup action is registered.
On unbind, devres cancels irq_work and releases its switches before
freeing the IRQ, allowing an interrupt to queue work against released
resources. Earlier probe failures can leave the work uncancelled.

Request the IRQ after registering the cleanup action so devres frees
it before cancelling the work and releasing its resources. Keep
ptn5150_init_dev_type() after the IRQ request: clearing pending status
before installing the falling-edge handler can lose an interrupt.

Found by a static analysis tool under development.

Compile-tested with W=1 for arm64 and x86_64.
Not tested on hardware.

Fixes: 782cd939cbe0 ("extcon: ptn5150: Add queue work sync before driver release")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---

 drivers/extcon/extcon-ptn5150.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/extcon/extcon-ptn5150.c b/drivers/extcon/extcon-ptn5150.c
index 0b96b58b4212..6ee4edd7adbd 100644
--- a/drivers/extcon/extcon-ptn5150.c
+++ b/drivers/extcon/extcon-ptn5150.c
@@ -307,16 +307,6 @@ static int ptn5150_i2c_probe(struct i2c_client *i2c)
 		}
 	}
 
-	ret = devm_request_threaded_irq(dev, info->irq, NULL,
-					ptn5150_irq_handler,
-					IRQF_TRIGGER_FALLING |
-					IRQF_ONESHOT,
-					i2c->name, info);
-	if (ret < 0) {
-		dev_err(dev, "failed to request handler for INTB IRQ\n");
-		return ret;
-	}
-
 	/* Allocate extcon device */
 	info->edev = devm_extcon_dev_allocate(info->dev, ptn5150_extcon_cable);
 	if (IS_ERR(info->edev)) {
@@ -338,11 +328,6 @@ static int ptn5150_i2c_probe(struct i2c_client *i2c)
 	extcon_set_property_capability(info->edev, EXTCON_USB_HOST,
 					EXTCON_PROP_USB_TYPEC_POLARITY);
 
-	/* Initialize PTN5150 device and print vendor id and version id */
-	ret = ptn5150_init_dev_type(info);
-	if (ret)
-		return -EINVAL;
-
 	connector = device_get_named_child_node(dev, "connector");
 	if (connector) {
 		info->orient_sw = fwnode_typec_switch_get(connector);
@@ -362,6 +347,21 @@ static int ptn5150_i2c_probe(struct i2c_client *i2c)
 	if (ret)
 		return ret;
 
+	ret = devm_request_threaded_irq(dev, info->irq, NULL,
+					ptn5150_irq_handler,
+					IRQF_TRIGGER_FALLING |
+					IRQF_ONESHOT,
+					i2c->name, info);
+	if (ret < 0) {
+		dev_err(dev, "failed to request handler for INTB IRQ\n");
+		return ret;
+	}
+
+	/* Initialize PTN5150 device and print vendor id and version id */
+	ret = ptn5150_init_dev_type(info);
+	if (ret)
+		return -EINVAL;
+
 	/*
 	 * Update current extcon state if for example OTG connection was there
 	 * before the probe

base-commit: 630059a5a632377b9b7b487baccde92b7ae1dd47
-- 
2.43.0

