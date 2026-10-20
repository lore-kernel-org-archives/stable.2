Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493446;
	b=AJ5K/YOMv6etn3iWe8SUmAEk1xk173cdQLcIWPEYCjoL0Q94gaxPNZKgWgOE5+sms2YL
	 9es4IqReqYvGvjvZ5b6VaOYVc06KoQPCYskOeSJp/JYpwcZzLo/p3+KJHpUiLOtAtPlVJ
	 nI4uBk1DdvNuX1U3Uwhde9vKHrq8bfpwLA4Zb92li7+iProapnvoezuWLTgE7zTODqhYX
	 r5LTEYd9o4xWciHPnob4lfh1d6HPyzpnd4ZhD97BhtNM7JU7u5zJChyk4M6e65KfInLkJ
	 U76L7Xh1MHsCW6FPDqykRtBsSW1zF5N87HfOZL/wKzVHk2vnyjxPE9RpSjpQ5XDRCNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493446;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ijPSVZtN0wV/FObkbQ5coj1GUsZLgW/HlOlDTeZNmFI=;
	b=S5/iTMXRT4LOwkbF1ypaWAQnQNVoggx0QmwLGPMEyXkMVMo9CX+O/Upf3dqo9fvw7S5/
	 cMG/OLCwmqlybfGd991LsYCi3a7Unfu45S2aUX4s3wqXmbzqeqGrpMc3+r1/aGQMdAHls
	 Xpq2/XkIWNETSSDehvXgXyoBKmtQBP+/4r+2n3iF4fHwIG08FY2gpUZGQxP5RmyLh+Hzg
	 eC5H+thuN3mRj9/fGzdNZg4UwvZo/DCeaSHkIC0hSpF/miMfXFT6MTpZBwt9IIL3GySdR
	 vbCPgtrDFWh47qse1yT/OmqdxVdLCVTa49ftnI7bH0lA57MhCu+2tTcpTC7AHlb/qCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bobrowski.net;
	spf=pass smtp.mailfrom=bobrowski.net;
	dkim=pass header.d=bobrowski.net header.i=@bobrowski.net header.a=rsa-sha256 header.s=google header.b=CpFjF7HH;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C1B606A31B
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 10:50:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8C1B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bobrowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bobrowski.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bobrowski.net header.i=@bobrowski.net header.a=rsa-sha256 header.s=google header.b=CpFjF7HH
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3a4b3ac8fb7so1677156a91.0
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 03:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bobrowski.net; s=google; t=1792493445; x=1793098245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ijPSVZtN0wV/FObkbQ5coj1GUsZLgW/HlOlDTeZNmFI=;
        b=CpFjF7HHjiBPEyxhDRihQ3nc60Cyw7biDO8DewrQJDjFdKjSR2q77jdcI1CmwnPdMZ
         o4ylYaenRJ0i0c2ZUC37IwuqhT1jiKsZg0pxehLaIZdv3mEKzVRbkM3sLlY5gimJvxgz
         hFrpy4bSAjXp2Ej4If0TH7VypNFaIOAUlKAk8IXr3sQMpNZ0OMq6UTYk+GK3l4acuY2r
         D6wCZ7JWOXgS45XELV+UcEMeFsCo296qi5jaHfg8fWnqpwj6x0SZb8deUrJ10uat0gm7
         8ehHCsjjtnf22GSXcc5xYv6kU7rudfhKMJlroNQb861zFTQbpmk0cC293LYzjq9zUOnd
         wSBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792493445; x=1793098245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ijPSVZtN0wV/FObkbQ5coj1GUsZLgW/HlOlDTeZNmFI=;
        b=1iB+Tn+Kr2L7De6OrbDJXpbhg9rFCjwNrEwK6daH/3PO2HJxWJMcHVoOFK6FL+fOdn
         9y9hCaZlP1MCXDWbk78yoiBOlV3Zqv9/lyU2q7Kc7ip8wpzJNF9qlEUtij9sRGK7TdHT
         +alOuToABqYKzDu7046okHupQk/5pjOjdSB7bZoT4+Ltrf1+rHJJ1vOQ4zAGtBVGVUbD
         SmVgsseXCafIHM7vpxBaq7nar8YUoC56z2W+se+QWu18fAs4S6Tip8kXzRMSOLetOdbZ
         W9Dnr7gBE5v9d4pvTahB9hvFOCOiyZmEkOS+km2c1q9RGHrU4+6z/2yofQ5FHj1q2NC2
         c5KQ==
