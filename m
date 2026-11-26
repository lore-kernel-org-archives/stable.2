Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795652007;
	b=o3mxafRoRGELKKYpc5yTQdBmbLZJGBguXyupS+pVa7rLF4qEKjRsYDVEQ0/C5jUNYv48
	 yjl8KLk+PgRb+nTaLcYax/IAGI8CuRC+SwSzmTc22AvjDNf8GDjDcKDA7u4YmjdjpG9QI
	 jZap0Oo/HwIoI7pbTwuXGiu153z2VAiYCi36kemuzUFWYd/YiSu6K3M/BSqHa9OpiMlYv
	 JdBT+mZpZ8+zQsoza6Zmo9Vi1WNOcGRL4jPkTdmhURG8y9KEOUEuzhPDm0sYv8jn/bYoT
	 buro5UwUnB7sDyriUfy70fa7tmhDQczsUfE1E7p58iCntRmBph2ED6bIKY7sLi4IUDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795652007;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pXPp/90lX1YkR24tu0x78bsF0BUZZN7MTybZBzP2dMs=;
	b=09hoAgXBcOI2BMr1icBAIS/4E2IenlrgV4hx7dh6YslwzVFBe6UfvuBTZgwEXX2VdtA4
	 SVQi6cdp8t1lgdoDwTD3P0i/DVuaI7ozwjlsURfkSoB8iHz9TMXmFGhL7kP/W49Tb03AO
	 +7v6FBYTyoJ5UzAqqB8bhcCVYB1M1r8KsxvNfTE2in3xYLHPM8Es6rIe3VDT60VTYGTZf
	 AxLH6MokuE5AZyHx8WFUtDNVCSVx9hF1eUI9h3R/d8nDXW2WFWJQOd3h0DSKNfMTu1a8t
	 s6RaJifzx3y3JTao6wOogx8bV4TAVseY7VC/JJf5J9xnJ/+8flOPY/bkFB5P046Fi+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dkT+0a29;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C2E606A321
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 00:13:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2C2E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dkT+0a29
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3ada4c06b7bso3471452a91.2
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 16:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795652006; x=1796256806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pXPp/90lX1YkR24tu0x78bsF0BUZZN7MTybZBzP2dMs=;
        b=dkT+0a29FJ4KfjvyHLjIEAXn6G8GuDTS0bICdbFQKUJoozqkasEpK8Y2aPFOU7Zpvh
         mU4mqgChrO/meJvCvYcGqClVGpB5vNis42ubJwfYRWzXEjRkm4YQzgSQPCjmPAvJTuzv
         uQ60CnBm+jlSIT7LVAH/7bH8Qz3mQLRbUt1Ij/hc1anuF/Hqnuu34gt8b8PfAoGuu9VX
         JOxaLBHoI+ZCVMS2O0VbXOTYhY0hn2CoUcWXrUYg7OrcgeMqhR4a/xmd3JxzpqZ5PAAE
         Kfr0YFrGpVMtJYxb/zGvzgKsOLnAwn0bk0rPs8ugonHMHtpdmGUdUTHQIT6cfv6zHuPq
         dyZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795652006; x=1796256806;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pXPp/90lX1YkR24tu0x78bsF0BUZZN7MTybZBzP2dMs=;
        b=JCH9gfz4LE3LnlyqDUyqkQi39mlipM42oHCPHPLGSfVzOUnXb28nz6vuggngp5YFmr
         EVO3ejakJWdlwtwSXp+sYCunO8fOgddpl5pnt6a7aZT6nx/QlbWX+RKd/x9GqEHwwQ/O
         c1meCM3fD+cH22OFiPlQXTLvNyb6wuOwJLvBn7ITiz44WkPIzwFUhsXf/5erOqvK4J0q
         7R2U1d0Lu8RvZnYkBSTyWDYE8eAYzlZsyqf/GbP0fZldX0R2q+0MiRwGDL+BBHw/IMWu
         8BtnXKEwivrsIZ2g1rT82QIiHGGVyXcdbTcRC4wXwXSJ2F2s2LySiDXJC0bKZXbUbTVs
         dURg==
X-Forwarded-Encrypted: i=1; AL+hErHhUXMZ/CaVmJhHMeUbqX5ddpwcQbBYlHhOWgRDP+rIImovyDEyZqtc7Toty18jKo/R1z9jL+U=@vger.kernel.org
X-Gm-Message-State: APuU4Z/3oJVF1VXYJt81DoYcPf6fr305Les71L1guhVzVrTrBDghjBjG
	MdHVs3qZOlkqFopXbYH8seji2JJnQ/5/iyKBid1bh+o56PqaSruepPwO
