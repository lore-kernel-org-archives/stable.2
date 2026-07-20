Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9446D435EDF
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 15:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784562528; cv=none; b=PjRKEBnazbmLxwsnU5JkxYYEtvfqBUblte6610MK8BoGSfLDmSZEgrwSWMgbGUtAFIl1Gn8pch7A7PQC7JivL9yJ02Q9ymzFK1RW43HbStgz7TtA6oEpcaZeNZHJIlfq+poxFoMDoTcbG0xFG4NrGDLf1UhoIwowsCqnQ61fzac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784562528; c=relaxed/simple;
	bh=iNzYPI2684Rx/GujamDfeVYTVNLZBXldBPdktgvKr9Y=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=k1KKa7ir8VQTXg1IOYFkjbQhAnH9Jlv/6qdsBs+PXSZmGdi5QCA9UIhV/7Zh2kpMQxT3/rgWwjL0h7NMro9L6W66YTve9Ocd0G00pewhdqK+tGr0YAsBLrpLXkesEcuxmc1p0fItZnaj/yblCVD0VwoELHcNkWtoOYt7G/P924w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ee1cYzMu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ee1cYzMu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D431F000E9;
	Mon, 20 Jul 2026 15:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784562527;
	bh=JOgrhUbauhCd7F1VPdIAkPeuun7KUiRzxtByCoIGVgc=;
	h=Subject:To:Cc:From:Date;
	b=ee1cYzMuw7wsb/Qe4eMpQJV2vztm4ayGojgKnV25FMXb2Sxk7gDwD66hkqUeGV6sv
	 wCMRA7lcJjeqpf1/pE+YFwQ+ez5wFjBRNBgVT9sjCq3ZEJPiikXpxCs/t3SQx3tV5B
	 N1lYc+sXk6ZIoI8n9n9r9QtUDtibp2gPHINzRXWg=
Subject: FAILED: patch "[PATCH] mmc: vub300: fix use-after-free on probe failure" failed to apply to 6.12-stable tree
To: lgs201920130244@gmail.com,johan@kernel.org,ulfh@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 17:42:46 +0200
Message-ID: <2026072046-octane-riverside-49ce@gregkh>
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
git cherry-pick -x a3b5f242997a3be7404112fd48784881560aea57
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072046-octane-riverside-49ce@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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

