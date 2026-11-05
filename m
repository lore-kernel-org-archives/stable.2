Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793849370;
	b=niZpBel9h7p5pw/x6SAl4g9JFg23CJzfOys6ueO44OFp6+DVE7+rUsQ1jTJFA9sYxTEZ
	 My9bJ8IGZ1fL5oDx9TxXDP5ytvrTBiF/tJ0Czr6yZlZWuhyEHfNS0iCXmj5FbTlqchu8Q
	 OTSsBQ5STllFBba2DUyFZG+YW8EqNI5sOjb5KoFg1dTeyw8vyezLPONjLdMUFejl0m57b
	 mS/yQwGhWJI/TsoAo6D0NzbG6bhyQPNDep9u0rVtcLC3uVTGSNYX2DKvpQeEbo/joT6y5
	 9pWI9WXclUR0P2gx9dHY9+iwPq3RwBkxYGbXVSDlDIKQDv2ohYHdFXJ6wrcMzpOn09g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793849370;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=7MLhfQXO+xkYp2XQhzSm3g9OBFIo08KPg7MNSZZ7E6E=;
	b=dnBj9JRhK57wLlZl6DT6c8/Q5UG3yQpOP5ka00omRwo40rsVPL0j7ndgLcPrjOQKox3x
	 c6xU9f1zUEn4ZFveNkdH1yEmfFX8VlJO5P88HIK2VUsXm6hOOIxai/sjvp6ay5krn+yPe
	 MK+NGhradU70yRX3jLXmJY47q0373XCsZDRDoxmz00LIMgdYED7hA2rD9cwo9rYNoEXyh
	 pv/F4QEQ1WmHmkNs74zF3DF3OI67f9BqPYZlFvbpsH8+leyR0DKseGt3G+JuKnCniViOf
	 0/qXNs0u65FdmxzX4uD8mFKNWJr9rU+59SqscNTvXheEK9pxM7C8xkHzgKDEmrHWo0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z5nbbW6V;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5974F606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 03:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z5nbbW6V
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60A2E1F000C1;
	Thu,  5 Nov 2026 03:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793849369;
	bh=7MLhfQXO+xkYp2XQhzSm3g9OBFIo08KPg7MNSZZ7E6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z5nbbW6V7xSI1e0rnb4g4wNLjuepFLs3t2B2Z4/rh71YRq2eVuY1xWcmfXbiQQkMR
	 lFgdPFTcB3NX2aclJIGdh92JrgkkQo6ccDfKhTQz0ID3nUz0582DsNRLCjJ4o6FgDc
	 +EYQ+y7NADYnky3U5zB+lifRgcPHJV73m+4S5EFgH+SPiMXA8DXKbxXquLWF1Gr5aa
	 mogf3wnRLhP8zAcqAD57ZuemvbDJrF70zSExm2xJ8nDyUOmAUqKdWY/+b8KJMjktpU
	 t92YUVeFEEugbDi2yfEVPhvFlPyc0qJ+23ZK179l3b2QONnIs0+OCu1aFM35DOVGOk
	 0CWhiYFiR7l1Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fan Wu <fanwu01@zju.edu.cn>,
	Jamie Lenehan <lenehan@twibble.org>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] scsi: dc395x: sync the waiting_timer before freeing the host
Date: Wed,  4 Nov 2026 22:29:28 -0500
Message-ID: <20261105032859.1171835-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110424-unless-washer-9ef1@gregkh>
References: <2026110424-unless-washer-9ef1@gregkh>
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
[ sashal: Replaced unavailable timer_shutdown_sync() with timer_delete_sync(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/dc395x.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/dc395x.c b/drivers/scsi/dc395x.c
index d8967bf72ef26..5442713433f9b 100644
--- a/drivers/scsi/dc395x.c
+++ b/drivers/scsi/dc395x.c
@@ -4456,13 +4456,11 @@ static void adapter_uninit_chip(struct AdapterCtlBlk *acb)
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
+	timer_delete_sync(&acb->waiting_timer);
+
+	DC395x_LOCK_IO(acb->scsi_host, flags);
 
 	adapter_uninit_chip(acb);
 	adapter_remove_and_free_all_devices(acb);
-- 
2.53.0

