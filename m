Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch [185.70.43.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0513E51D4
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 12:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788178637; cv=none; b=KyQHbCQEvFfZKxdMPnaH7jTRQLlg5LZ9LyI4QNxof1VSzJlh3Hkz4nGrx5A2qYGFk3ZlJTiyDN3BuGgP6drebn4VzMMRXbC7SRP4wTzoTsmOuhsHutjQWSlQij4QRHzl2WgwMzCS1nzq4lcBIytLEIBQV4eY0uu531WOlWHf9as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788178637; c=relaxed/simple;
	bh=M5SL/h42yWAk4NKd3VQ/etF+/h7oCMnnc0yG4sXazU4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SXuJNu97C/4kG9ND8N2gdh3Iq47LR3GYGExdFWXhurDANS7JrLnUylagUb2V+NN5MtS7nsHhJqWcj5okXCaHPZ+dBxFf9RAd8bVFgkgHDbuLOo7jnd7B++bp8O/0iIQjCWIRD0j6dHN2TEpDyBxKq4uGfBeCOWoce/Q3WgAONKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=hmWN9Yhe; arc=none smtp.client-ip=185.70.43.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="hmWN9Yhe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1788178631; x=1788437831;
	bh=ZY1JPctQtuxLv8PjzYWWaNHnTJKlkk+4wWRVrTLoCHg=;
	h=From:Subject:Date:Message-Id:To:Cc:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=hmWN9YhecnW9VX+qtqjQno79cnqOl3GdIMzIRGSihLKvMDenF+CKhNwvKnFoGZpXW
	 JrUnPVLBlGoLivHVdBh+tHTWNuc0TwOhM307Zs3HAzMfoL+TNmlztcMe+7fvfEGM3N
	 adA4XN2F7unGNZ+sUXMf35bYTqTNeN89j6z4S4VLQ6jkFFZ2/WPh7pFQmpAGUeeHRN
	 l1A5qQB82bO+1WGM5GoHo+R0wGE/Gn69QHaBfWurQW5nrnNdHwnN/vOqztidvvccgn
	 YQiEn+fxKXsS/1NRpmb8cSZBYpR3K7+KD+j/CVPpZr39o20BhIXdASvQ0oO9qfAguC
	 CTiY5Y4xoldUQ==
X-Pm-Submission-Id: 4hYSfX6wY5z1DDXH
From: Esben Haabendal <esben@geanix.com>
Subject: [PATCH v7 0/8] io: accel: mma8452: Allow open drain interrupt pin
 configuration
Date: Mon, 31 Aug 2026 14:17:03 +0200
Message-Id: <20260831-mma8452-open-drain-v7-0-22946812c928@geanix.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XQPWrEMBAF4KssqqMwGs/oJ1XuEVLIkryrwvJiB
 5Ow+O6R08TBglTDK94Hbx5iSXNOi3i5PMSc1rzkqdRgni4i3Hy5JpljzQIBGQiUHEdviVFO91R
 knH0u0io2JpDqDAdRi7e8fEzz14+5qnre9roGo7hVX5UE2asY0RNB0PB6Tb7kz+cwjeK9eiv+b
 2A1HPfJDTyQcXwyul/DQtvoqqEVuYFAewJ3MuhgKGwatG8ZglccAXs+G3w0XNPgakTrPTuIJnT
 6ZOiDge0tev9Hj4wWKCX796fbtn0DHIjfdPkBAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788178627; l=4328;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=M5SL/h42yWAk4NKd3VQ/etF+/h7oCMnnc0yG4sXazU4=;
 b=f7RJGTl021HJwFLFre8rRN0A9iwzoCVvkdvGb3Gfn3a2CRNZMgeh6MXeCoMoP/QHQcGpKOGya
 YED1Nr6dP4kDo9+15hPaAvQP8eGKI1uzienau9WfLKp/hfe/Bzexa94
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

Extend the mma8452 driver with support for configuration of the
interrupt line in open-drain mode, which is needed for hardware designs
where the interrupt line is shared with other chips.

Adding drive-open-drain property to mma8452 device-tree node for such
designs to enable switching pin configuration to open-drain mode.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
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
Esben Haabendal (8):
      dt-bindings: iio: accel: mma8452: Add drive-open-drain
      iio: accel: mma8452: Optimize struct mma8452_data member orders
      iio: accel: mma8452: Only apply trigger type when not set by firmware
      iio: accel: mma8452: Support interrupt sharing
      iio: accel: mma8452: Allow open drain interrupt pin configuration
      iio: accel: mma8452: Reuse existing dev pointer in mma8452_probe()
      iio: accel: mma8452: Fix use-after-free bug in error error path
      iio: accel: mma8452: Use proper error code when missing device model

 .../devicetree/bindings/iio/accel/fsl,mma8452.yaml |   6 ++
 drivers/iio/accel/mma8452.c                        | 115 ++++++++++++++++-----
 2 files changed, 94 insertions(+), 27 deletions(-)
---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20250401-mma8452-open-drain-81577c41375c

Best regards,
--  
Esben Haabendal <esben@geanix.com>

