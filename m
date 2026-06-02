Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132783CBE73
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 09:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780392618; cv=none; b=IGWN/Skg5wouwO6szB3PBh0l3UtodklAOrogcoC8qt+gWOlOkj8gVL5Msa4tWSS4eCDZxGkuMco9qs8O9O7MlhhqXG8vrW+r4csHZUVZ5kpfMga/2ZgNDXwFEG/xecmJNNsmm+pVFGR678nT0KttOi4qTevYlBeUACZjnMUt6Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780392618; c=relaxed/simple;
	bh=nuOQF8c8KxVbRDCQEK+H7hJ/2q9rBX3iIApc6SElZO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E4oQqlyooWpEGm5wtGKQ8IYC07kdZuDr9q87MiZSD0T1LANROwuxg4snDFtWeh3YiQDFdixfnY8fgR7i7m+/95npR9iZlAQ5MoL8xciJa5YbuhHXj8OAAAwro4/if7iWudcvKi+G0O+3kubW4RJoWNTkDuQn7QMamsrAQUw62js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IDwcd8YU; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IDwcd8YU"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-46015dc517aso1184731f8f.2
        for <stable@vger.kernel.org>; Tue, 02 Jun 2026 02:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780392609; x=1780997409; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F5dHp4eP3E1awLcqfYD+9lAY8LH+Tyw2XaP254CUu0w=;
        b=IDwcd8YUoNi0jlpetlEbS/gx8P4XmiWzOFYIJddBhsIfiOn1ieYpdvXJZVM3ueNsPN
         A81nBatCQiL+KutinEn+OTF+l03SAsmlooGeZdd3ZHefCVOLr5HmdOiwDZCYB0zEnTmw
         aVmPqZ8y0BdpEu1wXFW4E3eU6JMEe0dzWoWZRWG4ygbIuk6RS1pkmlVqZ56PtDGbNjAO
         pq9tSjLrky42a370aaEqIdTBmcjrDNvXTlkhMQ2AQOdk43oEHlIbBr1uPnoDmrut3gmV
         9vVUDYGkxnwwlft3VM46+LX+Pr0dF51UG6cYJQAMHlChkGah0Q7XeieGbiwCwTFeVGdP
         XFZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780392609; x=1780997409;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F5dHp4eP3E1awLcqfYD+9lAY8LH+Tyw2XaP254CUu0w=;
        b=NmwhYw6ffxIXX1nDQdwDFcHqIqADTafT0xsgz8Gvn6sxVkBKkbMGdD7kOMNaM4zIg4
         Fv0mZ12u5yCO85dg7dkniuG3Gy4ZDkJeHMwcj4McC5ZrZcKf8VXgFbVZ+JJPd9ilnuGt
         ufgc/cH1yfpXAcnVJ5ofDLPV8aVW9lNaMLI3+eEz4rxTNeWMvfG27P2TkS7hMwkmzvn1
         v+70K3r4GvJPXpo216Zx/B0c+PFjkvpQo9VjDDANBY7Iw5DuyBoY1ZHWw1UKxTIuQGc2
         Bz0HMV8rDhDQNWJorcr6mQ7xGSxuKb89Pb9a5YYArkZVyvRP+FzVGHknOK0biWE3tK1R
         N8uw==
X-Gm-Message-State: AOJu0YxJszaajeVY0m2k7ok9TzcLU8nGtOMRUJYDPTCo5aEjOOuc+C4+
	qsNdPm4oCt/Mhd45ZxUN2ED9RZzbX9WQzjcis15IIpVrM4Q7IcQq7j4dI1smtWYO
X-Gm-Gg: Acq92OFKlU8MRUxDfY8Wmk92HvYawhBzup1VhGpLwjeqB81eQ7XM/jKH3gG/d9aB3Xk
	FDDpO9/k8XOWZlmhbKnQ79A5EKHAO7ml6dF6UaERz3ZKaCLm42NnyFqU+WrUe9OvrhJS+XbRQ+B
	HIZlM8ZW6lW72JVG6yrJoBECleGJd2c6Frwn+e+Jl92YB8oABbI+oITU2CYO7n4M9Tem8GzWsjt
	DOTHrxjsVpzhCGEi/NaRgI6d6g7AXarnQ+epOhXBRIUZVUBVZzuIVG3T2prfNyFHvVvKqIVtNDj
	h2+sFN2fvLJaJKhFSkG7hGSUHJ+rBB8netZyLFvNNaJ+1ieG3EwQvnSKs7pgxiTSJnJybuTXCw5
	AyewrAWTPOtv52at64tz5Ad3kEKdzz2kTrlS9yN7cI3PpVVzB94Zclph8z5pwTVFXO0R5TPqZoi
	HcOVW4xNoJ2E2+N2VexG2NJcICe7hf4zcB1IDvUAakJEdpy7P+lLUGHfoF/ToX3pFu3KNJhmgRz
	KaVjuYYXYVrdOlQFfHQkO1giH6J519fo4VKeODig/EHGZ7rsZcJWAJMixNR2/mfY3ImHicCrXPM
	8gck1bsAqjHSNmHzaf9L+KOSxVB3AS5DJr3Rz0p9j0PAp7uyHQdqng==
X-Received: by 2002:a5d:560f:0:b0:45e:d8dc:922e with SMTP id ffacd0b85a97d-45ef6b4e3cfmr19168817f8f.20.1780392608883;
        Tue, 02 Jun 2026 02:30:08 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00d5a27cd7dcd113c6.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:d5a2:7cd7:dcd1:13c6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef34c3081sm31952954f8f.15.2026.06.02.02.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 02:30:08 -0700 (PDT)
Date: Tue, 2 Jun 2026 11:30:06 +0200
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
Subject: [PATCH 6.1.y 04/11] Revert "selftests/bpf: Add tests for _opts
 variants of bpf_*_get_fd_by_id()"
Message-ID: <a689cc902ce9ea42af7635678362a63aa4677e42.1780392093.git.paul.chaignon@gmail.com>
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

