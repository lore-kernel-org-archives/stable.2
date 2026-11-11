Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794389087;
	b=BvOypxbqz58MoNtVztir6Q3A8eiOOw1B8xkbGzeMKYOR8NqNQfIuo7BkJvs9RYAwEHm0
	 O1avvumfrzdEpRSgP+46MEPbqzcQLTcR5mgorc/m03M1Ld4PwrOERWvGdpbQeGFjwfjJt
	 fDtxJ9x6yFH2SPN9CUSof+71xHsbMWosFV5QAbjLTYWBLFQyCQd7zyVPnhX6dUvtX7cLU
	 HIj+fiYLq4z32C8oHB/dj5CxC9G5Q9MT788sg+hWygUGxzVMj5/lHpRWTcWEYINySYijS
	 NP573i/LE15+FUjsV9z+Bk8wzgw5STt85irLpqzLc0USXHu2rQ/yxo6YKDRQ3QrZxUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794389087;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=1HiZVoGdgP26KTrqD2XwxNDHWJELschXpQq9mDiL7Kw=;
	b=0GDQSxyuK08BmeWUF2LvtMH15v0VZHc7au3M459CNcDCAobFSv27xyV6jrLm7Ef8qBVe
	 QpJAc1EPqEOuA89e5Ng9uSgB19MmmyYR4/v1UPGAtVMufuWlOyAnpbyStzP2+N5qohHD0
	 sZ8+UEgYEUlD2SBEU0Jc4518gKJSxmcT5UPYQfRKQ0Z4fIf5Uft/kME/bFp5y8qxwdfTH
	 vxahSfPMui7ruzk7K1AkcDKQlRd0iQB53Qvoco5Ykha83fi8zW2SIUb1XdR9XHcNjW8sz
	 aElJntu/f1kj4W8I46vE7QPYyOGtQJUighpmrS3eMvx62jg8K/tGieGP03Cfhd8Bf4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF52606A330;
	Wed, 11 Nov 2026 09:24:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCF52606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.17])
	by gateway (Coremail) with SMTP id _____8AxXdJZNPRq238eAA--.22658S3;
	Wed, 11 Nov 2026 17:24:41 +0800 (CST)
Received: from kernelserver (unknown [223.64.69.17])
	by front1 (Coremail) with SMTP id qMiowJDxxMxRNPRqU7IzAA--.12611S2;
	Wed, 11 Nov 2026 17:24:39 +0800 (CST)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Andrew Morton <akpm@linux-foundation.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>,
	stable@vger.kernel.org,
	Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: [PATCH] lib/smp_processor_id: Don't warn if there is only one CPU
Date: Wed, 11 Nov 2026 17:24:21 +0800
Message-ID: <20261111092421.3771992-1-chenhuacai@loongson.cn>
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
X-CM-TRANSID:qMiowJDxxMxRNPRqU7IzAA--.12611S2
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7uryDZr4fCr43CrW3JF47trc_yoW8KFyDpa
	40k3y8Kr48Cr1jva17Ja4kGry5Xas8ua93Cw17Aw45Zr15Aw1DJry5tF12gFyrCF4UGayU
	GF1vqr1Fvr1rXwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUP529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUtVW8ZwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r1q6r43MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0L0ePUUUUU==

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
warning if (nr_cpu_ids == 1) in check_preemption_disabled().

Cc: stable@vger.kernel.org
Reported-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 lib/smp_processor_id.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/smp_processor_id.c b/lib/smp_processor_id.c
index 94b3f6b19538..64901d33c0ee 100644
--- a/lib/smp_processor_id.c
+++ b/lib/smp_processor_id.c
@@ -19,6 +19,9 @@ unsigned int check_preemption_disabled(const char *what1, const char *what2)
 	if (irqs_disabled())
 		goto out;
 
+	if (nr_cpu_ids == 1)
+		goto out;
+
 	if (is_percpu_thread())
 		goto out;
 
-- 
2.52.0

