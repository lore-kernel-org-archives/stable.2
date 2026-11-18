Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795012025;
	b=CXtXA+XmUZLM2wuyW5Q/glae0dC4CCMek1oH+rC+Xp/FHdCFc/17mmbOgVdYj2+hkTXm
	 uso4FK7aEUYp9804/6YxqVFFEhELTzwORpXNyvXrYsAudqeTM0W+y/MXS2ukBT3dC+QKd
	 OQ4UHgl+lbk6SVjFDpcJGcd6pBzT0XG1H8223aNg01Z3vNojvJE5yOcG8Lwsk9heFk2Ir
	 HoAkhTS8fk8boMbPipVm3Q0u7VVPPhKwJ8wXvESZzTjWf4x2k3i6qa8aS1TAgVMvWb61b
	 pMnQA/r4b41mqMP35/e8E2FAhMmb3sk8NiJfaEUhVYqH/e2diQDihScdvYjwMdZ6ChA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795012025;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=1caUQuDAo9B4D1sZWQgRiYxVWIU2K0f+Qt+bmgwUoAU=;
	b=V8THA4vdJttHAyOM6/M706/e1IlFs8HHtktOzSxyTBPl3scRRJ/z7ywbQtPBaMGHINum
	 XeLlM6JWd+oOZOcQfMS7cj0DmO0FWCgiCNxs78WiuCPwldi6os7HgoSosqZqzsxoUGa/h
	 wHZwcMjD9Xgg/9w0Tiz+9kXhhfrg9EfL1kcPWGOnkOFM1H7FDjTEQtSab81oBIh7RS32S
	 mPYOLkAH6hIOfo6Wfp5ZgW/jHFPK377y2rennM1L5E/rRBv23X9ntGsNEJqQIL8HNLga1
	 6o35Xi7GtQ1Y1yVYSBbcPyBEIDRxdjhPmsJoq3ED0UN4GAkGVgzlu4iR4PUgwV/2FQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fajvUbTQ;
	arc=none smtp.remote-ip=209.85.210.41
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD9060A2605
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 14:27:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FD9060A2605
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fajvUbTQ
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-862b76e3c8cso436170a34.1
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 06:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795012024; x=1795616824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1caUQuDAo9B4D1sZWQgRiYxVWIU2K0f+Qt+bmgwUoAU=;
        b=fajvUbTQYt2JvgHLNzQe42oxgkdL9v/Po1xKgNM/5oV1jCJbQv/qCOHYu27C2Sou06
         j+cG1tQczT3clXQez9cUPm9wyf0DEvYJLRxJ+r60YU4fr28v3JV6yGr6a1EmJU8zxxIP
         Z4HGRx/tOCbob/4MiwN+fGl3Eq57QZXHqLPZRBp3mFBfRHtntvCF4V/5HR82z0shxxH8
         yHsBkOJJHkDdELhqM+jlltpm6S6A2PlOpRZNZwottLeu3OrWRIPisCA/tiZA/wdg6bIy
         eVxakUMW2YydBqArn5cAlLGTPAShUtpMVSqqrydi/coaKhez0ixDLvpUwBpLbO3xnygS
         tcxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795012024; x=1795616824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1caUQuDAo9B4D1sZWQgRiYxVWIU2K0f+Qt+bmgwUoAU=;
        b=GJD3vuwD7vmA2QPBQArvOI1Hl/fnQskCptNftfKUUho954AzR7mDTiYEB72m/gn8s+
         4JeotQlIAAyU3kpaUrQRLNPG1H4+p0r3La3lqmBWx8urlVEgNXRKbOLqxSPL9sqPhLLR
         4caHo9VNInqhVSiDz8jD5SrdngDI3NsEtdcd8wr4T8PBx+1XuGhU0jgiIb2NoBUrgLmj
         +cyhdrllNqkS+X0Bm/E4plS0sJROyHZpycbK30TN7Wwr3x/D1n6cc1C5oNG08U+UNGrm
         6jYtk8N63mqFB5UaupLnt9nxJLNNVX0ogjpBGfqDwd2AfyiCZIZpVgyNLjA+c5UTqD6g
         epLQ==
X-Forwarded-Encrypted: i=1; AL+hErHOKXXCAww+k0XIXSVvT33BFCMB11R1kEiGkkqc5IcKCiJYT04pMxY11j4axEL6NH23vto1zSw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/slEVF9Sm2bAKC1F3QsPJ7RUVBeEkI10qYb1/E4lyt4v0FsXci
	nb5+6aC0gVUs3pLHxn4J6kxmxkfPZ1jhtErzskTZlIjMNifR5RgEoyel
