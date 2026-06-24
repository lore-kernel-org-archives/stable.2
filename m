Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8C3388379
	for <stable@vger.kernel.org>; Wed, 24 Jun 2026 06:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782282178; cv=none; b=rJ4HiRe4mIPN77+79ecWm20BwUO7i52izReToq/glNGcQv/1EkVJLa4mzU1egjiAAY2MXPolSGNZBafBmo9DWpl9aL9yoZsZHXwtHpNFHMfxIOm6H1FoYpIHgHsk31+OrKl+TGrKFMnE5GXLc7jM3IVRjWMlIMX/OXa4DZEe42A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782282178; c=relaxed/simple;
	bh=Uhsyq0CUs3WXevhOJHuFqAYMxTAvMIMdMAGzrmceiWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mugqCEGl6/YkjvsKuYcyscQ/GXvWtwB9zQU1oslVAdgu/WYzX9cvfSThM9ru+i5SEV1xO91RrAJ8SHkaFsxJSpmTYDrx/aNwVQ5o7V0To7LMeLRf+yXihYR9K3CKM9uFVqZ9/UcN8OsZ4l1ztZU/7JlhidakNskSTta3kuTJ6KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=b83Xq97J; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="b83Xq97J"
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-c0d6c75c58cso101069166b.1
        for <stable@vger.kernel.org>; Tue, 23 Jun 2026 23:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782282175; x=1782886975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m2FYgyzT0EA6TeLkUKE25jXiBWCLsyh7nyw0QWKYGZE=;
        b=b83Xq97JFEDDLfg2Ry4VwV3XOKhsfl7qNcHEie4cx31rUkv9klK5YXI9qVXvMppiWJ
         mRNcQumKv/stAUA8y7n56/HhuTaPScrtXcPgJi1+CLPL8g1fTqtM+TqzERtD3pkY4YUw
         TlKLCIjaYAjAaT8RPdbI4K5C7Rt+3CvaA1vGkly4HOoEk8zN+TENMahH9QOL8tHg1r5R
         bXv4EPSsFDltqORJFao6Ppp0cfjc58ChLHgVVYT+JgbgEAiFr2XGWJwLFAWSasNaa2Rp
         i5MVMjg9GVp5oeyyroaqJ9jXnnh/UmxIEmB+vVuJwdBdOn9hd9yi8UKA2a4B2bXfY1tw
         EXSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782282175; x=1782886975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m2FYgyzT0EA6TeLkUKE25jXiBWCLsyh7nyw0QWKYGZE=;
        b=lhSKWA3WzSMfW8+50rTuAXhRc2clLp+gvXOw7ipWZEIce8mWFOJ1nEWlGX5kLL2hij
         HZVuHE1RQOe1sYAFaWyB8PfxUMtbIr5vdb1o0eTV0K+C8IGiRzpLDgGSOl9oiBt4FFDQ
         +k0jyfCzdI73O68mg0R7Q+AkRrL6jHF1/n/IsegOqee69ypzTzEFoYeJyGcgBp6tIMvs
         r9sNjbYr7zRRZHpmY3ixIpkiUXkElnsdUihVNqw9YxxZNxuZddIkrP0QQ/bVN6VIy/uw
         /AHnh+yFRh8EIvCh8kLol8u6k61XyxWB70vk10JNYbf3lCHSyW8G4aZUZzlv/NEMw7wk
         8SrA==
X-Gm-Message-State: AOJu0YybBxpTrPhUvujkU2uxmuqZ+WlXEKCwP/uErVycJoR4i46Nwiqz
	exfBR+IuvZNlYQSRxTRm+ez6f5eqI4tuLZWY67UoSPm1Ucjet7Y8AmU3bM2TDs8qZp1oICRszP9
	77BeJiHEaeKih
X-Gm-Gg: AfdE7cn4Ksl3Y2cGEWWnHbIAFEk2Sm6MMm06OR81PAuI7UE8b8N83pIcFSC/C/OOJmB
	R5eYV4ZeyGoXRN/4ywJtMVZEimS74vaQirgdnljrGNq0FDC6XWgQoDVPrTHJ9I7QCEL/CE+4maX
	49w7gmiSVZjRFmoIXIh/GfwHHO6oFRRWfrwcDr0P8Nv/kw2Mi78oR0nwCORydKojnPM0+Bs+ti5
	8ZJWZb4DNcAKglimdhDu1rcrXwkb5CNGzwgQdknZ4JzDdpj9vCkmRkUUMHGtzreyhkJiULGa8Ad
	WG/rwK0Sh11SAhMDiUDa7hWjOOQXETzDdClnVdNGGDa24enHR2Y9ZV8pdnH1rnXTSfRS61ZR6va
	cbQ0G34vYltRqE3+FpslkBwztiLH/bM+FiRQyAUlNiQTTM0/XePsuLrOu6Achld9Gj4+pvjdzsK
	eGeCWNHXeIYLcuQvve6w6jKP1n6J7tWrD0DWkAJ20=
X-Received: by 2002:a17:907:e8f:b0:be8:93c2:cbae with SMTP id a640c23a62f3a-c0c644a5667mr842151466b.19.1782282175026;
        Tue, 23 Jun 2026 23:22:55 -0700 (PDT)
