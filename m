Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAC3218E91
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 19:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780429204; cv=none; b=RDjC7CLzn3oPa7ngDhhiA695xFrJGEjyrpRJ5vLc4gtg26t6kAK/igiFzDnlkVZCp8Lka0S5s32XVHQDgTgvVxLOLf4o96nKOs1JMXU681nk3eXyS520/f7kgvkVARrVAm+YCXAM7TRNeIJ9uRzpyNQUpK3MfMbrMegd9dmVFl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780429204; c=relaxed/simple;
	bh=XDXgGFhqZEP69Z4nmunsnimgK4T5oI7BJzgVwyyL05k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WHR9ygg7/V6PlwCKGm/JegnQ2TekAakScchdP//253y//mZP9HJhE0pMC76yn/vWtne1/IaNPwTmvVGsieN0BUFLTMX+yjQ+b/t/jLJ59VqMjMf9bENtxBLh80I2BuitaCzKyIldamlun3ca/O1zd85I8dPLYJ2u20QcM8wWUsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P2q7jPZ/; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2q7jPZ/"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-45eecb8bf67so4235615f8f.2
        for <stable@vger.kernel.org>; Tue, 02 Jun 2026 12:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780429201; x=1781034001; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K8POa05uu1RqDewi10ttys+p5lBM19TAa8twgRXfOLw=;
        b=P2q7jPZ/7/Ntyh+kZ6D+wup7UWbZJiRcYTzwfY/TN9faX4JQbK4/X7GUeTbV9RfwQh
         SlmI9r/iB92gB+mEXRhH07ahzok/ZVHCHp4rL2aUC+RrzK3U4g0pRwT50bEXBGeilUEi
         VRS2CqMb8dQFu1PyZ8j/sq+r1NaKgse3eQKi8xDmG+htrsIPrcfRdKxpdg8GQ53wwdYC
         my5FhQxurAJmZ9lPxWFHB033Ea6QQlVlVsn2f8O8Yd0vvD3Hqnng99VIOej5e5SDF3wp
         CvFdY23eHY2eoZwlXhMqu5l13eu8Js1xAO6d/VTzdDWSkX2fbqh37jI9vuhyMG664bnq
         3wtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780429201; x=1781034001;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K8POa05uu1RqDewi10ttys+p5lBM19TAa8twgRXfOLw=;
        b=aVJdzkoFDLSkw7l6MisSZF+Hg++nrdNs8e/okGztQdXZMTFW1tOVUMypLeBWxM7tUK
         p6YzBLu6fSRPBMv+wAWmmyhrSqbixTa9tT9TKDBJfmYf550GJtg7/i7JK2/il+lPRAx+
         yFHin3rnylogjVrG3G8geV8QtxVhoBOjcNwpKTu6HCsnGypBsdazi1SuO7Fk2faSNnl8
         3uCcDu7LT7R/QJZwMv3i22ewCfK0GnrqdRDxnecMYOzfdF0NtaU38+DjySBAyQ1TS7Ff
         SD7gOUR2rLTtVa/cfObgnRBoYdNV2B64RDYigCDHcOQRL3kPdkCKM+3EoI2xJ+H50gfT
         a9eQ==
X-Gm-Message-State: AOJu0YxbjOnl169Rm8gopUBYvcx3lJa4apiccIDR3XylfOBB2VkLuYs2
	Iy2dn35Ckp6jyy9XQ3LRG7o2k9HfYrJEZbiFkE4Hnn4zYmiDC3JA8wKw2w/nHbCH
