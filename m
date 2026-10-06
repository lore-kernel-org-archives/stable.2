Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F0622425B
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 07:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791272655; cv=none; b=XKXssHJsKbF0fdZ7mo+HWJTaWNSuL8Bfvh1jdQiTWKCVc3FALiSuoPfRo1GphLcM9XyBzbB5JYtAmhGkXIzv24Lx0dfdp2Hav+PxDP1X24IIIGXI+Mk/TucxFZTQ4fRKiPdWzKoxTYIH6IfwjeDpin4dFYxQzCVviBrVeRWc5+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791272655; c=relaxed/simple;
	bh=3qfFq2fU5AI6He894KfyIlBgrAgKDUsy6yBBUlq7CJk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=J6Px4cfYFC+h20d5MTGMM0qbVctaDtGbYFXWcaUuumpj0L6138yR0bITuCHom1YyK/2VjftkfkzC4WPrQUQR0FE2lTPjuR5fBCyyFfTIJaB7TeX3geZTrSu+XcKyluBkB2EoSdWQy9K8GT5ArGdPPZFfDq3s2HjcCxqg8Hwsc9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SpFY6BG+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SpFY6BG+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E1201F000FF;
	Tue,  6 Oct 2026 07:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791272654;
	bh=CVKLgoMDxgu5mco41v7GyL0iQD4sozhECgxQTkRXB7E=;
	h=Subject:To:Cc:From:Date;
	b=SpFY6BG+KDcBZZvU2CE4JBWggjxbbdrr5Z1UG1K0QrzDlgIcpBw2gffvfIOU5I4/F
	 c0Llk7SjWlsUhoJZiny/1tXfZnqGJ1Xc7mwW9X8Fs7AQG2s+p33Nz/sZLbXEc7adsp
	 UkqWM2QLrr/gaN5zzc8O/NArWiqc16FT5guyvOFY=
Subject: FAILED: patch "[PATCH] iio: adc: aspeed: propagate reset deassert errors" failed to apply to 6.6-stable tree
To: pengpeng@iscas.ac.cn,jonathan.cameron@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 06 Oct 2026 09:44:00 +0200
Message-ID: <2026100600-partake-series-35e3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 95e4eb426b4bd666fa2f37886c0ddf74a0cc6167
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100600-partake-series-35e3@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

