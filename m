Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15295367B72
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 02:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792117133; cv=none; b=Tc3dagULTtAUEA8p66FHTHhcaEYXb36udgZ49njP1xfCIPkjSuTammcEFop5kcSTfgNNin3RdWsHB4ORwC1i6IYjUeb+pQqFr6s+hnd3b5n7JYB3EyfSKf/GHDK0E8pa88QPAN4a6wwm9wB+93dDLfwKxPl4IZUlG9i8B/c6J7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792117133; c=relaxed/simple;
	bh=fS+1/YDK2c5xj53yMJr2qNGjho16cvGDrTz0OXunelg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p8yl51jtnG53O3XJv4mBODMBFNjqZE5q7UOxHpAi3+KLue4r9kAUscIj1nUd1QOIT/QyMWSourB6CDPds7PLGAev4EMG8FgQDHwCguInG1LEAf1D3Zz5QMcOiHOUZ2uFEEQjl2tocjp6+hz1l4PjQy/UdraUn/ZUAFz1Csdby/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=kDJg9C6E; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="kDJg9C6E"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-30b6dad2382so14198855eec.0
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 19:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1792117131; x=1792721931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jc4afiZdmgjSlBTxJSupYGZTonwC9tDWBHg+soEoOIU=;
        b=kDJg9C6E6s54SvQqum55RjuOd050HlahDc0l1d44tbN6OD/+DRTPIBPzIu9fry47bB
         YTFQWCHTh5WylcAc7j8Kh7spJT46A4LiXlv8ZdbJFZ4k4rYU8ejyW3Xyd34gnAPUlua9
         ygiQYsA3SEWtixKThI9KzDbv6oTEMOLKLstjA+L8j5sNIo829EHJR5c0MGIOMvPAeypP
         SiroDSdv9CTZUg/Z4n1TlLHXYqGGD/yjsRMh6SvUV9RyNuInhD5STCXW0prvwogJsb0i
         fu5gaNeFp2Uo8/ceh/HTfY5oOjs+K/WWLTcPfYALB2NQm1WWV7J/vF7KsSjy5T4629Xl
         GAzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792117131; x=1792721931;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jc4afiZdmgjSlBTxJSupYGZTonwC9tDWBHg+soEoOIU=;
        b=oahF1t0ysiB/7THb3ukV3W21z2ai5vlbJ3nwnpNdO8ZaQk3pCBShJN/sRuLVRTsUB+
         cSfEGMRM4XrVW+O9OUGvLcuUin2Wmf1CYW2z5YtdO9yu2cKR7RPF3qZsIO6dD2Mryyzu
         fKjCb8u9gUmqG2IVXkE+z3OH0/wNkr7pkco1p5sqLlWCJDFTfDXtTcr0CgrUBUNZoKtH
         5eZeNfaTuOXlQJwaOpRORDh7gwRzc5H7XVEHH/5jJSKgs8E72HNfmM/PVCjwWl9tsMOu
         NgVLktTSAw0bKyIQpoM/IhvczeKLS0SsszLf1pIDyDuudFi9oj/zMOMo+xboil4jB47F
         k68g==
X-Gm-Message-State: AFq9FYIWWaOsCXkDF/ps/0tEcpWk5A5SmoP3Lkyn2NsxzKtcjh9hqiBH
	7x4vLyw+RvocSHByj4Qp8BdAkx42OGNJ6HqLRQCpgC5q80FDth+4lKuwLokwh5tj4m/yaUbBB+I
	oOjkOPAGAbg==
X-Gm-Gg: AYBFou1ujbRvl58WD9PZOv69vtZ+FUDoEjTxLrE+IRubUEDHIhWz/GLaAMKwLwUgZ3R
	6fVzRtUQ0y1ou2gfAEy96cDe2Q88L4Q1xXSOklrbyK/3L4oBK0MOySBMVyikH8f/As1/YsfzwLG
	yq7+DGT7eIVCIMYBAeOZO48YV2pA9F0mpxh7uUWil43VEV+NNdvuD9Fp1LhgVJYKmeWm6b1ZG10
	nsUOrrcNnOb+0B7hR8nRzReV0nz40qBnORmNxqVrpxWmEdIXtDidBUwew44Fdbwsfx9X+d3xp4j
	lgngQMrkW2WI7zIF/XVFwgHaaCMM4y8cgYWszjILyANtExtYVTcYfXqQy4iC0ToCA9kalRzjJC4
	07SCkndLXnVp/ArlICeyfSau5vPAtmunMCH6hl6BamWMkbe8rZx1uupt/2DnIDErmeWJuzmAFUD
	qh93Vv+HqPqbatLzns2k6ZBXlkVAid9ihYkMJnhZDYKqn+Z4ptgjWwJqfSlgzPNFCwxGfOXTZvC
	7XzrDEwTechMjtE/stXhk5GXzIMs87dwHxmtlgIzL50rFsg97AOc1QWQijtROIMcB5ITbpSo5mP
	l/h3
