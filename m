Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1494E39A05C
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 17:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785258429; cv=none; b=YMfDpz2XGkRT14G5gXvjJKa30lxanrgRy4pyTOTttWqtoDwdhd+mphpV7UxZIhzR3m3zvcQiknhfvKGpjSqNzr31Whhitzcgg5KervK4dqfVMr5z7G+fAYPeQiZrdtL9YyB6EiqedV4FUCT5oLvl0O8Z6DOGyrEmotlC6/1skM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785258429; c=relaxed/simple;
	bh=FSl8NbwYEvZywt/N3aE/X/wjHs9hUkn5bj+FSDdsTWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sai5vfXvPBsS5KlmFJMAEKY+k4dZk02XATYMET7XEZ2SeiDCJHMeQrwZlQQj7mFLakKjmD+Wv5aa6jZ+nBy3HTx3ReNJueuElgpAIEWwenT8WqsjG36S2R7eEq2G59A16iac+OI3NJhQ0aE6zmuTnqZqLd+ilVS/waALhYUlpek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WjPbM4D1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WjPbM4D1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 246151F000E9;
	Tue, 28 Jul 2026 17:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785258427;
	bh=LtvEDBtiRKzPNTbO14uxZlxaCiemYe7S2doPeXC1z4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WjPbM4D1mMs9acauoDeKbhGnKWAUG+EEN3Za0sRjsuK4XHBbytozPhWW+o6tHiGMp
	 HPeo9Aq4WgT9XjcRO5f3LuQCY1C9AO++FD3wvo5r8ceVCPrm/gNADMWzGFJylevMZn
	 ZHn0IYPW8AFvv90uWrXApIJ+YWuulVr7pDbJEfW0BT1eqhFPONbvHLWQgi+ueLaNXD
	 8PJlogw01DEHLJ3KixQBUPAsxO6H5gDRPaqU+296jUCYBiQAN0xBVJRZ5nXJfVViwR
	 Lt5Hb6KcerSxBxqIFqij1kmicOKpSyfWC9/Rg5fXStDY9VI9GW/y1t2qlLP6tYWXTL
	 oJtDEoynkiUsg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sergio Paracuellos <sergio.paracuellos@gmail.com>,
	Sashiko <sashiko-bot@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] gpio: mt7621: avoid corruption of shared interrupt trigger state
Date: Tue, 28 Jul 2026 13:07:05 -0400
Message-ID: <20260728170705.183535-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072039-anemic-agreeably-f500@gregkh>
References: <2026072039-anemic-agreeably-f500@gregkh>
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
index 82fb20dca53af5..6a6bf3d503eb63 100644
--- a/drivers/gpio/gpio-mt7621.c
+++ b/drivers/gpio/gpio-mt7621.c
@@ -155,6 +155,8 @@ mediatek_gpio_irq_type(struct irq_data *d, unsigned int type)
 	int pin = d->hwirq;
 	u32 mask = BIT(pin);
 
+	guard(spinlock_irqsave)(&rg->lock);
+
 	if (type == IRQ_TYPE_PROBE) {
 		if ((rg->rising | rg->falling |
 		     rg->hlevel | rg->llevel) & mask)
-- 
2.53.0

