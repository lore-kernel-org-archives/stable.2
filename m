Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795608329;
	b=ym0exnEwSqs4zHQucavddkyCQYdjTyw1omJmINridjwWBUd3S855V6MwllAWvvpTKU8W
	 JpSGHZ76HyWLGIhARUlJwpNC+092JIPVB1GuaACjdOAS0+aVHu6vfu1jPi7xFgI6TfCLw
	 DSwYE50R+etHjucny3znaQUbtePi+V6zglQ4Njbe99DZDYtmt4imOCg5Wlswk7rYw2na5
	 mQzLNOxXAunAxMj++Q+bZPUgXUORKsEeBmdGmS5e1opFBlbK/Dr1pUReka5Mie7ykkrV8
	 sNIM10x2DVLzdlTAbWXTlvenJ38Eb14m+OkBiT53+TUpAA1DvqPwESc328ZPHfPoE4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795608329;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=puQfW3p0R1e1g7ui45JZvVBr4KlyZ0qBqCbl9mK3nVQ=;
	b=1lTLOq2/84WcJztdGom+/b8fSQuq5T0Pjw/uBjyvlbvdj3qrdNCYSd6dPJMF8IreJtpd
	 9w8bOrdjiqrUfsmge3c0Qn50q7OKjvF9o7d/ug9Z06Y/OB7qFI6Zge3cDs8ebk0e6MxR5
	 ZzNR7vYK28Fjg0p7bhLRRvrhZ8tGVUJJ1kkMPbHxaJe+gMTtIRcnQfn9T54E8HWtyOYp9
	 GJzGmdlB8BXzGRKx0D3I+5Vxhm7JILg2qqcbwyaOOh0EO2BD5L6QuOmX5uRI0LFH90swK
	 hrn4SwTsnWz1pWUObGlJjFwP9zhnlYXL2GwkETMr+2jw6EWSHiSPPc2uiFiz/jODegA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=rKW1irpC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518E7606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=rKW1irpC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 619C41F000C4;
	Wed, 25 Nov 2026 12:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795608328;
	bh=puQfW3p0R1e1g7ui45JZvVBr4KlyZ0qBqCbl9mK3nVQ=;
	h=Subject:To:Cc:From:Date;
	b=rKW1irpCp1Nk1y1LHFNQenSLBJ43QF0MPGXKbC0/Lu1fUSMLrJGtQjTgRrB92pskZ
	 sAUk0XndeibI2EItd8DxcWODkhPGpv43eUVcEwnUbEJ1bBfOqqAZ+GJtHkvXGDHBuq
	 S0QQ0D0fh2nMoBQaVKnU2BCGOfVRH8jOr2TPBTcg=
Subject: FAILED: patch "[PATCH] iio: adc: ad7923: add the AD7927 to the SPI ID table" failed to apply to 6.18-stable tree
To: josef@toxicpanda.com,gregkh@linuxfoundation.org,jonathan.cameron@oss.qualcomm.com,nuno.sa@analog.com,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 12:28:01 +0100
Message-ID: <2026112501-stylist-frightful-2d5a@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 594157b4f3f64db5833dee679194c33a5968f92e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112501-stylist-frightful-2d5a@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 594157b4f3f64db5833dee679194c33a5968f92e Mon Sep 17 00:00:00 2001
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 27 Oct 2026 17:19:10 +0100
Subject: [PATCH] iio: adc: ad7923: add the AD7927 to the SPI ID table
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The binding describes the AD7927 as

  compatible = "adi,ad7927", "adi,ad7928";

The OF match takes the second string. The modalias of the SPI device is
made from the first one, "ad7927", which is not in the spi_device_id table:
spi_get_device_id() returns NULL and ad7923_probe() dereferences it for
the chip information. The module is not loaded automatically either, as the
uevent of an SPI device says "spi:ad7927".

Add the name, with the data of the AD7928.

Fixes: 1140f96cd4af ("dt-bindings: iio: adc: ad7923: adjust documentation")
Cc: stable <stable@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
index 44e014da9722..69fafb4aa4ea 100644
--- a/drivers/iio/adc/ad7923.c
+++ b/drivers/iio/adc/ad7923.c
@@ -366,6 +366,7 @@ static const struct spi_device_id ad7923_id[] = {
 	{ .name = "ad7924", .driver_data = AD7924 },
 	{ .name = "ad7908", .driver_data = AD7908 },
 	{ .name = "ad7918", .driver_data = AD7918 },
+	{ .name = "ad7927", .driver_data = AD7928 },
 	{ .name = "ad7928", .driver_data = AD7928 },
 	{ }
 };

