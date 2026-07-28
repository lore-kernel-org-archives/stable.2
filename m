Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9185536F909
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 16:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785255043; cv=none; b=nPqavLOjWEPJps75ecBeiGnwZ2f7IUnrzjPHm/Utzef0cyS9YTYazqJiiwa5IyE7Wku5SJwAW0mpTrdmn71oFwIlhXQQOwdUZ3MCuovTCq8iWRa3PtZyjfKPU50bFCd1Vuw0WKVvpmVt8RGDHsHhJL7DAC411lX4mhMECUpDGt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785255043; c=relaxed/simple;
	bh=7lzBBpKl525xbuAgJ6D4I67MvimynDIy4ayRioThEbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CvR2n64MkEFhDqO/w+yPAdJHM+Jk8UTlkfE/F5SA+X7DoR3ITAfa8ljMtKXUPRWNH7E4iWf6MUUQDykGVKvDpeRBhZ/MAOIp7/qTFDZRAJ2/UNmXbHGHhZmzHim2pPTvEqa5ZYkouvEYBBKqkjkDvBSw+C/X51WYi2chWACiSOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g++FZZlo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g++FZZlo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 971351F000E9;
	Tue, 28 Jul 2026 16:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785255042;
	bh=0rhgh2pkY+6/FnbhaTKn2z4bPTLKFol613zVJTSkcYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g++FZZloOjG2fjDthl8m9XJi748l2u/Bi1v8n5sirqJSqKZrdyIVHEcSLTyr1NKJ6
	 qlfaKJMMu2sLlK557EqN8xEuqI/a1ddLnulnzU51zWroBeI3OUJqOfSmXmXUBx8inA
	 AAFhhyKRqQ0M23SP+Gwm8fvaT79lQMZ0dKdtSkP/eb8ZOTpx1yI/s1RASAIuVBqCSj
	 UkEZBkR/7wTv0Rl7km/F4dxMiofwLXIXZVagiWDEFZfpZMKAbxkFPDx1uvDVni2H9F
	 /81HZ/qfvC3Wv5zQ+CzeIkDcPG423fNJl3frRU6N/iu542qUX3QdoxrVqZi9+V6tlE
	 GGngr83Ol25WA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sergio Paracuellos <sergio.paracuellos@gmail.com>,
	Sashiko <sashiko-bot@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] gpio: mt7621: avoid corruption of shared interrupt trigger state
Date: Tue, 28 Jul 2026 12:10:39 -0400
Message-ID: <20260728161039.36121-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072039-opponent-audition-18c5@gregkh>
References: <2026072039-opponent-audition-18c5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sergio Paracuellos <sergio.paracuellos@gmail.com>

[ Upstream commit 1781172526d1092323af443fa03f00e6de560401 ]

The bank-shared fields like 'rising' and 'falling' are modified using
non-atomic read-modify-write operations. Since every gpio chip instance
represents an entire bank of 32 pins, if 'mediatek_gpio_irq_type()' is
called concurrently for different IRQs on the same bank a possible overwrite
of each other's configuration is possible. Thus, protect this state with
'gpio_generic_lock_irqsave' lock in the same way it is handled in irp_chip
'mediatek_gpio_irq_mask()' and 'mediatek_gpio_irq_unmask()' callbacks.

Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: 4ba9c3afda41 ("gpio: mt7621: Add a driver for MT7621")
Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Link: https://patch.msgid.link/20260626060112.2498324-2-sergio.paracuellos@gmail.com
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
[ Changed `guard(gpio_generic_lock_irqsave)(&rg->chip)` to `guard(spinlock_irqsave)(&rg->lock)` as the generic GPIO chip lock does not exist in this tree. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-mt7621.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpio/gpio-mt7621.c b/drivers/gpio/gpio-mt7621.c
index 93facbebb80efa..212a5f57cfd2bd 100644
--- a/drivers/gpio/gpio-mt7621.c
+++ b/drivers/gpio/gpio-mt7621.c
@@ -156,6 +156,8 @@ mediatek_gpio_irq_type(struct irq_data *d, unsigned int type)
 	int pin = d->hwirq;
 	u32 mask = BIT(pin);
 
+	guard(spinlock_irqsave)(&rg->lock);
+
 	if (type == IRQ_TYPE_PROBE) {
 		if ((rg->rising | rg->falling |
 		     rg->hlevel | rg->llevel) & mask)
-- 
2.53.0

