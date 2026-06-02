Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090D33CDBBD
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 09:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780392597; cv=none; b=AMmEneeQrcZS9+dB9tltMZTOluVexNOoBZkXSPnNNrLtgloYtBVSBndCjjJdPuZe3ruvN7hTWppiAy+ZicNptL6YdQZmJ1+k6oJyq3VveJJ95hDBZBujSFuAXK/3q+NuNErVZqpIHJjPMhD2NKzO8JHqZtJjgwpO+FwLc7nWdOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780392597; c=relaxed/simple;
	bh=UgxvsR+pqrqyuXAofjdKp6lBzDK3bK5tYs5YVaB1ak4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SYvskCy3bX1Tq/q37M7orSe5DHCuGGp6gopaoBGR3cfmbsX+gSFe2mKLrT86y98edQ32Zb4038AVYQ4L0da7Us03XW0l1IXqPnDt/7v/ATtzBPqLzLuxdGfiR0phmDSe5nvExrLQ354/FliljnPS/oyYzINUQxpP+GvAMUVjK30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J+xOWwvm; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+xOWwvm"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-46015dc517aso1184324f8f.2
        for <stable@vger.kernel.org>; Tue, 02 Jun 2026 02:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780392587; x=1780997387; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G7jHVdrT3r70UfNb667dRsCj+eSQXR+L+oWdEsSA0hI=;
        b=J+xOWwvmqnvJMJ5+7hKb5vlvD49YAwFHRmJdIYIgkxs3rxMHgbKA0+8w6hYt5s6c6c
         ptS8ClxsivqEtlQ2suOqssiASmKEgI6MMlY7w31GEsWqEEl9JNoLZb44085DKbEoa3PA
         AsPzSVG6dFDkhfbeE8ISUHFz2LViA8N7CpQiUJiQha6ftBPn+8+1sV5Ihb++I39yFqVe
         Z4J+WdPlAxP9ApKXato7jg9ySqno8hpzMsAei/KTZkS7R6JC0L3BMhxxkv54fZ16FU2j
         90sXqzcjWLoNm92kYmxtAFLOHnMOCmAj1Hh1JcQ1sDO93zAYwN9Myq0VnBsBZvdMgCQk
         tiXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780392587; x=1780997387;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G7jHVdrT3r70UfNb667dRsCj+eSQXR+L+oWdEsSA0hI=;
        b=XLVBnX3nZGuu3HP4wovITgSJmsRODE908J95qoMtPcZFzl1b/CoufjMSJLpGLUBON1
         VwD3ZTeFxhTTQPu6QnR7hFRaAutJkzVHFnkkEAnsP7/M1VmrkLyxFqQ3TeVKorWtI/Ql
         Zl8jkfLOB7c9UsRJCFYeghH49x57fIhwUev9YR4S3+mauYzIhJVN1ZpQGo49dBP8iIWi
         rlXtE+phIgh9V94FYQsd1vip9hmrHWkT3USQPnmztpJtQkdOXR9VrbyDAPOkoD6rzCRC
         DezioyU634NPYtPgjvD/yfu2JOmAHjubncxjTaVPZI0A8j/8vp8vboS89fDXoQOFf6Al
         /2/Q==
X-Gm-Message-State: AOJu0Yybzz9YkzrkBDJYC5Zmnr6TUM7hKMX2aR0RAeB4VTfLjfTF+Wgo
	fEqsiTxbvcd/MWzXLfEIvOFGZctzfEZMbcx6vopgQjgt83UfNEZ4DVZB//1uXLrn
X-Gm-Gg: Acq92OH13uPwAJYBVx6bGSvSPpcSstOZwojnDxpWifUU4d6OmiOO9uerD/ULd5qKSgV
	dkmLCnm5yXn4pOqqLdOSTD48vcth9AFW9Mtxen4Ekt/tq84lLjaaLzOoTjmkR6Jy3O6SKbDCdpT
	mSf5auH7N3O7t/p+l0BAl4p9b7EH3UnnV4yZi7cy+HNTfW4Fp78+PUZmBKr2yq/UlpFSqddN222
	a1yO+vzjAAauMSSlzBI/BOefWigKCzOytBYKxrOLC8/oFYajhj7k1HDWXnKqctw9It32JpN2fMt
	pnX/lIvvRclG27pCqIjLOttq/b6gZ+IG1uTFI0igxLQUC4zbfOlHsMajTC2QnPJvgDt2SdnP2l6
	hP1hJkyFQxS0KmhSVkv4e0+LNGQQyPn0l0O7kUshb8c4VICCFXvDIHiaFQfsehy1TV22Hn28/d7
	eS5sFul/fZWLl5a3Ar/mS0h5mFZzO301un3ZajzExv8NGFJnV83jc4lV6zIirRNbLv1K35fQoS7
	aaSaIloN7AuE15FjL+gN+jKgz1upjb4Tbc7WGqJRmMS7Ye9o8r5r4kphXuX+eY20jVtwK2Hiav5
	WiWGzZn51dzCfULhh3nx3XuQ4IvIgWgHJsdIHup2TJcQeMceCqV4Tw==
X-Received: by 2002:adf:f14e:0:b0:45e:e44b:3136 with SMTP id ffacd0b85a97d-45ef6b4edffmr20066493f8f.19.1780392586734;
        Tue, 02 Jun 2026 02:29:46 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00d5a27cd7dcd113c6.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:d5a2:7cd7:dcd1:13c6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef34b7d6bsm33333512f8f.10.2026.06.02.02.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 02:29:46 -0700 (PDT)
Date: Tue, 2 Jun 2026 11:29:43 +0200
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
	Stanislav Fomichev <sdf@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH 6.1.y 02/11] selftests/bpf: Convert test_global_funcs test to
 test_loader framework
Message-ID: <be7619f25ba0095ad78f72034097860bddc9ee23.1780392092.git.paul.chaignon@gmail.com>
References: <cover.1780392092.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1780392092.git.paul.chaignon@gmail.com>

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

