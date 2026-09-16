Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A70F4A43E6
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 09:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789550216; cv=none; b=kSmKUHvfcWpEtXojTO/Cc5wN/Sl3AyrXETkYNRE3WnSKLvXuZ3Poy3Tg1oekV0LrRz40eHvhrdmBA9gwoERIwtY1ocAuijcm6Xgl+cd5Awkz1nlVQcE1ZnhX83xzKKZBPkFAI+lnmH/jlOEPeZUFYnejMdMZ8p1ozx6RBnPqH68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789550216; c=relaxed/simple;
	bh=HL4LnDEkucpEFKAg6J6jrdPJkvCcoDAOeN+87idlWNM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=WHXCebiA+dz3YatBJZTkGcHn1hvRUWukHzbqV51a5iHl/CSJrQP/a8upk+GJRMyq532FHyaw0Xn2xL/GGSjakeoheQmLo50hLbU3IaWO7szrpojY3x8ytwBMi9wge1XrDRs3l967q1QzjFnd09UZ9286p1jPN8Rv1A/I+yPg8xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hif9aUOw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hif9aUOw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B951F00893;
	Wed, 16 Sep 2026 09:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789550210;
	bh=m1NlO4FKkVcNpvh9+uGtauh1F0taTDQWCt4lVspBHHo=;
	h=Subject:To:Cc:From:Date;
	b=hif9aUOwceNgaDvJb0obBVEi7x9zZ0gr4Yt9feRETzEjyG1r0+8kMnN/Yt4Ex2wiF
	 Vtk4Ul6ilMwcmKqM/HJGpy7DAFU31iGDiLsYo2WcLBQ5PSLIG3xypN+tixF6cvti8J
	 2UNsfMoYJ8MRhrgif9UuKUddwt1jcQy6VKtQwaTQ=
Subject: FAILED: patch "[PATCH] ALSA: usbusx2y: validate URB actual_length in interrupt" failed to apply to 5.15-stable tree
To: tristan@talencesecurity.com,tiwai@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 10:14:46 +0100
Message-ID: <2026091646-catalyst-goldmine-6801@gregkh>
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
git cherry-pick -x 8f5ef203abda9dd36b2af473c7b737d544f807bd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091646-catalyst-goldmine-6801@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8f5ef203abda9dd36b2af473c7b737d544f807bd Mon Sep 17 00:00:00 2001
From: Tristan Madani <tristan@talencesecurity.com>
Date: Fri, 4 Sep 2026 20:58:26 +0000
Subject: [PATCH] ALSA: usbusx2y: validate URB actual_length in interrupt
 callback

i_usx2y_in04_int() processes the interrupt URB data without checking
urb->actual_length.  A short transfer from a malfunctioning device
would cause the handler to process uninitialized heap data from the
kmalloc-allocated in04_buf, which is then copied to the mmap-accessible
ctl_snapshot[] array.

Fix by using kzalloc() for in04_buf to zero-initialize the buffer,
and adding an actual_length check to skip processing on short
transfers while still resubmitting the URB.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
Link: https://patch.msgid.link/20260904205826.4071119-2-tristmd@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>

diff --git a/sound/usb/usx2y/usbusx2y.c b/sound/usb/usx2y/usbusx2y.c
index 200b708aacd6..108f9bddf9aa 100644
--- a/sound/usb/usx2y/usbusx2y.c
+++ b/sound/usb/usx2y/usbusx2y.c
@@ -189,6 +189,9 @@ static void i_usx2y_in04_int(struct urb *urb)
 		return;
 	}
 
+	if (urb->actual_length < USX2Y_IN04_SIZE)
+		goto resubmit;
+
 	if (us428ctls) {
 		diff = -1;
 		if (us428ctls->ctl_snapshot_last == -2) {
@@ -253,6 +256,7 @@ static void i_usx2y_in04_int(struct urb *urb)
 	if (err)
 		dev_err(&urb->dev->dev, "in04_int() usb_submit_urb err=%i\n", err);
 
+resubmit:
 	urb->dev = usx2y->dev;
 	usb_submit_urb(urb, GFP_ATOMIC);
 }
@@ -305,7 +309,7 @@ int usx2y_in04_init(struct usx2ydev *usx2y)
 		goto error;
 	}
 
-	usx2y->in04_buf = kmalloc(USX2Y_IN04_SIZE, GFP_KERNEL);
+	usx2y->in04_buf = kzalloc(USX2Y_IN04_SIZE, GFP_KERNEL);
 	if (!usx2y->in04_buf) {
 		err = -ENOMEM;
 		goto error;

