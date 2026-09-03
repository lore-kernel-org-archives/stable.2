Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED1F4E56F8
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788450016; cv=none; b=oie93zwVq3TEtV4GgOGMgyEBSYm8++KSh1Uxc6CYfEMz2opXaAl9ZHRRFKqBrb5uMiiTKKIkBKLEPh6TuL/y0NgRO9ozm4Thmf7m5hQbDmVLWAgQuDmfAec8ZijFuBBiVDfmnK0wZRVjeYIVGCpAb+HZIQGY5nKItpGhFHdx9ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788450016; c=relaxed/simple;
	bh=KqpP71GrVR9XabCUb/0MgiAN1yMMwIBsp7LTfJgZMBI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YYwQSwUsTE4Vf3ZOfCTMVbU5g2cQ/UEZRzYXXEMiV2/NeJoMWPfKvfo7CrhnpywQY6/aEcOsDT8wsQZKSVaWam5SyECRV45FZorrSFUYbdiC71UNzg/S24J05TclOKhfYvDAzMf0oomIVr0nv7CI6Y/v6Vo+jVeHVTTxAKCSokk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A3zLhx4h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A3zLhx4h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 061181F000E9;
	Thu,  3 Sep 2026 15:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788450015;
	bh=muWZaaLgV0Ly+TqLC0zp+vYp2hgGuhtClSrXufbeW+A=;
	h=Subject:To:Cc:From:Date;
	b=A3zLhx4hwdL/K9rXjEoAEif8J7ctMA09qTmZETi9fmngZrdhRYAHmNXLXMVG4w0L6
	 9sLCKxA0kKIZ5I96Wg3taEiuhiRfMxDKw20RNKUuRZqMHNhl3sq/UYJNDpDxgE7c/C
	 lQO5xIZy0weLLt60b5yZk6AaANCbU9zyTwDOzUb4=
Subject: FAILED: patch "[PATCH] ALSA: pcxhr: initialize mutexes before requesting threaded" failed to apply to 5.10-stable tree
To: runyu.xiao@seu.edu.cn,tiwai@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 17:14:09 +0200
Message-ID: <2026090309-dimly-regulator-21d3@gregkh>
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
git cherry-pick -x 6c97817e20598e5473094e0e38d1f51f1cf4dfff
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090309-dimly-regulator-21d3@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6c97817e20598e5473094e0e38d1f51f1cf4dfff Mon Sep 17 00:00:00 2001
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
Date: Tue, 18 Aug 2026 22:47:17 +0800
Subject: [PATCH] ALSA: pcxhr: initialize mutexes before requesting threaded
 IRQ

pcxhr_probe() requests pcxhr_threaded_irq() before initializing
mgr->lock, even though the threaded handler takes that mutex.

Initialize the manager locks before request_threaded_irq() so an
early interrupt cannot run against uninitialized mutex state during
probe.

Fixes: 9bef72bdb26e ("ALSA: pcxhr: Use nonatomic PCM ops")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
Link: https://patch.msgid.link/20260818144717.2269918-1-runyu.xiao@seu.edu.cn
Signed-off-by: Takashi Iwai <tiwai@suse.de>

diff --git a/sound/pci/pcxhr/pcxhr.c b/sound/pci/pcxhr/pcxhr.c
index 25a640304430..60cc0721d0a6 100644
--- a/sound/pci/pcxhr/pcxhr.c
+++ b/sound/pci/pcxhr/pcxhr.c
@@ -1535,6 +1535,13 @@ static int pcxhr_probe(struct pci_dev *pci,
 	mgr->pci = pci;
 	mgr->irq = -1;
 
+	/* ISR lock  */
+	mutex_init(&mgr->lock);
+	mutex_init(&mgr->msg_lock);
+
+	/* init setup mutex*/
+	mutex_init(&mgr->setup_mutex);
+
 	if (request_threaded_irq(pci->irq, pcxhr_interrupt,
 				 pcxhr_threaded_irq, IRQF_SHARED,
 				 KBUILD_MODNAME, mgr)) {
@@ -1548,13 +1555,6 @@ static int pcxhr_probe(struct pci_dev *pci,
 		 "Digigram at 0x%lx & 0x%lx, 0x%lx irq %i",
 		 mgr->port[0], mgr->port[1], mgr->port[2], mgr->irq);
 
-	/* ISR lock  */
-	mutex_init(&mgr->lock);
-	mutex_init(&mgr->msg_lock);
-
-	/* init setup mutex*/
-	mutex_init(&mgr->setup_mutex);
-
 	mgr->prmh = kmalloc(sizeof(*mgr->prmh) +
 			    sizeof(u32) * (PCXHR_SIZE_MAX_LONG_STATUS -
 					   PCXHR_SIZE_MAX_STATUS),

