Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F128E284883
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 19:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780429247; cv=none; b=pk0OFiMkwnFhBgeq3sd2jLLUAVOWDKJ5xSEGP8BUAjgsh+BSRUTttMhqZzx8vQh+z9YNzKVriOBBPqaO4YYVA4KXHMblwFPlrWEQuz1DDkYyeqja4WQrtQigneRmxjRawJu1G7dIUhKMlob0z4DJpM6FL1GgQ6y+lWx2YXEJihg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780429247; c=relaxed/simple;
	bh=UgxvsR+pqrqyuXAofjdKp6lBzDK3bK5tYs5YVaB1ak4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Baj4sBlrGHFW45OigOKMCK4kqedEtNdCoqbQFVMEtBTRtYj79dB55JhytDrTI8WBiRVTaenH6xf9a1kXn6P1wn+pJFBZLddC736HAGofeBOMLvTziH/RXYD15KlAZR4vCv7tTDK7SxYzh1p/LpT5sB2kU3sp6AkX2qzaWd+IMaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JBro4l2U; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBro4l2U"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490b12270b3so8917325e9.1
        for <stable@vger.kernel.org>; Tue, 02 Jun 2026 12:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780429243; x=1781034043; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G7jHVdrT3r70UfNb667dRsCj+eSQXR+L+oWdEsSA0hI=;
        b=JBro4l2Uq3if7C8nukXPyiglYQ9ZAJkHnBeGhFgZQGaEaSv1Uggmv+BUniPLf+ApsB
         +Da5z4I/K5Ke9jg3LLGQpZ3R3PuJPPIKUVlHn1hZzkF55fXTyMz34RG5dizd5i0C1C6s
         btvftgLS+0wp3oNs0AcW01zPPvfIUc7nUa2tH0zcpLFcQ0twmoK2Y1ewDTVfHJ7a3AU1
         fyEat4Bwa7NARq+6VKwe0UY8K6AXcL29NI6gxqSmIsDg6thGQnapIDYpabCkv4CQ/ZqG
         eF3ufq7PzNZIAq5g2txDaJ97q0Otm5bhKMFFE1IWM0LuChefMKa45cscSVVaCna6XF1v
         GSlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780429243; x=1781034043;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G7jHVdrT3r70UfNb667dRsCj+eSQXR+L+oWdEsSA0hI=;
        b=gFyJ1680wBAWhhekcPWchogDM2Wn++t5bqCX1qu0i95wcM1fS4cXRkKuyqfpnMs4v5
         RN3vhYYgUkEtv26FR4QcFn7JI14S7ZsiDSkBs/8lj+3d9MuKYUxQQ9PyoIrNxG8S7M4v
         8qwK0Q5W41BLC/mzbT8b7FUnM8zExy+vQfy012S3Y4Tsvg8JryqgTYizcecRqSOCchuh
         V1jW8XC6Hhv32ypMuxqrmyzEa+D7mlVZKL9gwzX0gMXFCYH0n5dCexygQ0maXS+LmEVk
         MFSOlo66/dWbkju/16dkQa4m907aSxVk2Hc7ED/SpHN6k0J4fFhxKDNRy1mmGP+3jzV6
         bdqA==
X-Gm-Message-State: AOJu0Yxfv5qmIXjwF95JdWEnGBSBnnejnR/tZXAcBMTZfDTQm/PdlODx
	V9Nq+1EYufP9pOBVdA2m0JTI4LjbH4uKDqfh3mYZT1CfCRjrMX13tBllJd0v8Z9n
X-Gm-Gg: Acq92OGfgBrOB7ztjxtXHRxTCrx4eMZPbMwdZVmNF9BL7aQQvqouF3gBCEMgrHnGkXG
	bPn0OK51MIq1fCHulF2eAFbFhrT2DHT0wmUY5nI0kXJpQx/rtm+upkgQ1usjktdkfOJ2heCXKLh
	15R/pEyUIQ3XpbUEfah4e7e2o39GQcZewlXgda4im6ranXQj4TZ4cNo6Oum7mqyiTDbTG+VVhAH
	M7FU6YA33Jg11OAFhE2JN+sLUFAJaspltCbBypc+i/OIyDJUBMomqWuKNucRpazRAcL74Xp33TK
	g3svZEixio4Sple6brHIkH8eXO3XZ4ZQxjp6WroLqoh7tVe5y/EkaQHxtwlIFexSLZahQOFouMT
	PyMwLwU07EDCufkpt+RZE/FHcer6hNkQy10IDpVFMXeSB1eHeyHmBVS1jynKqNNSZG57vlteY4l
	Jqswmb4MvwtluYfrhbv8OqKON56IdnOD3PKpf/+UxAc6VQwxmJMlN+G5gidfk9typoLOSKmP3/A
	uC8bU0WqW9eZ8RXyfyJmgLTm54mYTBLtoag6JQ9no2++yBNl6sqpeVnrQcy19bHYdbOmg41k+4k
	bC9VNMWJBFRYYfKIK5eM8T5DzN3v/QzbLnf1J76/klSYgrcUWGYteQ==
