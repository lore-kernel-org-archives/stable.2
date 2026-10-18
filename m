Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09673DB31E
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 17:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792343146; cv=none; b=Xf1Zh13NT8o53xkmRGC34ohdVhE/KN/rZQAM6ZWrwOK5MwmPmHvI4MhlVG8IJMjoUnow7FF2MNVqxDuasa5JXb+5IrkcSgl2bgAoL7T+zjAN2Rt3xmDBscuEsrFKSU8v55wAwomFusCsja/EGai2K6zKk0H+/z7kKH7y05emVQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792343146; c=relaxed/simple;
	bh=so/mFx2Ao2GsJpBhafP1pe9fktRMxxMEgCjCSX2y/b0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rL0XahUZoL5JJuvp2nM+xylRFk58uzVTyzDeho8G4w5DDIJdR5Ce/t9FL4qFEfE8SSIHtFrDmlE3fK09+Yq4HcjqjZzF4Vzc0B4pYnhzAFGHfW5+4LLrt1e450f2YxlEJYtLxcgJhev3ssLozp/B/+9dvahtBIlYdX8MIDDEhx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ney9zHCt; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ney9zHCt"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2e60f9af6e6so10228155ad.3
        for <stable@vger.kernel.org>; Sun, 18 Oct 2026 10:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792343144; x=1792947944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3W+MZb2eOKpPBttwcKlbbD/WfEQPKdgJ9KWbT5a3vI4=;
        b=Ney9zHCt6Np26Oj79AbYEf6EmM7tOjGQZspkshvYeRUnpymI7l1W/8j/J7T7tzEO4F
         DeSxc7Vdx0jaoYq9Kgv0Zn+Pwq/4iWJhRk8FhBLI2H55SL7zC0SdZZCiJ7HF8XCCrc4U
         TLu2eU3EEhaEu3McMEi3fgNVTHzaZWlk/pGuhFsaD12XlnObXtvIGTwVt5MafAnYnKJC
         ZqEMuPl10bqJe+YRsSJfFfBdBq6DufdMwJYnJI2phew7/P823EE+Krk0TzyiMEbRWJQl
         eU4RH5VQxdOmyAi4AdZkwfhnLpUpktsDGJGsloN0Me0VkPgRQh8bs/8ALBht34gRY8+X
         R4jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792343144; x=1792947944;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3W+MZb2eOKpPBttwcKlbbD/WfEQPKdgJ9KWbT5a3vI4=;
        b=GX5Sa8VYNKKaz4ATyDWvCI0qDCsMJnzPnAmUX4gmaD7EwDUEFTYrygRZ6q2kgZe+ja
         vOfXx06z8A+7xhc9AouKBXC7VqpuRC5b28D6BxmnMu2xWYuqPjd8kosyr+fHcz9C+8Gt
         twrJpYYepVCMbnT4J1bvQao/tscDNpsn4mVuSKVdE1y92oG9UeUAnXXdyeHMF/3bBvmW
         0Nv0XmV9OxsXdrL3jNeU3+x5GzfdjLsZ8Tvdi3NFNIPb1cujH52bvsYjOVm4wgHpMC8y
         CkHKqwzlG8LfnXBZQmK7eB7grOcg2/tD3qIu66FYRo4akBnRRQYkkXQqIOKfwTskUixh
         6ARw==
X-Forwarded-Encrypted: i=1; AKwUvBzwjXNsI3EvRRdsvo0YJfSF5KbMsk+AXPuOexhSP+9HBVxRMHPEhrBL5juZ4GZWpRMSfwIrT4k=@vger.kernel.org
X-Gm-Message-State: AFq9FYLn9He7gPJD8ll+bD11QqqtkekfQtpRHsT/ANzQJur7+doY9xb2
	guqVjH6jQL0Al6lktU/KYBL86WYIntFstVVjaKtB9Nbce8krfV+KfbV3
