Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33C74A3413
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 13:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783000218; cv=none; b=fPLaG1J5rCs/C7W8+3/0QhOqhZM6QR9qlf5SRSvvGocKT2YsLcqfdLMi8UdIShY3LgGIxBt8EC4xMqP2u2N10Dm5sHqlD5VDvpWvkRa0xrmMEnUtyB+vj00eVs+K66Kqz8pCyUUyL36UhXUF66wyMGM4gW9bAMzSE3AxQqfqTZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783000218; c=relaxed/simple;
	bh=WzanjI2H+ieCUY6SvPm+hT9mgTCkjkhZJ5KP+jkZHdg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=on2abxS4cGKu03iuKe+ypgiS8oHWCCTEZ4Pq/2f3Tt8ZtLAnu2Tm0kbRyJhcRFfujwFMDCYQmLYLzhY2LYBoxdrPaYnU8NNOXfDQpazX4yZgzllz1xq+OD1pImxvwhQ/KbILVR0vcYFPReDNGdF5wGty0yqxDmqzXfVwPsIF7og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yGDCmtgW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yGDCmtgW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7D9F1F000E9;
	Thu,  2 Jul 2026 13:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783000217;
	bh=koKAdAZQdXaeH8QYPXGHkCRgtQPCc7k7GvdjzySpiuY=;
	h=Subject:To:Cc:From:Date;
	b=yGDCmtgWyPhBW4RqEwp+x9uCEWJigponi0PdIX53ZR4AA8lYX3PMWRb2phsODvkxx
	 YeYL5peYSVnkyCERBMij3h/NS0Di2x6DdBNr3Xrm06LJxTiHJzZs/YWI9Vlp/uqJ2O
	 qPmee527xKlbv244j5gHV4gZTkS/cTGJs6Z2UObk=
Subject: FAILED: patch "[PATCH] rpmsg: char: Fix use-after-free on probe error path" failed to apply to 6.1-stable tree
To: dbgh9129@gmail.com,mathieu.poirier@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 02 Jul 2026 15:50:28 +0200
Message-ID: <2026070228-dwelled-nurture-5733@gregkh>
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
git cherry-pick -x 1ff3f528e67d20e2b1483dcaba899dc7832b2e6b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026070228-dwelled-nurture-5733@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1ff3f528e67d20e2b1483dcaba899dc7832b2e6b Mon Sep 17 00:00:00 2001
From: Yuho Choi <dbgh9129@gmail.com>
Date: Mon, 1 Jun 2026 14:32:47 -0400
Subject: [PATCH] rpmsg: char: Fix use-after-free on probe error path

rpmsg_chrdev_probe() stores the newly allocated eptdev in the default
endpoint's priv pointer before calling rpmsg_chrdev_eptdev_add(). If
rpmsg_chrdev_eptdev_add() then fails, its error path frees eptdev while
the default endpoint may still dispatch callbacks with the stale priv
pointer.

Avoid publishing eptdev through the default endpoint until
rpmsg_chrdev_eptdev_add() succeeds. Messages received before the priv
pointer is published should be ignored by rpmsg_ept_cb(). Flow-control
updates can hit rpmsg_ept_flow_cb() in the same window, so make both
callbacks return success when priv is NULL.

Fixes: bc69d1066569 ("rpmsg: char: Introduce the "rpmsg-raw" channel")
Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20260601183247.1962010-1-dbgh9129@gmail.com
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
index ca9cf8858a5e..bff5aefee212 100644
--- a/drivers/rpmsg/rpmsg_char.c
+++ b/drivers/rpmsg/rpmsg_char.c
@@ -104,6 +104,9 @@ static int rpmsg_ept_cb(struct rpmsg_device *rpdev, void *buf, int len,
 	struct rpmsg_eptdev *eptdev = priv;
 	struct sk_buff *skb;
 
+	if (!eptdev)
+		return 0;
+
 	skb = alloc_skb(len, GFP_ATOMIC);
 	if (!skb)
 		return -ENOMEM;
@@ -124,6 +127,9 @@ static int rpmsg_ept_flow_cb(struct rpmsg_device *rpdev, void *priv, bool enable
 {
 	struct rpmsg_eptdev *eptdev = priv;
 
+	if (!eptdev)
+		return 0;
+
 	eptdev->remote_flow_restricted = enable;
 	eptdev->remote_flow_updated = true;
 
@@ -490,6 +496,7 @@ static int rpmsg_chrdev_probe(struct rpmsg_device *rpdev)
 	struct rpmsg_channel_info chinfo;
 	struct rpmsg_eptdev *eptdev;
 	struct device *dev = &rpdev->dev;
+	int ret;
 
 	memcpy(chinfo.name, rpdev->id.name, RPMSG_NAME_SIZE);
 	chinfo.src = rpdev->src;
@@ -502,13 +509,17 @@ static int rpmsg_chrdev_probe(struct rpmsg_device *rpdev)
 	/* Set the default_ept to the rpmsg device endpoint */
 	eptdev->default_ept = rpdev->ept;
 
+	ret = rpmsg_chrdev_eptdev_add(eptdev, chinfo);
+
+	if (ret)
+		return ret;
 	/*
 	 * The rpmsg_ept_cb uses *priv parameter to get its rpmsg_eptdev context.
-	 * Storedit in default_ept *priv field.
+	 * Stored it in default_ept *priv field.
 	 */
 	eptdev->default_ept->priv = eptdev;
 
-	return rpmsg_chrdev_eptdev_add(eptdev, chinfo);
+	return 0;
 }
 
 static void rpmsg_chrdev_remove(struct rpmsg_device *rpdev)

