Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793655936;
	b=BWje/BnY4hLBamxNZnKQJ8gj2qf/HSuAv4jTsECWkZ8OGCZs4vT2ucdtnNva2wHWMNkT
	 +JOVfgT00/UKK4sTyjYFut/A6KFJvJ8S1E+Dq4sYdF+swy9S1wrlCNB0+1x/M2zVaw3qH
	 1w/Haea/PbDACLJ0C5aUGBz+/O2/mhmcMtKfcAwPhOY63cx2/duK2a8RF2iR8B5p+L1LW
	 aMh8vxZs+OkibbBfbDYTwPnGOHxS6X5HtDnHX5CBNpRV2+P9MOJNp61LRvVaf+KOk7vrt
	 U+5n7LL2d9RU3Pki6mBubpMPL8wzfRN0rvdVIOv/d1liimYr9isKt50fO5uk6usKyPg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793655936;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=8K4sDSR+XNlMacpmwjsCqcNr5RLWZIek+N8Cx6CDDD8=;
	b=YGTIXj8x4JFRiTjMYJwrewetYewrBEpWnaoXdkwmXpC2y3tAGMx5l+fGAj7XKkYF8tYP
	 gvOK5YBGzSUPaOcl+F1TBsWWefzteiuPFFzNECgjt16eXbJ9Wnz8PIt1uHToevVPNpa27
	 Qt7JkhW+PQ1ZezYi+97E3qHNquNPa0EV/4RSBodt9aq5YochuZYFYPMWy7z6LQMy31yXs
	 cH5RQconHY5OY0urVk34fkUHuzP9MOx5s0JMQHJgCB6J/ZVNZCjNw+72iUOzpJ9BIX8K5
	 viu+H7gwZ6CVtXoc6Sv+Abku6umNk2oqJhoTgZW+WR5DmN4oHGZg78Z9Z/N77Wmb+Hg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U+uMB1pT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5272E606A339;
	Mon,  2 Nov 2026 21:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U+uMB1pT
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793655936;
	b=bbCQ5a6gnfQyeO73FMDZUMDQTkbzW8rf531Z8lKV/ysvEyAgENT9An6GBsA0a+7V1TSt
	 R4ZdkWEVpERG2eMlSzu4sLPuycrv+ASgSEuVL4Qicng78pXlC8woHSvG7lFLu0cDpyQQe
	 G6plbmhZXbnY4NS+R04JQ/Iq6+e1PQZj/5c8lhqXN28cOiCmey70qByK+E7pEQg5aQyq+
	 FI4LRAI5spGbTGzcjI67/iimkLOIXHphiCGrBRCcQH5EttFmG2/2XXV+YyEpEj5ovZQtE
	 30khjH7gPo6FmxNvsvJRCt0fKXliRNmVjhFduyWJrA460aCvrdvO3/N9xgNMfzH8v8A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793655936;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=8K4sDSR+XNlMacpmwjsCqcNr5RLWZIek+N8Cx6CDDD8=;
	b=UHQxyVM+2POHLrZKBsrDv8oQszvxLSFzlLlJbPiLwmLKWU3debmgrEQiI++5RVNMdzU1
	 2d8PcOVTPPohk0n9oYAfkCQmVABSGGutH9fDuPzr3RjdumYxXYL9xzpPI1t7nm730ck4y
	 FKHD+CI3vGpYI5h8X1uVJzKg0U1qS4x9onf7D0dPkUGeQK7/SGYNI+UL8kWMHmdYGekS2
	 tyUNsbBC0DJUOwwfK99XTik5liH8zlHhctG/aw5n1gbto/zigTQ4jQI+KjmJ34kGEfEZ7
	 3VgV8UtlSR0fZHp1UwvOSa8EjfL/Du17OCAPSosWAcuDliTzFCKRF7NKvqo+M73pudA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 917621F00A16;
	Mon,  2 Nov 2026 21:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793655936;
	bh=8K4sDSR+XNlMacpmwjsCqcNr5RLWZIek+N8Cx6CDDD8=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=U+uMB1pT1uG7Ud/qU+KfHr7+xEIFskl2Ihk5yp0HLeiSC+8UkNgHSuGNhfQjmMLVp
	 kALa/QR62zs85WRLfnD1pBhPxhoxA8e3RxcmUFX70MT1Eip82pqNzUaPIJBbCsCr3e
	 N8eRxEiZ/gckYP26yrLNsqG/aoNE1jIJfIUbdTQfOA0sJ0IqOJFvNzUVeANNhgqWaj
	 T5+SFazwmA6k2x2HD9M61qarDrFsEowt9jMVnbTTg/SQLMwxIdSc/qjr56shzD//NO
	 D1qV/zwZMCOA5a+z05S44X6RBKy7d++I5VmG7k5g8uFKoKhxG9Dn/2w5lDdQgOAAfU
	 Nz7UApaKpDWhA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 2081C4668F;
	Mon,  2 Nov 2026 21:45:35 +0000 (UTC)
