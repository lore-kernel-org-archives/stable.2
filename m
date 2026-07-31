Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DAB3B7742;
	Fri, 31 Jul 2026 09:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785491124; cv=none; b=YaDueEhxfjkRgbI/49h5Oz/ALUwCdgWYNl9YIzathXjgb3Lk+/J+74OyitoAQEODq3etAYGK6eCBs5YMwd6FBkM1nZ4ZYL39wv/4C4P2FeRmhO0Q5PwSv0PyWe9LWoqwGfkX6CcpT+O+scBSg53nKKObeS3wrYWXejnbdGNJYZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785491124; c=relaxed/simple;
	bh=JI3hwQZG9O+wVX41sbs8+Np1ov5ehOcvZtKBDgg+Tow=;
	h=Message-ID:From:Date:Subject:MIME-Version:Content-Type:References:
	 In-Reply-To:To:Cc; b=ZDt/BTjQvmeYk4KHQqPV0vJiY4VPNVpa+MBWTTTijDwMCur6++OIOqCQZ4bYGyuR+8YxGVWq/9MNWMlXjw3YcIIpsTRITMDKx+bm3FvW5vlTOGoFTKPTQvn/7OcvEXy3mFgKDq/JXNoSwaX5y62XknImlfSBKPICCHA/bme/oBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=fb+mWE2n; arc=none smtp.client-ip=43.163.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="fb+mWE2n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1785491111; bh=ISmSHUnxFfQoUpZFO1QyXg4OFEW5rbqFD96jqZMmjj0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=fb+mWE2nw+Z9jYLI0z3doQ3+l03FiNFInuPVfIGokwyL+HN9FeEuAy08X5YHQ24ac
	 mooQJJ8Vh4YZv9B3Lo46A1bfo4YpL7RwpEgNyWuBcrypQ5ij6q0jC09X6alMn+QAbe
	 cI82BDxLqRnHtloP31jaMPznh0w2bSpGnuEs1P6M=
Received: from ubuntu2204.localdomain ([2409:8d20:22b:54c:9e54:40ff:fe02:3f0f])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id B4623E87; Fri, 31 Jul 2026 17:45:06 +0800
X-QQ-mid: xmsmtpt1785491108tdqxs9959
Message-ID: <tencent_C825C17D442F801351CE2FBC4984064B4605@qq.com>
X-QQ-XMAILINFO: NX3IH4pixvQAx2COF1gCU6EIJLauzWo3Kt7+E3SrVC7av0c18336ZgsQ8B9RIJ
	 Rboj+DKm5ui5eqI9NC1iBawuWNKlI87ky/4DOjmNeq/P3NAWBTxOlXyfiy7ua0MQ6JAjbNo4/bJV
	 TP93Y4IwWOg/fO9VUSLFgFaautwsCcawst1iduEXUXyXnkY8Vj0yvD9Un7jeye8L/3qVvdI7aneL
	 BJgDipkTp/4qmB1ykxK/faNuYYzfdzGXdsb9UJxL4xaAKMGtmAHLsbIa5Fbv3WhTAJgXgeSMUCgc
	 HDf6Qoe/SO5xB9KoUNGJ8s0+C8cV4B4lRYLikS1AbYrn+cs5LLNu12MiRtVy2PVuyD7w5uYWduTP
	 p+DEqEbwORY70LF0BBqi5PP85VivI6e9WUQM6A6jto6+c63JiyOqgPkCwiv/k8v70Tr/pmMddpSf
	 RXPNAhc1osYaNvDkw/uq33f3GZTY5o7QFfuAjK0RwnKYYdT/2kCHtIrt4t9qW8UVG8YoJ3F3TEli
	 ktXmYaMavtEkHdM4kCV/j+eJWBj3FQSIwf4QkL3ZIOB3mh0nMaTvkwBmqKwyhRjnAo8fELuSeVgf
	 NzUXNyTU3AtTn/OYuO8JckJ6hHwQxUKrlXqip2GE3mFNenHU22+TZEbfSfCVDEMcysZVDv3knpwr
	 TIYIjMiob+YZxAJpAxLoakqtcPNl0CetHiaQrEaCOF07jm2PTFUrgDOrlVv3LIJLNIdOwPbfqLmE
	 p5Cbii0gQz/HnvoE2GxlN1zsHYTuYzk/Tq7aCoX1yQPFUt4rn5luL5uPiJY4+W6yv9FrrBwQTf3l
	 5K2tI9erjUobmZQ3isLqcnlyCnSJ4PgCYE+derN+1mMebZI06gdmVvwTce+bXYVEDhv+tbWb8lIJ
	 yt7cR+opgMAB8nCoDd89x9gKGRNkeaUQ0X3d3Su5Pbt03pi6sia9LrG2qv10TI+kU9ZWaCNaGbCN
	 0cZzFtkimoJkLWWoqN9c88j7Xv5x8kzdMEymnIswF0fdNq1NXmaGBjiW4B7E7rFm6vnh1UlQCKaI
	 bweNBP2S3Isa/GC2CZ/LR414xQV4mWA/cZJl5Cs9Kgnu88MbdHUIlTvMeCHrEMyxNAlRhLM61t6P
	 qNqNFu
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: Cunhao Lu <1579567540@qq.com>
Date: Fri, 31 Jul 2026 17:45:01 +0800
Subject: [PATCH v3 2/3] can: skb: make CAN skb allocation failure paths
 IRQ-safe
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-OQ-MSGID: <20260731-master-v3-2-b56cd1e8d675@qq.com>
References: <20260731-master-v3-0-b56cd1e8d675@qq.com>
In-Reply-To: <20260731-master-v3-0-b56cd1e8d675@qq.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Cunhao Lu <1579567540@qq.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2

The CAN skb allocation helpers are used from hardware interrupt receive
handlers. If can_skb_ext_add() fails, they release the newly allocated skb
with kfree_skb(), which is not safe in hardware interrupt context.

Use dev_kfree_skb_any() for the allocation failure paths in
alloc_can_skb(), alloc_canfd_skb(), and alloc_canxl_skb().

Fixes: 96ea3a1e2d31 ("can: add CAN skb extension infrastructure")
Cc: stable@vger.kernel.org
Signed-off-by: Cunhao Lu <1579567540@qq.com>
---
 drivers/net/can/dev/skb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
index d7b5a5d17ff2..d34d3e7d4c9f 100644
--- a/drivers/net/can/dev/skb.c
+++ b/drivers/net/can/dev/skb.c
@@ -223,7 +223,7 @@ struct sk_buff *alloc_can_skb(struct net_device *dev, struct can_frame **cf)
 
 	csx = can_skb_ext_add(skb);
 	if (!csx) {
-		kfree_skb(skb);
+		dev_kfree_skb_any(skb);
 		goto out_error_cc;
 	}
 
@@ -254,7 +254,7 @@ struct sk_buff *alloc_canfd_skb(struct net_device *dev,
 
 	csx = can_skb_ext_add(skb);
 	if (!csx) {
-		kfree_skb(skb);
+		dev_kfree_skb_any(skb);
 		goto out_error_fd;
 	}
 
@@ -292,7 +292,7 @@ struct sk_buff *alloc_canxl_skb(struct net_device *dev,
 
 	csx = can_skb_ext_add(skb);
 	if (!csx) {
-		kfree_skb(skb);
+		dev_kfree_skb_any(skb);
 		goto out_error_xl;
 	}
 

-- 
2.34.1

