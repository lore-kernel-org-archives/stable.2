Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch [84.16.66.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4D93403F2
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 16:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781798600; cv=none; b=BLvLBdekRT+kyAvj780zXznld0mvCwuNNNXtVFYuM1AsSAKDlzUWXImmhFcw6YPXJmzLnVF5RZ2Pu/ln3fjKS5Pn3Ru/wwkPaLA+TSTx+o3OayqstcS8ubuajd8TL8MVfBBB4BPjyNQXO1nlktfvOOFI1//hGN09NkTXoFgqfwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781798600; c=relaxed/simple;
	bh=4NhTXoOQZEs4cN6xbmxVzuH8Qf9Bn1i/4b+0+fEoDcM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uZeNa1tofslkWdiN8aB6u7kMAbjtN/1+jmWyCtrzQ3auwu1QrDwWncSMQRhoBCC8VWX08H4or9UMSRPA28egYo5863WfaV07wpZNy2oMeOhejwFTtX/bzVLSDONSfv9qbOqKRCgYMOtZTt08T5HlQmhTS+gfcKFrhH2LMksiDLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=0leil.net; spf=pass smtp.mailfrom=0leil.net; dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.b=X1/Emyvh; arc=none smtp.client-ip=84.16.66.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0leil.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.b="X1/Emyvh"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gh59T6ygxzXN4;
	Thu, 18 Jun 2026 18:03:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
	s=20231125; t=1781798589;
	bh=CvD9z9YN4M+/vOXsi6tXS5UgQCp5qSoTR48bj8emK8g=;
	h=From:Subject:Date:To:Cc:From;
	b=X1/EmyvhD6ujMlv6Aeg26+976pX8f0ZRNDzK7W1azwHh1H5FOXxH3/DjRA/PF2eN5
	 mrcBorvPsqDeO4GurIPVIZIEF8tubwbcnwCFLT4yUPka0seUnUpBNos/dcgNzoBo+s
	 rQV+oP8ZSOTLFKvrm1FK+AioA1kjBA7Z9N2Ut9Gw9etU13gI1O7UZoEBzH8wNiv8fg
	 28r1MR/5vWy2I1nZSd9nEKGC7nYM+ic6Ffw2ddf5Jdy8oCQCx3hACc5iMDYpa6b+n/
	 ZTZCoACU7ZJMQ6XnqQWhtwG7hhoHqhcSJWwgoB8dsQ17oxGZYXXWAHqnHkW2emTWUx
	 opTTwGgNhvIjw==
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4gh59S03xCz5nn;
	Thu, 18 Jun 2026 18:03:07 +0200 (CEST)
From: Quentin Schulz <foss+kernel@0leil.net>
Subject: [PATCH 6.12.y 0/3] gpiolib: backport 16fdabe143fc
Date: Thu, 18 Jun 2026 18:02:50 +0200
Message-Id: <20260618-6-12-cve-2026-31732-v1-0-7ca0d0b906b0@cherry.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQ6CMBAAv0L27JLuNmyNXzEepCywHtC0SCSEv
 1v0OJPMbJA1mWa4VBskXSzbcypApwrieJ8GResKAzsWJ3RGQWKMi+Jh0FPwjOJdkK4hCeyglK+
 kvX1+1ytITVyvcPv7/G4fGudjCfv+BZVCl2x/AAAA
X-Change-ID: 20260618-6-12-cve-2026-31732-63076d516720
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
 Tzung-Bi Shih <tzungbi@kernel.org>, stable@vger.kernel.org, 
 Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-47773
X-Infomaniak-Routing: alpha

Backport 16fdabe143fc ("gpio: Fix resource leaks on errors in
gpiochip_add_data_with_key()") to 6.12.y. To make the git diff more
similar with the upstream commit, also backport 375790f18396 ("gpiolib:
Extract gpiochip_choose_fwnode() for wider use") and 550300b9a295
("gpiolib: Remove redundant assignment of return variable").

The changes between 16fdabe143fc and the third patch of this series is
(according to git-range-diff):

"""
      ## drivers/gpio/gpiolib.c ##
     @@ drivers/gpio/gpiolib.c: static const struct device_type gpio_dev_type = {
    @@ drivers/gpio/gpiolib.c: int gpiochip_add_data_with_key(struct gpio_chip *gc, voi
     +	}
     +
     +	gdev->can_sleep = gc->can_sleep;
    -+	rwlock_init(&gdev->line_state_lock);
    -+	RAW_INIT_NOTIFIER_HEAD(&gdev->line_state_notifier);
    ++	BLOCKING_INIT_NOTIFIER_HEAD(&gdev->line_state_notifier);
     +	BLOCKING_INIT_NOTIFIER_HEAD(&gdev->device_notifier);
     +#ifdef CONFIG_PINCTRL
     +	INIT_LIST_HEAD(&gdev->pin_ranges);
    @@ drivers/gpio/gpiolib.c: int gpiochip_add_data_with_key(struct gpio_chip *gc, voi
     -	gdev->ngpio = gc->ngpio;
     -	gdev->can_sleep = gc->can_sleep;
     -
    --	rwlock_init(&gdev->line_state_lock);
    --	RAW_INIT_NOTIFIER_HEAD(&gdev->line_state_notifier);
    +-	BLOCKING_INIT_NOTIFIER_HEAD(&gdev->line_state_notifier);
     -	BLOCKING_INIT_NOTIFIER_HEAD(&gdev->device_notifier);
     -
     -	ret = init_srcu_struct(&gdev->srcu);
    @@ drivers/gpio/gpiolib.c: int gpiochip_add_data_with_key(struct gpio_chip *gc, voi
     @@ drivers/gpio/gpiolib.c: int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
      		ret = gpiodev_add_to_list_unlocked(gdev);
      		if (ret) {
    - 			gpiochip_err(gc, "GPIO integer space overlap, cannot add chip\n");
    + 			chip_err(gc, "GPIO integer space overlap, cannot add chip\n");
     -			goto err_cleanup_desc_srcu;
     +			goto err_put_device;
      		}
"""

s/gpiochip_err/chip_err/ aside, the rest of the diff comes from feature
commits which do not fit the rules for backporting to stable.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Andy Shevchenko (2):
      gpiolib: Extract gpiochip_choose_fwnode() for wider use
      gpiolib: Remove redundant assignment of return variable

Tzung-Bi Shih (1):
      gpio: Fix resource leaks on errors in gpiochip_add_data_with_key()

 drivers/gpio/gpiolib.c | 156 +++++++++++++++++++++++++------------------------
 1 file changed, 79 insertions(+), 77 deletions(-)
---
base-commit: 1d3a00d3bacff25652c96e1527610c69e91f7c38
change-id: 20260618-6-12-cve-2026-31732-63076d516720

Best regards,
--  
Quentin Schulz <quentin.schulz@cherry.de>