Received: from localhost (110-28-2-172.adsl.fetnet.net. [110.28.2.172])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e94429a5bdsm11356754a34.22.2026.06.23.23.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 23:22:54 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Varun R Mallya <varunrmallya@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH stable 6.12 2/2] selftests/bpf: Add test to ensure kprobe_multi is not sleepable
Date: Wed, 24 Jun 2026 14:22:32 +0800
Message-ID: <20260624062235.21002-2-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260624062235.21002-1-shung-hsi.yu@suse.com>
References: <20260624062235.21002-1-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Varun R Mallya <varunrmallya@gmail.com>

commit c7cab53f9d5273f0cf2a26bdf178c4e074bdfb50 upstream.

Add a selftest to ensure that kprobe_multi programs cannot be attached
using the BPF_F_SLEEPABLE flag. This test succeeds when the kernel
rejects attachment of kprobe_multi when the BPF_F_SLEEPABLE flag is set.

Suggested-by: Leon Hwang <leon.hwang@linux.dev>
Signed-off-by: Varun R Mallya <varunrmallya@gmail.com>
Link: https://lore.kernel.org/r/20260408190137.101418-3-varunrmallya@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 .../bpf/prog_tests/kprobe_multi_test.c        | 35 ++++++++++++++++++-
 .../bpf/progs/kprobe_multi_sleepable.c        | 25 +++++++++++++
 2 files changed, 59 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/kprobe_multi_sleepable.c

diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
index 960c9323d1e0..4183c2c057a3 100644
--- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
@@ -6,6 +6,7 @@
 #include "kprobe_multi_override.skel.h"
 #include "kprobe_multi_session.skel.h"
 #include "kprobe_multi_session_cookie.skel.h"
+#include "kprobe_multi_sleepable.skel.h"
 #include "bpf/libbpf_internal.h"
 #include "bpf/hashmap.h"
 
@@ -216,7 +217,9 @@ static void test_attach_api_syms(void)
 static void test_attach_api_fails(void)
 {
 	LIBBPF_OPTS(bpf_kprobe_multi_opts, opts);
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
 	struct kprobe_multi *skel = NULL;
+	struct kprobe_multi_sleepable *sl_skel = NULL;
 	struct bpf_link *link = NULL;
 	unsigned long long addrs[2];
 	const char *syms[2] = {
@@ -224,7 +227,7 @@ static void test_attach_api_fails(void)
 		"bpf_fentry_test2",
 	};
 	__u64 cookies[2];
-	int saved_error;
+	int saved_error, err;
 
 	addrs[0] = ksym_get_addr("bpf_fentry_test1");
 	addrs[1] = ksym_get_addr("bpf_fentry_test2");
@@ -323,9 +326,39 @@ static void test_attach_api_fails(void)
 	if (!ASSERT_EQ(saved_error, -E2BIG, "fail_6_error"))
 		goto cleanup;
 
+	/* fail_9 - sleepable kprobe multi should not attach */
+	sl_skel = kprobe_multi_sleepable__open();
+	if (!ASSERT_OK_PTR(sl_skel, "sleep_skel_open"))
+		goto cleanup;
+
+	sl_skel->bss->user_ptr = sl_skel;
+
+	err = bpf_program__set_flags(sl_skel->progs.handle_kprobe_multi_sleepable,
+				     BPF_F_SLEEPABLE);
+	if (!ASSERT_OK(err, "sleep_skel_set_flags"))
+		goto cleanup;
+
+	err = kprobe_multi_sleepable__load(sl_skel);
+	if (!ASSERT_OK(err, "sleep_skel_load"))
+		goto cleanup;
+
+	link = bpf_program__attach_kprobe_multi_opts(sl_skel->progs.handle_kprobe_multi_sleepable,
+						     "bpf_fentry_test1", NULL);
+	saved_error = -errno;
+
+	if (!ASSERT_ERR_PTR(link, "fail_9"))
+		goto cleanup;
+
+	if (!ASSERT_EQ(saved_error, -EINVAL, "fail_9_error"))
+		goto cleanup;
+
+	err = bpf_prog_test_run_opts(bpf_program__fd(sl_skel->progs.fentry), &topts);
+	ASSERT_OK(err, "bpf_prog_test_run_opts");
+
 cleanup:
 	bpf_link__destroy(link);
 	kprobe_multi__destroy(skel);
+	kprobe_multi_sleepable__destroy(sl_skel);
 }
 
 static void test_session_skel_api(void)
diff --git a/tools/testing/selftests/bpf/progs/kprobe_multi_sleepable.c b/tools/testing/selftests/bpf/progs/kprobe_multi_sleepable.c
new file mode 100644
index 000000000000..932e1d9c72e2
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/kprobe_multi_sleepable.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+void *user_ptr = 0;
+
+SEC("kprobe.multi")
+int handle_kprobe_multi_sleepable(struct pt_regs *ctx)
+{
+	int a, err;
+
+	err = bpf_copy_from_user(&a, sizeof(a), user_ptr);
+	barrier_var(a);
+	return err;
+}
+
+SEC("fentry/bpf_fentry_test1")
+int BPF_PROG(fentry)
+{
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.54.0

