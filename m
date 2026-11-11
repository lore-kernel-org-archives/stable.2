Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794420279;
	b=G7lVJHjrFn3nx+XOfIk23AHAkv1Zjki9t4TXkCnyXbNwAFqG36FOrbYmanTQZtjmHaBq
	 23ErUOlHHCnyzzlTKaKMHqO6Bu7AlEjNKrhCP5xh67LsX+U+am8l7qmpcBMXNrg1eeCB1
	 /ZryOyBNjuhqPMJwpBEn5X0MO3b0OTyFbWhjy6dkbpyFuCyvWXL3FE/OUrVjMt1y9HUBL
	 JnaMqMe+/2nk09R0c3CFEB77dTBAXjdrnLUij74880+71F10cwcMOYNL9yXw4S7FSb3MK
	 z+TyMDydtmURlC4WrOGkAaOe4ZKMs6RI82dqD/419qGl4rrQGZqBiBHv/KiFuwDXa2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794420279;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=8flrmTNlp7L2C3bdjz0v5JpZBMdtc8AegGYpyk6AJX8=;
	b=cdioLvOQSFLogE0FZnvyuUrwErVXD4GCtGLTGA41T39mW+sA1Za0hYBs68vO4DOj3YJc
	 QznrC6tuk0Ym6v3Wk1ribtm71yZTQKFgxiJXD7HyujoivOlVfMeill66yDqek4d52Yfq8
	 SlS1MCNl8FvTYk7rEase8ZE2xf/BEmg06hFK+BOB3JWk5V2yom+vSm7I2A5zu4iRwG8pU
	 qjnE5al5EEtyh4O9eMPfp9aiRpGwRgadBbZa0gBgDByrk2QdoLhi8qpJxnSXqZXc0/GnR
	 DeXcEbjzByubjZXmgH0KPrUfxhK0fwPyBq66XX3dLYAA/DjL3krx0giW7pVe/INtVUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kqu6hEX1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9345A606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 18:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kqu6hEX1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F3911F00A0A;
	Wed, 11 Nov 2026 18:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794420279;
	bh=8flrmTNlp7L2C3bdjz0v5JpZBMdtc8AegGYpyk6AJX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Kqu6hEX1A3LqjIjZRWNVSeaNy31vWAzZdp6phyB/VSIweWJQieuviN8CoruBwv2l2
	 bFqRdF2xHYyf3ETrIRiZiiovq67rnzLABtCQHAMo2ic1f286TyvpZgR6mgRoYX7o2b
	 67y5eu/TbNSVSm7OyXOvQYcCUhsVwW1fy+VELrt0gZuz57u23lHEDb2WVirMP96ghY
	 znoj3vRsnyFxh+pPlpy9YpzZ9z3GLNt+XfyLoeOheO4jthK8NJw5Jqq8cxrlO/tCY+
	 PG5hPYFOTYn6SLHPsDnM55Hl6BAJCYozkZ/PwQzc2tykZes157eCVxKJu4102stCZb
	 96CXvkZ3Uhd1Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] mm/gup: check for overflow when converting nr_pages to bytes in GUP-fast
Date: Wed, 11 Nov 2026 13:04:37 -0500
Message-ID: <20261111180419.3728532-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201826-failed-6.1-21a3888d3d2f@kernel.org>
References: <20261109201826-failed-6.1-21a3888d3d2f@kernel.org>
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
[ sashal: adapted gup_fast_fallback() changes to internal_get_user_pages_fast() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/gup.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index b3b6de2c37c12..8629b2e145460 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -3065,9 +3065,9 @@ static int internal_get_user_pages_fast(unsigned long start,
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

