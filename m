Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181684B95AF
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 15:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789573758; cv=none; b=LNc8C2i7pC5VWrUf6aztdDeJMiXLzdqldr+c/8qtEJdTpRYisiNWhMzXWQPAX2rUAZJfkxfVmYLQIx3Er5GDrheOkpDs//BWDz0ZnPZX06DZWKkaSpWll8QN2IKsrD0BNlNHdlkivCMPK5HbzcTrTtTWRrlPmfA7tQbNex9EyxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789573758; c=relaxed/simple;
	bh=gUNRhP/LjJYTTnRIDExA76p50EHaP7c1Bcaaf2cygZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iCuARUY4IzDEP6+GJ5YYybZ/6C5obn0H3yej3OyD5Ts5HHZH03T6lqMUvsn8w5bmFSdJJ0Z8BliaBtcaZZv6Urz9/l6JBuI5v5fHc37o+pLt5ryMPMncdnVxPTyXmAqNRQ8+Wuzzk5cNhfSLyefarqGK81/HNxx0KWTJtQqcEEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iqMjnS8f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iqMjnS8f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F0C61F000FF;
	Wed, 16 Sep 2026 15:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789573756;
	bh=4m08QZhGs59KjJuTyMXfzIX08grqpg2YADuw7aq8tvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iqMjnS8fs3pfrS/MOgs/MMHM8dWYepwN8AFnHGzmfNsIV2r+yj9bKWxUucJXkqzFw
	 RPZq0Fgiw92jbWiEi/DWQdAcSsc2pawfLHQCn+NSiovRJZb/T4igI3iU8oQ3lF0SyQ
	 XUf1JbfWnPtgsJeDrGFM6ctxX3YA6GJyNk2hZiPGmhM7af9aeiKV0fCDO3V+u8ew9J
	 5gj3qbkJRvofLc/xrIWZCR9Sj5TQpSIMaavST0Ck837JASkE796ZpqyZgRiBAfo5d8
	 Ay5X/0QxSTY8ZpobatubOaUH7argUJ+ZrTZGIvXc27wqFFzD6leT37NX3korwNeFym
	 yrQltKIFQEJJw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Dave Hansen <dave.hansen@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/4] x86/mm/pat: Don't gate cpa_lock on debug_pagealloc_enabled()
Date: Wed, 16 Sep 2026 11:49:12 -0400
Message-ID: <20260916154914.4167599-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916154914.4167599-1-sashal@kernel.org>
References: <2026091605-rehire-self-1650@gregkh>
 <20260916154914.4167599-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

[ Upstream commit 5fce67641a3ed9a0782eaa228ddece526461a367 ]

The splitting and merging of kernel page table mappings between small and
large is protected by cpa_lock. The merging is relatively new but the
splitting is ancient.

The splitting has a locking optimization: since DEBUG_PAGEALLOC forces all
mappings to 4k, there are no large pages to split. So the code that *might*
cause a split can just skip the locking (and a few other things).

This is entertaining, but it adds complexity and makes for weird locking
rules. Plus it's all for a debugging feature which makes the kernel super
slow in the first place. Optimizing something which is already super slow
and not used in production is not the best way to spend our complexity
budget.

Stop gating cpa_lock on debug_pagealloc_enabled() to simplify the code
and the locking rules.

[ dhansen: flesh out changelog ]

Suggested-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://patch.msgid.link/20260715144519.934289-1-rppt@kernel.org
Link: https://lore.kernel.org/all/aab44f08-89f8-47fe-bee4-0ab6b25968c6@intel.com/
Stable-dep-of: 9e4a3ec3411b ("x86/mm/pat: Allocate split page tables as kernel page tables")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/mm/pat/set_memory.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 3621532fccb61..5dc322409888f 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -62,10 +62,9 @@ enum cpa_warn {
 static const int cpa_warn_level = CPA_PROTECT;
 
 /*
- * Serialize cpa() (for !DEBUG_PAGEALLOC which uses large identity mappings)
- * using cpa_lock. So that we don't allow any other cpu, with stale large tlb
- * entries change the page attribute in parallel to some other cpu
- * splitting a large page entry along with changing the attribute.
+ * Serialize cpa() using cpa_lock so that we don't allow any other cpu, with
+ * stale large tlb entries, to change the page attribute in parallel to some
+ * other cpu splitting a large page entry along with changing the attribute.
  */
 static DEFINE_SPINLOCK(cpa_lock);
 
@@ -1235,11 +1234,9 @@ static int split_large_page(struct cpa_data *cpa, pte_t *kpte,
 {
 	struct ptdesc *ptdesc;
 
-	if (!debug_pagealloc_enabled())
-		spin_unlock(&cpa_lock);
+	spin_unlock(&cpa_lock);
 	ptdesc = pagetable_alloc(GFP_KERNEL, 0);
-	if (!debug_pagealloc_enabled())
-		spin_lock(&cpa_lock);
+	spin_lock(&cpa_lock);
 	if (!ptdesc)
 		return -ENOMEM;
 
@@ -2011,11 +2008,9 @@ static int __change_page_attr_set_clr(struct cpa_data *cpa, int primary)
 		if (cpa->flags & (CPA_ARRAY | CPA_PAGES_ARRAY))
 			cpa->numpages = 1;
 
-		if (!debug_pagealloc_enabled())
-			spin_lock(&cpa_lock);
+		spin_lock(&cpa_lock);
 		ret = __change_page_attr(cpa, primary);
-		if (!debug_pagealloc_enabled())
-			spin_unlock(&cpa_lock);
+		spin_unlock(&cpa_lock);
 		if (ret)
 			goto out;
 
-- 
2.53.0

