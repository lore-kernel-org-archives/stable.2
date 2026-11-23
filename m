Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795441937;
	b=0wBMSJY990mSatpAhiHnorzP3WWUnonMl7InFozRtIq8rukkDieBJEIhYbCQA71Wv78q
	 v8fb751RdP/k6whhCwtrOdz+cW+JEiW+5qFGLQw3EpyBaHpVwASfK572g/r1oA2dxzfIV
	 /CakfTRLCr9HRJB8dRguDF/Nf2P369eKyQhCO+teOOu1Z+c9TxlA5Oq/lWAHXRCxVrHBn
	 IUlApUhDU4ogAK8Ot9G7rRtk+nBDtQlGvLuMhGR7+reyJ60+Z5z90vvrZFmNTcz4OL+3n
	 jPLUIPBTCrHkTBJHmPJfywehiburSKW1P7pkcPJUU1xWkG2s9VTvlSXszUNGeXyL1lQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795441937;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=a/CsYCjZnUT9LdHmBziM6cx7f8RTiWtsUMpbEwB8YcQ=;
	b=r3rIbBywg6hI4QJ2FWjN1KIkUBQGwK1fb1/MULK6u8G0Nnvg+n3XcaIzhRMw9kSyoNp/
	 kAwifyst98j3/+WIxmXcyvKx2h5qetI3TcjKqe/Xmu6FBLJPcLrGLQmhy7xs7f1LULYpR
	 hSP+ygBrzG4MnM+Ypt0ILU0nyFp0L5uF6/XcbFUzQiqnwgFeXveTAAmVa0UVhr3E3Y8Zc
	 pQfJcKW9h0nOU5qcMeyTFpg1MiPbA7jlzzZ2zc3PfWOep79KfO4ohEyKS6h5ZLHzroTDx
	 e2qjmMJGio1Q3AZU6bcOk0HNeLvxsH2Ce3xzZYwCpZoPzLIl3g8SKzFMArbYmcRLIAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mw1MZ9EX;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270CD606A333
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 13:52:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 270CD606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mw1MZ9EX
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3b0ae87069dso1295688a91.2
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 05:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795441936; x=1796046736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a/CsYCjZnUT9LdHmBziM6cx7f8RTiWtsUMpbEwB8YcQ=;
        b=mw1MZ9EXS3Xb9Gv2GsvjmIR4ENEKbUcASevEEuWnMri/AfZnxURndMIBXpflww8kDs
         syOzU892XFIZWFsSryUWTJeQpSrwfxJeBsTHRwNnIPhd/9ecjt0gx22uYIX4J6e5H7eJ
         34eJAr+n6S5mXK5l7F/fdc3w3XEcDifL7m+vcmssjSTp9SwNCMB3sM0tIDrU/TJBDHvH
         PuKl119fO8NciAroANnJt9uZ4GbnQkuK2fWI/wMwJNrJfyNnITD7KmfhaNeU83S2fIJD
         NULHlE2LeRQiKIXEI/dJsgyDFZYJlGqtdtnD85gqk0ODMikoyb+Qn/5mTA3qYjU6rVZx
         wz4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795441936; x=1796046736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=a/CsYCjZnUT9LdHmBziM6cx7f8RTiWtsUMpbEwB8YcQ=;
        b=ER6nNaDDyQCz/mIhYnRkISHcEDVqB9prIfEmc32BvSxvF8e2EiM80kjdaxAZvGFfcQ
         nvXxkpwy0BArQ6GYMTkSF7btmykD5j0/+7vgg6y+MA1YH9KBAGY2GZrbCrTfD8JM43S7
         mTvdUtmZmi+EMj4X+q4DQJ3R3zbbcp0cyTE8Xu70UFglPVRj5NrpzFttqDRFj41c9GLs
         TuBQM1NBOlOtsOtmi/oeOQU4p3jVziwe/OlvZko7raYFRsXxfkxMiwrJkBVzeeJQpPs/
         PgXF0/FbTrBOQvhXkEtvdgANRWKCEcPGLGfWUjYdLAe1oDwr/xEvxDvQfNdszRCsNP6P
         R4sg==
X-Forwarded-Encrypted: i=1; AL+hErHLkm7OcSTjNvfn10PjyrURKs587tpLJgDwQjZjC6cMZ5blAO46U0/Rw8cu4TppeK6pnkOIZyY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8kfRIzhg2yGEBmwU3ip1h07ibe0nXg4lEmkiQ6PVM3xfFdwb0a
	2szELICFW8zs3KZOR0UzqhjCsHqBxYJLhZHHuoOFVbY+WjvT924SfB02
