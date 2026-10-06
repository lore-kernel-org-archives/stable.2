Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9E53B71A2
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 07:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791272663; cv=none; b=bO7+wySirPnZSWG+Cqp7o2TFLr3ecis0bOE+T2ncq6IPUL1hF8BGfptmVZMHvBnliAzdpB/2D304mbU8+6OWC6b4RoXF1e4p0WAQWk/ajx7B6pG97VZxX5Im10MCx9NnHry5CG8fYwcEgNPjF8tQv1GMDxWm7i1z0eZ/eNEtIaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791272663; c=relaxed/simple;
	bh=KYCrg8lei3GISBkYSJelPoRWoVQUHdc8xI8s5o38nio=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=gEhv3vbOQVwPY6nyl3oRxya8rgzQCbW0/kMFkTkDvDiIeotuv1wC7fN7YMBiAcOSfC+WDMZHenspeZNlU26VNKPN4qOZM0UW/6vMNflTwyfl3+3owdoKDqups8iM3uR2wlO3HmZ//80HVVQHUvjw6sJUjDBe6pSAbxps5nlv82o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JSd/voYV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JSd/voYV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D349B1F000FF;
	Tue,  6 Oct 2026 07:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791272662;
	bh=QVJC1UFEpLjU+sDEPTOif4keMiMa7f7Xy2qqtbfC1E0=;
	h=Subject:To:Cc:From:Date;
	b=JSd/voYV6sMIxWaG4gPkvTI/xaC+WWyyPdFSvvWuzug9lvfQ/SDOP0/KsPxxjFgHC
	 TKcNUklbN1oNK15zdDN+8p2Nez4FhtcwIjdJsL3n5Ml8aWIUBN48AlqZnlNqV+f8xy
	 Ka7yeSbGfSjvFgE7JkvWwFXN78+LSeirr15dOZzg=
Subject: FAILED: patch "[PATCH] iio: adc: aspeed: propagate reset deassert errors" failed to apply to 6.1-stable tree
To: pengpeng@iscas.ac.cn,jonathan.cameron@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 06 Oct 2026 09:44:01 +0200
Message-ID: <2026100601-upcoming-ravine-b302@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 95e4eb426b4bd666fa2f37886c0ddf74a0cc6167
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100601-upcoming-ravine-b302@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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

