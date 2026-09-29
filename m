Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5053252F27F;
	Tue, 29 Sep 2026 21:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790718206; cv=none; b=GaVu8a01HNFbGUBtMQr6TbXUkeKZc7mjTR64thSZOgZMNCJLT484pMaHy4WGqfqAOe4u7LiR2p2sLpAsr4eIa21u8pjZglfjZExRLinLtVgW7ELekLLnEAxAeSvHt/a0mTj6NceEXPBbyAbkLMPS7UJCPvr43+2XQTDh97iJ3Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790718206; c=relaxed/simple;
	bh=AYYs+qrWjxXRo32JaM/96E9PNBHB4VuFPWz7X+U4sTo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=J+mDUdNIqOZNFHZLqB7YtawQ6BXSDeb+cM2odvjfqIT1IKf5a00sySTl1EPuiXHrp5SSubjyKvB4B8Fb6dj0pA+ocXWqeg9hQIGZiw+VheyHIorUXfuOI3czk09xH5VhlaKTfA2H3lAHqHgBADVdQduoLSv3vAncNM1615Wn4V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DNAyFuJZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L8r72iYe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DNAyFuJZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L8r72iYe"
Date: Tue, 29 Sep 2026 21:43:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790718184;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9KoIhd1++z7e0xBEFXI0dn3YEdSeou2/+toTtFoE7ps=;
	b=DNAyFuJZt8SUlZbRvkZBMFmxnaV7N2BT0SDGJIuq5uqZnIBGYTQMmasyNTjbYfYmoA8JXo
	MuVVVUXBf8Zd5DfxHIHHWYJTUC9P65LgVAs0HrpKx3T6lTi+y0Yvxo84WZds49sVEnpiaz
	h1fAbZNKZ6NghqsYZobZ27wEvNa+wMmFxv6ug7EXfHCc80ErMyo/oSc/ZWOgTxOWHURurW
	GJFQbXbj3Oguc/e1oXoyOO9qjGMkpj3/UnSzSGhKjGReyzMTaPbZMBY48gqCBVVzDa2FzR
	GfpnorbH9xLKw17XeJN7LnPbDQv2zrQrAWT1wFJ3jmf7om0EtPaTjiOP7hqhkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790718184;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9KoIhd1++z7e0xBEFXI0dn3YEdSeou2/+toTtFoE7ps=;
	b=L8r72iYeg1cLPa9C7Mmoqjt3vRR+R6+fYy4inGEoP5qX2Rw87ObtVbGIJ7OBVUwVJDIPYv
	BpHeb/+uGFtsiiCA==
From: "tip-bot2 for Karl Mehltretter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] hrtimer: Use the mask to clear TIF_HRTIMER_REARM
 from the exit work
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
 Thomas Gleixner <tglx@kernel.org>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260919144027.70250-1-kmehltretter@gmail.com>
References: <20260919144027.70250-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <179071818280.3910103.4410625048347203382.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     28fa9af353bed2bb738c46e31f9b7d0347b759d1
Gitweb:        https://git.kernel.org/tip/28fa9af353bed2bb738c46e31f9b7d0347b=
759d1
Author:        Karl Mehltretter <kmehltretter@gmail.com>
AuthorDate:    Sat, 19 Sep 2026 16:40:27 +02:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Tue, 29 Sep 2026 23:42:11 +02:00

hrtimer: Use the mask to clear TIF_HRTIMER_REARM from the exit work

hrtimer_rearm_deferred_user_irq() removes the rearm bit from the local
copy of the TIF work with:

	*tif_work &=3D ~TIF_HRTIMER_REARM;

TIF_HRTIMER_REARM is the bit number (12), not the mask. That clears
TIF_NOTIFY_SIGNAL (bit 2) and TIF_MEMDIE (bit 3) from the copy and
leaves bit 12 set.

So the function never returns true, and the copy handed to
exit_to_user_mode_loop() lacks TIF_NOTIFY_SIGNAL. If that was the only
work for the loop, the task returns to user space with the task work
still pending. hrtimer_interrupt() sets TIF_HRTIMER_REARM every time,
so the next tick repeats that. Task work queued with TWA_SIGNAL from a
hrtimer callback stays pending until the task does a syscall, takes an
interrupt without deferred rearm or has to reschedule.

A task which polls the io_uring completion ring in user space sees a
timeout completion after 30ms (median) instead of 70us. 2 CPU QEMU
guest, HZ=3D1000.

Use the mask.

Fixes: 15dd3a948855 ("hrtimer: Push reprogramming timers into the interrupt r=
eturn path")
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Assisted-by: LLM
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260919144027.70250-1-kmehltretter@gmail.com
---
 include/linux/hrtimer_rearm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/hrtimer_rearm.h b/include/linux/hrtimer_rearm.h
index 17a8182..12e4272 100644
--- a/include/linux/hrtimer_rearm.h
+++ b/include/linux/hrtimer_rearm.h
@@ -45,7 +45,7 @@ hrtimer_rearm_deferred_user_irq(unsigned long *tif_work, co=
nst unsigned long tif
 		clear_thread_flag(TIF_HRTIMER_REARM);
 		__hrtimer_rearm_deferred();
 		/* Don't go into the loop if HRTIMER_REARM was the only flag */
-		*tif_work &=3D ~TIF_HRTIMER_REARM;
+		*tif_work &=3D ~_TIF_HRTIMER_REARM;
 		return !*tif_work;
 	}
 	return false;
