Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672AF284883
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 19:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780429311; cv=none; b=b/W0zWI+h9KVqvA4fLbECCcU3uf6C3kzO+848C+TtXcNc4zj1yRnba8+sOQpcP9IYkAMEwF3N5jYlwTkWslzGHQ5g/HLmZkBxlvHezegvbZcaFVYa238QTf7vZj0o2mNOFqruAq8tGBoVCZ6/L6SY0YvIuU9wIQkhZs+fl7CT+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780429311; c=relaxed/simple;
	bh=GpOhVnUato6nAjWG5ZzhOjxZMa/xx1ZXereqiPdbuvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WF95dUd40N71nNSsFLZo3lqlG1eGRWnjR/c2hsyQ2BOah9Y8hwGTd2kteKKmziLRP4sBxhjnfF3qzvjBdNhxw32x1Dy2tYPV1pFj6tQEoksdJw4vvJsRWn3yd7uHCTA7GXFu2HHplkNDRnSu3bgvx+2EP5dCWJjjsufKlmUTEDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pagcUi3n; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pagcUi3n"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-490b3637b90so9016485e9.3
        for <stable@vger.kernel.org>; Tue, 02 Jun 2026 12:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780429309; x=1781034109; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mSScEfq21tmwJsqhb0IpUvHNH6FCuXi3tvVlH03ljGQ=;
        b=pagcUi3nYzSc8izEY8NDhNOJo4vfPjy3ZJFRtdeyJSZUwu29qFW5AcmXCg4giLmj3D
         qBqeKO2g/usW9RRunJsxIttH0lYqL/WepfJB1QILKoZ7CahwDsOBJS/ulUwhkG4FTfvi
         or6YBvE6VXdrWgr8z6vbpiOAaKvu2ioqAi9cECB7bMiYtQ5b6I9un36ROROfk5uU6kO5
         B7jLlxRH+939K9U8qv6wDeqWb1bR/2XV7haMKc3gGHiyhnV6cV+q0X/CV69xK+kYWYbE
         efUBK/yeEJZDHr99YyRdZOvopaYAKYNIthb2zufl288QIEGbvyxm+P9kN6okjHLE65+U
         PNaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780429309; x=1781034109;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mSScEfq21tmwJsqhb0IpUvHNH6FCuXi3tvVlH03ljGQ=;
        b=PUJ3hRdQ9GpSbCC3dIa01dWlwBkqctyme6j0oEFZLyZZClQkArmQ+lr9ffh0cHME77
         fbvBRfmdnaaTTwUHKybtc7va1DOnajNzDY3cq9cF0T6nz9Qgpiqk+lb3O5esS3Litb0s
         Y129Jvq7QVMr/pU1IdXy72dMsuwe95A/v4i6gvD5LhxTi39w3skyXCHv8+WbAHrM8PIa
         1MJPdPqkp8NCcmhnPbHU0UK9e3tlsYCxQNuidzuMlgR0bHB4IR7DST9e0XPVNXAZ+gCJ
         mBbwq5QUcOiQED0TKzmFQ6VTPv6Ff1Qs7R7YJkPRn9+q6AO47x2FShgf03cnKJX5iE3r
         6YRw==
X-Gm-Message-State: AOJu0YyUcMQEfq1y9oh5h16J2Fg1XI6lGMfTFOmp34VbGltUEEIwxAR9
	u/HNV9eFJt/N12ELwgr3GOEH2EAMTQuekKHlLbds/ZfJhtfpi1Y2cs7WqT+hJ+7R
X-Gm-Gg: Acq92OHgJw/cdxA7HuxUiYSRNHxyWEtxIuduo24dFsZeQieJs8QgtrJZ2iaKioTQMxm
	w6tWfoCMqbJ0v2bpq5WzxZJoXuEAh0vIGgocFTLOm1lW5LtCXd/mIcwa3P5uv1OYeOHU5S6k5Tn
	txep1/M2PXT2ByIAB2vemeCkeANJOBH+g3QL2YuopTlhMVi3hrVISA3lUA+IkD2PVA/m2MGP5J9
	7WJL6+ywQeKPm0t7noGx0NJ4Xm2o65ynd6qMdJN3AX5JRL2LdKaZQY/O+AXjHV+pfi275D2o4sB
	gbp1xgu+bLbO6hgsK4LgpRT4C3DlrQYHALC2cCYmWv+Z+KLt4VfhRL347PogB3FLJhA/xk3RRE5
	quu1TvtcwVIcTX45QscI6XNXVD8w8QhDe/8m4foFBE7yEKX25c1Y8e1M+HeYZLumflYFCP5l5K1
	U+lel7lwpatDMMPpCwniPlo6CP2kxLUwaQSkvuiCduLtMzrNgx8oyEWNBHDKQb1aJfuQqE5sWBO
	x06z9hck+/DFwQuolvjIhHnpZGJND71q6yzyJ/QvEsuAOz2j4jtQP6aa3V+6rVYEFr0BnhNDVWw
	e8g7j/q8reR8mpj85qiogpIxCbwvLi1ZwkeIXPmI8oOmZ/ydxoDCVBzSK8tlU9cN
X-Received: by 2002:a05:600c:1d09:b0:490:9d5b:d721 with SMTP id 5b1f17b1804b1-490b5ed62admr3222195e9.16.1780429308835;
        Tue, 02 Jun 2026 12:41:48 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00d5a27cd7dcd113c6.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:d5a2:7cd7:dcd1:13c6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0e13f91sm106961405e9.3.2026.06.02.12.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 12:41:48 -0700 (PDT)
Date: Tue, 2 Jun 2026 21:41:46 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH 6.1.y v2 09/11] Revert "selftests/bpf: Add a cgroup prog
 bpf_get_ns_current_pid_tgid() test"