X-Gm-Gg: Acq92OHa3S0l5RxqqDMBYJ1V7RxUB9BX+WziFvO282ent31PxzaE+Xqwu4YtSESvyki
	up1NsJa845w+UGJC8Sks1lUImab3ORl4O7gtDCBFXAHuMCuBWvClXih9oCdSkP13XJX+BHG+JY4
	8Me6u6niVCr8IBWHmIH4x+8Wvsu7mCQBH4PJD2ZrefvdpV7wuff2nj1xBdqRPO92E3FHnz1Kww+
	K1kSeFH+Do0sBOHF8UGolNavzsz4hsLVWBAvjDJAyR18NqesMNUfFbPgp3ENgmvfKQebqZP3tnN
	BIsw/zhdRstFIvHpBij2Sr0mP6w7TXd69jxB7X5ZBtqtQOHkRs8R7c8g+VXcVvUxxGHK3SdVJFW
	DKARqDbqgnyr50aQbh8L1z81EIogFfrRID6vUi4FTSRuXspP3BAkL9uWQ3CGWzJLPNWIFPghOq6
	J1vVD29Oj1b5Z+DRkxbv4tzXwJU9iPu5SA0tRdE+UbnrMBKbvV+2a/I5t15dRWDP70UJNHAx5Py
	EKwXMo9lN8ssQ3SL5N928P/YzeA658XCbcwVC+BwxWd/r/1lRn+fRcrJ/2opmBCEp6oG7Ckj5Ru
	qFLZhBxrOJ8eocvYWVFx+Cb7Nv92anX/u5CQNc9DTXmcSWuxSX7LzA==
X-Received: by 2002:a05:6000:2892:b0:45e:f381:cd8a with SMTP id ffacd0b85a97d-4601f4e3732mr1290211f8f.2.1780429200967;
        Tue, 02 Jun 2026 12:40:00 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00d5a27cd7dcd113c6.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:d5a2:7cd7:dcd1:13c6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2eadefsm1627865f8f.11.2026.06.02.12.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 12:40:00 -0700 (PDT)
Date: Tue, 2 Jun 2026 21:39:58 +0200
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
Subject: [PATCH 6.1.y v2 01/11] selftests/bpf: add generic BPF program
 tester-loader
Message-ID: <1edc3c82a85361948fce239e36d6f55a8d96597b.1780427227.git.paul.chaignon@gmail.com>
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

[ Upstream commit 537c3f66eac137a02ec50a40219d2da6597e5dc9 ]

It's become a common pattern to have a collection of small BPF programs
in one BPF object file, each representing one test case. On user-space
side of such tests we maintain a table of program names and expected
failure or success, along with optional expected verifier log message.

This works, but each set of tests reimplement this mundane code over and
over again, which is a waste of time for anyone trying to add a new set
of tests. Furthermore, it's quite error prone as it's way too easy to miss
some entries in these manually maintained test tables (as evidences by
dynptr_fail tests, in which ringbuf_release_uninit_dynptr subtest was
accidentally missed; this is fixed in next patch).

So this patch implements generic test_loader, which accepts skeleton
name and handles the rest of details: opens and loads BPF object file,
making sure each program is tested in isolation. Optionally each test
case can specify expected BPF verifier log message. In case of failure,
tester makes sure to report verifier log, but it also reports verifier
log in verbose mode unconditionally.

Now, the interesting deviation from existing custom implementations is
the use of btf_decl_tag attribute to specify expected-to-fail vs
expected-to-succeed markers and, optionally, expected log message
directly next to BPF program source code, eliminating the need to
manually create and update table of tests.

We define few macros wrapping btf_decl_tag with a convention that all
values of btf_decl_tag start with "comment:" prefix, and then utilizing
a very simple "just_some_text_tag" or "some_key_name=<value>" pattern to
define things like expected success/failure, expected verifier message,
extra verifier log level (if necessary). This approach is demonstrated
by next patch in which two existing sets of failure tests are converted.

Tester supports both expected-to-fail and expected-to-succeed programs,
though this patch set didn't convert any existing expected-to-succeed
programs yet, as existing tests couple BPF program loading with their
further execution through attach or test_prog_run. One way to allow
testing scenarios like this would be ability to specify custom callback,
executed for each successfully loaded BPF program. This is left for
follow up patches, after some more analysis of existing test cases.

This test_loader is, hopefully, a start of a test_verifier-like runner,
but integrated into test_progs infrastructure. It will allow much better
"user experience" of defining low-level verification tests that can take
advantage of all the libbpf-provided nicety features on BPF side: global
variables, declarative maps, etc.  All while having a choice of defining
it in C or as BPF assembly (through __attribute__((naked)) functions and
using embedded asm), depending on what makes most sense in each
particular case. This will be explored in follow up patches as well.