X-Received: by 2002:a05:600c:5288:b0:490:abd7:fd9 with SMTP id 5b1f17b1804b1-490b5ec47c5mr4008385e9.10.1780429243190;
        Tue, 02 Jun 2026 12:40:43 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00d5a27cd7dcd113c6.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:d5a2:7cd7:dcd1:13c6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0e20a76sm82342695e9.4.2026.06.02.12.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 12:40:42 -0700 (PDT)
Date: Tue, 2 Jun 2026 21:40:40 +0200
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
	Stanislav Fomichev <sdf@fomichev.me>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH 6.1.y v2 02/11] selftests/bpf: Convert test_global_funcs test
 to test_loader framework
Message-ID: <8d6ed4273abde0ac1f02e52a401d9a70601374cd.1780427227.git.paul.chaignon@gmail.com>
References: <cover.1780427227.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1780427227.git.paul.chaignon@gmail.com>

From: Andrii Nakryiko <andrii@kernel.org>

[ Upstream commit 95ebb376176c52382293e05e63f142114a5e40ef ]

Convert 17 test_global_funcs subtests into test_loader framework for
easier maintenance and more declarative way to define expected
failures/successes.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Stanislav Fomichev <sdf@google.com>
Link: https://lore.kernel.org/bpf/20230216045954.3002473-3-andrii@kernel.org
Fixes: bbac91d57ac2 ("bpf: Allow reads from uninit stack")
[ Notes: This backport fixes backport commit bbac91d57ac2 ("bpf: Allow
  reads from uninit stack"), which broke the BPF selftest build. A minor
  conflict needed resolution in test_global_func10.c on the error
  message. ]
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 .../bpf/prog_tests/test_global_funcs.c        | 131 +++++-------------
 .../selftests/bpf/progs/test_global_func1.c   |   6 +-
 .../selftests/bpf/progs/test_global_func10.c  |   1 +
 .../selftests/bpf/progs/test_global_func11.c  |   4 +-
 .../selftests/bpf/progs/test_global_func12.c  |   4 +-
 .../selftests/bpf/progs/test_global_func13.c  |   4 +-
 .../selftests/bpf/progs/test_global_func14.c  |   4 +-
 .../selftests/bpf/progs/test_global_func15.c  |   4 +-
 .../selftests/bpf/progs/test_global_func16.c  |   4 +-
 .../selftests/bpf/progs/test_global_func17.c  |   4 +-
 .../selftests/bpf/progs/test_global_func2.c   |  43 +++++-
 .../selftests/bpf/progs/test_global_func3.c   |  10 +-
 .../selftests/bpf/progs/test_global_func4.c   |  55 +++++++-
 .../selftests/bpf/progs/test_global_func5.c   |   4 +-
 .../selftests/bpf/progs/test_global_func6.c   |   4 +-
 .../selftests/bpf/progs/test_global_func7.c   |   4 +-
 .../selftests/bpf/progs/test_global_func8.c   |   4 +-
 .../selftests/bpf/progs/test_global_func9.c   |   4 +-
 18 files changed, 172 insertions(+), 122 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c b/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
index 7295cc60f724..2ff4d5c7abfc 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
@@ -1,104 +1,41 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2020 Facebook */
 #include <test_progs.h>
-
-const char *err_str;
-bool found;
-
-static int libbpf_debug_print(enum libbpf_print_level level,
-			      const char *format, va_list args)
-{
-	char *log_buf;
-
-	if (level != LIBBPF_WARN ||
-	    strcmp(format, "libbpf: \n%s\n")) {
-		vprintf(format, args);
-		return 0;
-	}
-
-	log_buf = va_arg(args, char *);
-	if (!log_buf)
-		goto out;
-	if (err_str && strstr(log_buf, err_str) == 0)
-		found = true;
-out:
-	printf(format, log_buf);
-	return 0;
-}
-
-extern int extra_prog_load_log_flags;
-
-static int check_load(const char *file)
-{
-	struct bpf_object *obj = NULL;
-	struct bpf_program *prog;
-	int err;
-
-	found = false;
-
-	obj = bpf_object__open_file(file, NULL);
-	err = libbpf_get_error(obj);
-	if (err)
-		return err;
-
-	prog = bpf_object__next_program(obj, NULL);
-	if (!prog) {
-		err = -ENOENT;
-		goto err_out;
-	}
-
-	bpf_program__set_flags(prog, BPF_F_TEST_RND_HI32);
-	bpf_program__set_log_level(prog, extra_prog_load_log_flags);
-
-	err = bpf_object__load(obj);
-
-err_out:
-	bpf_object__close(obj);
-	return err;
-}
-
-struct test_def {
-	const char *file;
-	const char *err_str;
-};
+#include "test_global_func1.skel.h"
+#include "test_global_func2.skel.h"
+#include "test_global_func3.skel.h"
+#include "test_global_func4.skel.h"
+#include "test_global_func5.skel.h"
+#include "test_global_func6.skel.h"
+#include "test_global_func7.skel.h"
+#include "test_global_func8.skel.h"
+#include "test_global_func9.skel.h"
+#include "test_global_func10.skel.h"
+#include "test_global_func11.skel.h"
+#include "test_global_func12.skel.h"
+#include "test_global_func13.skel.h"
+#include "test_global_func14.skel.h"
+#include "test_global_func15.skel.h"
+#include "test_global_func16.skel.h"
+#include "test_global_func17.skel.h"
 
 void test_test_global_funcs(void)
 {
-	struct test_def tests[] = {
-		{ "test_global_func1.bpf.o", "combined stack size of 4 calls is 544" },
-		{ "test_global_func2.bpf.o" },
-		{ "test_global_func3.bpf.o", "the call stack of 8 frames" },
-		{ "test_global_func4.bpf.o" },
-		{ "test_global_func5.bpf.o", "expected pointer to ctx, but got PTR" },
-		{ "test_global_func6.bpf.o", "modified ctx ptr R2" },
-		{ "test_global_func7.bpf.o", "foo() doesn't return scalar" },
-		{ "test_global_func8.bpf.o" },
-		{ "test_global_func9.bpf.o" },
-		{ "test_global_func10.bpf.o", "invalid indirect read from stack" },
-		{ "test_global_func11.bpf.o", "Caller passes invalid args into func#1" },
-		{ "test_global_func12.bpf.o", "invalid mem access 'mem_or_null'" },
-		{ "test_global_func13.bpf.o", "Caller passes invalid args into func#1" },
-		{ "test_global_func14.bpf.o", "reference type('FWD S') size cannot be determined" },
-		{ "test_global_func15.bpf.o", "At program exit the register R0 has value" },
-		{ "test_global_func16.bpf.o", "invalid indirect read from stack" },
-		{ "test_global_func17.bpf.o", "Caller passes invalid args into func#1" },
-	};
-	libbpf_print_fn_t old_print_fn = NULL;
-	int err, i, duration = 0;
-
-	old_print_fn = libbpf_set_print(libbpf_debug_print);
-
-	for (i = 0; i < ARRAY_SIZE(tests); i++) {
-		const struct test_def *test = &tests[i];
-
-		if (!test__start_subtest(test->file))
-			continue;
-
-		err_str = test->err_str;
-		err = check_load(test->file);
-		CHECK_FAIL(!!err ^ !!err_str);
-		if (err_str)
-			CHECK(found, "", "expected string '%s'", err_str);
-	}
-	libbpf_set_print(old_print_fn);
+	RUN_TESTS(test_global_func1);
+	RUN_TESTS(test_global_func2);
+	RUN_TESTS(test_global_func3);
+	RUN_TESTS(test_global_func4);
+	RUN_TESTS(test_global_func5);
+	RUN_TESTS(test_global_func6);
+	RUN_TESTS(test_global_func7);
+	RUN_TESTS(test_global_func8);
+	RUN_TESTS(test_global_func9);
+	RUN_TESTS(test_global_func10);
+	RUN_TESTS(test_global_func11);
+	RUN_TESTS(test_global_func12);
+	RUN_TESTS(test_global_func13);
+	RUN_TESTS(test_global_func14);
+	RUN_TESTS(test_global_func15);
+	RUN_TESTS(test_global_func16);
+	RUN_TESTS(test_global_func17);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_global_func1.c b/tools/testing/selftests/bpf/progs/test_global_func1.c
index 7b42dad187b8..23970a20b324 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func1.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func1.c
@@ -3,10 +3,9 @@
 #include <stddef.h>
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
 
-#ifndef MAX_STACK
 #define MAX_STACK (512 - 3 * 32 + 8)
-#endif
 
 static __attribute__ ((noinline))
 int f0(int var, struct __sk_buff *skb)
@@ -39,7 +38,8 @@ int f3(int val, struct __sk_buff *skb, int var)
 }
 
 SEC("tc")
-int test_cls(struct __sk_buff *skb)
+__failure __msg("combined stack size of 4 calls is 544")
+int global_func1(struct __sk_buff *skb)
 {
 	return f0(1, skb) + f1(skb) + f2(2, skb) + f3(3, skb, 4);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_global_func10.c b/tools/testing/selftests/bpf/progs/test_global_func10.c
index d361eba167f6..8fba3f3649e2 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func10.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func10.c
@@ -2,6 +2,7 @@
 #include <stddef.h>
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
 
 struct Small {
 	long x;
diff --git a/tools/testing/selftests/bpf/progs/test_global_func11.c b/tools/testing/selftests/bpf/progs/test_global_func11.c
index ef5277d982d9..283e036dc401 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func11.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func11.c
@@ -2,6 +2,7 @@
 #include <stddef.h>
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
 
 struct S {
 	int x;
@@ -13,7 +14,8 @@ __noinline int foo(const struct S *s)
 }
 
 SEC("cgroup_skb/ingress")
-int test_cls(struct __sk_buff *skb)
+__failure __msg("Caller passes invalid args into func#1")
+int global_func11(struct __sk_buff *skb)
 {
 	return foo((const void *)skb);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_global_func12.c b/tools/testing/selftests/bpf/progs/test_global_func12.c
index 62343527cc59..7f159d83c6f6 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func12.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func12.c
@@ -2,6 +2,7 @@
 #include <stddef.h>
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
 
 struct S {
 	int x;
@@ -13,7 +14,8 @@ __noinline int foo(const struct S *s)
 }
 
 SEC("cgroup_skb/ingress")
-int test_cls(struct __sk_buff *skb)
+__failure __msg("invalid mem access 'mem_or_null'")
+int global_func12(struct __sk_buff *skb)
 {
 	const struct S s = {.x = skb->len };
 
diff --git a/tools/testing/selftests/bpf/progs/test_global_func13.c b/tools/testing/selftests/bpf/progs/test_global_func13.c
index ff8897c1ac22..02ea80da75b5 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func13.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func13.c
@@ -2,6 +2,7 @@
 #include <stddef.h>
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
 
 struct S {
 	int x;
@@ -16,7 +17,8 @@ __noinline int foo(const struct S *s)
 }
 
 SEC("cgroup_skb/ingress")
-int test_cls(struct __sk_buff *skb)
+__failure __msg("Caller passes invalid args into func#1")
+int global_func13(struct __sk_buff *skb)
 {
 	const struct S *s = (const struct S *)(0xbedabeda);
 
diff --git a/tools/testing/selftests/bpf/progs/test_global_func14.c b/tools/testing/selftests/bpf/progs/test_global_func14.c
index 698c77199ebf..33b7d5efd7b2 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func14.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func14.c
@@ -2,6 +2,7 @@
 #include <stddef.h>
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
 
 struct S;
 
@@ -14,7 +15,8 @@ __noinline int foo(const struct S *s)
 }
 
 SEC("cgroup_skb/ingress")
-int test_cls(struct __sk_buff *skb)
+__failure __msg("reference type('FWD S') size cannot be determined")
+int global_func14(struct __sk_buff *skb)
 {
 
 	return foo(NULL);
diff --git a/tools/testing/selftests/bpf/progs/test_global_func15.c b/tools/testing/selftests/bpf/progs/test_global_func15.c
index c19c435988d5..b512d6a6c75e 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func15.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func15.c
@@ -2,6 +2,7 @@
 #include <stddef.h>
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
 
 __noinline int foo(unsigned int *v)
 {
@@ -12,7 +13,8 @@ __noinline int foo(unsigned int *v)
 }
 
 SEC("cgroup_skb/ingress")
-int test_cls(struct __sk_buff *skb)
+__failure __msg("At program exit the register R0 has value")
+int global_func15(struct __sk_buff *skb)
 {
 	unsigned int v = 1;
 
diff --git a/tools/testing/selftests/bpf/progs/test_global_func16.c b/tools/testing/selftests/bpf/progs/test_global_func16.c
index 0312d1e8d8c0..e7206304632e 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func16.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func16.c
@@ -2,6 +2,7 @@
 #include <stddef.h>
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
 
 __noinline int foo(int (*arr)[10])
 {
@@ -12,7 +13,8 @@ __noinline int foo(int (*arr)[10])
 }
 
 SEC("cgroup_skb/ingress")
-int test_cls(struct __sk_buff *skb)
+__failure __msg("invalid indirect read from stack")
+int global_func16(struct __sk_buff *skb)
 {
 	int array[10];
 
diff --git a/tools/testing/selftests/bpf/progs/test_global_func17.c b/tools/testing/selftests/bpf/progs/test_global_func17.c
index 2b8b9b8ba018..a32e11c7d933 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func17.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func17.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
 
 __noinline int foo(int *p)
 {
@@ -10,7 +11,8 @@ __noinline int foo(int *p)
 const volatile int i;
 
 SEC("tc")
-int test_cls(struct __sk_buff *skb)
+__failure __msg("Caller passes invalid args into func#1")
+int global_func17(struct __sk_buff *skb)
 {
 	return foo((int *)&i);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_global_func2.c b/tools/testing/selftests/bpf/progs/test_global_func2.c
index 2c18d82923a2..3dce97fb52a4 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func2.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func2.c
@@ -1,4 +1,45 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (c) 2020 Facebook */
+#include <stddef.h>
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
 #define MAX_STACK (512 - 3 * 32)
-#include "test_global_func1.c"
+
+static __attribute__ ((noinline))
+int f0(int var, struct __sk_buff *skb)
+{
+	return skb->len;
+}
+
+__attribute__ ((noinline))
+int f1(struct __sk_buff *skb)
+{
+	volatile char buf[MAX_STACK] = {};
+
+	return f0(0, skb) + skb->len;
+}
+
+int f3(int, struct __sk_buff *skb, int);
+
+__attribute__ ((noinline))
+int f2(int val, struct __sk_buff *skb)
+{
+	return f1(skb) + f3(val, skb, 1);
+}
+
+__attribute__ ((noinline))
+int f3(int val, struct __sk_buff *skb, int var)
+{
+	volatile char buf[MAX_STACK] = {};
+
+	return skb->ifindex * val * var;
+}
+
+SEC("tc")
+__success
+int global_func2(struct __sk_buff *skb)
+{
+	return f0(1, skb) + f1(skb) + f2(2, skb) + f3(3, skb, 4);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_global_func3.c b/tools/testing/selftests/bpf/progs/test_global_func3.c
index 01bf8275dfd6..142b682d3c2f 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func3.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func3.c
@@ -3,6 +3,7 @@
 #include <stddef.h>
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
 
 __attribute__ ((noinline))
 int f1(struct __sk_buff *skb)
@@ -46,20 +47,15 @@ int f7(struct __sk_buff *skb)
 	return f6(skb);
 }
 
-#ifndef NO_FN8
 __attribute__ ((noinline))
 int f8(struct __sk_buff *skb)
 {
 	return f7(skb);
 }
-#endif
 
 SEC("tc")
-int test_cls(struct __sk_buff *skb)
+__failure __msg("the call stack of 8 frames")
+int global_func3(struct __sk_buff *skb)
 {
-#ifndef NO_FN8
 	return f8(skb);
-#else
-	return f7(skb);
-#endif
 }
diff --git a/tools/testing/selftests/bpf/progs/test_global_func4.c b/tools/testing/selftests/bpf/progs/test_global_func4.c
index 610f75edf276..1733d87ad3f3 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func4.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func4.c
@@ -1,4 +1,55 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (c) 2020 Facebook */
-#define NO_FN8
-#include "test_global_func3.c"
+#include <stddef.h>
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+__attribute__ ((noinline))
+int f1(struct __sk_buff *skb)
+{
+	return skb->len;
+}
+
+__attribute__ ((noinline))
+int f2(int val, struct __sk_buff *skb)
+{
+	return f1(skb) + val;
+}
+
+__attribute__ ((noinline))
+int f3(int val, struct __sk_buff *skb, int var)
+{
+	return f2(var, skb) + val;
+}
+
+__attribute__ ((noinline))
+int f4(struct __sk_buff *skb)
+{
+	return f3(1, skb, 2);
+}
+
+__attribute__ ((noinline))
+int f5(struct __sk_buff *skb)
+{
+	return f4(skb);
+}
+
+__attribute__ ((noinline))
+int f6(struct __sk_buff *skb)
+{
+	return f5(skb);
+}
+
+__attribute__ ((noinline))
+int f7(struct __sk_buff *skb)
+{
+	return f6(skb);
+}
+
+SEC("tc")
+__success
+int global_func4(struct __sk_buff *skb)
+{
+	return f7(skb);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_global_func5.c b/tools/testing/selftests/bpf/progs/test_global_func5.c
index 9248d03e0d06..cc55aedaf82d 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func5.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func5.c
@@ -3,6 +3,7 @@
 #include <stddef.h>
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
 
 __attribute__ ((noinline))
 int f1(struct __sk_buff *skb)
@@ -25,7 +26,8 @@ int f3(int val, struct __sk_buff *skb)
 }
 
 SEC("tc")
-int test_cls(struct __sk_buff *skb)
+__failure __msg("expected pointer to ctx, but got PTR")
+int global_func5(struct __sk_buff *skb)
 {
 	return f1(skb) + f2(2, skb) + f3(3, skb);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_global_func6.c b/tools/testing/selftests/bpf/progs/test_global_func6.c
index af8c78bdfb25..46c38c8f2cf0 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func6.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func6.c
@@ -3,6 +3,7 @@
 #include <stddef.h>
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
 
 __attribute__ ((noinline))
 int f1(struct __sk_buff *skb)
@@ -25,7 +26,8 @@ int f3(int val, struct __sk_buff *skb)
 }
 
 SEC("tc")
-int test_cls(struct __sk_buff *skb)
+__failure __msg("modified ctx ptr R2")
+int global_func6(struct __sk_buff *skb)
 {
 	return f1(skb) + f2(2, skb) + f3(3, skb);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_global_func7.c b/tools/testing/selftests/bpf/progs/test_global_func7.c
index 6cb8e2f5254c..f182febfde3c 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func7.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func7.c
@@ -3,6 +3,7 @@
 #include <stddef.h>
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
 
 __attribute__ ((noinline))
 void foo(struct __sk_buff *skb)
@@ -11,7 +12,8 @@ void foo(struct __sk_buff *skb)
 }
 
 SEC("tc")
-int test_cls(struct __sk_buff *skb)
+__failure __msg("foo() doesn't return scalar")
+int global_func7(struct __sk_buff *skb)
 {
 	foo(skb);
 	return 0;
diff --git a/tools/testing/selftests/bpf/progs/test_global_func8.c b/tools/testing/selftests/bpf/progs/test_global_func8.c
index d55a6544b1ab..9b9c57fa2dd3 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func8.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func8.c
@@ -3,6 +3,7 @@
 #include <stddef.h>
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
 
 __noinline int foo(struct __sk_buff *skb)
 {
@@ -10,7 +11,8 @@ __noinline int foo(struct __sk_buff *skb)
 }
 
 SEC("cgroup_skb/ingress")
-int test_cls(struct __sk_buff *skb)
+__success
+int global_func8(struct __sk_buff *skb)
 {
 	if (!foo(skb))
 		return 0;
diff --git a/tools/testing/selftests/bpf/progs/test_global_func9.c b/tools/testing/selftests/bpf/progs/test_global_func9.c
index bd233ddede98..1f2cb0159b8d 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func9.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func9.c
@@ -2,6 +2,7 @@
 #include <stddef.h>
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
 
 struct S {
 	int x;
@@ -74,7 +75,8 @@ __noinline int quuz(int **p)
 }
 
 SEC("cgroup_skb/ingress")
-int test_cls(struct __sk_buff *skb)
+__success
+int global_func9(struct __sk_buff *skb)
 {
 	int result = 0;
 
-- 
2.43.0

