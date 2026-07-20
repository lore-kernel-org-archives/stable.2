Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0958437134
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 15:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784562681; cv=none; b=o6G9md4XuP9cSUbHw1ZKuRxHrGwfk8nICVuExqdvYxb80rUS+tVoBJJisrWtehDE+AeDPxip8LYYORaLv7NzhNTRMP+rSq/TKBmfKGgWOCQ10Hu8QMxAkydD+Mmqt/8WwYSjhAnCWEUnblmea6baOIxTFWEEcbY6B3yYUVxoi/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784562681; c=relaxed/simple;
	bh=k2ZBELPnYHkUb6efHUvCPLM8ZD8MHkOr/Hqjm6LAaBU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=DJ3W+GbJ9RbJgVtjh3e2mHWjkKDOGpZgPmEUfaTrOtl1m+Y0ZTeqzuwxOyGC+fwOLAwJMM6E1OttXpNxfQoM7uyOQHlZQadq2BQ9p7Rzm0IdC/ahJWOE1mesYIFALwVip2D3REIPgtWi/lJqwh9ws1kw4xthTcvZ8SbUhqZcG6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1sL8kPf3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1sL8kPf3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12ADF1F000E9;
	Mon, 20 Jul 2026 15:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784562680;
	bh=ZNr8ULW9J39vO0Lh6surBNioMs9DarrXDrBQybxBcxY=;
	h=Subject:To:Cc:From:Date;
	b=1sL8kPf35UGxedTu1WygPaCGaWqHPNL3tfEQHtcA7JUwe5zlodo1YPu7z3ProH9WI
	 +YI2pnqB9cxJ3Ah2h+K8dTemZ6MPi/nLJFy+oZiji9MeDngmbq8yA9BknqYFEIshdp
	 yNZfUM/oMKcDcV6/EbsDrhxwrPZthcDJkxoXWxWA=
Subject: FAILED: patch "[PATCH] Input: ims-pcu - fix race condition in reset_device sysfs" failed to apply to 5.10-stable tree
To: dmitry.torokhov@gmail.com,sashiko-bot@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 17:46:30 +0200
Message-ID: <2026072030-reference-unenvied-28bf@gregkh>
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
git cherry-pick -x 411b8c4b274737c3bf08e1e025801161603cfffc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072030-reference-unenvied-28bf@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 411b8c4b274737c3bf08e1e025801161603cfffc Mon Sep 17 00:00:00 2001
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 22 May 2026 10:29:04 -0700
Subject: [PATCH] Input: ims-pcu - fix race condition in reset_device sysfs
 callback

The ims_pcu_reset_device() sysfs callback calls ims_pcu_execute_command()
without acquiring pcu->cmd_mutex. This can lead to data races and
corruption of the shared command buffer if triggered concurrently with
other commands.

Acquire pcu->cmd_mutex before calling ims_pcu_execute_command().

Fixes: 628329d52474 ("Input: add IMS Passenger Control Unit driver")
Cc: stable@vger.kernel.org
Reported-by: Sashiko bot <sashiko-bot@kernel.org>
Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
index 4f8265c0772f..39bc02ef3e53 100644
--- a/drivers/input/misc/ims-pcu.c
+++ b/drivers/input/misc/ims-pcu.c
@@ -1153,6 +1153,8 @@ static ssize_t ims_pcu_reset_device(struct device *dev,
 
 	dev_info(pcu->dev, "Attempting to reset device\n");
 
+	guard(mutex)(&pcu->cmd_mutex);
+
 	error = ims_pcu_execute_command(pcu, PCU_RESET, &reset_byte, 1);
 	if (error) {
 		dev_info(pcu->dev,