From: Mani Tofigh via B4 Relay <devnull+mt4022.columbia.edu@kernel.org>
Date: Mon, 02 Nov 2026 16:45:35 -0500
Subject: [PATCH] clocksource: Use the clocksource under test for the skew
 check timeout
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261102-clocksource-skew-timeout-v1-1-4ff412918591@columbia.edu>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQrCMBBG4auUWTvQRKroVcRFO/7RsdpIJlGh9
 O5GXX6L92YyJIXRvpkp4ammcapwq4bk0k9nsJ6qybd+41zrWW5RRoslCdhGvDjrHbFkDr7foQv
 DOmw7qvkjIej7tz4c/7YyXCH5+6Nl+QBA6AVcfAAAAA==
X-Change-ID: 20261102-clocksource-skew-timeout-f2a9e5fb3f75
To: Thomas Gleixner <tglx@kernel.org>, John Stultz <jstultz@google.com>
Cc: Stephen Boyd <sboyd@kernel.org>, Miroslav Lichvar <mlichvar@redhat.com>, 
 Srikanth Aithal <Srikanth.Aithal@amd.com>, Borislav Petkov <bp@alien8.de>, 
 K Prateek Nayak <kprateek.nayak@amd.com>, linux-kernel@vger.kernel.org, 
 tz2294@columbia.edu, stable@vger.kernel.org, 
 Mani Tofigh <mt4022@columbia.edu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793655935; l=5072;
 i=mt4022@columbia.edu; s=20261026; h=from:subject:message-id;
 bh=BwOAXMTSmN3S5CdQQNe0kwBbbM0riuH0AkP9PTw3cow=;
 b=X4hBPBJpPywiDSpkFxm5qV4E84jNKzIKZezeqM1NLCPq+buPyTkeybhiCSVmSBIjVpkq3+QEZ
 H63xSgmVSFxASydIlKIHue6PbkZC5vf8sKSYhCeW6fgGeRE1a2zBOt+
X-Developer-Key: i=mt4022@columbia.edu; a=ed25519;
 pk=gljCMQDuxyKPmd5y37CRpEJGSPXDV1MyAnHBhCgXl0I=
X-Endpoint-Received: by B4 Relay for mt4022@columbia.edu/20261026 with
 auth_id=1322
X-Original-From: Mani Tofigh <mt4022@columbia.edu>
Reply-To: mt4022@columbia.edu
Content-Transfer-Encoding: 7bit

From: Mani Tofigh <mt4022@columbia.edu>

watchdog_check_skew() waits for the remote CPU with interrupts disabled
and gives up after a timeout measured with ktime_get_raw_fast_ns().
While the clocksource is still jiffies during boot (or with
clocksource=jiffies) that timeout can't expire, because only the boot
CPU's tick advances jiffies and that's the CPU spinning with interrupts
disabled.

The boot then hangs when the remote CPU can't answer, eg in the
stop_machine() of the switch away from jiffies:

  CPU0                                  CPU1
  multi_cpu_stop()                      multi_cpu_stop()
                                          local_irq_disable()
                                          /* waits for CPU0 */
    <timer interrupt>
      clocksource_watchdog()
        /* sends CSD to CPU1 */
        watchdog_check_skew()
          /* waits for CPU1 forever */

