Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.192
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793763644;
	b=2/bM7FCzO2NOpsuWiuXOTT9ET2qHyPhK1qYBJFzxV4W+CTbmTmuDDm1VqViom8bZNgGn
	 7k4B8GBiB7q3+XZp55nd7ZpmYxtZkTWKbPIRjJ3EavyIIRgV21NPvyE0WBakJAe0MAala
	 4VtbLZ3nHOkBccAuxcaO08X9I1e4PtbZnvU9t0jb/pfHraOghszKrGkA/xv0DKqVZyeru
	 nQfV2MKZ4AICIgO+OtGy+p2R2vE1qUmWE8k3IJ7aIDNpgVZX8yIJ+tU6KM1IjfjDtFx8B
	 wzjeNle+JZlUBW3AKQfOi5jcEc2C7dNzmxdCHn8tKnNBsUUpAjE/44BbHLcOuqV5zlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793763644;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=KMGUUx+abGZBetvPn2ZZRhu/i7K4XgWYOdWg5RHIoQ4=;
	b=sGETEQUIH+mk52sVGSRyvf2nK+ybs700t4NH+UcbW80bZuo7psa5E1bumhA4pB2w6Oke
	 YvDU/He0FpMG6/VkuxNUnDgu+xE/7zHwNkJAjZFyuP5Z3I1ulUItgYDGC2loA2NMSKilc
	 etrvHRa15BZvxWuX2zZxAodj+fQzBcHtQINPbOgmUHVym+4ujerAOiIR9x7WDW4Pd/IvN
	 uA6HvUZrTjObrCpsdXeiBNIv5f+JjRxowZF8aabhvotRuJBkdi8tNbDgMvVipRayv/lmY
	 KZF0gLG/qKPRZttHODawG+Y3r4pnJXtiU9iYkHbZPX5Aw3h8eZWPDgKU5uyZKciViLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=XQ9cNjmi;
	arc=none smtp.remote-ip=91.218.175.192
Received: from mta0.migadu.com (out-192.mta0.migadu.com [91.218.175.192])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1D2606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 03:40:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B1D2606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=XQ9cNjmi
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=d8q17nt4gg/LWrH+2wR20CZaKMdkDabFkr/xqhI7JQs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793763641; v=1; x=1794368441;
 b=XQ9cNjmiGU/DsNIKUYYj/MArk9+xgeMzGT2vm5U7uybRliZdXKzNflhnKLa2mXy72EukaTBu
 NY95EaqnnDTFwGPUzyYq0Ol0tfl6HmciM2i4HqpAkDzQD5wfTyA+w0/3G645RCv5qQ1iyU4mbS1
 jqhkefo3y3bdT3zA1xQrsgBY=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 04e1281942ca9720;
	Wed, 04 Nov 2026 03:40:35 +0000
X-Mizu-Trace-ID: 04e1281942ca9720
X-Migadu-Flow: FLOW_OUT
From: "Luiz Capitulino (Red Hat)" <luiz.capitulino@linux.dev>
To: maddy@linux.ibm.com,
	npiggin@gmail.com,
	linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au,
	chleroy@kernel.org,
	ritesh.list@gmail.com,
	sshegde@linux.ibm.com,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] powerpc/watchdog: disable watchdog when watchdog_thresh=0
Date: Tue,  3 Nov 2026 22:40:18 -0500
Message-ID: <20261104034018.2676750-1-luiz.capitulino@linux.dev>
X-Mailer: git-send-email 2.56.0
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

On powerpc, trying to disable the hardlockup detector with:

 # echo 0 > /proc/sys/kernel/watchdog_thresh

causes an immediate and endless hardlockup detection, eventually leading
to an unusable system (splat example below). This happens because
watchdog_calc_timeouts() sets wd_timer_period_ms, wd_panic_timeout_tb
and wd_smp_panic_timeout_tb to zero, but start_watchdog() still starts
the timer (with expiry=0) in this code path:

proc_watchdog_thresh()
  proc_watchdog_update()
    __lockup_detector_reconfigure()
      watchdog_hardlockup_start()
        start_watchdog_on_cpu()
          start_watchdog()
            hrtimer_start() /* wd_timer_period_ms=0 */

However, according to Documentation/admin-guide/sysctl/kernel.rst,
setting watchdog_thresh=0 should disable both the soft and hard lockup
detectors.