Acked-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20221207201648.2990661-1-andrii@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Stable-dep-of: 95ebb376176c ("selftests/bpf: Convert test_global_funcs test to test_loader framework")
[ Note: Minor conflict in Makefile. ]
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 tools/testing/selftests/bpf/Makefile         |   2 +-
 tools/testing/selftests/bpf/progs/bpf_misc.h |   5 +
 tools/testing/selftests/bpf/test_loader.c    | 233 +++++++++++++++++++
 tools/testing/selftests/bpf/test_progs.h     |  33 +++
 4 files changed, 272 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/test_loader.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index b09205d92511..541f251036ae 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -519,7 +519,7 @@ TRUNNER_BPF_PROGS_DIR := progs
 TRUNNER_EXTRA_SOURCES := test_progs.c cgroup_helpers.c trace_helpers.c	\
 			 network_helpers.c testing_helpers.c		\
 			 btf_helpers.c flow_dissector_load.h		\
-			 cap_helpers.c
+			 cap_helpers.c test_loader.c
 TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read $(OUTPUT)/bpf_testmod.ko	\
 		       $(OUTPUT)/liburandom_read.so			\
 		       $(OUTPUT)/xdp_synproxy				\
diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index 5bb11fe595a4..4a01ea9113bf 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -2,6 +2,11 @@
 #ifndef __BPF_MISC_H__
 #define __BPF_MISC_H__
 
