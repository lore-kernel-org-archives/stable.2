Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEED9247291
	for <Stable@vger.kernel.org>; Sun, 14 Jun 2026 05:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781416723; cv=none; b=mkpunAeCSjjQH+RbvI30+C3/SWgEp9zPEl9njzIFEMiuVDLaAUDXF6/fl8PFb50gsQEHu39UuEXcYjw2QEqZQb+5DfFlRcXOFXL7ws9P2IiATvOmzzGXp9dLmvs6OpfOeWj4PJPLBumrsphLQ7FNOpERJ5MUn8VrDbjnboKhZg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781416723; c=relaxed/simple;
	bh=A4SBVvg9JXG0H/eO+tYfcCsER1Rozs2ZKEbJCAxBV2M=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=MYsoEVvPC5a22JbqAoBErevm3gAlVbTOkhq0cHoZdMX7+a+MPAAk2Jk54+Xq67Fp3TroN7kf187uZGCBLRl04yecLLvzVSoZM/mGxAZ/GLNKplPW59TcTeWJbErA/3I3NfDm9GYOLxw9bzlTzh6i0b7gKBYptCkYpV1APuUNPwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b9vd+u2H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b9vd+u2H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00A631F000E9;
	Sun, 14 Jun 2026 05:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781416722;
	bh=LX86w+jUdPBDJISfoNOPz9gPMVd8/ev1S2We96C/t2k=;
	h=Subject:To:From:Date;
	b=b9vd+u2HRqQhetFDC2wscyfsPnmdqt+3nrzialxwcTDXCfi1D4UOJwTfxmZIpspDm
	 RD6jVTmgJxdBoBt+u8IEwOhipbTPZHQfjAwsaVn0m/lCq47ZwggnJ4S8ZjkI37pzw+
	 iPiuaNJ3Gt1zNp2NgwD2ll97TuK7+PmCeLearPrw=
Subject: patch "iio: gyro: bmg160: wait full startup time after mode change at probe" added to char-misc-testing
To: sozdayvek@gmail.com,Stable@vger.kernel.org,jic23@kernel.org
From: <gregkh@linuxfoundation.org>
Date: Sun, 14 Jun 2026 07:57:18 +0200
Message-ID: <2026061418-carmaker-camcorder-62ef@gregkh>
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
in the char-misc-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the char-misc-next branch sometime soon,
after it passes testing, and the merge window is open.

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


