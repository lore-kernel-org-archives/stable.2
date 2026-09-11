Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270043D3336
	for <Stable@vger.kernel.org>; Fri, 11 Sep 2026 09:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789120575; cv=none; b=Td6ztkbqVwBpx8mAB7zpuKK3wD36IFAtpAC9gtss5bDzpzZ93zNEkp1gpg81DHHT8bW0bKw0MuhetjGyZv9BSnbKQurNiuYPn8vAWjJ14vCGRCmMLSn5OcONhH6sUgb+tS7PyP9JesuGFe3ZayXT7mCLJDvulpfGyizDD34tRaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789120575; c=relaxed/simple;
	bh=2A1SlrgirhK+zFBGl24h2LaaUvubrdR4+Drw4CDyGzw=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=J1mI0LIt5DbI5VMNz1LS4fP2PomptCuqtKqPlZufTvpowHy1/Cxq4qmf7YEYIDjC80eH5JIMXU3dAZk52Qz6KwViGammeMFKGX5r9za2VOSKMoftyqaMUZYrVK9TC/ja7L1dZ8XCFhtAHYb7mv6lxVUNV8FbA4EfOrQRKcSpFng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eQjCf+kC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eQjCf+kC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0990E1F000FF;
	Fri, 11 Sep 2026 09:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789120572;
	bh=oO36GO8vuQpFfJBT+C1v5j8WxH2ziNCBhDYFntdOsUc=;
	h=Subject:To:From:Date;
	b=eQjCf+kCNsPXDZdfbp8LU4+oKGPnJ7cHtIYUHqNMD38tVkeLFp7M9Z85t4PwCCPk4
	 GvaUZbVKQDo/zr/0YeGB1GqAg7Ta1Zk/AEcyY/zJ5UwZ/NFjBxfG+fruQpdxYjnvHH
	 uZ+ZPiPNA2HfexjdiJ4v7dU/uNGuCQ6WSOZOshgo=
Subject: patch "iio: adc: rohm-bd79124: Fix rising alarm" added to char-misc-linus
To: mazziesaccount@gmail.com,Stable@vger.kernel.org,jonathan.cameron@oss.qualcomm.com
From: <gregkh@linuxfoundation.org>
Date: Fri, 11 Sep 2026 11:55:32 +0200
Message-ID: <2026091132-petted-rumbling-369a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: adc: rohm-bd79124: Fix rising alarm

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 0d3f6b5e639f0bca5c1466ec523a94ec4f9f4c24 Mon Sep 17 00:00:00 2001
From: Matti Vaittinen <mazziesaccount@gmail.com>
Date: Mon, 10 Aug 2026 10:49:56 +0300
Subject: iio: adc: rohm-bd79124: Fix rising alarm

The rising alarm is using the cached falling alarm value causing wrong
value to be used.

Fix this by using the correct cached value for rising alarm.

Fixes: 3f57a3b9ab74 ("iio: adc: Support ROHM BD79124 ADC")
Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/adc/rohm-bd79124.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/rohm-bd79124.c b/drivers/iio/adc/rohm-bd79124.c
index ed5427288961..eab5286763a7 100644
--- a/drivers/iio/adc/rohm-bd79124.c
+++ b/drivers/iio/adc/rohm-bd79124.c
@@ -524,7 +524,7 @@ static int bd79124_enable_event(struct bd79124_data *data,
 		return ret;
 
 	if (dir == IIO_EV_DIR_RISING) {
-		limit = &data->alarm_f_limit[channel];
+		limit = &data->alarm_r_limit[channel];
 		reg = BD79124_GET_HIGH_LIMIT_REG(channel);
 	} else {
 		limit = &data->alarm_f_limit[channel];
-- 
2.55.0


