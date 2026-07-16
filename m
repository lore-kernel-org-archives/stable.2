Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854573F1AA6;
	Thu, 16 Jul 2026 09:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784195673; cv=none; b=XliaFRds5fl62hYXFM9LcZJap4whbbtNgnxtNChI/mwmGspno3Omx8hLmNrjbVNMm9nY/TNXgiNJHD/ZZFKJRMSkUOifoHN4xym32r6h1LK0PImtUP9fZN/WwaR9f8cc6BD2KEAevDgQ/89kEkzx6+zQ4hNhLQB0pT5Fl3rrrHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784195673; c=relaxed/simple;
	bh=ogh2KhpcCtTm1TaSaOWZEZ+PPOTBaLd5tkqe2zydFpU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DF3NF2n/NGwAebWgsV8j3akc6hOBpDTmpAqwoPX2LlgT1ndvxtCoK2QiAqZtfgnTHR8OMSwUE2hA74K+XHpInyU69R9YAtbFVoa1Z3m8+QMTxJ7eJcNSLdqB84Cy0kX9zeyoll7I3x8Kwa29zvAuJgGBlBcQLeVG77QCRnI99jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=VPdM28X0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IDBMZLAk; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="VPdM28X0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IDBMZLAk"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 771EDEC0175;
	Thu, 16 Jul 2026 05:54:29 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 16 Jul 2026 05:54:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1784195669; x=1784282069; bh=t8G5lsIKKp
	va0znbYyGiKU/6r4uVYEwGmeoiyfav03A=; b=VPdM28X0ewdlGKE+UspBf3FiMr
	/YOs2e4VnHhivUcMVDEjinvSwDxKivB6AW27+BChqAfXgIvx4o9yuR2VJj94MH+9
	fgOky4HwZf9fIZlAOswZKTmMD1MAbWL5S5YygEkap3MPH80/6wEJmLsVL5QrjTQP
	vFv6J9XjSSWOqG0ZOLkKb8HXNi9SB6z1Y/39k61JbVyHOWHkRrj029NAOaJVhCjO
	Orecw1nHKvrNkc9Gp/bPFLDyXqUR+RNDjc68X+DrGbAzfwoZxq1Gqu2DaI7Tt72z
	Y9DXf/8T/GreMP6F78kbos2n8LMy7ez4r8UYaPwecYk6q98X0wtZCySDHQUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784195669; x=1784282069; bh=t8G5lsIKKpva0znbYyGiKU/6r4uVYEwGmeo
	iyfav03A=; b=IDBMZLAkWJJ70cc96aMS6cZ4r8pcETBBI+xIPraKrVfcdETV/9A
	RynIyMJqYpSq88f4LawBBCKoxySp0ca/w4wzmyoPhQJ4RMc4wnmXLelEzrWgRkl7
	3ZPLofRkmAxTghbLnxy5tcBTAEsu3gOrJ+I7S1P489UyoIlNRJKpDRhTPPwpjUoq
	htS5vztFcFYhfhLG/FgAGXxldIJXF3//9TMM1a7vxN/h8d92cIGTGFsjdQJD+79r
	bCyOJ/gee+/+lRP1wzHSMSWcGPKVD4LprAE8DrHthZFxpZ3WdGXjaj2GMTCuAtgn
	hvskGuevMRAUErX/nIJas1n53rTyCt/PWwQ==
X-ME-Sender: <xms:U6pYar0Arx2oXk9M4F1WQrJSbx85RZQXbP_7_UWLAlAnFYAutnXokA>
    <xme:U6pYau_1Ou_WNVDaXpDbzYF1bc_FJZDW6YSD-QvR3dqC1mFMdLUE5-A2_fRZa-9ne
    1lKKH5yZzWMXNK8orbvXAosOI63D86P8hePqE1B1HpEM5J787dtTow>
X-ME-Received: <xmr:U6pYake5rwIpIOfaDqEVw_H24FnUzlD4yRmbIcZWJkka8PZQyXJ8KLXXLdNJ5g>
X-ME-Proxy-Cause: dmFkZTF+CYkUYldUcjhegyiuGvzrP4J+tflPEv+hUKqI/6hhNyOBudvlQYE+Ipk0aE1Xm9
    FZI4wc+pjIeyYENfLoy5GGLnnDXAsWOJpRYWAe1FggnGQs312LLvb+tGAPqIYpUY3+1kB3
    JqnUm0rg050bRxyFoLLwXzlrCU0fgMYi9w+86HcHDy25ToZdlVm/UhdLctff0r9LdC4gWT
    8tB7TyorVAPBJLAMg5RHqfSQ05JSLR44Bd0yaYKc5y3UgnX0ZQlRpB+IYtVEEVC6FzvhtC
    CMX7tb+6HxUpkpZAbf7FGQj9zPA/Rj6S5+JEqw9L1bOSUQYsxItgWeA1vhgwpBsfpxJGGf
    b9C2HWNm++KFq0UwlGMjeteiRgMiMQ/HkasAdHkHa5Dzy7pOGDRzr2SoSpqJiflzfzBzi1
    TCei9blgdpYrP6DdNC5B4iaKS/l7ooO3BoNhGzwPzt91pAnyKl560BE1GhLucUAS1kit+q
    elOmU4wpab12OsstkdRNeB1JL2ctun60vwaRe0CQTMdqxoZTkMIANfJZVI8aUVSHFSoN2Z
    ff/GQ3wCPZOmwleiAKootnMrihsUM/5RA/ZwPp0Y0ymFWkIooOpl6A8OM5/V9mPTv15m8e
    nbDBerKpdrb2OqYlAFcQQWWu/67ZrJ0ho/GJwga76F/OCYmXL5SVSSal80Ug
