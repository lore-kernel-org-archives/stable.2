Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434451;
	b=dAz7THT1XyAQY69MD9Ko7N/6VF+Hfyj6/Yx0SKnhql7q7bm4gDILKUEZTMMpp+yg/Xx2
	 J0BEKs355BKCIBe2N2moGx7yyRzGLQRTTOHtpODwfZ1NbYhW52+MFwGUX7TkXNeION3uM
	 //6fjqyz9ydPTcP/7R2T4uFqKP1Nxx9i7fgPsOmG/qAkrXrfWnj5QZTSEbWvUgxNj47n3
	 6Hb2HeFgAJbYqOsgY4s2sf9whrSv5jWTfAoOntbgLFY1Blp0dEevv7YNDG3A1MF5Nn/zf
	 3R86qupfo3RiQDG2QxeBZmw7WstwFheJJQv/Giv32mZ++qA72NUxjTJLKBoUBhQ1kCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434451;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=WwlyXVZcHRn1gRhmBn9v2fXObx/eZh35N+VTj/JaUg4=;
	b=es6b9h17heFQ+Mv5j/xux+it6IaGKdxwfNw7FH9yKWNZFeqDjUxAeWgRwATT1L2F4JWn
	 b0u87hV1zn4CFy6/JqxzcycRP3aDTHEOVimegjGJe7iWDIAAMcuXMoonh04Bj+DCGPkUe
	 RW5D9+jjoMF4125Dg6gY/fNXSNcwP1UMpX4ET8M1LQc8YtWWoAx7qRbdHnJiHxaJWQLQd
	 6wr5ys5VJ9d6+5LJMz6ouOyFAbgTpsic2O4VKqWEId4DDrlHayuf/zOm7YNAXJRn76HeD
	 paATPH5j6g+R9M58AtcGXUBY7gNd53ppkj3aCNNzzkdmCwuyouruPEf4l9PLeH6D3Hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a8Att1la;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396E8606A327
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 22:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a8Att1la
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 990B71F00A05;
	Wed, 11 Nov 2026 22:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794434451;
	bh=WwlyXVZcHRn1gRhmBn9v2fXObx/eZh35N+VTj/JaUg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a8Att1la/lDEwNjVuj+ICgXZOYjlkmEKlqc3pIxj87J66McQ6GewjsKPbKnhUfVei
	 xlk/3zCUZwfRL9XwiZGTi8/wvZL+CQjLjMzy4ybBb+HyFfqF2Vo5uXSCbkzBx39ogA
	 Yr1ASLWg/jYNj1E/84n+msLB1WlG8Lx5EzYvbbrKJIlpGFi6Fk5AwsE/Wg7dxraPE/
	 IjMY+Y9shhvWJNbz02dM5Lg2tgPnBHBM3dTBJ9iGU3uOdSwfrWSNwBkKQk3umqQHPz
	 JItkjE81eS8uIk/y7YkS3hxLB42LOgZFuo2Zmu5qVnwbmnJNT3iasMrWpv5kHAUW5p
	 zw48w4vau+jxg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] selftests:core: test coverage for dup_fd() failure handling in unshare_fd()
Date: Wed, 11 Nov 2026 17:00:48 -0500
Message-ID: <20261111220033.4083453-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053213-failed-6.6-df0b7e0ea59c@kernel.org>
References: <20261107053213-failed-6.6-df0b7e0ea59c@kernel.org>
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

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit 611fbeb44a777e5ab54ab3127ec85f72147911d8 ]

At some point there'd been a dumb braino during the dup_fd()
calling conventions change; caught by smatch and immediately fixed.
The trouble is, there had been no test coverage for the dup_fd() failure
handling - neither in kselftests nor in LTP.  Fortunately, it can be
triggered on stock kernel - ENOMEM would require fault injection, but
EMFILE can be had with sysctl alone (fs.nr_open).