X-Gm-Gg: AYBFou2JUXGyBow30XKLSr3bzjuoPiuYezL7i5mcpHV/4fI+QUz/eN3Zj1Wt96B+GT/
	UxHwnY+wVVKFwzyeulBNvaWnZ2YHsorrRaJ4eidKDzD83FZWEfJMH0pZ7+374AbyinbahzLmPYF
	EHZ6hNc6etg8I21rRg+DgNVT3TnyQv7tizWvRp66h5XISkVwNbjU2L51kqwib1mwNdrSxjq0Y2o
	y8yb1GHXvrFBfTVXzYTiyvhNBS8zOelULwTP5ZwmLNm0qOHirnD0WjRCREsgy6BnCv141ACOcn1
	x19ZnNFv6LeDhlScaETr7yO9L78++EUnq7pEdu0+R//2PZ19p5wm4/FOK3vjle5NoZuYPjeLV2W
	f/R2ahY4wEOmoyL2zHVx9AvVJ5s4ublw9Lrgc60OeRQavl6pOYhlAgDpcxJCQUg0Kyo5mBiq1ka
	3YFL+NBHeaxWEHUS23cIAL/IYvaGIKX6tEzB3d+gCEOtpsFFZhfxP9J2KVyJyaxBX3hbMLpfQqh
	iT8mfdZWojymPPtUznEdwk7TVrfmUwULGJzCwyuLmh+
X-Received: by 2002:a17:902:db03:b0:2e9:502a:ddbb with SMTP id d9443c01a7336-2e9a6c201f3mr47934555ad.45.1792343144127;
        Sun, 18 Oct 2026 10:05:44 -0700 (PDT)
Received: from obadmin-Precision-3680.atlascopco.group ([167.103.3.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e8758efsm28757625ad.55.2026.10.18.10.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 10:05:43 -0700 (PDT)
From: Sahaj Chaudhari <sahaj123.sc@gmail.com>
To: Keerthy <j-keerthy@ti.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Devarsh Thakkar <devarsht@ti.com>,
	Aswath Govindraju <a-govindraju@ti.com>,
	Aniket Limaye <a-limaye@ti.com>
Subject: [PATCH] gpio: davinci: Clear interrupt status in every bank on suspend
Date: Sun, 18 Oct 2026 22:36:22 +0530
Message-ID: <20261018170622.3406158-1-sahaj123.sc@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

davinci_gpio_save_context() saves the registers of each 32-GPIO
register bank, but clears interrupt status only after the loop. At that
point g refers to the last bank, so pending status in all preceding
banks is left uncleared.

Move the interrupt-status write into the per-bank loop so that the
existing suspend-time clearing covers every register bank. Single-bank
controllers retain the same behavior.

Fixes: 0651a730924b ("gpio: davinci: Add support for system suspend/resume PM")
Cc: stable@vger.kernel.org
Signed-off-by: Sahaj Chaudhari <sahaj123.sc@gmail.com>
---
Testing:
- Built an ARM64 kernel with CONFIG_GPIO_DAVINCI=y,
  CONFIG_PM_SLEEP=y and CONFIG_SUSPEND=y, containing this fix alone.
- Booted it on AM642 and confirmed all three DaVinci GPIO controllers
  bound, with an untainted kernel.
- Validated the extracted save-context function in a standalone
  userspace harness with simulated write-one-to-clear MMIO, using one
  through five register banks. Verified that every bank is cleared
  exactly once and GPIO register and bank-enable context is preserved.
  The unpatched function fails clearing checks for two through five
  banks; the patched function passes. Ran the harness natively on
  AM642 and under host ASan/UBSan.

The suspend callback has not been exercised on the live GPIO hardware.
The regression results above use simulated MMIO, not real pending IRQs.

 drivers/gpio/gpio-davinci.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
index cccbaea1dec2..fc2b9bef7efc 100644
--- a/drivers/gpio/gpio-davinci.c
+++ b/drivers/gpio/gpio-davinci.c
@@ -611,10 +611,10 @@ static void davinci_gpio_save_context(struct davinci_gpio_controller *chips,
 		context->set_data = readl_relaxed(&g->set_data);
 		context->set_rising = readl_relaxed(&g->set_rising);
 		context->set_falling = readl_relaxed(&g->set_falling);
-	}
 
-	/* Clear all interrupt status registers */
-	writel_relaxed(GENMASK(31, 0), &g->intstat);
+		/* Clear stale interrupt status for this bank. */
+		writel_relaxed(GENMASK(31, 0), &g->intstat);
+	}
 }
 
 static void davinci_gpio_restore_context(struct davinci_gpio_controller *chips,

base-commit: ac46dac1613a7c971e28e16d3a7a6ad4b1ae6c5a
-- 
2.43.0
