Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792602991;
	b=S7UdaWVkgiXfGesKbIH70RgqQXgawBfIjIo4O82cqkMOY2X3LIaaJWmjFdCu5Kf7rmd6
	 j5taWUv3IFa8l9ww/dhLAIa+nZUwBbzlHyezqlCQ7PZFFPQ2vQhN7lMVWi54n89aIAYBF
	 eu9eVkdMFlx+iu4sBAKCLhJCWePrrXHi+1ttvTiQJNrMdVoFIphvvCdWYlc06/hLgg/kX
	 dHbAwX6Nj+5RoG82lantP4Ew88kt5LHri/LR+jbPuL1xqt0C+La791RUASDKMySeE3dlD
	 JLdMuMwKkzmkm+ItGUApPvJl8VhFNbxaf5Snq0mLcGwcUl+MwlbsbAcD0BzPXJr8yjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792602991;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=B9xTWWD9mfzJtMcAru9lP6tSUbC9S1bscJnItCWs39w=;
	b=gBe6R2SQDfJjykEJWkyZ2SzuaGdduCGHn/gMWNfmNXVVIHIfpQ2th6YuyQiFfGyXx6f+
	 qr6LEfGN0mOXvR2LYpfKfByYtmMxvSbYqSoGZCKOiFewC1T30fzn7y56lMiM3VF0YtXQi
	 5siIaQ2UmQC0AxOiMRW4OsKjwinkXQsYcT92f3+uMj/I8L8SHF74MgGHR+QGSSVyeaUCf
	 2ZydLdvg3H4/KdueNp6uuN0VvzhE6fSA3k74AL4xVmpwufWLpZ/yTQS9xiK3w4Y60wwUT
	 RSlWnr8i3PXEM39rgcwnSIndHaj2PZt00+YNXY4SIThHbl4oePqqHSYChpf3QV1HjLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=trailofbits.com;
	spf=pass smtp.mailfrom=trailofbits.com;
	dkim=pass header.d=trailofbits.com header.i=@trailofbits.com header.a=rsa-sha256 header.s=google header.b=f5amWmm1;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B829606A31F
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 17:16:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B829606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=trailofbits.com header.i=@trailofbits.com header.a=rsa-sha256 header.s=google header.b=f5amWmm1
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-170135e43c7so903436c88.0
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 10:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1792602989; x=1793207789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=B9xTWWD9mfzJtMcAru9lP6tSUbC9S1bscJnItCWs39w=;
        b=f5amWmm1rM7SwpLLXKz2K+o6DHbLZHwpLVXk6EryPZsEbT8GBgDBGLsGk5nqeXShGB
         h7dSo9hGdeZuxhJ+5uTl7kUcYMYrnCCUhv6w7LandIJoFUnSHGeuMk+q/bLvv5BEW2Z2
         o//QDUb7cXaEXBIg4js5X9+vEFJpS3sThCQHAmy8eePIzGzIK6vAY2iVp8DBIiRvS0h2
         NST6tbFgsTm7F30uH/0ZSa7JuAMZA4pkpXBG4TfVmbqqcFxbViwBJaCozcdxNFGErRdZ
         GyyJNi+3oCazMrFJJbNYJOVYQqywnL51/mt22X+A4Z6vwRH/nxZqUabVBKrAh8eYYhEQ
         i+TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792602989; x=1793207789;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B9xTWWD9mfzJtMcAru9lP6tSUbC9S1bscJnItCWs39w=;
        b=qjisTAT0w45CLTk6MNOXPjxJ3t52XvFAH5Rg+qNpswkcLZ+w3mhUMUYaPN1jIUQkNL
         P4dxrEevmgXKeidn86b4MGE1OxO61DanauOu8Iu2AOKVyiBviNBa6m8w5U6Q2y9Fkhlq
         OgOjrhXxF2+LXyy2GyGvV/zSsGfySllFyMyh0kIEX3FIB4fWfT3xeefkqR+sF3pSadje
         o8XYwP3DSlcCu60gGBR5X/U7TqmL4JsIMt0NsGw+HkZmkmqPODgoBiYNtSvkGP9yCFdz
         iNxyG9LYK7mmt7uQXzc6axbVTlMYJDJ6rWe94Sz9f3bic6XwB8Bg+wMzN6tBzLYFCHwe
         oldA==
X-Gm-Message-State: AFq9FYKXB5vUn6BiM+zB8ktgwELdmuOIWfFkcFWw5p6FFZSM/HAvcP+g
	mhepN3i5nrounUKGwDGl3T6m+n05DEuxwL+I97HYUjVt0SXxmZfWJe16AJnmMc1TcZ2BHShiUAP
	6T24SbOPXIw==
