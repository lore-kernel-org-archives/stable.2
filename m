Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4343C1D56
	for <Stable@vger.kernel.org>; Tue,  6 Oct 2026 08:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791273776; cv=none; b=tOPyC/U/ggl4Vr13ykEhrG5aHuEE82pKcPmzsIvcG/sbqFv+r+m5HUr1yC/UzCeicHffiXltuwcO20RAzu44TVZr1PSu2zlBJmdSuEzC4co9BvFTgkHORg7GnlAMtXgZb5s6KmweQOWAsczQRpoxA7EXwf2iTQmw6tom/G4+cb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791273776; c=relaxed/simple;
	bh=4i8rYsnVlocmRO7E3qOLdr7z1EIHP9wfGUhLE7X606w=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CZdZv4O7ceh489/o2EUFyD+8z48mOmiuV7gm1i2uc6UHBAeEo4wPnN3khxHn7hDqoqw9xKm1KR+frXf5a4RMHFcMcrJaCYEtaDsputJBCu7P6MGR/MGDZNEfJ5GWR+y8gPq5TnUvpcG80TwciXaxsTupixFDYAYMTIRKgW8lYaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LwbQBlfe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LwbQBlfe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 209081F000FF;
	Tue,  6 Oct 2026 08:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791273774;
	bh=WnvAFg4pKWYiRB4zQLBtMdklBBixKDdm8OpeocfwI94=;
	h=Subject:To:Cc:From:Date;
	b=LwbQBlfeRM5FLoRwxALalnSFcGXpGy3YYGC2hdhde9aEbZDLYIhiAMRmS4BROBkQA
	 9FTF+Sa0nhWKNctGnKFf+SZQLuSJQrReuHiUNHRyeVfy00mf2bhykTMRwrp1m3a7+0
	 elk46+FytB5diZ9a4WV99JLozMVcfC1P0XJv5wVM=
Subject: FAILED: patch "[PATCH] iio: adc: adi-axi-adc: Initialize state mutex" failed to apply to 6.12-stable tree
To: janani.sunil@analog.com,Stable@vger.kernel.org,jonathan.cameron@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 06 Oct 2026 09:52:09 +0200
Message-ID: <2026100609-cape-bust-86da@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 549b71ce050637dd32678371ad76c445a2f8c9aa
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100609-cape-bust-86da@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 549b71ce050637dd32678371ad76c445a2f8c9aa Mon Sep 17 00:00:00 2001
From: Janani Sunil <janani.sunil@analog.com>
Date: Thu, 13 Aug 2026 15:56:56 +0200
Subject: [PATCH] iio: adc: adi-axi-adc: Initialize state mutex

The AXI ADC register access paths serialize transactions with st->lock,
but probe does not initialize it. Initialize the mutex before registering
the backend.

Fixes: 7ecb8ee5c93b ("iio: adc: adi-axi-adc: support digital interface calibration")
Signed-off-by: Janani Sunil <janani.sunil@analog.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

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

