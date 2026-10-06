Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5834437DEBC
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 07:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791272749; cv=none; b=s8Pup16ED/ZdWb9BlZ9IZlVxug9gVg7Os+QMArV2Skg3fC5knuBg7kwYRF7BGlafDAUFRv6KQUctf5IU1UAEqGWPmbesNOd9WR3CLT7IxKtzYxKSp+He3OsH0LAJL1JvP4U+VaA0pSY326/JwxJaB4PFVMzxRkGt3DriDIc/Mgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791272749; c=relaxed/simple;
	bh=bPjwTyFApigzajjCrPwmhVP4QYbXhJw+FrowzJptPZ8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jdDNxZsSROfx8omXQk1qBRbhqHQ/dDLSMpIVFJIesY//gGfK8O24GeCWDVX5eA4XX/PsGUVv6p56uXDM0N+Wqsd0fCg6MsyfxefI4wkrfL05ybWO7lDPSzFr/pBHTjuthziNiwEny3qFEHGLpEPHB0b2Vyf4ev3YonwuBQVVQ/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lm4IPrqz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lm4IPrqz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6BFE1F000FF;
	Tue,  6 Oct 2026 07:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791272748;
	bh=rguCOItBF9Vv46px6IKAdfexsa5kxtG+ZEMjSN9IxxA=;
	h=Subject:To:Cc:From:Date;
	b=lm4IPrqzBCmkq/QJZDzvuFk9avWOzedXbMhO7Lw1jch2zAqoPH2gJ67GSt+LoGsdi
	 p+7zBavpDV6UD/Jd9pupe4X5EDNeNBKTA9wNS58tSIpyuCL0BTRuq34uaTH4yTNNJD
	 tJRJIrfXWu5cWubVUAKxbwfDP7BBwBOUuJdkHazM=
Subject: FAILED: patch "[PATCH] iio: admv1013: initialize callback mutex before registering" failed to apply to 6.6-stable tree
To: runyu.xiao@seu.edu.cn,jonathan.cameron@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 06 Oct 2026 09:45:45 +0200
Message-ID: <2026100645-snide-neatness-caed@gregkh>
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
git cherry-pick -x baf7e43b7fb5afb777353bf265ddf9d909f72b9f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100645-snide-neatness-caed@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From baf7e43b7fb5afb777353bf265ddf9d909f72b9f Mon Sep 17 00:00:00 2001
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
Date: Wed, 19 Aug 2026 22:17:51 +0800
Subject: [PATCH] iio: admv1013: initialize callback mutex before registering
 notifier

admv1013_probe() registers a clock notifier whose callback takes st->lock
on POST_RATE_CHANGE. Initialize the mutex before
devm_clk_notifier_register() so the callback cannot observe an
uninitialized lock during probe.

Use devm_mutex_init() so the lock lifetime is tied to the device and
cleanup stays paired with the rest of the managed probe resources.

Fixes: da35a7b526d9 ("iio: frequency: admv1013: add support for ADMV1013")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

diff --git a/drivers/iio/frequency/admv1013.c b/drivers/iio/frequency/admv1013.c
index c9baaab574e3..cdf33ccfd1f9 100644
--- a/drivers/iio/frequency/admv1013.c
+++ b/drivers/iio/frequency/admv1013.c
@@ -601,11 +601,14 @@ static int admv1013_probe(struct spi_device *spi)
 				     "failed to get the LO input clock\n");
 
 	st->nb.notifier_call = admv1013_freq_change;
-	ret = devm_clk_notifier_register(dev, st->clkin, &st->nb);
+
+	ret = devm_mutex_init(dev, &st->lock);
 	if (ret)
 		return ret;
 
-	mutex_init(&st->lock);
+	ret = devm_clk_notifier_register(dev, st->clkin, &st->nb);
+	if (ret)
+		return ret;
 
 	ret = admv1013_init(st, vcm_uv);
 	if (ret)

