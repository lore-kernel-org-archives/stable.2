Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26423D3D00
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 11:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782213952; cv=none; b=c0NkdtoKGOfSilGniCD6GkDNtd30cCMoIPNMsCzYnls2p9zv2IPeRWYHsgX6v00Gs6KdJC60UgyfdRnQWrcTL0XRD0kRLWSrFEujLuV95QvIE4AYX9+I+LZPCU+xrlPdeN6iabSzd5RMvly6ql8O1TyK7034bAUTJQZiFQxorDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782213952; c=relaxed/simple;
	bh=m+E3TjkE6dn/6fKKHYHpYC0iGcTgTNTIlGlR5oO/3lo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KdyBIVtb/eKBfyiuwP8ZrGyTObNhIRrAlbqJwAN4EAI0p221N6LY42dEVnJL/EPynyqD3cZnKfQSqf44qOvyq2goLflNhrMzX/Fkp2DMba3jJDkPFU+U1WfnZVo9mkKeDQ7LpiV7NC1NV/frCN003i6wVssZ2wTIt79mNF7VZYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PInSf4QT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PInSf4QT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782213949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XCMI4TR7QFtDkc3LYw54gkw6mxhFRqeq79UUiIMDTNY=;
	b=PInSf4QTPyQ1JEkdxrouBCM+DL7h9JtbwzEGbgyWQy4uhRuNMqL3SknFxIlpivPIgUt0xc
	LOr9QW2F6urGj0ZtExXlJtyrgstZ7v22wCm+ddTOYIDrt5QEU6YXx7zgGxbUVoGaNRa5bf
	V3ACQjodKL+wrV09+sXaRMBTO21VzOE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-549-3Diog-vuNYuzkEiwpJDqLQ-1; Tue,
 23 Jun 2026 07:25:44 -0400
X-MC-Unique: 3Diog-vuNYuzkEiwpJDqLQ-1
X-Mimecast-MFC-AGG-ID: 3Diog-vuNYuzkEiwpJDqLQ_1782213942
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C71771955E9C;
	Tue, 23 Jun 2026 11:25:41 +0000 (UTC)
Received: from vmalik-fedora.brq.redhat.com (unknown [10.43.17.131])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6D3D31800597;
	Tue, 23 Jun 2026 11:25:37 +0000 (UTC)
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
	Howard Chu <howardchu95@gmail.com>,
	Viktor Malik <vmalik@redhat.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Michael Petlan <mpetlan@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH] perf trace: Refactor augmented_raw_syscalls using bpf_loop
Date: Tue, 23 Jun 2026 13:25:33 +0200
Message-ID: <20260623112533.1151502-1-vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

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

Fix the issue by refactoring the loop body into a callback function and
calling the bpf_loop helper. This should prevent future breakages of
this kind since the callback function has no loops. It also allows to
drop a few artificial checks to help the verifier, including the changes
introduced by 013eb043f37b.

Signed-off-by: Viktor Malik <vmalik@redhat.com>
Fixes: a68fd6a6cdd3 ("perf trace: Collect augmented data using BPF")
Fixes: 013eb043f37b ("perf trace: Fix BPF loading failure (-E2BIG)")
Cc: stable@vger.kernel.org
---
 .../bpf_skel/augmented_raw_syscalls.bpf.c     | 157 +++++++++++-------
 1 file changed, 96 insertions(+), 61 deletions(-)

diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
index 2a6e61864ee0..6d553ed3ac23 100644
--- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
+++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
@@ -429,15 +429,96 @@ static bool pid_filter__has(struct pids_filtered *pids, pid_t pid)
 	return bpf_map_lookup_elem(pids, &pid) != NULL;
 }
 
