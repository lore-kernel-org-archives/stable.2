Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF70637F32C
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 11:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790682202; cv=none; b=qamzUY3bZmmCQvp4iQAHaYuJFIwY5ZGlgjVvLv8ZwVo0R5IyWfFb0uO7aJTaRJOmfIeyKnbfJ+Tk7eycXO2+E6b6Q76CTOUTHUDez386GPc08U+Dr51SvwK8oFL8obsPxsgJWI2GALbheUB5bK2SP/9M10L0oidHJys7jT73jwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790682202; c=relaxed/simple;
	bh=8jCyDeuIxJ8wf0vJYv9Kkiq9ih+EBnntGkeavxfC6pg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=q6UdAcsADMjSCdycndZuGU1GCV5/f+aMaLxJ5tn1H2l8lw0HEgnMQ4H2PTjY9TEAxDi7hIy0snfTV1ETBb825kcG4BXcn2MzVryMk73mir9NPXvIKF8ECI/XzUTIWZaawPdzKtaitfjacto6u/klyKrqBJGAcPcImHjQ2Bxj44c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wCYZ+rQ5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wCYZ+rQ5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7B7D1F000FF;
	Tue, 29 Sep 2026 11:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790682200;
	bh=nZgHhhQ5GbGblwvyRM7s6yAIQhN0WUqMtoLcLoJtgpE=;
	h=Subject:To:Cc:From:Date;
	b=wCYZ+rQ5J8fLrkB9fMR8QI41jWtFHP+lNcyA/DvQT5sYBgThplrtMcCN6srKIFVcD
	 pDUdY/U4b/b1+Qpg6SS1zWSdgpbpi8Z0fb+kBkIcvXBM/iVurE+q6iExPXlgYoCElL
	 Ysi90gyiyWU1ny1l1XHp0+LlHfps2oG3fF9LMwLQ=
Subject: FAILED: patch "[PATCH] sched_ext: Add a size argument to scx_bpf_cid_topo() so" failed to apply to 7.2-stable tree
To: tj@kernel.org,arighi@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 13:43:14 +0200
Message-ID: <2026092914-daughter-crudeness-399c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.2-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.2.y
git checkout FETCH_HEAD
git cherry-pick -x 94480606a677deb68d5622cf0ded88626514b3f2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092914-daughter-crudeness-399c@gregkh' --subject-prefix 'PATCH 7.2.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 94480606a677deb68d5622cf0ded88626514b3f2 Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Sat, 26 Sep 2026 09:23:02 -1000
Subject: [PATCH] sched_ext: Add a size argument to scx_bpf_cid_topo() so
 struct scx_cid_topo can grow

scx_bpf_cid_topo() copies struct scx_cid_topo into a buffer the BPF program
sized from its own vmlinux.h while the verifier sizes the write from the
running kernel's BTF. The struct may grow and each growth then breaks every
scheduler built against the older layout, rejected at load or written past
its buffer. This is the usual hole for a struct handed to BPF, closed
elsewhere with a size argument, and it was missed here.

Take the buffer size, copy the smaller of it and the kernel's struct and set
the rest to -1. Accesses to the copy are CO-RE relocated, so the struct can
grow by appending fields, which its comment now states. The kfunc changes in
place: the cid interface is still being finalized and no released scheduler
uses the current form.

Fixes: e9b55af47edf ("sched_ext: Add topological CPU IDs (cids)")
Cc: stable@vger.kernel.org # v7.2+
Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Andrea Righi <arighi@nvidia.com>