X-Gm-Gg: AYBFou346DS6MU35tbBi1gEqe/j1dGqCpbh9ibrxY/UGF4nnzB5gf4qBKgfq8UNPJh4
	41ZQSFGxS6uSYHJdktbvBTXGKAbM2pgvLMoEVB88YGRcrGHc/pVsYODB7m10KVjEaDgsj8gCeu0
	GCvVd16DoXQ6LXY4xgVBcnPlMdgM/Wac5mFjXxITz72FQ+fYUrFFjZRU1dL/WG11Dol5rlXKz9q
	e4SqGhbmbJza+utqwJoUE3tczRtD97XmDbLJzd+CxIE93iu4gjmHUUZ4mb7oUFCZXL7WzGSIAn7
	LrdwkHSRgQ1ZoC9i4FRVh9njS9zJad+BtgzFjcrTaP5OZZTbiUng0SPYwRrhg1AwNI5qyjCxuX4
	Aa2xJ/IeVjnD46AAHQgqWtSanUC9oapGKjfUdIvedJpUDdEWP2HZcGo9fAnJw27ER1cwQL6SzJa
	nAgLeu/HLcMy7SHC2eYi4KqxHHAsJ1H932BwY73Z5Wdt/I+nyXlgjNx8u22Jo5RW5JKdEycuQYn
	UaboKGznXf8zfdBNdcG7i/6zuor0MrysKUzkU4LsAShB/zO0yODN4xrHjZUm8rF/wz0eWHzDgTd
	u+Zz+YEb/NFpTAM+1Bezxod+EnVvW4NKhWYD+vV2Bx762ylXCtMIcFAsG/bolHiCLuasEhYk6WL
	w6r4h5OFrrg==
X-Received: by 2002:a05:6830:2692:b0:862:f05c:2fd with SMTP id 46e09a7af769-862f084c214mr2539116a34.3.1795012023649;
        Wed, 18 Nov 2026 06:27:03 -0800 (PST)
Received: from localhost ([216.128.135.139])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-862f024e434sm1999241a34.24.2026.11.18.06.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 06:27:03 -0800 (PST)
From: asatsuyu.liu@gmail.com
To: gregkh@linuxfoundation.org
Cc: asatsuyu.liu@gmail.com,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	puranjay@kernel.org,
	stable@vger.kernel.org,
	vadim.fedorenko@linux.dev
Subject: [PATCH 6.18.y 2/2] selftests: bpf: Fix test_bpf_nf for trusted args becoming default
Date: Wed, 18 Nov 2026 14:26:54 +0000
Message-Id: <20261118142654.3098395-3-asatsuyu.liu@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261118142654.3098395-1-asatsuyu.liu@gmail.com>
References: <2026111850-shiftless-popcorn-a566@gregkh>
 <20261118142654.3098395-1-asatsuyu.liu@gmail.com>
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

From: Puranjay Mohan <puranjay@kernel.org>

With trusted args now being the default, passing NULL to kfunc
parameters that are pointers causes verifier rejection rather than a
runtime error. The test_bpf_nf test was failing because it attempted to
pass NULL to bpf_xdp_ct_lookup() to verify runtime error handling.

Since the NULL check now happens at verification time, remove the
runtime test case that passed NULL to the bpf_tuple parameter and
instead add verification-time tests to ensure the verifier correctly
rejects programs that pass NULL to trusted arguments.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Link: https://lore.kernel.org/r/20260102180038.2708325-11-puranjay@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>

(cherry picked from commit cf503eb2c6c38bf449063f33790a96218a067718)
Signed-off-by: Yi Liu <asatsuyu.liu@gmail.com>
---
 .../testing/selftests/bpf/prog_tests/bpf_nf.c |  5 +-
 .../testing/selftests/bpf/progs/test_bpf_nf.c |  7 ---
 .../selftests/bpf/progs/test_bpf_nf_fail.c    | 57 +++++++++++++++++++
 3 files changed, 61 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_nf.c b/tools/testing/selftests/bpf/prog_tests/bpf_nf.c
