Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794420461;
	b=Hby2BxmT0XmEBZXHKlSVEQqkDrHcWGvKeKx5XxjkhSA3CqjItACV77PYW/P298LIiMTp
	 0B3iKmzYEXhmJkq5wERs48WvOsUqCH0Hn44EpNL3URk2qSa8Nj8fAKkK0m2MEeRx84t1c
	 0BkLCA9bF34fBur/kCTzbjFztmlVsWUrVeArzYrWBQy8LrVnXoBUIRZxNCk3aYRoXwEVL
	 oTrSCs7IZOYIrozBkhI0V7XscjscFpj/3jgPUigX1xf+NkehPnwo7Jw3s0DfikXpOO2mL
	 v4SmKiGaV1gdaw0fF2KLHThhl+nstgdqi+dP5csu77ATm/mgGXKNHFdjdvEGZw4zeQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794420461;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=iH7UIFJWwvypaMy+GXRP/4wZw3cLkwFSs9X84tpBwFc=;
	b=bHMbkhcLrLatSxKlkQqH7vbAVHldpHTMPK/g4OmRiVNh7OkGauk7/9mOx3DQv2/wEkue
	 bC8Gt6Bk7mAMH69QH/jcpeuC+oeXK9bLTIP9Esq4lp+gSto7RwBlzDAuRryCTmgQ4aBeo
	 /VrOUSzw+F8i4h8G67oiaA0G04869vRBoOII7qOzccPgObyT+fkqVPe2T90b1mvcFEwld
	 fhRXlm1ZAhHFFRPNtLMfPSZWSd5sQL1TMXwDdlGGjZxVTvlsytumSEAASJan751lwRU+M
	 Kwr+WFpIh2nvtAZM/FUAJMnNzeeKIy+xghmURseuIQnLqHRoGu4S2asTxzaiQVyGgdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ru21tbuQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71027606A32A
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 18:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ru21tbuQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CC591F00A05;
	Wed, 11 Nov 2026 18:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794420461;
	bh=iH7UIFJWwvypaMy+GXRP/4wZw3cLkwFSs9X84tpBwFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ru21tbuQJrNASRZCyBPM7XMYuQPNy9hJHfM6sT5zWHtnHa+ytyrII/c7Gy+zLepxb
	 8p+3hCBQc587qJEVzSCOAKW5xdndrCTskejHCfl0YQWi4C9bID6UvVDrmjp+IEhI3I
	 EgsF49G0JAoUiCFGYe+dhCcY6bFbWPuYoBEkk0aAEwx8zvn4Q08Lju6JV9/HGwJcrI
	 qPvp2uu0Fda5ym7D+VNDo0wMC7mkCu4pK1X6XLvJKRUDS7IH6qqFm2Czyz7zZTkXCi
	 cqLtJUQynIoAiMTGmGuLNHdvVSYKMZAGtljOhxW/RnaqvX9U1D+T0CC5WMFVty6VAf
	 U1nHpD7SD9LmQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] mm/gup: check for overflow when converting nr_pages to bytes in GUP-fast
Date: Wed, 11 Nov 2026 13:07:39 -0500
Message-ID: <20261111180719.3764092-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202323-failed-5.15-21a3888d3d2f@kernel.org>
References: <20261109202323-failed-5.15-21a3888d3d2f@kernel.org>
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
[ sashal: adapted the overflow check to internal_get_user_pages_fast(), changing its existing failure return from 0 to -EOVERFLOW ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/gup.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index c1508281c2f93..3f828fb456e2c 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2898,9 +2898,9 @@ static int internal_get_user_pages_fast(unsigned long start,
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

