Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FC21DF73C
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 19:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780429263; cv=none; b=rRdK+swT27Yc6YgxbQZgqrgTWvttu7oozMFVVfmcKuha9+djcna/RwBxoArZuZoOZfj5HP39J7ONX0QDWP5FHbeO8uI6RYPii1NxiVkRiFIPj1yil7r28WV/IOhimHE55wG5ULs9dcV0y1gZZc3GsGsUmcX0YgyybfXOQ25wkMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780429263; c=relaxed/simple;
	bh=nuOQF8c8KxVbRDCQEK+H7hJ/2q9rBX3iIApc6SElZO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QUh6FENN73eYOwr9URb2IhIBY+rnqkFzZmgQvvoWmp/p7tmn1bBz7t9/V7J3lycdG8iNn3OqtREb7cCpwyoUpMIm1qaVNErPxSrhP+CJyzb9Yh8h0CY+lAI9dwoSshRz8WqjycqjiiIboexq8AvLd2wqhLza2iPEdaxFhsW81Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QK66rTui; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QK66rTui"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-45e9f4a3510so6879418f8f.1
        for <stable@vger.kernel.org>; Tue, 02 Jun 2026 12:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780429260; x=1781034060; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F5dHp4eP3E1awLcqfYD+9lAY8LH+Tyw2XaP254CUu0w=;
        b=QK66rTuiPmqIAAygN3fADFcW0irqrZypZRhtfhcZVZRwtHxA17dKn0HL6hnEb5vSy2
         JLoMU9uuNqXlzEjHz4T5lIJKuE72IQt9vvmRAwIJMbDBVTtqN2UzDs5rhCjmY/Vs8CvU
         sy8sESfZ1xmgsy9fIQ+AOenZLuOLHToEUOMtljPfAGqZbbt4TbD70Hz80l2QFuDhWzbY
         9c1+QwQN+bXiUbq6DWKSI46zQfGtIa5moea7grHeAe0bWrE82+qyMCrQ9dJqpgPBi7vg
         GKuZRFSg0ojW2uWiofLjl4P4UujTkQGePVtvSExomSeHKUcnzusoNLhh8urca4Pc3mOg
         TVSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780429260; x=1781034060;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F5dHp4eP3E1awLcqfYD+9lAY8LH+Tyw2XaP254CUu0w=;
        b=n20o/dd5ZPEP1ZBHvCLITN8VyrcWBuvPdp20TmizvXxM82SokVVIkel7fmCNzy2i2J
         dMYEbDToZu97lGTRBwiXAqT807gfD5vYcnzXkfFa7o52HAmiYXPnJoH83HmHe9eg2FrL
         0NbKPPv3oy+7+NHkZLxyU4ZBXIT4DNrViORzyRM8qGKgmCF4a4jCgnw8q/u5TnHqtrw9
         1YqDZBn24PgRoCugC10j57XOb02HcKQCtyqVtFI6AuHF5TfAsD+gGtgkoKIV4xCs/bc3
         fPpBwDKECqPYmSQz5AR5373LbBswemIjA+huO8BJyzUZCOgxPJ796+sbSyLGJRBR3TP7
         pEjQ==
X-Gm-Message-State: AOJu0YxFw9ESsBUw8ZR1/Odwed+pO+HFAYVUp9vPa23c9g15H0UDXTDI
	QmycYqreQapnwYfYYVujnBceNxnlFEdiN76gTRTUus1mYw5b05ruaMjKVLsey6W+
X-Gm-Gg: Acq92OFj0CaegZ+2vrID5Bzxr70/lj9k2XLJEJJN3VTzyaHFWHhdepnTIJqtYTPJj8i
	Qrjc5Sk1+w5yVlDmKbh0aRmxc5jemJiSiheiET8ZacKAbPcrVpLa8hxTazrtaUEf30xVJOxcoOB
	WPqEcKOPH1QAZ3JBvmeY/9GZCASWtOjTkGJrXQM5euJU9b3C7V+353ofXawgEAHlxVtRTEYX+6i
	QbzfmOuaC0puUgx8QxQlHvj3sE4Vdcu0BYL+2pNtjArxj823eGTw2chlFuUMsOUSuXduytG4jZg
	fzuGF4s5jl/bIryb1xiJ2VY+JQo8Bi5TbItSfYRyrcE1sb+G3i86Uk/ApECwL91eKmPLvh4ZWeB
	FtICZ6Qgd/5jk9QxbIE8c1LhdmIJV3qauGuaPImmlVbKz+FOWaCg02CkG01DXY0yFT5uESL4JSN
	QXOUS0dUTRRRIio/OQmWyEW139CF+Ow80y3fTprR/b7q7zGpX2luowA1akUGrhbyOVelh/Y6qbU
	qzlyugM90AivLdmVnBVpxpnVQ237Ficj+tZhCmHC1I63qkb7x2h6E9AzgZ8zBFx7kouCs7aOXxF
	XuLYs06iUnmajL7VuIkfLuxgbKSI9B4GSs2czTIAVr93lZWzQZUzbYwqx2gwU76l
