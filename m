Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F47486621;
	Thu,  6 Aug 2026 17:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786039046; cv=none; b=O6hxPyl0c7YgiCdqymZTSyQOvQwCbozP0Ql3ZcrBBFCQCgOHHIkxhJ7WahI7lLxcqbihAsg+I4wMJHlMhrbP6bxFDUClfh2JQJ9iVM0u8DGs0Ipmp1hIOgl3nmdv8sEV3+Ljb6c9piJdbJyhwme8jZnm/SVuQd6+YHB0V2cGw54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786039046; c=relaxed/simple;
	bh=i/N2n80KoZW3z2QdDp5u3E2LZ7a7PdPzw483AxRpdQE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jJjZ66Zzog59E/m3RWF4Sc/qQQxKzQQq45ciUalWu/NsJP632JBDY/iUd89A3wpB6JDn4KNP2WhiM4GHTXkXbNLCPqE+lsMyr2Gv3wEt1m9mp38rhAVQvp9xpMi0unQ/O0MMWA8FMWX/7d0wDiAMFfLKGcbzGrRoM/gQI9+Vepw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=L0J/sVRO; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="L0J/sVRO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Jg
	UVsHPW9KholmWZs3P6a2lna6z1ylFYUaa5qaEFXaU=; b=L0J/sVROu4wGG4QEUY
	v5mw5xaMbSin7T4iJ4E49j03acf7sxayxdG6hu9zxeZ+LRJ6rAXwsjLeeSilYZcF
	Ahkot6Mfl33hSD9VJN/tPqOlre3eDz4LlWCqdWN0rSXJrh9pJRiR1Y1WnQMmk4JH
	iBMmjLb8xW1rDNmdYwc8eHa/Y=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wBXn+3HynRqNwMqNw--.35274S2;
	Fri, 07 Aug 2026 01:56:24 +0800 (CST)
From: Hui Su <sh_def@163.com>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Su <sh_def@163.com>
Subject: [PATCH] bpf: Fix infinite loop in pcpu_freelist push with one possible CPU
Date: Fri,  7 Aug 2026 01:56:00 +0800
Message-ID: <20260806175600.1993595-1-sh_def@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBXn+3HynRqNwMqNw--.35274S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxurWkur47CF4rCFW3ZFWDArb_yoWrAryrpr
	Z5G3y5tw1kKrs3Cws3Jr4UW3y3JrW8Jw17G3y5Cw1rAr15J39FqF13AFsavFy3GrsrZr1Y
	vF4q9FZxCFW7ZrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piHa0PUUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbC6Qic+2p0ysiorgAA3c

__pcpu_freelist_push() can loop forever when only one CPU is possible
and an NMI re-enters pcpu_freelist_push() while the interrupted context
holds that CPU's freelist lock.

After the current-CPU fast path fails, the fallback loop walks
cpu_possible_mask while skipping the current CPU. With CONFIG_SMP=n, or
when an SMP kernel is limited to one possible CPU with nr_cpus=1 or
possible_cpus=1, there are no other possible CPUs to examine. The loop
therefore makes no lock acquisition attempt and can never make progress.

The following stack was observed on a UP system:

  NMI context:
    pcpu_freelist_push
    free_htab_elem
    htab_map_delete_elem
    [perf-event BPF program]
    __perf_event_overflow
    perf_event_nmi_handler
    exc_nmi

  Interrupted context:
    __pcpu_freelist_push
    pcpu_freelist_push
    free_htab_elem
    htab_map_delete_elem
    [raw_tp/sys_enter BPF program]
    __bpf_trace_sys_enter
    do_syscall_64

raw_res_spin_lock() detects the same-CPU recursive acquisition and
returns -EDEADLK, but the subsequent fallback loop has no candidate head
on a system with one possible CPU.

Restore the extra fallback head that existed before the rqspinlock
conversion. Keep the current-CPU fast path, then try the other possible
CPUs and finally the extra head. The additional head lets a push, which
cannot fail without losing a preallocated element, make progress when the
only per-CPU head is held by the interrupted context.

Also check the extra head from the pop path so that nodes placed there
can be reused.

Fixes: f2ac0e5d1c4d ("bpf: Convert percpu_freelist.c to rqspinlock")
Cc: stable@vger.kernel.org
Signed-off-by: Hui Su <sh_def@163.com>
---
 kernel/bpf/percpu_freelist.c | 35 +++++++++++++++++++++++++++--------
 kernel/bpf/percpu_freelist.h |  1 +
 2 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/percpu_freelist.c b/kernel/bpf/percpu_freelist.c
index 632762b57299..06ce588d13a3 100644
--- a/kernel/bpf/percpu_freelist.c
+++ b/kernel/bpf/percpu_freelist.c
@@ -17,6 +17,8 @@ int pcpu_freelist_init(struct pcpu_freelist *s)
 		raw_res_spin_lock_init(&head->lock);
 		head->first = NULL;
 	}
+	raw_res_spin_lock_init(&s->extralist.lock);
+	s->extralist.first = NULL;
 	return 0;
 }
 
@@ -46,22 +48,28 @@ void __pcpu_freelist_push(struct pcpu_freelist *s,
 			struct pcpu_freelist_node *node)
 {
 	struct pcpu_freelist_head *head;
-	int cpu;
+	int cpu, this_cpu;
 
 	if (___pcpu_freelist_push(this_cpu_ptr(s->freelist), node))
 		return;
 
+	this_cpu = raw_smp_processor_id();
 	while (true) {
-		for_each_cpu_wrap(cpu, cpu_possible_mask, raw_smp_processor_id()) {
-			if (cpu == raw_smp_processor_id())
+		for_each_cpu_wrap(cpu, cpu_possible_mask, this_cpu) {
+			if (cpu == this_cpu)
 				continue;
+
 			head = per_cpu_ptr(s->freelist, cpu);
-			if (raw_res_spin_lock(&head->lock))
-				continue;
-			pcpu_freelist_push_node(head, node);
-			raw_res_spin_unlock(&head->lock);
-			return;
+			if (___pcpu_freelist_push(head, node))
+				return;
 		}
+
+		/*
+		 * Push cannot fail. Use the extra list when none of the
+		 * per-CPU freelists can accept the node.
+		 */
+		if (___pcpu_freelist_push(&s->extralist, node))
+			return;
 	}
 }
 
@@ -117,6 +125,17 @@ static struct pcpu_freelist_node *___pcpu_freelist_pop(struct pcpu_freelist *s)
 		}
 		raw_res_spin_unlock(&head->lock);
 	}
+
+	/* Per-CPU lists are empty or unavailable, try the extra list. */
+	head = &s->extralist;
+	if (!READ_ONCE(head->first))
+		return NULL;
+	if (raw_res_spin_lock(&head->lock))
+		return NULL;
+	node = head->first;
+	if (node)
+		WRITE_ONCE(head->first, node->next);
+	raw_res_spin_unlock(&head->lock);
 	return node;
 }
 
diff --git a/kernel/bpf/percpu_freelist.h b/kernel/bpf/percpu_freelist.h
index 914798b74967..980cf2884fd2 100644
--- a/kernel/bpf/percpu_freelist.h
+++ b/kernel/bpf/percpu_freelist.h
@@ -14,6 +14,7 @@ struct pcpu_freelist_head {
 
 struct pcpu_freelist {
 	struct pcpu_freelist_head __percpu *freelist;
+	struct pcpu_freelist_head extralist;
 };
 
 struct pcpu_freelist_node {
-- 
2.43.0