diff --git a/kernel/sched/ext/cid.c b/kernel/sched/ext/cid.c
index 39f88deb94bc..d4d5f537832a 100644
--- a/kernel/sched/ext/cid.c
+++ b/kernel/sched/ext/cid.c
@@ -912,30 +912,36 @@ bool scx_cmask_empty(const struct scx_cmask *m)
 /**
  * scx_bpf_cid_topo - Copy out per-cid topology info
  * @cid: cid to look up
- * @out__uninit: where to copy the topology info; fully written by this call
+ * @out: where to copy the topology info
+ * @out__sz: size of @out, the program's sizeof(struct scx_cid_topo)
  * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
  *
- * Fill @out__uninit with the topology info for @cid. Trigger scx_error() if
- * @cid is out of range. If @cid is valid but in the no-topo section, all fields
- * are set to -1. All fields are also set to -1 when no cid tables have been
- * published yet, which a program may observe while racing the root enable.
+ * Fill @out with the topology info for @cid. Trigger scx_error() if @cid is out
+ * of range. If @cid is valid but in the no-topo section, all fields are set to
+ * -1. All fields are also set to -1 when no cid tables have been published yet,
+ * which a program may observe while racing the root enable.
+ *
+ * The program's struct may be older or newer than the kernel's. The smaller of
+ * @out__sz and the kernel's size is copied and the rest of @out is set to -1.
  */
-__bpf_kfunc void scx_bpf_cid_topo(s32 cid, struct scx_cid_topo *out__uninit,
+__bpf_kfunc void scx_bpf_cid_topo(s32 cid, struct scx_cid_topo *out, size_t out__sz,
 				  const struct bpf_prog_aux *aux)
 {
+	size_t len = min(out__sz, sizeof(*out));
 	struct scx_cid_topo *topo;
 	struct scx_sched *sch;
 
+	/* the error cases and fields the kernel lacks read as -1 */
+	memset(out, 0xff, out__sz);
+
 	guard(rcu)();
 
 	sch = scx_prog_sched(aux);
 	topo = rcu_dereference(scx_cid_topo);
-	if (unlikely(!sch) || !cid_valid(sch, cid) || unlikely(!topo)) {
-		*out__uninit = SCX_CID_TOPO_NEG;
+	if (unlikely(!sch) || !cid_valid(sch, cid) || unlikely(!topo))
 		return;
-	}
 
-	*out__uninit = topo[cid];
+	memcpy(out, &topo[cid], len);
 }
 
 __bpf_kfunc_end_defs();
diff --git a/kernel/sched/ext/types.h b/kernel/sched/ext/types.h
index 943d8d429a2c..139176cf9fc6 100644
--- a/kernel/sched/ext/types.h
+++ b/kernel/sched/ext/types.h
@@ -70,6 +70,10 @@ enum scx_consts {
  * smaller shards if the LLC exceeds the target size. No-topo cids are packed
  * into their own max-sized shards.
  *
+ * New fields are appended, never inserted: scx_bpf_cid_topo() copies this
+ * struct out sized by the program's own layout, and an older program's copy
+ * must stay a prefix of the kernel's.
+ *
  * @core_cid: first cid of this cid's core (smt-sibling group)
  * @core_idx: global index of that core, in [0, nr_cores_at_init)
  * @llc_cid: first cid of this cid's LLC
diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index 2ddb01a059fd..22f24ebef8a9 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -106,7 +106,7 @@ u64 scx_bpf_now(void) __ksym __weak;
 void scx_bpf_events(struct scx_event_stats *events, size_t events__sz) __ksym __weak;
 s32 scx_bpf_cpu_to_cid(s32 cpu) __ksym __weak;
 s32 scx_bpf_cid_to_cpu(s32 cid) __ksym __weak;
-void scx_bpf_cid_topo(s32 cid, struct scx_cid_topo *out) __ksym __weak;
+void scx_bpf_cid_topo(s32 cid, struct scx_cid_topo *out, size_t out__sz) __ksym __weak;
 void scx_bpf_kick_cid(s32 cid, u64 flags) __ksym __weak;
 s32 scx_bpf_task_cid(const struct task_struct *p) __ksym __weak;
 s32 scx_bpf_this_cid(void) __ksym __weak;

