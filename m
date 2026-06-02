Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAF534889F
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 09:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780392660; cv=none; b=RItZ4Ro2YtN9QEMTMQXtp4leTzbYOM8u+yMVzZx8UAZqWV1Eqglw4KVA8LKm3/HU46DrZKAiaaWPobCQFSjEVtdozQZW8nxvFpLtnivRYmUUHaFEFFK8tbEbV66Q7SDKg3SXL/N+GXC7CXp/j5M30gaaso3pDdnV5SrRg+QF2dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780392660; c=relaxed/simple;
	bh=GpOhVnUato6nAjWG5ZzhOjxZMa/xx1ZXereqiPdbuvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t2OrceY2bTuNC/FB0VEt09l/e1BUtcB5lJbhmSrLa/fhNxMUWJTLqxM3mp59gy3KrCQ+uyFY1CP3/l9DB9bMUkgmgQYFnB8aQigVf0fxaF8VgXClgBJ38Fm58HI7q6IhXLGvptfCz/CK24PrVcfhwalQdI0hIG+JT0TIQ7rZePI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=POjo0Ak9; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POjo0Ak9"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49068493267so63023785e9.1
        for <stable@vger.kernel.org>; Tue, 02 Jun 2026 02:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780392652; x=1780997452; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mSScEfq21tmwJsqhb0IpUvHNH6FCuXi3tvVlH03ljGQ=;
        b=POjo0Ak9fOsliO/6lP59NPX5fxioGRM/DkKXXcHjozucFr+lSvzJ5fnkjECEsViaJX
         EjcQyqxJur4Wi0XqVmHcGbDFjxx5P4frVxoUbxfD1fkxCpzJRLiO8TDZlwStncAqkzWW
         pfhehVWdsXtXfJsmsI5DmQc5QD/o2hgIwoh7p5uclJ58jSjpN3YLZzZrrvwz2SE+WiUe
         g2iJWHsCy/mKHCW/KXoRQ9yIq+H7umb1Q8TyrCEkRzjYPcUnoaGay8Y29jebBjvpF+ie
         9thILdK4zT1AA6PwK8W6vuUr75ky+sfF4L+DnciuviKfoaoymlM9kfoLCzyJ623gA+lY
         jv6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780392652; x=1780997452;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mSScEfq21tmwJsqhb0IpUvHNH6FCuXi3tvVlH03ljGQ=;
        b=V77aIajRNGKmeh5rwtj1IhYNqBhDNC+6BY3ohUtSY4XV1ZJtnD/0Rz5WtcfWCdXQgX
         BsLtSS9SceXQDFHg5YOITtuv94UD+W55VSnOSVktQsKTB7YQoBYpM0ywuWnaVh/PvsFr
         Qx8uq8ZiEjuCnvXPBaD0NZvUgHN5mEXHNzNdv0E9eRH6beHaqcNwdfwQ9U+MpfwRtvEE
         6WetBvgxvoAowtNqPfzUkpbeZN6PEYZuENbF4d45UJuvtlzYVuE2sq3uuhZl9Dcnx35/
         c0Z7KBI47KOLwWN3k8nVxF+CcEDYqxcYgGjIPX5QPU/uSXO796qZ2mwdm8KgzSB0hIMG
         NacA==
X-Gm-Message-State: AOJu0Yz+eB/RFPo4+SD9+Qm2bkuFQ9E7AtYDRGlqv6w7QCcmOStWqttp
	JQgLWSiM0h1LeFwWgCH/c0ubuT71PCLo3umHlev9tYTBTObyuee+IGuhW8YQtH9x
X-Gm-Gg: Acq92OEla5n6gOCS1lBBE1kJVZiJT5dv+pG0+TDzvaSTKAwrN4w7BviXFjZ0vBeJ9d+
	mL/gz7p2kn91kgD/5kmwBqBJ95PyOiAA5QC96Ta8J36uPB/S31mHwPJMNGgjVdazCnkaovhCKYt
	U/Ghd6n9NXNoE7bmxi7fIdsQchpgCqCSfJUBjDlTBBtL9lLTiWPR+Hpq4hW1lWY+AatI1vu4VdY
	b6sO2RWLZB5FxNVtxArqmErENUKOghwf/JivpVMbEutg8KFO2hegdnHxTPoYR01WHaFvpP/XNzb
	tteUbKCH7bfqoxxb/oS01foB+pkbM/KWfNfxCFO/YEArp9XyP0sdZ0fckUohqWXwoNBjeWaFgFd
	CWk8S3caocjtMMHryrOVdGHy4sm/URlq8mQrYmz8998+4m3Mc69w5+P/GnLveEBQNQtCfbisCLf
	weR/YXRvhfQTc3T4btSgBGZoLvs5tY2Rld8e6iKPKe8BC0yhZozrlyEI9ralBnnL2M0XMLzkqLn
	NiknLxFpAP92hqnVrg5+01ChW6asdWaIW5mOWXXQHb9F6dOrv23nWC7F0LwDvxhHCedcfDVmWxN
	LTO6S9OwLulEw9MG3ESENSsLwkJh4SGydSliE+j2bvpZnfE2T0W9wQ==
X-Received: by 2002:a05:600c:3f0c:b0:490:b2a6:8c1d with SMTP id 5b1f17b1804b1-490b2a68cc9mr21628425e9.10.1780392651462;
        Tue, 02 Jun 2026 02:30:51 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00d5a27cd7dcd113c6.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:d5a2:7cd7:dcd1:13c6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490afc41a61sm44626305e9.2.2026.06.02.02.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 02:30:50 -0700 (PDT)
Date: Tue, 2 Jun 2026 11:30:49 +0200
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
	Stanislav Fomichev <sdf@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH 6.1.y 09/11] Revert "selftests/bpf: Add a cgroup prog
 bpf_get_ns_current_pid_tgid() test"
Message-ID: <94bc1d833e2a48bb73cc772f67401a9484a337f5.1780392093.git.paul.chaignon@gmail.com>
References: <cover.1780392092.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1780392092.git.paul.chaignon@gmail.com>

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

