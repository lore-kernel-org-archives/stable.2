Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D0A3BF677
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 06:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783407208; cv=none; b=h8Nh/YZs4gJByuffE88zmmvcd9HXr7Gm4rt4Y8TiFzgBfn7alkYukqu1KLRBT2VQC/vRMuGm0YCiDhrNenmoWxI4NiVsr7miDOf5aE7IsMLtektzhmDco+l8Om7SxO6OiOXELM65pRBg46i+WjpQkzpXDW5rpp1mG4k/CIn89EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783407208; c=relaxed/simple;
	bh=UUi7ZPY68FzydqFXLRJx1F35K1cv91nvZLrM7pj5Gus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gmcvH+obMR/ATPcR/mgjGyeyZLhJzz/CU4p1Yrxj0jQ94hIsI8gh8NLJXx2SJSeCxlezMBDTa9+FxfCf8MKu/gsTvd+xoJ979cFsZCaR222yd2ClqTNghxXBDo1glKKWuLKweAfvCXGGkCs/mb2ForuePycjownjeNpLpTLNqXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g6PRk7nW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g6PRk7nW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783407202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KKyrkRQAO2eoY3ppvINPzoApwyh1I0vLGhy15gwEZ/I=;
	b=g6PRk7nWXFs6n6oM6RLzxUGqJISE2UJ3HMmmfRluTzJnsgGFaKy1eIVl6i475QlmeZqbWm
	uUUY0pdN3nRrM06I/3hVXprCuu+V8nkhVWTV6ldPqLr4+/2+zDmZY9KJg2URZZH2oV9f5O
	Lsqthsy3slHu+bcn8ZeXrIaMNgZZ4O0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-12-PvVAgK-PPmW7IURXm9HiZg-1; Tue,
 07 Jul 2026 02:53:16 -0400
X-MC-Unique: PvVAgK-PPmW7IURXm9HiZg-1
X-Mimecast-MFC-AGG-ID: PvVAgK-PPmW7IURXm9HiZg_1783407194
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 532EB1920C2E;
	Tue,  7 Jul 2026 06:53:04 +0000 (UTC)
Received: from vmalik-fedora.brq.redhat.com (unknown [10.43.17.109])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 70CCA19560A6;
	Tue,  7 Jul 2026 06:53:00 +0000 (UTC)
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
Subject: [PATCH v4 2/2] perf trace: Refactor augmented_raw_syscalls using bpf_for
Date: Tue,  7 Jul 2026 08:52:47 +0200
Message-ID: <a4a363ae325a670ba122fee2cabcebc7ecd236bd.1783406979.git.vmalik@redhat.com>
In-Reply-To: <cover.1783406979.git.vmalik@redhat.com>
References: <cover.1783406979.git.vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

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

Fix the issue by replacing the standard for loop with the bpf_for macro,
which uses a numeric BPF iterator. This should prevent future breakages
of this kind since the verifier has a much easier job proving that the
loop terminates.

Small adjustments were necessary for the loop to make it work.  The main
problem is that the verifier sometimes has problems with bpf_for loops
that use a carry-over state, such as the `payload_offset` and `output`
vars here, since the verifier tries to track their values too precisely
and cannot prove loop convergence. To resolve the issue, we (1)
explicitly recompute `payload_offset` in every iteration and (2) use a
trick with adding a global zero to `output` to help the verifier forget
its precise state and use a range instead.

Finally, to keep backwards compatibility with older kernel versions that
don't have bpf_for (i.e. numeric iterators), fall back to standard loop.

Signed-off-by: Viktor Malik <vmalik@redhat.com>
Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Fixes: a68fd6a6cdd3 ("perf trace: Collect augmented data using BPF")
Cc: stable@vger.kernel.org
---
 .../bpf_skel/augmented_raw_syscalls.bpf.c     | 47 ++++++++++++++-----
 1 file changed, 35 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
index bc036a348079..3bc9e28a9b8a 100644
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
@@ -440,9 +442,10 @@ static bool pid_filter__has(struct pids_filtered *pids, pid_t pid)
  */
 static inline int augment_arg(struct syscall_enter_args *args, int i,
 			      unsigned int *beauty_map,
-			      struct augmented_arg *payload_offset)
+			      struct beauty_payload_enter *payload, u64 offset)
 {
 	int index, value_size = sizeof(struct augmented_arg) - offsetof(struct augmented_arg, value);
+	struct augmented_arg *payload_offset;
 	s64 aug_size, size;
 	bool augmented;
 	void *arg;
@@ -455,6 +458,12 @@ static inline int augment_arg(struct syscall_enter_args *args, int i,
 	if (size == 0 || arg == NULL)
 		return 0;
 
+	/* bounds check for the verifier */
+	if (offset > sizeof(payload->aug_args) - sizeof(payload->aug_args[0]))
+		return -1;
+	barrier_var(offset);
+	payload_offset = (struct augmented_arg *)((void *)&payload->aug_args + offset);
+
 	if (size == 1) { /* string */
 		aug_size = bpf_probe_read_user_str(payload_offset->value, value_size, arg);
 		/* minimum of 0 to pass the verifier */
@@ -498,11 +507,10 @@ static inline int augment_arg(struct syscall_enter_args *args, int i,
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
@@ -514,7 +522,6 @@ static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
 
 	/* set up payload for output */
 	payload        = bpf_map_lookup_elem(&beauty_payload_enter_map, &zero);
-	payload_offset = (void *)&payload->aug_args;
 
 	if (beauty_map == NULL || payload == NULL)
 		return 1;
@@ -522,14 +529,30 @@ static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
 	/* copy the sys_enter header, which has the syscall_nr */
 	__builtin_memcpy(&payload->args, args, sizeof(struct syscall_enter_args));
 
-	for (int i = 0; i < 6; i++) {
-		written = augment_arg(args, i, beauty_map, (struct augmented_arg *)payload_offset);
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
+				/*
+				 * guide the verifier to forget range of `output`, which
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

