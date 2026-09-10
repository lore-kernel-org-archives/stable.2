Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543164A093A
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 14:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789049186; cv=none; b=SHPiiWpDgOa004WSWDWkvEobIm/JJE+G7Rh9j1XxI7mC8xLwyaDuHETwj85D+JXrUZ+KuIlz0fBsD/LvLLFN2HVN/a/3WnqTGMSARAtwWIpR5+9n2tUQqCXbceS83QHG2NcyB/k8sj5ygShJiSheYuz5vdcGJs3AOK6v6wZBO7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789049186; c=relaxed/simple;
	bh=FvIgU8mBKZE6rp5SK3nC7PRhb+0vCYIWHxW4kHO2+60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=akZDj8o2Dbzw3hTtN8ezH5F8V1YR3yROZaxVKVuCacLGPYV5i2xrpQGMm93XhuSbn5BT2+60fNR2MWOmkdSyk7I8Yr4syIsHwMg6l6DHGzVCPw4/TnqHoQTI31ZdqGHaN3xHtM9iB2ci1AvfVgxABv0ltCZa8yIxJrmy+Rqpxc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jk0ost6v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jk0ost6v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3EF01F000FF;
	Thu, 10 Sep 2026 14:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789049184;
	bh=s0tyfLPkpEcEHoN5kP3SRelLFYjtxn23wo12H2vP/G0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jk0ost6vnkWvH2mLoUajSIaPp3gMUxZMyTX64gUDzJow705moSYR6J9l0+CWLRI50
	 uNf6zRrw6TiMtFDP31d9qAc8hZPzOY/aq1Qy4SnIdMe+uXWexo6Iq4gPOv4nFWXhS5
	 fTI9GchcyHkBGSF48bDr7CAv85DhWxu5wJlOVc9GLxvKn2we8MnQmmySEhw5zxlbOL
	 blDSX68/4a09iHn+gDAPUIIz8CZ/05vqlLYa3agoX/Z7XvFhPa12xdq0Z7P4yuNsaq
	 3thz5/yEopnGBCmnFJyqy0M6LMifzKgfOlyFm7CxYZl9tWRPp3N78EUFd+FphoZkSv
	 Up21U7l6dX0zw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Marco Elver <elver@google.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/3] compiler_types: Move lock checking attributes to compiler-context-analysis.h
Date: Thu, 10 Sep 2026 10:06:20 -0400
Message-ID: <20260910140622.565169-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090836-asparagus-jujitsu-9a6e@gregkh>
References: <2026090836-asparagus-jujitsu-9a6e@gregkh>
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
index 2f18b8a01afe6..ba49413f704be 100644
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

