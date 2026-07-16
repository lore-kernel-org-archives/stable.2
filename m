Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC18A3C9429
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 21:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784237768; cv=none; b=MU8xx48G5k4yLoOHN1hjgNMiI5xZqC632iXVObwu4zDaZA3qWAKHfIqiEBwxZBC/CmmTEi2H6nsdlWjYet/5XiTztPb23y8wmnFtfTxvGw9XNIHhdqya4zq+bjPreRTgmuxMOSmE5ZJyadB03ZWl/8+CIj6JIwiEDRNCD/VVn4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784237768; c=relaxed/simple;
	bh=Qv8EKNaB4gxs3G/+kzHZdaGKrz+F5QADykQpIfoQcWg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bKMfEeiK1/v2AOgaEfw527yJS3lCDBq15tlhHqElBGJZUdBgehLSj5/Ou+DJ4KZJPZP9gqRVvKNcn5pyB4aRY+3ASjSUh/bgTx5bjD4mfouFRBOrZqungRmBVfT6xnyWCm9CUA3dAHx5X8/ch/oQqAsBzc7fzVzdscxvpv4mDzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ibkHLwLJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ibkHLwLJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B90FD1F00A3D;
	Thu, 16 Jul 2026 21:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784237766;
	bh=o9mIz+glcahnY+6T6Udy4Pv/q+bn7nbAtWaBI6Hasfw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=ibkHLwLJ1LSufDZ0zFUoQ/dun7qcNRSQZBZAC2P9sKDoFs3DJGsr36vEDC/NUojGG
	 I6HYPBQ6z8QiK92fkjFatvKCbW/edoBm1zEkDgKMVlM+gkI8NaNO/EwZTpMJ3dsRfv
	 FtydnfZM9Paj5gVqDNjPvkCe4Wt45ZtvgjZMAC1OhZA6YsHkGXKr+/uZYm9+lSCVfz
	 a8Ly4Byv9Ec4hpCXLxPmLSUThZg7vAQKbEuXfyS6zUnjlj/2vQDf7kzQ0Mr/HVbNe+
	 9YJ0JKq0kZNbSTBZf/x9yx0muly0V+VFGIVQ6flJZAwvksn0oNUy+0WiRNWegyBdAz
	 qrCgl+uMH4Z/A==
From: Thomas Gleixner <tglx@kernel.org>
To: gregkh@linuxfoundation.org, mikhail.v.gavrilov@gmail.com,
 leitao@debian.org, oleg@redhat.com
Cc: stable@vger.kernel.org
Subject: [PATCH 6.12.y] timekeeping: Register default clocksource before
 taking tk_core.lock
In-Reply-To: <2026071623-scurvy-remission-1d7e@gregkh>
References: <2026071623-scurvy-remission-1d7e@gregkh>
Date: Thu, 16 Jul 2026 23:35:59 +0200
Message-ID: <87o6g6obwg.ffs@fw13>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

commit 8fa30821180a9a19e78e9f4df1c0ba710252801e upstream.

Commit f24df84cbe05 ("time/jiffies: Register jiffies clocksource before
usage") moved the jiffies clocksource registration into
clocksource_default_clock(), so that it is registered lazily on the first
call. __clocksource_register() acquires clocksource_mutex, but the first
caller is timekeeping_init(), which invokes clocksource_default_clock()
while holding tk_core.lock, a raw spinlock.

Acquiring a sleeping mutex while holding a raw spinlock is invalid.

The default clocksource only has to be registered before
tk_setup_internals() consumes its mult/shift/maxadj. Neither
clocksource_default_clock(), the ->enable() callback, nor the registration
itself need tk_core.lock, so fetch and enable the clock before acquiring
the lock. This preserves the "register before usage" ordering while
keeping clocksource_mutex out of the raw spinlock section.

clocksource_default_clock() has a second caller,
clocksource_done_booting(), which invokes it with clocksource_mutex already
held. That path avoids a recursive lock because timekeeping_init() has
already run and set cs_jiffies_registered, so the registration is skipped
there. This change does not alter that; it only fixes the invalid wait
context in timekeeping_init().

Fixes: f24df84cbe05 ("time/jiffies: Register jiffies clocksource before usage")
Reported-by: Breno Leitao <leitao@debian.org>
Reported-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Breno Leitao <leitao@debian.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260616070914.65818-1-mikhail.v.gavrilov@gmail.com
---
 kernel/time/timekeeping.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1685,13 +1685,14 @@ void __init timekeeping_init(void)
 	 */
 	wall_to_mono = timespec64_sub(boot_offset, wall_time);
 
+	clock = clocksource_default_clock();
+	if (clock->enable)
+		clock->enable(clock);
+
 	raw_spin_lock_irqsave(&timekeeper_lock, flags);
 	write_seqcount_begin(&tk_core.seq);
 	ntp_init();
 
-	clock = clocksource_default_clock();
-	if (clock->enable)
-		clock->enable(clock);
 	tk_setup_internals(tk, clock);
 
 	tk_set_xtime(tk, &wall_time);

