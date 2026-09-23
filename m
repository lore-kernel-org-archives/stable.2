Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE512E736D
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 00:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790123170; cv=none; b=JUbD/8hyIZ92xMnrUkXE4rOMC4iusdT1j/3wP2NBKN5+ICJeoweJf+UILwsCoFm1BSv76qoKMn9BcRYYFeLiBwfNVztd0DQ5zJFW4PYhv4esJsP1PwCf//jgGF8hzBpU8DTTy/iwOfsBrMfSreZwftgZ+exAij6tbEQ5+AQ8qmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790123170; c=relaxed/simple;
	bh=VmXTMa/Bup21S8yFkEfL/80LZh3xNrLztMxxvOe2+R8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J3pJ67hCkbe7cK1OGWLbq7XNeBTdeVpfb9KxEbbVfLetVT4JGjTUpZYPPL4Il25ihIpesEc1FUqUbrL7Q3v1LIajQ40nT9VFBkKfBQJo7nwiieYxcSpv4Oq4G1j88UJluDexVnD0OrZiA3UqnMOZBcAKS6KiiTyiVCOpS+5Bh44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y8u35ch2; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8u35ch2"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2db1ca069c8so1872325ad.3
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 17:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790123168; x=1790727968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EuB5HZ83DEiTy12L1l/fqfuPkHFmU6lDMt8lQEtLu4c=;
        b=Y8u35ch2se5OWcIVWju5xiBVVmEAujR3KsdSWkcw3VEHDoBO/cZqbiBWFkFkGcOhl/
         RgtrnDObeuQDYsjzQkRHur7Q/eSa8qjM2Nu5mBpTf+R1SCzhNgv7qeRR8+dPDpeMmbjW
         P0hSUKAZcMsTWST5qHTfIdV/oIhcLNhC8depf5b47aemhSYS/FGKYHnEiZbylzHWvNry
         zzWU5Jnia6tRC84kdhBUDZUNg1ocqRRq26eZnXgF5W3pCHThyG8n0GOKY0aEIWX8JhQT
         7no3/uDQ9SzvdWqct8DhY+TH7Ll7tMgXTxR3cHxlMHpFBeDGZe5Kw11SxCPEVIIvN7HW
         Q+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790123168; x=1790727968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EuB5HZ83DEiTy12L1l/fqfuPkHFmU6lDMt8lQEtLu4c=;
        b=vPwZeV2+ORySXmrJ5mASGFs34thJKFuMck4pIJFjvoXkiG6Bz6W13y9sA2LTMI9hm+
         DVT1i+bYc48TK75HnX1eQj4i8Scn7PZcQOd7Pgo3LqVw4k1dcJ7JcjSdrlo7o6zulfQR
         9B0tujrxTby0ITlBrYH9tYAbinziWwAGodXt9IDxskI//Fk7F/PXaFqZlk1Cd2xR+yGS
         AHodIrtTsvBOSeuLy/NxkLZNlL+4S8IATD2jJClV8OI4ePI5uwek/tBvoXFQfRsm30Un
         uhrbxKgl2dma/7RWYSJRBVHlwebAbC+FwoIRN07wqBzqD7+K4W7B6RKhc/lTjoQvf/EO
         GZTA==
X-Forwarded-Encrypted: i=1; AKwUvBwJbv1adFKo8TKMNU7Y10sesNJP2rdJpH8rsyd/noTL+QtukGjOONpxKfvtwaBpWE6PmmUHTkI=@vger.kernel.org
X-Gm-Message-State: AFuF++mF9OlGs2wJ1EyJbHCYodeCL/9UJvj46LsOm9cMUjD4Eff+Xk0K
	TijPs8T3hSnPgrfCnd77c7v8cX9DVRqt2n45HjPlVGM4ioIC69oRXyw=
