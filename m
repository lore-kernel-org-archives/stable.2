Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793820642;
	b=xXWTmbyXzfx+b3ljLwsDNoDYy6svka6tojWgvXecr/NcWR5oUCpKgN37rG3nDBilBx6L
	 juFczrDFqCzyEasrWg1gFePQk2nGwDLAfbAC4XKGY/1KTFfMlLSYRLjYe3ElirJITfD51
	 MAGdEIzVUKqa8IkZu2ZIAYrMNj5ZmMoIemePstZkJlA8r7JW0YXYPmHsSAyuDZJnK8wL+
	 0wGxvIEQbee+66TQb3ZyGlEcVgJSMLHT4aGy5z8UN49Vu80FeSGTqEYWD5eDjJ/CJwxbZ
	 x4k2kQ9D5U2EI13OiZnAgxcFTrMY7N+tOeCZ7hJROWcwB1TMnsrYptCQ1APyViRKs1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793820642;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3at1T5Y3NkxHZArmAf/Wyx+q3DAsNgKKHj/Uc4gaVrA=;
	b=3uQnbOmcHV8dSkPSTi5EnQJ9coSQUE2moXmulMfgd8rTAI8umQ6C7QZOR1Q41H37O/AZ
	 Lhs+9mG/rMbRYJrf43qO7OS0WMtIYrYbr6FCVN4onMknh0VRJLuwoG5SYsSlGKhpesTJm
	 vKT7kQwrs+75t9g/iGhO+XVcr5UoJYUOI7SC15Q5bKuC6Lc2Eg81nmQbQSMXoCSk26rVX
	 tsYlchSOrGAD85ohD89aVHtYKGNp6dM8otusjsA7BioNDVvEyoCTlwy4Tjtz7Ll7URCuF
	 aQwYz4oERUPj3WxUgn6C3oRvZZndqxRxfsDlnuH8v4nJDwRqElpBfykdYSoXaxpu0lQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a5TQ7dJv;
	arc=none smtp.remote-ip=209.85.210.44
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BD46076CE4
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 19:30:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59BD46076CE4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a5TQ7dJv
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-846566246e8so1037539a34.1
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 11:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793820641; x=1794425441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3at1T5Y3NkxHZArmAf/Wyx+q3DAsNgKKHj/Uc4gaVrA=;
        b=a5TQ7dJv2Q8yNW9kFRS0c6hHEyDGSH0UpHFfuS115vtOJ6fLBlOX4RhN54HWkAGDlI
         N9PbT6hfdGZoy77XMwJNDQQdOGEP4XPu2lDttzbHwVmtKnZBfEAa8O/7nNRMx85uyAJM
         LK0rrhtIf8701DxXoQH6hXxrr8WWRIqTbxkc8xcYkf0kcXu90tj8fQ+QWFUmMzsTikwr
         W+Y674kZHB/kEpXccuP0JS80f4jZhEVk3pPbDQm/wTvybAxLs0QLYUkn5ogSW3jH9/ht
         /AvkQ2oKeeJhmku/wJ5xcll2/IsRRIL5hyEBtJvUQ6+JoUVUyh4wt7DlXx0eEEvBtfz0
         Rzyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793820641; x=1794425441;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3at1T5Y3NkxHZArmAf/Wyx+q3DAsNgKKHj/Uc4gaVrA=;
        b=1OpEVHytZJxW7b1xRiNUDiqySAqBfLNHpEs2gc1NixejhTcPPviPO1mD/KQSJzNX5C
         ChmbovVJKkKMFfabSVC5rxslPqpxX3RoLJDBMCIv+JUcsJjPnyWJCErx+81Hhzn32zs1
         wn+C2JVlt9GDr8Dj3gIMj0MphQsXkAOxe9HwQg5x6wXVSYVCDZn+QXlpvt4Z+IQ3qie2
         sfGaa+4rberr7D5OsTn+W6N7YqBZfFJz4mbpQLgbKbehkxxqtC2RxxwcLEJheuJc7jgv
         UfcYOarimZXGuPC3iLKXgPCRmVmVKTIuOm6bmxbyR/kg3GwErWxc7xtC2zikdlWg+wJV
         2P7g==
X-Forwarded-Encrypted: i=1; AKwUvBwbucyB1Ypx7YWJ4rVWjYHSW8cdtfQZhYD8QWioxsSSdXyDjuM532xolgMhWDnaEUGL7hL1lpw=@vger.kernel.org
X-Gm-Message-State: APuU4Z95fMyl5w8DGx6PxZQzSyScN/y1SBel6GtFclyfg5YO+RZ/b1p/
	6nmf7oLm+Vduc1t3CUsoIexZ56UVJZkPSP445Aoj2NePmeUOpcVTt6qM
