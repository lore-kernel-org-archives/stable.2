Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch [45.157.188.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FF42EDD69
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 16:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781800465; cv=none; b=JAeVzePALByzT13JHJD57OzFNK++w6tvuz0clrMtIsI3OBJ6ra3ugUhH5FXcFcYsOhkVsM9KnGvSsbGvocwRZldhKxZFBvT28R25WxJKE9cCQhcwxTP50WT4OVtjLDCF2o2Macn0KjluzOQav9h8eZWmibLxVDjPXco1q5BnG6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781800465; c=relaxed/simple;
	bh=sH4Ke66JIpnc0MZHo3EIyfu1ZYY+mgAZrrnNVgq4yPg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rxjjK+ZTNHeTKU6fD5u+Kwmx0c+4chz3KE3dC8MDW/82LENzwiV5gJYmQZH1rQYQNLoK/Yyl0AW8ntDiEdpogHSMru2NQ+5vKh2Y1of/6WurwChdPn7di/reCHvvEFIgo0QqeVm5UKyympbIrFs4a1rWO1qRZFxAXFvDNuhTQ0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=0leil.net; spf=pass smtp.mailfrom=0leil.net; dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.b=nJsKeg+G; arc=none smtp.client-ip=45.157.188.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0leil.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.b="nJsKeg+G"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gh5sN2wKGzrD2;
	Thu, 18 Jun 2026 18:34:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
	s=20231125; t=1781800456;
	bh=PHAWjs2Y1yJ4pF784Wz2QgiwURvcLQMB3ILixgzZUmg=;
	h=From:Subject:Date:To:Cc:From;
	b=nJsKeg+Gzquz90VmPRmUQAvcfpXfE0vRjqm75lM0E2WISsTFpnXqzjWRMd6sb+sPp
	 HwrQ88ezCGzaSD7gYQE2Mz1v6s/NWpwAdV5FqsBA1SxQ1Rpf5jnBMP+MJO4cCbKhH8
	 rPlBwjvMPGpWDHmWXvcr5RUULkEPNy4t6ACdF+WhA0DO7chnFXzr7d+jK9ePrjfOM2
	 Lq9j4xMDApRj9ifDJxdv67AIFrqi5h8VUXMuDkzimwJZpjlVOklIEkaCR3UODZanPh
	 QuizTgRE3se7mnq4j7GhyCNR9H/xuc02/fEOMZ6W1A3M9odtyT3c5yLNL1LIn+TO8C
	 xABidE4dW2z/A==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4gh5sL3fJDzhjJ;
	Thu, 18 Jun 2026 18:34:14 +0200 (CEST)
From: Quentin Schulz <foss+kernel@0leil.net>
Subject: [PATCH 6.12.y v2 0/3] gpiolib: backport 16fdabe143fc
Date: Thu, 18 Jun 2026 18:34:00 +0200
Message-Id: <20260618-6-12-cve-2026-31732-v2-0-42cc54b7bf04@cherry.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NwQ6CMBBEf4Xs2SW7JW7Vk/9hOEC7Sj2AabGRE
 P5dwLvHmbx5M0PSGDTBpZghag4pDP0azKEA1zX9QzH4NYMhIyR8QkE26LLi1mDFtjIoFVnxRxZ
 rCNblK+o9fHbrDaRkU05Q//r0bp/qxk25kV1I4xCn/T7zzv99yoyE1jXkqT2TtHR1ncY4lV6hX
 pblC/IaTQTQAAAA
X-Change-ID: 20260618-6-12-cve-2026-31732-63076d516720
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 stable@vger.kernel.org, Quentin Schulz <quentin.schulz@cherry.de>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
 Tzung-Bi Shih <tzungbi@kernel.org>, Linus Walleij <linusw@kernel.org>, 
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
Changes in v2:
- added stable@vger.kernel.org in Cc, apologies for the noise.
- Link to v1: https://patch.msgid.link/20260618-6-12-cve-2026-31732-v1-0-7ca0d0b906b0@cherry.de

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

