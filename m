Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2872877DE
	for <Stable@vger.kernel.org>; Sun, 14 Jun 2026 06:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781417088; cv=none; b=cdNQ2UnO0x8st9keeICoEfGf90DAQM6dtUL9DPHtmuCEEcRq0zS0QKr5E2v0FPSCIQn6hua29x2rnYuqlcTjW0INLfU/7Kg0Kah8gPzV0GXtShhjqhG5LlasjKDkg8zrbeeF6gIEy+wSSxHeEiGAUgQotVfOz3/vlRYAixmBf/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781417088; c=relaxed/simple;
	bh=GsavWIwGuXiOh4DBaAOVbteM3cWcCFIZb5dkeVgulhY=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=RJNWCg2fgMF50SCJrEhaJbzSujee/IYYCNI+pUFs7iJNi/5ZCLUB9OQz8E5YNqv52mMIEnc4GUj6HhoNjc5AfDK+7/0GdHOQ20Ikc76UA1q7UbSEza6Lwa0BiljU0c1C174qbis3t8jSrNMegjtbFG+R62sLhV8cIHGF5A2FPwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mNmvXEo2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mNmvXEo2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BD351F000E9;
	Sun, 14 Jun 2026 06:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781417086;
	bh=ZkpqaQt9bdLxss+yTu3NsMJCVJ9PC/KrWbZxzVqmRd8=;
	h=Subject:To:From:Date;
	b=mNmvXEo2qDXvvFky5pz9+MuEXWqOj3jJZmfmoyfWhWMuvpzlpChZljGOtt/qEVqZP
	 pg7JdLsgWXLxkgmUpfE0wdQ+zE4JITa6ll3DdKjb9Le9mzwJJk5d0NBwEH+mUPqJ+m
	 jZm7CD6Ah2xbMog15WUUzMKLNTK+HfvdKsaf4zYQ=
Subject: patch "iio: gyro: bmg160: wait full startup time after mode change at probe" added to char-misc-next
To: sozdayvek@gmail.com,Stable@vger.kernel.org,jic23@kernel.org
From: <gregkh@linuxfoundation.org>
Date: Sun, 14 Jun 2026 08:03:32 +0200
Message-ID: <2026061432-acronym-antsy-dc66@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: gyro: bmg160: wait full startup time after mode change at probe

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


From 088fcb9b567f8723074ad9eb1bf5cb46f8a0096b Mon Sep 17 00:00:00 2001
From: Stepan Ionichev <sozdayvek@gmail.com>
Date: Mon, 11 May 2026 11:40:20 +0500
Subject: iio: gyro: bmg160: wait full startup time after mode change at probe

bmg160_chip_init() calls bmg160_set_mode(BMG160_MODE_NORMAL) and
then waits only 500-1000 us. Per the BMG160 datasheet
(BST-BMG160-DS000-07 Rev. 1.0, May 2013), the start-up and wake-up
times (tsu, twusm) are 30 ms.

The same file already waits BMG160_MAX_STARTUP_TIME_MS (80 ms)
in bmg160_runtime_resume() after the same set_mode(NORMAL)
operation. The 500 us value at probe was likely a unit mix-up;
the old comment said "500 ms" while the code used microseconds.

Reuse the same constant via msleep() and add a code comment
explaining the datasheet basis for the wait. Without this,
register writes that follow the mode change can hit the chip
before it is ready.

Fixes: 22b46c45fb9b ("iio:gyro:bmg160 Gyro Sensor driver")
Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/gyro/bmg160_core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
index 58963f3ea186..d611341a0e2a 100644
--- a/drivers/iio/gyro/bmg160_core.c
+++ b/drivers/iio/gyro/bmg160_core.c
@@ -264,8 +264,14 @@ static int bmg160_chip_init(struct bmg160_data *data)
 	if (ret < 0)
 		return ret;
 
-	/* Wait upto 500 ms to be ready after changing mode */
-	usleep_range(500, 1000);
+	/*
+	 * Wait for the chip to be ready after switching to normal mode.
+	 * The BMG160 datasheet (BST-BMG160-DS000-07 Rev. 1.0, May 2013)
+	 * specifies a start-up / wake-up time (tsu, twusm) of 30 ms; use
+	 * BMG160_MAX_STARTUP_TIME_MS (80 ms) as a safety margin, matching
+	 * what bmg160_runtime_resume() already does.
+	 */
+	msleep(BMG160_MAX_STARTUP_TIME_MS);
 
 	/* Set Bandwidth */
 	ret = bmg160_set_bw(data, BMG160_DEF_BW);
-- 
2.54.0


