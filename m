Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165EE378D70
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 16:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785256188; cv=none; b=RbcZakFzJ0sbb2pz36RHaY3aT5vQK67mVWmogZ2mzd3mqkGRe9DgVE3LP+q5O9J7W2wRKll+dLWEKqeZmpar99ZRme1hEzi5Ml9vUvZvMAUug11xfpTiRxeGfZVuilR0moDdNdnq7f4FUKRIgE6gPjkXqRY+sWY2AESGmeyaEdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785256188; c=relaxed/simple;
	bh=d6SXg0AA7YjB2C9MTvxebLj9DcfXat0ZxXmbKae95iE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kS3rIIEOK1Gyswa8Kz1n8oz46mqmdiUuzWti3ihDykHlAJdm13tp73VHJFuG6Mh2sPBsRLdz3U1Qmzhg6ILEJ7Evv6XhPPLLo2pdCKG+JjWBy7siYvL1Gw9fRngRAl2CIFcqCxV5/HCnEPggYJtM8hgvMc5KUWJnKfSHeG1fqAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ODp0DYE5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ODp0DYE5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E1C1F000E9;
	Tue, 28 Jul 2026 16:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785256186;
	bh=651/731/638fIAJ/NP0I3B3hd5paXx9p2VgDkLo5jC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ODp0DYE5ryhhuk14Yhu2TGyzQ5BNiUAPyw15chLzqkmYAw/fy/dGHx9BeZzCLuXz9
	 pD7Avuvsoi0v61Hk2iw28AFq0jSN/SI8gQmrsNFaOWLexD7/b8nhEauxsvfWyMLUwJ
	 fca6h+ucUy+T9vDkLVPA2K2E9yySud7FFRDgkI7YeokNv1eW1l9SobEJ+B3PTkWRJH
	 Xr1nfjq8Rkt9eO87CzLhPA6YEuIBIw0gsqP47+eACfo+dpdjVTyNGw54HpJEPW+8ey
	 GIefBYrzpR64NmKLByJc8dM7nZXl60P5sSLy5X2UCuzy+dOHpiv1U85OXzU4nPq52i
	 9j7EE/wr5WPqg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sergio Paracuellos <sergio.paracuellos@gmail.com>,
	Sashiko <sashiko-bot@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] gpio: mt7621: avoid corruption of shared interrupt trigger state
Date: Tue, 28 Jul 2026 12:29:44 -0400
Message-ID: <20260728162944.99404-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072039-grip-phony-0a5a@gregkh>
References: <2026072039-grip-phony-0a5a@gregkh>
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
index c3658a597a80a0..bf08f6894ae063 100644
--- a/drivers/gpio/gpio-mt7621.c
+++ b/drivers/gpio/gpio-mt7621.c
@@ -153,6 +153,8 @@ mediatek_gpio_irq_type(struct irq_data *d, unsigned int type)
 	int pin = d->hwirq;
 	u32 mask = BIT(pin);
 
+	guard(spinlock_irqsave)(&rg->lock);
+
 	if (type == IRQ_TYPE_PROBE) {
 		if ((rg->rising | rg->falling |
 		     rg->hlevel | rg->llevel) & mask)
-- 
2.53.0

