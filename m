Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802030;
	b=TQHrVXXIpDbSru2G4Jaggx/a5oa3/KT9aSVi4O2XoC4QSyVcjroGnazlq5Q4UsxBdYVH
	 Q9bM/YXd39pSCyD04jMnZaxv5k8xUixr5tponPYSJVbVtipyP9AdqVy8rbg+LDALklfby
	 tePWXbhinoaZkmTyafDJHZ5CMPX2HBeoOyiB5GU5HgpAZwnneBAumeu4aLPNlQuznxKyg
	 eIordDAmUwcfoUqTy3V/vAN2jIaa1hsHswlMa3vuN3dxlBom//R0MIyeJ67dIZMl1fD1i
	 OURzWLYL1RmBjxaoNOjc3UP2i8zeYDS1OcheXBwqyM3bNgipcMu+HnmtNNlqOxk7FTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802030;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=fvRXp1BNU4XcrME94OGhKdIdTceoDbq1IEEwsQSTKug=;
	b=FJS15m9Sf1yLc4xH6fAHUibofbwi3iKd1/mWuaA0zxDab86HawA+lYL6gHVnOH1WHvLH
	 Yg/hXUG56Gwop81thvLt1Ap7H/IGXo36eUfRaNEP42hTR1i0tT5JJ/nw6FuulGNl0lgBr
	 a9C8E8ZKwCGSAYkd4u3C4W7i85BBHfE1f75sj+OOMv1Utx6X8Wv5W2Z5ig9336K6WE8nH
	 dehFg9IQJnxkjyCOASfqz/0vqDj4UNNjidZQstCF1s7MeR7KAUnzllTKZWgrcWEAZMdNW
	 d2J4VCAzZffir0udzYVtwEiGHx02SEjf40cs9NNW9asz07oe5cvC0z8tf51PDyrJgKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=MAbpDhmi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62EC606A331
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 14:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=MAbpDhmi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52D2B1F000C1;
	Wed,  4 Nov 2026 14:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793802029;
	bh=fvRXp1BNU4XcrME94OGhKdIdTceoDbq1IEEwsQSTKug=;
	h=Subject:To:Cc:From:Date;
	b=MAbpDhmiEyjRGNqyRI7ChSo9LLaU5F2MEcl7yRwTvWvAYXc9Eq8kNkjlUXdyrfxi/
	 Nre0fhMnF4QffHIUwQxLJ87vIq2ctNA/QxSvqbXIn+2dDf7r9CWIkDnSQHnitiN/oB
	 RORKSin1ATKJCdJ5vAjUJhRyGPT7CdYZK8i9PNu0=
Subject: FAILED: patch "[PATCH] scsi: dc395x: sync the waiting_timer before freeing the host" failed to apply to 6.1-stable tree
To: fanwu01@zju.edu.cn,lenehan@twibble.org,mkp@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 15:20:23 +0100
Message-ID: <2026110423-almost-vantage-160b@gregkh>
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


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 0b1a79f2791a06f139dce5450e487307cf0e241f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110423-almost-vantage-160b@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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

