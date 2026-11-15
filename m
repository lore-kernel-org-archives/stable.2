Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794736550;
	b=32rIUzPBErx0dGXoqnORNdOfv2X2Q7F+1KklTebSz3auOTPp1c+/JjKKUIK81M+/lNLE
	 f0x0neeV4THQ5UAVDzQzCXM0dXXA+tIf9fhhUoVh4ixN6Uv1W6Zh7+9LqEgzU/61wPwi/
	 ouOhOoclMYBah7tauEexyFRP6JJTKa7XVUkmVTtD2l8JqeS7cbL/1nXl/icHWJGMzWUsS
	 yuuxtdku6mp7xXxp3T5fhVkySSRerlniZ6638fAhuJAcPVeEI6fTmevqOjmvSUF7w6wm4
	 kh9EisFrEPdNDmCrIefcUPGtAAadkAfKflHr+2pIW6e6+niUTT/Oa6FcbzAEXhDlPuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794736550;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=VfNEYKtq+P1y119j5w9ZasnBrt/MoIaAlnAPJm3j+is=;
	b=y2Py25/elZi41F2pW8Xc1hKdevdVuCirb4bRfWJTt3aLK/6APOOJYyd3gHILwAR4LpSg
	 LJCf6cGrvmeDQgJVzS+tWivzgDFEXi5mDhVEv/XVa/yNzI2zMvJb+5IHFjd0AGGXOwq8P
	 7wQcZ7YvClQEmDWaVglgeZAre0joq7MLLDpvA6yKxbpEjxnrE9IlY+h0sNlSyuj2QQ1m/
	 SK2eflI9glyprmu/GZTgWOBZDF6xvFPO3nelD2hbcsIcaVPIXUa+LpDdvxH7jfQ1uPC8H
	 tRsLbQWCNIqxgvmLrJsl7UUkLj36VRzpLAU2Krt+Ymx2KZ2ibvvLP1mVGR1Qz22h6zQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DAA606A31D;
	Sun, 15 Nov 2026 09:55:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35DAA606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.17])
	by gateway (Coremail) with SMTP id _____8CxPtObgflqM9kfAA--.26322S3;
	Sun, 15 Nov 2026 17:55:39 +0800 (CST)
Received: from kernelserver (unknown [223.64.69.17])
	by front1 (Coremail) with SMTP id qMiowJAxFs2WgflqibM0AA--.48914S2;
	Sun, 15 Nov 2026 17:55:38 +0800 (CST)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>,
	stable@vger.kernel.org,
	Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: [PATCH V2] lib/smp_processor_id: Don't warn if there is only one CPU
Date: Sun, 15 Nov 2026 17:55:03 +0800
Message-ID: <20261115095503.2922598-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.52.0
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
X-CM-TRANSID:qMiowJAxFs2WgflqibM0AA--.48914S2
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxAFW8WF47tw13KryfXFy3WrX_yoW5Xr4Dpa
	40k3y8Kr4rAr1jvw47AaykGFyFq3Z8ua97Gw17A3y5ZF45Aw1Dtry5tF12qFy5CF4UCa18
	JFn2qr1Fvr1rXwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUk529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUtVW8ZwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWr
	XwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r1q6r43MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0L0ePUUUUU==

When CONFIG_DEBUG_PREEMPT is enabled on a Non-SMP (single-core) kernel,
calls to smp_processor_id() in preemptible contexts trigger some false
positive "BUG: using smp_processor_id() in preemptible" warnings, which
are harmless noise because the process always executes on CPU 0 and CPU
migration is impossible.

Here are some of the trimmed log messages:

  Call Trace:
  [<9000000000d33e28>] show_stack+0xf8/0x1c0
  [<9000000000d2fdac>] dump_stack_lvl+0x4c/0x78
  [<9000000002456fc0>] check_preemption_disabled.isra.0+0x100/0x110
  [<9000000002456ff8>] debug_smp_processor_id+0x18/0x40
  [<9000000000d31118>] init_cache_level+0x18/0x90
  [<9000000001adbe2c>] detect_cache_attributes+0x4c/0x640
  [<9000000001adc44c>] cacheinfo_cpu_online+0x1c/0x310
  [<9000000000d5ae04>] cpuhp_issue_call.constprop.0+0x94/0xd0
  [<9000000000d5b278>] __cpuhp_setup_state_cpuslocked+0x208/0x320
  [<9000000000d30148>] do_one_initcall+0x68/0x200
  [<90000000024711b8>] kernel_init_freeable+0x1fc/0x294
  [<900000000245824c>] kernel_init+0x20/0x134
  [<9000000002455b54>] ret_from_kernel_thread+0x24/0x1d0
  [<9000000000d31650>] ret_from_kernel_thread_asm+0xc/0x9c

This warning only exists for the !CONFIG_SMP build. This is because for
CONFIG_SMP cpuhp_issue_call() invokes callbacks in cpuhp_thread_fun()
which is a percpu thread, but for !CONFIG_SMP build it invoke callbacks
in the init process which is not a percpu thread. And there is such a
skip condition in check_preemption_disabled():

    if (is_percpu_thread())
            goto out;

Since there is only one CPU for the !CONFIG_SMP, we can simply skip the
warning if (!IS_ENABLED(CONFIG_SMP)) in check_preemption_disabled(). The
effect is partially reverting 570a752b7a9bd03b50 ("lib/smp_processor_id:
Use is_percpu_thread() instead of nr_cpus_allowed"), because now in the
UP case nr_cpus_allowed is 1 but PF_NO_SETAFFINITY is unset.

Cc: stable@vger.kernel.org
Reported-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
V2: Keep the behaviors for CONFIG_SMP.

 lib/smp_processor_id.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/smp_processor_id.c b/lib/smp_processor_id.c
index 94b3f6b19538..be079b908504 100644
--- a/lib/smp_processor_id.c
+++ b/lib/smp_processor_id.c
@@ -22,6 +22,9 @@ unsigned int check_preemption_disabled(const char *what1, const char *what2)
 	if (is_percpu_thread())
 		goto out;
 
+	if (!IS_ENABLED(CONFIG_SMP))
+		goto out;
+
 	if (current->migration_disabled)
 		goto out;
 
-- 
2.52.0