Nothing gets printed.  With the hard lockup detector on in a KVM guest:

  [    1.554193] watchdog: CPU0: Watchdog detected hard LOCKUP on cpu 0
  [    1.554193] CPU: 0 UID: 0 PID: 18 Comm: migration/0 Not tainted 7.3.0-17087-gd865f2677c44 #1 PREEMPT
  [    1.554193] Stopper: multi_cpu_stop+0x0/0x310 <- __stop_cpus.constprop.0+0xdd/0x150
  [    1.554193] RIP: 0010:watchdog_check_skew+0x12d/0x5a0
  [    1.554193] Call Trace:
  [    1.554193]  <IRQ>
  [    1.554193]  clocksource_watchdog+0x761/0xc90
  [    1.554193]  call_timer_fn+0x154/0x470
  [    1.554193]  __run_timer_base.part.0+0x5d0/0x910
  [    1.554193]  run_timer_softirq+0xc2/0x280
  [    1.554193]  handle_softirqs+0x1f9/0x840
  [    1.554193]  __irq_exit_rcu+0x157/0x210
  [    1.554193]  irq_exit_rcu+0x9/0x20
  [    1.554193]  sysvec_apic_timer_interrupt+0x6b/0x80
  [    1.554193]  </IRQ>
  [    1.554193]  <TASK>
  [    1.554193]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
  [    1.554193] RIP: 0010:multi_cpu_stop+0xf7/0x310
  ...
  [    1.554193]  cpu_stopper_thread+0x1fa/0x3f0
  [    1.554193]  smpboot_thread_fn+0x2fb/0x8a0
  [    1.554193]  kthread+0x300/0x3e0
  [    1.554193]  ret_from_fork+0x4f0/0x6f0
  [    1.554193]  ret_from_fork_asm+0x1a/0x30
  [    1.554193]  </TASK>

Measure the timeout with the clocksource under test instead, which
keeps counting with interrupts disabled.  With the fix, the watchdog
gives up after the timeout and the boot goes on.  A 2-vCPU guest on one
host core hung in 4 of 150 boots without it, and it didn't hang at all
in 400 tests with the fix applied.

This bug was identified and confirmed with the help of a deterministic
hypervisor currently under development.  The C reproducer below however
hits it within about 80s on a kernel booted with clocksource=jiffies.

Fixes: 763aacf86f1b ("clocksource: Rewrite watchdog code completely")
Cc: stable@vger.kernel.org
Signed-off-by: Mani Tofigh <mt4022@columbia.edu>
---
Srikanth reported silent early boot hangs of large KVM guests that he
bisected to the same commit [1].  I think it's the same bug but it was
never confirmed.  Srikanth, would you mind giving this a try on your
setup?

[1] https://lore.kernel.org/all/e4a41d43-4d60-4132-aa2d-70e038a3e9dd@amd.com/

Reproducer: https://github.com/manitofigh/files/blob/main/linux-repros/wdboot.c
---
 kernel/time/clocksource.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 58c0ca11cdc5..fdce67f7c3d1 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -305,11 +305,16 @@ static bool watchdog_wait_seq(struct watchdog_cpu_data *wd, u64 start, int seq)
 		if (READ_ONCE(wd->result) != WD_SUCCESS)
 			return false;
 
-		/* Prevent endless loops if the other CPU does not react. */
+		/*
+		 * Prevent endless loops if the other CPU does not react.  The
+		 * timeout uses the clocksource under test because the timekeeping
+		 * clocksource can be jiffies, which doesn't advance while this CPU
+		 * waits with interrupts disabled.
+		 */
 		if (cnt == 5000) {
-			u64 nsecs = ktime_get_raw_fast_ns();
+			struct clocksource *cs = wd->cs;
 
-			if (nsecs - start >=wd->timeout_ns) {
+			if (cycles_to_nsec_safe(cs, start, cs->read(cs)) >= wd->timeout_ns) {
 				watchdog_set_result(wd, WD_CPU_TIMEOUT);
 				return false;
 			}
@@ -322,12 +327,13 @@ static bool watchdog_wait_seq(struct watchdog_cpu_data *wd, u64 start, int seq)
 
 static void watchdog_check_skew(struct watchdog_cpu_data *wd, int index)
 {
-	u64 prev, now, delta, start = ktime_get_raw_fast_ns();
+	u64 prev, now, delta, start;
 	int local = index, remote = (index + 1) & 0x1;
 	struct clocksource *cs = wd->cs;
 
 	/* Set the local timestamp so that the first iteration works correctly */
-	wd->cpu_ts[local] = cs->read(cs);
+	start = cs->read(cs);
+	wd->cpu_ts[local] = start;
 
 	/* Signal arrival */
 	atomic_inc(&wd->seq);

---
base-commit: f322d7f7ae56bce728ba03a387e35380bc4ad939
change-id: 20261102-clocksource-skew-timeout-f2a9e5fb3f75

Best regards,
--  
Mani Tofigh <mt4022@columbia.edu>


