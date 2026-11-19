Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795075520;
	b=AZBlk5Kh5uRa1W0bRJ7U2BFkkk7oBMbSJpUmKh3lH/7/u/46tSJsjVzldAdvewMzp/rl
	 SCJ/xhESNcN/DO+L/XwzKJ4t6wAibm4TqETWgRfyFcvri0AZeDFEt+U8sQnmHPO8ff3RX
	 BqlLUdjw4PzkxvhrMKH5k8pOlEdiKUei8Oo2NLoC4xm70cp+vf94/WvizAVrYjsHBs3/q
	 rS5ePoppqY6V9jQDzXXqMRJgwf++7rIJJR97SCtGffipPBgY1QgcEWIbi213qocAYxgiG
	 yU3ZucgFy6oUbbTyM4OKOe6ASeQnHQsoN4eRvhAq1ilBz01mrZHn2g9p//l6pNXN6rA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795075520;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Rek7UTjER/suQr6FAWR61hR3HRsZdSl74XAnmKcX4S4=;
	b=2orT/Fs5HK83hSMVfbQBrIWyEOzkO+G7jGbRngOp101EeH8ayazzQ6YxjLDtz3zc2Wkk
	 JU1I2w8R/uPea8dq717og+PrCQ/y8F38m4J2FihsIGtMQud6ZAC9CAh0LEwpcv+8SDOZl
	 +eCDc8oHAAE8kTx6DfHWP67XODXGzRQtWQOb8ilZdbNaa+Q20Xg0lJl4cL8MPpkdJfizj
	 v3WpiNaGjYILcnRy0TWQQJpQ6X0O8e/CO5bjo9QcUdgHWmW3sNQ++CRjy2eD9wL3koBBe
	 81bAP0c6DgYK/iLzB9CcnjdGMsXxOP6ypIzfpicTIpuBxkvNEwYz16uVUdsxXhQxsKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XL7pJJBk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6920606A320;
	Thu, 19 Nov 2026 08:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XL7pJJBk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E692D1F000C5;
	Thu, 19 Nov 2026 08:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795075519;
	bh=Rek7UTjER/suQr6FAWR61hR3HRsZdSl74XAnmKcX4S4=;
	h=From:Date:Subject:To:Cc;
	b=XL7pJJBkRxw6vp1B7sLrs8+PPOzVSCLx5x5NMKdUFo/AcFOI7uXVV+TrWJlvyfojJ
	 eLX4Gk/7YDVl7fnoL1rBjvYgCR52PHFzOrCKTsdKKzBLFGYeqPuPEYSkmsaetdqtc0
	 RDWYobT9fry0eRYhf3cD2XWn/0oOkC6DvCV0whfZoFib4LSsuIZi8X4DSPhtNwu9en
	 W1GZO9LORnbX6guOLiiYIiRKJfmZ1vQpVQJ89Zp+1P5yk8DhMlpilkiGWT0n0TCKIT
	 Y/I/6yG/WDYxsBkzxwnz6iBfl691IUzuJxof4moKBGDxUR2ZYefNFpNTzPPuTVg+7P
	 Muv7pLqr2lkzw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 19 Nov 2026 09:04:58 +0100
Subject: [PATCH] fork: clear p->mm when copy_process() fails
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-mm_failed_fork-v1-1-b3019f43d197@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/yXMTQ6CMBAG0KtMvjVNOogk9CrGkEKnMCo/adWYE
 O5ulOXbvA1ZkkqGow1J3pp1meGIC0I/+nkQowGOUNqyZubGTFMbvT4ktHFJd+OrmivuzvYULAr
 CmiTq5x9erofzq7tJ//wt2PcvbCpTG3IAAAA=
