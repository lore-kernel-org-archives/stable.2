Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B7252E069
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788951659; cv=none; b=qN3Jqke3zvZffT4+sSGrVhdpsdHo06xjAzNn2v/VFr3gRqTYcZgCic+q0lCaKjlNG/gbt/8u3NL5hAxyFwR3IdtPBJj3NBigYP0JcL+MBJHibs7qVGCMCt1aT0dMLf6wZyqH9lVnEq3hQr5MnUjXANTQE7tHkLil2q82jzul92k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788951659; c=relaxed/simple;
	bh=mhY+/CjJvFrvSG/WDIHOwa/gM4FADRNkj1MVRbTOKDo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=PItOhejPxyeiUIDHhb0nuW++y5TAgMfOGHnp4dsINYUa+ZyS+V4ZYUJHXZN1CVeIus0PLwkS9UtC1+fvib0J4VkIcUBhNZ++pxxAj7kKCCP4fGUBP8Ltm2U3rUj4V/bZmufuuWe0yrDCEshQ8wWjD+MnTkxIuqYLkM9LhCAtqL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R3wdmgE7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R3wdmgE7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B31F21F00A3A;
	Wed,  9 Sep 2026 11:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788951657;
	bh=IOou2BZwh8gQcjPHbFMWPAHZylDhqAzkOPqGC5beSDs=;
	h=Subject:To:Cc:From:Date;
	b=R3wdmgE7enbEV4pNGi3KBzjKrgUkvI2UyfGvc+iwO2r6xxjpyXjgI0oMn2vkCUpwj
	 aLKD4Rn759kDyecwjP4hSHdbwPGln+ktvG2+nFyK+6Q1s98mOFiDxtEtMip+I2vMRX
	 uv05uCSrCwtEmtaElzASjuBDuyri1UcrHPOhB5Kc=
Subject: FAILED: patch "[PATCH] media: qcom: iris: fix runtime PM reference leaks" failed to apply to 7.2-stable tree
To: dennylin0707@gmail.com,bod@kernel.org,dmitry.baryshkov@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 12:53:08 +0200
Message-ID: <2026090908-modulator-ascent-3261@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.2-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.2.y
git checkout FETCH_HEAD
git cherry-pick -x f87d7eda07fca21efe4b96169ae59007db46e60e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090908-modulator-ascent-3261@gregkh' --subject-prefix 'PATCH 7.2.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f87d7eda07fca21efe4b96169ae59007db46e60e Mon Sep 17 00:00:00 2001
From: Hungyu Lin <dennylin0707@gmail.com>
Date: Mon, 8 Jun 2026 08:17:20 +0000
Subject: [PATCH] media: qcom: iris: fix runtime PM reference leaks

Use pm_runtime_resume_and_get() in iris_enable_power_domains()
to avoid leaking a runtime PM usage count on failure.

Also ensure pm_runtime_put_sync() is always called in
iris_disable_power_domains(), even when iris_opp_set_rate()
fails, so runtime PM references remain balanced.

Fixes: bb8a95aa038e ("media: iris: implement power management")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Bryan O'Donoghue <bod@kernel.org>

diff --git a/drivers/media/platform/qcom/iris/iris_resources.c b/drivers/media/platform/qcom/iris/iris_resources.c
index 872bd09656b1..6d3339423eec 100644
--- a/drivers/media/platform/qcom/iris/iris_resources.c
+++ b/drivers/media/platform/qcom/iris/iris_resources.c
@@ -78,20 +78,21 @@ int iris_enable_power_domains(struct iris_core *core, struct device *pd_dev)
 	if (ret)
 		return ret;
 
-	return pm_runtime_get_sync(pd_dev);
+	return pm_runtime_resume_and_get(pd_dev);
 }
 
 int iris_disable_power_domains(struct iris_core *core, struct device *pd_dev)
 {
 	int ret;
+	int pm_ret;
 
 	ret = iris_opp_set_rate(core->dev, 0);
-	if (ret)
-		return ret;
 
-	pm_runtime_put_sync(pd_dev);
+	pm_ret = pm_runtime_put_sync(pd_dev);
+	if (!ret)
+		ret = pm_ret;
 
-	return 0;
+	return ret;
 }
 
 static struct clk *iris_get_clk_by_type(struct iris_core *core, enum platform_clk_type clk_type)

