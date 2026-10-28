Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793202201;
	b=XL/69ZVPRNsMnvtfq5SZyrHlfjOjeF/UzNQSFjuYev1UAkGo4WpQ8vT+B08RkdvQGjN3
	 BiTzvCzvSo83JdHoWHeLxAgoQ0aXl22LEt8tQXIa7C9QvbTVhULP/bC5NJcb/M0YDU0S1
	 P0RgzHVljcPt7TCiBlffemi5Y7ARYqvKs2WfGrCaRxdXorV/xCQFkfYar1G4CrPirQFAo
	 /KK8j6BOZJkoNHtPjKo9bwjvUXkm4PWR8inP0uXBjJ1NFR72ffLzQA6bkmkhUZ0BCwVZU
	 vLySuPmZFTNr1pU1vSrcoe7tezZOiGpO59xCyqdzaPw3o7zvBix2dB7/1zJyWb2qBdA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793202201;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=dVyo0oflSI5I95og9CttAPWdFzUAxu6w0ea9EU03XNI=;
	b=b+V9slAkVuiKdI/E1vJVplxHAv4nZO7Uv3dMbC4OsRHJcizU+G6jnDlU5DDQYlO+OJQ/
	 u8z0HJR5SXQM16Jk8d7YVvsoFaqsD+dM/FGt+YhfTAerSIw+rEPwLRHOpslfvmb8/C4bn
	 0I0DUtTme/MFMKeXSObFfMniNlMksFl+f9VNBAwricPpyODl4+wac3niLU7UlECOjaXFJ
	 crFZvaKgsHwgSmtePdBZ5TRvb0QjALiUlnGtG+LCwbSLm6cXTDS64aNMh8iDSShPIgUK0
	 /zfzU7mdPoiOSLwMDAT6zChApctV+DyCG8aanugiKpAZWMjaGz5G4k1t0ZNDUiGUprw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kYzroclk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A356606A31C;
	Wed, 28 Oct 2026 15:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kYzroclk
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793202200;
	b=OFHRwNeGbmaivyCowhc1zEB0TrVQxWAZWXyeuJy/QttxPPT+R0KbnduHoggrxHuUf/J0
	 NW3aCNEDUBlL7wQzSs2XX9sl+fs4WJRbW6D6bhjzZUtMk7ejDkkN2uEoGmXPaMKwTln/+
	 yVrDBvmu2XOcvVh7lX6Mq8FcK7sjwKV/mvYoeQfrC2S8kdWfpza5tyXPs+wGFF+AJouBg
	 iHYvqw+A6NP1zHQ4F1atSEdDP6f581JM9Ht0k1SKb1dk4KA9FFy8lQUVGCVQJHOCakdaw
	 mrHfais5uPFXDufx7jeRaMRUfTEZvR5BkGNqGOJupUBEXK3tpKgsw+USJ338BfM8WOg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793202200;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=dVyo0oflSI5I95og9CttAPWdFzUAxu6w0ea9EU03XNI=;
	b=hmhqHaPMm0SUBtJvzFHhf+fvsUn/+RBcDXJvi+NBOxChRlsPP1XP9pAIi5evsCcBiH+x
	 Tugqjo8mFbCztzTz3csjc0nue3cEu+RSZ++6u7KCMzN8kH2RkLlbSH8eqlnlM1Vci+sAd
	 VDnc+CPMiSULSe5SFLGKkoFjJGMMZqCGPkY4p6Tv7sA8lpEvOzlVosB/KUEipulapAHjt
	 BYo/N1mTBBiFHu9XmDgrnbmTbzaMVidtPhQLZCsKGH0NncZZKo69jzbLYH6B29JHtrpBc
	 8wkOS1gAl4U4CCAAXZi6uG/e8L7/ND27ZVfy9SfBSs3Os7KbCOggjW53hEBhwE8dsgQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 14A251F01825;
	Wed, 28 Oct 2026 15:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793202200;
	bh=dVyo0oflSI5I95og9CttAPWdFzUAxu6w0ea9EU03XNI=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=kYzroclkeaKBXDQnM6MGPDG4l8EW82mBn6Sd+DgR9flAtdFtYTjEZ2YCcuySkS8je
	 4J+UzLa79/K0PGrWumITzGM3ROPWdqoQekJ0SgBT80GqnrpffHTBaEUHc4R+G62XyB
	 VS4YSlfKAT1w+tqNSEdoIF8xyFJ7yDaPSIeistUGBOGD7PM9I4BIBt8k4ZCB6p0WUR
	 vN0gVDGypOorEJ5k5Jngq/SoFGsBrkf/UO9KOxlJc48ZiOmODgim+xVGyr5eM5Uee3
	 uFBKkW5jrUt2JI6CtcTH+vafthJC9jwuIHsGYA6Evb+eN1lVp8JSoWnZI6uLWzCLcU
	 bHweSbZ/ZNRww==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 6C11F454DD;
	Wed, 28 Oct 2026 15:43:19 +0000 (UTC)
From: Mani Tofigh via B4 Relay <devnull+mt4022.columbia.edu@kernel.org>
Date: Wed, 28 Oct 2026 11:43:19 -0400
Subject: [PATCH] mm/hugetlb: clear the hugetlb flag before leaking a
 hwpoisoned folio
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261028-hugetlb-hwpoison-leak-v1-1-77ce56002523@columbia.edu>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQqDMBBA4avIrDtgfhDpVUoXRkczKolktC2Id
 2/U5bd4bwehxCTwLHZI9GHhGDLUo4DWN2Eg5C4bdKkrVeoa/TbQOjv03yWyxIAzNRO6ujPWmkp
 ZZSC3S6Kef9f39b4tmxupXc8ZHMcfructq3kAAAA=
