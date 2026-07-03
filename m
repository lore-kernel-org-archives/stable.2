Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770963DD852
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 10:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783074767; cv=none; b=Cfz3ECNUU2ORvhRiYviT/jOdUnkpbezVb9nLhmBiALzY/Vqx2XfelEG5ODpGSOL0Lch40VOHsHimUXO6rKWBtwNa/Dbbt4fjObRmG5bH3pU50Hph9V8Yax+eEMPSxQxBcitg89qudHq3FiUnXQVych2fu5oL5QNjomc+nPho3ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783074767; c=relaxed/simple;
	bh=Tm8VgvFWvXiTmoyvRnjPUK67MVmbbmRSs7WoNfnh3iQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ce/IV3Gv/Bi0PpathCtEpd2J/OP2jh7YrwzPPYZ4AM5OnqZdB3vzZZvrjXP6RyJl0SmI+Hbxupe1QfYq8sGUM4SmCfFw0vewG8WPTL6riUjkJ13Wf3pPQV2UqRdQV7qiTL8RXZm0HvnTnfXXcqv5M7tGU3XrhaZi3dlXG+z3R/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=drBd1qvB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="drBd1qvB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783074764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NaKQdFI56yqpqD9iJJ20XQp95MNPvmZUW2GKpcwiGUk=;
	b=drBd1qvB/i1TRI01l/IxkFXK28XiKIC3tm5LDoer2RvPqBqqi6CLZcCMeaocH22YmQO6A1
	BrAxw+YlU3mT76O0VYnPTq7OeeQcM+56vhy2CQW8vODv8D8Ib4aMDNMt4Jhg8FY+xR2Wvl
	FLlnV554x892wVq5miWOFLVv89fo0Fw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-w5v3z22nPDGybJn8X80hkQ-1; Fri,
 03 Jul 2026 06:32:41 -0400
X-MC-Unique: w5v3z22nPDGybJn8X80hkQ-1
X-Mimecast-MFC-AGG-ID: w5v3z22nPDGybJn8X80hkQ_1783074759
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DEACB1944AB4;
	Fri,  3 Jul 2026 10:32:38 +0000 (UTC)
Received: from vmalik-fedora.redhat.com (unknown [10.44.34.72])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 857BE1971E7D;
	Fri,  3 Jul 2026 10:32:32 +0000 (UTC)
From: Viktor Malik <vmalik@redhat.com>
To: linux-perf-users@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Viktor Malik <vmalik@redhat.com>,
	Howard Chu <howardchu95@gmail.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Michael Petlan <mpetlan@redhat.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] perf trace: Refactor augmented_raw_syscalls using bpf_for
Date: Fri,  3 Jul 2026 12:32:15 +0200
Message-ID: <8ceb8f3323d0742163c42c343eb9d26843fe9e9b.1783070132.git.vmalik@redhat.com>
In-Reply-To: <cover.1783070132.git.vmalik@redhat.com>
References: <cover.1783070132.git.vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The loop for processing syscall args in augment_raw_syscalls has a
history of breaking with Clang updates, see e.g. commit 013eb043f37b
("perf trace: Fix BPF loading failure (-E2BIG)") from Clang 15 to 16.

Now, a similar thing happened between Clang 21 and 22. While the issue
is mitigated on the main line by a recent verifier update, it remains
broken on the 6.12 and 6.18 stable branches:

    [linux-6.18.y]# sudo perf trace true
    libbpf: prog 'sys_enter': BPF program load failed: -E2BIG
    libbpf: prog 'sys_enter': -- BEGIN PROG LOAD LOG --
    [...]
    BPF program is too large. Processed 1000001 insn
    processed 1000001 insns (limit 1000000) max_states_per_insn 40 total_states 37941 peak_states 232 mark_read 0
    -- END PROG LOAD LOG --
    libbpf: prog 'sys_enter': failed to load: -E2BIG
    libbpf: failed to load object 'augmented_raw_syscalls_bpf'
    libbpf: failed to load BPF skeleton 'augmented_raw_syscalls_bpf': -E2BIG
    Error: failed to get syscall or beauty map fd
    [...]

The reason is that the loop is quite complex and the BPF verifier often
struggles to prove that it terminates.

Fix the issue by replacing the standard for loop by the bpf_for macro,
which uses numeric BPF iterator. This should prevent future breakages of
this kind since the verifier has much easier job proving that the loop
terminates.

Small adjustments were necessary for the loop to make it work.  The main
problem is that the verifier has sometimes problems with bpf_for loops
that use a carry-over state, such as the `payload_offset` and `output`
vars here, since the verifier tries to track their values too precisely
and cannot prove loop convergence. To resolve the issue, we (1)
explicitly recompute `payload_offset` in every iteration and (2) use a
trick with adding a global zero to `output` to help verifier forget its
precise state and use a range instead.

In exchange, this also allows to drop a few artificial checks to help
the verifier, including the changes introduced by 013eb043f37b.

Finally, to keep backwards compatibility with older kernel versions
which do not have bpf_for (i.e. numeric iterators), fall back to
standard for loop in such a case.

