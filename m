Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793835969;
	b=KYLcbflHIr/vLpBf+5LaXSdQexAWHh/IRUwA5wB3ez7qaYEixBMBWhly9f+kJ7dJz3g0
	 ROgQofghNcAaBXCtYLfsLkTLRAGWoO11dneuLJg2SqblnMszrOlLcsDdv3haJen7JTep8
	 doeAhEZa6mBg9/G5DCgDdLSiclVks7rqe4Ux8ytkE8v/y8Ea4p53sfWx/L1KcHYAdKsab
	 l6IoZphBlHVKO4gVt3OMNGzwvA0x4MthMU+cf1XKHaTppRkdaID4X0KlEcwjBv5wdgiLE
	 Um+ATGZciyZcfy9ezZsIBQNdR2anRTSpH44FQv9yBjMkEHtAmnpg3v+yYKSrEcZHEkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793835969;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=JD5ah/qvgMwNrAvQyEB7gbtsmmoNUsXsM6BVDh24KVc=;
	b=mKeY1zXGijm3ulgtdUzItT4ue7EprYD71pYjfDLW9W0Ox/+1bSuDh1XmXWen760lBxhZ
	 FsCpNMquBVHNLMiqFyK8yLu5w7QWAgwdCN3ioZIumKDnTjP1FPxgOXXgRhG+LWoyYN38I
	 T0tVgbjJRWUs49GnuRDhS/GMN6N4KvG51eM7Km9j76GKv5fd+PH+Q2baFRuMH3k03+lwv
	 rE7tLCHuOlDLAGanu00PE3W5pqqjcXcZNdyC4MB8UaNM43snqDZUK/8Yb39usmcXwuT/e
	 Swja5a5dWo9Jz33VaCx7L0TXyt/e+F1YE1Jd3BlZQIP5yWAZbeNgZwEiovXOe6ZTr0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GXUB+F2i;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D252606A32D
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 23:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GXUB+F2i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55B771F00A16;
	Wed,  4 Nov 2026 23:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793835968;
	bh=JD5ah/qvgMwNrAvQyEB7gbtsmmoNUsXsM6BVDh24KVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GXUB+F2iVxNCAx939DEy+m61KU7O+E1ma8QABFQSX7FyApTg2nJdmFLJ2FyeZ4MW+
	 Whw/wgDvVLNHqNOPnKs+W9zdAMZeGhGcPKQEyBXJ3lsCFY8nYpxZ5x2xSLeQR+8nCH
	 qtKVU1x5cyPTKIQoAe7t1XPN2AKqlWEdxTYJBueoEK4dQV5CakL9+VvgC4U4nvbaRN
	 RA2eCZV4kvv8lPD+oegP+LWeVsoBO1fCfLq8/44kp+maimsBvGg8xJE9VQjIXlUG1I
	 ihyJKberVWbLX5b5iLR2fRWfvLBFsyUzdwyuSG0NN3HMB4f62J1cqBI9Ht7k3ySsnV
	 +HHuhKhKCfkkw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fan Wu <fanwu01@zju.edu.cn>,
	Jamie Lenehan <lenehan@twibble.org>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] scsi: dc395x: sync the waiting_timer before freeing the host
Date: Wed,  4 Nov 2026 18:46:06 -0500
Message-ID: <20261104234537.932280-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110422-grandson-cling-4ad4@gregkh>
References: <2026110422-grandson-cling-4ad4@gregkh>
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
[ sashal: Adjusted patch context to remove del_timer() calls where upstream removes timer_delete() calls. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/dc395x.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/dc395x.c b/drivers/scsi/dc395x.c
index d108a86e196ef..f4be99c8eb472 100644
--- a/drivers/scsi/dc395x.c
+++ b/drivers/scsi/dc395x.c
@@ -4411,13 +4411,11 @@ static void adapter_uninit_chip(struct AdapterCtlBlk *acb)
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

