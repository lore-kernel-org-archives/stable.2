Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D14B40960B
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 15:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781538706; cv=none; b=DCIdvjvUutR/SEZCfAsbix+wvWSkvyHOwjiCZkKTyqZ03tdoVGQvOXX7qdLQyhqKQs+DxL6c4aaBJei/gqMGKMKdFnO7kVgPtmZf0Rpw5TSNVA7wpRJBjpgfXpU9FbjN2PKut4z0Yn2ZAGoeh2aVVLQE6R5q4O//zr+0DCjKOO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781538706; c=relaxed/simple;
	bh=V5Fw2FNJrtiWoIAx22JVJbEtiy6XcOUC6mET2WuTgmA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Ki0Cx/padhh6Azh7EDnpXMVbda93G6ULXcmqQEX8QL3/GjR7D+EgHSrDacfNv4ZowCEcCmv0Rrr7/VWmHo+j2ms6RJyGp1dYyxSHHLGEvF3R0slKI855G0IkV3rbny8B542M//78OQ6AVdXRuxhN1/CLYjNZfJn0FGP8L9mFG9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pRQM1T7G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pRQM1T7G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A68371F000E9;
	Mon, 15 Jun 2026 15:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781538705;
	bh=/kGdT0WBVx8eSjo5pK+ACY9Vrc2a8CnDyFa+8ds3GUM=;
	h=Subject:To:Cc:From:Date;
	b=pRQM1T7GD0UaJ/uw+ZoB4bD+FV4IC7MPEQarnzRCWEBsoKiDDD8XTUlvCuiY7W/sj
	 7zyYMn4UPlubHBAyIHZvLdvioXLxRN1a+xEAq/V5Jui6/4v5ijuR987+FUqRuaBym2
	 sbUbJLdxfcEw+yF4B6fJfNEfRmC8GW+TYJz0LHqY=
Subject: FAILED: patch "[PATCH] slimbus: qcom-ngd-ctrl: fix OF node refcount" failed to apply to 5.10-stable tree
To: bartosz.golaszewski@oss.qualcomm.com,gregkh@linuxfoundation.org,srini@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jun 2026 17:45:56 +0200
Message-ID: <2026061556-wrongly-backless-8e40@gregkh>
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
git cherry-pick -x 120134fe75c6b0ae38f14eb8b548ad1e5761f912
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061556-wrongly-backless-8e40@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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

