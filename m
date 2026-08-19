Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630443F12CB
	for <Stable@vger.kernel.org>; Wed, 19 Aug 2026 07:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787125553; cv=none; b=lVR49K4FhIJj0n5Bnrohs/2b+wlgTpNefUy8SCR2+qI1Fg65BIzQgYxzM/8B7uFikl9tFe5+MCBhVC28Lti086gOvrulayrwj1i5NSl27C+j4n4ERTWSf1AjMMBOiNOoXA25/+Xf+2S9VlftplwE4IUJmPbTqD0zLE6Lgltv1zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787125553; c=relaxed/simple;
	bh=KR9x1tjwwI4E5Gi6kgBOKIV9iRd23pTKd3Jst5QajV0=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=TRR19rI0Ip5o7uHr28mqEtD60nhGqX0vIojp6IqlVMAD/ttrfLbApy/gA1/aTXGXGEgJJ9Q6w1EvHhd/JplCft6oWQZ5WXueabtvC5tiHJO7qyAg0WWzSHhgWxzkzzwDVt4A/9wbfz0x2mFxckcMrVPj3NmQ/bmQcoUEMpIxvrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hzT4z/in; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hzT4z/in"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C530F1F00A3A;
	Wed, 19 Aug 2026 07:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787125549;
	bh=ZVAXOxE6TRzR10io+nCWBQE6vYDtpCKf0BwGWc8c254=;
	h=Subject:To:From:Date;
	b=hzT4z/in7EM+6TXaIPMEJ9p8ZiRcMY3vVzldeL+S37FNQqT3sjBU7XWjbsPM2Zxke
	 oIsLsXzTPGHOpZla0ObiqyjFruQ+eQ3H7O3LOuOCRKrNDMohgaJwufN6iDaACYU/n6
	 x7FFJEIr0wVlhfzMETruP9ihJXiHFVF4VhMwk2Rg=
Subject: patch "iio: adc: ad4080: configure backend data size" added to char-misc-testing
To: antoniu.miclaus@analog.com,Stable@vger.kernel.org,dlechner@baylibre.com,jonathan.cameron@oss.qualcomm.com
From: <gregkh@linuxfoundation.org>
Date: Wed, 19 Aug 2026 09:44:08 +0200
Message-ID: <2026081908-gallon-paper-9280@gregkh>
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
in the char-misc-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the char-misc-next branch sometime soon,
after it passes testing, and the merge window is open.

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


