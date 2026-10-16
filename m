Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953761FE47B
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 02:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792117951; cv=none; b=DURHw3X1cjzFp4A1zQ+tQC5/ovzPuBRhWm/JGpri+X8AB7bGb6IsV2G0+11pdDBuRN/HQWCQZzYwsHzvbR9NYn+tn92M9hh55DdN4W/ZYeKmirXbJfE7xIrBhhT3GTh5+l5nJAkgtgMAiuZvCqe/N2RA/Gc1XwNtVXqmmk7eMbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792117951; c=relaxed/simple;
	bh=Jwbt4sna4q8SKqLdUWxKiDuVxC9GU3p1BMahIzU/F2A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cAv6LMZryVNWuLO1G3RNg3s4Ot9xO7LJaIH8dMfEoGMIBo4gB77izzOSbwqAbR1HIEGLQLWKL9LXG02iPO6o7vV4mWusgbMhurKHAkS0dyYqrrJMrANfGbslMsx9TXjKffLcB+hh7+0YZ3598Xy/RL9rBRluqTrTbKr6bs0hEPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=ihfPfg1D; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="ihfPfg1D"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-15ea896ddc8so3907544c88.0
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 19:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1792117950; x=1792722750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=B9xTWWD9mfzJtMcAru9lP6tSUbC9S1bscJnItCWs39w=;
        b=ihfPfg1DOeIlqGcgUwVDOXhrTBDxBBdUFyXNgVcKv0evpDlm0VwnnPBM3v9CkDpfDb
         b0VFEVLcuo8frMM2nZBGRUu5vr1UQ/kqVZeyrNqND2cSy5Gpt4kxYbeDSmub2frUQTFk
         21SHyDQ72+CZEMbzC/LLvmXKyBZe6vyXQK9Sq3sT69TiMa5VsA5hpLice1AmsvNzldAW
         end3lw5NHaVorHfSVxIiltN1FKZi3nK4y8o8xuy30llVPjrpYJDwd+p0DRDH1+M3Th3/
         JM5csGr4LgYDFNvMtt0lJFLpoWFTGLuUahfnje5Itq/8T8PVNHHt7sgirhb4BCMr2m71
         Swpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792117950; x=1792722750;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B9xTWWD9mfzJtMcAru9lP6tSUbC9S1bscJnItCWs39w=;
        b=XK0MmIDXGAMR/pdNdmsmi81rFGmtcX7XaujyWU2o6dVAWBHtrGPEe1snCUseL2EPpT
         uyXyE5Cq2iS8LqLAljpvVBJf+aMnqOHdsYj0mxQC78E5oWks26lqL/7UfC+pUpz5x9ii
         24Cq0kfoZjxyTRBynhe+C8LQOueohRaYS0BxmdR2xFv8hzmiVd3lTwhVxjhcORMDPuaU
         2OXG8tllUTd7MH9ljelrq6AXqDcnhBX3YRvByc16TUKsBvwyOSrI1JKMVEV3/IFhXJNC
         PWYHpZNZxBRDfLKboLDrDTWF4HAqTVC5YEVQXJWuPa6Q/IS1n38GkfQHcuvpZ51M8ng3
         3bHw==
X-Gm-Message-State: AFq9FYL50MfdYFhSqQe4IJFjlJs/AczQB8josfyBE/fB2bj9PyyK9NNm
	q+mgbTVI8ao0iOQZC50LvyOMN4O3uUe3usgeCpUGUcL4G0VluVBnA/D7O6SXORxTeY+U7josdSw
	1YW5nZbxxXQ==
X-Gm-Gg: AYBFou3Y4mgtRcjjl45wuRYo7I45FZoQootiDj+8y18NqEW5W/4zj8NVTXS7pDTkouv
	V2mcnQk79x5vjomsZIZ1undkItulMKjXln3D7jhhjkgSsOp9ez6BSfnQ3+UPAXrT6+HhQMxUsFe
	n39vBezM0jOfteYMdRhQonOAsKHp5DRDJAY4HRHu/J26lNZ5kn2/n3/gUia4/v6jRCMBwjwIYx8
	BvlBnxhHEOQvz5L6BoWY+CEjDHsgppKmR/6hrKsfDYDHnRXeA6r4YF7qAw2cmSphlRbo5nhiqq5
	9kQy9araMoY1JUCSX/vo+wBeEq3EP7iDUAc198Fc794Sl9nw5ZC476g7WIrPPswZ8YiElLDVeRF
	c9KQAndGtBtOar67raqoMGvFDufSaSPmWuLJRmF6FVflWmh5xSdvVZ/BsB5d7ik1nWWlK4g4SgN
	yDu2OXB+QBf212Ek0kxF7JdVIGizI4jkNqOGBq7wEGP6VDgy/T7xOeVfbYvSu2Ur+vUT2KYWN+s
	F0rXOUqFMknp7VHG0h/K75X4Ue3l9jg+oWkGw4CcJNZ43hw1naEGW1PWX24H3NGwPOsGw==
X-Received: by 2002:a05:7022:171c:b0:14f:8e70:fad0 with SMTP id a92af1059eb24-16a6090d024mr26389777c88.33.1792117949507;
        Thu, 15 Oct 2026 19:32:29 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:d66:d0e8:dae3:3257])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360813b6791sm2233692eec.6.2026.10.15.19.32.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 15 Oct 2026 19:32:28 -0700 (PDT)
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
Date: Thu, 15 Oct 2026 22:32:25 -0400
Message-ID: <20261016023225.19034-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
 
