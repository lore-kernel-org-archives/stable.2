Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD8C22425B
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 07:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791272644; cv=none; b=TFaq8kQzwFRWiYQLIEdRBb/R27YkIx437f3d4y9YebSS79VdYJw6BLdmn578Jg6WBX9E3vEDK2MmrZmjlx/yDXMVlPqHqgca/IGmsiieSq2gdSc6lrCFQNZPdtlby70mDbEVIyL9VaiNG1V+O/1dsOx4O3HpAx4b0fyszlL5ddk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791272644; c=relaxed/simple;
	bh=Vq4CRCn43RpHoBtWQG2ebgBev08JP0xNbCkkjrZedXk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=SO6KLtoDcITUM9lXTgcMaLNQxzD8qeF8mv/SBcUeMVzLxikGtsaH6Har+BvHn3UPrTA4XgopcQUODClo+ZuCybCI7DnmQGbzzZVRKaXkaSUbNx+x9XnyByknf1zD8/4k05FHi5Ibwy627uov6IGAHbVD2T5kK9oROEJdTQ8h+3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mCzjfNTe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mCzjfNTe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EAFB1F000FF;
	Tue,  6 Oct 2026 07:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791272642;
	bh=xd+pQLtkSeRmXVc7+99t82WGWsJjJs+TZDBz3G9Krag=;
	h=Subject:To:Cc:From:Date;
	b=mCzjfNTe6xYs/VhZu6/hyG9YJqv9LxPUQru53IXBLAISt43g4m2nD2dZudHJlUY+v
	 lnN7s6i/QhP1VIfsJUFpXo65R9905tyMCIWEs9xhpX8vbVf6wwUeFd0wl8PWNUaVH2
	 lrQrYSPS6lkPBBzxSIt1436R9ouvqVnIeRzEGeIY=
Subject: FAILED: patch "[PATCH] iio: adc: aspeed: propagate reset deassert errors" failed to apply to 6.18-stable tree
To: pengpeng@iscas.ac.cn,jonathan.cameron@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 06 Oct 2026 09:44:00 +0200
Message-ID: <2026100600-blimp-motivator-875e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 95e4eb426b4bd666fa2f37886c0ddf74a0cc6167
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100600-blimp-motivator-875e@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 95e4eb426b4bd666fa2f37886c0ddf74a0cc6167 Mon Sep 17 00:00:00 2001
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
Date: Sun, 30 Aug 2026 21:42:27 +0800
Subject: [PATCH] iio: adc: aspeed: propagate reset deassert errors

aspeed_adc_probe() continues to register ADC resources after deasserting
the shared reset, even if the reset controller reports a failure.

A failed deassertion leaves the hardware unavailable, so stop probing
before installing the cleanup action and enabling the ADC.

Fixes: edf7550a1f93 ("iio: adc: aspeed: Deassert reset in probe")
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: stable@vger.kernel.org
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
index 6169ce28261e..452c30cf04f2 100644
--- a/drivers/iio/adc/aspeed_adc.c
+++ b/drivers/iio/adc/aspeed_adc.c
@@ -585,7 +585,9 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(data->rst),
 				     "invalid or missing reset controller device tree entry");
 
-	reset_control_deassert(data->rst);
+	ret = reset_control_deassert(data->rst);
+	if (ret)
+		return ret;
 
 	ret = devm_add_action_or_reset(dev, aspeed_adc_reset_assert, data->rst);
 	if (ret)

