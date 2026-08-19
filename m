Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A011A2DF12F
	for <Stable@vger.kernel.org>; Wed, 19 Aug 2026 08:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787126589; cv=none; b=UdOYdCpQBAEdjnxYObsFMkpGrCcQqlI4SeaaeYuOmgZ/9IGIVXEW7LKaAq2dTYdJke9x9w054cLc5xxjQY0sLJII8LImuzQTAOIG1r3jTHt9WqKqABZfLtDZTjPyZItOUe/YzWBgNPNALW82omAnR0ympZbCSDt2tvUBOlHhNlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787126589; c=relaxed/simple;
	bh=mXuld2Hlc8P8OcTRjfY3hZGpzHbP9MiK3zvs6N59+8Y=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=YTEFNLu82q2DvI+DRS8oTqiZhye/feIqquYsLqIHgEH9k+KL24Mlzken+dRTRwdVTDkCXis16hHyrlpHkTfsmcp7/AILkMmk0hzrJN1dLtJn93tsa1lVbUGgxkDQ0XOtIz1lujYhSkOfQroU34NtJ01qvsaGlhlTXixxJ+BjoCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LWIzyvYl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LWIzyvYl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B03DC1F000E9;
	Wed, 19 Aug 2026 08:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787126582;
	bh=sieh2eTROKvxRrkc9QTBMXPUCs/rLDJfGiNAZ5yaQjE=;
	h=Subject:To:From:Date;
	b=LWIzyvYl91+SUg3noQxF+5AdjLzsVuTwj+gbqqWXEr5VJmZMhL7535Yrl5envuN4E
	 oNwZ6ww6LC2j2Oq8wqv31SC+KWTV31ecjDGSf5qJfAF0nhvbVrKU6e/bUTuTTLPtWP
	 IN5iVTbRheLBGxUctrotboKNVIA+wAsEgwGhsRdw=
Subject: patch "iio: chemical: sgp30: Handle IAQ thread creation failure" added to char-misc-testing
To: lilinmao@kylinos.cn,Stable@vger.kernel.org,jonathan.cameron@oss.qualcomm.com,joshua.crofts1@gmail.com
From: <gregkh@linuxfoundation.org>
Date: Wed, 19 Aug 2026 09:47:46 +0200
Message-ID: <2026081946-composer-dexterous-5f05@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: chemical: sgp30: Handle IAQ thread creation failure

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the char-misc-next branch sometime soon,
after it passes testing, and the merge window is open.

If you have any questions about this process, please let me know.


From 1135d6875d2dbda3f6ec718f3421a6ce4378bd63 Mon Sep 17 00:00:00 2001
From: Linmao Li <lilinmao@kylinos.cn>
Date: Wed, 22 Jul 2026 15:48:37 +0800
Subject: iio: chemical: sgp30: Handle IAQ thread creation failure

kthread_run() can fail and return an error pointer, but sgp_probe() stores
it and returns success, so the device is registered without its IAQ thread
and sgp_remove() later passes the error pointer to kthread_stop(). Return
the error from probe instead.

Fixes: ce514124161a ("iio: chemical: sgp30: Support Sensirion SGP30/SGPC3 sensors")
Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/chemical/sgp30.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/chemical/sgp30.c b/drivers/iio/chemical/sgp30.c
index f10bbebc29e4..379c1c4af8d8 100644
--- a/drivers/iio/chemical/sgp30.c
+++ b/drivers/iio/chemical/sgp30.c
@@ -548,6 +548,9 @@ static int sgp_probe(struct i2c_client *client)
 
 	data->iaq_thread = kthread_run(sgp_iaq_threadfn, data,
 				       "%s-iaq", data->client->name);
+	if (IS_ERR(data->iaq_thread))
+		return dev_err_probe(dev, PTR_ERR(data->iaq_thread),
+				     "failed to start IAQ thread\n");
 
 	return 0;
 }
-- 
2.55.0