Add a test for dup_fd() failure.
Fixed up commit log and short log - Shuah Khan

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Stable-dep-of: df0b7e0ea59c ("selftests/core: fix unshare_test with large fs.nr_open")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/core/Makefile       |  2 +-
 tools/testing/selftests/core/unshare_test.c | 94 +++++++++++++++++++++
 2 files changed, 95 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/core/unshare_test.c

diff --git a/tools/testing/selftests/core/Makefile b/tools/testing/selftests/core/Makefile
index ce262d0972699..8e99f87f5d7c2 100644
--- a/tools/testing/selftests/core/Makefile
+++ b/tools/testing/selftests/core/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 CFLAGS += -g $(KHDR_INCLUDES)
 
-TEST_GEN_PROGS := close_range_test
+TEST_GEN_PROGS := close_range_test unshare_test
 
 include ../lib.mk
 
diff --git a/tools/testing/selftests/core/unshare_test.c b/tools/testing/selftests/core/unshare_test.c
new file mode 100644
index 0000000000000..7fec9dfb1b0e3
--- /dev/null
+++ b/tools/testing/selftests/core/unshare_test.c
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <linux/kernel.h>
+#include <limits.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <syscall.h>
+#include <unistd.h>
+#include <sys/resource.h>
+#include <linux/close_range.h>
+
+#include "../kselftest_harness.h"
+#include "../clone3/clone3_selftests.h"
+
+TEST(unshare_EMFILE)
+{
+	pid_t pid;
+	int status;
+	struct __clone_args args = {
+		.flags = CLONE_FILES,
+		.exit_signal = SIGCHLD,
+	};
+	int fd;
+	ssize_t n, n2;
+	static char buf[512], buf2[512];
+	struct rlimit rlimit;
+	int nr_open;
+
+	fd = open("/proc/sys/fs/nr_open", O_RDWR);
+	ASSERT_GE(fd, 0);
+
+	n = read(fd, buf, sizeof(buf));
+	ASSERT_GT(n, 0);
+	ASSERT_EQ(buf[n - 1], '\n');
+
+	ASSERT_EQ(sscanf(buf, "%d", &nr_open), 1);
+
+	ASSERT_EQ(0, getrlimit(RLIMIT_NOFILE, &rlimit));
+
+	/* bump fs.nr_open */
+	n2 = sprintf(buf2, "%d\n", nr_open + 1024);
+	lseek(fd, 0, SEEK_SET);
+	write(fd, buf2, n2);
+
+	/* bump ulimit -n */
+	rlimit.rlim_cur = nr_open + 1024;
+	rlimit.rlim_max = nr_open + 1024;
+	EXPECT_EQ(0, setrlimit(RLIMIT_NOFILE, &rlimit)) {
+		lseek(fd, 0, SEEK_SET);
+		write(fd, buf, n);
+		exit(EXIT_FAILURE);
+	}
+
+	/* get a descriptor past the old fs.nr_open */
+	EXPECT_GE(dup2(2, nr_open + 64), 0) {
+		lseek(fd, 0, SEEK_SET);
+		write(fd, buf, n);
+		exit(EXIT_FAILURE);
+	}
+
+	/* get descriptor table shared */
+	pid = sys_clone3(&args, sizeof(args));
+	EXPECT_GE(pid, 0) {
+		lseek(fd, 0, SEEK_SET);
+		write(fd, buf, n);
+		exit(EXIT_FAILURE);
+	}
+
+	if (pid == 0) {
+		int err;
+
+		/* restore fs.nr_open */
+		lseek(fd, 0, SEEK_SET);
+		write(fd, buf, n);
+		/* ... and now unshare(CLONE_FILES) must fail with EMFILE */
+		err = unshare(CLONE_FILES);
+		EXPECT_EQ(err, -1)
+			exit(EXIT_FAILURE);
+		EXPECT_EQ(errno, EMFILE)
+			exit(EXIT_FAILURE);
+		exit(EXIT_SUCCESS);
+	}
+
+	EXPECT_EQ(waitpid(pid, &status, 0), pid);
+	EXPECT_EQ(true, WIFEXITED(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
+}
+
+TEST_HARNESS_MAIN
-- 
2.53.0

