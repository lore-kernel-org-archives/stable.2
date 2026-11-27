Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795788428;
	b=Q84KLzh+e3sQK8U1cbnk0bCKs+TO0y0LSTmyJAmfoiWsM17OK+FuyJOhjtdpgz7Eifzk
	 9bHxzs1rlsBMUvg5uatGhuF6pSy0ZHZQ45zo2d5WFmVvabJpIRHc2IvKYGwquA6GPGWg/
	 0kVWzTbaZt/lVuWBXr5t73GXI8ufebaYQg+qNIuwojLOBN6RZjk8k5++Zi7hFg5Zveotq
	 D07ZPR30MIcBAuIURbrwaiEgkEscuQXCjccKNegb5c9t7yNrhwgLSaARx1mAeM2ob2wD8
	 61Dj27FwvOPm5h96QIBoQlKh1T53qRCbN3ZgBIsyaF58dVGImU0GR4O+EzgfAVvAN5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795788428;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=prqg+9+C9OZ8PzG7e/SKDZecuZaCZLp73YjumQbdiU0=;
	b=5b3L8M4bkVvt44B7fBjfUHoIzAD5K+/PR6KetyA/4hHd32PrUErzsVnfoVtB/cI2kF7u
	 yhM0cbrU92tma3q2gLqsjo2mdDThPYqldtEnfuiJekDceFzVeK2CoO7O1qmuerq1Dk+RL
	 EpLo9EKcjCv4Wmb4f6hVhzCx7Pl2U/vyjNnkMSDYOWyvLyJX06VCqz1qN8H4wSfN3gf7I
	 dBYV9Ngi/H2C3e3MSa/IfOsWpOHHfQTGPG4djd4TP7L5dw5fb9BhvRkN8Tyx+m9dcZweq
	 h58egbO+vW0gDtqY9fmh9qafDJ1551HrLl6LV75JmVKkrOfzdCuP6NT9VS38UIFmobg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WluSVrhM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E57606A31F;
	Fri, 27 Nov 2026 14:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WluSVrhM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90D261F00898;
	Fri, 27 Nov 2026 14:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795788428;
	bh=prqg+9+C9OZ8PzG7e/SKDZecuZaCZLp73YjumQbdiU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WluSVrhM26loZJ82d5WTlntzlSI7z764lstfJsoSo+F67X0TWsat7WFCo2lHSal6q
	 CXZX1TEeoiyJhhS/meskFdEfs72gcw5+UgBEbSaH9phrDN6lcwz7GI4M83T0DtGPyy
	 nMW4BqBFn03tFHvAv74vJN9fiefL+VxiX2+nPlyrazIgTfM/0FnCXghN1mV+agl7Hc
	 9adM7/o3QM+HEtZQtsYKIpJfhrWJk+ygkBD3rVfkDVVO0IqTMcARJ949HDQHGl7rTh
	 L4YL1rZF7kkZCRMq6b3SJ2IElhPX4r0xrinpLo4IiSqe/ZDSePsve0YTcVffpPOfa8
	 pLqApiCKhk3lA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Avi Fishman <avifishman70@gmail.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	Tali Perry <tali.perry1@gmail.com>,
	Patrick Venture <venture@google.com>,
	Nancy Yuen <yuenn@google.com>,
	Benjamin Fair <benjaminfair@google.com>,
	Linus Walleij <linusw@kernel.org>,
	Maulik Shah <maulik.shah@oss.qualcomm.com>,
	jordan_hargrave@dell.com,
	tomer.maimon@nuvoton.com,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	openbmc@lists.ozlabs.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v3 08/12] pinctrl: nuvoton: npcm7xx: Fix fwnode_irq_get() error check in npcm7xx_gpio_of()
Date: Fri, 27 Nov 2026 14:04:56 +0000
Message-ID: <20261127140602.2790001-9-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261127140602.2790001-1-lee@kernel.org>
References: <20261127140602.2790001-1-lee@kernel.org>
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

Commit 693c9ecd8326 ("pinctrl: nuvoton: Reduce use of OF-specific APIs")
replaced irq_of_parse_and_map(), which returns 0 on failure, with
fwnode_irq_get(), which returns a negative errno on failure (including
-EPROBE_DEFER), while leaving the !ret check unchanged.  As a result,
negative error codes are stored in pctrl->gpio_bank[id].irq and passed
as large unsigned IRQ numbers when registering the GPIO chip instead of
aborting or deferring probe.

Check for ret < 0 and propagate the error code, matching the NPCM8XX
driver.

Fixes: 693c9ecd8326 ("pinctrl: nuvoton: Reduce use of OF-specific APIs")
Closes: https://sashiko.dev/#/bug/linux-95c9d7d3-32bb-4f4e-ab7f-84872957de4f
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
v2 => v3:
 - Rebase onto pinctrl/for-next; no functional changes.

 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c b/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
index 08eb9aca36b8..ffa2fba023af 100644
--- a/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
@@ -1871,10 +1871,9 @@ static int npcm7xx_gpio_of(struct npcm7xx_pinctrl *pctrl)
 		fwnode_handle_put(args.fwnode);
 
 		ret = fwnode_irq_get(child, 0);
-		if (!ret) {
-			dev_err(dev, "No IRQ for GPIO bank %u\n", id);
-			return -EINVAL;
-		}
+		if (ret < 0)
+			return dev_err_probe(dev, ret,
+					     "No IRQ for GPIO bank %u\n", id);
 		pctrl->gpio_bank[id].irq = ret;
 		pctrl->gpio_bank[id].irqbase = id * NPCM7XX_GPIO_PER_BANK;
 		pctrl->gpio_bank[id].pinctrl_id = args.args[0];
-- 
2.56.1.839.g22a8290db9-goog