+#define __msg(msg)		__attribute__((btf_decl_tag("comment:test_expect_msg=" msg)))
+#define __failure		__attribute__((btf_decl_tag("comment:test_expect_failure")))
+#define __success		__attribute__((btf_decl_tag("comment:test_expect_success")))
+#define __log_level(lvl)	__attribute__((btf_decl_tag("comment:test_log_level="#lvl)))
+
 #if defined(__TARGET_ARCH_x86)
 #define SYSCALL_WRAPPER 1
 #define SYS_PREFIX "__x64_"
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
new file mode 100644
index 000000000000..679efb3aa785
--- /dev/null
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -0,0 +1,233 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+#include <stdlib.h>
+#include <test_progs.h>
+#include <bpf/btf.h>
+
+#define str_has_pfx(str, pfx) \
+	(strncmp(str, pfx, __builtin_constant_p(pfx) ? sizeof(pfx) - 1 : strlen(pfx)) == 0)
+
+#define TEST_LOADER_LOG_BUF_SZ 1048576
+
+#define TEST_TAG_EXPECT_FAILURE "comment:test_expect_failure"
+#define TEST_TAG_EXPECT_SUCCESS "comment:test_expect_success"
+#define TEST_TAG_EXPECT_MSG_PFX "comment:test_expect_msg="
+#define TEST_TAG_LOG_LEVEL_PFX "comment:test_log_level="
+
+struct test_spec {
+	const char *name;
+	bool expect_failure;
+	const char *expect_msg;
+	int log_level;
+};
+
+static int tester_init(struct test_loader *tester)
+{
+	if (!tester->log_buf) {
+		tester->log_buf_sz = TEST_LOADER_LOG_BUF_SZ;
+		tester->log_buf = malloc(tester->log_buf_sz);
+		if (!ASSERT_OK_PTR(tester->log_buf, "tester_log_buf"))
+			return -ENOMEM;
+	}
+
+	return 0;
+}
+
+void test_loader_fini(struct test_loader *tester)
+{
+	if (!tester)
+		return;
+
+	free(tester->log_buf);
+}
+
+static int parse_test_spec(struct test_loader *tester,
+			   struct bpf_object *obj,
+			   struct bpf_program *prog,
+			   struct test_spec *spec)
+{
+	struct btf *btf;
+	int func_id, i;
+
+	memset(spec, 0, sizeof(*spec));
+
+	spec->name = bpf_program__name(prog);
+
+	btf = bpf_object__btf(obj);
+	if (!btf) {
+		ASSERT_FAIL("BPF object has no BTF");
+		return -EINVAL;
+	}
+
+	func_id = btf__find_by_name_kind(btf, spec->name, BTF_KIND_FUNC);
+	if (func_id < 0) {
+		ASSERT_FAIL("failed to find FUNC BTF type for '%s'", spec->name);
+		return -EINVAL;
+	}
+
+	for (i = 1; i < btf__type_cnt(btf); i++) {
+		const struct btf_type *t;
+		const char *s;
+
+		t = btf__type_by_id(btf, i);
+		if (!btf_is_decl_tag(t))
+			continue;
+
+		if (t->type != func_id || btf_decl_tag(t)->component_idx != -1)
+			continue;
+
+		s = btf__str_by_offset(btf, t->name_off);
+		if (strcmp(s, TEST_TAG_EXPECT_FAILURE) == 0) {
+			spec->expect_failure = true;
+		} else if (strcmp(s, TEST_TAG_EXPECT_SUCCESS) == 0) {
+			spec->expect_failure = false;
+		} else if (str_has_pfx(s, TEST_TAG_EXPECT_MSG_PFX)) {
+			spec->expect_msg = s + sizeof(TEST_TAG_EXPECT_MSG_PFX) - 1;
+		} else if (str_has_pfx(s, TEST_TAG_LOG_LEVEL_PFX)) {
+			errno = 0;
+			spec->log_level = strtol(s + sizeof(TEST_TAG_LOG_LEVEL_PFX) - 1, NULL, 0);
+			if (errno) {
+				ASSERT_FAIL("failed to parse test log level from '%s'", s);
+				return -EINVAL;
+			}
+		}
+	}
+
+	return 0;
+}
+
+static void prepare_case(struct test_loader *tester,
+			 struct test_spec *spec,
+			 struct bpf_object *obj,
+			 struct bpf_program *prog)
+{
+	int min_log_level = 0;
+
+	if (env.verbosity > VERBOSE_NONE)
+		min_log_level = 1;
+	if (env.verbosity > VERBOSE_VERY)
+		min_log_level = 2;
+
+	bpf_program__set_log_buf(prog, tester->log_buf, tester->log_buf_sz);
+
+	/* Make sure we set at least minimal log level, unless test requirest
+	 * even higher level already. Make sure to preserve independent log
+	 * level 4 (verifier stats), though.
+	 */
+	if ((spec->log_level & 3) < min_log_level)
+		bpf_program__set_log_level(prog, (spec->log_level & 4) | min_log_level);
+	else
+		bpf_program__set_log_level(prog, spec->log_level);
+
+	tester->log_buf[0] = '\0';
+}
+
+static void emit_verifier_log(const char *log_buf, bool force)
+{
+	if (!force && env.verbosity == VERBOSE_NONE)
+		return;
+	fprintf(stdout, "VERIFIER LOG:\n=============\n%s=============\n", log_buf);
+}
+
+static void validate_case(struct test_loader *tester,
+			  struct test_spec *spec,
+			  struct bpf_object *obj,
+			  struct bpf_program *prog,
+			  int load_err)
+{
+	if (spec->expect_msg) {
+		char *match;
+
+		match = strstr(tester->log_buf, spec->expect_msg);
+		if (!ASSERT_OK_PTR(match, "expect_msg")) {
+			/* if we are in verbose mode, we've already emitted log */
+			if (env.verbosity == VERBOSE_NONE)
+				emit_verifier_log(tester->log_buf, true /*force*/);
+			fprintf(stderr, "EXPECTED MSG: '%s'\n", spec->expect_msg);
+			return;
+		}
+	}
+}
+
+/* this function is forced noinline and has short generic name to look better
+ * in test_progs output (in case of a failure)
+ */
+static noinline
+void run_subtest(struct test_loader *tester,
+		 const char *skel_name,
+		 skel_elf_bytes_fn elf_bytes_factory)
+{
+	LIBBPF_OPTS(bpf_object_open_opts, open_opts, .object_name = skel_name);
+	struct bpf_object *obj = NULL, *tobj;
+	struct bpf_program *prog, *tprog;
+	const void *obj_bytes;
+	size_t obj_byte_cnt;
+	int err;
+
+	if (tester_init(tester) < 0)
+		return; /* failed to initialize tester */
+
+	obj_bytes = elf_bytes_factory(&obj_byte_cnt);
+	obj = bpf_object__open_mem(obj_bytes, obj_byte_cnt, &open_opts);
+	if (!ASSERT_OK_PTR(obj, "obj_open_mem"))
+		return;
+
+	bpf_object__for_each_program(prog, obj) {
+		const char *prog_name = bpf_program__name(prog);
+		struct test_spec spec;
+
+		if (!test__start_subtest(prog_name))
+			continue;
+
+		/* if we can't derive test specification, go to the next test */
+		err = parse_test_spec(tester, obj, prog, &spec);
+		if (!ASSERT_OK(err, "parse_test_spec"))
+			continue;
+
+		tobj = bpf_object__open_mem(obj_bytes, obj_byte_cnt, &open_opts);
+		if (!ASSERT_OK_PTR(tobj, "obj_open_mem")) /* shouldn't happen */
+			continue;
+
+		bpf_object__for_each_program(tprog, tobj)
+			bpf_program__set_autoload(tprog, false);
+
+		bpf_object__for_each_program(tprog, tobj) {
+			/* only load specified program */
+			if (strcmp(bpf_program__name(tprog), prog_name) == 0) {
+				bpf_program__set_autoload(tprog, true);
+				break;
+			}
+		}
+
+		prepare_case(tester, &spec, tobj, tprog);
+
+		err = bpf_object__load(tobj);
+		if (spec.expect_failure) {
+			if (!ASSERT_ERR(err, "unexpected_load_success")) {
+				emit_verifier_log(tester->log_buf, false /*force*/);
+				goto tobj_cleanup;
+			}
+		} else {
+			if (!ASSERT_OK(err, "unexpected_load_failure")) {
+				emit_verifier_log(tester->log_buf, true /*force*/);
+				goto tobj_cleanup;
+			}
+		}
+
+		emit_verifier_log(tester->log_buf, false /*force*/);
+		validate_case(tester, &spec, tobj, tprog, err);
+
+tobj_cleanup:
+		bpf_object__close(tobj);
+	}
+
+	bpf_object__close(obj);
+}
+
+void test_loader__run_subtests(struct test_loader *tester,
+			       const char *skel_name,
+			       skel_elf_bytes_fn elf_bytes_factory)
+{
+	/* see comment in run_subtest() for why we do this function nesting */
+	run_subtest(tester, skel_name, elf_bytes_factory);
+}
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index feb14f14006d..ff1caffefa52 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -1,4 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __TEST_PROGS_H
+#define __TEST_PROGS_H
+
 #include <stdio.h>
 #include <unistd.h>
 #include <errno.h>