X-Gm-Gg: AYBFou1UVperr8GWEq82Uzx1RdN/aEPbces6UfDdC/lKtQ9zGZoYlAmjCHGyj7iApR6
	BIz5GI0gJc0/6sZcZFw8PV0QtrfuJKDBsDHNAMumUd6Uqq41HMKddshT8OIwegB4rNJUntGuJmr
	7HTFdRKrxlf3qt0rn4rcU1Jk1Q7pvFDt0mKyu//8gvzQLWnXr7FY35KdchES1YxCO9IFkWRZ5PG
	Ebi5asVDrtuk9Pl2bU+O95/yX/MecoQPNoYyycXiXDMkF8v+8FD0doT3g7tPHZSKD4iOT+VTrhe
	dM/HXXjbC4Cz5kcL5/5YFi7QYrgW4uOBpDCxt9Z9CFj1IjyWXChSTpuggJ+0unAeEGTCbLlgmcH
	2NrgTPj5sZw7umBsaWJLX2iZSnSExbURK8jEaA6XbLKE4bXgKwx1yOmIJo3w3m2M3QWG13PSjwb
	gqt8qkNOxbG8aILgKtm5JU4ISh+Fk910WmucwQzo4Sxf3/NSz5m3LZvFHMhOY2gjr5Hz7P1t2j+
	9VY+reMbO4U/vNxqqxltVg7e14=
X-Received: by 2002:a17:903:950:b0:2dd:c053:c20d with SMTP id d9443c01a7336-2df69e00ec3mr7931245ad.41.1790123168457;
        Tue, 22 Sep 2026 17:26:08 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:7f00:8c85:2466:805a:e198:cde8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a5a7b76sm2176595ad.20.2026.09.22.17.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 17:26:08 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	donggeunyoo.kernel@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v4 1/2] mm/damon/core: prevent size quota overflow in the temporal goal tuner
Date: Wed, 23 Sep 2026 09:25:58 +0900
Message-ID: <20260923002600.1825448-2-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923002600.1825448-1-donggeunyoo.kernel@gmail.com>
References: <20260923002600.1825448-1-donggeunyoo.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damos_goal_tune_esz_bp_temporal() converts the scheme's size quota
into basis points with "quota->esz_bp = quota->sz * 10000", both
unsigned long, and damos_set_effective_quota() divides the result
back by 10000.  quotas/bytes is unbounded; bytes_store() hands it to
kstrtoul() as is.

On 32-bit the product wraps for any size quota above ULONG_MAX /
10000, that is 429496 bytes.  A wrapped product below 10000 divides
to a zero effective quota: 429497 gives 0.  damos_quota_is_full() is
then true on the first test of every charge window.  Other wrapped
values are wrong without being zero: 500000 gives 70503.

Triggering this needs a scheme with a quota goal, the temporal goal
tuner, and a size quota above ULONG_MAX / 10000 -- 429496 bytes on
32-bit, 1844674407370955 on 64-bit.  The scheme then makes no
progress for as long as the goal is unachieved, which is easy to
notice, and writing a smaller size quota restores it.  Nothing is
corrupted and nothing leaks.  This is unlikely to be hit on a tested
setup.

addr_unit does not cover this.  It only scales the numbers a paddr
context writes to quotas/bytes, so a large enough scaled value wraps
just the same, and vaddr and fvaddr contexts take raw byte values.

Bound the multiply.

Fixes: af738a6a00c1 ("mm/damon/core: introduce DAMOS_QUOTA_GOAL_TUNER_TEMPORAL")
Cc: <stable@vger.kernel.org> # 7.1.x
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
---
Measured on i386 under QEMU: one paddr context with a stat scheme, the
temporal goal tuner, and one unachieved user_input goal.  Each size is
written to quotas/bytes and quotas/effective_bytes is read back after
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

 mm/damon/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 4687b909d42c9..4716693ec0dc5 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3275,7 +3275,7 @@ static void damos_goal_tune_esz_bp_temporal(struct damon_ctx *c,
 
 	if (score >= 10000)
 		quota->esz_bp = 0;
-	else if (quota->sz)
+	else if (quota->sz && quota->sz <= ULONG_MAX / 10000)
 		quota->esz_bp = quota->sz * 10000;
 	else
 		quota->esz_bp = ULONG_MAX;
-- 
2.53.0

