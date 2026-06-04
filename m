Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A82E37DE84
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 10:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780569897; cv=none; b=imBq9ulQAiueEqorHkkx0CIyIR7mUgCl5txEfvbC3g1m1sHf6yDpW1vfFVit8drH1JajPJPYW0+uv5iir0KJVuaTJBMc9i6pmaXjkxrS0WcbA3P622HEepqAG3gW9chACauYMvbdHDZNY3mFSMCRbRuP38g/h65e4CoNjsH5rMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780569897; c=relaxed/simple;
	bh=0ygn6hQLilrVIzyhJmLLb6g9JP2fkilMa69YCB2OCYc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=f+5c0zj9u9gq5Q9cxaahhP4PsIP7ce9zFrO+P6SYrE1akk7YaNqGC8bypY0M3MDlrVFVyvpRmQ3/lZDabx+Q0JQjdcxU3b2C3eeqIdc2wj+Th0GSIXuCAccSw1todHjVIFhejRkeqCB4ThkBDoO+usQOxiJUPFZZt0MASQAzWYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=i/jw9X1A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i/jw9X1A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6490A1F00893;
	Thu,  4 Jun 2026 10:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780569896;
	bh=td3XgDPdcHYf4mA3bw4GajBC/C+Csv86uhaqM80quyk=;
	h=Subject:To:Cc:From:Date;
	b=i/jw9X1AHEtBkJvNQMyR7PQYEX3BvFxrSHSkXmptyZnbnm19m7SEMJDk+Wbb8PwvS
	 rSEjmLzM1RmZ1GbaQcQeAb7HOtpe6FnJ3l0iZ0B7HeYQLFLzVDWWkczIFFWpCrmPGH
	 8VvQb9CftOKAKa9CoZbBkZeg3AeVueSOo8CHljOE=
Subject: FAILED: patch "[PATCH] usb: musb: omap2430: Fix use-after-free in omap2430_probe()" failed to apply to 6.1-stable tree
To: vulab@iscas.ac.cn,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 04 Jun 2026 12:42:38 +0200
Message-ID: <2026060438-crispy-channel-2856@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x e194ce048f5a6c549b3a23a8c568c6470f40f772
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026060438-crispy-channel-2856@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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

