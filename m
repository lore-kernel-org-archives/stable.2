Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794629535;
	b=0VhIksXJBCE2g5SWgCACUWLs/pV1nQnbL2OGFFx4QwqVX04fW5wtIAzAW7OFCQqQ4AbZ
	 cZF3uB8OG7pPo02YHq+PKG2wczJ6Rkw6YT1pujyZ+9EkKk1rslNMEn7XxjoB9bFQkDbD+
	 nCMPH+OxpTgR2nMfNAWViVz7pyM+wEwZEwZV9HOxxDlGMH5HqHKlgFel3UqbMhJMCDDd+
	 Kzu2jMCqDj6U7bHIAJtRXKq5LhB5uZruacMEv07kUrsun2HNvU+Ocl5cVzSvwTk0dM7W0
	 yHgcVrjDPHd7/FoA9KNICXkkZ5yiK836lX+OdsPnJ+O/IBlAZlne/MkLnr3J7X7OfXw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794629535;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=NFwByUoCkck0oIRmvyotKPAFHoWYrG3yCNyiAjA4CJU=;
	b=Dl55uISdcvQnI/h4b3qosl3KWkZTWLvYqF4fC9vWf1REJRAsSWOuhdkWiZP3ONw192/k
	 2R8b4cxEKAUb+uJMTjQFHoWvVbHyIYPnDK49pK4GTffagCm5krxC2M2LzDos2wc3qN5D4
	 hQB6RbMbWynyhcu+XZCRxGaam06LQ4glG/kAO8ZefHr9v+pTT8XmBT6mkJNiUck1ykIon
	 5wPBv/ZZZYrSKo/hhMKBkOxRm00k/NdfcF9yKwBMXwN2J64gCl0HSTcO40Ee0gsJaoEfm
	 wcEF8eW0niwUCJALybKem670BHEeoaWbV6+FaxafvUMKKaOlHODrAbtZ0kz2+qIEW2Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="OfQ/MZEK";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80FB606A327;
	Sat, 14 Nov 2026 04:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OfQ/MZEK
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794629535;
	b=pOElRqZ+sajpUpzF69howgRterUZHHQFTi5Ig7zenI4dhOgjk2rv7m7NeBnJRieGidS1
	 TxWcy9ydfcY0gaFVNZVC8JnBCIhs26M45F8FCm2YeEVL+0wsRgLM9Gs2QI+i4HZm+k7VV
	 SoFIuJqzmhyvk1yWoO6dXENWsDI2HTxIbSEm2Edj83fvYW1ECmu6hmAn609bRVfnHjR89
	 MVvmvffHDn1hyTqH9K/BIWsUx5Jb1RTqKanYbL89DpA8+Ubto/9wE/BeDddyjJChTTZEG
	 Jm8St6pveCTrxhK2BRB9eyHJ+lCzLe3rL78vIUhzp9UiX02cW3I4pmbrpiGSSOROqCg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794629535;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=NFwByUoCkck0oIRmvyotKPAFHoWYrG3yCNyiAjA4CJU=;
	b=UNIZ+CDNfbOOizDTg7wDodE+JsQ95h7QB5tjBESoe2jRt1AqaarmjkwO0NWKmpLz7iI8
	 LfGPxi/iUSZ8CF0Dc9ptm8cuisXFDx2f7sp+Iv4HBEQWXJZjc9VQnnt9mm6jC0rR7yO2s
	 lduftsiWwU+ikPI+rFR0NyW8gYE0FyVhWYyAFtGjpkAGSZrWIQ2tdv3pDmeCbMBb1l4DA
	 JCgqcuxi4I0KfSTY9nKqxnwa+MR0oLEjcf6GzZd2qpyJh5ap0wj8F6FG47tJGWxfitgD/
	 ciMIq6xlw074O+zW+RVnxWdEV224qzp0k6ExHdK6egBRXg6o7xvtfnV5qfuQFMBhR4g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 9317C1F000C4;
	Sat, 14 Nov 2026 04:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794629535;
	bh=NFwByUoCkck0oIRmvyotKPAFHoWYrG3yCNyiAjA4CJU=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=OfQ/MZEKxkwTd2FdorEzdYc9xFYTHFW65D7pxhMli3pkOnGwgj0Y+aRf1Mm7qamx4
	 etTUa1X/2CLLVPKf8G68Fuwr+7c97OcChwY0aWktQ0pN6lkH2RVNkmrPXn4lXqrO57
	 MZxTSCL/VZcKJzv17O6wSsxeJjb6IC7sVBfjejeUrnOln/wsu2Fe03NxL+FwyoI0V8
	 MFwIuS4dpxrCr2U0ntOYyh7gDL4SPwkOVgyMXvwdyRbYiamHJXm3vG1NYrRVb9iEgu
	 YrTUpX2fsqhOCQfW6YBiSvD9RbmT76rDoze07AEZnF3Q90RNGvdopG6jSvCjWqAXSw
	 SZ3XOICXcu9Ag==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id DE85B49C73;
	Sat, 14 Nov 2026 04:12:13 +0000 (UTC)
