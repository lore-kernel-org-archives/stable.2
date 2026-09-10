Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2524725DB0D
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 02:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789006499; cv=none; b=SoT3cXtesR50ecWiNDoM8qOO9Eh6Zr6bsyx5c3JfE/Yr3+gcEfly3egZ8UG4v56YBdN+/8pGoxkqCYdHOJRcCGgPHH1nnyVdAn5IDYE8H5SDF9s17E/2JJku7GwArDboWGBBo3SfSBb9Oup9RVdYW/8A9ZLvBwNt7rf//PYfa+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789006499; c=relaxed/simple;
	bh=IaIk2IQosx/h56aHBvb1dmYfPLpodhU0q+8MTD6kMFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dw+iYa04nxJTF++z5d65KmALUJLmbdc4xc78Hua6tOIaom8MUjuBpR54vvPirD6qmz60rBABve0vxzL3UL29+WuVo6CQchNGG8vRxhfrMb8OZbjziq36uDYYRYBFoaGEaZpFosFUP+HZqjiv9R+nzLm95soBSmGcrcdjein99hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pp5SXphb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pp5SXphb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E9C11F00893;
	Thu, 10 Sep 2026 02:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789006498;
	bh=AevA6saFGdrtRbN5x/w21/6vccVd43KaktrP2sdWKWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Pp5SXphbfdwgIsH5bLzYZPV+EQbQ+T6D5TRe1VkH+sw4tQTbPd53oxKp/HwwLRlC4
	 VJkt54OfD3RVpSFglOVrqlXuTbCqBkRDWnoM1hRj3ktltjvGu6ET1Sxxw0jVZk4gR0
	 vihOoDMXQ/nG6RVhjwjGHd3KRm11mBWVV3T3OipV2uSHqOIu+hlr/U8KIfA0540qTO
	 kEAkR8Y65ibbOSKOeHnB+YR4Tx7QytzBE5aUwwEa/vji1w1gnz1it0DiBeysEYBcls
	 VJzFbcmBc/0c1uOWf4ODHyhr+KxkcwOY3EiBo7IhdcbsEuwuirPNP3vx/fRL/ZqlOu
	 arFY+iN+jr7gg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Myeonghun Pak <mhun512@gmail.com>,
	stable <stable@kernel.org>,
	Ijae Kim <ae878000@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] usb: storage: realtek_cr: fix use-after-free on disconnect
Date: Wed,  9 Sep 2026 22:14:55 -0400
Message-ID: <20260910021455.3999787-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090832-operating-rubbed-df03@gregkh>
References: <2026090832-operating-rubbed-df03@gregkh>
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

