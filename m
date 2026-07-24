Received: from mail-ed2-f11.google.com (mail-ed2-f11.google.com [74.125.228.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6352F37882E
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 07:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784879326; cv=none; b=K1dHL8GNTnjtNAIBYZzZdwY5UEm+Cso0LV4XZUKzonxrugjh4OOfxYzVh7qPe46w7wQExOlfCEJF5ceNlN2LNUVQ21kzxhiRkslrydlxXm049/Of89ZwF7UBRXNwLt+rnzv523Yv9sJjR/VaMqAwNT4KdspymwKy8mlYYLTmjog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784879326; c=relaxed/simple;
	bh=2HrvKMPJvRzkGZt6encJFJtIUdaK4hOehaYNpRdHJ60=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oEdWcylaNL6Jf4uD0eda4v1wibHDSvyEyS+Re3THW6Zei5hc7GkDIwNetvg9lRnEsypfgB6OUQVhPpZYoxHRD7Q0khAjggCJrTjfWrwUqC1uaVGDQMWRkcbFrYmyKRXUo2QRJ9gbyoWQ1YYwwCNdj4tcGfYibX1h04/sQZQ3hew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LZGzu1Lx; arc=none smtp.client-ip=74.125.228.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LZGzu1Lx"
Received: by mail-ed2-f11.google.com with SMTP id 4fb4d7f45d1cf-69f4b000237so69046a12.0
        for <stable@vger.kernel.org>; Fri, 24 Jul 2026 00:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784879321; x=1785484121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qi0JEhFLxcRG+++ypOP0k6UMvF8zVzdmBPYweQRWU4k=;
        b=LZGzu1LxC9ZSzWxq55QurElhmAp/uyCGc0XSh+qJsicf0xdIYqchIi8xLogKHCat5c
         bRtWiHgIo0nlomsgyKRhIAdL5HMwhrKxNtJTrsoTvTvNAMOJGE9GaIuLOZQaUyhnH1kj
         FL7iB57YEpzTxEwRvDyQL870FQSGBEGt10xTsls0Q0Cl4q0JwIygaAQjstRS7eArvQyl
         BTgg6tkReaGBLzBbfOEfMoUIaMlRjaR/m/sgpb35s0AWvLPZuDZEggQXvXYa6zHBee7o
         cwAXV5aEMa9da/RQHA48o6mRrcmV18GZP69S9EOqdBIF0TVycwkspY/5yrG24seJDEs1
         wHaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784879321; x=1785484121;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qi0JEhFLxcRG+++ypOP0k6UMvF8zVzdmBPYweQRWU4k=;
        b=T2Ensn9b9Cq18Tqip6tRZ4rSH1tNQ2j7P62A59kLQMeH9G91X5HzjtEjlgQ55/fbJi
         DgK5CABMr+cS3xhH15S4/quAbFgiTkD8EweH0MUX9FXseuyCBr99anlsob0yEJ8STtb9
         i3U8doEDXS4nxTENKA3KJzh3ktUU2JYvfNqekVWcKo18TztoXWGGkVewnkZnMWLcWfK7
         Z0FVTUSGkN8Hy2YSFFIPLlfw5EpjhvTtpY8eLt1DfsCGLETsLQKcKWp6qNvX+jlPLUCP
         Jne92DxG2HCSrLwdDGrQzBzGdzHbmCKiZ7qO4W4yPi4fQFl1t15Z9xlnKGJG7LXmsdeI
         cGGg==
X-Gm-Message-State: AOJu0YzY06q8kXuN+Tg7oF/GiPr5tcethTHIn6w/xuCPzOntl8L7salQ
	zRScGCa2XTuEyITKRJT4iNr7QHhVPcrGNArYzMFn3rPXLRk0bkVN4rDfWVNEAaAkJvy2Sqnh50e
	0/v0rrJSGnDXh3lg=
X-Gm-Gg: AR+sD11Z7PuyGi6GssbbW1DZrCNhtAV0VqgK0zt7GgnE3JaiIZ0W6n/cVIqdt6VK+JV
	7lhPwgaINgz7Q8F9hman8z7hNWuOauB0fM2L1kBiD5xrTfdFutwNoqhVOW0POq+Ohk9NCKq4Jv5
	g+CP93P+CFi0Xyam334rw7uOLUKskDuIIEnIvUJ6OX3WkB06+HeklD/AbnbNFvPo7YkheiZsMZ0
	eKmtO/MrrjXint4WonL7MFqcFU4/2/J6p0uTfdeg/ATdxO9Bd8VylzP81e/jFszQ+Jo/tRcRH71
	wwer7xmKuor2GQOSeT1ve6dK8WkFh4nU+4KuWeHOlCHUeWm3rGyU/IcVjG7bEFN/Ea6fqa3tpAm
	Ji9r2OHO95sfUBWmpS7JAWro+GEC1oft9sgMsRraVFsZCP1GuA9txMnriP6WrYZALd0YUuFL2Hi
	TRC1oQsgr1XG7/idGp9mCrskrprdJN03cpoe0=
X-Received: by 2002:a17:907:25c3:b0:bed:9a7:5ed1 with SMTP id a640c23a62f3a-c1c506e8a62mr271526166b.5.1784879321545;
        Fri, 24 Jul 2026 00:48:41 -0700 (PDT)
Received: from localhost (61-227-70-26.dynamic-ip.hinet.net. [61.227.70.26])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbb8f02e454sm3904386a12.0.2026.07.24.00.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 00:48:40 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Jann Horn <jannh@google.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Liam Howlett <liam.howlett@oracle.com>,
	Sidhartha Kumar <sidhartha.kumar@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Dan Williams <dan.j.williams@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH stable 6.6 1/2] tools/testing: add linux/args.h header and fix radix, VMA tests
Date: Fri, 24 Jul 2026 15:48:33 +0800
Message-ID: <20260724074835.47479-1-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

commit 9a6a6a3191574a01dcf7a7d9385246d7bc8736bc upstream.

Commit 857d18f23ab1 ("cleanup: Introduce ACQUIRE() and ACQUIRE_ERR() for
conditional locks") accidentally broke the radix tree, VMA userland tests
by including linux/args.h which is not present in the tools/include
directory.

This patch copies this over and adds an #ifdef block to avoid duplicate
__CONCAT declaration in conflict with system headers when we ultimately
include this.

Link: https://lkml.kernel.org/r/20250811052654.33286-1-lorenzo.stoakes@oracle.com
Fixes: 857d18f23ab1 ("cleanup: Introduce ACQUIRE() and ACQUIRE_ERR() for conditional locks")
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Jann Horn <jannh@google.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 63c49efc987a ("selftests/bpf: Add simple strscpy() implementation")
[shung-hsi.yu: tools/testing/shared/linux/idr.h was
tools/testing/radix-tree/linux/idr.h before commit 579d8dab47 ("tools: separate
out shared radix-tree components"). ]
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 tools/include/linux/args.h           | 28 ++++++++++++++++++++++++++++
 tools/testing/radix-tree/linux/idr.h |  4 ++++
 2 files changed, 32 insertions(+)
 create mode 100644 tools/include/linux/args.h

diff --git a/tools/include/linux/args.h b/tools/include/linux/args.h
new file mode 100644
index 000000000000..2e8e65d975c7
--- /dev/null
+++ b/tools/include/linux/args.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _LINUX_ARGS_H
+#define _LINUX_ARGS_H
+
+/*
+ * How do these macros work?
+ *
+ * In __COUNT_ARGS() _0 to _12 are just placeholders from the start
+ * in order to make sure _n is positioned over the correct number
+ * from 12 to 0 (depending on X, which is a variadic argument list).
+ * They serve no purpose other than occupying a position. Since each
+ * macro parameter must have a distinct identifier, those identifiers
+ * are as good as any.
+ *
+ * In COUNT_ARGS() we use actual integers, so __COUNT_ARGS() returns
+ * that as _n.
+ */
+
+/* This counts to 15. Any more, it will return 16th argument. */
+#define __COUNT_ARGS(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15, _n, X...) _n
+#define COUNT_ARGS(X...) __COUNT_ARGS(, ##X, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0)
+
+/* Concatenate two parameters, but allow them to be expanded beforehand. */
+#define __CONCAT(a, b) a ## b
+#define CONCATENATE(a, b) __CONCAT(a, b)
+
+#endif	/* _LINUX_ARGS_H */
diff --git a/tools/testing/radix-tree/linux/idr.h b/tools/testing/radix-tree/linux/idr.h
index 4e342f2e37cf..676c5564e33f 100644
--- a/tools/testing/radix-tree/linux/idr.h
+++ b/tools/testing/radix-tree/linux/idr.h
@@ -1 +1,5 @@
+/* Avoid duplicate definitions due to system headers. */
+#ifdef __CONCAT
+#undef __CONCAT
+#endif
 #include "../../../../include/linux/idr.h"

base-commit: 1700dc5387811a6517b390294a98b51adcbf1794
-- 
2.55.0