From: Mani Tofigh via B4 Relay <devnull+mt4022.columbia.edu@kernel.org>
Date: Fri, 13 Nov 2026 23:12:13 -0500
Subject: [PATCH v2] clocksource: Use the clocksource under test for the
 skew check timeout
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
Message-Id: <20261113-clocksource-skew-timeout-v2-1-9361d9a18262@columbia.edu>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NTQ6CMBBGr0K6toapoOLKexgWUKYy8lPTaVFDe
 ncBL+DyJe973ywYHSGLSzILhxMx2XEBtUuEbqvxjpKahYVK1REgVVL3Vndsg9MoucOX9DSgDV4
 aVRWYm/pgTrlY5k+Hht5b+lb+mEP9QO3X3mq0xN66z/Y9wer9cTOBBJkZk4Eq4JwXcNW2D0NN1
 R6bIMoY4xcK9MT/1QAAAA==
X-Change-ID: 20261102-clocksource-skew-timeout-f2a9e5fb3f75
To: Thomas Gleixner <tglx@kernel.org>, John Stultz <jstultz@google.com>
Cc: Stephen Boyd <sboyd@kernel.org>, Miroslav Lichvar <mlichvar@redhat.com>, 
 Srikanth Aithal <Srikanth.Aithal@amd.com>, Borislav Petkov <bp@alien8.de>, 
 K Prateek Nayak <kprateek.nayak@amd.com>, linux-kernel@vger.kernel.org, 
 tz2294@columbia.edu, Mani Tofigh <mt4022@columbia.edu>, 
 stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794629533; l=5524;
 i=mt4022@columbia.edu; s=20261026; h=from:subject:message-id;
 bh=qa93QCBknsgPMlWtKisZvhE+AO3Pt47PR9ZovD5lOZg=;
 b=N5vm0VGdkSowOxUn5xef9uAmY1tW/5ACA4RREKq2zL+uk7CXgrpBhfyyuVH5olXCmYk+IgE/o
 u93qBaW3zNxD4Ta6vAIZr+5VyKWuEhiaBoJtsrFJwikGQUNnEZl6d6U
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

The boot then hangs silently when the remote CPU can't answer, e.g., in
the stop_machine() of the switch away from jiffies:

  CPU0                                  CPU1
  multi_cpu_stop()                      multi_cpu_stop()
                                          local_irq_disable()
                                          /* waits for CPU0 */
    <timer interrupt>
      clocksource_watchdog()
        /* sends CSD to CPU1 */
        watchdog_check_skew()
          /* waits for CPU1 forever */

Measure the timeout with the clocksource under test instead, which keeps
counting with interrupts disabled.  Also, when the remote CPU still
hasn't answered by the next watchdog round, report it as stalled and
mark the clocksource unstable instead of retrying forever.

