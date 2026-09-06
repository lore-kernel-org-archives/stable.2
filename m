Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6563B5F50
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 03:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788666257; cv=none; b=qKpZXZ7h0kmJ0rfCZqSalbeFGHBFTdDOYQx3RStG3GBtQa/PSTv/naDAnYTViYgVi1GpgIMy+j5UQQgEG55k7d5ZrW6Qitj2gqBvNxjT64nKv3YSLCY4bqKZk2o2aaw0HQUy6md5RxMOR8SCydDC5djBaF7r0Cyy3asYshk5I9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788666257; c=relaxed/simple;
	bh=nz7WpThK2Yj7pbRrI2t4/rlRY2RNQP/63J6KbYYh4Vk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KQbcDhp0AkoOiJU9ATiDGlXMF5ejrn56Lq0R0o/+mtyAVHtIPSNzlJ/fxfW28s1MVWWl9Y2r3t3srkWFu40zQeMpBWwu6yMyuXe+5NhvVHJihG/Yk6VulNnxWEQTInXbrTsiqGgM69WLfDA4FBkB4QSp0vr0vNstmEgNr5nvA2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eqFp8+fU; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqFp8+fU"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38511175ad3so2075265a91.2
        for <stable@vger.kernel.org>; Sat, 05 Sep 2026 20:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788666255; x=1789271055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=C4Ap773c76TL1E1578+g8wGsSz9MJ+j7nGEGULZVyZ8=;
        b=eqFp8+fUTxhuEzXcQYW4EVi/NOuhUKOO0m74PiUKaktHMqj7Hn6bxFuGCcQMmgUkmk
         QwMgVLBv5XPUtUFfkes/sY1g7FdzcS/jao+b71xrP8y7AcCoVhOSg8lxX46k8cn+bcNd
         ZfL0zHCqBTX2TWEwjeCgmpM6aYD7RfZKq/KSpETEc9X3aI7PMyJao4BcnFv/5OwQuY+D
         6xWrrGZRX2YTjqwT/k3ITo87KCoO3gNmDAT1KcCh0BMEBHicxBDo6cOwaSTGp78uE5xL
         iSVmrVMczKkNnB5tdBOaITXsR/+qWeTZiUBrnUEwuRvD84ijqoW2cp6kVGYEAdg4jWf0
         oKkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788666255; x=1789271055;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C4Ap773c76TL1E1578+g8wGsSz9MJ+j7nGEGULZVyZ8=;
        b=Z4dgFuO5/iVCDXgFAOU9X07/hQvqCzg7y+FXXYpo8/zCiyRZYNwJmeJpXI/BPmx8O4
         vFvWAdwKonpAuVkVsWgftc7qozugNIWS7o6ShFz8WuY0MJQTqGNWY6PlnxF/QaCKZrtI
         jrXC1LLIUvs39ebg66Pos56XgcsNPOlpwHRoceteXdysX6ZO4IsVO+SHP5MsVsit/8LL
         tuBanHs+3jstfv+WmQ9a2LlcGL0bShQhj4+/4hkKrKma+Udc5/uDoAnwrshFMjrgL8Nv
         TLtoiDfwmqQ7gq6d8capypETGrZPUKVuMUAxgtObncuIBEKP/w42EJRiPeeVI/6BMqTS
         98zg==
X-Forwarded-Encrypted: i=1; AKwUvBzL3fDayRkBKd/XoRreJhYK99DocPU8niajPH3j1vSwf4aRIPxk4ccDS/5lK7TJrIv0Taq1igI=@vger.kernel.org
X-Gm-Message-State: AFuF++n0TuszrEpdUteO9yN60aMQN+1DkvhVhoaLT2GgAA2yQi0BaDAF
	R9vRaWc4JlKKevqfGGfXsXULiFrc5p88DywjqrDG4Tyn5bE0NNbTv/M=
