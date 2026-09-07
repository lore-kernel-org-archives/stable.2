Received: from mail-06.mail-europe.com (mail-06.mail-europe.com [85.9.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD554F6463;
	Mon,  7 Sep 2026 14:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788792704; cv=none; b=unLumiJfmF/8a7pHqJSQeXj3uIaxvFVZqib//lW+0FjyF6GCB09IFt3llvf+l2s2Ho707kJvoOQ9fqZ7Oma+4eH1Z6t0jHVTpUMsSCHX8chh9qOkkMkqcNnWoDxTz5vTiI3bsUtHNSwjDF8UaS3wP2NocdiSKLCxJ6ul7DYMwys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788792704; c=relaxed/simple;
	bh=PgUA3dIZLhRkI57kRZs2fKBBK1RRyr21AN3eZ5vODo8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ncv+Tj6eeHeS6rFfeKF8rzsiz6IYT5VURaHsNk7lGJTHDE2RtLLS30E1gzKfLcbXvDwlML1ng2b+5HMK8Sfv/6UNeLpjdByZUZfg1a4y1RGor0fnQHyhs88I7Zcm0Vx+qbcdzf/JuesQ7Tn/WLF9DGziLKEQAHRQIFa6d+D4sz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=G/lLmX1g; arc=none smtp.client-ip=85.9.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="G/lLmX1g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1788792671; x=1789051871;
	bh=6A90I0UJx58zIViMJiJpywUxA4OyKvBeb0uSB24Qrz0=;
	h=From:Subject:Date:Message-Id:To:Cc:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=G/lLmX1g1DKjUOpg5bSJrolB+EBHsiLwKEYhNDvjAVUteZUv6vocj0CeF147gZEQm
	 2JE6SxznLypQIzESGwkE32Q/w6YNTVtG2dkP3mAT70eRLI1CVBcIZxbyL/W1JdEAuT
	 gl2MNDKs1wSytToAGVgvHGvEaZhcn66qgyDXfd2ejHehYFLRrh33/y4HFM0W8ngvVx
	 QXbIuTLaJeo8HYzR6YlQaMyovv8pc9uQzen8wXwfiw3JguwjASYyHj9zZG7CeDB2kg
	 PB/R3PMzMzoKri8hhTIgYLaFluFbyh3aJCHZwaZ2pY+WH6k4ivn94UZs2PeMVCTVvA
	 F28E7t6kMI3rw==
X-Pm-Submission-Id: 4hdqkx6mmkz1DFGT
From: Esben Haabendal <esben@geanix.com>
Subject: [PATCH v8 0/9] io: accel: mma8452: Allow open drain interrupt pin
 configuration
Date: Mon, 07 Sep 2026 16:50:55 +0200
Message-Id: <20260907-mma8452-open-drain-v8-0-c17407e22118@geanix.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XRTU7EMAwF4KuMsibIce38sOIeiEWapDNZtB21K
 AKNendSNhQ1EivLi/dJz36INS05reLl8hBLKnnN81QX+3QR4eana5I51l0gIAOBkuPoLTHK+Z4
 mGRefJ2kVGxNIdYaDqMFbXj/m5evHLKqOtz2uwShuxYuSIHsVI3oiCBper8lP+fM5zKN4r17B/
 w2shuM+uYEHMo5PRvdrWGgbXTW0IjcQaE/gTgYdDIVNg/YuQ/CKI2DPZ4OPhmsaXI1ovWcH0YR
 Onwx9MLDdRe/36JHRAqVkzzc1B6NrvrWYaiA60rVscGj/GNu2fQMmaGXzPQIAAA==
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
 stable@vger.kernel.org, Joshua Crofts <joshua.crofts1@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788792664; l=4958;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=PgUA3dIZLhRkI57kRZs2fKBBK1RRyr21AN3eZ5vODo8=;
 b=OVOgOxz9cEwR9id4rSAuRkJJqStcS2QGCV0t6/T1SZtNWTHRNmhNKXRcOQjARh/wJ0SI7sjYc
 0zKDRG2B/BmDntXmZZjkk5h5Qew4tLYlfT8GgkaCebQeb3F6nu8Wojr
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

Extend the mma8452 driver with support for configuration of the
interrupt line in open-drain mode, which is needed for hardware designs
where the interrupt line is shared with other chips.

Adding drive-open-drain property to mma8452 device-tree node for such
designs to enable switching pin configuration to open-drain mode.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
Changes in v8:
- Move patch 7 (with Fixes: ...) to go before the non-fixes patches.
- Rebased from v7.3-rc1 to current iio/togreg branch.
- Drop patch 8 (identical patch from Sanjay Chitroda already in togreg
  branch).
- Add new patch fixing a strangely extra indentation of a comment block.
- Add new patch adding documentation for struct mma8452_data.
- Move patch 4 to last in series, and rework the synchronization between
  suspend/resume and interrupt handler.
- Link to v7: https://patch.msgid.link/20260831-mma8452-open-drain-v7-0-22946812c928@geanix.com

Changes in v7:
- Use dev pointer directly in mma8452_runtime_suspend() also.
- Move struct i2c_client *client definition to patch 4.
- Drop patch 7 (Drop unneeded lock acquire on read).
- Link to v6: https://patch.msgid.link/20260825-mma8452-open-drain-v6-0-9b252804ee80@geanix.com

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
      iio: accel: mma8452: Fix use-after-free bug in error error path
      iio: accel: mma8452: Optimize struct mma8452_data member orders
      iio: accel: mma8452: Only apply trigger type when not set by firmware
      iio: accel: mma8452: Fix unintended comment indent
      iio: accel: mma8452: Add comment block for struct mma8452_data
      iio: accel: mma8452: Allow open drain interrupt pin configuration
      iio: accel: mma8452: Use proper error code when missing device model
      iio: accel: mma8452: Support interrupt sharing

 .../devicetree/bindings/iio/accel/fsl,mma8452.yaml |   6 +
 drivers/iio/accel/mma8452.c                        | 165 +++++++++++++++++----
 2 files changed, 141 insertions(+), 30 deletions(-)
---
base-commit: 309bd01041636b587bcb424b243640b448bd62f7
change-id: 20250401-mma8452-open-drain-81577c41375c

Best regards,
--  
Esben Haabendal <esben@geanix.com>

