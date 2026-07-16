Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049CF412BE1
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 12:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784205761; cv=none; b=chFeHAs6n6g/Og/IrVVOPQN7L0qPhPfEVIWejcJ0jjL7TJyRJSO0frtQUO6fhIND+Uyk8EgbYOZb+XwDMFHSiPLs8MZwpcxDIOHBI4Qxdam4LReVe17JPMykVNcl+Oe+fpI0TZjef4w2Ll8s/NBBdBRPJoJx7Sv2BYCUtrkXIqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784205761; c=relaxed/simple;
	bh=5lUfj9tu7iYD2/GheQaU5umq1TVwRzDhumz+2ppA/QY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YTG2CXZIynyIfYn2P59ldb6vjZb8mTB+04KaZGIwnUOSfnPNnpfnW4Yj8G8fGzsjzeqOp6U0ehFV/PThmqOOaAgQ6VPnjReICu976rDjJPxmOA5wQz//zamzUXHrvyw1XtorCLucN2xEFURKo2NEJBc4Z68er48KZ6KmL2yD0no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Wbiya56A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Wbiya56A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 314621F000E9;
	Thu, 16 Jul 2026 12:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784205759;
	bh=ZzL2OCW3EIK5HO0bYvPtOeJxhsn57EXC6iOU0L9MhUY=;
	h=Subject:To:Cc:From:Date;
	b=Wbiya56APOs6DZoF/p7+Te26iRY5nsdRMPEQEg48Zm7XfwRxAZ67T8MrGhCsxDefh
	 C19kVJOz1/A02RAWc4IP/jrRx+FGntZI2QOJp/MFmxiSrChJbvPJPdBwA0Z8SS3eYA
	 vsR+JkfAuKCLMAicQe7yBLoekwSR6OQcf+npkBEg=
Subject: FAILED: patch "[PATCH] i2c: davinci: Unregister cpufreq notifier on probe failure" failed to apply to 5.10-stable tree
To: haoxiang_li2024@163.com,andi.shyti@kernel.org,bartosz.golaszewski@oss.qualcomm.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Jul 2026 14:42:20 +0200
Message-ID: <2026071620-pantyhose-primarily-45ab@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x e43f32816a1b1fe5a86279411626fe3a9be56d45
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071620-pantyhose-primarily-45ab@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e43f32816a1b1fe5a86279411626fe3a9be56d45 Mon Sep 17 00:00:00 2001
From: Haoxiang Li <haoxiang_li2024@163.com>
Date: Wed, 10 Jun 2026 11:05:13 +0800
Subject: [PATCH] i2c: davinci: Unregister cpufreq notifier on probe failure

davinci_i2c_probe() registers a cpufreq transition notifier before adding
the I2C adapter.  If i2c_add_numbered_adapter() fails, the probe error path
releases the device resources without unregistering the notifier.

Add a dedicated error path to unregister the cpufreq notifier after
i2c_add_numbered_adapter() fails.

Fixes: 82c0de11b734 ("i2c: davinci: Add cpufreq support")
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
Cc: <stable@vger.kernel.org> # v2.6.36+
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Link: https://lore.kernel.org/r/20260610030513.2651018-1-haoxiang_li2024@163.com

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index 66c23535656b..0617f416cb0b 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -818,12 +818,14 @@ static int davinci_i2c_probe(struct platform_device *pdev)
 	adap->nr = pdev->id;
 	r = i2c_add_numbered_adapter(adap);
 	if (r)
-		goto err_unuse_clocks;
+		goto err_cpufreq;
 
 	pm_runtime_put_autosuspend(dev->dev);
 
 	return 0;
 
+err_cpufreq:
+	i2c_davinci_cpufreq_deregister(dev);
 err_unuse_clocks:
 	pm_runtime_dont_use_autosuspend(dev->dev);
 	pm_runtime_put_sync(dev->dev);

