Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA9B387347
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 09:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788947207; cv=none; b=r13r0TnHHQSn1g7QZcYnWBRSeKcw+Rjhq9W20EAZkX2C7rr/uwyNjYdTx8uVaojFFJ+VwctKHAr/XvYji9D5b2IafeejM5iwdbFHgFHlqoPS5KKTMkQnBohACXidHojY/ceEeB6pWI1ejQGsfXbMkTKzUTtR/A4RIaLPmlPCBbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788947207; c=relaxed/simple;
	bh=TW+a6uxoHxUAyq46frGzHNW99+WdisaSKsB/SC/Eh1I=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GhPJjKmM5cW+vZALwFKsE60gF07fVGdg+N3tTcY5PgYnmVEVYu9gBxIAnXnuV8jo5gp781ijUU3KUQSR6jZsMr4M7sP11N3NBn9Dvtm2ZRm2uDBotk2h//EVt7gzY4sEkKGuvH1Tw8xSZNigb6JpFX/xbe0F7kQhjXtj3Ow3tew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ECu/fRV8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ECu/fRV8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E72021F00A3A;
	Wed,  9 Sep 2026 09:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788947205;
	bh=/Af5FvH+P7PL+cireN63k/LE/z7A1Pb3YAyy95DnKTE=;
	h=Subject:To:Cc:From:Date;
	b=ECu/fRV8MxT/86CPuaoGnQfs0M4r76Y35yxNjrepqv076MtxcFD28ZCu+XFB4Ub9+
	 WvGouGbHqg7hzHRjDRRabfF+8xR6x06oTqP7T735MH7MXe3CWVlizREYDHIipHo77O
	 PrW2N1tmUUK0VuXRCBpGDFr+n66PeGFPmCtmJcVQ=
Subject: FAILED: patch "[PATCH] i2c: qcom-cci: fix autosuspend cleanup" failed to apply to 5.10-stable tree
To: lgs201920130244@gmail.com,andi.shyti@kernel.org,loic.poulain@oss.qualcomm.com,stable@vger.kernel.org,vladimir.zapolskiy@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 11:41:10 +0200
Message-ID: <2026090910-covenant-freestyle-77a9@gregkh>
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
git cherry-pick -x f98d4986482151a835b521a734722fe8dc5ca37d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090910-covenant-freestyle-77a9@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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