X-Gm-Gg: AYBFou2T62wT4o1jrts0zeOWDPxlLqvYE3NSihLVv9Ly3VHWd1ouGpt9jj+R2BqUeEW
	3+qwNHg0bOcts9kmcO7pjXh/C14CO6dRxJouLK3ZtB04RTzI+EpDpGJr+AK239lOtiVxdbLTX6G
	3eJ9HyeiorkvQDkQpke3VzeiKDEZgyrOv0XzhMf/XYLlpOODcdF1iZ2EGehBMLIPnumBXWSxncR
	ewbYO0IIsAcEJqVK48zi7YCTy/NqQnonn7899m7+CQC+88wsRfwkMXahIQJhkf9fg2p54BiGWel
	MjuiTSfFT3VTrUdYepHd4HJcilquhHeTy0f/bJP6ARu3bEY9jEB0FOTMhWE0BVJB5Xkms2FJ79u
	Lqy0lnZMBw7s374qlu26julKB5q3cTCSz2QSwypecJNH1dbhtea5//Xgs0oY2xRckUOHO63dNgN
	wLT2a/VJxO9q0RG+8NSiKgHkyvRAkM0SrGy99UhRaMcBpsPh7IzxLs025RhiFvEwdUdVv0aVxLm
	QFKYT1Wsn9TyMWD
X-Received: by 2002:a17:90b:224c:b0:398:9bd4:d15 with SMTP id 98e67ed59e1d1-39b26245d08mr21476187a91.20.1788666252720;
        Sat, 05 Sep 2026 20:44:12 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:6467:d689:2b14:fe4a:ab17:f236])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b260fdf9asm13075385a91.9.2026.09.05.20.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 20:44:12 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	donggeunyoo.kernel@gmail.com
Subject: [PATCH] function_graph: Use the saved entry's size when reprinting it
Date: Sun,  6 Sep 2026 12:44:06 +0900
Message-ID: <20260906034406.1335316-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a graph entry does not fit in the trace_seq, print_graph_entry()
saves it in the iterator's fgraph_data and reprints it on the next read.
The entry has already been consumed from the ring buffer by then, so the
copy is all that is left of it.

The copy is sized with iter->ent_size, which no longer describes the
saved entry but whatever entry the iterator has moved on to. The
argument count is derived from the same field, so a 72 byte entry saved
and then reprinted ahead of a 48 byte return entry loses its arguments.

Record the size next to the failure flag, so that the two are always set
together, and restore it before reprinting.

Fixes: ff5c9c576e75 ("ftrace: Add support for function argument to graph tracer")
Cc: stable@vger.kernel.org
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
---
Reproduced under QEMU (x86_64 defconfig plus FTRACE, FUNCTION_GRAPH_TRACER,
DEBUG_INFO_BTF, 2 vCPUs). function_graph with funcgraph-args on, trace_pipe
read in 64K chunks 300 times from a static init:

  before: 271 reprints, 190 of them with a size that did not match the saved
          entry, 184 of those deciding the argument count the wrong way.
          _raw_spin_unlock() takes one argument and printed as
          "_raw_spin_unlock()" 19 times out of 2209.
  after:  same workload, 0 times.

Toggling funcgraph-args and funcgraph-retaddr during the run produces all four
entry sizes (24, 32, 72, 80 here) and they are all reprinted with their own.

No change in tools/testing/selftests/ftrace: 80 passed, 3 failed, 13 unresolved,
81 unsupported both with and without the patch, identical per test. The
in-kernel selftests pass, including "Testing tracer function_graph". A KASAN
build reports nothing on the same workload.

 kernel/trace/trace_functions_graph.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index ff7cb1a76b95..c5befd0c5b9a 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -52,6 +52,7 @@ struct fgraph_data {
 	};
 	struct ftrace_graph_ret_entry	ret;
 	int				failed;
+	int				ent_size;
 	int				cpu;
 };
 
@@ -1274,6 +1275,7 @@ print_graph_entry(struct ftrace_graph_ent_entry *field, struct trace_seq *s,
 		if (s->full) {
 			data->failed = 1;
 			data->cpu = cpu;
+			data->ent_size = iter->ent_size;
 		} else
 			data->failed = 0;
 	}
@@ -1457,6 +1459,7 @@ print_graph_function_flags(struct trace_iterator *iter, u32 flags)
 	if (data && data->failed) {
 		field = &data->ent.ent;
 		iter->cpu = data->cpu;
+		iter->ent_size = data->ent_size;
 		ret = print_graph_entry(field, s, iter, flags);
 		if (ret == TRACE_TYPE_HANDLED && iter->cpu != cpu) {
 			per_cpu_ptr(data->cpu_data, iter->cpu)->ignore = 1;
-- 
2.53.0

