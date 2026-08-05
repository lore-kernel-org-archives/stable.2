Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EFA436BC6
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 11:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785930241; cv=none; b=CfCtTuYulG7Pp8nu259fTz7icyYh8tfwM24MWQtopTKKMqBPKB0OlTFSpf3JluwjsrzJ0B7jbpiKzgnEiln09teLqXihku2Gap+mglwWP3YopWPvVta3ZYl+Z9Gt1qepyLDTFy7/iZjSfuwCMs4TgGp5spxkNNZQUhUgKlK2TNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785930241; c=relaxed/simple;
	bh=jcCBqzNbT2oi/crR9srg1ia8IQqHd2GGzSBW+7lvdHM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=NWu58CB9/vDeFxZf6jI6ZpBgfIcw1x/QXeYAXYt5SylO3TC/UknM676Qi9wYCySW+fCadsZhxhnZ7IUJeqXHH0MvW4uQv1E/k6net0zXOjhfYVuu69LWZK2e9vnzk/WxQR6hTX6ZhNnNzam0BP3ci79GmMRwJ30nMoo+Vp7zDhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qopzzNpM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qopzzNpM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 670291F000E9;
	Wed,  5 Aug 2026 11:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785930238;
	bh=kdeD2zAR4TCw7swaul7idGuPPcOT9zMrZxYMxVhOAyg=;
	h=Subject:To:Cc:From:Date;
	b=qopzzNpM+bkCpCHoO2qfCx/GBYpjP1rX68FbfXVAD8lAMAl5d/zVwaFFnq5egj8D7
	 7VluDN/u27DoV81uQwR0Ka0vgEross5ujGFpt/mwLeHuQjKQaUOrRVTOYynmF2YKrh
	 Ox4MOQ9RKXtTqU9YQA7VQSDfwz3vJYnEPetOVhsc=
Subject: FAILED: patch "[PATCH] i2c: qcom-cci: drop custom suspend/resume and rely on runtime" failed to apply to 6.12-stable tree
To: wenmeng.liu@oss.qualcomm.com,andi.shyti@kernel.org,konrad.dybcio@oss.qualcomm.com,loic.poulain@oss.qualcomm.com,stable@vger.kernel.org,vladimir.zapolskiy@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 13:43:42 +0200
Message-ID: <2026080542-curse-dispersed-597e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x b08c9857aa1f5f3a81d375d6d4bb1d8b92f22ebc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080542-curse-dispersed-597e@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b08c9857aa1f5f3a81d375d6d4bb1d8b92f22ebc Mon Sep 17 00:00:00 2001
From: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
Date: Thu, 25 Jun 2026 17:42:45 +0800
Subject: [PATCH] i2c: qcom-cci: drop custom suspend/resume and rely on runtime
 PM helpers

cci_resume() unconditionally calls cci_resume_runtime() regardless of
the runtime PM state.

If the device is already runtime-suspended before system suspend,
the clock is re-enabled while runtime_status remains RPM_SUSPENDED.
As a result, pm_request_autosuspend() does not arm the timer,
leaving the clock permanently enabled.

Fixes: e517526195de ("i2c: Add Qualcomm CCI I2C driver")
Signed-off-by: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
Cc: <stable@vger.kernel.org> # v5.8+
Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Link: https://lore.kernel.org/r/20260625-cci-v1-1-a100cda673ce@oss.qualcomm.com

diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
index 4d64895a9e9e..bdeda3979c48 100644
--- a/drivers/i2c/busses/i2c-qcom-cci.c
+++ b/drivers/i2c/busses/i2c-qcom-cci.c
@@ -492,24 +492,8 @@ static int __maybe_unused cci_resume_runtime(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused cci_suspend(struct device *dev)
-{
-	if (!pm_runtime_suspended(dev))
-		return cci_suspend_runtime(dev);
-
-	return 0;
-}
-
-static int __maybe_unused cci_resume(struct device *dev)
-{
-	cci_resume_runtime(dev);
-	pm_request_autosuspend(dev);
-
-	return 0;
-}
-
 static const struct dev_pm_ops qcom_cci_pm = {
-	SET_SYSTEM_SLEEP_PM_OPS(cci_suspend, cci_resume)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
 	SET_RUNTIME_PM_OPS(cci_suspend_runtime, cci_resume_runtime, NULL)
 };
 

