Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE921424669
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 12:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783339375; cv=none; b=UDs4KoOn7NHkaPgltXE/+HMTEn+TEWI00MO30+KqPsxTn18k3n8Tlr+siHqDN5kfB8RbdSzguR4Iggn4ivE71mcCgDfGex40dlTCbX+sAUo3JqgE0LnCCEhWhOiyUcKMhEf7RDfTUJsmKCloTkn11iL5rLt4pjmgBcOcY8U9wZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783339375; c=relaxed/simple;
	bh=RTeM1o0+h6I5lPOEEsm/fHlPdZ30SFvAMe+hN/a9HGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dcWpFuLYTQvPeyRLpceKoIt+nt7RF3b7J1/H84IvtCJdHKQubTBNZdY+pVRBXzS7AFHuXqT1UmzblHRQmvvc+FpX5DomPkGhlBVjHe+iyVxxvQ//HMXPdLDIAztKhG56dGmuVqKO9mc+g6HwR/U9NeJlPQJ7NRp1hymid/kxxgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VX0Fieqc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VX0Fieqc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783339372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Blqvx5WIsXc9GB+tgTHAk2e9rF7RZrVJBZcg5w7duPE=;
	b=VX0FieqcQvErLc9TcoQA6G9IaOHw1dyJq1ZRfYIR2j2bOUpFRv/wYZhqfkGV2gsG1CuAUw
	vttS3XvZ9vWovzplDEp1pb498YLbC4409OtIXPmcYPsiCB5OKwrZ2gY3RmlFSC46cEFJCL
	oYnagYBRqz1g7LWRlMN3Axu48BVZ89M=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-rYtAbhdBM-OrG1TRw5Ek1g-1; Mon,
 06 Jul 2026 08:02:47 -0400
X-MC-Unique: rYtAbhdBM-OrG1TRw5Ek1g-1
X-Mimecast-MFC-AGG-ID: rYtAbhdBM-OrG1TRw5Ek1g_1783339365
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E34281955F26;
	Mon,  6 Jul 2026 12:02:44 +0000 (UTC)
Received: from vmalik-fedora.redhat.com (unknown [10.44.49.128])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 130321956096;
	Mon,  6 Jul 2026 12:02:38 +0000 (UTC)
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
	stable@vger.kernel.org
Subject: [PATCH v3 1/2] perf trace: Factor out BPF loop body
Date: Mon,  6 Jul 2026 14:02:27 +0200
Message-ID: <a922f3db714918d88dbedb21066f895dca2e951f.1783339165.git.vmalik@redhat.com>
In-Reply-To: <cover.1783339165.git.vmalik@redhat.com>
References: <cover.1783339165.git.vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The BPF program in augmented_raw_syscalls uses a for loop to iterate all
syscall arguments. The loop body is quite complex and often poses
problems for the BPF verifier. As a preparation step for addressing this
issue, factor out the loop body into a separate function.

Signed-off-by: Viktor Malik <vmalik@redhat.com>
Cc: stable@vger.kernel.org
---
 .../bpf_skel/augmented_raw_syscalls.bpf.c     | 128 ++++++++++--------
 1 file changed, 73 insertions(+), 55 deletions(-)

diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
index 2a6e61864ee0..bc036a348079 100644
--- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
+++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
@@ -429,15 +429,80 @@ static bool pid_filter__has(struct pids_filtered *pids, pid_t pid)
 	return bpf_map_lookup_elem(pids, &pid) != NULL;
 }
 
+/*
+ * Determine what type of argument and how many bytes to read from user space, using the
+ * value in the beauty_map. This is the relation of parameter type and its corresponding
+ * value in the beauty map, and how many bytes we read eventually:
+ *
+ * string: 1			      -> size of string
+ * struct: size of struct	      -> size of struct
+ * buffer: -1 * (index of paired len) -> value of paired len (maximum: TRACE_AUG_MAX_BUF)
+ */
+static inline int augment_arg(struct syscall_enter_args *args, int i,
+			      unsigned int *beauty_map,
+			      struct augmented_arg *payload_offset)
+{
+	int index, value_size = sizeof(struct augmented_arg) - offsetof(struct augmented_arg, value);
+	s64 aug_size, size;
+	bool augmented;
+	void *arg;
+
+	arg = (void *)args->args[i];
+	augmented = false;
+	size = beauty_map[i];
+	aug_size = size; /* size of the augmented data read from user space */
+
+	if (size == 0 || arg == NULL)
+		return 0;
+
+	if (size == 1) { /* string */
+		aug_size = bpf_probe_read_user_str(payload_offset->value, value_size, arg);
+		/* minimum of 0 to pass the verifier */
+		if (aug_size < 0)
+			aug_size = 0;
+
+		augmented = true;
+	} else if (size > 0 && size <= value_size) { /* struct */
+		if (!bpf_probe_read_user(payload_offset->value, size, arg))
+			augmented = true;
+	} else if ((int)size < 0 && size >= -6) { /* buffer */
+		index = -(size + 1);
+		barrier_var(index); // Prevent clang (noticed with v18) from removing the &= 7 trick.
+		index &= 7;	    // Satisfy the bounds checking with the verifier in some kernels.
+		aug_size = args->args[index] > TRACE_AUG_MAX_BUF ? TRACE_AUG_MAX_BUF : args->args[index];
+
+		if (aug_size > 0) {
+			if (!bpf_probe_read_user(payload_offset->value, aug_size, arg))
+				augmented = true;
+		}
+	}
+
+	/* Augmented data size is limited to sizeof(augmented_arg->unnamed union with value field) */
+	if (aug_size > value_size)
+		aug_size = value_size;
+
+	/* write data to payload */
+	if (augmented) {
+		int written = offsetof(struct augmented_arg, value) + aug_size;
+
+		if (written < 0 || written > sizeof(struct augmented_arg))
+			return -1;
+
+		payload_offset->size = aug_size;
+		return written;
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
+	int zero = 0, written;
 	u64 output = 0; /* has to be u64, otherwise it won't pass the verifier */
-	s64 aug_size, size;
 	unsigned int nr, *beauty_map;
 	struct beauty_payload_enter *payload;
-	void *arg, *payload_offset;
+	void *payload_offset;
 
 	/* fall back to do predefined tail call */
 	if (args == NULL)
@@ -457,58 +522,11 @@ static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
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
 	for (int i = 0; i < 6; i++) {
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
+		written = augment_arg(args, i, beauty_map, (struct augmented_arg *)payload_offset);
+		if (written < 0)
+			return 1;
+		if (written > 0) {
 			output += written;
 			payload_offset += written;
 			do_output = true;
-- 
2.54.0

