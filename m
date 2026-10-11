Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5F02AD03;
	Sun, 11 Oct 2026 13:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791723641; cv=none; b=X7EDNp939o9iseCl2rnbxmR1xjN5fgZb7ySjlY4X5mJTEXcb8c2JyAQGpWuCebAzU0JWCrvYHJi6VOqxIid6kECSAw8Nq0wJZWzUUIov1L3x9rfkBmpLi2b1oB/qjeaPCuidAw2JzsjhspU2qOkBImGakqSPjKMENAhy7idu1vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791723641; c=relaxed/simple;
	bh=9hCbvebX07T1xMNBPfXkhv3YYnJ9FnbtZpO2VDmZ6+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eRe3N7puJKBaQexngOYnz0tQPiuk58WME2Ljf4jXczRbyZ2pdHroefmuTfl9lrzUnjXpzAvVDxY59CvjhyNN1js8oMSHF0lWgUxHsTSsTXubQcWKVRBXinCwFjuVCepFFJA1fLt2z32dYEy2zSnIO8/RP4KYRrKbALPB/IgYpHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gh7X10kC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gh7X10kC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B07B1F0089B;
	Sun, 11 Oct 2026 13:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791723635;
	bh=HOVFcYsFJGykwM1UIUyp356S3MbI3P/ysIg/n3jF1t0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Gh7X10kC9s5QetyYxRL7bersQrcWPQ1UcpetnsF4p4gq6EIXjD3ZLmY7b6vac/eho
	 Ii7qfT6D8Uw8xP3XV/xs2bOzgedtgrpefPLTB9WfCJxfCqoXMgQQYE8c/EadQzpG0W
	 iiybCUNVOZOC5tGMTTgi1aZxiU1dnI45KAAPs271aQ97gLBFN3zhI27Z0zqeixR7Hy
	 xI/5PCifPMuiLJENzOB/4QkbPcjlMVRJO7h405F0nGFrDpuKyLOwjZmq+zapvtBMCY
	 5PT5n/NAQsbZPe7kX/IdKLsDIt5j5+Ap0EuycrYZTQ4NKrjHBkL/CGdny9WG6WzwT6
	 HJniuhO5owePQ==
Date: Sun, 11 Oct 2026 14:00:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Esben Haabendal <esben@geanix.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Martin Kepplinger <martink@posteo.de>, Sean Nyekjaer
 <sean@geanix.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Martin Kepplinger <martin.kepplinger@theobroma-systems.com>, Christoph
 Muellner <christoph.muellner@theobroma-systems.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, Joshua Crofts
 <joshua.crofts1@gmail.com>, Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v10 00/10] io: accel: mma8452: Allow open drain
 interrupt pin configuration
Message-ID: <20261011140002.6e9d68d3@jic23-hlaptop>
In-Reply-To: <20260928-mma8452-open-drain-v10-0-b906fb408386@geanix.com>
References: <20260928-mma8452-open-drain-v10-0-b906fb408386@geanix.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 28 Sep 2026 10:26:16 +0200
Esben Haabendal <esben@geanix.com> wrote:

> Extend the mma8452 driver with support for configuration of the
> interrupt line in open-drain mode, which is needed for hardware designs
> where the interrupt line is shared with other chips.
>=20
> Adding drive-open-drain property to mma8452 device-tree node for such
> designs to enable switching pin configuration to open-drain mode.
>=20
> Signed-off-by: Esben Haabendal <esben@geanix.com>

Applied patches 1-9 to the testing branch of iio.git.
As mentioned, I think 10 needs a bit more review time.

We may loose sashiko coverage. In theory you can tell it about
dependencies, but I'm not sure how that works with a temporary
testing branch.=20

There are some notes on using message-id: tags in the cover
letter in https://b4.docs.kernel.org/en/latest/contributor/prep.html

I gather from the LPC session last week that sashiko should work
with those now.

