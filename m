Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924003D8128
	for <Stable@vger.kernel.org>; Wed, 19 Aug 2026 07:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787125512; cv=none; b=KhyINpRn1IbUd/FkBQQ2fJPNLmHpKnUypX+8TUu28McGAAFqZ7pESUGo7uo2dXxf49zXK1c3T0nM8kFLa2qTIR87NebfLZ8XFSxxVNW0aIk5GjyPdMOSzocpaMRH7w1VX7rwg0s5EYf+Rbb+3LFLBD2IYbXE0/nAi4SA60ICe0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787125512; c=relaxed/simple;
	bh=dlQvB1XqMDYibKNubGsVsJE2tdaMp5uyQZ8cf7WyY5E=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=OboWAOvHwtI9OMg4iy8BktYmj1omWl3BUa9CrS9e04Rf2Rkblw3f43SRNEgkHI6n7G27/ZBakMhpbyDAPM4mDq8ZlOl1VACBdAfYT9pB6OFp5R94M4cFGFeF6ZvdKJxfp3ENNddvD90Au/L/BAB+wcpUbjiVGRuhJ16rJMNLCcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J9I9r1jM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J9I9r1jM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 638151F000E9;
	Wed, 19 Aug 2026 07:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787125511;
	bh=/WZfA71KX7/5cVx73BHsaMp9yWQW4WR0qTcDFLfmSzI=;
	h=Subject:To:From:Date;
	b=J9I9r1jMM9OuyN8cNMReLRg5rw2ypNw9fHBv14ycqygabxhbVOb220qaIPVhq+UCy
	 YFp8nZ8RpRR4gtWezPILDATJIb3E+fNel2fXnU54FB4FvB1gldoXPcfSnHTxphqHMS
	 bNeIsujMfv7F7WUUI5VsZxTNUusrYe1EeNT36CMw=
Subject: patch "iio: light: opt4060: Fix incorrect register name in threshold read" added to char-misc-testing
To: vidhu.linux@gmail.com,Stable@vger.kernel.org,jonathan.cameron@oss.qualcomm.com
From: <gregkh@linuxfoundation.org>
Date: Wed, 19 Aug 2026 09:44:06 +0200
Message-ID: <2026081906-gully-specimen-88c1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: light: opt4060: Fix incorrect register name in threshold read

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the char-misc-next branch sometime soon,
after it passes testing, and the merge window is open.

If you have any questions about this process, please let me know.


From ad367638212a9f2495ecfa59c886f0cfb7934e9c Mon Sep 17 00:00:00 2001
From: Vidhu Sarwal <vidhu.linux@gmail.com>
Date: Wed, 15 Jul 2026 06:45:44 +0530
Subject: iio: light: opt4060: Fix incorrect register name in threshold read
 error message

opt4060_get_thresholds() correctly reads OPT4060_THRESHOLD_HIGH, but
logs "Failed to read THRESHOLD_LOW." if the read fails. This is a
copy-and-paste mistake, as the preceding low-threshold read already uses
the correct error message.

Update the error message to reference OPT4060_THRESHOLD_HIGH.

Fixes: 0c6db4506ad0 ("iio: light: Add support for TI OPT4060 color sensor")
Signed-off-by: Vidhu Sarwal <vidhu.linux@gmail.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/light/opt4060.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/opt4060.c b/drivers/iio/light/opt4060.c
index e3aabfb14d5d..f79dd342937d 100644
--- a/drivers/iio/light/opt4060.c
+++ b/drivers/iio/light/opt4060.c
@@ -810,7 +810,7 @@ static int opt4060_get_thresholds(struct opt4060_chip *chip, u32 *th_lo, u32 *th
 
 	ret = regmap_read(chip->regmap, OPT4060_THRESHOLD_HIGH, &regval);
 	if (ret) {
-		dev_err(chip->dev, "Failed to read THRESHOLD_LOW.\n");
+		dev_err(chip->dev, "Failed to read THRESHOLD_HIGH.\n");
 		return ret;
 	}
 	*th_hi = opt4060_calc_val_from_th_reg(regval);
-- 
2.55.0


