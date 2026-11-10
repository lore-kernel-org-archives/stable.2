Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794288199;
	b=tV51hvgVbZeWdHesB80x6qMA028OUTQT1uKerc4nurh3hTXK5+STZTTelSDudyIGXo/m
	 zIIfQ97XXwS5tptiYSC8Yl4/12PIXXxLNbG0QHLOD8NXSE8zAwnGgGQwdlw+mFG8PVfOe
	 a+oJvxWB+LcnLfs5lpX7CAb3g3euxKM9vJm+CdvdE+VlAnJYAE0OPg8PptlKng909r4qP
	 Tr+smRtE4rQqCwohgDbLVYbH8YKrq+h+2mKkFph65OA6SNXJ5OJnUJyg5cPvs44n5WQr6
	 2TOoB3D/+Qqrj1EnSktFvJMDXuBwySjTv5xUGt6yv/N1Iqr+RbTJcl618Ao4bacuDpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794288199;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=O0kQk/jQVqjTsiS1JQFYHD/JlNmgnCuQcuR8anwS53Y=;
	b=k9OnB+cwIJHXuYzmhFipjQZcE45q/oV/+1Y5/3hwwD0muWxoaibR1psv2BlbfIznsH2o
	 KGGxRjGFmF4v35wqKpNGonjGAbWN/85vOFkVb3JLWgYh907cNle5OTLTHcdwpI4SP16Vn
	 z7ataWqNiU1XLJfJzJ5Gcl1rjKK/78I4G0ZkXsAm+dyKFpElg/rKhtjpsYD1Vw00MqbLg
	 VAZoqhp5xZSDxpjaY0k7yAzJCoL80skHPkZm2LHxB2IS1VyYpf71nt+L/P8gwcbQn/dij
	 5uKkjzWp8501Bns+UcvmBnDVGAh7PXQiUEKm2YSSjtr6PN6qgnXXabEvIDXdTVe9W1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W935smPL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A333606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 05:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W935smPL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49B3E1F008A5;
	Tue, 10 Nov 2026 05:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794288198;
	bh=O0kQk/jQVqjTsiS1JQFYHD/JlNmgnCuQcuR8anwS53Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W935smPLcv0ra+cWnl0W+mPob+Y9LdGVkgP57zlSUUJCh43x0JhvurUyIgkFmlwd8
	 IVCetUbFiBlXF+6R6+Rl8bZpEdrNbiGtG/7zPnmNhFml2obTO5fXwQkB0gHRU5pBNA
	 SjeX1tMsulDBsspKNZyQ5iwNbG69ZUd11kv8Moi8FYcNWhnI7HVlzr3IjUmXKm4pd9
	 rkeTgYEoF9cAHrHA69E82u2yYAzDLS4kSMG7S9OfpsgidRM+3pgzCdmLo1KQ07htXc
	 +tccKe0ecs+3janBmtjDCXv7MkK9IHQPVAPyX99TC2qZW8Qky1ZjEAtRwZJhvkWRxQ
	 Zqe1GtWvvf8hg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jann Horn <jannh@google.com>,
	Kees Cook <keescook@chromium.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/3] selftests/seccomp: Test PTRACE_O_SUSPEND_SECCOMP without CAP_SYS_ADMIN
Date: Tue, 10 Nov 2026 00:23:15 -0500
Message-ID: <20261110052309.446865-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055933-failed-5.15-832b9b176be0@kernel.org>
References: <20261107055933-failed-5.15-832b9b176be0@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jann Horn <jannh@google.com>

[ Upstream commit d250a3e4e5b41d9d805a8bfd2458b548d1681742 ]

Add a test to check that PTRACE_O_SUSPEND_SECCOMP can't be set without
CAP_SYS_ADMIN through PTRACE_SEIZE or PTRACE_SETOPTIONS.

