Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793839100;
	b=rU7fx68ltk7dr5Zzx5qlBOS5H64Q1lgnEpMb+0GsCwQKmf7KOzfebsgqm0CsjVVm4qJK
	 t2e5mkPozyHlDynWGBOVMrHARJQK/fHFLawWNYu04M5m2huHWohnglnb6HGmBP6ZXKQCj
	 YoiTgJAGhgd597kvYX+dB+GbXIw6xr5JDwmk3hAuYdKSvJdkU4QG28c0pXZMNDA4FZ9T8
	 3Kl1ZwzLS2J2HK7iJ6vzdBHEuV53hOIs0DSAOwdBzHfqZt8q0lJf09krj8LI0L7t1tBSH
	 DJozToi2WgqJydadOn9ZRZ2A95Z6sDXmCepJAJXr/5J6ZTWxeb6J3kJz6d7Jj/50z1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793839100;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=KUDxiSxJITvVYaGfMBSH9nFZ7Mf1lJhQlaGqO5wXTVQ=;
	b=MF54KjgBBLgjr8rTAC83q9WEMcCejVtrWasK2zuVn8wjqrXX0Z3N8SFCMueBnLt7D7j+
	 GrBs36lAsImxOvJBAJxVvjS/Ztx3IrybRIBe4kYzmC4aEOPabb2xR5+SHrxW9x9QkbyK1
	 zOoKg6CmB1gzyu4RuBZE3coUeFgKaRtQ+6kiI71BIL/CReOYGS/scWhSp57qDQ180YeTm
	 VkvnobNliZTZ5iu5U2rt9idx5rtpnALyxR3zdo4dBYE9hlqN0trlCNud4UT8Z+mnKgpwY
	 zsX8x198tD6q7a6BqScggtnqzo8sEabgulPmmzXel+AJ2d3pxfKF1hNA3mg9sbgXz+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BeOjNIwd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFA5606A32E
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 00:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BeOjNIwd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E8631F000C1;
	Thu,  5 Nov 2026 00:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793839100;
	bh=KUDxiSxJITvVYaGfMBSH9nFZ7Mf1lJhQlaGqO5wXTVQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BeOjNIwd6K1AztiBE4EQkmP+lxITuSV5xfvDLy89iTFT1vGkUhfWdBfdH7UVByoYf
	 96y6GNlhlFXDhmUDzIo8FvxdOq9olD8wyUf6X4Aw+uyvpahVli+W2h7lqXe60wTZBz
	 GOAHv6O6VXgRp6GHI6JhWYIP0xGjYMkiDTZYxwLWX5cK0nnIEde8dEuhMQptN5/+ow
	 0cqRN1eMsOzy6i5WLA7P14FuQQ8LFBhpTkW3egGGH1b7INRgRr48Ecv/9yaToM734A
	 bzl91UYMx4jVvyslnBhgtGxIZJ9Wt3PNshgypb1IFQGYYuycnGSrIu8bR5ctX8oLfj
	 kHsZuXNJOn3Fg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fan Wu <fanwu01@zju.edu.cn>,
	Jamie Lenehan <lenehan@twibble.org>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] scsi: dc395x: sync the waiting_timer before freeing the host
Date: Wed,  4 Nov 2026 19:38:18 -0500
Message-ID: <20261105003740.1022036-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110423-almost-vantage-160b@gregkh>
References: <2026110423-almost-vantage-160b@gregkh>
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
[ sashal: Adjusted timer-removal context for existing del_timer() calls instead of timer_delete(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/dc395x.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/dc395x.c b/drivers/scsi/dc395x.c
index 670a836a6ba19..f18cd86ee7b4c 100644
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

