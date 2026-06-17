Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB03D346E55
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 17:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781716864; cv=none; b=P7qi6qQ+9pib+F62MChQHtRIKHuRGDByjdJGp/HpQu7yAQXpG8bSowzPrN9iPB9/rTuz3bk178SDLCIw3ZypH++1R0UGSx57rB1vU/IUtLKUd4a0A9dWElLoq19wgYny/VOmZlU3vzPBJdEU8MPniGVBm1iKK2d6/APOwUzzaGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781716864; c=relaxed/simple;
	bh=dgTvGU49cBFDkj7IP9PbmLD68usnIxvn73O4yGjhoBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nHNaFGMYqiNBwBkVAzbCyBWOI9umBPxqoPhlA16JgoKb2E0bVJPujJk/KauEoKeWUklgJlquQTQjh9x2Ctp3Fm8cviAKWLgXKbGyt4wh8F2rZnFCR4wZQZT7PYfs3VxX1trEyaA2sFPfKRLHrpMT3E1ejfahJdzWTykVbLCaFU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jAKFH2pq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jAKFH2pq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFEEA1F000E9;
	Wed, 17 Jun 2026 17:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781716861;
	bh=iRg4KkahyL7x4u/2Zf448ud+T1To4PK/YszaWWSdOyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jAKFH2pqKWNmlNDp12pagxjxx3sE+OKGztLnsXu8mTEtI2aMI3hcU5lhBS1K51dRW
	 /q8zAcxJhkL+rLVmlG7joyG8Rl7Uiy8FqqnLvBWEiMmqZMwBFU1oTyHed7HQbU3l00
	 fB2k0xfBK9ZfysnVTRFYJJss/90+R5hpcacZfWjK9yWMpYebggJGfEFHUhiXd8px6s
	 9W7G2XPZeoZqNTx4AVFMwSiOa4wY0i/zy6uXoA/hvEB4E4lZvkSQUI3lS1QCDwgEm7
	 Jp7f9mT26k57eRx1B1YxDKl8OTT+JHuN7OMJnR9l3J81OLwof2/+uwIqVrF1hysvC7
	 PK0rBXfl3x6Lw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bill Wendling <morbo@google.com>,
	Kees Cook <kees@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/6] compiler_types.h: Attributes: Add __counted_by_ptr macro
Date: Wed, 17 Jun 2026 13:20:53 -0400
Message-ID: <20260617172058.253463-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061553-curly-gigahertz-3ad1@gregkh>
References: <2026061553-curly-gigahertz-3ad1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bill Wendling <morbo@google.com>

[ Upstream commit 150a04d817d8f5be5a4f92799827cdc8d7e45989 ]

Introduce __counted_by_ptr(), which works like __counted_by(), but for
pointer struct members.

struct foo {
	int a, b, c;
	char *buffer __counted_by_ptr(bytes);
	short nr_bars;
	struct bar *bars __counted_by_ptr(nr_bars);
	size_t bytes;
};

Because "counted_by" can only be applied to pointer members in very
recent compiler versions, its application ends up needing to be distinct
from flexibe array "counted_by" annotations, hence a separate macro.

This is a reworking of Kees' previous patch [1].

Link: https://lore.kernel.org/all/20251020220118.1226740-1-kees@kernel.org/ [1]
Co-developed-by: Kees Cook <kees@kernel.org>
Signed-off-by: Bill Wendling <morbo@google.com>
Link: https://patch.msgid.link/20260116005838.2419118-1-morbo@google.com
Signed-off-by: Kees Cook <kees@kernel.org>
Stable-dep-of: bf296f83a3dd ("firmware: samsung: acpm: Fix missing LKMM barriers in sequence allocator")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Makefile                       |  6 ++++++
 include/linux/compiler_types.h | 18 +++++++++++++++++-
 include/uapi/linux/stddef.h    |  4 ++++
 init/Kconfig                   |  7 +++++++
 4 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 0b24b388e16c29..1f3f256adf5cb5 100644
--- a/Makefile
+++ b/Makefile
@@ -939,6 +939,12 @@ KBUILD_CFLAGS	+= $(CC_AUTO_VAR_INIT_ZERO_ENABLER)
 endif
 endif
 
+ifdef CONFIG_CC_IS_CLANG
+ifdef CONFIG_CC_HAS_COUNTED_BY_PTR
+KBUILD_CFLAGS	+= -fexperimental-late-parse-attributes
+endif
+endif
+
 # Explicitly clear padding bits during variable initialization
 KBUILD_CFLAGS += $(call cc-option,-fzero-init-padding-bits=all)
 
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 2f18b8a01afe62..1d2f49cf315d7a 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -378,7 +378,7 @@ struct ftrace_likely_data {
  * Optional: only supported since clang >= 18
  *
  *   gcc: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=108896
- * clang: https://github.com/llvm/llvm-project/pull/76348
+ * clang: https://clang.llvm.org/docs/AttributeReference.html#counted-by-counted-by-or-null-sized-by-sized-by-or-null
  *
  * __bdos on clang < 19.1.2 can erroneously return 0:
  * https://github.com/llvm/llvm-project/pull/110497
@@ -392,6 +392,22 @@ struct ftrace_likely_data {
 # define __counted_by(member)
 #endif
 
+/*
+ * Runtime track number of objects pointed to by a pointer member for use by
+ * CONFIG_FORTIFY_SOURCE and CONFIG_UBSAN_BOUNDS.
+ *
+ * Optional: only supported since gcc >= 16
+ * Optional: only supported since clang >= 22
+ *
+ *   gcc: https://gcc.gnu.org/pipermail/gcc-patches/2025-April/681727.html
+ * clang: https://clang.llvm.org/docs/AttributeReference.html#counted-by-counted-by-or-null-sized-by-sized-by-or-null
+ */
+#ifdef CONFIG_CC_HAS_COUNTED_BY_PTR
+#define __counted_by_ptr(member)	__attribute__((__counted_by__(member)))
+#else
+#define __counted_by_ptr(member)
+#endif
+
 /*
  * Optional: only supported since gcc >= 15
  * Optional: not supported by Clang
diff --git a/include/uapi/linux/stddef.h b/include/uapi/linux/stddef.h
index 9a28f7d9a3342d..111b097ec00b0a 100644
--- a/include/uapi/linux/stddef.h
+++ b/include/uapi/linux/stddef.h
@@ -72,6 +72,10 @@
 #define __counted_by_be(m)
 #endif
 
+#ifndef __counted_by_ptr
+#define __counted_by_ptr(m)
+#endif
+
 #ifdef __KERNEL__
 #define __kernel_nonstring	__nonstring
 #else
diff --git a/init/Kconfig b/init/Kconfig
index cab3ad28ca49e7..5cfd79a2fa790e 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -139,6 +139,13 @@ config CC_HAS_COUNTED_BY
 	# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=108896
 	default y if CC_IS_GCC && GCC_VERSION >= 150100
 
+config CC_HAS_COUNTED_BY_PTR
+	bool
+	# supported since clang 22
+	default y if CC_IS_CLANG && CLANG_VERSION >= 220000
+	# supported since gcc 16.0.0
+	default y if CC_IS_GCC && GCC_VERSION >= 160000
+
 config CC_HAS_MULTIDIMENSIONAL_NONSTRING
 	def_bool $(success,echo 'char tag[][4] __attribute__((__nonstring__)) = { };' | $(CC) $(CLANG_FLAGS) -x c - -c -o /dev/null -Werror)
 
-- 
2.53.0