X-Forwarded-Encrypted: i=1; AKwUvBxo2eK+oqIbrIaQvjinmZWQSvYKtvISFqR+B6UmpFBNVCRWp2hdeBAy4VHTHng/3kpq/ww5rwY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKaP1KV8QeoJs0QfGkYLMyMt3Cl+Y/ymALzypOs4mRW3KgHVQa3
	4P2iDfPfXbO52CRjv7QBxfnhSFhSMxpWS0khiM8YIDc9Rzw/BTlPm2AD8JAxctujh1Q2
X-Gm-Gg: AYBFou2T0iogbufmn9hwQrKTUeG0v5ecqmq24fHnIXI5+EIInlFIvpVOJ0Yx2VU6vs+
	5gzp/hXZ/DFK/BpSg64sUaNXgZ1RKtwkLS7QZMftzEG075s4YCJZQ6AfDkgdan6JV3RKZBe4gIW
	087Nyfjw5Ek4hO/RnyLH5olCacMYVHLSOfbdZQkdWoDmYMSqGBNrFnkN43oXpOl3SGsmyzI55c5
	l1TQAzEUlXlAk/VJbdBGTjn2GeQMw8YtjD5qjlC3RNFLmPpw07s+4r16ECOe7baCB24XohwKxCy
	YRj6wMdFuKlnQ71H+TGTlNeoZprhygl7rBPCMItzvSwzNIN654G9Vj6q/OyfpdNUHYRX2L5jbmz
	gDuD0zBL/u3bGxAXHSt6csXtJE21vZPs3r4sBKfTh7dohdP1t8uPyAAbNlKMlTTveYbezgCQaZ7
	tyeUa45j6pNFOqhFPCs0Iag02Yp6qLKtbIFggEv02Yw0tmC/Zq6u4HzE79tnLj6eyp77cSkyKgl
	jiUVclGrJWZ81OwM0SWY5i3R5v59xEp5+lxVv6iNxW5aQ==
X-Received: by 2002:a17:90b:5743:b0:3ac:9d14:feb2 with SMTP id 98e67ed59e1d1-3acef14fe3bmr8737797a91.35.1792493445059;
        Tue, 20 Oct 2026 03:50:45 -0700 (PDT)
Received: from workstation.. (163-53-146-70.ip4.superloop.au. [163.53.146.70])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad60f36a5asm3487902a91.9.2026.10.20.03.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 03:50:44 -0700 (PDT)
From: Matt Bobrowski <matt@bobrowski.net>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Matt Bobrowski <matt@bobrowski.net>,
	stable@vger.kernel.org
Subject: [PATCH bpf-next 2/2] selftests/bpf: test bpf_path_d_path() on a file released at task exit
Date: Tue, 20 Oct 2026 21:50:14 +1100
Message-ID: <20261020105014.97985-3-matt@bobrowski.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261020105014.97985-1-matt@bobrowski.net>
References: <20261020105014.97985-1-matt@bobrowski.net>
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

Add a fs_kfuncs subtest for the crash fixed by the previous commit. A
child opens a file and exits without closing it, so exit_files() drops
the last reference and the file is released from exit_task_work(),
after exit_fs() has cleared the task's fs. A file_release program calls
bpf_path_d_path() on that release, matched by the file's inode number,
and records what it returned.

Without the fix the subtest crashes the kernel in d_path(). With it,
bpf_path_d_path() returns -EINVAL.

