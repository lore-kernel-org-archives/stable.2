Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794420598;
	b=DmN5Tmd5p32QmuVPMbHh5dZuWZ0cI8gOE+/nzlsHkdyV4EYgEpoesXMt5pGVxshOnM/u
	 v2CsmrVv4Rs+pZ6dPm0GXLYp+mJLgRxulky5NPM8gGXGByWHFbwtYYpRimmo8DUHuj9lG
	 rCFACjZe+Z9w3Z8YzYcM8bYeCblu7WLAzKngHBnp6FGwELIuV98/npgMMjA6IAR0jd09P
	 HTWQxPKJccUH7T6qmq1+iYzRnRXciWXmd54P5CsZaztEGcts1YVcz+V5uvN49MMTyLdlu
	 SW4LyqumRMGiFpVWYyny27n7pOR6C+xURHlqmgCdUX4hqZzf8jc11zbiPpjmCkWRXKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794420598;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=9hcKBQFPuAqASTqC3Fw4gD1OJfDiL/X6ciPjQaqOOAo=;
	b=SHjxXwUyjN47HVCE6Wz642vCMhZeSmMbsnTs+R+f5QXeS0p+WALuVlpGEw26PqrWpFfD
	 SfK3drk8dkHRPqWrFSzU2H8A//J6Y3yk4g/c1fFxK/ANvdebMIPfvor50J5gLsQhxcOVR
	 nES6AUNWFcv7dJAaxc16WEOew1eLbLItYZ6/1SSlqbrXMYLh5nUX3LEKDKcyxg2t2MKvo
	 4VUxJ5+kLJzcZi4FUmUyB9fjuyoH6T4Ty1yzSxHR6IfpolJfUTyNNQdbR8Wa8P3YTzqAg
	 mhc6dO7RnYkBCa+8gs1TvpB+2Y0rgKkcetCcT2oPAvnA62LStDb7pY0EwrdyYeZpJMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="SDW/ZLpG";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFEE606A8AF
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 18:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SDW/ZLpG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B971A1F00A05;
	Wed, 11 Nov 2026 18:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794420598;
	bh=9hcKBQFPuAqASTqC3Fw4gD1OJfDiL/X6ciPjQaqOOAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SDW/ZLpGWBaiE43bb9jpJrTbH4Y8wVV2ML/2nK5dkT17TmfhFKgRuUJubb4hXVpA7
	 WXHPtbqgco7/LUNBqJ3w7ewZr6SpQp1vEwzGJU2uVSAmDtkcrWA0lby7vXfnQCVxwf
	 REaXprN1QVbq44EU5Ic2OlT05YCAnFUPqfS0xTjvBJXmEvTSSEuQOj06S0C3E8yOrw
	 JoSZdMHRC8oQX/1CSJ2qgaviIMrc2tL1fn1GIeOCkxOeHmafJGIdNyCwJidSK3aXw9
	 EbBFfxKCsOMp7YwmJtnRWzqk9oaxDiDcM9kOcO5R+IeQ48shPMXYdukhTtYN+bq7By
	 ccRq8uoCgZ2BA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] mm/gup: check for overflow when converting nr_pages to bytes in GUP-fast
Date: Wed, 11 Nov 2026 13:09:56 -0500
Message-ID: <20261111180939.3807352-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202803-failed-5.10-21a3888d3d2f@kernel.org>
References: <20261109202803-failed-5.10-21a3888d3d2f@kernel.org>
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

From: "David Hildenbrand (Arm)" <david@kernel.org>

[ Upstream commit 21a3888d3d2f87b7f15ccea1f0befd57346fe899 ]

The overflow check in gup_fast_fallback() only covers the addition to
start. The preceding nr_pages << PAGE_SHIFT can already have truncated
the length on 32bit.

Users such as RapidIO's rio_dma_transfer() can derive such page counts
from a 64-bit userspace length.

Let's just check_shl_overflow() to reject any such overflow with
-EOVERFLOW early.

Fixes: c28b1fc70390 ("mm/gup: reorganize internal_get_user_pages_fast()")
Cc: stable@vger.kernel.org
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Acked-by: Muchun Song <muchun.song@linux.dev>
Reviewed-by: Barry Song <baohua@kernel.org>
Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
Link: https://patch.msgid.link/20261031-fixes_core-v3-22-d6437171ecc3@kernel.org
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
[ sashal: adapted the check to internal_get_user_pages_fast(), changing its existing overflow return from 0 to -EOVERFLOW ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/gup.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index e1fe283badf3b..f9316a91df521 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2753,9 +2753,9 @@ static int internal_get_user_pages_fast(unsigned long start,
 		might_lock_read(&current->mm->mmap_lock);
 
 	start = untagged_addr(start) & PAGE_MASK;
-	len = nr_pages << PAGE_SHIFT;
-	if (check_add_overflow(start, len, &end))
-		return 0;
+	if (check_shl_overflow(nr_pages, PAGE_SHIFT, &len) ||
+	    check_add_overflow(start, len, &end))
+		return -EOVERFLOW;
 	if (unlikely(!access_ok((void __user *)start, len)))
 		return -EFAULT;
 
-- 
2.53.0

