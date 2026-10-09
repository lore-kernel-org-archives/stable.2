Received: from forward102d.mail.yandex.net (forward102d.mail.yandex.net [51.250.60.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706513D4127
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 06:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.250.60.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791528179; cv=none; b=VYmYFNd4/mfHKLiqkv1QpsS5wjFUHlPHCjoRMF1UUuL342b9A84qtqmWRc9VhKDeSaP8RTjMatJy6m1EJg6U0rHIHVwkAljSUaoua6qQViwaeJujHVaXKYfp5Sa6XtDBJnZDwV3xBRU8BDj4kRXX0qdKWxg86caoEavBgTg4VUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791528179; c=relaxed/simple;
	bh=0VNubLcB4UGt0Asvbqk3ojG5QLhj2pSuOCNDsNn3upo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iiOOHnpCgkYHRSgOdV8I5HOq+ACGwhNNndNBGJdXcVcu78RLrpmkP6F6ZevWu6mm4QWHvMZTfzalxkRpwlKe7fF3ZriuHk5iqzA7x7zRGC68bLACfJNam98IyZYe5L69i3o35xZmpPB1gjEO0upN5ztBQmAybZIDlIsfIk+Va70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=M9AZW/az; arc=none smtp.client-ip=51.250.60.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="M9AZW/az"
Received: from mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:1924:0:640:b9a6:0])
	by forward102d.mail.yandex.net (postfix) with ESMTPS id 1E9A1C02A6;
	Fri, 09 Oct 2026 09:42:46 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net (smtp) with ESMTPSA id igIbxPLdZW20-DWkxzhFB;
	Fri, 09 Oct 2026 09:42:45 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1791528165; bh=ULwLDa8b8sswub5Df2sSvcstKxQfnsZalF/1R3K6mTU=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=M9AZW/azncXCGXtAayuZwltDFoeBAZxgLChJeINRn0HV6usDTj6Due1+Tvgnf2OSK
	 xqjSivycznpyY1Odgi28lkCKPhO4coqvAR+R0jBsnK/4QH01pQRqQOUtFvdqxowBX8
	 pp0OSY5VJdrYt7wP/6lVfUhaUk3mlH1hM/eCpUzM=
Authentication-Results: mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: lvc-patches@linuxtesting.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Mahe Tardy <mahe.tardy@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH 6.12 1/4] selftests/bpf: add cgroup skb direct packet access test
Date: Fri,  9 Oct 2026 09:42:17 +0300
Message-ID: <20261009064220.451530-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mahe Tardy <mahe.tardy@gmail.com>

commit 9aef3aaa7059c4dd0cc875107e05bb3198a7fc33 upstream.

This verifies that programs of BPF_PROG_TYPE_CGROUP_SKB can access
skb->data_end with direct packet access when being run with
BPF_PROG_TEST_RUN.

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
Link: https://lore.kernel.org/r/20241125152603.375898-2-mahe.tardy@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 .../cgroup_skb_direct_packet_access.c         | 28 +++++++++++++++++++
 .../progs/cgroup_skb_direct_packet_access.c   | 15 ++++++++++
 2 files changed, 43 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_skb_direct_packet_access.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgroup_skb_direct_packet_access.c

diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_skb_direct_packet_access.c b/tools/testing/selftests/bpf/prog_tests/cgroup_skb_direct_packet_access.c
new file mode 100644
index 000000000000..e1a90c10db8c
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_skb_direct_packet_access.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include "cgroup_skb_direct_packet_access.skel.h"
+
+void test_cgroup_skb_prog_run_direct_packet_access(void)
+{
+	int err;
+	struct cgroup_skb_direct_packet_access *skel;
+	char test_skb[64] = {};
+
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in = test_skb,
+		.data_size_in = sizeof(test_skb),
+	);
+
+	skel = cgroup_skb_direct_packet_access__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "cgroup_skb_direct_packet_access__open_and_load"))
+		return;
+
+	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.direct_packet_access), &topts);
+	ASSERT_OK(err, "bpf_prog_test_run_opts err");
+	ASSERT_EQ(topts.retval, 1, "retval");
+
+	ASSERT_NEQ(skel->bss->data_end, 0, "data_end");
+
+	cgroup_skb_direct_packet_access__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/cgroup_skb_direct_packet_access.c b/tools/testing/selftests/bpf/progs/cgroup_skb_direct_packet_access.c
new file mode 100644
index 000000000000..e32b07d802bb
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/cgroup_skb_direct_packet_access.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+
+__u32 data_end;
+
+SEC("cgroup_skb/ingress")
+int direct_packet_access(struct __sk_buff *skb)
+{
+	data_end = skb->data_end;
+	return 1;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.56.0

