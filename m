Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C9D3CB2E5
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 13:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784207971; cv=none; b=mIUrnBjkarKcSZfmufodfFXXW2Yi5NwCf//TnmUDpYdNJdkAkMngNp5jdPI62J+thBZwadyBLTLPRF9qc6ADSXTUFHb9viqFh4m2dctet0dt8dsMQo8dVgSQHaWaKGohW+xoDPszaMuBp6h3O2cjvQuKFQTbQes4hKROVG8RCjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784207971; c=relaxed/simple;
	bh=wWsVOpcZuhFgQ0XxxinLh8KgoyGWRZQaaAA32ks1le8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lAR7A/huLpIn3+eWmDSf1z0U6JOZxJfsyzHe/yIbLUT+87f6IbcSoXWfp+kfFdZW2ZN3M6z3gHaZ5KeoSKvbs1Jz5B1E37eft1gVK28uiztSB4VdrfDByKCD0IU2cO4TlnGPu3BWKu0BzTQyzfFaVfXRJIk8DPosFfEwC8Pe8OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TDKtmWMm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TDKtmWMm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE37B1F000E9;
	Thu, 16 Jul 2026 13:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784207970;
	bh=Yxi7632W1MYeAKUkxifMWPJP+aaY/oZxHENP6NuCbzg=;
	h=Subject:To:Cc:From:Date;
	b=TDKtmWMm5O5HSIVPGfWsQGI0aG86MsdmIxAaDwo89n4HOssD5OSphgAJLx05yze85
	 cv/+oyVvbz1kWJ+WEpWOVWF7wuciCAgmKBpxnFXLF1CIjKkVV+ofItxqBPCo8R5ju3
	 Dme7WeI2fgIRjCdl44Uyw5Dtc2AX37IxAdxK1FUQ=
Subject: FAILED: patch "[PATCH] timekeeping: Register default clocksource before taking" failed to apply to 6.12-stable tree
To: mikhail.v.gavrilov@gmail.com,leitao@debian.org,oleg@redhat.com,tglx@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Jul 2026 15:19:23 +0200
Message-ID: <2026071623-scurvy-remission-1d7e@gregkh>
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
git cherry-pick -x 8fa30821180a9a19e78e9f4df1c0ba710252801e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071623-scurvy-remission-1d7e@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8fa30821180a9a19e78e9f4df1c0ba710252801e Mon Sep 17 00:00:00 2001
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Tue, 16 Jun 2026 12:09:14 +0500
Subject: [PATCH] timekeeping: Register default clocksource before taking
 tk_core.lock

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
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Reported-by: Breno Leitao <leitao@debian.org>
Reported-by: Oleg Nesterov <oleg@redhat.com>
Reviewed-by: Breno Leitao <leitao@debian.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260616070914.65818-1-mikhail.v.gavrilov@gmail.com

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 0d5b67f609bb..b1b5ec43c0f2 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2061,13 +2061,14 @@ void __init timekeeping_init(void)
 	 */
 	wall_to_mono = timespec64_sub(boot_offset, wall_time);
 
+	clock = clocksource_default_clock();
+	if (clock->enable)
+		clock->enable(clock);
+
 	guard(raw_spinlock_irqsave)(&tk_core.lock);
 
 	ntp_init();
 
-	clock = clocksource_default_clock();
-	if (clock->enable)
-		clock->enable(clock);
 	tk_setup_internals(tks, clock);
 
 	tk_set_xtime(tks, &wall_time);

