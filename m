Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795458788;
	b=ySEVFDX+5FOl3Rxa6TnTovzKahc+23RTeeKYRBck2THaRThgSxDa5tCoUY1LsZpja7xS
	 JTtp67rh9ONJ5waj9itg+kthIAKn8LUP5goeR7TWve7qXPWn4B6Q2Dxciy4sO4N1Iac7K
	 ysuzgeyDQeIm2tir2Ig8wQenWu6t6J1DA+U/4emMzfOZLd7BAhxfXozGDtGWyX6t+zWB/
	 To8XK4Y8m97Vfukn9PCWgBohesK5FDIbU+fEG+R8W8TBQMd0GNpnQ91+bZK1Z0qxIAYww
	 anXBA/7QOh1JcEAuhtZofX7/8UhiqYK4a3c6y82H1X9GF3UN7qXD29TanVsguznA//g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795458788;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ewYq6AIbBNsZwelrKkc+xEBWvdNQGiW8QGnMZ/P338c=;
	b=sRoa/o0BVRwvbbM2sy4sjPrMhgUeIMHHkpuxGUddPwgwy+Zc0KY6jAq4cBkgxKQ2tBT+
	 5/nWgw36n73b9e+a8y8tuZDbt+f24/nsvJPs1HAhAvxHPAH0fnP1e899cCYF/WEZcgW+Z
	 0MqN1//YlV9k47UG+/m8jXI+o+uZjru5H1sX6OZ2cJN/AyhHvd7PBRjf/S1EIn8eHtZmw
	 JMY/Kkpw7yXzP0O4UbUOgA0B9bgq+6WHVLc9JtZrwamHIK6d1iXo2PAKz0eZ4Xf4H0d2s
	 1GlvBJnth6ThmkwaIgbl0uGvj7FpIuGHhoVZ+RIM9HfY8D+d63In1xStACgavLmPw4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fw7itiBg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE54606A31E;
	Mon, 23 Nov 2026 18:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fw7itiBg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8A0F1F000D0;
	Mon, 23 Nov 2026 18:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795458788;
	bh=ewYq6AIbBNsZwelrKkc+xEBWvdNQGiW8QGnMZ/P338c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Fw7itiBg/4bO92QnraKYawehunCcURbXpYI8xwE3yAPUKnCymsO+c7wqPvekvu/FH
	 QRsa3SuEy5qWyRBZFUu2ngPhFOXEBJ3V8shSI0Pm0+0O0t1M6tWzjra+ew6kYXMUss
	 AzTUGdYiGPDGYkA107w9LQRufO9ClVLMxZem4AAI2eQ2A1aWbpYl7Dm1Cv/tWBhlgR
	 QqqVyiOqkzcQ/aH4HboaGQ3arG5lQ4x9NSrI0IFlC2vB6wqXeJXkshWSQ5SDcPsh1U
	 3FMVEz8IErCqJHyVS6QuiulX6+spYk3bEgjXoB0oqucrANSyhFZqU8hcPDdl8cyhyN
	 2Ke/j7qswIVdw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Samuel Holland <samuel@sholland.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 09/10] Input: pinephone-keyboard - request IRQ before registering input device
Date: Mon, 23 Nov 2026 18:31:15 +0000
Message-ID: <20261123183200.3900004-10-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
In-Reply-To: <20261123183200.3900004-1-lee@kernel.org>
References: <20261123183200.3900004-1-lee@kernel.org>
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

ppkb_probe() registers ppkb->input before installing its threaded
interrupt handler with devm_request_threaded_irq().

As soon as input_register_device() exposes the keyboard (including
synchronous open by the console keyboard handler), ppkb_open() enables
matrix scanning.  If a key is held during this window, the controller
asserts its level-triggered interrupt line before the handler is
registered, causing the kernel to disable the unhandled IRQ.  In
addition, devres unwinds in reverse order on unbind, freeing the IRQ
handler before input unregistration invokes ppkb_close() to disable
scanning.

Request the threaded IRQ before calling input_register_device() so the
handler is in place before scanning can be enabled and outlives input
unregistration on teardown.

Fixes: 17406967ec0f ("Input: pinephone-keyboard - add PinePhone keyboard driver")
Closes: https://sashiko.dev/#/bug/linux-f24d8390-cd48-42d7-a3ea-c075b69c127a
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/input/keyboard/pinephone-keyboard.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/input/keyboard/pinephone-keyboard.c b/drivers/input/keyboard/pinephone-keyboard.c
index b4a02ade3a80..fdf2c270bacd 100644
--- a/drivers/input/keyboard/pinephone-keyboard.c
+++ b/drivers/input/keyboard/pinephone-keyboard.c
@@ -412,12 +412,6 @@ static int ppkb_probe(struct i2c_client *client)
 		return error;
 	}
 
-	error = input_register_device(ppkb->input);
-	if (error) {
-		dev_err(dev, "Failed to register input: %d\n", error);
-		return error;
-	}
-
 	error = devm_request_threaded_irq(dev, client->irq,
 					  NULL, ppkb_irq_thread,
 					  IRQF_ONESHOT, client->name, client);
@@ -426,6 +420,12 @@ static int ppkb_probe(struct i2c_client *client)
 		return error;
 	}
 
+	error = input_register_device(ppkb->input);
+	if (error) {
+		dev_err(dev, "Failed to register input: %d\n", error);
+		return error;
+	}
+
 	return 0;
 }
 
-- 
2.56.1.750.gf70dc682cf-goog