+struct args_loop_ctx {
+	struct syscall_enter_args *args;
+	unsigned int *beauty_map;
+	void *payload_offset;
+	int value_size;
+	u64 *output;
+	bool *do_output;
+};
+
+static long process_arg_cb(u64 i, void *ctx)
+{
+	/*
+	 * Determine what type of argument and how many bytes to read from user space, using the
+	 * value in the beauty_map. This is the relation of parameter type and its corresponding
+	 * value in the beauty map, and how many bytes we read eventually:
+	 *
+	 * string: 1			      -> size of string
+	 * struct: size of struct	      -> size of struct
+	 * buffer: -1 * (index of paired len) -> value of paired len (maximum: TRACE_AUG_MAX_BUF)
+	 */
+	struct augmented_arg *augmented_arg;
+	struct args_loop_ctx *loop_ctx;
+	int aug_size, size, index;
+	bool augmented;
+	void *arg;
+
+	/* Bounds check for the below map access to help the verifier */
+	if (i < 0 || i >= 6)
+		return 1;
+
+	loop_ctx = (struct args_loop_ctx *)ctx;
+	arg = (void *)loop_ctx->args->args[i];
+	augmented = false;
+	size = loop_ctx->beauty_map[i];
+	aug_size = size; /* size of the augmented data read from user space */
+	augmented_arg = (struct augmented_arg *)loop_ctx->payload_offset;
+
+	if (size == 0 || arg == NULL)
+		return 0; /* continue */
+
+	if (size == 1) { /* string */
+		aug_size = bpf_probe_read_user_str(augmented_arg->value, loop_ctx->value_size, arg);
+		augmented = true;
+	} else if (size > 0 && size <= loop_ctx->value_size) { /* struct */
+		if (!bpf_probe_read_user(augmented_arg->value, size, arg))
+			augmented = true;
+	} else if (size < 0 && size >= -6) { /* buffer */
+		index = -(size + 1);
+		barrier_var(index); // Prevent clang (noticed with v18) from removing the &= 7 trick.
+		index &= 7;	    // Satisfy the bounds checking with the verifier in some kernels.
+		aug_size = loop_ctx->args->args[index];
+
+		if (aug_size > TRACE_AUG_MAX_BUF)
+			aug_size = TRACE_AUG_MAX_BUF;
+
+		if (aug_size > 0) {
+			if (!bpf_probe_read_user(augmented_arg->value, aug_size, arg))
+				augmented = true;
+		}
+	}
+
+	/* Augmented data size is limited to sizeof(augmented_arg->unnamed union with value field) */
+	if (aug_size > loop_ctx->value_size)
+		aug_size = loop_ctx->value_size;
+
+	/* write data to payload */
+	if (augmented) {
+		int written = offsetof(struct augmented_arg, value) + aug_size;
+
+		if (written < 0 || written > sizeof(struct augmented_arg))
+			return 1; /* break */
+
+		augmented_arg->size = aug_size;
+		*loop_ctx->output += written;
+		loop_ctx->payload_offset += written;
+		*loop_ctx->do_output = true;
+	}
+
+	return 0;
+}
+
 static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
 {
-	bool augmented, do_output = false;
-	int zero = 0, index, value_size = sizeof(struct augmented_arg) - offsetof(struct augmented_arg, value);
+	bool do_output = false;
+	int zero = 0, value_size = sizeof(struct augmented_arg) - offsetof(struct augmented_arg, value);
 	u64 output = 0; /* has to be u64, otherwise it won't pass the verifier */
-	s64 aug_size, size;
 	unsigned int nr, *beauty_map;
 	struct beauty_payload_enter *payload;
-	void *arg, *payload_offset;
+	void *payload_offset;
+	long iters;
 
 	/* fall back to do predefined tail call */
 	if (args == NULL)
@@ -457,63 +538,17 @@ static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
 	/* copy the sys_enter header, which has the syscall_nr */
 	__builtin_memcpy(&payload->args, args, sizeof(struct syscall_enter_args));
 
-	/*
-	 * Determine what type of argument and how many bytes to read from user space, using the
-	 * value in the beauty_map. This is the relation of parameter type and its corresponding
-	 * value in the beauty map, and how many bytes we read eventually:
-	 *
-	 * string: 1			      -> size of string
-	 * struct: size of struct	      -> size of struct
-	 * buffer: -1 * (index of paired len) -> value of paired len (maximum: TRACE_AUG_MAX_BUF)
-	 */
-	for (int i = 0; i < 6; i++) {
-		arg = (void *)args->args[i];
-		augmented = false;
-		size = beauty_map[i];
-		aug_size = size; /* size of the augmented data read from user space */
-
-		if (size == 0 || arg == NULL)
-			continue;
-
-		if (size == 1) { /* string */
-			aug_size = bpf_probe_read_user_str(((struct augmented_arg *)payload_offset)->value, value_size, arg);
-			/* minimum of 0 to pass the verifier */
-			if (aug_size < 0)
-				aug_size = 0;
-
-			augmented = true;
-		} else if (size > 0 && size <= value_size) { /* struct */
-			if (!bpf_probe_read_user(((struct augmented_arg *)payload_offset)->value, size, arg))
-				augmented = true;
-		} else if ((int)size < 0 && size >= -6) { /* buffer */
-			index = -(size + 1);
-			barrier_var(index); // Prevent clang (noticed with v18) from removing the &= 7 trick.
-			index &= 7;	    // Satisfy the bounds checking with the verifier in some kernels.
-			aug_size = args->args[index] > TRACE_AUG_MAX_BUF ? TRACE_AUG_MAX_BUF : args->args[index];
-
-			if (aug_size > 0) {
-				if (!bpf_probe_read_user(((struct augmented_arg *)payload_offset)->value, aug_size, arg))
-					augmented = true;
-			}
-		}
-
-		/* Augmented data size is limited to sizeof(augmented_arg->unnamed union with value field) */
-		if (aug_size > value_size)
-			aug_size = value_size;
-
-		/* write data to payload */
-		if (augmented) {
-			int written = offsetof(struct augmented_arg, value) + aug_size;
-
-			if (written < 0 || written > sizeof(struct augmented_arg))
-				return 1;
-
-			((struct augmented_arg *)payload_offset)->size = aug_size;
-			output += written;
-			payload_offset += written;
-			do_output = true;
-		}
-	}
+	struct args_loop_ctx loop_ctx = {
+		.args = args,
+		.beauty_map = beauty_map,
+		.payload_offset = payload_offset,
+		.value_size = value_size,
+		.output = &output,
+		.do_output = &do_output
+	};
+	iters = bpf_loop(6, process_arg_cb, &loop_ctx, 0);
+	if (iters != 6)
+		return 1;
 
 	if (!do_output || (sizeof(struct syscall_enter_args) + output) > sizeof(struct beauty_payload_enter))
 		return 1;
-- 
2.54.0

