Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794315640;
	b=S1GcnHlJwsf73m4czJrY66RuO5vvylb7O9Hc6i3EnjKycaKVpEH47Y6jF+mN3Ow3XND9
	 zqR93LRNliPIXpnYtzWEVHzCXPAyYQQjEJyHEFB1lLoR6r4PturELF2Ia4Jew0QS4+qxl
	 EI0Mw5XJsjJEGVMi6CAFVDRzrXUUKJcWNz53H3siPgG5d7oaagUA/vL/oO2eRrpTYcyFZ
	 i3Ou1HOK/hncpCPGpyE8l+o1rzr1J7irdxybC93RmeKiOAbCN0NLX2MeQt2zOeNOIySEg
	 4DjLOWNKcopNTAEVc3+nOcZG60o/2vQqMSxQamqXnPzRybWoUdIr3EF2JfyCSElRAxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315640;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Lzbqnixdu/0NrDr9AWIk4ZtcsNkzamI495+RJHbAe7Y=;
	b=2L6evqRqimePEFo1YpioKZO9OiwhdN0lJ8Dc/GdbkFokqOzGOTVhh5/TsQR9hXOCPDFT
	 n/RqmyzeL1hol7Ims2av+yFZmMXOdAVDp8z2E6lw2LtrGa+dPbDV3PUoIc9ZPadPsh6bB
	 6orBb3JURhwm4xIYumEBzH28UOi1ADQNTqoSfFYAMPfFA8b5SjhieigXvk1uIbxErlLbN
	 uO9g8EUz3BKw9Ho8TRfhFsBbnf49ZwYK+5n1j5HRYUxEUIywGec7yr8tXgYkqAq0Pah62
	 sfrQHe+d8XwuM6agtC3wrJ+WIVC82wrFCitN0g7XY0mLrFz/gy3f5iyL3XHeS3prsGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IH5DyE44;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5CD606A335
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IH5DyE44
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 694651F008A2;
	Tue, 10 Nov 2026 13:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794315640;
	bh=Lzbqnixdu/0NrDr9AWIk4ZtcsNkzamI495+RJHbAe7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IH5DyE44kQIQ03aLCuwF3wa2vi5lX5rf9KrTck7awT56QoumjM5z550nV8D3B+Jx7
	 wy13WtKJxY7lY63SKXt4Udz6ZPG1Fr0qRBHGorOUj/fts5OgpwCkWD53i687uth/Gb
	 BsrcvTCG9BHbFY+CYUtUFqQpy6ifm9drsC9wd91kSlh02UeyumyL8Rn1PgiG31R/Um
	 4iT/EcXkjJo4yDdfvspg+BKN2BNydXBTHMOLK27Zfe3VmeCLL/HeKU3Q/12kLg/uzN
	 0cQM43usipukfuCxgZX8DCZo+nLzCPrrkEtHDVrymm8ffyZNb05yCNI2IJxrb91lYo
	 A3mqTrVFtA3QQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Alexandru Ardelean <aardelean@baylibre.com>,
	Ingo Molnar <mingo@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] kernel.h: move PTR_IF() and u64_to_user_ptr() to util_macros.h
Date: Tue, 10 Nov 2026 08:00:36 -0500
Message-ID: <20261110125947.1497852-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110125947.1497852-1-sashal@kernel.org>
References: <20261107051756-failed-6.12-56c1d32323e7@kernel.org>
 <20261110125947.1497852-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 029c896c4105b7d74fcd88d99c5fbab2558fee89 ]

While the natural choice of PTR_IF() is kconfig.h, the latter is too broad
to include C code and actually the macro was moved out from there in the
past.  But kernel.h is neither a good choice for that.  Move it to
util_macros.h.  Do the same for u64_to_user_ptr().

While moving, add necessary documentation.

