Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B8953C3C2;
	Tue, 13 Oct 2026 19:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791920102; cv=none; b=jl6V6MuNNj/5xNJ/WfMJ9PVHSMCLJu7+GaUgo3uk9CnlaTHkxwoKNzCByxSXZsZvo5UQIxaTwmmYG95gBUQotvp5p7Ho47NmxMBUA+3UmWfYb9j9B5oTIJvCBRQR8Y1hYEpNZnonJ/EKXKL2FD8m6VcW/Te3+8al1l7jZhMDmeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791920102; c=relaxed/simple;
	bh=EKE+BrURLABnFg60A84Ac3H9FK1qvZV8iXW0jusei8M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=cSeSUT894B73ITdcqIBnk1N/A1yLlY/L2gxhbrXCzomkWunUz/pNUXyhGmuh3IWRJACQU/6hIH3i3+qoI/cV3Bl5GcURYvhBDB08BIDryF5QD6m87ZppI5dnLgyqiJSzTSZcchM493HzAipg9mNf/nIlaXIzN52SxQPSnLXS4pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T/HY68Sc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T/HY68Sc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59A701F000FF;
	Tue, 13 Oct 2026 19:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791920101;
	bh=6e7sCTs9s2Q0EweL+aD9Wlvk19OnMX+Ssr0sngoSMhI=;
	h=From:Date:Subject:To:Cc;
	b=T/HY68Sc3QjRCNkCifO5o9mK2HsfUUeyjqxEFjjGOPL45cILAPxsmu+/5apeQDJ42
	 9VKSkKYJVksoR7WCpG2IbG92C45ERFGoL5MJSJvyj64QiYTWDWPIof9ApirDYt+nhY
	 iN0kHFgqDXqtF/Xjg+hurJq1Ei35YbBkdOWsi56Sz1GtDNmOfJ2aUUMs3A+KkshaPw
	 Zay5U2NKLJH/dLkYJ9w0iGUkh6u7/Y9cqsEbVjrdfq2Z9Om9gaYkfzgO5Omdp2nKn7
	 0GjZ9KIclZsmEKWaQSs5ui+sQ4ikal6AGdwte2I0u+Te2Nymx8Dvb6+OZxAFsI2Uyo
	 QkjSxBIjdFjVg==
From: "Harry Yoo (Meta)" <harry@kernel.org>
Date: Tue, 13 Oct 2026 20:34:39 +0100
Subject: [PATCH] mm/percpu: account full object size for percpu memory
 allocations
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-fix-alloc-percpu-accounting-v1-1-03e788a1e41f@kernel.org>
X-B4-Tracking: v=1; b=H4sIAM6HzmoC/yXMQQqDMBBA0avIrDtgUinqVaSLOJ3oiCQhMSKId
 29slw8+/4TEUThBX50QeZck3hWoRwU0GzcxyqcYdK1fqlZPtHKgWVdPGDhSyGiIfHabuAmbdrS
 66VRHxkI5hMgl/92H998pjwvTdi/hur6pRrqsfwAAAA==
X-Change-ID: 20261013-fix-alloc-percpu-accounting-48bf24919caf
To: Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
 Christoph Lameter <cl@gentwo.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Suren Baghdasaryan <surenb@google.com>, Hao Ge <hao.ge@linux.dev>
Cc: kernel-team@meta.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, "Harry Yoo (Meta)" <harry@kernel.org>
X-Mailer: b4 0.16.0

When memory allocation profiling is enabled, the pages backing percpu
memory chunks are attributed to func:pcpu_alloc_pages. However, the
accounting of individual percpu memory allocations via alloc_percpu()
and friends record only the size of a single object rather than its
full size across all CPUs.

As a result, it is often not straightforward to identify which kernel
code is actually responsible for percpu memory, because the size is
under-accounted by a factor of num_possible_cpus().

Account full object size with pcpu_obj_full_size(size) instead, which
multiplies the object size by num_possible_cpus() and adds the objcg
pointer overhead. This is consistent with what memcg already does for
charging percpu allocations.

Verified with 64-CPU VM by spawning 400 processes in a memory cgroup and
measuring mm_init()'s rss_stat counters.

Delta of kernel/fork.c:1142 func:mm_init in /proc/allocinfo:

                  bytes   calls   per allocation
    unpatched      6320     395         16
    patched      418176     396       1056

'percpu' field in memory.stat: 422400 (1056 bytes per process)

Memory allocation profiling now accounts the same amount of memory as
what memcg charges.

Cc: stable@vger.kernel.org
Fixes: 60fa4a9e2323 ("mm: percpu: add codetag reference into pcpuobj_ext")
Assisted-by: LLM # Verification
Signed-off-by: Harry Yoo (Meta) <harry@kernel.org>
---
 mm/percpu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/percpu.c b/mm/percpu.c
index 3eff382e565a..d7883507dc15 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -1696,14 +1696,15 @@ static void pcpu_alloc_tag_alloc_hook(struct pcpu_chunk *chunk, int off,
 {
 	if (mem_alloc_profiling_enabled() && likely(chunk->obj_exts)) {
 		alloc_tag_add(&chunk->obj_exts[off >> PCPU_MIN_ALLOC_SHIFT].tag,
-			      current->alloc_tag, size);
+			      current->alloc_tag, pcpu_obj_full_size(size));
 	}
 }
 
 static void pcpu_alloc_tag_free_hook(struct pcpu_chunk *chunk, int off, size_t size)
 {
 	if (mem_alloc_profiling_enabled() && likely(chunk->obj_exts))
-		alloc_tag_sub(&chunk->obj_exts[off >> PCPU_MIN_ALLOC_SHIFT].tag, size);
+		alloc_tag_sub(&chunk->obj_exts[off >> PCPU_MIN_ALLOC_SHIFT].tag,
+			      pcpu_obj_full_size(size));
 }
 #else
 static void pcpu_alloc_tag_alloc_hook(struct pcpu_chunk *chunk, int off,

---
base-commit: 0e199ae6e803e76ebf128e009d336e5917221e63
change-id: 20261013-fix-alloc-percpu-accounting-48bf24919caf

Best regards,
--  
Cheers,
Harry / Hyeonggon