X-Received: by 2002:a05:600c:c84:b0:490:389:7644 with SMTP id 5b1f17b1804b1-490b5fe0e36mr3459745e9.17.1780429259915;
        Tue, 02 Jun 2026 12:40:59 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00d5a27cd7dcd113c6.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:d5a2:7cd7:dcd1:13c6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0e13f91sm106923175e9.3.2026.06.02.12.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 12:40:59 -0700 (PDT)
Date: Tue, 2 Jun 2026 21:40:57 +0200
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
Subject: [PATCH 6.1.y v2 04/11] Revert "selftests/bpf: Add tests for _opts
 variants of bpf_*_get_fd_by_id()"
Message-ID: <606e954857cf08c035a39dd2274b42c5ac883709.1780427227.git.paul.chaignon@gmail.com>
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

This reverts commit 45108a7b4866 ("selftests/bpf: Add tests for _opts
variants of bpf_*_get_fd_by_id()"). As explained in the previous patch,
it introduces a new selftest for a feature that doesn't exist in 6.1. It
was backported as a stable-dep of a1914d146622 ("selftests/bpf:
Workaround strict bpf_lsm return value check"), also reverted in the
previous patch.

Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 tools/testing/selftests/bpf/DENYLIST.s390x    |  1 -
 .../bpf/prog_tests/libbpf_get_fd_by_id_opts.c | 87 -------------------
 .../bpf/progs/test_libbpf_get_fd_by_id_opts.c | 36 --------
 3 files changed, 124 deletions(-)
 delete mode 100644 tools/testing/selftests/bpf/prog_tests/libbpf_get_fd_by_id_opts.c
 delete mode 100644 tools/testing/selftests/bpf/progs/test_libbpf_get_fd_by_id_opts.c

diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/testing/selftests/bpf/DENYLIST.s390x
index beef1232a47a..0fb03b8047d5 100644
--- a/tools/testing/selftests/bpf/DENYLIST.s390x
+++ b/tools/testing/selftests/bpf/DENYLIST.s390x
@@ -76,4 +76,3 @@ lookup_key                               # JIT does not support calling kernel f
 verify_pkcs7_sig                         # JIT does not support calling kernel function                                (kfunc)
 kfunc_dynptr_param                       # JIT does not support calling kernel function                                (kfunc)
 deny_namespace                           # failed to attach: ERROR: strerror_r(-524)=22                                (trampoline)
-libbpf_get_fd_by_id_opts                 # failed to attach: ERROR: strerror_r(-524)=22                                (trampoline)
diff --git a/tools/testing/selftests/bpf/prog_tests/libbpf_get_fd_by_id_opts.c b/tools/testing/selftests/bpf/prog_tests/libbpf_get_fd_by_id_opts.c
deleted file mode 100644
index 25e5dfa9c315..000000000000
--- a/tools/testing/selftests/bpf/prog_tests/libbpf_get_fd_by_id_opts.c
+++ /dev/null
@@ -1,87 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-/*
- * Copyright (C) 2022 Huawei Technologies Duesseldorf GmbH
- *
- * Author: Roberto Sassu <roberto.sassu@huawei.com>
- */
-
-#include <test_progs.h>
-
-#include "test_libbpf_get_fd_by_id_opts.skel.h"
-
-void test_libbpf_get_fd_by_id_opts(void)
-{
-	struct test_libbpf_get_fd_by_id_opts *skel;
-	struct bpf_map_info info_m = {};
-	__u32 len = sizeof(info_m), value;
-	int ret, zero = 0, fd = -1;
-	LIBBPF_OPTS(bpf_get_fd_by_id_opts, fd_opts_rdonly,
-		.open_flags = BPF_F_RDONLY,
-	);
-
-	skel = test_libbpf_get_fd_by_id_opts__open_and_load();
-	if (!ASSERT_OK_PTR(skel,
-			   "test_libbpf_get_fd_by_id_opts__open_and_load"))
-		return;
-
-	ret = test_libbpf_get_fd_by_id_opts__attach(skel);
-	if (!ASSERT_OK(ret, "test_libbpf_get_fd_by_id_opts__attach"))
-		goto close_prog;
-
-	ret = bpf_obj_get_info_by_fd(bpf_map__fd(skel->maps.data_input),
-				     &info_m, &len);
-	if (!ASSERT_OK(ret, "bpf_obj_get_info_by_fd"))
-		goto close_prog;
-
-	fd = bpf_map_get_fd_by_id(info_m.id);
-	if (!ASSERT_LT(fd, 0, "bpf_map_get_fd_by_id"))
-		goto close_prog;
-
-	fd = bpf_map_get_fd_by_id_opts(info_m.id, NULL);
-	if (!ASSERT_LT(fd, 0, "bpf_map_get_fd_by_id_opts"))
-		goto close_prog;
-
-	fd = bpf_map_get_fd_by_id_opts(info_m.id, &fd_opts_rdonly);
-	if (!ASSERT_GE(fd, 0, "bpf_map_get_fd_by_id_opts"))
-		goto close_prog;
-
-	/* Map lookup should work with read-only fd. */
-	ret = bpf_map_lookup_elem(fd, &zero, &value);
-	if (!ASSERT_OK(ret, "bpf_map_lookup_elem"))
-		goto close_prog;
-
-	if (!ASSERT_EQ(value, 0, "map value mismatch"))
-		goto close_prog;
-
-	/* Map update should not work with read-only fd. */
-	ret = bpf_map_update_elem(fd, &zero, &len, BPF_ANY);
-	if (!ASSERT_LT(ret, 0, "bpf_map_update_elem"))
-		goto close_prog;
-
-	/* Map update should work with read-write fd. */
-	ret = bpf_map_update_elem(bpf_map__fd(skel->maps.data_input), &zero,
-				  &len, BPF_ANY);
-	if (!ASSERT_OK(ret, "bpf_map_update_elem"))
-		goto close_prog;
-
-	/* Prog get fd with opts set should not work (no kernel support). */
-	ret = bpf_prog_get_fd_by_id_opts(0, &fd_opts_rdonly);
-	if (!ASSERT_EQ(ret, -EINVAL, "bpf_prog_get_fd_by_id_opts"))
-		goto close_prog;
-
-	/* Link get fd with opts set should not work (no kernel support). */
-	ret = bpf_link_get_fd_by_id_opts(0, &fd_opts_rdonly);
-	if (!ASSERT_EQ(ret, -EINVAL, "bpf_link_get_fd_by_id_opts"))
-		goto close_prog;
-
-	/* BTF get fd with opts set should not work (no kernel support). */
-	ret = bpf_btf_get_fd_by_id_opts(0, &fd_opts_rdonly);
-	ASSERT_EQ(ret, -EINVAL, "bpf_btf_get_fd_by_id_opts");
-
-close_prog:
-	if (fd >= 0)
-		close(fd);
-
-	test_libbpf_get_fd_by_id_opts__destroy(skel);
-}
diff --git a/tools/testing/selftests/bpf/progs/test_libbpf_get_fd_by_id_opts.c b/tools/testing/selftests/bpf/progs/test_libbpf_get_fd_by_id_opts.c
deleted file mode 100644
index f5ac5f3e8919..000000000000
--- a/tools/testing/selftests/bpf/progs/test_libbpf_get_fd_by_id_opts.c
+++ /dev/null
@@ -1,36 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-/*
- * Copyright (C) 2022 Huawei Technologies Duesseldorf GmbH
- *
- * Author: Roberto Sassu <roberto.sassu@huawei.com>
- */
-
-#include "vmlinux.h"
-#include <errno.h>
-#include <bpf/bpf_helpers.h>
-#include <bpf/bpf_tracing.h>
-
-/* From include/linux/mm.h. */
-#define FMODE_WRITE	0x2
-
-struct {
-	__uint(type, BPF_MAP_TYPE_ARRAY);
-	__uint(max_entries, 1);
-	__type(key, __u32);
-	__type(value, __u32);
-} data_input SEC(".maps");
-
-char _license[] SEC("license") = "GPL";
-
-SEC("lsm/bpf_map")
-int BPF_PROG(check_access, struct bpf_map *map, fmode_t fmode)
-{
-	if (map != (struct bpf_map *)&data_input)
-		return 0;
-
-	if (fmode & FMODE_WRITE)
-		return -EACCES;
-
-	return 0;
-}
-- 
2.43.0

