Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1541D5160
	for <stable@vger.kernel.org>; Wed, 24 Jun 2026 07:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782286157; cv=none; b=R8YkjWANh4GmZIhl9yesaMBi/HG9/+KtVEGmcYUEnhLe60Bce7AO+OEztx+mSdT+sPGrIW7+6A8ov/mjDyFGOy01pNL4ZsoJkA6v/P5IdynHcFkd30/or1hYumbBuicx0UG+8w2WOViTIMJfEkjDXEXgN/MZQ3nVSl4M2cOfWFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782286157; c=relaxed/simple;
	bh=UhRMJd1Xj7Pduy9vsiTZEyEECth0+6brgLLAwrWC2Oo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TwfTWfb63BCu1vckqpbRALGkHUzF0viOngMZyYqoi7D3zXT/BwexHb8eaqZmZgdNU9Smu6tgOkcsvYJJn86I2DhrVdqgZG0/q55Rq7aYtunFT3BTNquV/9mvy0cdUOwugYsr5WLr37pWjuFlYumwB3RkwNuYXRGbKin5kHIJHkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CLn3a/du; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CLn3a/du"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-490cf3000f0so6401915e9.1
        for <stable@vger.kernel.org>; Wed, 24 Jun 2026 00:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782286154; x=1782890954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7M9Y3GfPRlY8nrM+Skebr5BNortoaDYZlNbvFiGOPL8=;
        b=CLn3a/duPoVdoz3qJBgPiCaM2uyuyvdZWJ4RJoYrpin3sdCsmYxSreJJTjgBvnRYW6
         4Vx2fi/kG++2Wr7fvz53Tcp9MdDr+qKQcx7y8ofCyLNt6V57FeROovyLSBkl7eOl6jQT
         Km/PcHlCP5yywipjsHslwsDObyHCwI1Q+coddgQWlYYnapX0wjh9i6FCQAVrt7EySnpS
         5gDXMpA85MLHCpk5Ujxcb+ivmc7MnqeMnDG64G5A9po0CRL2i5fPK3+Ez6Mxjxjg0qlT
         ZjDn+yLbKZwdKsw7y0kNhE82Q4AqvouI3jVYNoaQ21Q4WbL2J7NEn71gegJfQWWulI1J
         xz2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782286154; x=1782890954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7M9Y3GfPRlY8nrM+Skebr5BNortoaDYZlNbvFiGOPL8=;
        b=b2AMgrs6nWzaTvD8J1wzgxfAemHL2YO8QvLrF8i2g9+I2xY7s7irQWaIkwe1+vPaZk
         QxNm5vhdndpd8ZcvVt8U0fP8ctAXurUAKUWQPvvpqTzAjt5HzlgAdRCoUKrXktZP4BW8
         qPiZZty8VWswIFuf9JEjc/N2Q0nM3u95r+ZlFif/shoWB+kWG2z3yxq5G4x//6LTFjGw
         RvZEI3eWpD691viV/8hKjIhlkgp1H96oF9qX/lqsAJkxuLjazhPPveCDQbybg1t11QkZ
         ly2rOMYkS+cKk+N1U3QWILQLHhbCFQBIS5piQg1Dg4ucMu8jUNyMUaKtk0AR4tIgYLlF
         IDmw==
X-Gm-Message-State: AOJu0YxHNjJvxM8YfGDxOEkN5VGXYESSSNocnjIupWNGfx9LUZl/Yjwc
	e/RR7FMLNzYJtcqK+/097M/s032Dui5yhmIpHM37ZwUCa58+Kiv7cnKteGkli8uHYLH1GbTdAcH
	Gaum+0LaXVo+K
X-Gm-Gg: AfdE7cl1yNnqy3wj/I/MxSP2B/CzhfE53xIa98qQHr29rN9cy1z4stMtaqRhOlMaIcw
	+eq7/N+AcLRgw3av2iznFhUM1wLxnBE40QNTMQCGiV5cGA9ln+fF3inx0GBT+K3mFWw9+ehl9Ef
	DClJhcsySvb8aHY0wGz2jx48Tf/1Ul0GVeE+XdglsAVYudtI1aoOQ0DXG11Vwek2VT0OuVhmnLC
	u80TTlK79XG/fjGFs4bypMsqyVmmg55J6uW2HuPImdVSUtij1U2Ef2+Hnjp1CeYluRU+PQvXyp1
	vVXjQXJqjP2r6eRGNoEXIgyVxT8WLsIqHszs6sdVjGf/aw6irrE+e3jLg+zewGaQfr+iONAgCC5
	rbEyMwGNPO0xiIgYxSTx4zkXBUsrPiIj/aaIpV0ai46oMVT79TEd6vFVDDKZ0t8DTaIximyWw4q
	lmKAkgDfRV2SAaFgVZLNDDjZuE/Uwp0+W1sbq7oUU=
X-Received: by 2002:a05:600d:844a:20b0:492:6067:2a6f with SMTP id 5b1f17b1804b1-49260672a84mr21553795e9.28.1782286153934;
        Wed, 24 Jun 2026 00:29:13 -0700 (PDT)
Received: from localhost (110-28-2-172.adsl.fetnet.net. [110.28.2.172])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37de3ab4437sm1456243a91.7.2026.06.24.00.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 00:29:13 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Varun R Mallya <varunrmallya@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH stable 6.6 2/2] selftests/bpf: Add test to ensure kprobe_multi is not sleepable
Date: Wed, 24 Jun 2026 15:29:00 +0800
Message-ID: <20260624072901.28197-2-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260624072901.28197-1-shung-hsi.yu@suse.com>
References: <20260624072901.28197-1-shung-hsi.yu@suse.com>
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
[shung-hsi.yu: borrowed 'saved_error' variable from commit 00cdcd2900bd
("selftests/bpf: Don't use libbpf_get_error() in kprobe_multi_test"). ]
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 .../bpf/prog_tests/kprobe_multi_test.c        | 34 +++++++++++++++++++
 .../bpf/progs/kprobe_multi_sleepable.c        | 25 ++++++++++++++
 2 files changed, 59 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/kprobe_multi_sleepable.c

diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
index 4041cfa670eb..d41e140c3150 100644
--- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
@@ -4,6 +4,7 @@
 #include "trace_helpers.h"
 #include "kprobe_multi_empty.skel.h"
 #include "kprobe_multi_override.skel.h"
+#include "kprobe_multi_sleepable.skel.h"
 #include "bpf/libbpf_internal.h"
 #include "bpf/hashmap.h"
 
@@ -214,7 +215,9 @@ static void test_attach_api_syms(void)
 static void test_attach_api_fails(void)
 {
 	LIBBPF_OPTS(bpf_kprobe_multi_opts, opts);
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
 	struct kprobe_multi *skel = NULL;
+	struct kprobe_multi_sleepable *sl_skel = NULL;
 	struct bpf_link *link = NULL;
 	unsigned long long addrs[2];
 	const char *syms[2] = {
@@ -222,6 +225,7 @@ static void test_attach_api_fails(void)
 		"bpf_fentry_test2",
 	};
 	__u64 cookies[2];
+	int saved_error, err;
 
 	addrs[0] = ksym_get_addr("bpf_fentry_test1");
 	addrs[1] = ksym_get_addr("bpf_fentry_test2");
@@ -300,9 +304,39 @@ static void test_attach_api_fails(void)
 	if (!ASSERT_EQ(libbpf_get_error(link), -EINVAL, "fail_5_error"))
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
 
 static size_t symbol_hash(long key, void *ctx __maybe_unused)
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