X-Change-ID: 20261119-mm_failed_fork-a46141b503d0
To: Andrew Morton <akpm@linux-foundation.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 K Prateek Nayak <kprateek.nayak@amd.com>, Kees Cook <kees@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Alexei Starovoitov <ast@kernel.org>, Song Liu <songliubraving@fb.com>, 
 Yonghong Song <yhs@fb.com>, Ingo Molnar <mingo@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Chris Mason <mason@kernel.org>, Sashiko <sashiko-bot@kernel.org>, 
 stable@vger.kernel.org, "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3334; i=david@kernel.org;
 h=from:subject:message-id; bh=2L4FtiSPbYQrvmgemAopv11ASeAoc306idpK+0NzQBY=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLL+rd1wUXrSo1PlktoPA5/KadyZrhO2PlioJGszl+/1Q
 3PXnNe91VHKwiDGwSArpsgSFHzf4OXLdbXVbnzMMHNYmUCGMHBxCsBEGPYwMmye56611oV53a4J
 DPP3SkfVHDp+KV7q5h7XE5EZpRUdnm2MDP0Lty0yP9Saeqf0TbUET2eQdaTHZaVN3i6XD2mqu6U
 m8AEA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

From: Chris Mason <mason@kernel.org>

When copy_process() fails after copy_mm(), the error path drops the mm
reference but leaves p->mm set. Perf and BPF can still reach the
task, and take a reference on the already freed mm through get_task_mm()
or bpf_find_vma(), resulting in a use-after-free:

    copy_process()               PERF_EVENT_IOC_SET_FILTER
    ==============               =========================
    perf_event_init_task(p)
    copy_mm(p)
    a later step fails
    mmput(p->mm)
      /* frees the mm */
                                 perf_event_addr_filters_apply()
                                   get_task_mm(p)
                                     /* use-after-free */

Similarly, a BPF program on the task_free LSM hook can call bpf_find_vma(p)
before the task is freed.

Fix it by clearing p->mm under task_lock() before dropping the reference,
just like exit_mm() does.

Further, if copy_process() fails before copy_mm(), p->mm is still the
parent's mm pointer copied by dup_task_struct(), without having taken a
reference. While nobody can access it concurrently, there is the
chance that it might get accessed later when a BPF program is attached
to free_task().

With CONFIG_MEMCG the task is freed after an RCU grace period, so the
parent might already be gone and p->mm in the child points at something
that was already freed. So let's just clear p->mm before freeing the
task. No lock is required as there cannot be concurrent access (and we
might not even have the lock initialized yet).

This has medium urgency.

Fixes: 375637bc5249 ("perf/core: Introduce address range filtering")
Fixes: 7c7e3d31e785 ("bpf: Introduce helper bpf_find_vma")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/sashiko-outbox-180866@kernel.org/
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
[ david: simplify description and comments ]
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
I can take this through my tree (rather soonish) unless someone else
wants to pick this up.
---
 kernel/fork.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 5efceb8d58a78..77d6c8fc38c66 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2628,8 +2628,14 @@ __latent_entropy struct task_struct *copy_process(
 bad_fork_cleanup_mm:
 	sched_cache_fork_cleanup(p);
 	if (p->mm) {
-		mm_clear_owner(p->mm, p);
-		mmput(p->mm);
+		struct mm_struct *mm = p->mm;
+
+		/* Perf events and BPF programs can still reach p. */
+		task_lock(p);
+		p->mm = NULL;
+		task_unlock(p);
+		mm_clear_owner(mm, p);
+		mmput(mm);
 	}
 bad_fork_cleanup_signal:
 	if (!(clone_flags & CLONE_THREAD))
@@ -2663,6 +2669,11 @@ __latent_entropy struct task_struct *copy_process(
 	exit_cred_namespaces(p);
 	exit_creds(p);
 bad_fork_free:
+	/*
+	 * If set, p->mm points at the parent's mm without a reference. Nobody
+	 * can access it concurrently anymore, but prevent later access.
+	 */
+	p->mm = NULL;
 	WRITE_ONCE(p->__state, TASK_DEAD);
 	exit_task_stack_account(p);
 	put_task_stack(p);

---
base-commit: 4405c18c95d2d0f99f6c581ef0ee8591a1aa6ccd
change-id: 20261119-mm_failed_fork-a46141b503d0

Best regards,
--  
David Hildenbrand (Arm) <david@kernel.org>

