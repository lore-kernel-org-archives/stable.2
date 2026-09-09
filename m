Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EC84DC53E
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788951306; cv=none; b=ovUHTwJYxBCYwlcEP3KpauSky9HtpleUUHR8pLz8/GKG/WXer8DOd7jD6BnFrosDkwvrFtb3UpsyE0zG3zVxLPU/S8w/sMk+jQvUTXwdXj204jplnT77B5VUF+Vx3m1sJFmfbWqmlQm9j4Wp6bC+upDhM/NKEwMxuh+MYRnqzKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788951306; c=relaxed/simple;
	bh=om6OhSgYyX6CEN6eegDbDUpv+WdW3MfmxgYuCMQZ12o=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=nXpQmcweSHpH7i1JNdENTLMZzHBbJyoiyo8OJkrMdoRcb2mppdxiOAIjiyyFEC9sKFmMciGPCcWo/Xq8orgQWq+cDL3V0W0JTd9T/dlu8kvhILqdxtNemlRoQSbCJH1bDXOXPwR8jG2qaewKP3AHGe760EdRFuz+hn+XTqXw8Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xy5j8cuj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xy5j8cuj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C1401F00A3A;
	Wed,  9 Sep 2026 10:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788951304;
	bh=hOw3bzuC+48C4zFRV/o9VS88Nd+sM3an2z++g0EaoJM=;
	h=Subject:To:Cc:From:Date;
	b=xy5j8cuj4Y7k4BtvKRgjXQ5i/oWDSraY8iZNP1CkcMo7ClHeg9xtqrIlnFLeVWHFH
	 wRT2SBSiJScFwX1ImbD5u20w1duvkcVCh93M3ui+AuYtmwG5F/OdpHcnFok1FA5kkq
	 DYWs+Lk38duL0soPP+1/HjWqDJmFKqhhDQOB6TT4=
Subject: FAILED: patch "[PATCH] media: imx355: Avoid calling imx355_power_off twice in error" failed to apply to 5.15-stable tree
To: dave.stevenson@raspberrypi.com,sakari.ailus@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 12:46:13 +0200
Message-ID: <2026090913-pedigree-concerned-351d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x ee737bc3ccae7dc713ccaa83ffa46080c6031b3e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090913-pedigree-concerned-351d@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ee737bc3ccae7dc713ccaa83ffa46080c6031b3e Mon Sep 17 00:00:00 2001
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Wed, 15 Jul 2026 12:43:14 +0100
Subject: [PATCH] media: imx355: Avoid calling imx355_power_off twice in error
 path

If v4l2_async_register_subdev_sensor failed, then the sensor had
already been powered down by pm_runtime_idle, but the error path
then also explicitly called imx355_power_off as well. That left
an imbalance in the regulator and clock calls.

Call pm_runtime_idle only after v4l2_async_register_subdev_sensor
succeeds to avoid this.

Fixes: efa5fe19c0a9 ("media: imx355: Enable runtime PM before registering async sub-device")
Cc: stable@vger.kernel.org
Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>

diff --git a/drivers/media/i2c/imx355.c b/drivers/media/i2c/imx355.c
index 27a5c212a527..ac59908f57aa 100644
--- a/drivers/media/i2c/imx355.c
+++ b/drivers/media/i2c/imx355.c
@@ -1822,12 +1822,13 @@ static int imx355_probe(struct i2c_client *client)
 	 */
 	pm_runtime_set_active(imx355->dev);
 	pm_runtime_enable(imx355->dev);
-	pm_runtime_idle(imx355->dev);
 
 	ret = v4l2_async_register_subdev_sensor(&imx355->sd);
 	if (ret < 0)
 		goto error_media_entity_runtime_pm;
 
+	pm_runtime_idle(imx355->dev);
+
 	return 0;
 
 error_media_entity_runtime_pm:

