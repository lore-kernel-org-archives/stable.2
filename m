Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CA73CF1F0
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 17:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785952486; cv=none; b=PEYj1ra1mANtkdX1eFPq2zmr7R+z32ysT+5N6+HP+8bZPn7tdzTcfYnJ/RIKTP+UPvgE5FjxCnv64a7aF8ZiFihpNSJPy8St+rJcXdiZ7qBCq4qLz37GtvOP8A/aHKyh1sLi3FakegjMvRwqaqPCNl2MmWPO4QMttvfbipHHJvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785952486; c=relaxed/simple;
	bh=41ZTRzM08tQ5uahF2xx+TZSPYRHKisMOeI7V6s9DSHI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XyOChDq9sAEU2lEYJB8b7FP1e0XMXbNDacJpux8k2qwqUlkB52tPCJ8NTd3Wv7TemNgPAFWEe3/wuJPPsbUtMt5c0QYdqyuFB8hIi3LfW//O74NKv3BZEaLsWXiD1syJ0WJQHfOmaOtMv7X8Zm8HrnuUahB+Pk8yqx5o0iZ4Wzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=JmydfxWO; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="JmydfxWO"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-4af173320f9so864276b6e.2
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 10:54:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785952483; x=1786557283;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k+P+RXL5pfUjEKNmX4xpFLJX8jTYngtTbSc4bUn2+XU=;
        b=EXcv5uu4vX+dylWcorg0/u/M10DhAMVTtwuQ/0kp+bmVtVCylntaCjDa504UyjIxU2
         KgBHndpevlldLjhUk8Dsfqbx1Q1Qk4/ySRwEQtFVP0/n6ddw9KtheNijqatzByKA9Puw
         5qA9Zjm0LG1SSvMipYtt1qEmHNbarqv4iq/ZY8r66bzGNnSDAHXX/T94W1xVACENW+G1
         QMGdIWRhjjA/L6V3QIj7l0qUGsMeVG0cBl3H960wGO9V2aSioB0F635pglmuI5Jl6Au1
         GwwyKeZxroXC/48dybAGLPt9ktIW7P5exrrXM/Zi9P8m7NtPC92PKtenOVtkQ4AYQ2xC
         rjCg==
X-Forwarded-Encrypted: i=1; AHgh+Rpc1hghYeQeEgDm0DR0T94UKIG2ZwbcODmzNWfq8/8anQmXvQwz3gzlb4ChjmZtsYz+vgIHKUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOLvLTquqI3mKruGzQtjTbx74WMX9dVxGeyDpX28TW0EegFk34
	WjEbj15M5HxtetTI5kSymrc5F/YCh9Wl2WrFbedbdl5Nx8cEZiCTCEQO
X-Gm-Gg: AR+sD10gWN/9LQqaswSwR0muFf7BQNvJWQCMRAgMAUgZ5aG6O5zExw6Wque68wUySz+
	nDDMj3kU+5qXeAseY1b5vO+PqNtr7AGMqUJ7jBH+iofDSaZf8ITdVkf/mig7Fkjiss7QBx1q6/9
	BNLulooH7XieMi8bqnLxD0X6UelItMNXMohNcokgzXnMeX7T3sfyME6I/5yuzuhzQKfMSJkUu9F
	nTBE4F5sC9E6icoNSOcuxoBLp8oRyM59uBzqlQG8jCy6N1d6XlCnAIVa/eWNy5PLiuaMh0dt4/f
	ckEWxD+pLVUlTMTSHwU5dnkiTzbhf2AqMwKkXAESSzcIv9ga/FLJHsa+ohWw+udStCHOoXWTEwY
	Z0A/JBXGJqgDv2511wVhhrfcTmR7GsU2DwVLoswnOltlQgZLPeNyP0X/OWYC5sKAspanxwyecrV
	SZI+ovuM4vf0ZfpViDPO1iCQ7i6+B7FHDzzg9etNDnfQeCdLEw+IL2SB8+GniJnOF/s99Lf1jUU
	dmaea/GZimCZBhMmF3yDIxBnCh8+3VlG4pMVXeEJuPwfhcpKdIqbk5k9gnzFcThpYlSqt4wxEK0
X-Received: by 2002:a05:6808:1486:b0:495:ff85:d33d with SMTP id 5614622812f47-4afadfb630bmr5540258b6e.12.1785952482998;
        Wed, 05 Aug 2026 10:54:42 -0700 (PDT)
Received: from mail.marliere.net (137.65.66.34.bc.googleusercontent.com. [34.66.65.137])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4afae4b5750sm2554962b6e.7.2026.08.05.10.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 10:54:42 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 53BDD609D3;
	Wed,  5 Aug 2026 17:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=dkim; t=1785952480;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=k+P+RXL5pfUjEKNmX4xpFLJX8jTYngtTbSc4bUn2+XU=;
	b=JmydfxWOITslXX6qx/BaHMPeihq41QFcUZpUEM66zXolET75dtROwB2UBs8/0+c1zCciXw
	SxJHqPL6ePWORyx3tFMzSI9XIvMwKI4CrmIRc17hum0bhE9cTtF5FI41F5Qg5u1GePiBYY
	45oogv4d7d+imVkWPNHt1gSHcYEuWcVk+x+m+cPy3qaeI6g8mtSvxpU49wNgbJSwvIzOLd
	Ch52XG8ofjBHjK7+EqC072Tr7eVurj379Bb/IEREcdocUuP6Ozmvqs2oVwgLBSCOOOT+LQ
	9XE3ovg2gwN532772AnLAuuww4I32INye7+S6HbTrjV9VPpHb+o3uugb4SBVnA==
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re_=28SUSE=29?= <ricardo@marliere.net>
Date: Wed, 05 Aug 2026 14:54:34 -0300
Subject: [PATCH 7.1.y] selftests/bpf: Add tests for sleepable tracepoint
 programs
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260805-selftests-bpf-sleepable-v1-1-e29fa5af4119@marliere.net>
X-B4-Tracking: v=1; b=H4sIANl4c2oC/4WOTQ6CMBSEr2Le2hJaiKIr72FctGUqNRVJXyUSw
 t2leACX8/dlZmJED6bzbqaI0bN/9auQ+x3ZTvd3CN+umlSpDmVTVoIRXAInFmZwggMwaBMgAON
 UezooVUpa10OE85+NfKVjIYuJbj+b3+YBmzI1F41mCBN1b7tsccq4HHSe0ytO27VRbpy/L0Ypp
 GhtbU3TVMcap8tTx+ARUfRIdFuW5QuNBbm+8wAAAA==
X-Change-ID: 20260803-selftests-bpf-sleepable-eebf2d962201
To: sashal@kernel.org, gregkh@linuxfoundation.org, 
 Alexei Starovoitov <ast@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, stable@vger.kernel.org, 
 Mykyta Yatsenko <yatsenko@meta.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1785952476; l=11150;
 i=ricardo@marliere.net; h=from:subject:message-id;
 bh=zHQiWS/0qthc95Lu8GM+XgUPNU3+5yyO7Vzaw+uAdx0=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QOHogWNJwUNFw3VZdv1HiqZ5LeuxDINMzPfNarzsCgVSdo2OGW7NKRUaVMZfEsWgaxOvragUAsb
 FtUz8GCpvSQ8=
X-Developer-Key: i=ricardo@marliere.net; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g
X-Last-TLS-Session-Version: TLSv1.3

From: Mykyta Yatsenko <yatsenko@meta.com>

[ Upstream commit 8a20655749c625dcc4debdfdeeaa0cf8bb85c203 ]

Cover all three sleepable tracepoint types (tp_btf.s, raw_tp.s, tp.s)
and sys_exit (via bpf_task_pt_regs) with functional tests using
bpf_copy_from_user() on getcwd. Verify alias and bare SEC variants,
bpf_prog_test_run_raw_tp() with BPF_F_TEST_RUN_ON_CPU rejection,
attach-time rejection on non-faultable tracepoints, and load-time
rejection for sleepable tp_btf on non-faultable tracepoints.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Link: https://lore.kernel.org/bpf/20260422-sleepable_tracepoints-v13-6-99005dff21ef@meta.com
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
Hi, backporting commit 23b933c6223f ("bpf: Verifier support for sleepable
tracepoint programs") without backporting this commit breaks the selftest,
as seen in openSUSE CI:

https://openqa.opensuse.org/tests/6145723/logfile?filename=test_verifier.tap.txt#line-780
---
 .../bpf/prog_tests/sleepable_tracepoints.c         | 142 +++++++++++++++++++++
 .../bpf/progs/test_sleepable_tracepoints.c         | 112 ++++++++++++++++
 .../bpf/progs/test_sleepable_tracepoints_fail.c    |  18 +++
 tools/testing/selftests/bpf/verifier/sleepable.c   |  17 ++-
 4 files changed, 287 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sleepable_tracepoints.c b/tools/testing/selftests/bpf/prog_tests/sleepable_tracepoints.c
new file mode 100644
index 000000000000..19500b785ee3
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/sleepable_tracepoints.c
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+
+#include <test_progs.h>
+#include <unistd.h>
+#include "test_sleepable_tracepoints.skel.h"
+#include "test_sleepable_tracepoints_fail.skel.h"
+
+static void run_test(struct test_sleepable_tracepoints *skel)
+{
+	char buf[PATH_MAX] = "/";
+
+	skel->bss->target_pid = getpid();
+	skel->bss->prog_triggered = 0;
+	skel->bss->err = 0;
+	skel->bss->copied_byte = 0;
+
+	syscall(__NR_getcwd, buf, sizeof(buf));
+
+	ASSERT_EQ(skel->bss->prog_triggered, 1, "prog_triggered");
+	ASSERT_EQ(skel->bss->err, 0, "err");
+	ASSERT_EQ(skel->bss->copied_byte, '/', "copied_byte");
+}
+
+static void run_auto_attach_test(struct bpf_program *prog,
+				 struct test_sleepable_tracepoints *skel)
+{
+	struct bpf_link *link;
+
+	link = bpf_program__attach(prog);
+	if (!ASSERT_OK_PTR(link, "prog_attach"))
+		return;
+
+	run_test(skel);
+	bpf_link__destroy(link);
+}
+
+static void test_attach_only(struct bpf_program *prog)
+{
+	struct bpf_link *link;
+
+	link = bpf_program__attach(prog);
+	if (ASSERT_OK_PTR(link, "attach"))
+		bpf_link__destroy(link);
+}
+
+static void test_attach_reject(struct bpf_program *prog)
+{
+	struct bpf_link *link;
+
+	link = bpf_program__attach(prog);
+	if (!ASSERT_ERR_PTR(link, "attach_should_fail"))
+		bpf_link__destroy(link);
+}
+
+static void test_raw_tp_bare(struct test_sleepable_tracepoints *skel)
+{
+	struct bpf_link *link;
+
+	link = bpf_program__attach_raw_tracepoint(skel->progs.handle_raw_tp_bare,
+						  "sys_enter");
+	if (ASSERT_OK_PTR(link, "attach"))
+		bpf_link__destroy(link);
+}
+
+static void test_tp_bare(struct test_sleepable_tracepoints *skel)
+{
+	struct bpf_link *link;
+
+	link = bpf_program__attach_tracepoint(skel->progs.handle_tp_bare,
+					      "syscalls", "sys_enter_getcwd");
+	if (ASSERT_OK_PTR(link, "attach"))
+		bpf_link__destroy(link);
+}
+
+static void test_test_run(struct test_sleepable_tracepoints *skel)
+{
+	__u64 args[2] = {0x1234ULL, 0x5678ULL};
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.ctx_in = args,
+		.ctx_size_in = sizeof(args),
+	);
+	int fd, err;
+
+	fd = bpf_program__fd(skel->progs.handle_test_run);
+	err = bpf_prog_test_run_opts(fd, &topts);
+	ASSERT_OK(err, "test_run");
+	ASSERT_EQ(topts.retval, args[0] + args[1], "test_run_retval");
+}
+
+static void test_test_run_on_cpu_reject(struct test_sleepable_tracepoints *skel)
+{
+	__u64 args[2] = {};
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.ctx_in = args,
+		.ctx_size_in = sizeof(args),
+		.flags = BPF_F_TEST_RUN_ON_CPU,
+	);
+	int fd, err;
+
+	fd = bpf_program__fd(skel->progs.handle_test_run);
+	err = bpf_prog_test_run_opts(fd, &topts);
+	ASSERT_ERR(err, "test_run_on_cpu_reject");
+}
+
+void test_sleepable_tracepoints(void)
+{
+	struct test_sleepable_tracepoints *skel;
+
+	skel = test_sleepable_tracepoints__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	if (test__start_subtest("tp_btf"))
+		run_auto_attach_test(skel->progs.handle_sys_enter_tp_btf, skel);
+	if (test__start_subtest("raw_tp"))
+		run_auto_attach_test(skel->progs.handle_sys_enter_raw_tp, skel);
+	if (test__start_subtest("tracepoint"))
+		run_auto_attach_test(skel->progs.handle_sys_enter_tp, skel);
+	if (test__start_subtest("sys_exit"))
+		run_auto_attach_test(skel->progs.handle_sys_exit_tp, skel);
+	if (test__start_subtest("tracepoint_alias"))
+		test_attach_only(skel->progs.handle_sys_enter_tp_alias);
+	if (test__start_subtest("raw_tracepoint_alias"))
+		test_attach_only(skel->progs.handle_sys_enter_raw_tp_alias);
+	if (test__start_subtest("raw_tp_bare"))
+		test_raw_tp_bare(skel);
+	if (test__start_subtest("tp_bare"))
+		test_tp_bare(skel);
+	if (test__start_subtest("test_run"))
+		test_test_run(skel);
+	if (test__start_subtest("test_run_on_cpu_reject"))
+		test_test_run_on_cpu_reject(skel);
+	if (test__start_subtest("raw_tp_non_faultable"))
+		test_attach_reject(skel->progs.handle_raw_tp_non_faultable);
+	if (test__start_subtest("tp_non_syscall"))
+		test_attach_reject(skel->progs.handle_tp_non_syscall);
+	if (test__start_subtest("tp_btf_non_faultable_reject"))
+		RUN_TESTS(test_sleepable_tracepoints_fail);
+
+	test_sleepable_tracepoints__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_sleepable_tracepoints.c b/tools/testing/selftests/bpf/progs/test_sleepable_tracepoints.c
new file mode 100644
index 000000000000..254f7fd895d9
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_sleepable_tracepoints.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <asm/unistd.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+#include <bpf/bpf_helpers.h>
+
+char _license[] SEC("license") = "GPL";
+
+int target_pid;
+int prog_triggered;
+long err;
+char copied_byte;
+
+static int copy_getcwd_arg(char *ubuf)
+{
+	err = bpf_copy_from_user(&copied_byte, sizeof(copied_byte), ubuf);
+	if (err)
+		return err;
+
+	prog_triggered = 1;
+	return 0;
+}
+
+SEC("tp_btf.s/sys_enter")
+int BPF_PROG(handle_sys_enter_tp_btf, struct pt_regs *regs, long id)
+{
+	if ((bpf_get_current_pid_tgid() >> 32) != target_pid ||
+	    id != __NR_getcwd)
+		return 0;
+
+	return copy_getcwd_arg((void *)PT_REGS_PARM1_SYSCALL(regs));
+}
+
+SEC("raw_tp.s/sys_enter")
+int BPF_PROG(handle_sys_enter_raw_tp, struct pt_regs *regs, long id)
+{
+	if ((bpf_get_current_pid_tgid() >> 32) != target_pid ||
+	    id != __NR_getcwd)
+		return 0;
+
+	return copy_getcwd_arg((void *)PT_REGS_PARM1_CORE_SYSCALL(regs));
+}
+
+SEC("tp.s/syscalls/sys_enter_getcwd")
+int handle_sys_enter_tp(struct syscall_trace_enter *args)
+{
+	if ((bpf_get_current_pid_tgid() >> 32) != target_pid)
+		return 0;
+
+	return copy_getcwd_arg((void *)args->args[0]);
+}
+
+SEC("tp.s/syscalls/sys_exit_getcwd")
+int handle_sys_exit_tp(struct syscall_trace_exit *args)
+{
+	struct pt_regs *regs;
+
+	if ((bpf_get_current_pid_tgid() >> 32) != target_pid)
+		return 0;
+
+	regs = (struct pt_regs *)bpf_task_pt_regs(bpf_get_current_task_btf());
+	return copy_getcwd_arg((void *)PT_REGS_PARM1_CORE_SYSCALL(regs));
+}
+
+SEC("raw_tp.s")
+int BPF_PROG(handle_raw_tp_bare, struct pt_regs *regs, long id)
+{
+	return 0;
+}
+
+SEC("tp.s")
+int handle_tp_bare(void *ctx)
+{
+	return 0;
+}
+
+SEC("tracepoint.s/syscalls/sys_enter_getcwd")
+int handle_sys_enter_tp_alias(struct syscall_trace_enter *args)
+{
+	return 0;
+}
+
+SEC("raw_tracepoint.s/sys_enter")
+int BPF_PROG(handle_sys_enter_raw_tp_alias, struct pt_regs *regs, long id)
+{
+	return 0;
+}
+
+SEC("raw_tp.s/sys_enter")
+int BPF_PROG(handle_test_run, struct pt_regs *regs, long id)
+{
+	if ((__u64)regs == 0x1234ULL && (__u64)id == 0x5678ULL)
+		return (__u64)regs + (__u64)id;
+
+	return 0;
+}
+
+SEC("raw_tp.s/sched_switch")
+int BPF_PROG(handle_raw_tp_non_faultable, bool preempt,
+	     struct task_struct *prev, struct task_struct *next)
+{
+	return 0;
+}
+
+SEC("tp.s/sched/sched_switch")
+int handle_tp_non_syscall(void *ctx)
+{
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/test_sleepable_tracepoints_fail.c b/tools/testing/selftests/bpf/progs/test_sleepable_tracepoints_fail.c
new file mode 100644
index 000000000000..1a0748a9520b
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_sleepable_tracepoints_fail.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+/* Sleepable program on a non-faultable tracepoint should fail to load */
+SEC("tp_btf.s/sched_switch")
+__failure __msg("Sleepable program cannot attach to non-faultable tracepoint")
+int BPF_PROG(handle_sched_switch, bool preempt,
+	     struct task_struct *prev, struct task_struct *next)
+{
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/verifier/sleepable.c b/tools/testing/selftests/bpf/verifier/sleepable.c
index c2b7f5ebf168..6dabc5522945 100644
--- a/tools/testing/selftests/bpf/verifier/sleepable.c
+++ b/tools/testing/selftests/bpf/verifier/sleepable.c
@@ -76,7 +76,20 @@
 	.runs = -1,
 },
 {
-	"sleepable raw tracepoint reject",
+	"sleepable raw tracepoint accept",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_TRACING,
+	.expected_attach_type = BPF_TRACE_RAW_TP,
+	.kfunc = "sys_enter",
+	.result = ACCEPT,
+	.flags = BPF_F_SLEEPABLE,
+	.runs = -1,
+},
+{
+	"sleepable raw tracepoint reject non-faultable",
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -85,7 +98,7 @@
 	.expected_attach_type = BPF_TRACE_RAW_TP,
 	.kfunc = "sched_switch",
 	.result = REJECT,
-	.errstr = "Only fentry/fexit/fsession/fmod_ret, lsm, iter, uprobe, and struct_ops programs can be sleepable",
+	.errstr = "Sleepable program cannot attach to non-faultable tracepoint",
 	.flags = BPF_F_SLEEPABLE,
 	.runs = -1,
 },

---
base-commit: c7d419828268d5f3e52b74506d074955ad8c01d1
change-id: 20260803-selftests-bpf-sleepable-eebf2d962201

Best regards,
--  
Ricardo B. Marlière (SUSE) <ricardo@marliere.net>

