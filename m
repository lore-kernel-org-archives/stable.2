Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793844069;
	b=tC0qZnMvf0cStIwgatCIknc898kGh140oEMXx9IARMtFPqqqaRgn6Z9diSVdY/LWWbar
	 uCm81YFWmDcYPnvxhDzHobHEENaQvdhnxOGmOrZGcRQEXwXD2Cl3l6WmMFbqCTAtps+II
	 iYQUZ6nZbCBV0W6c4uFdX4onvKxK3jytIFDvCZV5XmN9zf6zelwZdO/IL5nz5v1yAgXUk
	 0G+WK0sTz2SwndJjQClUxxLBn0wEKJ0x/aHL5SL2k8aJaJXlHTzsB2p/Hj9ZvELVnSh6F
	 fiJartOuDaXBawHaN8g9cej/iGsQxa/0L3ZxhaZ5GDo8hFgUzIjcmuFI5vbNjU71awg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793844069;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=6Jr1zICD/K/waeGyYyMgHEHtfsqGd05Jy9VR+ZrJj18=;
	b=UfGsc9OKGC3DFnDFaNP+3CamqmeUhVM06mE5P/4KEBpTGti3tUCGcyVYgW2pKLxUqUoH
	 r3XAQqXhIWgLKFOoWTTf2zdwl3Wa25Y0ItRp3J34PpOeglVZ9RmShXaE//1M6bZCByKFW
	 zRQg1zLsBn4WdZfVSx1F+iqRdO0XHUp1K6pd466/gAwTN/2AdzEygOAlnBElwx1xluDUi
	 kqBGbTbA+Y5TcVp0lvzBiYfMdkmicKzpkhfvWohqAqjD8vWFiAG1BlpoErMBuETvS9QE0
	 XARcJRewBdSDy72jkUfYQpL5d2BfZNhkSOvvBykgTENIyylISp1eK5PEIrs5m4K5vEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l08ZK9VC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2C0606A32C
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 02:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l08ZK9VC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B63CA1F000C1;
	Thu,  5 Nov 2026 02:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793844068;
	bh=6Jr1zICD/K/waeGyYyMgHEHtfsqGd05Jy9VR+ZrJj18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l08ZK9VCtW9h0kPc+a6cZzEKVIGV1SOoQkKaTdZ+bR6mMYVbnTE2uPAFIepW5Totf
	 n0URYHVivudjpsjRlP63rJMVujxSGZ6MRZKHCvyNoXnlRzI/uvy5vFRGEEYrnl1eCr
	 Ok/K/h/xjj/mhMoflJSn28S2QRNPAz5/EhuNlvxHHdgU9wbJas5PwyX87fODvIKFJA
	 1mR0nm94+IBhvD5Iaf0UMbZzpcCgbnnEUSrYiBmhS3twvpN2oXfzUHUSiB3l2r5fWB
	 nyTP1wPMnCXAutebsu0nGEr3TJClCkk7Xd2YnOlECW93gtTLF9UyKjgu6fexiIwM9s
	 RQJ0eq3s3SlCQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fan Wu <fanwu01@zju.edu.cn>,
	Jamie Lenehan <lenehan@twibble.org>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] scsi: dc395x: sync the waiting_timer before freeing the host
Date: Wed,  4 Nov 2026 21:01:06 -0500
Message-ID: <20261105020039.1070505-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110423-helper-sprang-8be1@gregkh>
References: <2026110423-helper-sprang-8be1@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fan Wu <fanwu01@zju.edu.cn>

[ Upstream commit 0b1a79f2791a06f139dce5450e487307cf0e241f ]

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
[ sashal: adjusted context for del_timer() instead of timer_delete() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/dc395x.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/dc395x.c b/drivers/scsi/dc395x.c
index d5623253826f1..7b15b86e85879 100644
--- a/drivers/scsi/dc395x.c
+++ b/drivers/scsi/dc395x.c
@@ -4416,13 +4416,11 @@ static void adapter_uninit_chip(struct AdapterCtlBlk *acb)
 static void adapter_uninit(struct AdapterCtlBlk *acb)
 {
 	unsigned long flags;
-	DC395x_LOCK_IO(acb->scsi_host, flags);
 
-	/* remove timers */
-	if (timer_pending(&acb->waiting_timer))
-		del_timer(&acb->waiting_timer);
-	if (timer_pending(&acb->selto_timer))
-		del_timer(&acb->selto_timer);
+	/* Drain the self-rearming timer; must not run under host_lock. */
+	timer_shutdown_sync(&acb->waiting_timer);
+
+	DC395x_LOCK_IO(acb->scsi_host, flags);
 
 	adapter_uninit_chip(acb);
 	adapter_remove_and_free_all_devices(acb);
-- 
2.53.0

