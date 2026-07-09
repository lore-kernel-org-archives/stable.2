Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D8E2E11C7
	for <Stable@vger.kernel.org>; Thu,  9 Jul 2026 05:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783575929; cv=none; b=MgYxCLZRfAtzrI+JXDo9sS3oVRu62hBGRiOBRjYoMerTFHs5ltEu0Oli9q+X2PmLeIKD2X+rITYAtcqBaKHc/JLqxVX2q8JIcKe7qhRIK/aBrkOvPbg4Jg9sMMGyC8gJwPIE0YE0kA+/7LaEuY3x/wPaAR+VRkPV7YMbKyhTC0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783575929; c=relaxed/simple;
	bh=lGMFswBLA1qhMvuh57iKSPZ5pL1akH1pzwuudxesldk=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=Wb8uv2DW/EJ4ii9X/K+IZEdbhMnX9PvJ/IvYGvbS8y/QrSZoyjMnKhw/aeeeVSfcJw3D66K6VAy3/MAbwDO9Wn99JfWKPe3tE8Xj0Cg9n4axNHDFSK8Eubu1WGskXqApXl8d1E3aiJDpgq9ybjOLGt9p/8WgClckNhYwhpglq6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mg/ddUhQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mg/ddUhQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 554431F000E9;
	Thu,  9 Jul 2026 05:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783575923;
	bh=BTJrqdcwYEJw1kPqQzZ864f5ggUS+IbKj8oYOUdYM6k=;
	h=Subject:To:From:Date;
	b=mg/ddUhQ1c+DggXRLqK/PMIFYbKKksfgZtMiwRkbH/b46xc6gzkXXlX0Bpd9BUygk
	 7ktCSwq0jo71LxMrLfc/d1yRTZyGWgR4zuBKuTYtNjBuz7MbXnlm0qhQ5LOMAKvh33
	 omxgJeAAuU0Clg30tiUMkU4j5xZ7npwA9JWheUjU=
Subject: patch "iio: light: al3000a: add missing REGMAP_I2C to Kconfig" added to char-misc-linus
To: joshua.crofts1@gmail.com,Stable@vger.kernel.org,andriy.shevchenko@intel.com,david@ixit.cz,jic23@kernel.org
From: <gregkh@linuxfoundation.org>
Date: Thu, 09 Jul 2026 07:44:50 +0200
Message-ID: <2026070950-reptile-elephant-a3c4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: light: al3000a: add missing REGMAP_I2C to Kconfig

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From a2d30022b7c316ad845d1b696e724058b88e5a4e Mon Sep 17 00:00:00 2001
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Thu, 25 Jun 2026 21:38:08 +0200
Subject: iio: light: al3000a: add missing REGMAP_I2C to Kconfig

The KConfig entry for the al3000a is missing a `select REGMAP_I2C`,
causing build failures.

Fixes: d531b9f78949 ("iio: light: Add support for AL3000a illuminance sensor")
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: David Heidelberg <david@ixit.cz>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/light/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index ef36824f312f..a33920568904 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -45,6 +45,7 @@ config ADUX1020
 
 config AL3000A
 	tristate "AL3000a ambient light sensor"
+	select REGMAP_I2C
 	depends on I2C
 	help
 	  Say Y here if you want to build a driver for the Dyna Image AL3000a
-- 
2.55.0


