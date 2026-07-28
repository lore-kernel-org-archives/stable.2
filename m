Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4943C3F58
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 07:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785223532; cv=none; b=UMhZgh0UOJ35vBiF2wHhxfbqrnY7ih7DjmtkmuVvqhQer8LC/Onm6uGSROSRcDre1Ob9y6nEI3r0ih0DrJzPW0idxVFqd5BxaN/z8JPj4imDhtmBcCt7X3wZZMWCvoUh7ay/+WPj+hkCFDt/1DQpv8C6qJqMOuvfGAdeSkLZHyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785223532; c=relaxed/simple;
	bh=y+umH8wxMGxNk9Gws8mhEEO0cl6BOqSfoU5FEWJZWJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S5UKc6npywbLsMhJJGzdlQLO7Y3CiEHat2rpLpmiFr4IFQLr2YJ0XNPZwN2U6e1VKSVGnIQYSWgpLUiW9eOwA+2m+Srmn8j+KyEEQe9zAwARINzKm2Lo6aI5GPCs20U3sScUVNp6C35ih8Zz66uGm2ikEG4VReHQ/aUiGlgTh0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OTPeJlqy; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OTPeJlqy"
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-c169ae1cb26so110991366b.1
        for <stable@vger.kernel.org>; Tue, 28 Jul 2026 00:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1785223529; x=1785828329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OviTaoy3r0eqHIy1tKziY8rCZxMSKhDs7PxVoa+kzAs=;
        b=OTPeJlqy9I1EEgEB1q9izD+0g/YqlzoTwYdd28jPLi4ySej8PiHlWJWgkkXZoK9w1f
         3QTdoYqw9kPc4g4fB0IHzGpu/ECZ2HFqpbbeVwUftmaJVrZMAPTkGSvdw3JbpQ9lRNUm
         krUoxCN4DDd5rbZa8U7k8NSkQdnjiWRLeuvDoRADzYpYVJgwxJTkrPc2JjDNK7hkz3NK
         tXFt+Ji0QWvC9r3YhWlLwqRNdqPPaozk/rys91DZfktd+QDLKqjBhrWRQ55QXJJbUhhn
         4hMRjyWzqWllvx11xHZW/iQN8h7vbQhlyrA9iCSN/+RdpzY/8iGRZn7DBeChuVfGaqhf
         jURg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785223529; x=1785828329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OviTaoy3r0eqHIy1tKziY8rCZxMSKhDs7PxVoa+kzAs=;
        b=myWAIshH8L9xf+VLKNxKgG5mhRXgwFWmkjZBwRU4BT74gWBmM+Y5OU30AuucDkkx5B
         8F2OuHFbRuhCCSPXk+cXMngKrFztpx/1rsgCOMCBA9AKVYouJxuPB2nSQcNdirKjfTBv
         HFoL8bog/cRXbBZmaf1fkratr8+lHY/rP+3fjmRPjG6QHRMpjWJsLrxOELZpFvNaJMZ6
         MQaCPrFmHiJWtczFDxSdhS0rOpmGRt5vBEFLasb39Hq01X/wb3f4FaWGMVfBVtM2p+I1
         tkq+M1J1WARmir1POV9IkYyHAHkHzLLJnCslOwKpBAYoQelRKkDdXvH+EgzFNmLN5BNr
         O5Ng==
X-Gm-Message-State: AOJu0YwodlwjGcwwsUpgmRzE82t+19MjNqdhAaAWgVbfO+MLu7NklbPK
	d699JTd1YXiEJRDjozLHVhHZBhzpMl2Jwo/rp2DpI3BEt2XhRAmoP3VHJ8g840jP3JzDLPAZxSx
	A9a1St3ClpB/m
X-Gm-Gg: AR+sD103xjYS18C5eifKKG4mFLQNruRkxWqBFF1o94DVERGGbPUfkwrRSuBqOtjtE9q
	hNjFzPtcu4uDNwPROziaerehVn5birQD3xjlaZFoqbbyNDkfzgknknoyOyIf+MM0zBZgKBt7U71
	Hk/dW6umJfum+Kn8Hf8Eim0FrFE1Skmb3eMe6OSuVC+xGwPAbnNL7Hfd5dSVS3V0b/AcxkhCUGn
	84eD4Ge/tMEWF5A0vUcWsj7Z4AXNsb9M3S5XsIl3mywkK+2FVvh+v5HDeQt6ERvB/5OLX0UdXqJ
	8rfQC/zQL/bhlDo6kBM7FVZwhcm3GvzZrtFdESbJF5ABs52gh4w9rtQ3L+2eV6BnA3f6b8hfDJO
	WcKVD/qUCcLdbBloLMf4i8BW/ZqKGPZ5CKO+LO4peWC8zySV97fxOXZeGSXg/8wdKbLD8naZvHY
	XeXB1qzXAHttB4hYRGI6/LW2nSBQFjWsg=
X-Received: by 2002:a17:907:fdcb:b0:c10:10c9:6d8c with SMTP id a640c23a62f3a-c1f720a90eamr57074866b.28.1785223528467;
        Tue, 28 Jul 2026 00:25:28 -0700 (PDT)
Received: from localhost (27-53-136-186.adsl.fetnet.net. [27.53.136.186])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde7f8e73sm47022335ad.72.2026.07.28.00.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 00:25:27 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH stable 7.1 6.18 2/2] selftests/bpf: Keep verifier_map_ptr exercising ops pointer access
Date: Tue, 28 Jul 2026 15:25:09 +0800
Message-ID: <20260728072512.33620-3-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260728072512.33620-1-shung-hsi.yu@suse.com>
References: <20260728072512.33620-1-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Borkmann <daniel@iogearbox.net>

