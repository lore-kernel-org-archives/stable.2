Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED66A3CB578
	for <Stable@vger.kernel.org>; Wed, 19 Aug 2026 07:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787125705; cv=none; b=pqNXwR1m1GyNSWCbXHGfoc8OkZIVYXJhAwv9Vd/j1KAu/uKLxRnwLAnXDjKEKtuXcIH1izd6ISSdQjPfVDrYQDKuLY3ZHZZ/oe/DPgXie/R/36u9M8EgsItQH+bi23yl6Hxsy+u/8tx6jruAPTEAmkbk446SVo3UZkDIuIN9OYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787125705; c=relaxed/simple;
	bh=4a8JairiYEbrbFYp/FUtO8S0xGCG0kWezT3bIl734vY=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=A5rnsAagIPcv9Mw7msHfRVgsX+WxQA0kr2DAV5/XcLqi01vl/axD3/bCPJsq3Bd5w7YVKa6YI9F1MG1pVTwqYLuhLvypNahs+vFG01B6aKuyJHyyhS/SRhADih6s9Ehtt9BjEKb05YlET4p8K3gcoUJUoHB+BwtQDrE/47pypXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VKoajKOL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VKoajKOL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6411F1F000E9;
	Wed, 19 Aug 2026 07:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787125703;
	bh=HpkHxN39FO9Vk1QM4gX67ifJQbupxva4a2GXh5vb9sI=;
	h=Subject:To:From:Date;
	b=VKoajKOL5zou4eoZMdvu12ULAeg2nQq7oOAJfZ5ndry82WUGmnO9wqMiWt+RIwdhW
	 iMuo88E6l2nqtegnDIapZ7aZou/IJrrXGYfyJclQzct53Vf9HCB5uT9+mVM1r6JaiX
	 RVOdioqf0quD7GJ9xQlUOB93NSi9KqS3+c40G3GU=
Subject: patch "iio: adc: ad4080: configure backend data size" added to char-misc-next
To: antoniu.miclaus@analog.com,Stable@vger.kernel.org,dlechner@baylibre.com,jonathan.cameron@oss.qualcomm.com
From: <gregkh@linuxfoundation.org>
Date: Wed, 19 Aug 2026 09:44:40 +0200
Message-ID: <2026081940-erratic-cling-6315@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: adc: ad4080: configure backend data size

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


From d39afd249d1ef5cb03b6f1dc22a68e6385de413d Mon Sep 17 00:00:00 2001
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
Date: Mon, 13 Jul 2026 11:40:43 +0300
Subject: iio: adc: ad4080: configure backend data size

The AXI backend needs to know the ADC word width in order to pack the
sample data correctly on the bus. During channel setup, program the
backend packet format via iio_backend_data_size_set() using the channel
resolution, so the data is transferred according to the device's
realbits.

The backend packet format field defaults to 20-bit packing, so the
20-bit parts (AD4080/AD4081/AD4082, AD4880) were unaffected. The 16-bit
(AD4083/AD4084/AD4085, AD4884) and 14-bit (AD4086/AD4087/AD4088) parts,
however, were left packing data at the wrong width, producing corrupt
buffered captures.

Fixes: 6c3e7265734b ("iio: adc: ad4080: add support for AD4084")
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/adc/ad4080.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
index 8d2953341b15..8feb0c7f7fcb 100644
--- a/drivers/iio/adc/ad4080.c
+++ b/drivers/iio/adc/ad4080.c
@@ -698,6 +698,11 @@ static int ad4080_setup_channel(struct ad4080_state *st, unsigned int ch)
 	if (ret)
 		return ret;
 
+	ret = iio_backend_data_size_set(st->back[ch],
+					st->info->channels[0].scan_type.realbits);
+	if (ret)
+		return ret;
+
 	if (!st->lvds_cnv_en)
 		return 0;
 
-- 
2.55.0


