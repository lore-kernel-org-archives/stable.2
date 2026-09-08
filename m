Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD9B53ED04
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 12:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788872129; cv=none; b=OE+YLwIKdvrW+xoyW0SgPabXfbB39CvwllQIVd2Hf/2Y7pMsb6FUgJdVQjD+eL2zT5UR73fI8/96luUXXHAR9YXn2S1C4iNr6rP0oxAlJPWfCO8xCeuMb1kCVMORzMO8xCKc9QN8whIr0YiHFLq0vMTwGHvOk+fNIF59r9VdW6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788872129; c=relaxed/simple;
	bh=FVlUheFK6R9W6ulhfjfASRoZHwSZRjHyCI/zW1P4SUs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=BvHPqNIWK0HfO55dnYmJ9HYGW7+KpMo+LTnY2aCu6wwj0uONQBAOQApvOiMZzfWHODkXEAvqnFHrarYuMzAX/JviACFVKhGAAlN8/ahRR4dqsggYF1I9vsBhZPA450coPrWTrZAyI2YlRN+BUOYe7rG3trGX7bdfvDEerCorSGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tuJplCWT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tuJplCWT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4B201F00A3A;
	Tue,  8 Sep 2026 12:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788872128;
	bh=Go5iPBSdamBIVVNNQYS1jmE33mmrsjADBdwV9ME/XjY=;
	h=Subject:To:Cc:From:Date;
	b=tuJplCWTPrje+lGqWUfn1ZKliAKSiwIY5j9X2gUiZJxwlHfpshwkD2jdVdotY6zhj
	 jyEQknvf4g0Z+n24hL0TzOhYomNROJJqg+D7r7SQ0VyNf0U/BRRKRHDvOdOMHRVzOo
	 f5whwuleY3Rpi8xf1MfimLq2+Bxcesrb2PSx6/4E=
Subject: FAILED: patch "[PATCH] spi: bcm63xx: disable clock on resume failure" failed to apply to 6.1-stable tree
To: pengcan@kylinos.cn,broonie@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Sep 2026 14:46:43 +0200
Message-ID: <2026090843-repaint-untwist-90f3@gregkh>
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
git cherry-pick -x 2b62c2c134fa32d9d3a9e7323c8ac74518eeb4ac
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090843-repaint-untwist-90f3@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2b62c2c134fa32d9d3a9e7323c8ac74518eeb4ac Mon Sep 17 00:00:00 2001
From: Can Peng <pengcan@kylinos.cn>
Date: Tue, 4 Aug 2026 15:18:31 +0800
Subject: [PATCH] spi: bcm63xx: disable clock on resume failure

bcm63xx_spi_resume() enables the controller clock before restarting the
SPI controller queue.

If spi_controller_resume() fails, the function currently reports success
and leaves the clock enabled. Propagate the error and disable the clock
before returning.

Fixes: b42dfed83d95 ("spi: add Broadcom BCM63xx SPI controller driver")
Cc: stable@vger.kernel.org
Signed-off-by: Can Peng <pengcan@kylinos.cn>
Link: https://patch.msgid.link/20260804071831.860784-1-pengcan@kylinos.cn
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index 8cef725aab26..1d8e257bad30 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -653,7 +653,11 @@ static int bcm63xx_spi_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	spi_controller_resume(host);
+	ret = spi_controller_resume(host);
+	if (ret) {
+		clk_disable_unprepare(bs->clk);
+		return ret;
+	}
 
 	return 0;
 }