X-Gm-Gg: AZFdTZeb2MiU1tuBfewZAsC1t3Rd97BcpX+BmoUd6Z66+G0QojoOs8EFIc5EdGPdL32
	O6YLf76DHNDFDGtBeStYro3M8I6Qddg03AN4H4EQRiWcrIYWwjs19m4Bb+r8fzSN5hWyXmZnW1I
	95eAD30E/zcqQA/GR97brXurI8z1SMqMlfLSJkKTUBGHkI1sMQdGvfVLzqs6SH587E6lznzWds8
	CWFX+Gd+xPBIKNix4vNwjJZ+4cGdAZG+KwzOSQYtyHn1gxqFtN39+9HnLHopESJ+3+3eHWT9V5c
	B83OeYR6ySz7oxXlSP2eAGqfwCQVIrhRrJtkUo8eYETdehDvpwE0vPT5TRNnSaqpfDgDj/XBucz
	hxcpRp+9L96nsm9axIYSJldxtCb146mEQ2NMq6ftqscFnSTq/L7+Y7qyAfLeaaOk2CL8H9pC2qx
	Z6FFnn2+yaJvaH+eTfa7HTKX/pp2ADc+cRi4plPesAAcuc5fLD4XBQ+GLDtdWqnAbExvzlLbYzC
	SR0NDuzPUTJbuHI68X+E9qDt36x7SZPTb0OeEJBTSkmVGFcLW7UKudb5P+euNfo+7+VYAjdt9I6
	hwF5x2KzHev5F6RmtPOuBIdKqyBs5OLoxA==
X-Received: by 2002:a17:90b:4ad0:b0:3ae:9944:3bf0 with SMTP id 98e67ed59e1d1-3b41c938c77mr10300495a91.34.1795441936461;
        Mon, 23 Nov 2026 05:52:16 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405ec698dsm20842512a91.14.2026.11.23.05.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 05:52:15 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	chleroy@kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Mukesh Kumar Chaurasiya <mkchauras@gmail.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCHv3 2/4] powerpc/watchdog: Disable preemption in arch_touch_nmi_watchdog()
Date: Mon, 23 Nov 2026 19:21:51 +0530
Message-Id: <8a70fa42449a63a73b8340d3296974cc519b5826.1795441238.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1795441238.git.ritesh.list@gmail.com>
References: <cover.1795441238.git.ritesh.list@gmail.com>
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

touch_nmi_watchdog() can be called from preemptible context, e.g.
sysrq-w via /proc/sysrq-trigger. The powerpc implementation uses
smp_processor_id(), so with DEBUG_PREEMPT we get:

  root@buildroot:/# echo w > /proc/sysrq-trigger
  sysrq: Show Blocked State
  BUG: using smp_processor_id() in preemptible [00000000] code: bash/238
  caller is arch_touch_nmi_watchdog+0x3c/0xd4
  CPU: 0 UID: 0 PID: 238 Comm: bash Not tainted 7.4.0-rc2-00029-g7664547149ae-dirty #126 PREEMPT
  Call Trace:
   dump_stack_lvl+0x138/0x150 (unreliable)
   check_preemption_disabled+0x120/0x158
   arch_touch_nmi_watchdog+0x3c/0xd4
   show_state_filter+0xf0/0x338
   sysrq_handle_showstate_blocked+0x24/0x38
   __handle_sysrq+0x134/0x3a8
   write_sysrq_trigger+0x178/0x22c
   proc_reg_write+0xf4/0x150
   vfs_write+0xfc/0x71c
   ksys_write+0x8c/0x150
   system_call_exception+0x310/0x590
   system_call_vectored_common+0x15c/0x2ec
  ---- interrupt: 3000 at 0x7ffd01755b98

Unlike the generic version, which only sets a flag, we update the CPU's
timebase stamp and its SMP watchdog pending bit, so a migration in
between touches the state of a CPU we are no longer on.

Disable preemption across the update. While at it, let's also mark the
function as notrace (since we might be within a tracer when this
function gets called).

Fixes: 2104180a5369 ("powerpc/64s: implement arch-specific hardlockup watchdog")
Cc: stable@vger.kernel.org
Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/kernel/watchdog.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchdog.c
index 44f178e07531..32d4e716cb0a 100644
--- a/arch/powerpc/kernel/watchdog.c
+++ b/arch/powerpc/kernel/watchdog.c
@@ -456,12 +456,16 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 	return HRTIMER_RESTART;
 }
 
-void arch_touch_nmi_watchdog(void)
+notrace void arch_touch_nmi_watchdog(void)
 {
 	unsigned long ticks = tb_ticks_per_usec * wd_timer_period_ms * 1000;
-	int cpu = smp_processor_id();
+	int cpu;
 	u64 tb;
 
+	/* Callers may be preemptible. Stay on this CPU for the update. */
+	guard(preempt_notrace)();
+	cpu = raw_smp_processor_id();
+
 	if (!cpumask_test_cpu(cpu, &watchdog_cpumask))
 		return;
 
-- 
2.39.5

