Received: from mail-ej2-f3.google.com (mail-ej2-f3.google.com [74.125.228.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D64369203
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 07:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784790830; cv=none; b=b3szdCoAOXD2QLKJ6xyXlm46Ug2onVHQb/vHTlyKEAUqTpSm6fakFoL1rQovDFAYSaYqFR7sqhqpJPkGrl8V9gC2q6IAogDhHvdUYCCqGmkAgHnfcs2zmTLQsQchbO8/TE8+8fkLt9bEoQmQVNt6Tf7sbKyLbc6kJAKKKoyDZ10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784790830; c=relaxed/simple;
	bh=lzNj4r9bnTh+aOZl93ZMRRm8wK2eWavZqqUcDf8wIB4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hSEMoDfaZ60ObMvMIXz4+D6SXTdN53PG+3uB/KX2bqytdq0SgD4JTENN4U8CdpGNmLIfXcyX7IAymYgsMN/3D59vrOwkCwdqwdUGL3I4V8oSGM7dF+5h+n6VUB41ia7wkr3oIs5W8hWd7ynawtUBRCjdUKv/OhcQtHy3Kx/ISiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FLispUBB; arc=none smtp.client-ip=74.125.228.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FLispUBB"
Received: by mail-ej2-f3.google.com with SMTP id a640c23a62f3a-c15dc93e168so19318966b.1
        for <stable@vger.kernel.org>; Thu, 23 Jul 2026 00:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784790823; x=1785395623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HocOFD+d0g5u6xwuOHKKGYNNJQw5E4UHoUKytktQPDc=;
        b=FLispUBB30kIweaO75vmxrl9TKOQe1WQq+n4JrgjqsT7djPnh67hNpPAOQYrbTZvhQ
         WFkRk6kcDg01VtXr7YGdAa7cJscPlhh6WvTdRhDPENO/1XC6I7VZpZIWC+fIaKCLhSlq
         F5ZQszTrR2/tBJKRNMysJG1UHwCoxDHbKVB4EhMyJh74hETZznewFocLCBrbBYwnGZBp
         N55UfU4Te+WCshk39t3IUiBXBLUODkQ0cQBee5Mo+hmBwTi+9lByPHftx/kaRCdH/OlD
         K48ZZWYdp8gkmzMlaKqA5d79XAtXSxYr/8j4s+pYL6lnfpmh1eeLCAP3lXt1IkClLGr6
         nV+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784790823; x=1785395623;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HocOFD+d0g5u6xwuOHKKGYNNJQw5E4UHoUKytktQPDc=;
        b=nlZj+dY2ZylWQyJ9PPLgTAJZvs4fBBVtMkd+IHGPMSjW54KzK2gQSAPG1sGZOa69S6
         KnjE5T8bFEDFj07MePI7J1NJ3i2x6bg1LWZ4BklOFQU/cIoWiKcfHN58ex3OGRE/YLve
         4OIRtV+o5p0TU8mLH1Vf+E9kowbyP/9s4uBg3cCjrqSXGxhzv39TRm+u9cZ2pl8alfML
         je8D2cELMfkLf0lH1TiBWUXliQHnElVvJ0Ou5DY01l2pTTdEHY3HvoHTJvIaTZa/dt/J
         jUk6Il+yQRdF11fa/5EByrkNkpJa49srHa3688aB6OVpmlG97xImvdREWo/jxlmbZbJw
         FNyA==
X-Gm-Message-State: AOJu0Yw3sir6FD+L2IWXx6794pBlTyD80hGMNb2Slaq2hvoXhu71ogyA
	rYry0OKRMikPOSUfhfGUla6Aqjjz2rGusX4jTRfCjSyCSqB8vpPOZmA4xdZwVE2w73ABvJL7wfx
	Cjfs73flMVNeDjkQ=
X-Gm-Gg: AR+sD13N1IFXKh4mv07rrhLfB5mQ1/aJ91USRSnmpNFv+HYvPtwSEeL54LBx8epkI4P
	UQDpH3U8us3TH3/Y7ac1QCWT9+2vaEchLqVBTQ/8OnahFuVrtzqq7FXz6pmKXXjYHABdS1++eb0
	2djzoO6YiGon8Dq4J2g9XPzbBaphlhMsq7Br6ucdrBryJAsBl24Y95fQSZgi92MJdoe9NVNUERH
	PPamkrhKuoXQHzgWXYHl3BjkhNRxCZDSfuEdFB/GiTiMgOpieNorNa6pOuXUnnX7nrdW7UQhl0d
	CkvvaVt75EVj8a79pb6wR21pHmpmlUDtBmYRJpVDVn3Ft9gkI7WIMj/MsWjrY/X6SXZ9emD8854
	DzO+jdnzQmrmQeDmT84IqLj7g1OHgu9x/9NtupK0uGxVN4wrGYTQG1/AVHBAoSMp6NRdKndVT7/
	8YdJk1Wb9r5fbB0kaLXMvGU7VE5A==
X-Received: by 2002:a17:907:26c9:b0:c12:9a13:47c with SMTP id a640c23a62f3a-c1c508d2116mr96577166b.2.1784790823191;
        Thu, 23 Jul 2026 00:13:43 -0700 (PDT)
Received: from localhost (27-53-97-40.adsl.fetnet.net. [27.53.97.40])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f3bbf58sm27591205ad.82.2026.07.23.00.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 00:13:41 -0700 (PDT)
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
Subject: [PATCH stable 6.12 6.6 1/2] tools/testing: add linux/args.h header and fix radix, VMA tests
Date: Thu, 23 Jul 2026 15:13:31 +0800
Message-ID: <20260723071334.39630-1-shung-hsi.yu@suse.com>
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
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 tools/include/linux/args.h       | 28 ++++++++++++++++++++++++++++
 tools/testing/shared/linux/idr.h |  4 ++++
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
diff --git a/tools/testing/shared/linux/idr.h b/tools/testing/shared/linux/idr.h
index 4e342f2e37cf..676c5564e33f 100644
--- a/tools/testing/shared/linux/idr.h
+++ b/tools/testing/shared/linux/idr.h
@@ -1 +1,5 @@
+/* Avoid duplicate definitions due to system headers. */
+#ifdef __CONCAT
+#undef __CONCAT
+#endif
 #include "../../../../include/linux/idr.h"
-- 
2.55.0

