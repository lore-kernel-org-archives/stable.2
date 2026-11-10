Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794287799;
	b=fvOdMPPn485HBI7t5oY6bsqCe5QvOXWXsMJjfKqn4Y9niMAKE3YlgknYcQgQwH3AESm6
	 SKwJoac1/lyEf+y9Oef8kQFtHBvfTI80qLcAYXqAlDgQ6zzYzt14ASMOPTsN0yyptmyal
	 bDC7F9aT1u6fF++DyeLshJmBIMJgPGInx21eY5yxCG5hXtHQdOJ6zPcKwcaWszQsyugw5
	 7CRniK0xlSP1LTBaoLg4Lmv18TuB3akqEoLSuXBa75E+N82G667qwuwlw3+RyQLRGKsyg
	 +UUh5uNM4s1ILubtFzlF2l55UGzn6znioo3hohP+tvms2/KM1SoZnQuTZoF3GRtDFfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794287799;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qGHhiDY3Ex78ujp/CSizoosU96qjcE/fIED99T0APEQ=;
	b=YNuQc6HcqkChN+XjD0rmttPoqJf3x3goLeIOi0+gtUX9Q3+yXt15ABV8oM52hoqZ/MzG
	 OXB16t6Yjaco2Ml58oGPCsLYbaUoxIErqdRjnOpM0mV7l1iPLTh7bvZezDsoh9ZeLY+0+
	 YkEoHTzPnwtezEnHyDRkOWnQC+U26qA8E5G6ewpsV0H/E6iGoEkQL2mEk+xKFXdyzqTbf
	 a2/z7iGqBXdIFi9zwo+LKEBfiOGoTGLqoxuKV33MHJW7VOlKqJTyE0IoQEARMqCTkgzvo
	 ImKDCzRWPrnO/m49meGl3gpE3NIMEhY2cV3URrBCM2IKof4M7dejeRfih1tnj+UObJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SfhEEWY3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1186F606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 05:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SfhEEWY3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 021DB1F0089F;
	Tue, 10 Nov 2026 05:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794287798;
	bh=qGHhiDY3Ex78ujp/CSizoosU96qjcE/fIED99T0APEQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SfhEEWY3GFiC4/QLMU6e+sASQZb+tAMIN/Nhiv5rIQ6J5lRw9v+5m0ou8CeO6hl3g
	 rxEl3VzaOtTLSiClH2X0cE5ENBaQ1dL407iNpIvsEfpJCZwg8hd/S08tWG8NPsItc3
	 qNzNTklNvgph8UhL4S4kZNwVqDoLFQfJ4qnjDUDYeiOrYVkNgnbmfu96Es3k7wCg2z
	 RtLhSvTqWSQAiujmXcaaCdrUtcy9q8PuuYMOALyeZTbPqiHVCDLLHfdd3x4KPB+HvT
	 N7Ta9ZzDnxHwhlLF2Bztbz1Ghu4K0tFyZ7ZiwjIydexu8iWK/57HoRo43zz5/b90rq
	 jI2faqVnF+IMg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andrei Vagin <avagin@google.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Kees Cook <keescook@chromium.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] selftest/seccomp: add a new test for the sync mode of seccomp_user_notify
Date: Tue, 10 Nov 2026 00:16:35 -0500
Message-ID: <20261110051630.440456-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054224-failed-6.1-832b9b176be0@kernel.org>
References: <20261107054224-failed-6.1-832b9b176be0@kernel.org>
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
index b054bfef0f4f2..daf8e2872a9cb 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -4246,6 +4246,61 @@ TEST(user_notification_addfd_rlimit)
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

