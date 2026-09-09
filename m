Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114BD3F23AF
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 09:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788947204; cv=none; b=bQm4GTdskXgwUGTfxcMmZcfadhU33KfOqMjqxtFeFhb4+VwEB24y2NhGbcvdYzqpq9oA217DWOrHr4Hr46lPnNFEtsgTS4OFdjjiE2iSqA9ku7SWQ6BeNxzIpJh0dGz31Yt94OdSJakC8skSgDb+x1VX8nW06KP6KouAVqd9o8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788947204; c=relaxed/simple;
	bh=GPQJGaPuyRcBWylPw0zPPue6vhfO8q2Evp+ESX6tfc4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cWBeRHA5NlP2NrmWyHCxnYoMQs1uv1OuqfmVDWzjQQKaKTNFooiZdxqSt7Y65GBOqMOMUQr4TjkosuBHNdTYehkocSLemKSM9rcTJLAxIu93aOf2Xjnh1glfZV2sJ3tcSIzOpfObXHqGqBsvWGow2d8Ivo6sUBBZ+O87JlYS1Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yVuxvOKV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yVuxvOKV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 166931F00A3A;
	Wed,  9 Sep 2026 09:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788947202;
	bh=9+isqAcISkuAeydl5kOX0Dv99prJLQXMeYcf/+0CX/c=;
	h=Subject:To:Cc:From:Date;
	b=yVuxvOKVDHb27HilQaKuUM+x0ym6lOMY3tXAMDUYKde/a3u6QankDZKdVv2JBUyVN
	 0tyhvvdWxzdwNVtDZQVXGuCl0MjwXXL4mIq+KU8wtjcqRqqW7yuMiy1pDM0Kues6nP
	 jR1gQWIadM1QM6MzguVHs/7GSJdVKHwIywloZ7UM=
Subject: FAILED: patch "[PATCH] i2c: qcom-cci: fix autosuspend cleanup" failed to apply to 6.1-stable tree
To: lgs201920130244@gmail.com,andi.shyti@kernel.org,loic.poulain@oss.qualcomm.com,stable@vger.kernel.org,vladimir.zapolskiy@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 11:41:09 +0200
Message-ID: <2026090909-unmarked-juggling-ce1d@gregkh>
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
git cherry-pick -x f98d4986482151a835b521a734722fe8dc5ca37d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090909-unmarked-juggling-ce1d@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f98d4986482151a835b521a734722fe8dc5ca37d Mon Sep 17 00:00:00 2001
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Wed, 12 Aug 2026 17:44:25 +0800
Subject: [PATCH] i2c: qcom-cci: fix autosuspend cleanup

cci_probe() calls pm_runtime_use_autosuspend(), but the remove path
does not call the matching pm_runtime_dont_use_autosuspend() before
disabling runtime PM.

If the autosuspend delay is set to a negative value while autosuspend
is enabled, the runtime PM core increments usage_count to prevent
runtime suspend. Without undoing the autosuspend setting during
teardown, this reference is not dropped and usage_count remains
unbalanced.

Use devm_pm_runtime_set_active_enabled() to manage the runtime PM
state. Its managed cleanup disables autosuspend and runtime PM and
restores the suspended state on probe failure and driver removal.
Remove the now redundant manual runtime PM cleanup.

This issue was found by manual code inspection.

Fixes: e517526195de ("i2c: Add Qualcomm CCI I2C driver")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
Cc: <stable@vger.kernel.org> # v5.8+
Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Link: https://patch.msgid.link/20260812094425.3515179-1-lgs201920130244@gmail.com

diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
index bdeda3979c48..25b6e4e9e3fa 100644
--- a/drivers/i2c/busses/i2c-qcom-cci.c
+++ b/drivers/i2c/busses/i2c-qcom-cci.c
@@ -595,9 +595,11 @@ static int cci_probe(struct platform_device *pdev)
 		goto disable_clocks;
 
 	pm_runtime_set_autosuspend_delay(dev, MSEC_PER_SEC);
+	ret = devm_pm_runtime_set_active_enabled(dev);
+	if (ret)
+		goto disable_clocks;
+
 	pm_runtime_use_autosuspend(dev);
-	pm_runtime_set_active(dev);
-	pm_runtime_enable(dev);
 
 	for (i = 0; i < cci->data->num_masters; i++) {
 		if (!cci->master[i].cci)
@@ -613,8 +615,6 @@ static int cci_probe(struct platform_device *pdev)
 	return 0;
 
 error_i2c:
-	pm_runtime_disable(dev);
-	pm_runtime_dont_use_autosuspend(dev);
 
 	for (--i ; i >= 0; i--) {
 		if (cci->master[i].cci) {
@@ -640,9 +640,6 @@ static void cci_remove(struct platform_device *pdev)
 			cci_halt(cci, i);
 		}
 	}
-
-	pm_runtime_disable(&pdev->dev);
-	pm_runtime_set_suspended(&pdev->dev);
 }
 
 static const struct cci_data cci_v1_data = {

