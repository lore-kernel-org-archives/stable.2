Received: from mail-244108.protonmail.ch (mail-244108.protonmail.ch [109.224.244.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2653DFC6B
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 08:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787646490; cv=none; b=tb7eqTaZYiEDLb7UJ3vVg+NVt8XDcNs/6mG3Ym09+u5GliMgIg3RvlSVsbmNF9QuGhgBkittK7TJ0Q+bmXEL6wnRO2r4q/GXweyuqanXqtw0vRi/TwZ+0trjMZalY25zZA+wtws9TgrBkxYhV1D/Ey+ZHZhUxzoP/2PxCrEiv/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787646490; c=relaxed/simple;
	bh=7o4o8NWUJ9a0OPqrlPa7u0FGma6dG481OaPzo7s1HYE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=h1j3QaaWDuyub2orKuitz+9ze4TUiz0+chQWLie7qbgEFxnTrmmPiOpeWHGJ8Y5o60k6XmcK0GzuZVoQ6zOEbnz0vus5dRcHuLcknwwQxZCXzM+oqgiAkIv8DDsnl2f0cYFr7pRqeBwid9O1/u2dbz9CDxt9MceAjokVB2q1IYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=SFrLdwnf; arc=none smtp.client-ip=109.224.244.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="SFrLdwnf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1787646475; x=1787905675;
	bh=bN6NGST5nqQMAuJJgM0Z1E4k8V5HM8Vlscxdz3Ur49Q=;
	h=From:Subject:Date:Message-Id:To:Cc:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=SFrLdwnf//DOVFriipWcnZEvThYbSaYg5Lko5kIVJVxQs9EXcYts3tE9TN5soit6y
	 /R2ZI/L/A4uGYwxE3+VNgNdiSKNR23odqruj/7H97oVWCSiXpevsnpsQbeCaQ0fWwx
	 t1s+it+aEmJIyB9qxySdKcAHFZPqbrXm0x1EB1BkqJBSs5Crj3ySrqw6QcwdOpeoNQ
	 +yVHkhx+ve0Fm8s/jXgbF9DvZ2ebZdyRC6NlnbWVWCjEwQOyyznsCpPqItFwx2LEgO
	 f0xqgN8ifypeZsmra/f/fVq4ZT/jgVJkUhZXKQTIaPqXLwio+csiV57QPNLPeTNE+k
	 ffcLWXH/iGQIQ==
X-Pm-Submission-Id: 4hTgrl6ZcMz2ScmH
From: Esben Haabendal <esben@geanix.com>
Subject: [PATCH v6 0/9] io: accel: mma8452: Allow open drain interrupt pin
 configuration
Date: Tue, 25 Aug 2026 10:27:38 +0200
Message-Id: <20260825-mma8452-open-drain-v6-0-9b252804ee80@geanix.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XPwWrDMAzG8VcpPs9DciQ73mnvMXpQbKf1IU5JR
 tgoefe6vbQjgZ3Ed/j/QFc1pymnWX0crmpKS57zWOqwbwcVzlJOSedYtzJgGAhQD4O0xEaPl1R
 0nCQX3SI7Fwgbx0HV8Jzn73H6fZgL1vN1zy045L18QQ26wxiNEEGw8HlKUvLPexgHdazeYv43T
 DU8d8n33JPzvDGap9HCvtFUwyL5nsAKgd8Y9GKg2TXo/ksfBDmC6Xhr8Kvhdw2uRmxF2EN0obF
 /jHVdbx8DAqS1AQAA
X-Change-ID: 20250401-mma8452-open-drain-81577c41375c
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Martin Kepplinger <martink@posteo.de>, 
 Sean Nyekjaer <sean@geanix.com>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Martin Kepplinger <martin.kepplinger@theobroma-systems.com>, 
 Christoph Muellner <christoph.muellner@theobroma-systems.com>
Cc: Esben Haabendal <esben@geanix.com>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787646470; l=4102;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=7o4o8NWUJ9a0OPqrlPa7u0FGma6dG481OaPzo7s1HYE=;
 b=6nito2Wwt04aSrWJeRLxHKGPIBZ/wOB/yXmQ6acsy3yuATIdh1wXQgjxB0DkHmertewAq32dJ
 z9idl8u5JzZArhNyhHf1HrhqfXPnh5gmmM89RyzcNn6COlR2GmfQLwa
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

Extend the mma8452 driver with support for configuration of the
interrupt line in open-drain mode, which is needed for hardware designs
where the interrupt line is shared with other chips.

Adding drive-open-drain property to mma8452 device-tree node for such
designs to enable switching pin configuration to open-drain mode.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
Changes in v6:
- Prevent interrupt storm if runtime suspend fails to set the device in
  standby mode by not setting suspended flag to true when failing to
  activate standby mode and by ensuring PM counter is not leaked in
  mma8452_interrupt().
- Don't acquire data->lock in mma8452_read_raw().
- Add fix for use-after-free in mma8452_probe() error path when CONFIG_PM
  is enabled.
- Fix (brown paper bug) build error introduced in v5.
- Renamed label in mma8452_interrupt().
- Add patch to return -ENODATA when missing device model information.
- Link to v5: https://patch.msgid.link/20260819-mma8452-open-drain-v5-0-d8aa590d7c36@geanix.com

Changes in v5:
- Squashed dev_err_probe() call to one line.
- Fixed typo in patch 2 title.
- Added synchronization between runtime suspend and interrupt handler.
- Link to v4: https://patch.msgid.link/20260812-mma8452-open-drain-v4-0-bfca15d02b59@geanix.com

Changes in v4:
- Fixed interrupt handler to check runtime PM status before trying to
  access the chip.
- Split open-drain support and interrupt sharing into separate patches.
- Added new patch to reuse existing struct device * through mma8452_probe()
  function.
- Print warning message when irq type is not set by firmware.
- Link to v3: https://patch.msgid.link/20260805-mma8452-open-drain-v3-0-6149f406a409@geanix.com

Changes in v3:
- Reordered patches, swapping #2 and #3.
- Always add IRQF_SHARED flag.
- New patch to change it so IQRF_TRIGGER_LOW flag is only added when no
  trigger type is set by firmware.
- Link to v2: https://patch.msgid.link/20260715-mma8452-open-drain-v2-0-95be9f5f4795@geanix.com

Changes in v2:
- Commit message of patch 2 updated.
- Operator precedence bug fixed in flags argument to
  request_threaded_irq().
- Always check return value of mma8452_set_interrupt_pin_mode(), and just
  check for non-zero value.
- Added new patch with optimization of struct mma8452_data ordering.
- Link to v1: https://patch.msgid.link/20260715-mma8452-open-drain-v1-0-b1dd2a440c60@geanix.com

To: Jonathan Cameron <jic23@kernel.org>
To: Lars-Peter Clausen <lars@metafoo.de>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Martin Kepplinger <martink@posteo.de>
To: Sean Nyekjaer <sean@geanix.com>
To: David Lechner <dlechner@baylibre.com>
To: Nuno Sá <nuno.sa@analog.com>
To: Andy Shevchenko <andy@kernel.org>
To: Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
To: Christoph Muellner <christoph.muellner@theobroma-systems.com>
Cc: linux-iio@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Esben Haabendal (9):
      dt-bindings: iio: accel: mma8452: Add drive-open-drain
      iio: accel: mma8452: Optimize struct mma8452_data member orders
      iio: accel: mma8452: Only apply trigger type when not set by firmware
      iio: accel: mma8452: Support interrupt sharing
      iio: accel: mma8452: Allow open drain interrupt pin configuration
      iio: accel: mma8452: Reuse existing dev pointer in mma8452_probe()
      iio: accel: mma8452: Drop unneeded lock acquire on read
      iio: accel: mma8452: Fix use-after-free bug in error error path
      iio: accel: mma8452: Use proper error code when missing device model

 .../devicetree/bindings/iio/accel/fsl,mma8452.yaml |   6 ++
 drivers/iio/accel/mma8452.c                        | 117 ++++++++++++++++-----
 2 files changed, 94 insertions(+), 29 deletions(-)
---
base-commit: db2ddb87143519e20a95aa36c60b36107b736a58
change-id: 20250401-mma8452-open-drain-81577c41375c

Best regards,
--  
Esben Haabendal <esben@geanix.com>

