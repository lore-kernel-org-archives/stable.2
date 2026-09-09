Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA9A36F916
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 09:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788947198; cv=none; b=DW1My+TM7CiN6n5yo1re0JCeRqe8UZjOVjO7OC8MRSgyK1iVLrb9RT+wLiX+6/r/BH4smC+LhtyduGfSc2MISh+jVhBO6quElyH+eZxuslv72SDQBm/MjKluQ+9sILNR8LLoPrlpSdpJRCNncd7PdhnfXjxWBuapcbxpqUoKhRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788947198; c=relaxed/simple;
	bh=VNp/SF+WDzy+ea5eG5vz2GzkWY+CkTgEmMiJqY+IDJM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=m3xPJCeNH4YYPzX8p8rMS8uJJqFQ1n3yfwSo1aQb6TcaqasaBwI9cuI4Y+kQJQGIBgjIon9KvKttY3JOYW/ZWsjzlr7wNPMA9gOwA2y8yRNGh8Tc9G+Tpnup9ZAO2EDjuKvmhsOYa1+O/7IRo8XWon+Q2U1sQnxse4OUdFkI8qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FRC+OUpV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FRC+OUpV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EABE1F00A3A;
	Wed,  9 Sep 2026 09:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788947196;
	bh=H5MowcJCu9cjjw/tw6P7nvHtTQITBme/RGzuDrTjF80=;
	h=Subject:To:Cc:From:Date;
	b=FRC+OUpVXA3L74poSFV0gfitTVeuc/w4wTVYFu43U1SB6j59P3UNGgoxLImCazkHj
	 pEayJ6Xb4aZw2kUm/GYhhFE3toeSbX2kNncs2bWUwK2v3S+sLJz/Ikk1JJ0wK8BUhb
	 V16YQMoQys3iJ87L0LjWxQRkhuEKcvXzUtA1J/ME=
Subject: FAILED: patch "[PATCH] i2c: qcom-cci: fix autosuspend cleanup" failed to apply to 6.18-stable tree
To: lgs201920130244@gmail.com,andi.shyti@kernel.org,loic.poulain@oss.qualcomm.com,stable@vger.kernel.org,vladimir.zapolskiy@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 11:41:08 +0200
Message-ID: <2026090908-bobbing-backlog-313f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x f98d4986482151a835b521a734722fe8dc5ca37d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090908-bobbing-backlog-313f@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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