Signed-off-by: Jann Horn <jannh@google.com>
Co-developed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
Stable-dep-of: 832b9b176be0 ("seccomp: restore knotif->state when SECCOMP_ADDFD_FLAG_SEND is interrupted")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/seccomp/Makefile      |  1 +
 tools/testing/selftests/seccomp/seccomp_bpf.c | 63 +++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/tools/testing/selftests/seccomp/Makefile b/tools/testing/selftests/seccomp/Makefile
index 585f7a0c10cbe..f017c382c0369 100644
--- a/tools/testing/selftests/seccomp/Makefile
+++ b/tools/testing/selftests/seccomp/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 CFLAGS += -Wl,-no-as-needed -Wall -isystem ../../../../usr/include/
 LDFLAGS += -lpthread
+LDLIBS += -lcap
 
 TEST_GEN_PROGS := seccomp_bpf seccomp_benchmark
 include ../lib.mk
diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index c1da445ab4db9..35c84bc2e5055 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -46,6 +46,7 @@
 #include <sys/ioctl.h>
 #include <linux/kcmp.h>
 #include <sys/resource.h>
+#include <sys/capability.h>
 
 #include <unistd.h>
 #include <sys/syscall.h>
@@ -4190,6 +4191,68 @@ TEST(user_notification_addfd_rlimit)
 	close(memfd);
 }
 
+/* Make sure PTRACE_O_SUSPEND_SECCOMP requires CAP_SYS_ADMIN. */
+FIXTURE(O_SUSPEND_SECCOMP) {
+	pid_t pid;
+};
+
+FIXTURE_SETUP(O_SUSPEND_SECCOMP)
+{
+	ERRNO_FILTER(block_read, E2BIG);
+	cap_value_t cap_list[] = { CAP_SYS_ADMIN };
+	cap_t caps;
+
+	self->pid = 0;
+
+	/* make sure we don't have CAP_SYS_ADMIN */
+	caps = cap_get_proc();
+	ASSERT_NE(NULL, caps);
+	ASSERT_EQ(0, cap_set_flag(caps, CAP_EFFECTIVE, 1, cap_list, CAP_CLEAR));
+	ASSERT_EQ(0, cap_set_proc(caps));
+	cap_free(caps);
+
+	ASSERT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0));
+	ASSERT_EQ(0, prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &prog_block_read));
+
+	self->pid = fork();
+	ASSERT_GE(self->pid, 0);
+
+	if (self->pid == 0) {
+		while (1)
+			pause();
+		_exit(127);
+	}
+}
+
+FIXTURE_TEARDOWN(O_SUSPEND_SECCOMP)
+{
+	if (self->pid)
+		kill(self->pid, SIGKILL);
+}
+
+TEST_F(O_SUSPEND_SECCOMP, setoptions)
+{
+	int wstatus;
+
+	ASSERT_EQ(0, ptrace(PTRACE_ATTACH, self->pid, NULL, 0));
+	ASSERT_EQ(self->pid, wait(&wstatus));
+	ASSERT_EQ(-1, ptrace(PTRACE_SETOPTIONS, self->pid, NULL, PTRACE_O_SUSPEND_SECCOMP));
+	if (errno == EINVAL)
+		SKIP(return, "Kernel does not support PTRACE_O_SUSPEND_SECCOMP (missing CONFIG_CHECKPOINT_RESTORE?)");
+	ASSERT_EQ(EPERM, errno);
+}
+
+TEST_F(O_SUSPEND_SECCOMP, seize)
+{
+	int ret;
+
+	ret = ptrace(PTRACE_SEIZE, self->pid, NULL, PTRACE_O_SUSPEND_SECCOMP);
+	ASSERT_EQ(-1, ret);
+	if (errno == EINVAL)
+		SKIP(return, "Kernel does not support PTRACE_O_SUSPEND_SECCOMP (missing CONFIG_CHECKPOINT_RESTORE?)");
+	ASSERT_EQ(EPERM, errno);
+}
+
 /*
  * TODO:
  * - expand NNP testing
-- 
2.53.0

