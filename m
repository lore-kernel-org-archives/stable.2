Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3713D3339
	for <Stable@vger.kernel.org>; Fri, 11 Sep 2026 09:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789120551; cv=none; b=unW1bf8hYxX+GlfwZuw6Ivm/NBUdu4oH/XaNOCVNlkwrxNXFk4a8GChbDHJMzIwOgdGZHIk085jZ6OJ+pbFzdvvT67Usr6lmTX4Vqc045kl6SFY/YOmd0SMVqMAh0+jw0v6Szq1EnNZqGEkc1y8ZeloXsmmtBcbWG1LpjhYiOLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789120551; c=relaxed/simple;
	bh=oycDNj85V0wqOOZirdzA4VJD/+XRG25AJh7xF+X+eFQ=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=p7MhUdkw+LRHXMwNjdneEuIsaURb28ingKD2xPFS4imXmHopJ1icFD3sO1sfEDzF5rsZdcCaC/DnhmYe7rtPw22qyrE7T0Z36Lgj2b+71CdPMQoVOvJh9GvmL0Bs0JDcjkHato3EsuGF+f0GearQNUyJ98eK3yj6Wz4wqJa1g8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BWsDfjlL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BWsDfjlL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 380C11F00898;
	Fri, 11 Sep 2026 09:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789120549;
	bh=dV5LtWr1dsOuTTMF7MqNBsj+nHsDdxSLU7HeZ/cCI7s=;
	h=Subject:To:From:Date;
	b=BWsDfjlL3ROmAinET79jPHBb0cgeAw1m8/kxeKwTzpsB5Tr2L0kxqxje+2wWzpsjj
	 xVWxpWI/AWCEjJFIrN/xGdr3lNZu1fSL2YE9M99uJ0gG0dAJeJnpRTvC3LVSpjoSON
	 J9JszeUClCm3AJD9VhAXAZ0ANwzkbUIbmEtCRGz4=
Subject: patch "iio: adc: adi-axi-adc: Initialize state mutex" added to char-misc-linus
To: janani.sunil@analog.com,Stable@vger.kernel.org,jonathan.cameron@oss.qualcomm.com
From: <gregkh@linuxfoundation.org>
Date: Fri, 11 Sep 2026 11:55:31 +0200
Message-ID: <2026091131-envoy-crock-d2c8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: adc: adi-axi-adc: Initialize state mutex

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 549b71ce050637dd32678371ad76c445a2f8c9aa Mon Sep 17 00:00:00 2001
From: Janani Sunil <janani.sunil@analog.com>
Date: Thu, 13 Aug 2026 15:56:56 +0200
Subject: iio: adc: adi-axi-adc: Initialize state mutex

The AXI ADC register access paths serialize transactions with st->lock,
but probe does not initialize it. Initialize the mutex before registering
the backend.

Fixes: 7ecb8ee5c93b ("iio: adc: adi-axi-adc: support digital interface calibration")
Signed-off-by: Janani Sunil <janani.sunil@analog.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/adc/adi-axi-adc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index 589f03618ecf..fc7cc92b35f0 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -714,6 +714,10 @@ static int adi_axi_adc_probe(struct platform_device *pdev)
 	if (!st)
 		return -ENOMEM;
 
+	ret = devm_mutex_init(dev, &st->lock);
+	if (ret)
+		return ret;
+
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
-- 
2.55.0


