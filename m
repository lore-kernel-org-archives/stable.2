Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E046A1F91E3
	for <Stable@vger.kernel.org>; Thu,  9 Jul 2026 05:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783575957; cv=none; b=LKah7gCr3gsKk9a67xxnYH/oPLa34ijwBrvJGhZvf+u4drcE+KjQ/6b+FAg3SJ2k9M620L8eVmzluGX5kBWCYpX8kzHdUi+TfSnYCVzvXePin1AIUMSvXzMTM053cScvL3QYqdvG8223EtKUwnrmK4Mhf+NtaMuycoargYPHdMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783575957; c=relaxed/simple;
	bh=moMKVVgilhfhH+qu3+IlWvBgLhSwF7mmJx7fRoFPPc0=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=V5Y47BndwTfHzmOoL4vhMSleP2BVq26DojKtG3ncUVExiSKt6awW2dGxrfe5SKJVwUC7ghj1sA12n1fwOsS2lg4ZM7AHuG2PefDWTI978y649/dd2q+8CIFZWe7pI2xdib9hbdDY8JhyUepMIKF0xqkGFn6civ+n3kBwobZ2t3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dpR6Bmvb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dpR6Bmvb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F20F41F000E9;
	Thu,  9 Jul 2026 05:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783575955;
	bh=mbqbCjf5KSi9Hs4Ix2qu5tlPs6hI3k3SiYF2r4lLU2Y=;
	h=Subject:To:From:Date;
	b=dpR6Bmvbt6c5yCsjBSzcI2hi1/0fdUCumGUzaBd/HfW2cbKazn1dNbU8GAJUZ1O5R
	 z6JHVx/vKMwyJenQnB67dIu5miCM4xVv5RwUTifLZ9VXMAq4+SvDj06xQDiY54sp53
	 GtEOsqZuLKvvIF3s+YbqgzM9Fbb6PpMCUOnQJ2OY=
Subject: patch "iio: imu: st_lsm6dsx: deselect shub page before reading whoami" added to char-misc-linus
To: andreas.kempe@actia.se,Stable@vger.kernel.org,jic23@kernel.org,lorenzo@kernel.org
From: <gregkh@linuxfoundation.org>
Date: Thu, 09 Jul 2026 07:44:52 +0200
Message-ID: <2026070952-choosy-charting-23ae@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: imu: st_lsm6dsx: deselect shub page before reading whoami

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From aede83625ff5d9539508582036df30c809d51058 Mon Sep 17 00:00:00 2001
From: Andreas Kempe <andreas.kempe@actia.se>
Date: Thu, 2 Jul 2026 10:41:23 +0000
Subject: iio: imu: st_lsm6dsx: deselect shub page before reading whoami

As part of driver initialization, e.g. st_lsm6dsx_init_shub() selects
the shub register page using st_lsm6dsx_set_page(). Selecting the shub
register page shadows the regular register space so whoami, among other
registers, is no longer accessible.

In applications where the IMU is permanently powered separately from the
processor, there is a window where a reset of the CPU leaves the IMU in
the shub register page. Once this occurs, any subsequent probe attempt
fails because of the register shadowing.

Using the ism330dlc, the error typically looks like

    st_lsm6dsx_i2c 3-006a: unsupported whoami [10]

with the unknown whoami read from a reserved register in the shub page.

The reset register is also shadowed by the page select, preventing a
reset from recovering the chip.

Unconditionally clear the shub page before the whoami readout to ensure
normal register access and allow the initialization to proceed.

Place the fix in st_lsm6dsx_check_whoami() before the whoami check
because hw->settings, which st_lsm6dsx_set_page() relies on, is first
assigned in that function.

Placing the fix in a more logical place than the whoami check would
require a bigger restructuring of the code.

Fixes: c91c1c844ebd ("iio: imu: st_lsm6dsx: add i2c embedded controller support")
Signed-off-by: Andreas Kempe <andreas.kempe@actia.se>
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 21 +++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 630e2cae6f19..f4edcb73ec8c 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -1712,6 +1712,26 @@ static int st_lsm6dsx_check_whoami(struct st_lsm6dsx_hw *hw, int id,
 		return -ENODEV;
 	}
 
+	hw->settings = &st_lsm6dsx_sensor_settings[i];
+
+	if (hw->settings->shub_settings.page_mux.addr) {
+		/*
+		 * If the IMU has the shub page selected on init, for example
+		 * after a CPU watchdog reset while the page is selected, the
+		 * regular register space is shadowed. While the regular
+		 * register space is shadowed, the registers needed for
+		 * initializing the IMU are not available.
+		 *
+		 * Unconditionally clear the shub page selection to ensure
+		 * normal register access.
+		 */
+		err = st_lsm6dsx_set_page(hw, false);
+		if (err < 0) {
+			dev_err(hw->dev, "failed to clear shub page\n");
+			return err;
+		}
+	}
+
 	err = regmap_read(hw->regmap, ST_LSM6DSX_REG_WHOAMI_ADDR, &data);
 	if (err < 0) {
 		dev_err(hw->dev, "failed to read whoami register\n");
@@ -1724,7 +1744,6 @@ static int st_lsm6dsx_check_whoami(struct st_lsm6dsx_hw *hw, int id,
 	}
 
 	*name = st_lsm6dsx_sensor_settings[i].id[j].name;
-	hw->settings = &st_lsm6dsx_sensor_settings[i];
 
 	return 0;
 }
-- 
2.55.0