X-Gm-Gg: AZFdTZdiR8h2balA1r0V0eG9xi/jp2kwORCjE1CWQle3/Z5UjzR5eKMtWDWFyjZFLgX
	bcGPVAkXYPnzJs9icTj57LxzXefnsLT6kCQCjp8AMv5jO0eTQP5xzBKnpaPDMJlOBTXETr3rJ4K
	L1HN8VL29iOLfPFfVjIdg7llBjeorNaUzUJU6vrMZt8Q6Y7ltZkQhhhQy3PrcfKJjVT+94ZsipM
	N2yH46JdHWUp5x2h4GICXkNs5+kLMhyU+l8oF0P91HixwD/k1BQ02eioEuzTGrQWAxH5aN6La7D
	MfVpuUEeQj5tzqTO5MniDEeIIQc9tSQs2pwloTT+zjbjl2I8kUUMiHKNtyVcb5i8zQCJwu1Hqpo
	CCEGapWJ40I7abt2LoKEJ8p7gb0dQDYb5RfH8bvVltNSLwzDxOFScD7zK9OYAHE0lMm7v1zbMzo
	ZqSmR2htRD1L0ZZBc+5lk7dL1mCCY0s4p5m5khPv1UHHQNt4gtaAn/dMMfF5Pxe6aPPDGqd4agI
	S5N67mwZODxVAojN+bSaW4PWgA2Tn9bocZ0vYGODoMuKdd9WunZ/VhR1o0r7bg40E7tT8bkhgWZ
	V8CumgVHam9Wc0lCELA5Mm4buxK6GEO0DcOvlbrJOv4t+KcfA7fL7HvTgkkO1RtzZ8xD4M2l81I
	HneV+wjgcO+cBn5CX7H3vMQoUHQ7Fp8GIW0KrQAGW6avujW5PUhzIlSDPeJMp/ImyEYE43QFET9
	AUVg==
X-Received: by 2002:a17:90b:4a48:b0:3b3:c675:d923 with SMTP id 98e67ed59e1d1-3b41c908109mr17235877a91.28.1795652005963;
        Wed, 25 Nov 2026 16:13:25 -0800 (PST)
Received: from ryzen.lan ([2601:644:8000:37f::e34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405d135e9sm32411110a91.4.2026.11.25.16.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 16:13:24 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: linux-gpio@vger.kernel.org
Cc: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Alexandre Courbot <acourbot@nvidia.com>,
	stable@vger.kernel.org
Subject: [PATCH v5] gpio: mvebu: fix Armada XP per-CPU mask register save/restore
Date: Wed, 25 Nov 2026 16:13:23 -0800
Message-ID: <20261126001323.583722-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.56.1
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

The Armada XP variant keeps the per-CPU edge/level mask registers in a
second I/O window (percpu_regs) rather than in the main GPIO window.
The suspend and resume paths however read and wrote them through
mvchip->regs with the per-CPU offsets, which hits unrelated registers
in the main window (including the global GPIO_EDGE_MASK /
GPIO_LEVEL_MASK registers) instead. The per-CPU mask state was
therefore never saved or restored, so interrupts the kernel had
unmasked could stay masked after resume, while the main window was
written with per-CPU mask values.

Use mvchip->percpu_regs for the Armada XP per-CPU mask registers in
both the suspend save and the resume restore paths, matching the
mask/unmask handlers and the probe-time masking.

Fixes: b5b7b487431b ("gpio: mvebu: add suspend/resume support")
Cc: stable@vger.kernel.org
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v5: rebase onto gpio/for-next (on top of 02af7eac17bc "gpio: mvebu: keep
     resume masks within the irqchip cache"); reword the impact paragraph
     since that commit already confines the resume masks to the irqchip cache
 v4: rebase again
 v3: rebase again
 v2: rebase
 drivers/gpio/gpio-mvebu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index 46604093a01e..a9e6e7a63495 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -1031,10 +1031,10 @@ static int mvebu_gpio_suspend(struct platform_device *pdev, pm_message_t state)
 		break;
 	case MVEBU_GPIO_SOC_VARIANT_ARMADAXP:
 		for (i = 0; i < 4; i++) {
-			regmap_read(mvchip->regs,
+			regmap_read(mvchip->percpu_regs,
 				    GPIO_EDGE_MASK_ARMADAXP_OFF(i),
 				    &mvchip->edge_mask_regs[i]);
-			regmap_read(mvchip->regs,
+			regmap_read(mvchip->percpu_regs,
 				    GPIO_LEVEL_MASK_ARMADAXP_OFF(i),
 				    &mvchip->level_mask_regs[i]);
 		}
@@ -1104,10 +1104,10 @@ static int mvebu_gpio_resume(struct platform_device *pdev)
 		break;
 	case MVEBU_GPIO_SOC_VARIANT_ARMADAXP:
 		for (i = 0; i < 4; i++) {
-			regmap_write(mvchip->regs,
+			regmap_write(mvchip->percpu_regs,
 				     GPIO_EDGE_MASK_ARMADAXP_OFF(i),
 				     mvchip->edge_mask_regs[i] & edge_cache);
-			regmap_write(mvchip->regs,
+			regmap_write(mvchip->percpu_regs,
 				     GPIO_LEVEL_MASK_ARMADAXP_OFF(i),
 				     mvchip->level_mask_regs[i] & level_cache);
 		}
-- 
2.56.1

