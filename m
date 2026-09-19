Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2436C3A6B73
	for <stable@vger.kernel.org>; Sat, 19 Sep 2026 07:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789802017; cv=none; b=fPn9Wp+2SaEhoI7Q0cvS66S53n7YoFZuIdmmQ8tMI48lxsLNXDilvb/s9aMeupA8YN5bdG4zln6Wt3g1E+MP0XssY++5TyT2xxXnMMsPxm7BToRG5EIr+/UGbqcDjG5T2dhvIsUE8UfYO1mIjmp95tVtuo8cO1iXxiApZ5Zm2EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789802017; c=relaxed/simple;
	bh=tCJZ0sGm20CQt/SDkdnQQGWtqC2TWAOAbuUKE9smfFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R072rNZD24J13SqZf8mQQA68qktWxf2LJoOf2rEXI1FEfjUw70k7+94zmd3U5YD211LYmTXTSWb1kWVl/ottCfJoPzUs0EJTGMm5RYE09jo3t72mQzY1DYCVqmqcmFq9byYWvY9jY6L3hezuX9X+vlAqW7Ejv7o5CxLUyTe1slo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h1sx5NTc; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1sx5NTc"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccd4f99dso1597493a91.2
        for <stable@vger.kernel.org>; Sat, 19 Sep 2026 00:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789802014; x=1790406814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v7zSksbU63dtRbVANyp6hQdrkXI5XkDjvPOFv3Zg/ek=;
        b=h1sx5NTcu7OAzsLtYlj3jReNjm5t3xAT5U/8dc1JDe3jrhepppxrs/L5/UceRHHpqs
         4xWpcjFumj/UB5ZWMKv2AnwqPZOvuUqI88Aa3Y2GjmDPRqe0NKqjxD1gv40gJapfarxX
         baUP7rjHjB5oy5xIpKVqh8gF7J6eASZwDtyBBdPPWVnSjxRMHy6zzEWd11Sq+6Iz9ycr
         6CraFCIST8Er6GpP/7eb6ycQUmZmB50AIE+3QriP9a11cIe9MvqtWX3SJvz3v7gKtSyu
         4AeSLF/0CtkcDTSd0cujlD83zrlDIDMn1HLfWChduub6luUaaGfjuwkUgjaO3cy830gd
         ZPeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789802014; x=1790406814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=v7zSksbU63dtRbVANyp6hQdrkXI5XkDjvPOFv3Zg/ek=;
        b=NXPqeAXq0j1rJyXRCjXDUGlyHfIoyB3+ZXTRd4JhlnvZs2nqnevEwXStFmKB8a2mm/
         1QO+mP3jISuI0wh1Q0fsuXSlYijyMqDJnEPyyh/4ZvKve9wuIqK13aNA3KR8MdUeuzxZ
         kUEwASzaDKu2ZgEFS6G+roqkm3X28vsF+VY+1wdhKmHRs3nR8kcGl2U6QEjS2NZkp7YZ
         2i2NAdB9VBWOpGAP5vuRxF40fecY1JQQBey7DKDtXmAHzV7Vk0YcsHTfBxj2OPkvnjLp
         y6o6RGCkH3mWE2UzPCDwk6mDU960OrW+4LFvA2rtT7fI0gJ5zpTaIvoPy8Ud2LLqpp/K
         mwiw==
X-Forwarded-Encrypted: i=1; AKwUvBzDgoQTXln5yKekoWQGsJBkmeGKyNrEJItJq0AoVVf3zDvzdTWlFRU7VzYCZPhTX/VSUxz4rMs=@vger.kernel.org
X-Gm-Message-State: AFuF++k2pPgiLUIWBvtNlVp4mUaZPB4N1oPJtfZydW5N2oYlcqDOYSqB
	vs5Gv84Dogs1NCozuUzYv9EqiAtioShmW4a8zZL4xjwoF/P1zFRNRiwF/AopDKATrw==
X-Gm-Gg: AYBFou29kmIXxwaHJo+YF159SOMr6y/ToLHXI5m4uP6+ofkAbANgG4pjirj/Yj/9jiT
	buZ0IzXtg5n5MZSfDm+juVkGnzJrkcYpmi29y3J2DsvpffzkoKJN7Rc1OV+5U5kRKiCWVnmE18e
	AXTseDHPUF1yqRUYDxX4EVPX9FAVl3m9Tjos7CrTiA1Bl8euukItKVO/admHNeQcgl8Z/T+9ntH
	rXg3tGUWhVFeIBF87GJEhKEfZyuRCEOK8BNF2qw6e1npyhug6qXVHSk0NJ7HRCqkKkhFwhdH7KX
	ATePeHnYj4xQBkWr/a0Mtyn8yeNZjlTDU/5AuaSUwsHR21Sl9n0C+w6QQa5ghp7NhCGHkcUo1dE
	7KsgHmk4CFAdRPNzQHKzbe9AkH+qAEUEeulxfHTrcsFLDanDTv2XQn7BURM9xr0sJxDdYf9Sqzq
	kyNY5S0Bzc1Kv59N7Q0fP6zHOVA/pFqr6oFYy9N44eBfh/0CLot3ev/0MVkgeTu+BPUm4d+OubP
	W5jrFnW4rtPqHZhUX3wQdmFYZM=
