Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56093220F2D
	for <Stable@vger.kernel.org>; Wed, 19 Aug 2026 08:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787126854; cv=none; b=RqabWR0SS3ZnOyOkdeAqbmBryGMPW1CYDLbKI9fbaTyNLfPqHOJBXb2saQqunAlWTIjbWVozuckbB7djf/GFMTwZakDx8ZdBTYjeuNiJejU8BhhdSiQt9NQPuSIZ462Ala9/LpX+Al8IRCxUHNZJwvSPi+L9PLYGw2XOWS8r0GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787126854; c=relaxed/simple;
	bh=RiqwMblZ9+2NG+UYCJHj5OR30FmBpQhzbiipbdZuG50=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=Mdd4IcCSnliNb5cwiOHzruekuHQ4Tnb9NtHmfN5Yu2elkqFWufEbSpec4dPH2NQV/QWZC3hyid3QSfdqoUPGGt5XTCl1VaJew7Ov3D34wtAPG+gEcC5rLwQvVcceSvgFylffBciNyPy2LIeAWd/avY3ekAcU/jo3b7hxLUIDbc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=m2/XcXBj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="m2/XcXBj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DF7B1F000E9;
	Wed, 19 Aug 2026 08:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787126853;
	bh=sMbgamTaWGlBM5H+L986yZhLbhjgmiHYVD614ljxtx4=;
	h=Subject:To:From:Date;
	b=m2/XcXBjzWHDv3AX7f0tvkfj1aaTC2R6TVhuWGiCYH3WH1cgSamG0No7Pkiu6nkWE
	 U9dACPrDCozutLZJiGvFSgl4jt4oEaoB0UjoBdbzOQV3c2/e/YlllEeqCVCIE6RWmd
	 2r0gH/DtYlpLvVzB4v2dsAs2zKuqP+/GNLpBWEvs=
Subject: patch "iio: imu: st_lsm6dsx: Update enable mask when using sensor fusion" added to char-misc-testing
To: flavra@baylibre.com,Stable@vger.kernel.org,jonathan.cameron@oss.qualcomm.com,lorenzo@kernel.org
From: <gregkh@linuxfoundation.org>
Date: Wed, 19 Aug 2026 09:47:58 +0200
Message-ID: <2026081958-deliverer-pedometer-fe71@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: imu: st_lsm6dsx: Update enable mask when using sensor fusion

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the char-misc-next branch sometime soon,
after it passes testing, and the merge window is open.

If you have any questions about this process, please let me know.


From 4a56c646e1bd4f22a2dcd65ef3723af957c651a9 Mon Sep 17 00:00:00 2001
From: Francesco Lavra <flavra@baylibre.com>
Date: Fri, 31 Jul 2026 19:47:02 +0200
Subject: iio: imu: st_lsm6dsx: Update enable mask when using sensor fusion

The enable_mask struct member keeps track of which sensors are enabled in
the IMU. When enabling and disabling the sensor fusion functionality, the
driver does not properly update this struct member. This prevents a correct
calculation of the number of samples that should be read from the hardware
FIFO; as a result, reads from the FIFO can be unnecessarily split into
multiple transactions, some of which can read past the FIFO length.

Fixes: cd4e1141bff8 ("iio: imu: st_lsm6dsx: Add support for rotation sensor")
Signed-off-by: Francesco Lavra <flavra@baylibre.com>
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c
index 2e72c7ba94dd..5321033daebc 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c
@@ -112,6 +112,11 @@ int st_lsm6dsx_fusion_set_enable(struct st_lsm6dsx_sensor *sensor, bool enable)
 		return err;
 	}
 
+	if (enable)
+		hw->enable_mask |= BIT(ST_LSM6DSX_ID_FUSION);
+	else
+		hw->enable_mask &= ~BIT(ST_LSM6DSX_ID_FUSION);
+
 	return st_lsm6dsx_fusion_page_disable(hw);
 }
 
-- 
2.55.0


