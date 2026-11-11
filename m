Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794362626;
	b=WjgLlbMRh9z6treczwKMN2G1O/EEDdokS/NFIsCHyk7yBAt/Z7VxmmKgSVt2bK9OLIaF
	 AZyT46Ul2GdjOj6w+8XTLBZzyZoTzsFGOePBHlgE1474HZm0OmYT9vvhYlamitHnsXQEs
	 c/n74IIM8A/Wshq5/fjQJUAJi/rNLsf0Iz5dCnJLLEOQexu+rqqz7l3S6DBs+JWptMk2w
	 Y3YngwE2SeToB9oofP1oHnOwgDVeWsidmvFi6tKed7/h6WKXvqbxwwqutetbcuteIV+sc
	 zlgyFw0Xygk+ce5QTdmMxeagglbaNT32tdwij5SkrD+Wc+3Oa9Bq8N6n8t9bXGyEVEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794362626;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=2l+YGQvm1ChHVVlAuapuk7z9Cf3SKBOcoBB0EQWRCoc=;
	b=zoNQqc30VCehq8bGdLDNyz2hPqoTCRA+IW6Bf76NlLnSLjqwm3dd5/r2KhUu+1s1J8QU
	 U3Gfa8peqSe5xZEbGC3GLpUh9yoMNOWmTFApS/OpHZo+HS4V6zHwo3FPZfguYI+qVQQhl
	 7UiUVs5d3rSbD2q7mjbqrrWhHnsKUI4GP/GY0gsO52CCK3CHuCGyggV44bo92fQAzmU9P
	 mbPMD37V/P6MM+BcyEniCtJlgLEjcySKC4+3wr0b+t55DkM4yudBC5Q87G03glCQLvyF3
	 20rOdEAfM5AqSagptSOfALtDK5/OQ31ozP/w/xdd38EBgRkA5IP19sL08aWj+q48NjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZTAVW18L;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAF460A260D
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 02:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZTAVW18L
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFED01F00A06;
	Wed, 11 Nov 2026 02:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794362626;
	bh=2l+YGQvm1ChHVVlAuapuk7z9Cf3SKBOcoBB0EQWRCoc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZTAVW18LZy5AMNgix3o8EQl3EBDQ6WgHt+3ryn0UrjVX332tEq2NUGndTCSzZO0oQ
	 ZAp0YzFGny2olNJvBwuVfKRgazLBdKR0XNU6V0LgiyO289qPijGxPDbVBFZqQVEQDP
	 1g4T090q952vmqip5CguWIOuvyl2sIWBv2oQmykZ4K/gQ7o2yjuvnHcWrfMyzdiUTE
	 E9N30WCXxopDCc7UKp09m3CWV44CN78zhyt4U7BU8/hvQ77OimifVJmp4CF6RVt8w9
	 YXDCk4VB/1/4djz0Yzf71aWCrS8MMnp0+7cowPK0USE9KS9T5RqyJ85y1iCPJ2ILSA
	 Q9PHuB8sLGf5A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alexander Kochetkov <al.kochet@gmail.com>,
	Siarhei Volkau <lis8215@gmail.com>,
	Paul Cercueil <paul@crapouillou.net>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 6/6] Revert "Input: matrix_keypad - force switch rows to input mode"
Date: Tue, 10 Nov 2026 21:03:41 -0500
Message-ID: <20261111020056.444668-6-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111020056.444668-1-sashal@kernel.org>
References: <20261107053642-failed-6.6-1527451f87df@kernel.org>
 <20261111020056.444668-1-sashal@kernel.org>
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

From: Alexander Kochetkov <al.kochet@gmail.com>

[ Upstream commit 1527451f87dfe368b8ddeeb501c24ac9bde6b589 ]

This reverts commit 01c84b03d80aab9f04c4e3e1f9085f4202ff7c29.

The commit makes every scan call gpiod_direction_input() on the row
GPIOs. On pin controllers where GPIO input and interrupt are separate
pinmux functions this switches the row pins out of interrupt mode, and
enable_row_irqs() does not switch them back: it only unmasks the
interrupts. Row interrupts then never arrive and the keypad stops
working. Seen with a matrix keypad on an Allwinner A64 board (PINE
A64-LTS); it works again with the commit reverted.

The workaround is not needed on Ingenic either: the author of the
reverted commit re-tested all available JZ47xx SoCs and they all report
the live pin state in interrupt mode, see the thread in Link.

Fixes: 01c84b03d80a ("Input: matrix_keypad - force switch rows to input mode")
Link: https://lore.kernel.org/all/4130C026-2A83-408B-836A-ECA044491C47@gmail.com/
Cc: stable@vger.kernel.org
Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
Acked-by: Siarhei Volkau <lis8215@gmail.com>
Acked-by: Paul Cercueil <paul@crapouillou.net>
Link: https://patch.msgid.link/20261002100935.449473-1-al.kochet@gmail.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
[ sashal: Adapted the loop removal from gpiod_direction_input() with keypad fields to gpio_direction_input() with pdata fields. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/keyboard/matrix_keypad.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/keyboard/matrix_keypad.c
index 9e6837217f441..d0787a568058d 100644
--- a/drivers/input/keyboard/matrix_keypad.c
+++ b/drivers/input/keyboard/matrix_keypad.c
@@ -118,9 +118,6 @@ static void matrix_keypad_scan(struct work_struct *work)
 
 	memset(new_state, 0, sizeof(new_state));
 
-	for (row = 0; row < pdata->num_row_gpios; row++)
-		gpio_direction_input(pdata->row_gpios[row]);
-
 	/* assert each column and read the row status out */
 	for (col = 0; col < pdata->num_col_gpios; col++) {
 
-- 
2.53.0

