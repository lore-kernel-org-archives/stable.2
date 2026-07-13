Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200FB340281;
	Mon, 13 Jul 2026 17:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783962564; cv=none; b=RbCPNncDnSl4tSmkFrWgiMIusQvi1bhh6yw6mqWJ3INVmDHyUT0jEJ1CpQOs5IoK6QPq+nlNQFR+dTmd4bwDF4n/YIaeaix3GJMuHzja+ukEXfCa0lkrCZO87MkM+1uNa0kjxPanrBrtfYptzA+oObEwZm8ik+C0OIO3iQ1SYnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783962564; c=relaxed/simple;
	bh=gYuxTyPWNKhXNkgUrJPzlfOuPH7baUPjddi0Y2CzHSE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HvYcCRHtD1HvEXXl4rZCxawrP6ymBoB4TPpZoFpQV5q7+wRn8SPWhXd0+KwLWQ48XwtLCwl2SlruX5JMWxQgHSS6aLqMpuUpmHlcUxcwl8OYYTvitT+M/RrHItaBSd/RkiKU3weLxAdAUA28xTX9IhPpGEzX3bM5dAvEaqm2xE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=NdR9KsWb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VoLSalhs; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="NdR9KsWb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VoLSalhs"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EF2A07A0133;
	Mon, 13 Jul 2026 13:09:21 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 13 Jul 2026 13:09:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1783962561; x=1784048961; bh=z7Hh5ULkxW
	RmZG6F9VlPZhmTwOlGuPHXwZ63YP2S9JA=; b=NdR9KsWbdOxoyS+GannqayIOip
	XItknKnI/jPa7MbF1AlQsktlJyKKJTMvtzqREyUTZISdahQogE73TEVvSk7xLOfN
	B7vF00hgpunLrrYeaceZ4YwgDD5635UvyiT5oiIVehvv/lmXqa9moVRYQ1tM9DIj
	Ay+ivIaVYjuM+tkuuXNscKhVEiL/trYfdsxIA4GH5vyFuPQARVq9xiNTn+Le5Nur
	/PYRaDubLSvn/pC/CoPc3t+sO9qMySZWmK1RJwQxzvlFj+57ImXeZ+XqH8mTIv6P
	opITmT0+p7nDs+nUtA874cAix+Ss3PUIenqB+H7rRajT9GjD+3PQajzMJLoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783962561; x=1784048961; bh=z7Hh5ULkxWRmZG6F9VlPZhmTwOlGuPHXwZ6
	3YP2S9JA=; b=VoLSalhsFTlUEpI9AIl6mZF1kSbQO7+/PgsRS/RlnANvTKXc8rb
	bm5GKlhE2dW6Sj4Osc5ZwX+YUU7bwWmKPrBLw4ma3Co6gpyMZEzB+tzGo5a/hUpm
	JonN6DiyGUKs264M7kMB+/Nz2KbB0J3r8gA6DtgJBYPKyD4D4lKJ7dsFPZHo1HKr
	47GZl62yz7rqeyyiELqNb5yaKyNgEoBALUEN9Tv0AgNRh8CZsaYTwNJtlWCeYTed
	Ig5OvJQwjUMjqHD4sbbl2Kd0TE4UFUkq8ud4Gdkk/piT/JsfKk0h54y20dZAYu7r
	N/JHV0IpO21OZeea4hZWh7YpymYGePlTbHg==
X-ME-Sender: <xms:vxtVaoNsaV_RXYGHI47bx7A9ytp9iIs_R0wDwsYxTiNkRizRLJ-byA>
    <xme:vxtVav5jXTam7M3e3prOho86FtKJRtk5HnszOFsEsrxA_NLZ8rZvwHgUvXeJPXwDt
    fJZ6WdpRhTllqKCWvml8VFeEX_e-YA80TaCyxAjeW4Ed1_tUbXjzAog>
X-ME-Received: <xmr:vxtVavnMbl5kHKTi17Y8ZkXE5rA27llO47_vJJ92_633ZGhggsHJ4EeMhXUklQ>
X-ME-Proxy-Cause: dmFkZTFf7TfKAfTdyv4ZQVxAdLSDk4bKZDHKJh36DOcwq8FaEm2iYMKaYNpHwq7Pc8Vjtm
    ujI66e7G41tPihARJm8rbsi0d0fDBjSATo08b4lHQtuiLLD3buXa38IZZvOnRGQwA1urax
    /84Hrnqq8xMr34H8rAQG1HG15WXAnLwD/aH2eeXITIf7EYdjS0FNCN1DVR70RHaBjrSkIv
    wI7q4gFj0YJsSXpnAob/qbSQg1fMRKfQuTHbuhBMr/bLBxSlWcI1aCw4ooXf1r3DgATwYx
    lORKVn3MzDuzv4/5t+D01Qo/TTkXVKjYDMXP2oPSJk2gq8kUIDB1Uc5STIJs5/koy72LHa
    cVmrfZGDR+oNHnWk54Lp9VMkSBhYAIO8z6g24x8UW4y9+Tvo6CT3q1TBELEhVd1UldL6Qx
    ol2kvfoFQHnlhBACDqYp1W+eDro6SYVbAFcSvFAydtAGyDhRAIfPcnfXZdJ1kBWzFi970E
    Q0L7NqDMR9q9q36qJJREb5wteQiohd4cn5hzlE9WkPtRtBdzt4c4brHpSjHwGKUYNyx0RG
    QyE9H3aqx+uY/uYtCOzepU8MuqgTnP/SGVoWvC/lrNOISxf7+LB+mspBllXvbtNOl1Xk+i
    ZD/XfAbVKmicFUouQZsDInO5NtGRAAsTu84a3JMG5dZFc/zLFbibTB5n/oEw