index dd6512fa652b..215878ea04de 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_nf.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_nf.c
@@ -19,6 +19,10 @@ struct {
 	{ "change_timeout_after_alloc", "kernel function bpf_ct_change_timeout args#0 expected pointer to STRUCT nf_conn but" },
 	{ "change_status_after_alloc", "kernel function bpf_ct_change_status args#0 expected pointer to STRUCT nf_conn but" },
 	{ "write_not_allowlisted_field", "no write support to nf_conn at off" },
+	{ "lookup_null_bpf_tuple", "Possibly NULL pointer passed to trusted arg1" },
+	{ "lookup_null_bpf_opts", "Possibly NULL pointer passed to trusted arg3" },
+	{ "xdp_lookup_null_bpf_tuple", "Possibly NULL pointer passed to trusted arg1" },
+	{ "xdp_lookup_null_bpf_opts", "Possibly NULL pointer passed to trusted arg3" },
 };
 
 enum {
@@ -111,7 +115,6 @@ static void test_bpf_nf_ct(int mode)
 	if (!ASSERT_OK(err, "bpf_prog_test_run"))
 		goto end;
 
-	ASSERT_EQ(skel->bss->test_einval_bpf_tuple, -EINVAL, "Test EINVAL for NULL bpf_tuple");
 	ASSERT_EQ(skel->bss->test_einval_reserved, -EINVAL, "Test EINVAL for reserved not set to 0");
 	ASSERT_EQ(skel->bss->test_einval_reserved_new, -EINVAL, "Test EINVAL for reserved in new struct not set to 0");
 	ASSERT_EQ(skel->bss->test_einval_netns_id, -EINVAL, "Test EINVAL for netns_id < -1");
diff --git a/tools/testing/selftests/bpf/progs/test_bpf_nf.c b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
index b42e6e149e26..ad03ee504cec 100644
--- a/tools/testing/selftests/bpf/progs/test_bpf_nf.c
+++ b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
@@ -15,7 +15,6 @@
 
 extern unsigned long CONFIG_HZ __kconfig;
 
-int test_einval_bpf_tuple = 0;
 int test_einval_reserved = 0;
 int test_einval_reserved_new = 0;
 int test_einval_netns_id = 0;
@@ -99,12 +98,6 @@ nf_ct_test(struct nf_conn *(*lookup_fn)(void *, struct bpf_sock_tuple *, u32,
 
 	__builtin_memset(&bpf_tuple, 0, sizeof(bpf_tuple.ipv4));
 
-	ct = lookup_fn(ctx, NULL, 0, &opts_def, sizeof(opts_def));
-	if (ct)
-		bpf_ct_release(ct);
-	else
-		test_einval_bpf_tuple = opts_def.error;
-
 	opts_def.reserved[0] = 1;
 	ct = lookup_fn(ctx, &bpf_tuple, sizeof(bpf_tuple.ipv4), &opts_def,
 		       sizeof(opts_def));
diff --git a/tools/testing/selftests/bpf/progs/test_bpf_nf_fail.c b/tools/testing/selftests/bpf/progs/test_bpf_nf_fail.c
index a586f087ffeb..2c156cd166af 100644
--- a/tools/testing/selftests/bpf/progs/test_bpf_nf_fail.c
+++ b/tools/testing/selftests/bpf/progs/test_bpf_nf_fail.c
@@ -4,6 +4,7 @@
 #include <bpf/bpf_tracing.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_core_read.h>
+#include "bpf_misc.h"
 
 struct nf_conn;
 
@@ -18,6 +19,10 @@ struct nf_conn *bpf_skb_ct_alloc(struct __sk_buff *, struct bpf_sock_tuple *, u3
 				 struct bpf_ct_opts___local *, u32) __ksym;
 struct nf_conn *bpf_skb_ct_lookup(struct __sk_buff *, struct bpf_sock_tuple *, u32,
 				  struct bpf_ct_opts___local *, u32) __ksym;
+struct nf_conn *bpf_xdp_ct_alloc(struct xdp_md *, struct bpf_sock_tuple *, u32,
+				 struct bpf_ct_opts___local *, u32) __ksym;
+struct nf_conn *bpf_xdp_ct_lookup(struct xdp_md *, struct bpf_sock_tuple *, u32,
+				  struct bpf_ct_opts___local *, u32) __ksym;
 struct nf_conn *bpf_ct_insert_entry(struct nf_conn *) __ksym;
 void bpf_ct_release(struct nf_conn *) __ksym;
 void bpf_ct_set_timeout(struct nf_conn *, u32) __ksym;
@@ -146,4 +151,56 @@ int change_status_after_alloc(struct __sk_buff *ctx)
 	return 0;
 }
 
+SEC("?tc")
+__failure __msg("Possibly NULL pointer passed to trusted arg1")
+int lookup_null_bpf_tuple(struct __sk_buff *ctx)
+{
+	struct bpf_ct_opts___local opts = {};
+	struct nf_conn *ct;
+
+	ct = bpf_skb_ct_lookup(ctx, NULL, 0, &opts, sizeof(opts));
+	if (ct)
+		bpf_ct_release(ct);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("Possibly NULL pointer passed to trusted arg3")
+int lookup_null_bpf_opts(struct __sk_buff *ctx)
+{
+	struct bpf_sock_tuple tup = {};
+	struct nf_conn *ct;
+
+	ct = bpf_skb_ct_lookup(ctx, &tup, sizeof(tup.ipv4), NULL, sizeof(struct bpf_ct_opts___local));
+	if (ct)
+		bpf_ct_release(ct);
+	return 0;
+}
+
+SEC("?xdp")
+__failure __msg("Possibly NULL pointer passed to trusted arg1")
+int xdp_lookup_null_bpf_tuple(struct xdp_md *ctx)
+{
+	struct bpf_ct_opts___local opts = {};
+	struct nf_conn *ct;
+
+	ct = bpf_xdp_ct_lookup(ctx, NULL, 0, &opts, sizeof(opts));
+	if (ct)
+		bpf_ct_release(ct);
+	return 0;
+}
+
+SEC("?xdp")
+__failure __msg("Possibly NULL pointer passed to trusted arg3")
+int xdp_lookup_null_bpf_opts(struct xdp_md *ctx)
+{
+	struct bpf_sock_tuple tup = {};
+	struct nf_conn *ct;
+
+	ct = bpf_xdp_ct_lookup(ctx, &tup, sizeof(tup.ipv4), NULL, sizeof(struct bpf_ct_opts___local));
+	if (ct)
+		bpf_ct_release(ct);
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.34.1

