Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D797140911C
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 15:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781538697; cv=none; b=pyV0CXBjN+ma2Ko8/EEcH/eRBPcEuUVgcBA9tt/OUKUxz+XHXim1+vuUMrsAwsDucuz7Vu8Ge344fCJFKJTA6mk3+dgKNGdbuJyKdfUSYz2zBucK2LxZN+oqb9oB/Fn69YEOxVm6gSCtL4xe/BSfZ/EMAaEqA57GVBEg9VYJurw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781538697; c=relaxed/simple;
	bh=kUGYot5CzmIsun+R2Ed1GrqGdODWEXxDqRs6zHd5NCw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=bSeqpmiliTtKZruX6Xs1fuqJqOhv8bNWg9+/mUajSj0SXjLtAW+thuToD+W17iW4DLCjeIaDPwZdg3ScwmDhGsOIphCJ2WM2MVCSbYUl5d1OXRCgp9Ja8QJx59b8ij2gREP45XdaxtwjGtzuygy2ESWzqilLsLwyZz5gUdM7xlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HCEgejKC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HCEgejKC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AB401F000E9;
	Mon, 15 Jun 2026 15:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781538696;
	bh=PWNrh8OF/kdHXt706g29n/vwBHR9SpdRg28F0cG8o5A=;
	h=Subject:To:Cc:From:Date;
	b=HCEgejKC1m4HgpOWBSUyEU9Mm08GGhHbhCEo04Pj32CJa6RxxriFZckOmfhaFXfiM
	 PNVmuWps5+iy4ce5yeFmL7LdaVkFK3NY1gTDlizbFoRkDPv+pb0JpC2KH8y2jjwd4c
	 vDjc89GxKN6HLGapNxz4ZpMGlcz2xfsY/X3fkIKU=
Subject: FAILED: patch "[PATCH] slimbus: qcom-ngd-ctrl: fix OF node refcount" failed to apply to 5.15-stable tree
To: bartosz.golaszewski@oss.qualcomm.com,gregkh@linuxfoundation.org,srini@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jun 2026 17:45:54 +0200
Message-ID: <2026061554-verse-rekindle-3ba2@gregkh>
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
git cherry-pick -x 120134fe75c6b0ae38f14eb8b548ad1e5761f912
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061554-verse-rekindle-3ba2@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 120134fe75c6b0ae38f14eb8b548ad1e5761f912 Mon Sep 17 00:00:00 2001
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Sat, 30 May 2026 21:44:14 +0100
Subject: [PATCH] slimbus: qcom-ngd-ctrl: fix OF node refcount

Platform devices created with platform_device_alloc() call
platform_device_release() when the last reference to the device's
kobject is dropped. This function calls of_node_put() unconditionally.
This works fine for devices created with platform_device_register_full()
but users of the split approach (platform_device_alloc() +
platform_device_add()) must bump the reference of the of_node they
assign manually. Add the missing call to of_node_get().

Cc: stable@vger.kernel.org
Fixes: 917809e2280b ("slimbus: ngd: Add qcom SLIMBus NGD driver")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
Link: https://patch.msgid.link/20260530204421.116824-2-srini@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 1ed6be6e85d2..428266949fdd 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1542,7 +1542,7 @@ static int of_qcom_slim_ngd_register(struct device *parent,
 			kfree(ngd);
 			return ret;
 		}
-		ngd->pdev->dev.of_node = node;
+		ngd->pdev->dev.of_node = of_node_get(node);
 		ctrl->ngd = ngd;
 
 		ret = platform_device_add(ngd->pdev);

