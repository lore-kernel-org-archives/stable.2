Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127BE1F5825
	for <stable@vger.kernel.org>; Sun, 11 Oct 2026 00:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791678666; cv=none; b=FeIOymd2TMuw+TxAm9+1ONQesezb1CdOpNa6EbHrSAD2nta3jnS/XiSbPQWyvB2wctEJj9b0Xj9x7PuibKVPizDPK2GAWP4hBhJNR/3x/YONt3AGEi6bYAA/KrOqEA77ZV2Nm3E8EGj/+Joo5CtbIpM5uS35cPPhPi1FnF+dqYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791678666; c=relaxed/simple;
	bh=livfjoHBpMZ2I9rsAu760FCHWhyj23URGY3nYYzdO9M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n0WPWtCKt5e+HhI9SuX3sFMO6UKNgu9ngTWXIjSO3veQ+rUz3MFr7LrlRIaekUVHLdInw5lEJdVh3ajDx1h/fSzn+P9LYaYngj/qcjfLZZO3iUxU3A2YK/xvbSQ7t8EWMtWcaVN9xjfqMDGZh6l4q7THPNNSpmtc5neRBP8ZYLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dVqMegzb; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dVqMegzb"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e812e2b31bso3889895ad.3
        for <stable@vger.kernel.org>; Sat, 10 Oct 2026 17:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791678664; x=1792283464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ip1A6CngHiq2WamXxahtB2LL7CsCqEsAKWuGP1PVcRQ=;
        b=dVqMegzb71m2ZHEdx9DdTvTnF8bMpqNB9DgLxXTgw6QxTj/cm4ymwj+NYNcWl60oUw
         pWwFtyMQVSe31L02ikJxr7l9iJ9rbzbWmR/SgLCLOnkjyu3EZJiwEGpZSUpwOA5r0kUc
         NecbgXmj+aknTNhyu53U70zqPkMEJBBsImz74KbLAvImbaYqme9sHBKPcqGMBlovItNr
         v4Mwy740mCCpDX3EtxoBpgiL7h38mS908cJPY8q/4GqzStONrwBveLzXGYEqBRcgUn2w
         9k1KJHcM8McG9dKgZLxYoMYjLd5EFFTMC9WDvKQLcUSNdxEaOfN6GaqLVXk2HEispthJ
         Qejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791678664; x=1792283464;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ip1A6CngHiq2WamXxahtB2LL7CsCqEsAKWuGP1PVcRQ=;
        b=itHSi9/Vt0eVBrSU/bHDnLS1bbdyyDluz//hHI00xynY1YqKTSSfXEVqfaL7ZXQmhb
         FI519WnV6dM4BvoDbWFErqL2ertH4LeCPKrkmKKrPFt6sBaqLvumxVVZo+B4mQqLCssR
         9cykMydd+j3BRvS3LuOeMWF9Tug6OB0ODqPpozcJzkx3EbBWKysb0Wr2HOd7wXr4KTcf
         o3X4ODj17THaXQw6vkuZQVCTRv8X0MSyd3rn+22RAO5jgtAH8QU2Q2an+yexHza4Bg9V
         AkOC4b7zLrAPL3j9RCzJHxhM1HTqUidBTKZ7XQkFW20CTJr7M06n6HqdAcBbC4AC43VL
         y6Iw==
X-Forwarded-Encrypted: i=1; AKwUvBz99gNOcQC07Ldr2h/KdJ7PQGgBE41AJQ+yqcWVKNg2DW9HLtJlkhLZfFBnLp3LFJQwiCP2XUo=@vger.kernel.org
X-Gm-Message-State: AFq9FYKKpJpXCBNQGedNPkSLIsFKyfmfRbYgbMM+y3StaWjoSuJJK0LF
	a4pYqsoyxFEfscCMYbvn9d1zf99OQyUUg+E6qY5J77XcIGXGZaiK7ISeKWM1zA==
