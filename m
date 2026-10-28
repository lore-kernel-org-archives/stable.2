Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793209435;
	b=sDek5EnmDJyx1F9fjf5JrCvAPtOIAoUH03TyIYXrDr33HKecRyaQni69JSplqDxXuqX2
	 jhX599cMFr/L1LPDkKbcsBEw4da8O26DIPTFFYP6J68IuFIWDOx8txp7IzA/P5vBsWGsh
	 +J2UiV7DhooYRjIY4nU/dptcmOOX+tmhvC0/V66gGIsfvoMZJMNJF1AY2fXGYfUJuy0mk
	 BFGD/VROPoDoZpngpdQuS5IAWjr1KtSOS3XABaDqQZH8KG5V+r4ihBxxn0ATZPkL9IriY
	 2t5nmXbtJfY1uAkoLlrzkyzanaUd3WP0Y1vi8mlDILGhP/VUrjRjbd8g/x8jMubaIeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793209435;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=C7bPJOiOxWmpQxwy7s6DX34z4VIYYp5wKziJM3UDTWA=;
	b=3pacAPnmU3SAApbv858biqScqB6yXfWRSqti4UByy0342q8EphVmVCA8I1Rh0AJnzZgM
	 j0RVY1GauoAwmJZwzrBEs7UR6KpHVm6q9KKWu2BMbx0t/d745kqOUQa+pFQpfDKSquslP
	 XaxviCk1KKV2dG//xnN/BuN4UuEMeZW3BYWOyQf9dY+/InVUEniuMRC6H1NCy4ijABmW2
	 qpDwxdyJ635rFcKn6XAvk0vpdtnBZx+FnDrRS/FUcl+p+5LTRE9sESG+UTPy5SSeUDGzN
	 rRv8aHRM3e4dek/3UHBNjJLSgAlekJg+5CoMoS+e4iOM1AMUVlusoUcEBt/V3bl708g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JJYiJJn4;
	arc=none smtp.remote-ip=209.85.167.178
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF68606A332
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 17:43:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCF68606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JJYiJJn4
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-4f66bb2ab57so510547b6e.3
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 10:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793209434; x=1793814234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C7bPJOiOxWmpQxwy7s6DX34z4VIYYp5wKziJM3UDTWA=;
        b=JJYiJJn4JkWCZeEc6Eis2ekHoap8cCzGqHyN7y9E0/bmhYY6SeOMj9wXaDxYGCF9W4
         rg6+zkS0FgWnliPYuAGh09K7H+ciIbzVpwopLnTlrKjr3K1sgsRTinNnSJQqI16KG2ME
         zRD0FXl/xMNfcTSFf1Vw2j92iw2g9/DbY79Xu4A8/Aq0YonF6eSIBpGbs52puEJc1gfO
         XgehVrwlBeXP9hXhhcZGLFYKkB5r6tuHGlTnxEV9n3iHFz7LB76f2WflVwH1DxlH0Y1z
         MhGYvLVap0OCNB+iO3pgZimqvW9FhewVuq4G40TkNci7ysBcRx2Wz1rnVlGNFCMfP2Ug
         +i/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793209434; x=1793814234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=C7bPJOiOxWmpQxwy7s6DX34z4VIYYp5wKziJM3UDTWA=;
        b=HVI4KUtPQRADHcHdB4y6HvaZ4k5RjvV7SEBDOtJHvVVLe8AIeWjvn9YUooRc7n4lnQ
         dUaWWuy9IgyLLhIbvSnQzkoaSt3YboILsTfUVp349FIoVxQ2pG3G2dfrhOUiSRN++w2g
         l7wPsi0Jvypi7T/JrWEUTxFC7UdVjPVq9Bl0c6j5NE2GhZ07tNQjRX027LquP/plmnig
         rLq9vT0NNiebE84/+eZ9bsLxXIsd7Jziu/bJI3/csbcx+IXzwqf/gWV6J9K2kD7w1BPP
         rtqEHNFRzWB3oSjV4MwhVjB1PaICpjzM+uogs/GG8Pv/s/WgAARnYv0Q0Ychg9EEQykf
         YOUw==
X-Forwarded-Encrypted: i=1; AKwUvBzNcuQIn/b+dWQJb2uJDMlMPhx2Ss+ohFJxZ2UugzKqJxRkCoQporPqel821D5Lhgv4iA1JwoA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJNq/HvWwULBbxQNnY9X0Q/K76ljFYSRv0N1lbUUHiXlQxUBiHO
	y1BeR0BvzoXoC6ObilqAn2WdOsfqaoLsgjvaqh0NrsUOLinmXVyq9InR