Link: https://lkml.kernel.org/r/20250324105228.775784-3-andriy.shevchenko@linux.intel.com
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Alexandru Ardelean <aardelean@baylibre.com>
Cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 56c1d32323e7 ("hwmon: (tmp102) Fix jiffies wraparound in conversion-ready check")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/kernel.h      | 10 +-----
 include/linux/util_macros.h | 66 +++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+), 9 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 01bb0fac36672..1cce1f6410a9d 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -33,6 +33,7 @@
 #include <linux/sprintf.h>
 #include <linux/static_call_types.h>
 #include <linux/instruction_pointer.h>
+#include <linux/util_macros.h>
 #include <linux/wordpart.h>
 
 #include <asm/byteorder.h>
@@ -41,15 +42,6 @@
 
 #define STACK_MAGIC	0xdeadbeef
 
-#define PTR_IF(cond, ptr)	((cond) ? (ptr) : NULL)
-
-#define u64_to_user_ptr(x) (		\
-{					\
-	typecheck(u64, (x));		\
-	(void __user *)(uintptr_t)(x);	\
-}					\
-)
-
 struct completion;
 struct user;
 
diff --git a/include/linux/util_macros.h b/include/linux/util_macros.h
index 825487fb66faf..785a970323bbc 100644
--- a/include/linux/util_macros.h
+++ b/include/linux/util_macros.h
@@ -64,6 +64,72 @@
 	(__fc_i);							\
 })
 
+/**
+ * PTR_IF - evaluate to @ptr if @cond is true, or to NULL otherwise.
+ * @cond: A conditional, usually in a form of IS_ENABLED(CONFIG_FOO)
+ * @ptr: A pointer to assign if @cond is true.
+ *
+ * PTR_IF(IS_ENABLED(CONFIG_FOO), ptr) evaluates to @ptr if CONFIG_FOO is set
+ * to 'y' or 'm', or to NULL otherwise. The (ptr) argument must be a pointer.
+ *
+ * The macro can be very useful to help compiler dropping dead code.
+ *
+ * For instance, consider the following::
+ *
+ *     #ifdef CONFIG_FOO_SUSPEND
+ *     static int foo_suspend(struct device *dev)
+ *     {
+ *        ...
+ *     }
+ *     #endif
+ *
+ *     static struct pm_ops foo_ops = {
+ *     #ifdef CONFIG_FOO_SUSPEND
+ *         .suspend = foo_suspend,
+ *     #endif
+ *     };
+ *
+ * While this works, the foo_suspend() macro is compiled conditionally,
+ * only when CONFIG_FOO_SUSPEND is set. This is problematic, as there could
+ * be a build bug in this function, we wouldn't have a way to know unless
+ * the configuration option is set.
+ *
+ * An alternative is to declare foo_suspend() always, but mark it
+ * as __maybe_unused. This works, but the __maybe_unused attribute
+ * is required to instruct the compiler that the function may not
+ * be referenced anywhere, and is safe to remove without making
+ * a fuss about it. This makes the programmer responsible for tagging
+ * the functions that can be garbage-collected.
+ *
+ * With the macro it is possible to write the following:
+ *
+ *     static int foo_suspend(struct device *dev)
+ *     {
+ *        ...
+ *     }
+ *
+ *     static struct pm_ops foo_ops = {
+ *         .suspend = PTR_IF(IS_ENABLED(CONFIG_FOO_SUSPEND), foo_suspend),
+ *     };
+ *
+ * The foo_suspend() function will now be automatically dropped by the
+ * compiler, and it does not require any specific attribute.
+ */
+#define PTR_IF(cond, ptr)	((cond) ? (ptr) : NULL)
+
+/**
+ * to_user_ptr - cast a pointer passed as u64 from user space to void __user *
+ * @x: The u64 value from user space, usually via IOCTL
+ *
+ * to_user_ptr() simply casts a pointer passed as u64 from user space to void
+ * __user * correctly. Using this lets us get rid of all the tiresome casts.
+ */
+#define u64_to_user_ptr(x)		\
+({					\
+	typecheck(u64, (x));		\
+	(void __user *)(uintptr_t)(x);	\
+})
+
 /**
  * is_insidevar - check if the @ptr points inside the @var memory range.
  * @ptr:	the pointer to a memory address.
-- 
2.53.0