X-Gm-Gg: AYBFou0VnUWi9EDIHGS8R3+EnmkusYsF9oHLl00Wt04umNbHY8vWrU70F2C7klZCcSe
	vswENGQzgJNJNKSHH0NSXWVoybVEBLshX2QmSVz12Ws5RUV+xBmn9JlOuVWvgJl8sDbSfeAYAsw
	Uvb78P2nFu0GilcM5s0oBel2fmsudpdAVYAfefgZr4b6udIkeIvWLYxHuaSBhv/NS/O7Lu3HXhD
	QDGD8bqqfnYlm2YJKoco/a6N1EX61odgRRDYupAVL0SIiubijx3yPwJQ6xnD1Gp9nuxtB5uhXeK
	O/UgEz/Tf2plFFgeNuFJ1s9CuftYFi4NHQQAEyudyVTPurmLnJIoNvRtSZwnMEVXMqmCbSUthQT
	wGBZAdIrWRnu1Ht6/n2wtlGkLG+UM5h8DKrly/pvQw1F6EvllL9TgAQcgii8FphQ5D14FUufwrt
	edYgMV/b8uVe5MGRsxVLx+FISTdzHAHllG5/BzwFH6O15zcpffn7nAqApjkOdlN5a9nzxFHCdR2
	APpUE11IoZaTKX+e4ySXHLLiLR+GGhffbCxDxVw0XQOCZjmZ0nU7AgPf9sC8Nk=
X-Received: by 2002:a17:90b:4fcd:b0:3a1:8b70:d46b with SMTP id 98e67ed59e1d1-3ab3ad2b1damr4674660a91.42.1791678664191;
        Sat, 10 Oct 2026 17:31:04 -0700 (PDT)
Received: from bloom.localdomain ([2604:3d09:178e:e100::a891])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab371c32cesm9681761a91.16.2026.10.10.17.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 17:31:03 -0700 (PDT)
From: Ivy Lopez <skunkolee@gmail.com>
To: akpm@linux-foundation.org
Cc: david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	fvdl@google.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Ivy Lopez <skunkolee@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] mm/cma: fix list_insert_sorted() ordering
Date: Sat, 10 Oct 2026 18:30:58 -0600
Message-ID: <20261011003059.169430-1-skunkolee@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cma_declare_contiguous_multi() uses list_insert_sorted() to keep its
candidate ranges sorted by size, largest first (revsizecmp()), and by
base address, lowest first (basecmp()). Both comparators return true
when the first argument sorts before the second.

The helper stops at the first existing entry for which cmp(entry, new)
is true and inserts the new range before it, which is the reverse of
what is needed. If no entry matches, mlp is left pointing at the last
entry and the new range is inserted before it instead of being
appended. With revsizecmp(), inserting sizes 1 2 3 4 yields 2 3 4 1
and inserting 4 3 2 1 yields 1 2 3 4. The first range inserted always
stays at the tail.

The caller relies on list_last_entry() being the smallest recorded
range when deciding whether to skip or replace a candidate, and on
walking the list largest first when picking the final ranges. With the
list misordered, a candidate larger than some recorded ranges can be
skipped because it is smaller than the first range found, so the
function can fail or reserve less than requested where a valid layout
exists. For example, free ranges of 4G, 7 x 1G and 2G, in address
order, with a request of 12G: the 2G range is dropped instead of
replacing a 1G one.

Insert before the first entry the new range sorts before, and append
when there is none.

Found by code inspection and checked with a userspace copy of the
helper and the selection loop.

Fixes: c009da4258f9 ("mm, cma: support multiple contiguous ranges, if requested")
Cc: <stable@vger.kernel.org> # 6.15+
Signed-off-by: Ivy Lopez <skunkolee@gmail.com>
---
 mm/cma.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/mm/cma.c b/mm/cma.c
index a10ea37a261d..527b2d894f3e 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -348,16 +348,12 @@ static void __init list_insert_sorted(
 	struct list_head *mp;
 	struct cma_init_memrange *mlp;
 
-	if (list_empty(ranges))
-		list_add(&mrp->list, ranges);
-	else {
-		list_for_each(mp, ranges) {
-			mlp = list_entry(mp, struct cma_init_memrange, list);
-			if (cmp(mlp, mrp))
-				break;
-		}
-		__list_add(&mrp->list, mlp->list.prev, &mlp->list);
+	list_for_each(mp, ranges) {
+		mlp = list_entry(mp, struct cma_init_memrange, list);
+		if (cmp(mrp, mlp))
+			break;
 	}
+	list_add_tail(&mrp->list, mp);
 }
 
 static int __init cma_fixed_reserve(phys_addr_t base, phys_addr_t size)
-- 
2.56.0

