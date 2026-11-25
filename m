Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795610772;
	b=WNolpzogX33nPIFpNXLwJASOg2D27uuMX60nvXYjMRgKimi4rBRoek54q5qfBUVQR9wD
	 RbZl2Hg8r5NDERGvywgWKevsgfmaAr+TPUwDfONcremmp7z9mOJ04UF8MGKb3RI4i3Nyq
	 l7e5DNoHMfgYCD5TqNuYxXWuftmfvE4QlaEsnYhGjqYQbuh/IQFEbW0eIOhV930Q6YsZR
	 X7UrYyEaknjsbQ4mYQsxjQJL+RFaJrmdO0GnAFF26+fTFEWJOloSR2Z5ql4y/5G6GHOP/
	 SDFJq/FLltargByl56SjcJcWj6djEnH/CCymdyT98kadbScw9MU5UClvnkmeQ8QOjZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795610772;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=PC7daVSL8FndeCzTxwdDo3nnq388Dh8/RSShpOz1k80=;
	b=PGXKQAq6eTBGeZOX32kYqBIAefml7QEzDcYgVmudH6dWoMngbp5wGQmXJflrLCAQRPRc
	 vl1Pg2dN9GDQbSXmZ4SUm4oEeLOQGeptztYw/vjeOA6gC7+ov2t6cPl+tQAtR9YjavC36
	 pTHGNYIYu9175yYmRo21vHzEDxCaxr2Wl66mH/rIJC14+5O4mMS5k2ICWUnf80zuhjeqs
	 OwUJaP12aZ2Qg7VnurCQJunmqdmA96f+H0pJL7YVdjPh/qdnGCa92ajEGRE7uDFdD4hNL
	 VC9Ij3UQE7uH68gZp6n5fvIxtnN34dnh7TqipjbWhlLYL6ds6qNuTodpwY9d1dIBwaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=K3kKLfTT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AE9606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=K3kKLfTT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCC311F000CF;
	Wed, 25 Nov 2026 12:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795610771;
	bh=PC7daVSL8FndeCzTxwdDo3nnq388Dh8/RSShpOz1k80=;
	h=Subject:To:Cc:From:Date;
	b=K3kKLfTTuIVnqypFbxV7snqQpI4yy5GG9nRSep1vvl7Yz4hB3mUcDK76ej+Wo4tK0
	 jsfSbmBj+ZYwYomArvde1FpJ9kPQVpahJRiUhBV2ePptIcOwKxukGhj5nblXylTwiw
	 OC1fXC5IHynM0X8Somi+AogBh+VBzJQJSxyIh2cc=
Subject: FAILED: patch "[PATCH] iio: proximity: hx9023s: Allocate trigger before requesting" failed to apply to 6.12-stable tree
To: mhun512@gmail.com,ae878000@gmail.com,jonathan.cameron@oss.qualcomm.com,joshua.crofts1@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 13:44:11 +0100
Message-ID: <2026112511-mosaic-gigahertz-6594@gregkh>
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


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x bfa3b177d839bb303d0187335115b572a2644920
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112511-mosaic-gigahertz-6594@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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