Jonathan
=09
> ---
> Changes in v10:
> - Fix sp3ling mistake in struct mma8452_data kernel-doc block.
> - Swap ordering of pm_runtime and irq setup in mma8452_probe() to match t=
he
>   order now used in mma8452_remove().
> - Bail out on -EINVAL in mma8452_interrupt() when CONFIG_PM is enabled.
> - Link to v9: https://patch.msgid.link/20260916-mma8452-open-drain-v9-0-0=
dd24fa2f3d7@geanix.com
>=20
> Changes in v9:
> - Fix documentation of voltage regulator field(s) in struct mma8452_data
>   kernel-doc block.
> - Fix a couple of nitpicks in struct mma8452_data kernel-doc block.
> - Switch to STANDBY mode before writing to CTRL_REG4.
> - Add patch fixing runtime PM bugs in mma8452_read().
> - Add comment about handling of -EINVAL return value from
>   pm_runtime_get_if_active() in mma8452_interrupt().
> - Fix for race between mma8452_remove() and mma8452_interrupt(), by calli=
ng
>   free_irq() before pm_runtime_disable() instead of after.
> - Fix mixing of guards and goto in mma8452_runtime_suspend(). Using guards
>   will be re-introduced later on, when mixing can be avoided.
> - Link to v8: https://patch.msgid.link/20260907-mma8452-open-drain-v8-0-c=
17407e22118@geanix.com
>=20
> Changes in v8:
> - Move patch 7 (with Fixes: ...) to go before the non-fixes patches.
> - Rebased from v7.3-rc1 to current iio/togreg branch.
> - Drop patch 8 (identical patch from Sanjay Chitroda already in togreg
>   branch).
> - Add new patch fixing a strangely extra indentation of a comment block.
> - Add new patch adding documentation for struct mma8452_data.
> - Move patch 4 to last in series, and rework the synchronization between
>   suspend/resume and interrupt handler.
> - Link to v7: https://patch.msgid.link/20260831-mma8452-open-drain-v7-0-2=
2946812c928@geanix.com
>=20
> Changes in v7:
> - Use dev pointer directly in mma8452_runtime_suspend() also.
> - Move struct i2c_client *client definition to patch 4.
> - Drop patch 7 (Drop unneeded lock acquire on read).
> - Link to v6: https://patch.msgid.link/20260825-mma8452-open-drain-v6-0-9=
b252804ee80@geanix.com
>=20
> Changes in v6:
> - Prevent interrupt storm if runtime suspend fails to set the device in
>   standby mode by not setting suspended flag to true when failing to
>   activate standby mode and by ensuring PM counter is not leaked in
>   mma8452_interrupt().
> - Don't acquire data->lock in mma8452_read_raw().
> - Add fix for use-after-free in mma8452_probe() error path when CONFIG_PM
>   is enabled.
> - Fix (brown paper bug) build error introduced in v5.
> - Renamed label in mma8452_interrupt().
> - Add patch to return -ENODATA when missing device model information.
> - Link to v5: https://patch.msgid.link/20260819-mma8452-open-drain-v5-0-d=
8aa590d7c36@geanix.com
>=20
> Changes in v5:
> - Squashed dev_err_probe() call to one line.
> - Fixed typo in patch 2 title.
> - Added synchronization between runtime suspend and interrupt handler.
> - Link to v4: https://patch.msgid.link/20260812-mma8452-open-drain-v4-0-b=
fca15d02b59@geanix.com
>=20
> Changes in v4:
> - Fixed interrupt handler to check runtime PM status before trying to
>   access the chip.
> - Split open-drain support and interrupt sharing into separate patches.
> - Added new patch to reuse existing struct device * through mma8452_probe=
()
>   function.
> - Print warning message when irq type is not set by firmware.
> - Link to v3: https://patch.msgid.link/20260805-mma8452-open-drain-v3-0-6=
149f406a409@geanix.com
>=20
> Changes in v3:
> - Reordered patches, swapping #2 and #3.
> - Always add IRQF_SHARED flag.
> - New patch to change it so IQRF_TRIGGER_LOW flag is only added when no
>   trigger type is set by firmware.
> - Link to v2: https://patch.msgid.link/20260715-mma8452-open-drain-v2-0-9=
5be9f5f4795@geanix.com
>=20
> Changes in v2:
> - Commit message of patch 2 updated.
> - Operator precedence bug fixed in flags argument to
>   request_threaded_irq().
> - Always check return value of mma8452_set_interrupt_pin_mode(), and just
>   check for non-zero value.
> - Added new patch with optimization of struct mma8452_data ordering.
> - Link to v1: https://patch.msgid.link/20260715-mma8452-open-drain-v1-0-b=
1dd2a440c60@geanix.com
>=20
> To: Jonathan Cameron <jic23@kernel.org>
> To: Lars-Peter Clausen <lars@metafoo.de>
> To: Rob Herring <robh@kernel.org>
> To: Krzysztof Kozlowski <krzk+dt@kernel.org>
> To: Conor Dooley <conor+dt@kernel.org>
> To: Martin Kepplinger <martink@posteo.de>
> To: Sean Nyekjaer <sean@geanix.com>
> To: David Lechner <dlechner@baylibre.com>
> To: Nuno S=C3=A1 <nuno.sa@analog.com>
> To: Andy Shevchenko <andy@kernel.org>
> To: Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
> To: Christoph Muellner <christoph.muellner@theobroma-systems.com>
> Cc: linux-iio@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
>=20
> ---
> Esben Haabendal (10):
>       dt-bindings: iio: accel: mma8452: Add drive-open-drain
>       iio: accel: mma8452: Fix use-after-free bug in error error path
>       iio: accel: mma8452: Fix runtime PM bugs in mma8452_read()
>       iio: accel: mma8452: Optimize struct mma8452_data member orders
>       iio: accel: mma8452: Only apply trigger type when not set by firmwa=
re
>       iio: accel: mma8452: Fix unintended comment indent
>       iio: accel: mma8452: Add comment block for struct mma8452_data
>       iio: accel: mma8452: Allow open drain interrupt pin configuration
>       iio: accel: mma8452: Use proper error code when missing device model
>       iio: accel: mma8452: Support interrupt sharing
>=20
>  .../devicetree/bindings/iio/accel/fsl,mma8452.yaml |   6 +
>  drivers/iio/accel/mma8452.c                        | 217 +++++++++++++++=
+-----
>  2 files changed, 177 insertions(+), 46 deletions(-)
> ---
> base-commit: e5b9e42a20392b669097c8c4aa09c3aed82ba10c
> change-id: 20250401-mma8452-open-drain-81577c41375c
>=20
> Best regards,
> -- =20
> Esben Haabendal <esben@geanix.com>
>=20

