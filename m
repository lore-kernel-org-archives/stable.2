Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BA239A04A
	for <Stable@vger.kernel.org>; Wed, 19 Aug 2026 07:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787125500; cv=none; b=N50PN9wyhnGj4cDo6x1lIxYdxEfHEKlud4ocW50mS27j+BJu3kjhqUadVy+U2GgKveSDl+lt8p8DDT1M3+i64iPQSWDRJU3U1M5iAY9sCa9KyL/5swyOBGkTYMepPNJrdwanyp1oOHmRJHopwxZvCM64t7zbd8CMFTHo0mLkVOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787125500; c=relaxed/simple;
	bh=OxN/GuvJeaYL9z4zr+JIqFGJbxu47SdoJtolscoqRB8=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=bXrDkPyNGGBvAIbuHvzN+VnkNjVrcp+nrX4uTIsgnJ19GMxZZ+dRBJsoE8JTxW5lpI3St40bYm/0PC4PQGGX85yCmsu6VA/znchz9cZReD8xlIKkLF5ndUjkY7D8zdbUflMmxJeSFjpcw3TwWluofvVZcgzWjU7tjNaiv2/mJlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NOet0jKY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NOet0jKY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2BE41F00A3A;
	Wed, 19 Aug 2026 07:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787125496;
	bh=5YR6P65fQl7fTC7mNeS5ZJCd4OpU7BzR13IrZKtI2qU=;
	h=Subject:To:From:Date;
	b=NOet0jKYRsnEF+bHQabzFEVSS64naMCcYOqCBuuvKjqcoTHpV2vQJFacN8fyEiwKX
	 3WZt4D1jEqBsIFotm1/5aC3092awKnWaKgWgPkTUZ38kN6LqQ3MomoZ3capRmFvmBE
	 3iC2g5ecizP7PDlKt+K3uEa6aOPl7o3/aywdsATM=
Subject: patch "iio: light: ltrf216a: fix runtime PM reference leak in error path" added to char-misc-testing
To: vidhu.linux@gmail.com,Stable@vger.kernel.org,jonathan.cameron@oss.qualcomm.com,joshua.crofts1@gmail.com
From: <gregkh@linuxfoundation.org>
Date: Wed, 19 Aug 2026 09:44:05 +0200
Message-ID: <2026081905-approach-sublime-bb52@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: light: ltrf216a: fix runtime PM reference leak in error path

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the char-misc-next branch sometime soon,
after it passes testing, and the merge window is open.

If you have any questions about this process, please let me know.


From c132aef0e757a39036b1d40faf0569f2e343b13e Mon Sep 17 00:00:00 2001
From: Vidhu Sarwal <vidhu.linux@gmail.com>
Date: Mon, 13 Jul 2026 07:58:29 +0530
Subject: iio: light: ltrf216a: fix runtime PM reference leak in error path

ltrf216a_get_lux() acquires a runtime PM reference by calling
ltrf216a_set_power_state(data, true). However, if
ltrf216a_read_data() fails, the function returns immediately without
dropping the reference.

This leaves the runtime PM usage count unbalanced, preventing the device
from autosuspending after a failed read.

Fix this by releasing the runtime PM reference before returning from the
error path.

Fixes: 83f0bcd40d5c ("iio: light: Add support for ltrf216a sensor")
Signed-off-by: Vidhu Sarwal <vidhu.linux@gmail.com>
Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/light/ltrf216a.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/light/ltrf216a.c b/drivers/iio/light/ltrf216a.c
index aad96fc91565..dd8f3260b1d8 100644
--- a/drivers/iio/light/ltrf216a.c
+++ b/drivers/iio/light/ltrf216a.c
@@ -248,11 +248,10 @@ static int ltrf216a_get_lux(struct ltrf216a_data *data)
 		return ret;
 
 	greendata = ltrf216a_read_data(data, LTRF216A_ALS_DATA_0);
+	ltrf216a_set_power_state(data, false);
 	if (greendata < 0)
 		return greendata;
 
-	ltrf216a_set_power_state(data, false);
-
 	lux = greendata * data->info->lux_multiplier * LTRF216A_WIN_FAC;
 
 	return lux;
-- 
2.55.0


