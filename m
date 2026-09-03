Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021E64E234C
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788449756; cv=none; b=I9N1mJsDAo7cHv33bMiLKg4YEiwgSZT4/arn9ylglKdlkGUjm0j9MOZzief5/U4gkkn1cFi/TlnGVotESgS8b3NYw1d3fVLyRon7rSQprEYEf/+qaZnFTowYhqhv2EPUE+TS1RBypJlXDlYbrGV5529a/BpZNeo2x1F63AR0tfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788449756; c=relaxed/simple;
	bh=d3hkzAhlJKLo43N+4v8Z8GKn9pTL+3rx3HyQEqHqRJg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=EJA62gHczycEA4upWEvF8/p8OuT+nkith9ZIohytHUOATEYI7Ma+9pjN95N1Q8oWDPhUxZrZrSqADDx2DvXdPgW+HhuKnqL7Bv+eN+ko15MdQiOCvMXL94yERs8BPy58z/VVbiDrxSciq8qv3c2qyqCVsqmY2Rt0aoQeQpUh8R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oinEk214; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oinEk214"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 102D11F000E9;
	Thu,  3 Sep 2026 15:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788449754;
	bh=Qy07b/FwzXUb/7VmLw7S/JyKyiccvh4lqoDGSXM+2O0=;
	h=Subject:To:Cc:From:Date;
	b=oinEk214her2kgpYmXd804BTGJ8DKK8GONK4POvFsiM2y/QnIBQ2CZJ0c10OgCiX8
	 a9Y4/KibooUa8LAhlfUbuJsa31ppBX7d4Nc8jd0h/DXieE5EKbIX2zC4SMxUfeRA8v
	 x+d6FbZJI06plqV5AnFSeCSLtKLqE3/j6FyIXU2M=
Subject: FAILED: patch "[PATCH] power: supply: twl4030_charger: cancel workers via devm" failed to apply to 5.10-stable tree
To: maoyixie.tju@gmail.com,sebastian.reichel@collabora.com,sre@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 17:04:56 +0200
Message-ID: <2026090356-iphone-deviate-2dac@gregkh>
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
git cherry-pick -x 6eba34732524067da2aad5ddfdfbc641ded10e9e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090356-iphone-deviate-2dac@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6eba34732524067da2aad5ddfdfbc641ded10e9e Mon Sep 17 00:00:00 2001
From: Maoyi Xie <maoyixie.tju@gmail.com>
Date: Sat, 25 Jul 2026 15:25:40 +0800
Subject: [PATCH] power: supply: twl4030_charger: cancel workers via devm

bci is devm-allocated. Two workers (bci->work and bci->current_worker)
dereference it. twl4030_bci_remove() disables charging and masks
interrupts. It cancels neither worker. A worker pending at remove() can
run after devm frees bci.

The USB transceiver comes from devm_usb_get_phy_by_node(). devm
unregisters its notifier only after remove() returns. A cancel_work_sync()
in remove() can then race a notifier reschedule. devm_work_autocancel()
and devm_delayed_work_autocancel() avoid that. They cancel the workers
during devm release, before bci is freed.

The current_worker is registered first, since devm will cancel in
reverse order and bci->work can reschedule current_worker.

Suggested-by: Sebastian Reichel <sre@kernel.org>
Fixes: d6ccc442b1210 ("twl4030_charger: Make the driver atomic notifier safe")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20260702172128.2001753-1-maoyixie.tju@gmail.com
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
Link: https://patch.msgid.link/20260725072540.3092504-1-maoyixie.tju@gmail.com
[Move comment about order into the commit message]
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

diff --git a/drivers/power/supply/twl4030_charger.c b/drivers/power/supply/twl4030_charger.c
index 1cace8f73927..c46b22ab8d99 100644
--- a/drivers/power/supply/twl4030_charger.c
+++ b/drivers/power/supply/twl4030_charger.c
@@ -14,6 +14,7 @@
 #include <linux/err.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/devm-helpers.h>
 #include <linux/interrupt.h>
 #include <linux/mfd/twl.h>
 #include <linux/power_supply.h>
@@ -1002,8 +1003,15 @@ static int twl4030_bci_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, bci);
 
-	INIT_WORK(&bci->work, twl4030_bci_usb_work);
-	INIT_DELAYED_WORK(&bci->current_worker, twl4030_current_worker);
+	ret = devm_delayed_work_autocancel(&pdev->dev, &bci->current_worker,
+					   twl4030_current_worker);
+	if (ret)
+		return ret;
+
+	ret = devm_work_autocancel(&pdev->dev, &bci->work,
+				   twl4030_bci_usb_work);
+	if (ret)
+		return ret;
 
 	bci->channel_vac = devm_iio_channel_get(&pdev->dev, "vac");
 	if (IS_ERR(bci->channel_vac)) {

