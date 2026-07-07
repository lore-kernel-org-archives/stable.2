Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5491130E828;
	Tue,  7 Jul 2026 08:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783412259; cv=none; b=kKYe7v9cWtyi0+WuAKOkODqDfX0vsPU+/0tB0LzZq1F0XJhN9DbNJKniznbZqqawFGR4zAEu8O29eW32xAoY808Be60zte1CmoOLTCiioVdlvsVj7A0htvPcls1bjG7ETgHtbHrdLraWY2tf3vH3CSEJwkCNubigS22eRynsQfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783412259; c=relaxed/simple;
	bh=D4WUkoQaUPJo2oVQHmTUMdxUZq1ZzTk7Cf3+fZ9QUcA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iy6Xiti0Vp3KiQo4f6yPg/52jBvvIoBWk86dkWnU+UpIecWLrAUHrLX1t2d5VcvGb5A9d6YZA6MLStmXvdw6Uu16zPz7xDpHRJ/7WFM1uHrnuWE8F6ifyqHr8mRwEPfx4FXJsIUeN0UAwVh1OqsZnp3cgWowlTF8dvtkeKos34c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=jt6Jcxn0; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="jt6Jcxn0"
Received: from hwang4-g16.bbrouter (unknown [120.238.231.45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id F3EA93FA33;
	Tue,  7 Jul 2026 08:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1783412247;
	bh=otMAzx7L+EJebfLdNISLzbMHGsQZXuDqmd8aKwVYc/E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=jt6Jcxn0VYub3FkHe82hTT3pEN+eoES0gf7ubygT9lWMEF181m6AU4aTZ5VOpIAsb
	 hlzltzbipxfTABlDYYnhMVVjc8q9i6g/x2vvUL1C5bAXcQdBZvWu+WwhcmrpZo9CO9
	 4OWZiFgR34V+DM9jf8pFVkX6x7WYlrahUjiVWHmxfn5o/gq2VX+FuPZm83KChwbTIy
	 X+VEnyoscPHPJusZgOWy91yYnU1SjXXAklFhM4w4qgbd0E5RECGtsDK3yGaLVjAlIG
	 TnCA3sN8XINmn9yNecqF8TWP6mRBbFe/BGsHn0vWyOP7qD0XyrYtqSwnifKroGfwmB
	 OopHLPPMj9CwnH2OucrOfJ9t+VvYZHgYBtoy0W4nDS78tbJRz5kL23VxFOjqb3jDCh
	 B76U77e8o59DTHMUx27GfTzP41f2jKLzp6phPaChoCFxGS+G6x0ItDd0fol0EWvSMz
	 OwkU5I8/8vzaobaoGsd1q3zhddlhqx71EEfDh+MqmAYqAp1oCsCWx8DNqKPfA672YS
	 AMkTsPOd6ZE4Fw/MgoThW8FBV0K2p5KJH7jUFRaoq0H+QQVuX9Mocb/dku3ieT4j2e
	 6gjZs7pJmKFkJf9ZPOprLOPyrYcaC1Nas5wKlYe0CmJEI0Nx0tEljUQ+ETc+EetIKJ
	 9DqZNvQxehSS4bkYnfxhYF+A=
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
Subject: [PATCH] selftests/rseq: Fix a buliding error for riscv arch
Date: Tue,  7 Jul 2026 16:17:20 +0800
Message-ID: <20260707081720.36510-1-hui.wang@canonical.com>
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

