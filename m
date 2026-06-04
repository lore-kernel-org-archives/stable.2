Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5D7403EB6
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 10:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780569893; cv=none; b=cZtM3jd5+eRfXejUNtvxudyHOq7hCj3RLE8lVZ8qcH3H0WNHbcfTp+0ycJF1Y3EUubKIOOBKyWn6+ZW1jctbHWFJokn2mUdS5H7spnKZ7f3hsmCebVBYqpsEwN7bJwNZQFZStAdyTO/ptGog96IHz9ofRmC/OMdDKa8CcyFpuJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780569893; c=relaxed/simple;
	bh=5iH1iP/szr1wKD3jwKuSEanUUgjrA2bA0fnxt0g90fQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=peclaCy6crdGDdpwGL+EpXwL2yKvB+LSC9miy+Ip/3RU0Xt6fUF5SyHHVWRkj6lJ0SQwloQ9mPSHTFQ1iUoyTwZ2c0z9QlMqGw5A/jsCOzu1hopUXamv9FXIUU22YyU6Qae+4qUdd2V21oJQbqtF4ZqM36r+VqwSoF8hCecV8/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QIcTzeuy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QIcTzeuy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C08E11F00893;
	Thu,  4 Jun 2026 10:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780569892;
	bh=FysDGgklq/MIEzx0ocvrBaHUUyzzlHgB8/zz4ldoIfk=;
	h=Subject:To:Cc:From:Date;
	b=QIcTzeuyA8r7gaLUmkuVueT4EViypJDErjb+YX02Qv8ptDbAUtP0VYmE5bhHDuUKN
	 KMLEuTNb4/ODYDoPZfTAOTN1yJEAIFGFw5MH9VC2FmphRByGwYet9Xczo7FOFMzVK1
	 0+pYpy+3OIhVz+x5zfIcSbJfkwWhF0XeLCcWqU/E=
Subject: FAILED: patch "[PATCH] usb: musb: omap2430: Fix use-after-free in omap2430_probe()" failed to apply to 6.12-stable tree
To: vulab@iscas.ac.cn,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 04 Jun 2026 12:42:37 +0200
Message-ID: <2026060437-sharper-renter-2852@gregkh>
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
git cherry-pick -x e194ce048f5a6c549b3a23a8c568c6470f40f772
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026060437-sharper-renter-2852@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e194ce048f5a6c549b3a23a8c568c6470f40f772 Mon Sep 17 00:00:00 2001
From: Wentao Liang <vulab@iscas.ac.cn>
Date: Thu, 9 Apr 2026 10:11:04 +0000
Subject: [PATCH] usb: musb: omap2430: Fix use-after-free in omap2430_probe()

In omap2430_probe(), of_node_put(np) is called prematurely before the
last access to np, leading to a use-after-free if the node's reference
count drops to zero. Move the of_node_put() calls after the last use of
np in both the success and error paths.

Fixes: ffbe2feac59b ("usb: musb: omap2430: Fix probe regression for missing resources")
Cc: stable <stable@kernel.org>
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Link: https://patch.msgid.link/20260409101104.480623-1-vulab@iscas.ac.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 48bb9bfb2204..333ab79f0ca9 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -337,7 +337,6 @@ static int omap2430_probe(struct platform_device *pdev)
 	} else {
 		device_set_of_node_from_dev(&musb->dev, &pdev->dev);
 	}
-	of_node_put(np);
 
 	glue->dev			= &pdev->dev;
 	glue->musb			= musb;
@@ -455,6 +454,7 @@ static int omap2430_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "failed to register musb device\n");
 		goto err_disable_rpm;
 	}
+	of_node_put(np);
 
 	return 0;
 
@@ -464,6 +464,7 @@ static int omap2430_probe(struct platform_device *pdev)
 	if (!IS_ERR(glue->control_otghs))
 		put_device(glue->control_otghs);
 err_put_musb:
+	of_node_put(np);
 	platform_device_put(musb);
 
 	return ret;

