Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44AC3559F8
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 07:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791272758; cv=none; b=BqlP7J8aN8UcTJ2bEINklZtT3hzT3a1rCKivEq/3YCi5S5NRACTLHOS4VS/cFlS3BYCxo8Zeuo1pqK+gf71Q+DOyytHUaVFJfd5MqTFcuHbeVRNmvEUk0ANZmfd0InYfjPVP2QybFfcvEXjWP5opGOwT9J2/Z351dQy4tGyquy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791272758; c=relaxed/simple;
	bh=KOvz/v4s/U9m0HLorDBMf3MThEdZ6v1w16PfZKBYXOM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LGok5J6MvvbPpBoyTUnpFbYxGeH1WdBF0jX62S+CfvWET79VZKI+6GbzUDYL6LOki7j5qPUjjq3QCJyD0QCDjDbv7D8HaU1NbGehg5mni3iEL3Uis2rqa49JooQYsFXL5i3sawya4Who300ShSWAhbhn3NrhmGH318JpxAnzucQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bZSUvtzz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bZSUvtzz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2634C1F000FF;
	Tue,  6 Oct 2026 07:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791272756;
	bh=Bn7rsMlcqddrPMk+hEZhorlOAJo7g2iq7UTb/K5oovA=;
	h=Subject:To:Cc:From:Date;
	b=bZSUvtzzxUhuz7B8bC6cuHHlKlyPXOxRVKfGPYeQXqM4R2JRZH/bLMIQcHIApum5o
	 8i4fs+cHs5HdfHIFSwRoGyWFT2wzbLy7p349OXozCIMLbVIPf5n5Hp3rC/EXOQLNkr
	 ldZTPNW8aDH2h2zLImb7+teIOMgnKVJNQZtRT+Sg=
Subject: FAILED: patch "[PATCH] iio: admv1013: initialize callback mutex before registering" failed to apply to 6.1-stable tree
To: runyu.xiao@seu.edu.cn,jonathan.cameron@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 06 Oct 2026 09:45:46 +0200
Message-ID: <2026100645-same-galvanize-380b@gregkh>
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
git cherry-pick -x baf7e43b7fb5afb777353bf265ddf9d909f72b9f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100645-same-galvanize-380b@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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