Signed-off-by: Viktor Malik <vmalik@redhat.com>
Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Fixes: a68fd6a6cdd3 ("perf trace: Collect augmented data using BPF")
Fixes: 013eb043f37b ("perf trace: Fix BPF loading failure (-E2BIG)")
Cc: stable@vger.kernel.org
---
 .../bpf_skel/augmented_raw_syscalls.bpf.c     | 54 +++++++++++++------
 1 file changed, 39 insertions(+), 15 deletions(-)

diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
index cbdd5ce19a2f..60babc06f381 100644
--- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
+++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
@@ -429,6 +429,8 @@ static bool pid_filter__has(struct pids_filtered *pids, pid_t pid)
 	return bpf_map_lookup_elem(pids, &pid) != NULL;
 }
 
+u64 ZERO = 0;
+
 /*
  * Determine what type of argument and how many bytes to read from user space, using the
  * value in the beauty_map. This is the relation of parameter type and its corresponding
@@ -439,12 +441,13 @@ static bool pid_filter__has(struct pids_filtered *pids, pid_t pid)
  * buffer: -1 * (index of paired len) -> value of paired len (maximum: TRACE_AUG_MAX_BUF)
  */
 static inline int augment_arg(struct syscall_enter_args *args, int i,
-			      unsigned int *beauty_map, void *payload_offset)
+			      unsigned int *beauty_map,
+			      struct beauty_payload_enter *payload, u64 offset)
 {
 	int index, value_size = sizeof(struct augmented_arg) - offsetof(struct augmented_arg, value);
 	s64 aug_size, size;
 	bool augmented;
-	void *arg;
+	void *arg, *payload_offset;
 
 	arg = (void *)args->args[i];
 	augmented = false;
@@ -454,6 +457,12 @@ static inline int augment_arg(struct syscall_enter_args *args, int i,
 	if (size == 0 || arg == NULL)
 		return 0;
 
+	/* bounds check for the verifier */
+	if (offset > sizeof(payload->aug_args) - sizeof(payload->aug_args[0]))
+		return -1;
+	barrier_var(offset);
+	payload_offset = (void *)&payload->aug_args + offset;
+
 	if (size == 1) { /* string */
 		aug_size = bpf_probe_read_user_str(((struct augmented_arg *)payload_offset)->value, value_size, arg);
 		/* minimum of 0 to pass the verifier */
@@ -464,11 +473,13 @@ static inline int augment_arg(struct syscall_enter_args *args, int i,
 	} else if (size > 0 && size <= value_size) { /* struct */
 		if (!bpf_probe_read_user(((struct augmented_arg *)payload_offset)->value, size, arg))
 			augmented = true;
-	} else if ((int)size < 0 && size >= -6) { /* buffer */
+	} else if (size < 0 && size >= -6) { /* buffer */
 		index = -(size + 1);
 		barrier_var(index); // Prevent clang (noticed with v18) from removing the &= 7 trick.
 		index &= 7;	    // Satisfy the bounds checking with the verifier in some kernels.
-		aug_size = args->args[index] > TRACE_AUG_MAX_BUF ? TRACE_AUG_MAX_BUF : args->args[index];
+		aug_size = args->args[index];
+		if (aug_size > TRACE_AUG_MAX_BUF)
+			aug_size = TRACE_AUG_MAX_BUF;
 
 		if (aug_size > 0) {
 			if (!bpf_probe_read_user(((struct augmented_arg *)payload_offset)->value, aug_size, arg))
@@ -497,11 +508,10 @@ static inline int augment_arg(struct syscall_enter_args *args, int i,
 static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
 {
 	bool do_output = false;
-	int zero = 0, written;
+	int i, zero = 0, written;
 	u64 output = 0; /* has to be u64, otherwise it won't pass the verifier */
 	unsigned int nr, *beauty_map;
 	struct beauty_payload_enter *payload;
-	void *payload_offset;
 
 	/* fall back to do predefined tail call */
 	if (args == NULL)
@@ -513,7 +523,6 @@ static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
 
 	/* set up payload for output */
 	payload        = bpf_map_lookup_elem(&beauty_payload_enter_map, &zero);
-	payload_offset = (void *)&payload->aug_args;
 
 	if (beauty_map == NULL || payload == NULL)
 		return 1;
@@ -521,14 +530,29 @@ static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
 	/* copy the sys_enter header, which has the syscall_nr */
 	__builtin_memcpy(&payload->args, args, sizeof(struct syscall_enter_args));
 
-	for (int i = 0; i < 6; i++) {
-		written = augment_arg(args, i, beauty_map, payload_offset);
-		if (written < 0)
-			return 1;
-		if (written > 0) {
-			output += written;
-			payload_offset += written;
-			do_output = true;
+	if (bpf_ksym_exists(bpf_iter_num_new)) {
+		bpf_for(i, 0, 6) {
+			written = augment_arg(args, i, beauty_map, payload, output);
+			if (written < 0)
+				return 1;
+			if (written > 0) {
+				output += written;
+				/* guide the verifier to forget range of `output`, which
+				 * helps to prove convergence of the loop
+				 */
+				output += ZERO;
+				do_output = true;
+			}
+		}
+	} else {
+		for (i = 0; i < 6; i++) {
+			written = augment_arg(args, i, beauty_map, payload, output);
+			if (written < 0)
+				return 1;
+			if (written > 0) {
+				output += written;
+				do_output = true;
+			}
 		}
 	}
 
-- 
2.54.0