@@ -210,6 +213,12 @@ int test__join_cgroup(const char *path);
 #define CHECK_ATTR(condition, tag, format...) \
 	_CHECK(condition, tag, tattr.duration, format)
 
+#define ASSERT_FAIL(fmt, args...) ({					\
+	static int duration = 0;					\
+	CHECK(false, "", fmt"\n", ##args);				\
+	false;								\
+})
+
 #define ASSERT_TRUE(actual, name) ({					\
 	static int duration = 0;					\
 	bool ___ok = (actual);						\
@@ -395,3 +404,27 @@ int write_sysctl(const char *sysctl, const char *value);
 #endif
 
 #define BPF_TESTMOD_TEST_FILE "/sys/kernel/bpf_testmod"
+
+struct test_loader {
+	char *log_buf;
+	size_t log_buf_sz;
+
+	struct bpf_object *obj;
+};
+
+typedef const void *(*skel_elf_bytes_fn)(size_t *sz);
+
+extern void test_loader__run_subtests(struct test_loader *tester,
+				      const char *skel_name,
+				      skel_elf_bytes_fn elf_bytes_factory);
+
+extern void test_loader_fini(struct test_loader *tester);
+
+#define RUN_TESTS(skel) ({						       \
+	struct test_loader tester = {};					       \
+									       \
+	test_loader__run_subtests(&tester, #skel, skel##__elf_bytes);	       \
+	test_loader_fini(&tester);					       \
+})
+
+#endif /* __TEST_PROGS_H */
-- 
2.43.0