commit 082c412097716b93ff1365689fc4ddcd1ce8296f upstream.

sashiko complained that 38498c0ebacd ("selftests/bpf: Adjust verifier_map_ptr
for the map's excl field") would slightly decrease the test coverage given
before the test was against the verifier rejecting the ops pointer. Recover
the old test with the right offsets and add the existing one as an additional
test case.

  # LDLIBS=-static PKG_CONFIG='pkg-config --static' ./vmtest.sh -- ./test_progs -t verifier_map_ptr
  [    1.672932] bpf_testmod: module verification failed: signature and/or required key missing - tainting kernel
  #637/1   verifier_map_ptr/bpf_map_ptr: read with negative offset rejected:OK
  #637/2   verifier_map_ptr/bpf_map_ptr: read with negative offset rejected @unpriv:OK
  #637/3   verifier_map_ptr/bpf_map_ptr: write rejected:OK
  #637/4   verifier_map_ptr/bpf_map_ptr: write rejected @unpriv:OK
  #637/5   verifier_map_ptr/bpf_map_ptr: read non-existent field rejected:OK
  #637/6   verifier_map_ptr/bpf_map_ptr: read non-existent field rejected @unpriv:OK
  #637/7   verifier_map_ptr/bpf_map_ptr: read beyond excl field rejected:OK
  #637/8   verifier_map_ptr/bpf_map_ptr: read beyond excl field rejected @unpriv:OK
  #637/9   verifier_map_ptr/bpf_map_ptr: read ops field accepted:OK
  #637/10  verifier_map_ptr/bpf_map_ptr: read ops field accepted @unpriv:OK
  #637/11  verifier_map_ptr/bpf_map_ptr: r = 0, map_ptr = map_ptr + r:OK
  #637/12  verifier_map_ptr/bpf_map_ptr: r = 0, map_ptr = map_ptr + r @unpriv:OK
  #637/13  verifier_map_ptr/bpf_map_ptr: r = 0, r = r + map_ptr:OK
  #637/14  verifier_map_ptr/bpf_map_ptr: r = 0, r = r + map_ptr @unpriv:OK
  #637     verifier_map_ptr:OK
  [...]
  Summary: 2/20 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/r/20260602133052.423725-4-daniel@iogearbox.net
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 .../selftests/bpf/progs/verifier_map_ptr.c    | 34 ++++++++++++++++---
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_map_ptr.c b/tools/testing/selftests/bpf/progs/verifier_map_ptr.c
index d8e822d1a8ba..166193659870 100644
--- a/tools/testing/selftests/bpf/progs/verifier_map_ptr.c
+++ b/tools/testing/selftests/bpf/progs/verifier_map_ptr.c
@@ -72,17 +72,43 @@ __naked void bpf_map_ptr_write_rejected(void)
 
 /*
  * struct bpf_map starts with the SHA256 hash sha[32] at offset 0 (a readable
- * byte array), followed by the u32 excl field at offset 32. Reading a u32 at
- * offset 33 runs past the end of excl and is rejected.
+ * byte array), the u32 excl field at offset 32, and the ops pointer at offset
+ * 40. Reading a u32 at offset 41 reaches into the middle of the ops pointer,
+ * i.e. a partial pointer access, which is rejected.
  */
 SEC("socket")
 __description("bpf_map_ptr: read non-existent field rejected")
 __failure
+__msg("cannot access ptr member ops with moff 40 in struct bpf_map with off 41 size 4")
+__failure_unpriv
+__msg_unpriv("access is allowed only to CAP_PERFMON and CAP_SYS_ADMIN")
+__flag(BPF_F_ANY_ALIGNMENT)
+__naked void read_non_existent_field_rejected(void)
+{
+	asm volatile ("					\
+	r6 = 0;						\
+	r1 = %[map_array_48b] ll;			\
+	r6 = *(u32*)(r1 + 41);				\
+	r0 = 1;						\
+	exit;						\
+"	:
+	: __imm_addr(map_array_48b)
+	: __clobber_all);
+}
+
+/*
+ * The u32 excl field spans offsets 32..35 (mend 36). Reading a u32 at offset
+ * 33 starts inside excl but extends past its end, which the verifier rejects
+ * as an out-of-bounds scalar access.
+ */
+SEC("socket")
+__description("bpf_map_ptr: read beyond excl field rejected")
+__failure
 __msg("access beyond the end of member excl (mend:36) in struct bpf_map with off 33 size 4")
 __failure_unpriv
 __msg_unpriv("access is allowed only to CAP_PERFMON and CAP_SYS_ADMIN")
 __flag(BPF_F_ANY_ALIGNMENT)
-__naked void read_non_existent_field_rejected(void)
+__naked void read_beyond_excl_field_rejected(void)
 {
 	asm volatile ("					\
 	r6 = 0;						\
@@ -105,7 +131,7 @@ __naked void ptr_read_ops_field_accepted(void)
 	asm volatile ("					\
 	r6 = 0;						\
 	r1 = %[map_array_48b] ll;			\
-	r6 = *(u64*)(r1 + 0);				\
+	r6 = *(u64*)(r1 + 40);				\
 	r0 = 1;						\
 	exit;						\
 "	:
-- 
2.55.0