Message-ID: <9f6469459ace58f189b12e4e3636488ef443775a.1780427227.git.paul.chaignon@gmail.com>
References: <cover.1780427227.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1780427227.git.paul.chaignon@gmail.com>

This reverts commit 4d8fb7ed7a55 ("selftests/bpf: Add a cgroup prog
bpf_get_ns_current_pid_tgid() test").

That commit should have never been backported to 6.1 because it
introduces a test for a feature that isn't supported:
bpf_get_ns_current_pid_tgid() cannot be called from cgroup BPF programs
in 6.1.

Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 .../bpf/prog_tests/ns_current_pid_tgid.c      | 73 -------------------
 .../bpf/progs/test_ns_current_pid_tgid.c      |  7 --
 2 files changed, 80 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c b/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
index 2c57ceede095..a84c41862ff8 100644
--- a/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
+++ b/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
@@ -12,7 +12,6 @@
 #include <sys/wait.h>
 #include <sys/mount.h>
 #include <fcntl.h>
-#include "network_helpers.h"
 
 #define STACK_SIZE (1024 * 1024)
 static char child_stack[STACK_SIZE];
@@ -75,50 +74,6 @@ static int test_current_pid_tgid_tp(void *args)
 	return ret;
 }
 
-static int test_current_pid_tgid_cgrp(void *args)
-{
-	struct test_ns_current_pid_tgid__bss *bss;
-	struct test_ns_current_pid_tgid *skel;
-	int server_fd = -1, ret = -1, err;
-	int cgroup_fd = *(int *)args;
-	pid_t tgid, pid;
-
-	skel = test_ns_current_pid_tgid__open();
-	if (!ASSERT_OK_PTR(skel, "test_ns_current_pid_tgid__open"))
-		return ret;
-
-	bpf_program__set_autoload(skel->progs.cgroup_bind4, true);
-
-	err = test_ns_current_pid_tgid__load(skel);
-	if (!ASSERT_OK(err, "test_ns_current_pid_tgid__load"))
-		goto cleanup;
-
-	bss = skel->bss;
-	if (get_pid_tgid(&pid, &tgid, bss))
-		goto cleanup;
-
-	skel->links.cgroup_bind4 = bpf_program__attach_cgroup(
-		skel->progs.cgroup_bind4, cgroup_fd);
-	if (!ASSERT_OK_PTR(skel->links.cgroup_bind4, "bpf_program__attach_cgroup"))
-		goto cleanup;
-
-	server_fd = start_server(AF_INET, SOCK_STREAM, NULL, 0, 0);
-	if (!ASSERT_GE(server_fd, 0, "start_server"))
-		goto cleanup;
-
-	if (!ASSERT_EQ(bss->user_pid, pid, "pid"))
-		goto cleanup;
-	if (!ASSERT_EQ(bss->user_tgid, tgid, "tgid"))
-		goto cleanup;
-	ret = 0;
-
-cleanup:
-	if (server_fd >= 0)
-		close(server_fd);
-	test_ns_current_pid_tgid__destroy(skel);
-	return ret;
-}
-
 static void test_ns_current_pid_tgid_new_ns(int (*fn)(void *), void *arg)
 {
 	int wstatus;
@@ -140,25 +95,6 @@ static void test_ns_current_pid_tgid_new_ns(int (*fn)(void *), void *arg)
 		return;
 }
 
-static void test_in_netns(int (*fn)(void *), void *arg)
-{
-	struct nstoken *nstoken = NULL;
-
-	SYS(cleanup, "ip netns add ns_current_pid_tgid");
-	SYS(cleanup, "ip -net ns_current_pid_tgid link set dev lo up");
-
-	nstoken = open_netns("ns_current_pid_tgid");
-	if (!ASSERT_OK_PTR(nstoken, "open_netns"))
-		goto cleanup;
-
-	test_ns_current_pid_tgid_new_ns(fn, arg);
-
-cleanup:
-	if (nstoken)
-		close_netns(nstoken);
-	SYS_NOFAIL("ip netns del ns_current_pid_tgid");
-}
-
 /* TODO: use a different tracepoint */
 void serial_test_ns_current_pid_tgid(void)
 {
@@ -166,13 +102,4 @@ void serial_test_ns_current_pid_tgid(void)
 		test_current_pid_tgid_tp(NULL);
 	if (test__start_subtest("new_ns_tp"))
 		test_ns_current_pid_tgid_new_ns(test_current_pid_tgid_tp, NULL);
-	if (test__start_subtest("new_ns_cgrp")) {
-		int cgroup_fd = -1;
-
-		cgroup_fd = test__join_cgroup("/sock_addr");
-		if (ASSERT_GE(cgroup_fd, 0, "join_cgroup")) {
-			test_in_netns(test_current_pid_tgid_cgrp, &cgroup_fd);
-			close(cgroup_fd);
-		}
-	}
 }
diff --git a/tools/testing/selftests/bpf/progs/test_ns_current_pid_tgid.c b/tools/testing/selftests/bpf/progs/test_ns_current_pid_tgid.c
index d0010e698f66..aa3ec7ca16d9 100644
--- a/tools/testing/selftests/bpf/progs/test_ns_current_pid_tgid.c
+++ b/tools/testing/selftests/bpf/progs/test_ns_current_pid_tgid.c
@@ -28,11 +28,4 @@ int tp_handler(const void *ctx)
 	return 0;
 }
 
-SEC("?cgroup/bind4")
-int cgroup_bind4(struct bpf_sock_addr *ctx)
-{
-	get_pid_tgid();
-	return 1;
-}
-
 char _license[] SEC("license") = "GPL";
-- 
2.43.0

