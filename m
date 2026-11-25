Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795610769;
	b=d1lmbZPgDgnM2pu3o0H8FqyUZIedhVN1LzjWpyNQcO512ZRqK+JYUBLI9de1WJRYqs7P
	 PIVVRh5kRs7GHuizJ2i9vp352zFRqZdpKjxBKYU6DoNzGmX9bMTdxBvqgRYsos0uUPMMp
	 zojHo55jj3gRNtbBbC4DEBPmTIgGP+WpAAMqJEElXQcPsIa0VPHhhgqf8gbhS2P5ge0p3
	 qUK6LdUR/p5sXoSwIbJB/NWGk7bvvCZLN3cB60hixxJI6HU9dY1btOycUfJ8bLx9sJyjo
	 Warrp3N/xVS/h3uXaGkh2YYa5KHznmBgdOaAaA7D/u2Qg/9/MrIH4xT4ZY5+FdBrDlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795610769;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=dS+dFFCqikWILpZsseQg2Ng4i5scj/E7/2PSZF4IeGM=;
	b=NIHb4b2iYqiOlPVcowYPa6rU3IxRG/BhdDFtg85cIZcR+mNjCN500ogf6Fj3iRkOc009
	 ugRTW3us+3e4tsXQtbXhCVVFJKISlIyjaUvyOJXrz0ALwS6XsaB9+xluGCJqnLe03PPiQ
	 sHI1FCOiPlS5h/dhD2Hgn4czFUuj01+932M5te0CfRK8I+9C5UpWWxaGCpUtUAw02RD6r
	 tuVe+FQQD7koJbl4+KXXy6cT5PGup2Ohnt8d825r7+DMtNZCKNpfT70HvhjBjygi6+et2
	 WWlk6kiNsJFxI8B+U0jrrm/ZWOupYlffI78173S3vU3mt2KqocV5ncZU4AFCBne6KQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Jy9CS6QI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEB2606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Jy9CS6QI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE9AC1F000CF;
	Wed, 25 Nov 2026 12:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795610768;
	bh=dS+dFFCqikWILpZsseQg2Ng4i5scj/E7/2PSZF4IeGM=;
	h=Subject:To:Cc:From:Date;
	b=Jy9CS6QIdarJ1xEEo/JKKthrnEkLbbLB0kevdg/68zUoZuMcuY3ZeYQBNB3kcUU2o
	 zTESRCaJIofAIKpN1zvIkeDdIcyeyYSui3NRe7OrwI85ng/Dgl9E4AcyVxfbHfW0qU
	 p5HMApB7ZP148gc6xMLuqk3O9g2pRppcEiYStTb4=
Subject: FAILED: patch "[PATCH] iio: proximity: hx9023s: Allocate trigger before requesting" failed to apply to 6.18-stable tree
To: mhun512@gmail.com,ae878000@gmail.com,jonathan.cameron@oss.qualcomm.com,joshua.crofts1@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 13:44:10 +0100
Message-ID: <2026112510-rhyme-sizable-422b@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
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
git cherry-pick -x bfa3b177d839bb303d0187335115b572a2644920
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112510-rhyme-sizable-422b@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From bfa3b177d839bb303d0187335115b572a2644920 Mon Sep 17 00:00:00 2001
From: Myeonghun Pak <mhun512@gmail.com>
Date: Thu, 15 Oct 2026 22:47:35 -0400
Subject: [PATCH] iio: proximity: hx9023s: Allocate trigger before requesting
 IRQ

An IRQ handler that already read trigger_enabled can poll data->trig
after buffer disable. Detaching the virtual IRQ does not join this
physical IRQ, and trigger deselection can drop the consumer reference.
Devres may then free the trigger before joining the handler.

Allocate the trigger before requesting the IRQ so devres joins the
handler before dropping the allocation reference.

This issue was identified as part of our ongoing research while
reviewing kernel code.

Fixes: 60df548277b7 ("iio: proximity: Add driver support for TYHX's HX9023S capacitive proximity sensor")
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
index 0199a6351a46..2a6da557f22e 100644
--- a/drivers/iio/proximity/hx9023s.c
+++ b/drivers/iio/proximity/hx9023s.c
@@ -1133,14 +1133,6 @@ static int hx9023s_probe(struct i2c_client *client)
 		return dev_err_probe(dev, ret, "reg config failed\n");
 
 	if (client->irq) {
-		ret = devm_request_threaded_irq(dev, client->irq,
-						hx9023s_irq_handler,
-						hx9023s_irq_thread_handler,
-						IRQF_ONESHOT,
-						"hx9023s_event", indio_dev);
-		if (ret)
-			return ret;
-
 		data->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
 						    indio_dev->name,
 						    iio_device_id(indio_dev));
@@ -1150,6 +1142,14 @@ static int hx9023s_probe(struct i2c_client *client)
 		data->trig->ops = &hx9023s_trigger_ops;
 		iio_trigger_set_drvdata(data->trig, indio_dev);
 
+		ret = devm_request_threaded_irq(dev, client->irq,
+						hx9023s_irq_handler,
+						hx9023s_irq_thread_handler,
+						IRQF_ONESHOT,
+						"hx9023s_event", indio_dev);
+		if (ret)
+			return ret;
+
 		ret = devm_iio_trigger_register(dev, data->trig);
 		if (ret)
 			return dev_err_probe(dev, ret,

