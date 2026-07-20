Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5500D2D6401
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 15:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784562531; cv=none; b=LSue6D5KBY/1LEE+wAPJha5e1eEbNcIkZhKDij+nd8OtAovR1CX9/nYkSCHChcbb1BTNaKYX3eoV0u7zeRxXu27ZMmfJFUnJRzdtAZu2a3YLYvW/dME4bJVzt59ejaebGjGVOw7gU284l5Zo+a+B6r3X6wBWi6fc6y2zY4sI9tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784562531; c=relaxed/simple;
	bh=JQAviVvAiGQTJX1x+ON9AqnjeUn65fD9VfGpUbNFcgk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=bmfYDC2T18ra+t5lXnf3T5TrKu2NV3VYwTgwk9ycPg//FEJMOxW4x0+VDzpm7BUPYHaP67V0nQwBJRRXFAjG9NphPAq3JIDR5mhRLp45AyM38UNXayzA7RaV6Oszfv3ldaeD7a7ZgHo4hECdjOhEz38OmSG/Ede+YLGJTSH8tdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=THBM3Xay; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="THBM3Xay"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B54F11F000E9;
	Mon, 20 Jul 2026 15:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784562530;
	bh=ovBlRY/OVMn4efVsivFIHX0d4qXJhiniEDqjfiSjec0=;
	h=Subject:To:Cc:From:Date;
	b=THBM3XayE0LBsPXxjrydKdXG4qU/77/W9K794yPCculHEJwwEV9VNke2OPYOkPIiL
	 1HTzdbEVtpAO9Ggm7xFwLrFzqvZ5TEnVvs7329Kgv9O8Gl7G1Y5gX8yT7qYdH4+Swg
	 Ts3oMQAKHBgYdo0xUppnbGW5j2w5xY/pZO3k3auo=
Subject: FAILED: patch "[PATCH] mmc: vub300: fix use-after-free on probe failure" failed to apply to 5.15-stable tree
To: lgs201920130244@gmail.com,johan@kernel.org,ulfh@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 17:42:47 +0200
Message-ID: <2026072047-stony-hardship-acc5@gregkh>
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
git cherry-pick -x a3b5f242997a3be7404112fd48784881560aea57
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072047-stony-hardship-acc5@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a3b5f242997a3be7404112fd48784881560aea57 Mon Sep 17 00:00:00 2001
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Fri, 12 Jun 2026 11:27:56 +0800
Subject: [PATCH] mmc: vub300: fix use-after-free on probe failure

The vub300 driver lifetime-manages its controller state using
vub300->kref, with vub300_delete() freeing the mmc host when the last
reference is dropped. The probe error path after the inactivity timer has
been armed still bypasses that lifetime rule, however, and falls through
to mmc_free_host() directly if mmc_add_host() fails.

The race window is between arming the inactivity timer and reaching the
probe error unwind after mmc_add_host() fails:

        probe thread                     timer/workqueue
        ------------                     ---------------
        kref_init(&vub300->kref)         ref = 1
        kref_get(&vub300->kref)          ref = 2, timer ref
        add_timer(inactivity_timer)      fires after one second
        |
        |   race window
        |<---------------------------------------------------->
        |
        mmc_add_host(mmc)
                                         inactivity timer fires
                                         vub300_queue_dead_work()
                                           kref_get()          ref = 3
                                           queue_work(deadwork)
        mmc_add_host() fails
        timer_delete_sync()
        mmc_free_host(mmc)
          frees vub300
                                         deadwork runs
                                           use-after-free

The inactivity timeout is one second, so this would require
mmc_add_host() to both fail and take more than one second to do so. This
is unlikely to happen in practice, but the error path is still wrong.

timer_delete_sync() only waits for the timer callback itself. It does
not flush deadwork that the callback may already have queued. As a
result, queued deadwork can still hold a kref while the probe error path
directly frees the backing mmc host, including the vub300 storage.

Fix this by using the same lifetime mechanism as disconnect. Clear
vub300->interface so that the timer callback and any queued deadwork
return early and drop their references, then drop the initial probe
reference and return without falling through to err_free_host.

Fixes: 0613ad2401f8 ("mmc: vub300: fix return value check of mmc_add_host()")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
Reviewed-by: Johan Hovold <johan@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulfh@kernel.org>

diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
index 6c3cb2f1c9d3..c1c21e95f5bf 100644
--- a/drivers/mmc/host/vub300.c
+++ b/drivers/mmc/host/vub300.c
@@ -2336,12 +2336,16 @@ static int vub300_probe(struct usb_interface *interface,
 			 interface_to_InterfaceNumber(interface));
 	retval = mmc_add_host(mmc);
 	if (retval)
-		goto err_delete_timer;
+		goto err_stop_io;
 
 	return 0;
 
-err_delete_timer:
-	timer_delete_sync(&vub300->inactivity_timer);
+err_stop_io:
+	vub300->interface = NULL;
+	kref_put(&vub300->kref, vub300_delete);
+
+	return retval;
+
 err_free_host:
 	mmc_free_host(mmc);
 	/*