X-Received: by 2002:a17:90b:164a:b0:39e:4d7b:b247 with SMTP id 98e67ed59e1d1-39e54ea66cbmr9161582a91.19.1789802013941;
        Sat, 19 Sep 2026 00:13:33 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:7f00:8c85:45e5:9e39:6356:6164])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a02738654csm1050170a91.3.2026.09.19.00.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 00:13:33 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	donggeunyoo.kernel@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v1 1/2] mm/damon/core: prevent size quota overflow in the temporal goal tuner
Date: Sat, 19 Sep 2026 16:13:23 +0900
Message-ID: <20260919071324.1583280-2-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260919071324.1583280-1-donggeunyoo.kernel@gmail.com>
References: <20260919071324.1583280-1-donggeunyoo.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damos_goal_tune_esz_bp_temporal() converts the scheme's size quota into
basis points with "quota->esz_bp = quota->sz * 10000", both unsigned long,
and damos_set_effective_quota() divides the result back by 10000.
quotas/bytes is unbounded; bytes_store() hands it to kstrtoul() as is.

On 32-bit the product wraps for any size quota above ULONG_MAX / 10000,
that is 429496 bytes.  Documentation/admin-guide/mm/damon/usage.rst
instructs "echo $((1024*1024*1024)) > quotas/bytes", and 1 GiB * 10000 is
2500 * 2^32, so that documented value wraps to exactly zero; 256 MiB and
every multiple of it do the same.  quota->esz then becomes zero while the
goal is not achieved, the trailing "if (quota->sz && quota->sz < esz)" can
only lower esz further, and damos_quota_is_full() is true on the first test
of every charge window, so the scheme applies nothing and the goal is never
approached.  Other sizes are wrong without being zero: 500000 yields 70503.

Saturate to ULONG_MAX, which is what the same function already writes for a
scheme with no size quota.  Widening esz_bp instead would reach the consist
tuner, which runs the same field through damon_feed_loop_next_input(),
unsigned long in and out; bounding the multiply keeps the change to this
branch.  On 32-bit a large size quota then behaves like no size quota
rather than like a dead scheme.

Fixes: af738a6a00c1 ("mm/damon/core: introduce DAMOS_QUOTA_GOAL_TUNER_TEMPORAL")
Cc: <stable@vger.kernel.org> # 7.1.x
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
---
Measured on i386 under QEMU: one paddr context with a stat scheme, the
temporal goal tuner, and one unachieved user_input goal.  Each size is
written to quotas/bytes, the kdamond is started, and
quotas/effective_bytes is read back after
update_schemes_effective_quotas.

  quotas/bytes    effective_bytes    effective_bytes
                  before             after
  4096            4096               4096
  429496          429496             429496
  429497          0                  429496
  268435456       0                  429496
  1073741824      0                  429496
  500000          70503              429496
  4294967295      429495             429496
  0               429496             429496

Everything the conversion can hold is unchanged, and 429496 is what the
no-size-quota row already produced before the patch.

Patch 2 pins the same boundary at ULONG_MAX / 10000 and so runs on any
word size.  Without this patch it fails on x86_64:

  # damos_test_esz_goal_temporal: EXPECTATION FAILED at mm/damon/tests/core-kunit.h:1959
  Expected s.quota.esz == max_sz, but
      s.quota.esz == 0 (0x0)
      max_sz == 1844674407370955 (0x68db8bac710cb)

 mm/damon/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 2258b72da7a7..5ec476cef4db 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3274,10 +3274,10 @@ static void damos_goal_tune_esz_bp_temporal(struct damon_ctx *c,
 
 	if (score >= 10000)
 		quota->esz_bp = 0;
-	else if (quota->sz)
-		quota->esz_bp = quota->sz * 10000;
-	else
+	else if (!quota->sz || quota->sz > ULONG_MAX / 10000)
 		quota->esz_bp = ULONG_MAX;
+	else
+		quota->esz_bp = quota->sz * 10000;
 }
 
 /*
-- 
2.53.0

