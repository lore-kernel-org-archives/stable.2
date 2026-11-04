Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802028;
	b=hExh4zTO/G9tD6JCEKJIj17UoY8j34Xlb3ieOkNdt1k2Xy3+epV3OxknBK4zS4LEDnsh
	 QZw4n+7Tr4+fCj3k2XLlakB7a1akAG8bTapJow89ThcZH0zgQuzXWVzM3F5nfeiYhRThW
	 IdlUL50uKlWioolftZNbpg2IWl2A84Xd6w7W1RheKCzIbNwA9AstZJeziiGdFF+JPdy9w
	 rMt3HItmr8qxt0vi+ndYgR4Yp+DS261Ytr6rnnNYMVhUepW6W0AYa9TbXhOxVXVNqnf75
	 7dXQK/U7PEDY5ZRDV3EG9QRs4YGKbuIXtPc/p6Zkw012/U6oigCVV7ug3TdUF6r4ePw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802028;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=r2tmPrMOEBt9Xc3QbgRm3T+8LMsoJp6F198J1IsA5tI=;
	b=AmJM7MZhCPR9Nvbyc1VGtFJ53nu01ZzF7FyUR8pfQnIMzp4SDCqyUGpGah6mTYJvP0el
	 Xbma8xEaJ5CFz7xhmRt5aS1jlNPJOkQbkohTW1nXgw+1VNayYCKQwGikIBOhQS6ZOXBgg
	 wgKssGLh86/5JLgWo+oP8OUPrdvOeBMM8uuCJ5Pq8sXpfubdWI2mJYlAqliQ4RmsWoxBY
	 XaqfFSXVl10/rlpXzQDFoCp5S6Ait6DxG7/mZ7ArZQo3f84e5yuuBorlP5wBQmpCns6lN
	 1HgjOYr5HbzWnfcHaK6J8yTqK5CfIdyyoB9Nd274T935pg31SFZT9ClRYBM2YLU+adA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ZBKMDy0v;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCB1606A326
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 14:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ZBKMDy0v
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1814B1F000C1;
	Wed,  4 Nov 2026 14:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793802028;
	bh=r2tmPrMOEBt9Xc3QbgRm3T+8LMsoJp6F198J1IsA5tI=;
	h=Subject:To:Cc:From:Date;
	b=ZBKMDy0vSf4uIh8pmQ8M7+ASr/fxJNAtzvdDTLwqbgEeybirPOk863sAinbrxMqgd
	 WGX9UWqm07oRWYWsAqdVCRdFqRM9Z+ZpktKCHFU6W6dvTp626jbebFAs33eLlmacPD
	 umCKconFfWF+04yjf+5DwEyuHUrUIkh6is0JBzgs=
Subject: FAILED: patch "[PATCH] scsi: dc395x: sync the waiting_timer before freeing the host" failed to apply to 5.15-stable tree
To: fanwu01@zju.edu.cn,lenehan@twibble.org,mkp@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 15:20:23 +0100
Message-ID: <2026110423-helper-sprang-8be1@gregkh>
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


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 0b1a79f2791a06f139dce5450e487307cf0e241f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110423-helper-sprang-8be1@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0b1a79f2791a06f139dce5450e487307cf0e241f Mon Sep 17 00:00:00 2001
From: Fan Wu <fanwu01@zju.edu.cn>
Date: Fri, 11 Sep 2026 02:05:44 +0000
Subject: [PATCH] scsi: dc395x: sync the waiting_timer before freeing the host

The waiting_timer callback re-arms itself and takes the host lock.
adapter_uninit() currently stops it with timer_delete(), which does not
wait for a callback already running on another CPU. The final
scsi_host_put() that frees the host (and the host lock the callback
dereferences) runs right after adapter_uninit(), so a concurrent or just
re-armed callback can fire after the free, leaving a potential
use-after-free window.

Replace timer_delete() with timer_shutdown_sync() at the top of
adapter_uninit(), before the host-lock section: the timer is dequeued,
a running callback is waited for and rearming is blocked before the chip
is halted, so it cannot fire at all once the adapter has ceased to
function. Waiting outside the lock avoids the self-deadlock that would
result from syncing a callback blocked on the lock we still hold.

No shutdown is needed for selto_timer because it has no reachable armer
or callback.

This issue was found by an in-house static analysis tool.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Cc: Jamie Lenehan <lenehan@twibble.org>
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
Link: https://patch.msgid.link/20260911020544.42966-1-fanwu01@zju.edu.cn
Signed-off-by: Martin K. Petersen (Oracle) <mkp@kernel.org>

diff --git a/drivers/scsi/dc395x.c b/drivers/scsi/dc395x.c
index 10e2078f4a0f..5a4f2713dcfa 100644
--- a/drivers/scsi/dc395x.c
+++ b/drivers/scsi/dc395x.c
@@ -3808,13 +3808,11 @@ static void adapter_uninit_chip(struct AdapterCtlBlk *acb)
 static void adapter_uninit(struct AdapterCtlBlk *acb)
 {
 	unsigned long flags;
-	DC395x_LOCK_IO(acb->scsi_host, flags);
 
-	/* remove timers */
-	if (timer_pending(&acb->waiting_timer))
-		timer_delete(&acb->waiting_timer);
-	if (timer_pending(&acb->selto_timer))
-		timer_delete(&acb->selto_timer);
+	/* Drain the self-rearming timer; must not run under host_lock. */
+	timer_shutdown_sync(&acb->waiting_timer);
+
+	DC395x_LOCK_IO(acb->scsi_host, flags);
 
 	adapter_uninit_chip(acb);
 	adapter_remove_and_free_all_devices(acb);