X-Change-ID: 20261028-hugetlb-hwpoison-leak-b8d344361413
To: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
 David Hildenbrand <david@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: Naoya Horiguchi <nao.horiguchi@gmail.com>, 
 Matthew Wilcox <willy@infradead.org>, Jane Chu <jane.chu@oracle.com>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, tz2294@columbia.edu, 
 stable@vger.kernel.org, Mani Tofigh <mt4022@columbia.edu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793202199; l=3284;
 i=mt4022@columbia.edu; s=20261026; h=from:subject:message-id;
 bh=cR+00jv6nY1jeTNTofLkwvXHeYkHwgr3Q37wQeBJJMc=;
 b=7irmncB/MpzPKA+QIZm3X8VvaXcSQlPwA5I1tfMDuVathOhu4bTIGXc1RMBaZ0+e8m0O4VpxI
 n/xTBuSAbwMD8aRZrhG/rRQ2efGKNk1aNOuGkEjCtXgDCpu0FheUsHv
X-Developer-Key: i=mt4022@columbia.edu; a=ed25519;
 pk=gljCMQDuxyKPmd5y37CRpEJGSPXDV1MyAnHBhCgXl0I=
X-Endpoint-Received: by B4 Relay for mt4022@columbia.edu/20261026 with
 auth_id=1322
X-Original-From: Mani Tofigh <mt4022@columbia.edu>
Reply-To: mt4022@columbia.edu
Content-Transfer-Encoding: 7bit

From: Mani Tofigh <mt4022@columbia.edu>

If hugetlb_update_hwpoison() fails to allocate a raw_hwp_page, the folio
is marked raw_hwp_unreliable and __update_and_free_hugetlb_folio() leaks
it intentionally.  With hugetlb_free_vmemmap=on, it's leaked before the
hugetlb flag is cleared, since commit 32c877191e02 ("hugetlb: do not
clear hugetlb dtor until allocating vmemmap") doesn't remove the flag
until the vmemmap is restored.  The leaked folio is then a hugetlb folio
with refcount 0 and on no list (the same state as a hugetlb folio that
is being freed), but nothing is freeing it, and
dissolve_free_hugetlb_folio() keeps retrying on it.  Offlining its
memory block then never completes:

  [    3.271255] Memory failure: 0x20007: recovery action for free huge page: Failed
  [   41.729695] INFO: task hugeoffline:77 blocked for more than 20 seconds.
  ...
  [   41.733014]  get_online_mems+0xc1/0xd0
  [   41.733026]  soft_offline_page+0xfd/0x9b0

alloc_and_dissolve_hugetlb_folio() loops on it the same way.

Check raw_hwp_unreliable after the hugetlb flag is cleared so that the
folio is leaked as a non-hugetlb folio, as without vmemmap
optimization.  With the fix, no task hangs.

This bug was identified and confirmed with the help of fault-injection
testing on a deterministic hypervisor currently under development.  The
C reproducer below however chains the specific events that trigger it.

Fixes: 32c877191e02 ("hugetlb: do not clear hugetlb dtor until allocating vmemmap")
Cc: stable@vger.kernel.org
Signed-off-by: Mani Tofigh <mt4022@columbia.edu>
---
This changes the same lines as patch 07/15 of Matthew's "Use
generic_file_read_iter() in hugetlbfs" series [1].  On top of that
series, the check goes right after the folio_clear_hugetlb() call.

[1] https://lore.kernel.org/all/20260805210557.1118966-8-willy@infradead.org/

Reproducer: https://github.com/manitofigh/files/blob/main/linux-repros/hugeoffline.c
---
 mm/hugetlb.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 4a008afaedf9..4d6b7ab49502 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1472,13 +1472,6 @@ static void __update_and_free_hugetlb_folio(struct hstate *h,
 		return;
 	}
 
-	/*
-	 * If we don't know which subpages are hwpoisoned, we can't free
-	 * the hugepage, so it's leaked intentionally.
-	 */
-	if (folio_test_hugetlb_raw_hwp_unreliable(folio))
-		return;
-
 	/*
 	 * If folio is not vmemmap optimized (!clear_flag), then the folio
 	 * is no longer identified as a hugetlb page.  hugetlb_vmemmap_restore_folio
@@ -1506,6 +1499,14 @@ static void __update_and_free_hugetlb_folio(struct hstate *h,
 		spin_unlock_irq(&hugetlb_lock);
 	}
 
+	/*
+	 * If we don't know which subpages are hwpoisoned, we can't free
+	 * the hugepage, so it's leaked intentionally, but only once it is
+	 * no longer a hugetlb folio.
+	 */
+	if (folio_test_hugetlb_raw_hwp_unreliable(folio))
+		return;
+
 	/*
 	 * Move PageHWPoison flag from head page to the raw error pages,
 	 * which makes any healthy subpages reusable.

---
base-commit: bae9a042b03b27924c6fd5bdc00a20d6a44d6041
change-id: 20261028-hugetlb-hwpoison-leak-b8d344361413

Best regards,
--  
Mani Tofigh <mt4022@columbia.edu>


