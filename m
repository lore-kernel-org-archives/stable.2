Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794729757;
	b=rUv1Rayh1tIr0bUQl5TWP976XfGnqICLYPd8nb/bRP9MREl6EFyPsN+DA+1ezdL25GeE
	 YbOENfb8VRhRVeMu1WhL5vv1Z5nOoW43fQG7U+A4ZZJZcCeETx0E+uvk3ZwVHr0Iw+CUD
	 tNB4FlRZ0yTW+UyoIjOSjkujZNKM4VR+vE/v2nfP0oMrRd8JbWdXpYTOGs6iysuZU/6Fj
	 9Haz0vRjkBtZJaIbZFdgmteAmCQcgxRKKqey9MrG+0WJgRum6DBvfKuweczsJbsw5d9hO
	 12cme1K2+A6NcjEm0NWAJrmxvHWKY7XCxsDe8X7xpDFLvDgvqwMykCdFPMp2D/aGJvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794729757;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=3fQFDkrdsCA7N+Ly9z4DF7jBxsWW1klAti6PabpR7rc=;
	b=yK06bhWLYBOQQ0yYM22cxA1HXuyKCLGzbmD9DOK6efrMz5VkqjDlSk7E+bQDOa1bF4gD
	 fxzHO/FQmSG/zy6SNt8sD/jvoQ6Jv9F3Jl/0M2mFe8E9sXZEzq8ZZu85DcHpZ+dwJSZ3W
	 fg74OYcJYfS8PA0rdaVPURtMZiFKtiscW3hKrMFLlDh1o1pVB8bfVkNn4wbLAqDBRatyR
	 ro8gjsRA7VzxxOOb1kQWYJKnApI3zJWAUzg9BFwWnVvuPGJ9YRGtn8GwBPSFVPX9rpmrI
	 QP7zgaQdVIJLWsyjpxHE5E+bw9pmDp1FKEeUXmylmw0q6TwAYMrqQHw3x4k08hqbZ2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=NxlK0myy;
	arc=none smtp.remote-ip=117.135.210.2
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76786606A8A7;
	Sun, 15 Nov 2026 08:02:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76786606A8A7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=NxlK0myy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=3f
	QFDkrdsCA7N+Ly9z4DF7jBxsWW1klAti6PabpR7rc=; b=NxlK0myy/+HIdUmRzy
	vi5coMGxFaYla/+d3+5mh3ljOcq7FocZ82tEnnLIWSJitEALNVB3VQXZsGWHXEG1
	wW6jyN8ZRQLmd0yY9YgiC9tjDDNxVfs1xycmjvRnUHRE/1WX7ul2WWOOMR2L+Kfg
	Z+lbBv6BpjZzgAy7ExrB8pxKw=
Received: from user-VMware-Virtual-Platform.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3P+EFZ_lqIm43HQ--.51631S2;
	Sun, 15 Nov 2026 16:02:14 +0800 (CST)
From: Ziheng Wei <zihengw03@163.com>
To: Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>
Cc: linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] leds: lm3642: Fix container_of() member confusion in pin attributes
Date: Sun, 15 Nov 2026 16:02:13 +0800
Message-ID: <20261115080213.910112-1-zihengw03@163.com>
X-Mailer: git-send-email 2.43.0
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
X-CM-TRANSID:_____wD3P+EFZ_lqIm43HQ--.51631S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCFyDZw1xKr1xGr47Ary3twb_yoW5Zr45pF
	Z8Ca4Ykrs3tw1kCryDXrWxua4fAF4kAFy3KF48Kw17Zw15Way0qFy5Ka4YyFy5G3yxArnI
	vF45Wryxta1DJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j_o7NUUUUU=
X-CM-SenderInfo: p2lkv0ljzqjqqrwthudrp/xtbC7gbzRGr5ZwaifQAA3y

The strobe_pin and torch_pin sysfs attributes are registered on the
flash and torch LED class devices respectively, but their store
callbacks recover the chip data by container_of() on cdev_indicator.

dev_get_drvdata() in the attribute callbacks returns the led_classdev
that owns the attribute group:

  - strobe_pin is in lm3642_flash_groups, so drvdata is &chip->cdev_flash
  - torch_pin is in lm3642_torch_groups, so drvdata is &chip->cdev_torch

Both strobe_pin_store() and torch_pin_store() however use
container_of(led_cdev, struct lm3642_chip_data, cdev_indicator).

cdev_indicator comes after cdev_flash and cdev_torch in struct
lm3642_chip_data, so the resulting pointer lands before the start of
the structure (by 1536 bytes for strobe_pin and 768 bytes for
torch_pin on x86_64). The callbacks then write chip->strobe_pin or
chip->torch_pin into unrelated memory and pass whatever is found at
the chip->regmap offset to regmap_update_bits().

Writing strobe_pin on an lm3642 instantiated on an emulated I2C
adapter (QEMU, KASAN, v7.3.1) faults the kernel:

  Oops: general protection fault: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN NOPTI
  KASAN: null-ptr-deref in range [0x00000000000000a0-0x00000000000000a7]
  RIP: 0010:regmap_update_bits_base+0x4e/0x1c0
  Call Trace:
   strobe_pin_store+0x15d/0x240 [leds_lm3642]
   dev_attr_store+0x5d/0xc0
   sysfs_kf_write+0xfb/0x180

The other three container_of() users in the driver already pick the
member matching the LED class device they are called for.

Use cdev_flash in strobe_pin_store() and cdev_torch in
torch_pin_store().

Found by LLM-assisted static analysis. Not tested on real hardware;
no in-tree board provides lm3642 platform data.

Fixes: 8b7cfbec052d ("leds: Add new LED driver for lm3642 chips")
Cc: stable@vger.kernel.org
Signed-off-by: Ziheng Wei <zihengw03@163.com>
---

Notes:
    The changelog was drafted with an AI assistant from my analysis;
    I have reviewed the code, the fix and the text.

 drivers/leds/leds-lm3642.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/leds/leds-lm3642.c b/drivers/leds/leds-lm3642.c
index 9af8b8e47..91ea41a7c 100644
--- a/drivers/leds/leds-lm3642.c
+++ b/drivers/leds/leds-lm3642.c
@@ -173,7 +173,7 @@ static ssize_t torch_pin_store(struct device *dev,
 	ssize_t ret;
 	struct led_classdev *led_cdev = dev_get_drvdata(dev);
 	struct lm3642_chip_data *chip =
-	    container_of(led_cdev, struct lm3642_chip_data, cdev_indicator);
+	    container_of(led_cdev, struct lm3642_chip_data, cdev_torch);
 	unsigned int state;
 
 	ret = kstrtouint(buf, 10, &state);
@@ -219,7 +219,7 @@ static ssize_t strobe_pin_store(struct device *dev,
 	ssize_t ret;
 	struct led_classdev *led_cdev = dev_get_drvdata(dev);
 	struct lm3642_chip_data *chip =
-	    container_of(led_cdev, struct lm3642_chip_data, cdev_indicator);
+	    container_of(led_cdev, struct lm3642_chip_data, cdev_flash);
 	unsigned int state;
 
 	ret = kstrtouint(buf, 10, &state);

base-commit: 97d73c8251226cf27cc6656b4c542869bb8c69fa
-- 
2.43.0

