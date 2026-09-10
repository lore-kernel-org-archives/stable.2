Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1267D49BD74
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 15:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789055565; cv=none; b=CtlwZsk0/RQ32E4mB4lR4rc67wgz7vEsefQKYUbCMzg8aJ1iOBhymzJuUNhjWbkU8iGm5GvtFk9ZWgy0M0uDGBSnZr+GHayMsCT1RplAo0yD6uRL15gsYvHySE8e2W1QHW7x9b3/pRSJqcpOQO73HYoq41XbG9zgVJLYXeodrok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789055565; c=relaxed/simple;
	bh=5RnC7Ty9GO0gzcNrR+VM01nfNJwIUTujog68Yd4YArA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zf1TP5i5IQD2CxxCKYcgTS43wS7sJgHDq6krq82omQneUa+C17Uli0sFpIkF380jbUqDUhmNuVvnhv+M3sgeCb3/dVcZSv+e/gsbJyx9qf7u6I3ynYWiQwvv3lH690d0wMcBB2OKSv90q2Qo4QIt3yUMU/cglVfIBt/8PFRiLxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G5L5Girj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G5L5Girj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 623A01F00893;
	Thu, 10 Sep 2026 15:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789055564;
	bh=t6RORo/TUQxdx9pGSZQTmB239MBNaW5W9/vUigYi7L4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G5L5GirjMXOYcfb/VLVyvQ5mGSWjBYNMlo3Z7kbFHFAF1O0962GmYKV/VFOJtfdci
	 mQx5tvlCMzKShL9amDw3SVSpJXl0FNYNh01eLTnsaQ8ljqjqJKaDka+39xi5qoosMq
	 K3gfpOuKf5BdVgFb4IZj+gbRc5dQL/84KZqgNaJyssQLbYbY29t4cMrPNiOzCwMoj4
	 a13PQnOAxc40msYshQfUnFEXzj01SG7ZNs0KTmdCpiROM//UfRAob14Sn7y1taAh49
	 UeJuj5gOpslzkA6z2dIskFtZJKxZojsI+I8A5bCy4KL1TwXeFAqKshsO4ih3rVwGqj
	 nHsqon/EweF3Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Marco Elver <elver@google.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] compiler_types: Move lock checking attributes to compiler-context-analysis.h
Date: Thu, 10 Sep 2026 11:52:40 -0400
Message-ID: <20260910155241.1081251-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090837-colonist-magnify-011d@gregkh>
References: <2026090837-colonist-magnify-011d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marco Elver <elver@google.com>

[ Upstream commit de15fecae44df8254fa597bad7eb3680a8b1c10c ]

The conditional definition of lock checking macros and attributes is
about to become more complex. Factor them out into their own header for
better readability, and to make it obvious which features are supported
by which mode (currently only Sparse). This is the first step towards
generalizing towards "context analysis".

No functional change intended.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Link: https://patch.msgid.link/20251219154418.3592607-2-elver@google.com
Stable-dep-of: 912edebe8501 ("futex: Provide rt_mutex_.*_schedule() equivalents for futex scheduling")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/compiler-context-analysis.h | 32 +++++++++++++++++++++++
 include/linux/compiler_types.h            | 18 ++-----------
 2 files changed, 34 insertions(+), 16 deletions(-)
 create mode 100644 include/linux/compiler-context-analysis.h

diff --git a/include/linux/compiler-context-analysis.h b/include/linux/compiler-context-analysis.h
new file mode 100644
index 0000000000000..f8af63045281d
--- /dev/null
+++ b/include/linux/compiler-context-analysis.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Macros and attributes for compiler-based static context analysis.
+ */
+
+#ifndef _LINUX_COMPILER_CONTEXT_ANALYSIS_H
+#define _LINUX_COMPILER_CONTEXT_ANALYSIS_H
+
+#ifdef __CHECKER__
+
+/* Sparse context/lock checking support. */
+# define __must_hold(x)		__attribute__((context(x,1,1)))
+# define __acquires(x)		__attribute__((context(x,0,1)))
+# define __cond_acquires(x)	__attribute__((context(x,0,-1)))
+# define __releases(x)		__attribute__((context(x,1,0)))
+# define __acquire(x)		__context__(x,1)
+# define __release(x)		__context__(x,-1)
+# define __cond_lock(x, c)	((c) ? ({ __acquire(x); 1; }) : 0)
+
+#else /* !__CHECKER__ */
+
+# define __must_hold(x)
+# define __acquires(x)
+# define __cond_acquires(x)
+# define __releases(x)
+# define __acquire(x)		(void)0
+# define __release(x)		(void)0
+# define __cond_lock(x, c)	(c)
+
+#endif /* __CHECKER__ */
+
+#endif /* _LINUX_COMPILER_CONTEXT_ANALYSIS_H */
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index b624f3e8716b1..286822a3c9133 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -37,6 +37,8 @@
 # define BTF_TYPE_TAG(value) /* nothing */
 #endif
 
+#include <linux/compiler-context-analysis.h>
+
 /* sparse defines __CHECKER__; see Documentation/dev-tools/sparse.rst */
 #ifdef __CHECKER__
 /* address spaces */
@@ -47,14 +49,6 @@
 # define __rcu		__attribute__((noderef, address_space(__rcu)))
 static inline void __chk_user_ptr(const volatile void __user *ptr) { }
 static inline void __chk_io_ptr(const volatile void __iomem *ptr) { }
-/* context/locking */
-# define __must_hold(x)	__attribute__((context(x,1,1)))
-# define __acquires(x)	__attribute__((context(x,0,1)))
-# define __cond_acquires(x) __attribute__((context(x,0,-1)))
-# define __releases(x)	__attribute__((context(x,1,0)))
-# define __acquire(x)	__context__(x,1)
-# define __release(x)	__context__(x,-1)
-# define __cond_lock(x,c)	((c) ? ({ __acquire(x); 1; }) : 0)
 /* other */
 # define __force	__attribute__((force))
 # define __nocast	__attribute__((nocast))
@@ -75,14 +69,6 @@ static inline void __chk_io_ptr(const volatile void __iomem *ptr) { }
 
 # define __chk_user_ptr(x)	(void)0
 # define __chk_io_ptr(x)	(void)0
-/* context/locking */
-# define __must_hold(x)
-# define __acquires(x)
-# define __cond_acquires(x)
-# define __releases(x)
-# define __acquire(x)	(void)0
-# define __release(x)	(void)0
-# define __cond_lock(x,c) (c)
 /* other */
 # define __force
 # define __nocast
-- 
2.53.0

