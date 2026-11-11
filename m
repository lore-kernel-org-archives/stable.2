Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794362623;
	b=iRIKeySxpDS/WlazqxBtPa31UEPdv4jqrsonZYVPDQLJ8fClYtW3XScibcDyQ3cvEjs+
	 lAxEsK2Vyup7hYeSN+/6E0Cg+ibnxTMlBsRg/Bd0s6rDb0TjjeGw6XjPI9SmNcxki0Rxb
	 7hpOh8mreaEB1FaoEHKhTENv8OeQzxBpLHjW5PlsG+5ZW/WNHjIybbE7oVfUN9R+wfQGg
	 1Vv2ugTGXsByhHJv627BTNTQ8cdiAc58EiVwWxl2ogMUWg6aunWotv7lSF3m19210dMbs
	 2XwYSUnbytQ52F4jE4Rp2qC+vvHL7G+4H2EsGsGhWHjXXaXmVVJ1WFlW5//Ha0KhB1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794362623;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=QJJd90FQnT7Q8k25K5YFLsUqenhMTZCgscyA8PwO/jk=;
	b=PgjtFaozBldhP8ShV6Flbix3MqsEjLcCpdtIUNGsCy64+1a18uBt2EUFF5wnX4QqS0Xk
	 Kg+/+Xny9OMz2u40nHK0urJdq+v7rvTD3SORfxM7MaHoKl1BLbj0HRMB81LKGRcpI4TXB
	 w8YSMCMqW3TS2BuqlBis1d5R30Iaf93zFmtlhfAEqLAAtnA9N+U9QKWDcZSWJ0MaFS28N
	 3d/R0gqMYVoct3JksvCGY9kv/Zp0rjs57ZMByLAm09ZTIufRP3YjoquBYbON4u6XH/b1A
	 suTrkGUW+SOfi3g8btAsbDhFj5Z5hhnhOCibZld5plKfFgGQQMiDg5IOkKo1aVVmI3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RINm7b9Z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635A2606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 02:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RINm7b9Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 733051F0089F;
	Wed, 11 Nov 2026 02:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794362622;
	bh=QJJd90FQnT7Q8k25K5YFLsUqenhMTZCgscyA8PwO/jk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RINm7b9ZMiZcrOQ+uTJOlDoTTwD51/vy1zVS9MZa673XbV/LGJpXUf+RtvOETcPj0
	 DBGnKpW473Thjz0ClV7VXLR5DbHkICXju7pAKTrwzN0FyT4zSqq739qlllVNBV8rWQ
	 X+or7PlUmgN1MPhgp8F+VhkwoDesWn7LFOLuhCvdamX+ZX8+MRW2h27ecL4a+KdYcH
	 LtQCuAaqQJNS2jDdPReZ6P8RqO3fS2C5v0Ze3NxkS+Z+zn6V/sSEhXZb2HdXJDiwRl
	 I7jblWBDmxvusp4JGjEO7bRDPBWRRm+jGES3wIobwkFBglg+OkZ7DEx25Nmpq/fF1U
	 tRiyN0zMNEbHg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/6] Input: matrix_keypad - convert to platform remove callback returning void
Date: Tue, 10 Nov 2026 21:03:36 -0500
Message-ID: <20261111020056.444668-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053642-failed-6.6-1527451f87df@kernel.org>
References: <20261107053642-failed-6.6-1527451f87df@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit af90388a598d39584283c18e4047124fee8f1801 ]

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart
from emitting a warning) and this typically results in resource leaks.
To improve here there is a quest to make the remove callback return
void. In the first step of this quest all drivers are converted to
.remove_new() which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Link: https://lore.kernel.org/r/20230920125829.1478827-6-u.kleine-koenig@pengutronix.de
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Stable-dep-of: 1527451f87df ("Revert "Input: matrix_keypad - force switch rows to input mode"")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/keyboard/matrix_keypad.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/keyboard/matrix_keypad.c
index a1b037891af25..50fa764c82d2b 100644
--- a/drivers/input/keyboard/matrix_keypad.c
+++ b/drivers/input/keyboard/matrix_keypad.c
@@ -549,15 +549,13 @@ static int matrix_keypad_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int matrix_keypad_remove(struct platform_device *pdev)
+static void matrix_keypad_remove(struct platform_device *pdev)
 {
 	struct matrix_keypad *keypad = platform_get_drvdata(pdev);
 
 	matrix_keypad_free_gpio(keypad);
 	input_unregister_device(keypad->input_dev);
 	kfree(keypad);
-
-	return 0;
 }
 
 #ifdef CONFIG_OF
@@ -570,7 +568,7 @@ MODULE_DEVICE_TABLE(of, matrix_keypad_dt_match);
 
 static struct platform_driver matrix_keypad_driver = {
 	.probe		= matrix_keypad_probe,
-	.remove		= matrix_keypad_remove,
+	.remove_new	= matrix_keypad_remove,
 	.driver		= {
 		.name	= "matrix-keypad",
 		.pm	= pm_sleep_ptr(&matrix_keypad_pm_ops),
-- 
2.53.0

