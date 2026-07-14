Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8809C44682A;
	Tue, 14 Jul 2026 12:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784031844; cv=none; b=IXRaAK08uk//gjdM93KLBhc65a6re7GEhFrtLNIk6jnUFIIgnKKs3imVfqVMLXbKkfAxc+90RCkti9IkD3gG2sWqnq6aTVQcRGZtjvWR8Az1AvoJ6hxFRcvSHb02qjaEWa4B4T7dtD8ttACYPMVqWPLr67fm4zl+Ma1N7w5Yt9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784031844; c=relaxed/simple;
	bh=jQNVO4RRwQ525O93hAsBPU5SzGEuk75wV+ZKmx7uvqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CpUn0yBhnbFQITq5mUB+TyI7X9PxVjaKquwCPX74qGVeFe0pgj5PQFgbqp8iqDX897aRZkveglHQuqhjoJruFD1R88f6svNF4AYE6w8vbGhEsxgZu5EGK0g1RR9VnprSZz5fxT7W8TXHmJ02SUJVvZLqAM32Fy8SgK/U/ac/RXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=WLGNLuJF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dxic3/Ka; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="WLGNLuJF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dxic3/Ka"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B7E287A00D9;
	Tue, 14 Jul 2026 08:23:53 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 14 Jul 2026 08:23:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1784031833; x=
	1784118233; bh=/0a1QUYMOPMY+SvL6khttYjCLI43JqaOiKufnepwcnw=; b=W
	LGNLuJFxBWrSHckB5wRVqupAOxNLygiRQyPEsUw7uASygYWzCxbrMGxNB2NIgoQ9
	EHffatN/GgCS7/ABt0RfMD5rKbJMY3nCMU3FTRYFoXEqyfIsPWdGA7V8XxgkgySR
	flZUbd3L3LTWZ7Q6DS+zopB+k2IVjaERRMCTOWNh/Y7nP487sxWxujjT7udFOVLB
	It2tOnYqj6fEgvYVIYpGMwbJepTDPC/346vIxQiEIm4pOrqkVPJ1vPOvwy/gNEtY
	toQLi/ulIsUq/vW5zLFryE2/Fr8obt8NEeXY0T/p9kTg/hx0IOhs9Y/+PoSK47wG
	v0Blh7m+6exfc+bqHFY8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1784031833; x=1784118233; bh=/
	0a1QUYMOPMY+SvL6khttYjCLI43JqaOiKufnepwcnw=; b=dxic3/KaZf89qck97
	vfe2mTSSOFkWLBxDBwepWT1gEWeXbf2QX9iW4Bmzfonw8WnKpVrHa/YuL0iy/hTe
	cyREDf73F2o4ehWyDa9wSt/XNdGD3uA8Na3/vyapWSKTnRFMNch1rHj4jjXpRdGs
	SQTkoClZNum0JjnryUM6vra9k2k10VWI2b3uM8Wu/bZP0yKfPXyXpqu4n8p8jTVt
	Br4QeRE1htq65UV4+DaGHbBXhiVLd4EWlbGNv39HLszzf+cjADAjdWIB9NwVn4bs
	xlNujrBpYB1AJxQFibUKmevJBAJMAkjiQkzEDhHmsx7DJR6nxuIxl82gPS7jYvHQ
	0/g8w==
X-ME-Sender: <xms:WSpWaggJkeJU3EmxeREr0QDSAyZRCAgnH9LG0vm_wrIfuwRi5-q7hw>
    <xme:WSpWauxQijxhvz6w9GIyWAzqo152DdT97r-0JlQiz9j0XT3ugFALQbJfSlMsNBomg
    IS6fo6zpBvP2J9vXYJ6n7nBUG1naWVJspXNnIa7zMZ3LJn7lOuMyHk>
