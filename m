Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795196478;
	b=dw10l4mjz+/SBIjJX8XRahKjxf6gM3oAp/Jdf7KTTmTGWA4bMCTutj810HAPVzv2HRsM
	 jEQYwaLicD18JtJHDkw1qF6aT1HrVQzOstE7HnKSw2SLwnZH+A35jNtJ7tb4OrSyUSQLp
	 hc/KInYSF7fb0Iuazq6ZIKcuXstU81LQLPaCLS3TTULO/j0x6pwCoQeV/mmma+ofwkAkr
	 4FSkjxbE6friCxV3WdpSPUOtc0b7jOHowvNkxC9Kzh3bKDY7M584jk8t0uFfXI2U9S+SR
	 6IrtlxyP02PL7BPVIhS51qxYZFovcebTBfzL5ri4ymKhhsUBUKdCsPFRhSk4ZwbWvXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795196478;
	h=Received:DKIM-Signature:Received:Message-ID:User-Agent:Date:From:To:
	 Cc:Subject:References:MIME-Version:Content-Type;
	bh=/JrhOF2XVSdyKgSUnfNnSVf78q5yfZwAkgCYz96RCpU=;
	b=U5JGLAcUTTrXOl+xJSwj1DFYTn7bu+wDptorMYVTOy5o1S+6YBIFHODla1cS5NR3T18A
	 JDiiWFvk91LY7PL64oWQKa4CZQ9rNVO5LGOWbBtfUL1+AFu0aRoC8n2UdPKBKoIvfR8x/
	 7mYOJ3hgIOaiW9Wh4r3ZbvWM4ck8erY4mCT46FqK/qY3TNS6NybPXDsHK2TXi/WMrneW3
	 NhSb65zLpc4DwJepl72Vlqn1O5h95+P6IeF6Ob0RkgdG2g4daT/1VUq2oA1/AW7NdQdAh
	 jLRQkTWS5bLaLjjbHbqer5XIV9VULOnyU/auGfqBH2I2ZOtZkJ14alrfkIKTe0o0tPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XU8om3HR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9B160A5BCC;
	Fri, 20 Nov 2026 17:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XU8om3HR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0DDB1F000D0;
	Fri, 20 Nov 2026 17:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795196477;
	bh=/JrhOF2XVSdyKgSUnfNnSVf78q5yfZwAkgCYz96RCpU=;
	h=Date:From:To:Cc:Subject:References;
	b=XU8om3HRbaRgP/+Tn/jDEM2RJZtGm1NQm5gBiIQiSvkRvTz2d34+bbLovdtCwMNch
	 DxG6haAO13EFSV4H4pfurc84AQquPnxnNh7F/2QlkKwbIeLG6hRUluq23WNfXb2Brl
	 GXlHf1cZNqIIR74P8lmYzYztuK+/Wp4Z+HtwyNr6e4YxC24J3idaJlksn+0s9uZvEB
	 oLfZh9fa0mMOYQcDBVNGMHFCNPijU67sqT1GbaYUmLeEtp7Xe4ZK5JoOQO9JNOOcxa
	 qnqdnP7PfKmKK+a5Wn7KbC4LcnG9ImJ1DlhX/GyjyiCGcWXkBPq6zALLi9FXctYEwa
	 olrP0m5ARDr2A==
Received: from rostedt by gandalf with local (Exim 4.100.1)
	(envelope-from <rostedt@kernel.org>)
	id 1xUSbt-00000004aN8-0wBF;
	Fri, 20 Nov 2026 12:41:17 -0500
Message-ID: <20261120174117.054583223@kernel.org>
User-Agent: quilt/0.69
Date: Fri, 20 Nov 2026 12:39:08 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Chaosheng Qu <chaosheng.qu.linux@gmail.com>
Subject: [for-linus][PATCH 16/32] tracing/osnoise: Dont start a kthread in timerlat user-space mode
References: <20261120173852.687189370@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Chaosheng Qu <chaosheng.qu.linux@gmail.com>

In timerlat user-space mode (NO_OSNOISE_WORKLOAD) the workload is a user
task reading timerlat_fd, so there is no per-CPU kernel thread to run.
start_kthread() only checks for that in the osnoise branch:

	if (timerlat_enabled()) {
		snprintf(comm, 24, "timerlat/%d", cpu);
		main = timerlat_main;
	} else {
		/* if no workload, just return */
		if (!test_bit(OSN_WORKLOAD, &osnoise_options)) {
			...
			return 0;
		}
		...
	}

start_per_cpu_kthreads() guards against this mode itself, but
osnoise_hotplug_workfn() calls start_kthread() directly. Bringing a CPU
online in user-space mode therefore starts a timerlat/N thread and sets
its bit in kthread_cpumask while OSN_WORKLOAD is clear.

stop_kthread() uses that bit to decide what the recorded task is:

	if (cpumask_test_and_clear_cpu(cpu, &kthread_cpumask) &&
	    !WARN_ON(!test_bit(OSN_WORKLOAD, &osnoise_options))) {
		kthread_stop(kthread);
	} else if (!WARN_ON(test_bit(OSN_WORKLOAD, &osnoise_options))) {
		kill_pid(kthread->thread_pid, SIGKILL, 1);
		put_task_struct(kthread);
	}

The bit is set but OSN_WORKLOAD is not, so the first WARN_ON() fires and
the && short-circuits into the user-task branch. A running kernel thread
is SIGKILLed and its task_struct is put without ever being stopped, so it
keeps executing until it is freed underneath itself.

Any write to osnoise/options reaches this: osnoise_options_write() stops
the per-CPU threads before applying the new value, so stop_kthread()
still sees OSN_WORKLOAD clear. Re-writing the value that is already set
triggers it just as well as changing it.

  echo NO_OSNOISE_WORKLOAD > osnoise/options
  echo timerlat > current_tracer
  echo 0 > /sys/devices/system/cpu/cpu1/online
  echo 1 > /sys/devices/system/cpu/cpu1/online
  echo NO_OSNOISE_WORKLOAD > osnoise/options

The offline/online pair is required, otherwise no kthread is recorded and
no bit is set. Running this on 7.3-rc7 with KASAN gives a WARNING in
stop_kthread() followed by a slab-use-after-free in update_se(); leaving
out the hotplug step produces neither.

Keep the check in start_kthread(), where the related hotplug bug was
fixed in 0bb0a5c12ecf, instead of adding another copy to the callback.

Cc: stable@vger.kernel.org
Fixes: e88ed227f639 ("tracing/timerlat: Add user-space interface")
Link: https://patch.msgid.link/20261014081034.12702-1-chaosheng.qu.linux@gmail.com
Signed-off-by: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace_osnoise.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 995da9e0b548..fbba42286747 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -2039,6 +2039,14 @@ static int start_kthread(unsigned int cpu)
 		return 0;
 
 	if (timerlat_enabled()) {
+		/*
+		 * In timerlat user-space mode the workload is the user task
+		 * reading timerlat_fd, so there is no kernel thread to start.
+		 * One started here would set its kthread_cpumask bit, which
+		 * stop_kthread() reads as "osnoise workload kthread".
+		 */
+		if (!test_bit(OSN_WORKLOAD, &osnoise_options))
+			return 0;
 		snprintf(comm, 24, "timerlat/%d", cpu);
 		main = timerlat_main;
 	} else {
-- 
2.53.0
