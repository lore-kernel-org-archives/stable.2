Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4939B3AB5B2;
	Mon, 31 Aug 2026 06:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788157998; cv=none; b=kh2WBfJTIGcInKRGEwZDtnwAJb15eVtgMnhYuQRhKAIGy8DpL7ZSzzFlN67IjLCbAVSrTMEF8ATN1qv1uh7iu7tsteMSH6KU4zqPoZ2vOjNh/rA3Zpr/vFw+bvNBABhMDTbllW6khotOyO1bTRt8TRnqRzcaBkijNv5jlCERAqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788157998; c=relaxed/simple;
	bh=wXO9AseMND6OhL4c88ep0JDRf7grY5LY9ErFMJA8H30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bSWgW5qAdt4QL0J7tHY4P8zvoh8mSs/D1Uu5VMz/6qy9wPhdFAY5LbXxsmf3fFMO1f2vXqEfcnLELABI8yD+EOPZ32YunTOkUEVNB8F+RVkiDtNYyeKwFcgkUVTYdMdlwPGgLn6mTOaZOQgniLw+9YLvFxi1u2IeI6InHS0Prfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=SJmcnNzt; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="SJmcnNzt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=qI
	cHr44vsOIWJ8kh0gHL1kvjQdn8y25zs4zjr5fJB5o=; b=SJmcnNztvHHgTNJITM
	mWnOWW1CJ/80wJcBuFJQ02lYEzTw43Ej8NOcJJYDQaquR0HhbtZiYgeZ1WZBSVdf
	0sEwkarxd3kt4BhANHoKbn5PBYZY6FrLdc70zoc/DdaVcpH748HMCwYznan/nCDc
	dnsFbElbaumJrw772iiJWHZv0=
Received: from nec8-i7 (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgBHMGIDIJVqTbDjMw--.5247S4;
	Mon, 31 Aug 2026 14:32:40 +0800 (CST)
From: chenyuan_fl@163.com
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Yuan Chen <chenyuan@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH bpf v5 2/2] selftests/bpf: Add regression test for queue/stack map size limit
Date: Mon, 31 Aug 2026 14:32:26 +0800
Message-ID: <20260831063226.621309-3-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260831063226.621309-1-chenyuan_fl@163.com>
References: <CAEf4BzYLUTO+6bcp8X8M_wbc=JaxZMo4PZCgS0e-t=8zMO9tSQ@mail.gmail.com>
 <20260831063226.621309-1-chenyuan_fl@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgBHMGIDIJVqTbDjMw--.5247S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw1DJF4DKr4rCFyxJFWrKrg_yoW8tr45pa
	95JF43KrW8Wrs2q343Kw1DXFs5KrnYgF1UKFnFgryDAwn3Wr1Igr1xtF1UAFn7GrZ5Xa4Y
	vw1xtFZ3G3y7K3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jv2NtUUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbDAgkKx2qVIAnarAAA3m

From: Yuan Chen <chenyuan@kylinos.cn>

Verify that queue/stack maps whose element storage would overflow the
u32 head/tail index multiplication are rejected at creation time, and
that max_entries == U32_MAX (which would wrap the u32 capacity counter
to 0) is rejected as well.

Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
---
v5: drop the unused opts and verbose comments, inline the 1MB value
    size, and close the fd on the rejection paths, as suggested by
    Andrii Nakryiko

v4: check the bpf_map_create() return value directly instead of errno
    as suggested by Andrii Nakryiko

 .../selftests/bpf/prog_tests/queue_stack_map.c     | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/queue_stack_map.c b/tools/testing/selftests/bpf/prog_tests/queue_stack_map.c
index 41441325e179..a01a0bcbdee7 100644
--- a/tools/testing/selftests/bpf/prog_tests/queue_stack_map.c
+++ b/tools/testing/selftests/bpf/prog_tests/queue_stack_map.c
@@ -2,6 +2,8 @@
 #include <test_progs.h>
 #include <network_helpers.h>
 
+#define U32_MAX ((u32)UINT_MAX)
+
 enum {
 	QUEUE,
 	STACK,
@@ -101,8 +103,35 @@ static void test_queue_stack_map_by_type(int type)
 	bpf_object__close(obj);
 }
 
+static void test_queue_stack_map_alloc_check(void)
+{
+	int fd;
+
+	fd = bpf_map_create(BPF_MAP_TYPE_QUEUE, NULL, 0, 1000000, 8192, NULL);
+	ASSERT_EQ(fd, -E2BIG, "queue_oversize");
+	if (fd >= 0)
+		close(fd);
+
+	fd = bpf_map_create(BPF_MAP_TYPE_QUEUE, NULL, 0, 1, U32_MAX, NULL);
+	ASSERT_EQ(fd, -E2BIG, "queue_u32max");
+	if (fd >= 0)
+		close(fd);
+
+	fd = bpf_map_create(BPF_MAP_TYPE_STACK, NULL, 0, 1000000, 8192, NULL);
+	ASSERT_EQ(fd, -E2BIG, "stack_oversize");
+	if (fd >= 0)
+		close(fd);
+
+	/* A normal-sized map must still be created successfully. */
+	fd = bpf_map_create(BPF_MAP_TYPE_QUEUE, NULL, 0, 64, 100, NULL);
+	ASSERT_GE(fd, 0, "queue_normal");
+	if (fd >= 0)
+		close(fd);
+}
+
 void test_queue_stack_map(void)
 {
 	test_queue_stack_map_by_type(QUEUE);
 	test_queue_stack_map_by_type(STACK);
+	test_queue_stack_map_alloc_check();
 }
-- 
2.43.0