Fixes: d08e2045ebf0 ("bpf: introduce new VFS based BPF kfuncs")
Cc: stable@vger.kernel.org
Signed-off-by: Matt Bobrowski <matt@bobrowski.net>
---
 .../selftests/bpf/prog_tests/fs_kfuncs.c      | 51 +++++++++++++++++++
 .../selftests/bpf/progs/test_path_d_path.c    | 35 +++++++++++++
 2 files changed, 86 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/test_path_d_path.c

diff --git a/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c b/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
index 43a26ec69a8e..510cf11c8bd8 100644
--- a/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
+++ b/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
@@ -4,12 +4,15 @@
 #include <stdlib.h>
 #include <sys/types.h>
 #include <sys/xattr.h>
+#include <sys/stat.h>
+#include <sys/wait.h>
 #include <linux/fsverity.h>
 #include <unistd.h>
 #include <test_progs.h>
 #include "test_get_xattr.skel.h"
 #include "test_set_remove_xattr.skel.h"
 #include "test_fsverity.skel.h"
+#include "test_path_d_path.skel.h"
 
 static const char testfile[] = "/tmp/test_progs_fs_kfuncs";
 
@@ -268,6 +271,51 @@ static void test_fsverity(void)
 	remove(testfile);
 }
 
+static void test_path_d_path_on_exit(void)
+{
+	struct test_path_d_path *skel = NULL;
+	struct stat st;
+	int fd, status;
+	pid_t pid;
+
+	fd = open(testfile, O_CREAT | O_RDONLY, 0644);
+	if (!ASSERT_GE(fd, 0, "create_file"))
+		return;
+	close(fd);
+
+	if (!ASSERT_OK(stat(testfile, &st), "stat"))
+		goto out;
+
+	skel = test_path_d_path__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "test_path_d_path__open_and_load"))
+		goto out;
+
+	skel->bss->monitored_ino = st.st_ino;
+
+	if (!ASSERT_OK(test_path_d_path__attach(skel), "test_path_d_path__attach"))
+		goto out;
+
+	/*
+	 * The child exits with testfile still open, so exit_files() drops
+	 * the last reference and the file is released from exit_task_work(),
+	 * after exit_fs().
+	 */
+	pid = fork();
+	if (!ASSERT_GE(pid, 0, "fork"))
+		goto out;
+	if (pid == 0)
+		_exit(open(testfile, O_RDONLY) < 0);
+
+	if (!ASSERT_EQ(waitpid(pid, &status, 0), pid, "waitpid"))
+		goto out;
+	ASSERT_TRUE(WIFEXITED(status) && !WEXITSTATUS(status), "child_open");
+	ASSERT_EQ(skel->bss->called, 1, "called");
+	ASSERT_EQ(skel->bss->ret, -EINVAL, "bpf_path_d_path");
+out:
+	test_path_d_path__destroy(skel);
+	remove(testfile);
+}
+
 void test_fs_kfuncs(void)
 {
 	/* Matches xattr_names in progs/test_get_xattr.c */
@@ -288,4 +336,7 @@ void test_fs_kfuncs(void)
 
 	if (test__start_subtest("fsverity"))
 		test_fsverity();
+
+	if (test__start_subtest("path_d_path_on_exit"))
+		test_path_d_path_on_exit();
 }
diff --git a/tools/testing/selftests/bpf/progs/test_path_d_path.c b/tools/testing/selftests/bpf/progs/test_path_d_path.c
new file mode 100644
index 000000000000..4ea50a067819
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_path_d_path.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <errno.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+#include "bpf_experimental.h"
+
+#define PF_EXITING 0x00000004
+
+char _license[] SEC("license") = "GPL";
+
+__u64 monitored_ino;
+int called;
+int ret;
+
+/*
+ * A task that exits with a file still open releases it from
+ * exit_task_work(), after exit_fs() has already cleared its fs.
+ */
+SEC("lsm/file_release")
+int BPF_PROG(path_d_path_on_exit, struct file *file)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+	char buf[64];
+
+	if (file->f_inode->i_ino != monitored_ino ||
+	    !(task->flags & PF_EXITING))
+		return 0;
+
+	ret = bpf_path_d_path(&file->f_path, buf, sizeof(buf));
+	called = 1;
+	return 0;
+}
-- 
2.47.3