X-ME-Received: <xmr:WSpWamLLKynTz4ovFQl-6IECigvxenA0mWJq4C-50EqtMJwIy33gNM1gHDqSlA>
X-ME-Proxy-Cause: dmFkZTE/UbLJkgjt0BoqHglwrJX1f5PHEA/FB0nSUDVtYKpndNAtdUl6JHnSUpXWMgfs4c
    d4J6LwvZCUX0a5T+QyiumtaKrodT7U+OJWhjSGjWu2F5DfddgHzIfut/BYthc7Sto1/3uk
    EHEI9Uu/OGSx6QViQOKP9KqikD2m/IBo47muElgTZEunn3coMc/3CzhGZk75H75+Vz2euG
    I8nkEmlGh0wryQWBMqDENy1O90ym5jZd3bfa9OkWP8p+lMnB48rVCs57F+52UpkmpKSDTQ
    pvWo96Nduo4s64x50svctFa77x9730BnaPHuEEzPQXyZFSJzjFCAKNnirj3a4e+5JuRctf
    3AjwX4rDrPBcraK/o3UwdKh0iaxSX+j0q99V36cWJJo35qVybt7yo+jUA//DL74jZfDjav
    UwpHaX/LCOA8zLyCvjnSWcAJJdWonIZKQH5EkfB86gIoxmJbdDA/+gkzlAz8tI6pHf3a4Q
    hY2OEtBhBzJ8T2pcXDcts6nWcgon4DmboC3fGXnInCtwRiZ5EkfXNB6ZNhCRLIAIk6nzUy
    qDkB38vSo+lJme+ZkJwsNqpUM/STROBDHByw9QDBKHESUSqRTs4phsjtAFbf+MiBfVmkDn
    dJIe+pmHbjx71Zo+FTWJjNbMq9SQZvTIoOvz1lSpZenE7wQBJ8EqCdZmaqSw
X-ME-Proxy: <xmx:WSpWar2Ly2Mn8j2HySrdEQDCWGUjJwgI2NaQMJZdjISRKA9QtelBzQ>
    <xmx:WSpWaoc35WgD7yVf8WLqSNjT1muC7YbV0RmMDNTNRB3lQzfBAyNw0Q>
    <xmx:WSpWan6nW1fLWAySpnerCtA0fjiVS0nG8BXuMQs03d1WK3HK7DOcOQ>
    <xmx:WSpWaj8bBfe0BI5s3730ulC-f88KW26Z5OYpQseWknYuSVYBDNhsBw>
    <xmx:WSpWardi_astK4Fc_m8S94wRNrXdXD_6Ehli5WeV5kRQcZCZE1c6Z0lI>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jul 2026 08:23:52 -0400 (EDT)
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc: Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R . Howlett" <liam@infradead.org>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Usama Arif <usama.arif@linux.dev>,
	Hao Zhang <zhanghao1@kylinos.cn>,
	Hao Zhang <hao_zhang_kdev@163.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/5] mm/huge_memory: refuse to split a file folio when the anchor is beyond EOF
Date: Tue, 14 Jul 2026 13:23:41 +0100
Message-ID: <20260714122344.351895-3-kirill@shutemov.name>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260714122344.351895-1-kirill@shutemov.name>
References: <20260714122344.351895-1-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>

__folio_split() dereferences the mapping after the split completes:
shmem_uncharge(mapping->host) for folios dropped beyond EOF and
i_mmap_unlock_read(mapping) on the way out.  Nothing holds an inode
reference for that duration; the split relies on the caller's locked
@lock_at folio, while it is locked and present in the page cache, to keep
the inode alive through eviction's truncate_inode_pages_final().

If @lock_at lies beyond EOF, __folio_freeze_and_split_unmapped() removes
it from the page cache while keeping it locked for the caller.  That drops
the pin and lets a concurrent final iput() evict and free the inode under
the still-running split.  On the anon side __folio_split() already pins
its anchor explicitly (folio_get_anon_vma()); the file side's anchor was
always the locked in-cache folio, just never enforced.

The only in-tree caller that passed a beyond-EOF @lock_at was
memory_failure(), fixed in the previous patch to anchor on the head.  Make
the requirement explicit so it cannot be reintroduced: refuse the split
with -EBUSY when @lock_at is at or beyond the sampled EOF.  Such a folio
is racing truncation, so there is nothing useful to split; -EBUSY is
already handled by every caller.

The check uses the same @end sampled under the folio lock that the drop
loop uses, so it does not race the trimming it guards against.

Fixes: baa355fd3314 ("thp: file pages support for split_huge_page()")
Cc: <stable@vger.kernel.org>
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 mm/huge_memory.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2bccb0a53a0a..0e3ca7178d8c 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -4065,6 +4065,20 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 		end = DIV_ROUND_UP(i_size_read(mapping->host), PAGE_SIZE);
 		if (shmem_mapping(mapping))
 			end = shmem_fallocend(mapping->host, end);
+
+		/*
+		 * @lock_at is returned locked to the caller, and while it is
+		 * locked and present in the page cache it is what keeps the
+		 * inode alive: the mapping is still dereferenced after the split
+		 * (shmem_uncharge(), i_mmap_unlock_read()).  If it lies beyond
+		 * EOF the split would drop it from the page cache while handing
+		 * it back locked, removing that pin.  Such a folio is racing
+		 * truncation and there is nothing useful to split; bail out.
+		 */
+		if (folio->index + folio_page_idx(folio, lock_at) >= end) {
+			ret = -EBUSY;
+			goto out_unlock;
+		}
 	}
 
 	/*
-- 
2.54.0

