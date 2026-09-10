Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BB33769FF
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 02:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789006278; cv=none; b=BnOUEP1FGNtER19eZIvFKqcKEusq2q6WHP1H8RZJ8Vx1FpZ8JMOdzRZLpJKQwsEL27wpMl57B/STAkIErYsGrah2GbPoQMhBflpEvCXICwSVx9hvGLxSd9DuEn2A65QaJfJk7sjwekHovRWnYZu03UxPzRj8AO2XnsiTZwUPgpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789006278; c=relaxed/simple;
	bh=IaIk2IQosx/h56aHBvb1dmYfPLpodhU0q+8MTD6kMFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mCE4HkS4d406wmdRTKcGcdPuKUMEoExTF4qi6/qLIQqdPrNotYCwhf4WYssTW4JLP6L1HMXn35sqos/Nw28Esc69k4R0yWhrGPWPnYeD4UYR4xbxYIjD95DrqbpwQSqATASuOb7AufX1vbnfsMUpvFFXFuDiZAvfBxcR/trgNRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mCmNhgKI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mCmNhgKI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 227F61F00898;
	Thu, 10 Sep 2026 02:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789006276;
	bh=AevA6saFGdrtRbN5x/w21/6vccVd43KaktrP2sdWKWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mCmNhgKI2VdTxfKZSm3kL98R8RRMdDs3ytbvmtBpj81ZRjhmQ8gGj+Q4Z+4DIhxj1
	 wIcaeuZCA5fJ01hB9Wwm5pNqjmbLKtnjbInvY4uIy1d/oiWrsEUUHpTozdLcXl6m2v
	 LG1pu4h23j+f68MIFHfiai/Uez+6x3DAeQff/cd47FNRuI2AFFZOnevAbv14YVvPPP
	 n4d2ep300LxSmCuQf/+hnYYH2YzmweJqTGsAx9xAuGucEpJSqc1T38usVPTbKDZq9h
	 VcBDGEhXaYWD+/zZ5MOBFmETKmIUEeNjdlImXDf/1t9Aio3nHs8dudXKkZpfnuO92d
	 ELn06QmcjBnMA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Myeonghun Pak <mhun512@gmail.com>,
	stable <stable@kernel.org>,
	Ijae Kim <ae878000@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] usb: storage: realtek_cr: fix use-after-free on disconnect
Date: Wed,  9 Sep 2026 22:11:14 -0400
Message-ID: <20260910021114.3989473-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090831-imbecile-crinkle-7c3e@gregkh>
References: <2026090831-imbecile-crinkle-7c3e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Myeonghun Pak <mhun512@gmail.com>

[ Upstream commit 4ffee1aebb0c0ffcda9faffd17834ea9b00d42cc ]

realtek_cr_destructor() calls timer_delete() before the chip containing
the timer is freed. The timer callback may still be running and can
rearm itself, resulting in a use-after-free.

Use timer_shutdown_sync() to wait for the callback and prevent further
rearming. Do this unconditionally because ss_en may be changed after
the timer is armed.

Move timer_setup() into init_realtek_cr() so the timer is initialized
before any failure path can invoke the destructor.

Found by static analysis.

Fixes: e931830bb877 ("Realtek cr: Add autosuspend function.")
Cc: stable <stable@kernel.org>
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
Link: https://patch.msgid.link/20260727123414.44700-1-mhun512@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ adapted the timer_delete() removal to the branch’s del_timer() spelling. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/storage/realtek_cr.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/storage/realtek_cr.c b/drivers/usb/storage/realtek_cr.c
index a026c6cb6e684..de82d8260d729 100644
--- a/drivers/usb/storage/realtek_cr.c
+++ b/drivers/usb/storage/realtek_cr.c
@@ -915,7 +915,6 @@ static int realtek_cr_autosuspend_setup(struct us_data *us)
 	us->proto_handler = rts51x_invoke_transport;
 
 	chip->timer_expires = 0;
-	timer_setup(&chip->rts51x_suspend_timer, rts51x_suspend_timer_fn, 0);
 	fw5895_init(us);
 
 	/* enable autosuspend function of the usb device */
@@ -933,10 +932,7 @@ static void realtek_cr_destructor(void *extra)
 		return;
 
 #ifdef CONFIG_REALTEK_AUTOPM
-	if (ss_en) {
-		del_timer(&chip->rts51x_suspend_timer);
-		chip->timer_expires = 0;
-	}
+	timer_shutdown_sync(&chip->rts51x_suspend_timer);
 #endif
 	kfree(chip->status);
 }
@@ -981,6 +977,9 @@ static int init_realtek_cr(struct us_data *us)
 
 	us->extra = chip;
 	us->extra_destructor = realtek_cr_destructor;
+#ifdef CONFIG_REALTEK_AUTOPM
+	timer_setup(&chip->rts51x_suspend_timer, rts51x_suspend_timer_fn, 0);
+#endif
 	us->max_lun = chip->max_lun = rts51x_get_max_lun(us);
 	chip->us = us;
 
-- 
2.53.0

