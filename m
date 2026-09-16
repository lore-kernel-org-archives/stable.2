Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0E338888E
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 09:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789550213; cv=none; b=g0C4Y3Pjhf4KywMdjpLu18pkggC979yAu1zVRWzfLg6N67Cj+GZQ+HJv9TCJdPz68eZes9vVnXpuP6ZRmfRI4Ej1SeSvA2Fgi0ui2pD4fVp5LE8e9I7MeVXs7fKIjjpASbBqA/zxhuzFZyAsuTV0guL1MByeUqfcaw+J3EnzEsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789550213; c=relaxed/simple;
	bh=+pAfcm7a48rSuMKDwseGQ3lFGREDMaQivPknGNjEN0o=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LY5hXwOaSQvAX6cpD8VfVAytZPoPs7XK9+xrJQvxpb99kRVvrjkuy39eQeLVphONkw6QWtCVmxNcIHUuu1IqqLXmXrpFyYeGmlnwNKxpRxOwVxYj7NqqAAq4ttADvXdpSpM7Ztdw8aOvCXHPSTVX9jlqn4v9V2wkCXfamSuJbGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wg2i5r++; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wg2i5r++"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DBFE1F0089A;
	Wed, 16 Sep 2026 09:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789550207;
	bh=BwZ2K3yuaexrIAmM/yQsbr4H0CGE2n0cyOJS9Mrx4T4=;
	h=Subject:To:Cc:From:Date;
	b=wg2i5r++EnbcE+q4a5DHc6H81UuYbyHwTOaeWQuAorDDFpYyiEqYt0KreNaGITb25
	 PuhaKO1yh9zixUTzjzR6RJUH2OE9N+eHWTSgPi76TUG194lp9kKTWw5m+fIU1FHcTf
	 qG31YPyA4woSRyULguDAfPMtrX7PMU7kZp44qq8k=
Subject: FAILED: patch "[PATCH] ALSA: usbusx2y: validate URB actual_length in interrupt" failed to apply to 5.10-stable tree
To: tristan@talencesecurity.com,tiwai@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 10:14:46 +0100
Message-ID: <2026091646-junkman-leverage-0c14@gregkh>
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
git cherry-pick -x 8f5ef203abda9dd36b2af473c7b737d544f807bd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091646-junkman-leverage-0c14@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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

