Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794288200;
	b=oPqNLSUsYh49qX+rF+EHYvFbTczCk5G/lxEfTVrBWiEFMfajVbuLTq/b9UjQhapzxMKX
	 QjVcF/3Wn2l5rzaj6cmMvzDqrgdXx3txPkCR/F6vBCa+aCQD31wdUTNsj803WDVBhbcTk
	 ZtFnmimqQ9eFNS7GgVJJBC4g1gqU3XlYb7yYUsF8ilC5ljksn72f0hVDOes6tOb5PcdTX
	 JFyWUzIezLTf9jJYWG4kJjpuyHHpNY+6X4h01m1jA7nOh39mX0lZPsmW+70arViQAlWaN
	 ngGjr2pXadXqD6himwPE18LijQquvX9E0jhIAOKl48TjBqhMLP2VOgKvg2ex/N6tp2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794288200;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=pSAiwwrrpUPeX203g1wEvE60jBtUZDlPkiRPQ5OsvZE=;
	b=qWplou7jdJAWl2d0ZLIdJSNYVP6jRq03XccNQN1q6ATS+NlEVpbmKF9yRdmbZB4hDjSq
	 6wPBvyK1kLtThRjytCNRYO9R/dd6TBlp0DGykr+57HQ624c048/736OHrc8ADOaTGfPc8
	 Q5Vm9RiPTCFmkEQqPBeE7UyuMt0sz8qEcHeYqxV4oPl8zMFsyJzhItupi+tK2ADTe+WKi
	 P0aOaxGlZflAPJxOxXSbIFEBg0GjGI507SN8YHNyt4HJ3ofcyfTI9vQ6wZ43MJCb0KDkK
	 JJ0Nwoa0EWALfrTp6srEUN7+jtz+MkTm1/L+DfUlcrQmgO+lUdCAlk3Xs0Xm+9zw9EQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eaP3Ol+0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7002606A32A
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 05:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eaP3Ol+0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B5AA1F008A1;
	Tue, 10 Nov 2026 05:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794288199;
	bh=pSAiwwrrpUPeX203g1wEvE60jBtUZDlPkiRPQ5OsvZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eaP3Ol+0ZGUTH4YzbDJTYGw6MHt8NzG4ZAdvNuf06JHSZ2iVN3CdYHbchWCQudZ3Q
	 9UCZ9XLr8W7jqWkW93n3CIZhbbt5JAX/zEgzPLRfpfgW+3OsmjIaWaEHIgf98P8xAP
	 Xl1F4P1HwnY4fpFakNgUg9EIiO5EfRM1faJkmqQThoaBdFQZmgspXjF+vHBS1ZZpS2
	 NUWKxUl8TDVxY3T6W7jI7ASn4Eo3sC4azl/FuARgr3fCzgYVVwZIUBhLH6FKmRrd8/
	 9ec8yDoQX43fsvaHtZJdTptt38QVBpDFjUTzfo+7nTUMT5OkI2cJpM3rIbcQ4lX1mJ
	 46RZkgdKaBWvg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andrei Vagin <avagin@google.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Kees Cook <keescook@chromium.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/3] selftest/seccomp: add a new test for the sync mode of seccomp_user_notify
Date: Tue, 10 Nov 2026 00:23:16 -0500
Message-ID: <20261110052309.446865-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110052309.446865-1-sashal@kernel.org>
References: <20261107055933-failed-5.15-832b9b176be0@kernel.org>
 <20261110052309.446865-1-sashal@kernel.org>
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

From: Andrei Vagin <avagin@google.com>

[ Upstream commit 8feae5adec17ec190118ad84da84a6ad9fa3e30b ]

Test output:
 #  RUN           global.user_notification_sync ...
 #            OK  global.user_notification_sync
 ok 51 global.user_notification_sync

Signed-off-by: Andrei Vagin <avagin@google.com>
Acked-by: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230308073201.3102738-6-avagin@google.com
Signed-off-by: Kees Cook <keescook@chromium.org>
Stable-dep-of: 832b9b176be0 ("seccomp: restore knotif->state when SECCOMP_ADDFD_FLAG_SEND is interrupted")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 35c84bc2e5055..cf53b982d8513 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -4191,6 +4191,61 @@ TEST(user_notification_addfd_rlimit)
 	close(memfd);
 }
 
+#ifndef SECCOMP_USER_NOTIF_FD_SYNC_WAKE_UP
+#define SECCOMP_USER_NOTIF_FD_SYNC_WAKE_UP (1UL << 0)
+#define SECCOMP_IOCTL_NOTIF_SET_FLAGS  SECCOMP_IOW(4, __u64)
+#endif
+
+TEST(user_notification_sync)
+{
+	struct seccomp_notif req = {};
+	struct seccomp_notif_resp resp = {};
+	int status, listener;
+	pid_t pid;
+	long ret;
+
+	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
+	}
+
+	listener = user_notif_syscall(__NR_getppid,
+				      SECCOMP_FILTER_FLAG_NEW_LISTENER);
+	ASSERT_GE(listener, 0);
+
+	/* Try to set invalid flags. */
+	EXPECT_SYSCALL_RETURN(-EINVAL,
+		ioctl(listener, SECCOMP_IOCTL_NOTIF_SET_FLAGS, 0xffffffff, 0));
+
+	ASSERT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_SET_FLAGS,
+			SECCOMP_USER_NOTIF_FD_SYNC_WAKE_UP, 0), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0) {
+		ret = syscall(__NR_getppid);
+		ASSERT_EQ(ret, USER_NOTIF_MAGIC) {
+			_exit(1);
+		}
+		_exit(0);
+	}
+
+	req.pid = 0;
+	ASSERT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, &req), 0);
+
+	ASSERT_EQ(req.data.nr,  __NR_getppid);
+
+	resp.id = req.id;
+	resp.error = 0;
+	resp.val = USER_NOTIF_MAGIC;
+	resp.flags = 0;
+	ASSERT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_SEND, &resp), 0);
+
+	ASSERT_EQ(waitpid(pid, &status, 0), pid);
+	ASSERT_EQ(status, 0);
+}
+
+
 /* Make sure PTRACE_O_SUSPEND_SECCOMP requires CAP_SYS_ADMIN. */
 FIXTURE(O_SUSPEND_SECCOMP) {
 	pid_t pid;
-- 
2.53.0