X-Gm-Gg: AYBFou1fP/vHzJd+M+RoQTSm1x5wXpaqoEA1jsIANj5xez8XYjeVeO09p9+/u1PSjsK
	8hcjWu0zoq8HmOC7TUK7JE2RZRlsNda8AAnLYUq1t85956noYGrkIQioPfZRdZuz5e+GZzFUYyV
	45TmkUu5bqOQG6xcGXlN9Qhxc8O+M8GwMVuAjmiHmjYhAhYTgHw0xzeVoR94JiNRWAk1WTeR3Ys
	UrD6wFxB1tbjNtj/b9aJ9DLZQIcNV/mOgraLnPYyYZVJg7e740zv99ImFxEUTQ1PfIX0vYjiF0K
	n7M5/9Qu4Xsnp+CXA+gfodz2Pe3Uz31CvlICjsrlbS5jCQcrFHwDYIuQ7IcoVr+TToJnlFClOQL
	I7TBEEU0jbUTz7MzF07kWFcrVJ2wMe2FnzE4XWzilWufC8rw9+ZaQETKo0q5J2O4tECz37s9wpU
	Orj8Mf7iR96iu83G+fcGS02w/Syu02ilHht5qvYB2ULhcmKz4ZmeBkfrC74eG5M/81chWLHoRIF
	7XZ2wM7+ox07QNUQFE4zRMYMW7EtQiiJkG3MQm2gorYlEcThMG24F2v26ljs/IwGAvbRZDxoFgG
	lgW8QfICPi+AY74Uoys+CyyP7TUXzmxSbB7jHp4xb023fiwQJac2
X-Received: by 2002:a05:7022:3f09:b0:18b:bce0:a227 with SMTP id a92af1059eb24-190a6adcd36mr3737924c88.15.1792602988593;
        Wed, 21 Oct 2026 10:16:28 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:d059:e601:becb:a5ad])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903aefe90asm7392775c88.9.2026.10.21.10.16.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Oct 2026 10:16:28 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	contact@arnaud-lcm.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev
Subject: [PATCH 6.6.y] bpf: Fix stackmap overflow check in __bpf_get_stackid()
Date: Wed, 21 Oct 2026 13:16:25 -0400
Message-ID: <20261021171625.206-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
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

From: Arnaud Lecomte <contact@arnaud-lcm.com>

[ Upstream commit 23f852daa4bab4d579110e034e4d513f7d490846 ]

Syzkaller reported a KASAN slab-out-of-bounds write in __bpf_get_stackid()
when copying stack trace data. The issue occurs when the perf trace
 contains more stack entries than the stack map bucket can hold,
 leading to an out-of-bounds write in the bucket's data array.

Fixes: ee2a098851bf ("bpf: Adjust BPF stack helper functions to accommodate skip > 0")
Reported-by: syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com
Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Acked-by: Song Liu <song@kernel.org>
Link: https://lore.kernel.org/bpf/20251025192941.1500-1-contact@arnaud-lcm.com

Closes: https://syzkaller.appspot.com/bug?extid=c9b724fbb41cf2538b7b
Assisted-by: LLM
[ Backport to 6.6.y: stack_map_calculate_max_depth() was introduced by
  e17d62fedd10 ("bpf: Refactor stack map trace depth calculation into
  helper function"), which is not in 6.6.y; open-code the same
  computation in __bpf_get_stackid(). ]
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi,

Please consider this backport of the fix for CVE-2025-68378 to 6.6.y.

The only difference from upstream is that the
stack_map_calculate_max_depth() helper, which 6.6.y lacks, is
open-coded in __bpf_get_stackid().

The complete fix is already present in 6.12.y, 6.18.y and 7.2.y.

Build-tested only as part of a cumulative 6.6.y series on x86_64
(allmodconfig, CONFIG_WERROR=y); no runtime testing.

Thanks,
Artem Dinaburg

 kernel/bpf/stackmap.c |   20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -216,7 +216,8 @@
 	struct bpf_stack_map *smap = container_of(map, struct bpf_stack_map, map);
 	struct stack_map_bucket *bucket, *new_bucket, *old_bucket;
 	u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
-	u32 hash, id, trace_nr, trace_len;
+	u32 hash, id, trace_nr, trace_len, max_depth;
+	u32 curr_sysctl_max_stack;
 	bool user = flags & BPF_F_USER_STACK;
 	u64 *ips;
 	bool hash_matches;
@@ -225,7 +226,12 @@
 		/* skipping more than usable stack trace */
 		return -EFAULT;
 
-	trace_nr = trace->nr - skip;
+	curr_sysctl_max_stack = READ_ONCE(sysctl_perf_event_max_stack);
+	max_depth = map->value_size / stack_map_data_size(map);
+	max_depth += skip;
+	if (max_depth > curr_sysctl_max_stack)
+		max_depth = curr_sysctl_max_stack;
+	trace_nr = min_t(u32, trace->nr - skip, max_depth - skip);
 	trace_len = trace_nr * sizeof(u64);
 	ips = trace->ip + skip;
 	hash = jhash2((u32 *)ips, trace_len / sizeof(u32), 0);
@@ -354,15 +360,11 @@
 		return -EFAULT;
 
 	nr_kernel = count_kernel_ip(trace);
+	__u64 nr = trace->nr; /* save original */
 
 	if (kernel) {
-		__u64 nr = trace->nr;
-
 		trace->nr = nr_kernel;
 		ret = __bpf_get_stackid(map, trace, flags);
-
-		/* restore nr */
-		trace->nr = nr;
 	} else { /* user */
 		u64 skip = flags & BPF_F_SKIP_FIELD_MASK;
 
@@ -373,6 +375,10 @@
 		flags = (flags & ~BPF_F_SKIP_FIELD_MASK) | skip;
 		ret = __bpf_get_stackid(map, trace, flags);
 	}
+
+	/* restore nr */
+	trace->nr = nr;
+
 	return ret;
 }
 