X-Received: by 2002:a05:7300:828a:b0:34c:d1f2:b552 with SMTP id 5a478bee46e88-3537dedaa87mr26642176eec.4.1792117130878;
        Thu, 15 Oct 2026 19:18:50 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:d66:d0e8:dae3:3257])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3608219f838sm1887564eec.19.2026.10.15.19.18.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 15 Oct 2026 19:18:50 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	martin.lau@kernel.org,
	martin.lau@linux.dev,
	memxor@gmail.com,
	song@kernel.org,
	thevlad@meta.com,
	yonghong.song@linux.dev
Subject: [PATCH 6.6.y] bpf: Fix kmemleak warning for percpu hashmap
Date: Thu, 15 Oct 2026 22:18:47 -0400
Message-ID: <20261016021847.16847-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yonghong Song <yonghong.song@linux.dev>

[ Upstream commit 11ba7ce076e5903e7bdc1fd1498979c331b3c286 ]

Vlad Poenaru reported the following kmemleak issue:

  unreferenced object 0x606fd7c44ac8 (size 32):
    backtrace (crc 0):
      pcpu_alloc_noprof+0x730/0xeb0
      bpf_map_alloc_percpu+0x69/0xc0
      prealloc_init+0x9d/0x1b0
      htab_map_alloc+0x363/0x510
      map_create+0x215/0x3a0
      __sys_bpf+0x16b/0x3e0
      __x64_sys_bpf+0x18/0x20
      do_syscall_64+0x7b/0x150
      entry_SYSCALL_64_after_hwframe+0x4b/0x53

Further investigation shows the reason is due to not 8-byte aligned
store of percpu pointer in htab_elem_set_ptr():
  *(void __percpu **)(l->key + key_size) = pptr;

Note that the whole htab_elem alignment is 8 (for x86_64). If the key_size
is 4, that means pptr is stored in a location which is 4 byte aligned but
not 8 byte aligned. In mm/kmemleak.c, scan_block() scans the memory based
on 8 byte stride, so it won't detect above pptr, hence reporting the memory
leak.

In htab_map_alloc(), we already have

        htab->elem_size = sizeof(struct htab_elem) +
                          round_up(htab->map.key_size, 8);
        if (percpu)
                htab->elem_size += sizeof(void *);
        else
                htab->elem_size += round_up(htab->map.value_size, 8);

So storing pptr with 8-byte alignment won't cause any problem and can fix
kmemleak too.

The issue can be reproduced with bpf selftest as well:
  1. Enable CONFIG_DEBUG_KMEMLEAK config
  2. Add a getchar() before skel destroy in test_hash_map() in prog_tests/for_each.c.
     The purpose is to keep map available so kmemleak can be detected.
  3. run './test_progs -t for_each/hash_map &' and a kmemleak should be reported.

Reported-by: Vlad Poenaru <thevlad@meta.com>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
Acked-by: Martin KaFai Lau <martin.lau@kernel.org>
Link: https://lore.kernel.org/r/20250224175514.2207227-1-yonghong.song@linux.dev
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Assisted-by: LLM
[ Backport to 6.6.y: Omit the htab_percpu_map_gen_lookup() hunk;
  this target has no corresponding helper. ]
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi,

Please consider this backport of the fix for CVE-2025-37807 to 6.6.y.

The code changes are identical to upstream, except the generated-lookup
hunk was omitted because 6.6.y has no htab_percpu_map_gen_lookup(); see
the bracketed backport note above.

The complete fix is already present in 6.12.y, 6.18.y and 7.2.y.

Build-tested only as part of a cumulative 6.6.y series on x86_64
(allmodconfig, CONFIG_WERROR=y); no runtime testing.

Thanks,
Artem Dinaburg

 kernel/bpf/hashtab.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index e14a0caa07bfadf9daf7720c065aca810165e310..fb7f64c494b0e3b181cea397b79327e1585a76ed 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -197,12 +197,12 @@ static bool htab_is_percpu(const struct bpf_htab *htab)
 static inline void htab_elem_set_ptr(struct htab_elem *l, u32 key_size,
 				     void __percpu *pptr)
 {
-	*(void __percpu **)(l->key + key_size) = pptr;
+	*(void __percpu **)(l->key + roundup(key_size, 8)) = pptr;
 }
 
 static inline void __percpu *htab_elem_get_ptr(struct htab_elem *l, u32 key_size)
 {
-	return *(void __percpu **)(l->key + key_size);
+	return *(void __percpu **)(l->key + roundup(key_size, 8));
 }
 
 static void *fd_htab_map_get_ptr(const struct bpf_map *map, struct htab_elem *l)