With the fix, the watchdog gives up after the timeout and the boot
continues.

Fixes: 763aacf86f1b ("clocksource: Rewrite watchdog code completely")
Reported-by: Srikanth Aithal <Srikanth.Aithal@amd.com>
Closes: https://lore.kernel.org/all/e4a41d43-4d60-4132-aa2d-70e038a3e9dd@amd.com/
Suggested-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Mani Tofigh <mt4022@columbia.edu>
Tested-by: Srikanth Aithal <Srikanth.Aithal@amd.com>
Cc: stable@vger.kernel.org
---
The reproducer hits it within about 80s on a kernel booted with
clocksource=jiffies, with both vCPUs of the guest on one host core:
https://github.com/manitofigh/files/blob/main/linux-repros/wdboot.c
---
Changes in v2:
- Fold in the stall check (Thomas)
- Drop the hard lockup backtrace (Thomas)
- Add Srikanth's Reported-by, Closes and Tested-by
- Link to v1: https://patch.msgid.link/20261102-clocksource-skew-timeout-v1-1-4ff412918591@columbia.edu
---
 kernel/time/clocksource.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 58c0ca11cdc5..5dfa72a2db68 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -250,6 +250,7 @@ enum wd_result {
 	WD_FREQ_RESET,
 	WD_FREQ_SKEWED,
 	WD_CPU_TIMEOUT,
+	WD_CPU_STALLED,
 	WD_CPU_SKEWED,
 };
 
@@ -305,11 +306,16 @@ static bool watchdog_wait_seq(struct watchdog_cpu_data *wd, u64 start, int seq)
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
@@ -322,12 +328,13 @@ static bool watchdog_wait_seq(struct watchdog_cpu_data *wd, u64 start, int seq)
 
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
@@ -392,7 +399,7 @@ static void __watchdog_check_cpu_skew(struct clocksource *cs, unsigned int cpu)
 
 	wd = per_cpu_ptr(&watchdog_cpu_data, cpu);
 	if (atomic_read(&wd->remote_inprogress) || wd_csd_locked(wd)) {
-		watchdog_data.result = WD_CPU_TIMEOUT;
+		watchdog_data.result = WD_CPU_STALLED;
 		return;
 	}
 
@@ -584,11 +591,16 @@ static void watchdog_print_freq_skew(struct clocksource *cs)
 	pr_warn("Clocksource %20s interval: %16lluns\n", cs->name, watchdog_data.cs_delta);
 }
 
-static void watchdog_handle_remote_timeout(struct clocksource *cs)
+static void watchdog_print_remote_timeout(struct clocksource *cs)
 {
 	pr_info_once("Watchdog remote CPU %u read timed out\n", watchdog_data.curr_cpu);
 }
 
+static void watchdog_print_remote_stall(struct clocksource *cs)
+{
+	pr_warn("Watchdog remote CPU %u stalled\n", watchdog_data.curr_cpu);
+}
+
 static void watchdog_print_remote_skew(struct clocksource *cs)
 {
 	pr_warn("Marking clocksource %s unstable due to inter CPU skew\n", cs->name);
@@ -629,9 +641,13 @@ static void watchdog_check_result(struct clocksource *cs)
 
 	case WD_CPU_TIMEOUT:
 		/* Remote check timed out. Try again next cycle. */
-		watchdog_handle_remote_timeout(cs);
+		watchdog_print_remote_timeout(cs);
 		return;
 
+	case WD_CPU_STALLED:
+		watchdog_print_remote_stall(cs);
+		break;
+
 	case WD_CPU_SKEWED:
 		watchdog_print_remote_skew(cs);
 		break;

---
base-commit: c1b96ba87e3caaa701d6dba254e58db7cc3c99be
change-id: 20261102-clocksource-skew-timeout-f2a9e5fb3f75

Best regards,
--  
Mani Tofigh <mt4022@columbia.edu>