This condition is already checked in __lockup_detector_reconfigure() for
the soft lockup detector and the arch-independent hardlockup detector,
what's missing is powerpc performing the same check in start_watchdog().

[  278.110085] watchdog: CPU 0 detected hard LOCKUP on other CPUs 1
[  278.110086] watchdog: CPU 1 became unstuck TB:33050716089564575
[  278.110097] CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Kdump: loaded Tainted: G            E       7.4.0-rc1 #1 PREEMPT(full)
[  278.110103] watchdog: CPU 0 TB:33050716089564185, last SMP heartbeat TB:33050716089563885 (0ms ago)
[  278.110109] Tainted: [E]=UNSIGNED_MODULE
[  278.110126] Hardware name: IBM,8375-42A POWER9 (architected) 0x4e0202 0xf000005 of:IBM,FW940.00 (VL940_027) hv:phyp pSeries
[  278.110136] NIP:  c0000000001bd518 LR: c0000000014dedf8 CTR: 0000000000000000
[  278.110145] REGS: c000000004b17a80 TRAP: 0900   Tainted: G            E        (7.4.0-rc1)
[  278.110155] MSR:  800000000280b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 22000224  XER: 20040004
[  278.110189] CFAR: 0000000000000000 IRQMASK: 0
GPR00: 0000000000000000 c000000004b17d20 c000000001c38100 0000000000000000
GPR04: 000000000000ffff 0000000000000000 0000000000000000 0000000000000000
GPR08: 0000000000000000 0000000000000080 0000000000000080 ffffffffffffffff
GPR12: 0000000000000000 c000000017fff300 0000000000000000 000000002ef3d820
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000001
GPR24: 0000000000000001 00000040c0a6075e 0000000000000000 0000000000000001
GPR28: c0000001fdb5b140 0000000000000001 c000000002291968 c000000002291970
[  278.110306] NIP [c0000000001bd518] plpar_hcall_norets_notrace+0x18/0x2c
[  278.110319] LR [c0000000014dedf8] check_and_cede_processor+0x48/0x60
[  278.110333] Call Trace:
[  278.110338] [c000000004b17d20] [c000000004b17dd0] 0xc000000004b17dd0 (unreliable)
[  278.110354] [c000000004b17d80] [c0000000014df020] shared_cede_loop+0x70/0x170
[  278.110367] [c000000004b17dc0] [c0000000014de460] cpuidle_enter_state+0x2f0/0x748
[  278.110381] [c000000004b17e70] [c000000000fe43b8] cpuidle_enter+0x48/0x70
[  278.110397] [c000000004b17eb0] [c0000000002cdcf8] call_cpuidle+0x48/0x90
[  278.110409] [c000000004b17ed0] [c0000000002d6300] cpuidle_idle_call+0x160/0x2d0
[  278.110422] [c000000004b17f20] [c0000000002d6578] do_idle+0x108/0x1f0
[  278.110434] [c000000004b17f60] [c0000000002d6938] cpu_startup_entry+0x48/0x50
[  278.110446] [c000000004b17f90] [c0000000000615c0] start_secondary+0x290/0x2a0
[  278.110459] [c000000004b17fe0] [c00000000000e258] start_secondary_prolog+0x10/0x14

Fixes: 2104180a5369 ("powerpc/64s: implement arch-specific hardlockup watchdog")
Cc: stable@vger.kernel.org
Signed-off-by: Luiz Capitulino (Red Hat) <luiz.capitulino@linux.dev>
---
Notes:
- This issue was not discovered by AI. We have a new test-case in our CI that
  sets watchdog_thresh=0, when running on powerpc we get the described issue
- This issue was initially reproduced on Power10, but I developed the fix
  on Power9 (which is what I have access now)

 arch/powerpc/kernel/watchdog.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchdog.c
index 582ee3fd71c1..44f178e07531 100644
--- a/arch/powerpc/kernel/watchdog.c
+++ b/arch/powerpc/kernel/watchdog.c
@@ -487,6 +487,9 @@ static void start_watchdog(void *arg)
 	if (!(watchdog_enabled & WATCHDOG_HARDLOCKUP_ENABLED))
 		return;
 
+	if (!watchdog_thresh)
+		return;
+
 	if (!cpumask_test_cpu(cpu, &watchdog_cpumask))
 		return;
 
-- 
2.56.0