X-Gm-Gg: AYBFou1Y+RR4QdnH5WfRdm2NE8vHLa4EhNGWy1O9JCHb4T2pBb3xz8hE5ebATf1DUgC
	SaV3nJnxZv7TfYW+kZpHwEu8eBzHHj9jKdGzehhTh3XtalJRG2adeyQCzXCxlEh1uPqPUmK0RMm
	tBSKca54n/hisu6Y+2d5o1c2W3YiiQVVhs48oSSJ3YA7ZTWn6zbNREndcJOR57XrslSYXEjYaey
	gLlPUwysE0NhhxsZ4Bvz077H7skDU2CSfVYbkwTufGLj4Yd148I6JL4GGQqhhfWg1zj6p9nvcWx
	7pBTbubIvOOw2qDNvyCGZB1u1SprayQMDlCNGkB09KpMWAsZLDZ9sXPsDz5OUNGQIJqK06FuMp9
	Xumko/ARO67UfndkDyea8uh9KC9zjq+kDnetuQ+GG0J/7FzlI5iyx9jwHYDRHjopqBu8n/pzfXF
	Nmu4DWHrmSICfBrVf2GbzSY50m9KqGP9XgkfWDaqOQm3ZTQ6pbCk/qurt1EogI2PZe9qolNOQqn
	w6YBtcLXKFSD83YaP6lekI3WK6IvUkl6SxN3nbdKBALRfukYyVV/n3WkWA4iwLst1NQye8a3bvz
	Jd8zA2vUoo9+go/Evj0jWS67FksRBGT0NomRKmjUQWNT2OxH3EgrgfgmL5roACkgLPViLd4=
X-Received: by 2002:a05:6830:6412:b0:81d:9acd:ee04 with SMTP id 46e09a7af769-85f0528fe51mr386304a34.0.1793820641158;
        Wed, 04 Nov 2026 11:30:41 -0800 (PST)
Received: from archlinux.lan ([136.34.156.120])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85ef3e55906sm2577422a34.18.2026.11.04.11.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 11:30:40 -0800 (PST)
From: Danish Khateeb <danishkhateeb03@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>
Cc: Andrew Davis <afd@ti.com>,
	linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danish Khateeb <danishkhateeb03@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v4] leds: tca6507: Fix use-after-free on unbind
Date: Wed,  4 Nov 2026 13:30:38 -0600
Message-ID: <20261104193038.91614-1-danishkhateeb03@gmail.com>
X-Mailer: git-send-email 2.56.0
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

Initialise the work before the LEDs are registered and flush it from a
devres action, which then runs after the LEDs are gone and before the
chip is freed, and drop tca6507_remove(). Flushing instead of cancelling
also makes sure that the queued writes reach the chip, so the LEDs are
really turned off. By the time the action runs, the LEDs and the GPIO
chip have been unregistered, and the work does not queue itself, so
nothing can queue it again.

Fixes: 1b5c2fa7081c ("leds: tca6507: Use devm_led_classdev_register() to simplify remove path")
Cc: stable@vger.kernel.org
Signed-off-by: Danish Khateeb <danishkhateeb03@gmail.com>
---

Notes:
    Changes in v4:
    - Squash the two v3 patches into one, flushing the work from the start (Lee)
    - Drop Andrew's Acked-by, since the code is now different from the
      version he acked
    - Rebase on for-leds-next
    - Link to v3: https://lore.kernel.org/all/20261028174348.64014-1-danishkhateeb03@gmail.com/
    
    Tested in QEMU on a next-20260930 KASAN kernel, with the driver built as
    a module and a test-only module that adds a fake I2C adapter, logs the
    register writes and adds a software node for a TCA6507 with two LEDs.
    Without this patch, unbinding with the LEDs on hits the report above
    (39 reports in 20 unbind/bind cycles). With it there are no reports in
    20 cycles or on unload, and every unbind ends with a write that turns
    both LEDs off (with v2's cancel, 7 of 20 unbinds left an LED on). A W=1
    build with GPIOLIB is clean. The code is the same as v3 with both
    patches applied.
    
    An LLM was used to help with this patch.

 drivers/leds/leds-tca6507.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/leds/leds-tca6507.c b/drivers/leds/leds-tca6507.c
index 9afe2722986c..ffad476af625 100644
--- a/drivers/leds/leds-tca6507.c
+++ b/drivers/leds/leds-tca6507.c
@@ -711,6 +711,11 @@ static const struct of_device_id __maybe_unused of_tca6507_leds_match[] = {
 };
 MODULE_DEVICE_TABLE(of, of_tca6507_leds_match);
 
+static void tca6507_flush_work(void *work)
+{
+	flush_work(work);
+}
+
 static int tca6507_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
@@ -735,9 +740,12 @@ static int tca6507_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	tca->client = client;
-	INIT_WORK(&tca->work, tca6507_work);
 	spin_lock_init(&tca->lock);
-	i2c_set_clientdata(client, tca);
+
+	INIT_WORK(&tca->work, tca6507_work);
+	err = devm_add_action_or_reset(dev, tca6507_flush_work, &tca->work);
+	if (err)
+		return err;
 
 	for (i = 0; i < NUM_LEDS; i++) {
 		struct tca6507_led *l = tca->leds + i;
@@ -766,20 +774,12 @@ static int tca6507_probe(struct i2c_client *client)
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
 

base-commit: fb511964723311e9a7223e424d725c58dde8307a
-- 
2.56.0

