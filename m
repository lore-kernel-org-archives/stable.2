Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC4A13A86C;
	Tue,  7 Jul 2026 08:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783412643; cv=none; b=Ha5E4+bhveMLOdLC1tqzgbBX8HhjPK5PfiQrHZbGeoClagHFK6UYPkUhtO1WN0i+xzYjRfYru4Sd/lbfiOTzoHY6qyg0uQBNENd7NbnPli7rmiIcs+XmT3/fTQxEU12HMQJam7njLop5vfeTM09aCH+1vYhqrpBcuisJhYQWx1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783412643; c=relaxed/simple;
	bh=D4WUkoQaUPJo2oVQHmTUMdxUZq1ZzTk7Cf3+fZ9QUcA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jkoJR8PmNiTPIK0RnKcGj8MJRMiSLaaeOj2R+B3Bw18eciMk+eRiccLXJ2/QixrMWuaKk1qLEIRYiFmytMRHyAzx0hteLiSI0HhP3C7N2ZE+s9ya+VFWeo1zgAjexrg7lVKmZ5OxCTwx4u2P7L5zx0TLvNgqkxhTCoTRSohku7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=bnGGKTSU; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="bnGGKTSU"
Received: from hwang4-g16.bbrouter (unknown [120.238.231.45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 6202A3F69E;
	Tue,  7 Jul 2026 08:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1783412639;
	bh=otMAzx7L+EJebfLdNISLzbMHGsQZXuDqmd8aKwVYc/E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=bnGGKTSUbNlNP0VVRDC3fO+W+Hj5ZoeBQD4xSTvu4gryGUXFGQmNMUjIFv7KuH0wY
	 579unEq4AXYrPnSlxw54cfLmMPah/0xtTZAJjlHo2EY5+szxtTZYo0UbFdnIvGKIdu
	 a5nJNnCu0NktB3qNsqhxW0W0LwhIetQVjZPNcDTLYps0HnPdlgtANIm5KGzjatv/0h
	 rY6AwhqpNFbqbWqFIS2dQgWuVK5JeoYiQ0xxgtLklreykYWZfY/o5f3EXXpgv+ngj1
	 39Ianr/6qpbJtPug/KKg20Yb9MMPkR3jXakjNpkb/0swBPkAGtIKAWKpyTRi5m1gWu
	 p5hbYOTEzGV+u5y5XpBKKFSJD5yfCev4cB2vnlrh0yMvLpTkWr33buPLFrD/a9RLKr
	 J8DBW19L/8i6xxNApEGIfPO8bgr8AqTA+Mjk0KNDAqyRpsWfJrU888ECoegcnLHwg6
	 ePPDRrPw506Jf7OGJQJt2td94EjuMm3M/xghT9bJ8zCior+PBc/bEOzNSd6HZl/C9C
	 DR7jn1THL+cfNKYI1TUEN+F6D6KpnzNhhzIhyCc4Q6ZwZpiiwd0/PCEphJ9YkMq+Kx
	 aSFA7t8suEaPxvpvCOccpJqe+SW1s8kItuSV2YRKKgLRdmBNpva/rmBEJz82JZPtHQ
	 +UcdWR2XmelrEadGr1yRJGK8=
From: Hui Wang <hui.wang@canonical.com>
To: mathieu.desnoyers@efficios.com,
	peterz@infradead.org,
	shuah@kernel.org,
	paulmck@kernel.org,
	boqun@kernel.org,
	zhouquan@iscas.ac.cn,
	ajones@ventanamicro.com,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: stable@vger.kernel.org,
	hui.wang@canonical.com
Subject: [PATCH v2] selftests/rseq: Fix a building error for riscv arch
Date: Tue,  7 Jul 2026 16:23:48 +0800
Message-ID: <20260707082348.36896-1-hui.wang@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RISC-V rseq selftests include asm/fence.h from tools/arch/riscv,
but the rseq Makefile only adds tools/include in the CFLAGS, this
results in the building failure both for native and cross build:

    In file included from rseq.h:131,
                     from rseq.c:37:
    rseq-riscv.h:11:10: fatal error: asm/fence.h: No such file or directory

To fix it, add the matching tools/arch/$(ARCH)/include path in the
CFLAGS and derive ARCH from SUBARCH for standalone native builds where
ARCH is not set.

Fixes: c92786e179e0 ("KVM: riscv: selftests: Use the existing RISCV_FENCE macro in `rseq-riscv.h`")
Cc: stable@vger.kernel.org
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 tools/testing/selftests/rseq/Makefile | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rseq/Makefile b/tools/testing/selftests/rseq/Makefile
index 50d69e22ee7a..aba6317f6cb8 100644
--- a/tools/testing/selftests/rseq/Makefile
+++ b/tools/testing/selftests/rseq/Makefile
@@ -5,9 +5,13 @@ CLANG_FLAGS += -no-integrated-as
 endif
 
 top_srcdir = ../../../..
+include $(top_srcdir)/scripts/subarch.include
+ARCH ?= $(SUBARCH)
+LINUX_TOOL_ARCH_INCLUDE = $(top_srcdir)/tools/arch/$(ARCH)/include
 
 CFLAGS += -O2 -Wall -g -I./ $(KHDR_INCLUDES) -L$(OUTPUT) -Wl,-rpath=./ \
-	  $(CLANG_FLAGS) -I$(top_srcdir)/tools/include
+	  $(CLANG_FLAGS) -I$(top_srcdir)/tools/include \
+	  -I$(LINUX_TOOL_ARCH_INCLUDE)
 LDLIBS += -lpthread -ldl
 
 # Own dependencies because we only want to build against 1st prerequisite, but
-- 
2.43.0

