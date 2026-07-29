Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F161B486B9E
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 13:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785330253; cv=none; b=WYRHpbjXuFrXlmKk3V6mMWGxJPGjoYbS0SGy3NU/kXo9Wv/dBglvD2RqcKtMipWJWwVHlimeiSeStN6iOeyXah0q2JNtjxdJi6KNbjFdEdVnxpme3PNzUdoWGASloPHhgfMuER4CmGhAi7DWfQGBPrdkBgdxlQRIGPGcJVEhVlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785330253; c=relaxed/simple;
	bh=IEUTPr07ysCU4KMH2wRgHYTtLQ6Cs8WYYWSMuLsromg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=aCgmnnIqs0dBqDSn96eyLY/wrmFU8l5IX9GUj2c2YobYbxn7cZSAuAMBN15ijI9c/XTtDJy0eBLel7VUKAx8fOKRxgzJ18UIFVbeFeEzUflsPWNJEXIit5i+mb5twoX0cJujrioa/Ng5Qd7/UBXWM5BGZuM4MDz7niniWMpXu+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NwZpWWWe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NwZpWWWe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BA1E1F000E9;
	Wed, 29 Jul 2026 13:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785330251;
	bh=kJVadQ95c+uQcAxRQ84iQsGscCW3T7t/waxb6SXMVQg=;
	h=Subject:To:Cc:From:Date;
	b=NwZpWWWeoIpiSyGWX7CDXsJwhLT2ESI5eDzoGNdvgdX+biNVvVpgD1WNIc0EBw5xP
	 C/L6tovo/nZFuNxVoiWaVuWqd2pmnrYnsK7NPcrrwiek53skLD9tpdwPwIz5iTSnBP
	 +kd8hNMcs/Z9wj20zBMgOJT+qZ+qKmY0iaK+Ml/o=
Subject: FAILED: patch "[PATCH] media: vpif_capture: fix OF node reference imbalance" failed to apply to 5.15-stable tree
To: johan@kernel.org,hverkuil+cisco@kernel.org,khilman@baylibre.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 15:03:58 +0200
Message-ID: <2026072958-overhear-annually-0708@gregkh>
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
git cherry-pick -x 2282f979560af6bbc8ee2c1ee8663197312cee5b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072958-overhear-annually-0708@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2282f979560af6bbc8ee2c1ee8663197312cee5b Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Tue, 7 Apr 2026 12:08:31 +0200
Subject: [PATCH] media: vpif_capture: fix OF node reference imbalance

The driver reuses the OF node of the parent device but fails to take
another reference to balance the one dropped by the platform bus code
when unbinding the parent and releasing the child devices.

Fix this by using the intended helper for reusing OF nodes.

Fixes: 4a5f8ae50b66 ("[media] davinci: vpif_capture: get subdevs from DT when available")
Cc: stable@vger.kernel.org	# 4.13
Cc: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>

diff --git a/drivers/media/platform/ti/davinci/vpif_capture.c b/drivers/media/platform/ti/davinci/vpif_capture.c
index 15df3ea2f77e..91cb6223561a 100644
--- a/drivers/media/platform/ti/davinci/vpif_capture.c
+++ b/drivers/media/platform/ti/davinci/vpif_capture.c
@@ -1498,7 +1498,7 @@ vpif_capture_get_pdata(struct platform_device *pdev,
 	 * video ports & endpoints data.
 	 */
 	if (pdev->dev.parent && pdev->dev.parent->of_node)
-		pdev->dev.of_node = pdev->dev.parent->of_node;
+		device_set_of_node_from_dev(&pdev->dev, pdev->dev.parent);
 	if (!IS_ENABLED(CONFIG_OF) || !pdev->dev.of_node)
 		return pdev->dev.platform_data;
 