X-Gm-Gg: AYBFou2DnUcGW7WQwX1MZCprVf9vKdAMXB+v7rTkVYpX1Shwn3REg1RHiAs4OE/Xp8L
	RFJNT7vMsO5/8YlGH+4fX/vnUGuNnl13CeZFT8vL+R8MGZzk8SbR1bQHGZS+CkSrzzRBicjO5mf
	hisgpbw6y6AuIipbh9nJVk6wh8V4wvdNlvNGsht68rMp3ZxMLBDsjRNcLvyc3W/pjdyjDyXENKy
	JMenR1TKg4JZ2n+uLwrNYUfYRxIoqddhMnlOOOExP3sltMxhgA0iJed9Xt+7xqAY0QAk6j/Nvwl
	eeMgU0X9fC5qQDqMi4xLD0wti47VgOJmlXOncpeoszIl+1F5R+1YpaGzGijtNPymeEzOBDG0VRG
	eGS2L/+5XC+1lA3PJXi67PqFjhhyQ0Q6zsR+Aq8MGwSDUdYziyGyeWB/7KTZbI5xavz74miEVD6
	oX18HG8HVm4hqnF6SazumwHzSzUPdM0wpmo73QNlLM/Cky1eSr4v1ZSz5hGvgp6YKC3GSYZqz18
	PeRFRRee/B5vlDDxwwoPTqU1SuH7qf21lXjOj4xgWAMNG71SkCa9reo4ZK0F9EWTKEA2KUNNwZE
	inv9SLMEeaxIoOoaAtWUf4F2UJ5prP9L2BSdxdksZmYoWQGAbmwQ4aVDYiU4/ReGWpFNJOV7BpR
	3p8/EA8Ad5rfsWWHg
X-Received: by 2002:a05:6808:bd6:b0:4d6:9283:1dec with SMTP id 5614622812f47-56384c81150mr2067708b6e.58.1793209433737;
        Wed, 28 Oct 2026 10:43:53 -0700 (PDT)
Received: from archlinux.lan ([136.34.156.120])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-563c5a4d8b7sm1612114b6e.8.2026.10.28.10.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 10:43:52 -0700 (PDT)
From: Danish Khateeb <danishkhateeb03@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>
Cc: Andrew Davis <afd@ti.com>,
	linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danish Khateeb <danishkhateeb03@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/2] leds: tca6507: Fix use-after-free on unbind
Date: Wed, 28 Oct 2026 12:43:47 -0500
Message-ID: <20261028174348.64014-2-danishkhateeb03@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028174348.64014-1-danishkhateeb03@gmail.com>
References: <20261028174348.64014-1-danishkhateeb03@gmail.com>
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

Since the LEDs are registered with devm_led_classdev_register(), they
are unregistered only after tca6507_remove() has cancelled the work.
Unregistering an LED that is on turns it off, which queues the work
again from led_assign(), and the work then runs after devres has freed
the chip:

  BUG: KASAN: slab-use-after-free in assign_work+0x414/0x5b0
  Read of size 8 at addr ffff888010d5c0c0 by task kworker/1:2/65
  ...
  Last potentially related work creation:
   ...
   queue_work_on+0xb6/0xc0
   led_assign+0x223/0x340 [leds_tca6507]
   led_classdev_unregister+0x26b/0x340
   release_nodes+0xb3/0x140
   devres_release_group+0x247/0x470
   i2c_device_remove+0xbf/0x1b0

Set up the work with devm_work_autocancel() before the LEDs are
registered, so that devres cancels it after they are gone, and drop
tca6507_remove().

Fixes: 1b5c2fa7081c ("leds: tca6507: Use devm_led_classdev_register() to simplify remove path")
Cc: stable@vger.kernel.org
Acked-by: Andrew Davis <afd@ti.com>
Signed-off-by: Danish Khateeb <danishkhateeb03@gmail.com>
---
 drivers/leds/leds-tca6507.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/leds/leds-tca6507.c b/drivers/leds/leds-tca6507.c
index 9afe2722986c..0f987e551f03 100644
--- a/drivers/leds/leds-tca6507.c
+++ b/drivers/leds/leds-tca6507.c
@@ -71,6 +71,7 @@
  * not recognised when matching.
  */
 
+#include <linux/devm-helpers.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/leds.h>
@@ -735,9 +736,11 @@ static int tca6507_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	tca->client = client;
-	INIT_WORK(&tca->work, tca6507_work);
 	spin_lock_init(&tca->lock);
-	i2c_set_clientdata(client, tca);
+
+	err = devm_work_autocancel(dev, &tca->work, tca6507_work);
+	if (err)
+		return err;
 
 	for (i = 0; i < NUM_LEDS; i++) {
 		struct tca6507_led *l = tca->leds + i;
@@ -766,20 +769,12 @@ static int tca6507_probe(struct i2c_client *client)
 	return 0;
 }
 
-static void tca6507_remove(struct i2c_client *client)
-{
-	struct tca6507_chip *tca = i2c_get_clientdata(client);
-
-	cancel_work_sync(&tca->work);
-}
-
 static struct i2c_driver tca6507_driver = {
 	.driver   = {
 		.name    = "leds-tca6507",
 		.of_match_table = of_match_ptr(of_tca6507_leds_match),
 	},
 	.probe    = tca6507_probe,
-	.remove   = tca6507_remove,
 	.id_table = tca6507_id,
 };
 
-- 
2.56.0