X-ME-Proxy: <xmx:vxtVavLFYlIOvYUCyEdojvQdJJcU7My1YR1kzB8UGReA_glst33eFg>
    <xmx:vxtVanRW8-I3lkVWqvtEBzXGMnc1iqwGvGYvQCFRcY2IFtfFrK-71A>
    <xmx:vxtVakvGfNXPh2XX1QAqMwId-yCwkk1z-f73Nc0Kg7UNuA6d6PktHg>
    <xmx:vxtVai9sTZosA1Qvv_LfQKO2rypjB8sIV8slHfImK26mdG5Ws6LyLw>
    <xmx:wRtVauvwy4TZbW-lqipR1-qhOJE4HXU3d3-5L0GXV67lMOXDif2FUzhj>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 13:09:19 -0400 (EDT)
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R . Howlett" <liam@infradead.org>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>
Cc: Hao Zhang <hao_zhang_kdev@163.com>,
	Hao Zhang <zhanghao1@kylinos.cn>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	"Kiryl Shutsemau (Meta)" <kirill@shutemov.name>,
	stable@vger.kernel.org
Subject: [PATCH] mm: thp: pin the inode across a file folio split
Date: Mon, 13 Jul 2026 18:09:15 +0100
Message-ID: <20260713170915.239819-1-kirill@shutemov.name>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Kiryl Shutsemau (Meta)" <kirill@shutemov.name>

__folio_split() looks up mapping = folio->mapping for a file-backed
folio and keeps dereferencing it after the split completes:
shmem_uncharge(mapping->host) for folios dropped beyond EOF and
i_mmap_unlock_read(mapping) on the way out.

Nothing holds an inode reference for that duration. The split relies on
the folio the caller keeps locked (@lock_at) to pin the inode through
the page cache: while it is locked and present,
truncate_inode_pages_final() in evict() cannot make progress. But the
split drops @lock_at from the page cache when it falls beyond EOF (the
@end handling in __folio_freeze_and_split_unmapped()), while keeping it
locked for the caller. That removes the last pin, and a concurrent final
iput() can then evict and RCU-free the inode before __folio_split() is
done touching mapping.

This is reachable from memory_failure(): poisoning a tail page of a
shmem THP that straddles EOF makes try_to_split_thp_page() split at that
page, so the dropped @lock_at is the folio returned locked. The result
is a use-after-free, e.g.:

  BUG: KASAN: slab-use-after-free in __up_read+0x634/0x790
   i_mmap_unlock_read include/linux/fs.h:537 [inline]
   __folio_split+0x732/0x1640 mm/huge_memory.c:4100
   try_to_split_thp_page+0xab/0x390 mm/memory-failure.c:1675
   memory_failure+0x1394/0x26e0 mm/memory-failure.c:2470

  Freed by task 4601:
   shmem_free_in_core_inode+0x54/0xb0 mm/shmem.c:5177
   i_callback+0x4c/0xa0 fs/inode.c:326
   destroy_inode+0x144/0x1e0 fs/inode.c:402
   evict+0x57f/0xac0 fs/inode.c:870

Pin the inode with igrab() before the split and drop the reference with
iput() after the last mapping dereference. igrab() returns NULL only if
the inode is already being evicted (i_count 0 and I_FREEING set), which
a split racing eviction can observe; there is nothing safe to split
then, so return -EBUSY, which callers already handle.

Reported-by: Hao Zhang <zhanghao1@kylinos.cn>
Closes: https://lore.kernel.org/linux-mm/20260710071344.GA106129@zh-pc
Fixes: baa355fd3314 ("thp: file pages support for split_huge_page()")
Cc: <stable@vger.kernel.org>
Signed-off-by: Kiryl Shutsemau (Meta) <kirill@shutemov.name>
---
 mm/huge_memory.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2bccb0a53a0a..9bfa3a879453 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3982,6 +3982,7 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 	bool is_anon = folio_test_anon(folio);
 	struct address_space *mapping = NULL;
 	struct anon_vma *anon_vma = NULL;
+	struct inode *inode = NULL;
 	int old_order = folio_order(folio);
 	struct folio *new_folio, *next;
 	int nr_shmem_dropped = 0;
@@ -4053,6 +4054,20 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 		}
 
 		anon_vma = NULL;
+
+		/*
+		 * The locked @lock_at folio keeps the inode alive: eviction
+		 * cannot remove it from the page cache while it is locked. But
+		 * the split drops it if it lies beyond EOF, after which we
+		 * still touch @mapping (shmem_uncharge(), i_mmap_unlock_read()).
+		 * Hold an inode reference across the split to be safe.
+		 */
+		inode = igrab(mapping->host);
+		if (!inode) {
+			/* Inode is being evicted; nothing to split. */
+			ret = -EBUSY;
+			goto out;
+		}
 		i_mmap_lock_read(mapping);
 
 		/*
@@ -4135,6 +4150,8 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 	}
 	if (mapping)
 		i_mmap_unlock_read(mapping);
+	if (inode)
+		iput(inode);
 out:
 	xas_destroy(&xas);
 	if (is_pmd_order(old_order))

base-commit: 0e35b9b6ec0ffcc5e23cbdec09f5c622ad532b53
-- 
2.54.0