X-ME-Proxy: <xmx:U6pYaiH8vkBlepdBOU81EFyQCPV8TC5LK6nEdax0OaqxBp8iCNOjmg>
    <xmx:U6pYahDnVj1xyxd5tE4aLUA5usksTmInZ5LUSTmIihtvgJ1CbZpy_g>
    <xmx:U6pYat6ry2f2VmzR2zXRZwK8WvarHnpCaN2vMQHjD8wGtnhxWgX3Pw>
    <xmx:U6pYaolaNZ49x1xZ7GIJjU0l3j-apAvr_aJXhujtQofPk1IniizMuQ>
    <xmx:VapYahmng1JV2-TjOArE1jyeTb1LObZ-tp0jW-nPNzs2ws4zEOK83a72>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 05:54:27 -0400 (EDT)
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
Subject: [PATCH v3] mm/huge_memory: unlock i_mmap_rwsem before releasing after-split folios
Date: Thu, 16 Jul 2026 10:54:24 +0100
Message-ID: <20260716095424.471052-1-kirill@shutemov.name>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>

__folio_split() keeps dereferencing the mapping after the split:
shmem_uncharge(mapping->host) and remap_page() while the folios are still
frozen/locked, and i_mmap_unlock_read(mapping) at the very end, after the
after-split folios have been unlocked and freed.

Nothing holds an inode reference across that. The split relies on @folio
-- which the beyond-EOF drop loop never removes, as it starts at
folio_next(folio) -- staying locked and in the page cache to hold off
eviction. But the unlock loop unlocks @folio before i_mmap_unlock_read()
runs. If the caller's @lock_at is a tail beyond EOF, as memory_failure()
passes when splitting a poisoned tail of a shmem THP that reaches past
i_size during truncation, it too is gone from the page cache; so once
@folio is unlocked no locked, in-cache folio pins the inode, and a
concurrent final iput() can evict and RCU-free it before
i_mmap_unlock_read() touches i_mmap_rwsem:

  BUG: KASAN: slab-use-after-free in __up_read+0x634/0x790
   i_mmap_unlock_read include/linux/fs.h:537 [inline]
   __folio_split+0x732/0x1640 mm/huge_memory.c:4100
   try_to_split_thp_page+0xab/0x390 mm/memory-failure.c:1675
   memory_failure+0x1394/0x26e0 mm/memory-failure.c:2470

  Freed by task 4601:
   shmem_free_in_core_inode+0x54/0xb0 mm/shmem.c:5177
   evict+0x57f/0xac0 fs/inode.c:870

Do every mapping dereference while @folio still pins the inode: drop
i_mmap_rwsem right after remap_page(), before the loop that unlocks and
frees the after-split folios, and clear @mapping so the exit path does not
unlock it again. shmem_uncharge() and remap_page() already run before that
point, so after this nothing past the unlock loop touches the inode or the
mapping.

This is now a rule the split depends on, alongside keeping @folio frozen
until the page cache is updated: no inode or mapping dereference once the
after-split folios start being unlocked.

Reported-by: Hao Zhang <zhanghao1@kylinos.cn>
Closes: https://lore.kernel.org/linux-mm/20260710071344.GA106129@zh-pc
Fixes: baa355fd3314 ("thp: file pages support for split_huge_page()")
Cc: <stable@vger.kernel.org>
Co-developed-by: Hao Zhang <zhanghao1@kylinos.cn>
Signed-off-by: Hao Zhang <zhanghao1@kylinos.cn>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---

Same patch as posted in the v2 discussion [1], now with tags collected.

v3:
 - Move i_mmap_unlock_read() before the after-split unlock loop instead
   of pinning the inode or refusing the split; based on Hao's original
   patch [2] with the race analysis corrected.
v2 [3]:
 - Anchor the split on the head in memory_failure() (broken: the caller's
   reference must land on the poisoned page) + -EBUSY guard in
   __folio_split() (over-rejects for new_order > 0).
v1 [4]:
 - igrab()/iput() around the split (self-deadlocks on final iput() under
   the folio lock).

[1] https://lore.kernel.org/linux-mm/aldjhtfVByHDQXe6@thinkstation
[2] https://lore.kernel.org/linux-mm/20260710071344.GA106129@zh-pc
[3] https://lore.kernel.org/linux-mm/20260714122344.351895-1-kirill@shutemov.name
[4] https://lore.kernel.org/linux-mm/20260713170915.239819-1-kirill@shutemov.name

 mm/huge_memory.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2bccb0a53a0a..abaea34ef558 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -4109,6 +4109,18 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 
 	remap_page(folio, 1 << old_order, ttu_flags);
 
+	/*
+	 * Drop the mapping while the inode is still pinned. @folio stays
+	 * locked and present in the page cache until the loop below, so
+	 * eviction cannot free the inode yet; @lock_at is not enough, it may
+	 * be a tail beyond EOF that the split already dropped from the page
+	 * cache. Nothing past this point may touch the inode or the mapping.
+	 */
+	if (mapping) {
+		i_mmap_unlock_read(mapping);
+		mapping = NULL;
+	}
+
 	/*
 	 * Unlock all after-split folios except the one containing
 	 * @lock_at page. If @folio is not split, it will be kept locked.

base-commit: 0e35b9b6ec0ffcc5e23cbdec09f5c622ad532b53
-- 
2.54.0

