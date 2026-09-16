Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch [185.70.43.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0783144C662;
	Wed, 16 Sep 2026 08:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789546181; cv=none; b=V9M+2WN+pftFgjHgASyM0dp/Jv2Vca4GEj3UdHXSQoR97eLG/gbV9A9NQEPsyn55KjPVfexqMc9k1SO8Lb5coZh5IvtnNrmQ/hUZT57FspOsBwWE2dcOI8BHg1ebgODSs68VmI/bsmiujpDviUioXYVTYPe076FreA0PD/HBtH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789546181; c=relaxed/simple;
	bh=oVCEER8qAQeZI62PA2aJdqsdaDB9MEvfnrpyzbthUNQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XXkjAA6YmGZrS0EiZHjNrJWmgfq7cNbiPBYt5FppcH/+zj5mlt9Gl8nUGLbC51PVSO/rovEwszhrmuDT+hxwb8So1dKMdMCSsl3XJYkQe27Qx1uFC+Ak8OfYnggURyd4VdMmhTE1J1+A4OGZ1CrgzJw0Ahb1fOwTs/3heMjy5u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=E3Wna2CB; arc=none smtp.client-ip=185.70.43.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="E3Wna2CB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1789546160; x=1789805360;
	bh=sYFhmye3GW5XiNBGJvP0ms0gl7OikdMFHxiPnj1A690=;
	h=From:Subject:Date:Message-Id:To:Cc:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=E3Wna2CBimJnzrX51j8ZytY6mo8n1zlSb/mjhfIRVhDR7WIg9eJ0MOzJAX7Hn1krq
	 ukukcL9A+/UrI8Q2dmrNyDYBwOyGXgxTlHonemAwWI0ujSZgw2QIgQxgmlPUjOc0AY
	 XB/U0YolFW9inh0hUmVV9MJxgi0Dr/Un/7gtjVluyH/PS0t5evR0tVQpD3QV8MEnfG
	 qPnobdvyFeHJpI22ckoueFB3t9Oc1QeZBSj1XXVlIm/CxiFkmUVyNwmt4RT4wRlsQ+
	 78O9n7DlA9rGyrI6cXICDmVS101vejJsN04Lx2AN+U6Wg6B+bD4yvpttVXN+CpHwu8
	 +Xknu2PJkKucA==
X-Pm-Submission-Id: 4hlBPB0YKKz2ScNZ
From: Esben Haabendal <esben@geanix.com>
Subject: [PATCH v9 00/10] io: accel: mma8452: Allow open drain interrupt
 pin configuration
Date: Wed, 16 Sep 2026 10:07:56 +0200
Message-Id: <20260916-mma8452-open-drain-v9-0-0dd24fa2f3d7@geanix.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XRPW7DMAwF4KsEmquCpEn9dOo9ig6yJCcaYhd2Y
 bQIfPcqXeLCAjoRHN4HPPKmljyXvKiX003NeS1Lmca6+KeTipcwnrMuqe6KgAQYUF+vwbGQnj7
 yqNMcyqgdirWRsbMSVQ1eyvI5zd+/5op1vN3jBixKK76iBt1jShSYIRp4Pecwlq/nOF3Ve/VW+
 t+ganjpsx9kYOvlYHQPw0Hb6KphkP3AYAKDPxi8M5CaBt+7DDGgJKBejobsDd80pBrJhSAeko2
 dORhmZ1C7i7nfoychB5yzO97U7oyu+dbVVoPIs6lloyd3MNzD8GCbhqtGRMtgMxHiX2Pbth9Ck
 VWQgQIAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789546157; l=5803;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=oVCEER8qAQeZI62PA2aJdqsdaDB9MEvfnrpyzbthUNQ=;
 b=m5lEJ4HYB9w9CTyxdI5942WLF/7b0TsUn1TF0Tqhrf7ZLR4Q5OpzUiAzLYcZ1DOgy7a6oOeKu
 cei1HrnoAJpB3QLV1/Q3PbfPG7oojJ8VhkA8W0Sdvg6bfM5JK0dyz50
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

Extend the mma8452 driver with support for configuration of the
interrupt line in open-drain mode, which is needed for hardware designs
where the interrupt line is shared with other chips.

Adding drive-open-drain property to mma8452 device-tree node for such
designs to enable switching pin configuration to open-drain mode.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
Changes in v9:
- Fix documentation of voltage regulator field(s) in struct mma8452_data
  kernel-doc block.
- Fix a couple of nitpicks in struct mma8452_data kernel-doc block.
- Switch to STANDBY mode before writing to CTRL_REG4.
- Add patch fixing runtime PM bugs in mma8452_read().
- Add comment about handling of -EINVAL return value from
  pm_runtime_get_if_active() in mma8452_interrupt().
- Fix for race between mma8452_remove() and mma8452_interrupt(), by calling
  free_irq() before pm_runtime_disable() instead of after.
- Fix mixing of guards and goto in mma8452_runtime_suspend(). Using guards
  will be re-introduced later on, when mixing can be avoided.
- Link to v8: https://patch.msgid.link/20260907-mma8452-open-drain-v8-0-c17407e22118@geanix.com

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
Esben Haabendal (10):
      dt-bindings: iio: accel: mma8452: Add drive-open-drain
      iio: accel: mma8452: Fix use-after-free bug in error error path
      iio: accel: mma8452: Fix runtime PM bugs in mma8452_read()
      iio: accel: mma8452: Optimize struct mma8452_data member orders
      iio: accel: mma8452: Only apply trigger type when not set by firmware
      iio: accel: mma8452: Fix unintended comment indent
      iio: accel: mma8452: Add comment block for struct mma8452_data
      iio: accel: mma8452: Allow open drain interrupt pin configuration
      iio: accel: mma8452: Use proper error code when missing device model
      iio: accel: mma8452: Support interrupt sharing

 .../devicetree/bindings/iio/accel/fsl,mma8452.yaml |   6 +
 drivers/iio/accel/mma8452.c                        | 201 +++++++++++++++++----
 2 files changed, 167 insertions(+), 40 deletions(-)
---
base-commit: 746ce4dd0ea41825a1dfa5e9d8c22e46a4cf7101
change-id: 20250401-mma8452-open-drain-81577c41375c

Best regards,
--  
Esben Haabendal <esben@geanix.com>

