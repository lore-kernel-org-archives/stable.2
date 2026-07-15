Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B8A436BF0;
	Wed, 15 Jul 2026 10:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784112141; cv=none; b=LuGetopKo4wCUPRB2IpDyU/z9dLFqn/iLUro5DkFwr4+vmmjpWOKzMTPC1bp6AbBJEBh6gZVpNzExAM226BsXK7jEAKOoBrxVCaIXsLFj0ktNn0IegOwTn1d8NgI+3s2NcItReSvZeQvbAinCCdwFp/DKhCuk2j68RdEhkt/w14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784112141; c=relaxed/simple;
	bh=CTjxkPvSDwWY+EGfAZPSRk49RqAfrHTIbZddbHrxUQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ih9eknDMeOzGtDFZSrsCfRM9T//2ofleCa2tylEw3uSgbfipoW3/UxpxXeSg4BE9CDe7dgFupVhz/hVK2RBVz7Utjp70rNmx2sW//omozQU5/lL8UL+ugwaU5b83bROm78pbBXiO1S3fvdimnLKFQUTfB6q7R4gSXPpnl6cbTLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=JaG7kJaO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RDB5YZTm; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="JaG7kJaO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RDB5YZTm"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id A39FCEC017D;
	Wed, 15 Jul 2026 06:42:15 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 15 Jul 2026 06:42:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1784112135; x=
	1784198535; bh=a+5vgXGfVtnA+C8TUUd5eVRpaUmr2OuAC+1IP97VaFY=; b=J
	aG7kJaOkQvvMO2Q35MySTKjWaBVQCh18uVGdm1R/6W4p5/lPFYOa+3r44Y9K3BWj
	LE2ubqv3jQrnvdVzdQ/lj7OBUTb+ZvXpkACyYITPkps9qTFK5892aLn8He3bnXtL
	7DtxUitBhQMComeUfm+XO/Ozd+Su6XDlIdjXvXyL0HXb8Og2ycsc1qQdidhhYwfn
	scgOcjawS8udmEbINlyppjIuiOlATAoKuEIwppUwqgOjHVPz9s3GqBQmMQPuvIDN
	+f1oCi/VxzemhH1I+pcuDT4Gy2GZ3ZOsgXR+uKK/ZaBF3p/hBCjlbGSlhBhCws/R
	S3zuzs/aDGbbuM5No93Kw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784112135; x=1784198535; bh=a+5vgXGfVtnA+C8TUUd5eVRpaUmr2OuAC+1
	IP97VaFY=; b=RDB5YZTmX/XJnlisXGsGa3uwLP4/Uyapc81MdjkCTfS0IOoIGBh
	pbIGXzTxVS4vVDdz6qFFH8oanLzYnJb7O8N6Xx9INYVFTD8zwARMH5hYEy7obSZS
	+yvec6X6At1i0si6h0hfjiq1gtQ6gMYTa+tWmRXoiUwEeA4PHufax+VDCgy0e4IQ
	NvEROuUl957WqUXE7x3zeN0wGJV6zqqayy4vr86Oze/npzc5sElo4xb9AnQiATgR
	ATyBFYSvdDAInQfT41y1nzT4Obhoj4nc/z/r4cPMZwUFfc2gy9AaElfJSyPvD8Y4
	JYXWTpy1GAuI9oTHdNGL2Co4Qv879hVGeqg==
X-ME-Sender: <xms:BWRXavIgQeIqkQdv4FtTIVkWY0w7mEuu7TDhG82AI3HhlAK3ZhKp7g>
    <xme:BWRXav6c0bKGpTISYdsir-lh5csyU6UBTitOj6AtU6qKsK2FJvk7yQ5lkgKSlDxeI
    o7JucPTjs_UzYH8x5rQ0mo8Gu4njr8LLITRfjHOIGtGh9_f7MmiiwWG>
X-ME-Received: <xmr:BWRXanTWlTyXFP9QPLopOn6evzWLP0CArDGGQCyfmZc4KyCYvVtLa610eqJUGg>
X-ME-Proxy-Cause: dmFkZTE9+Ty5l4Hk0j2Gb/fQsQ06CRASYsBJEfuCILaPdrY/Msekl1F224gFNu4HbzAd+8
    VH096Af2te/9p9gN8W+uLHfTfJY3/MewqKtksHPdVeIlSUko6AmavqOS2wHQHu0Af4u6hv
    MBdGSgVHhNLjRDhaMGEUPIMvmKxxVtem7RG6M6eFAiYwe1tZjVIzx52TKkb/rO+HmK2jxQ
    BtkslAy8JwZMpnnkyKY91rjDXF/CjXJhvfiw8b0n9zIjoWzmTbAkK1KdwBR7N4uHr3R1Xf
    xbun1TN0PGYpixfedcwO8eDkjDfFtVWEmeKRFqDpLYrsD82I0htClLB/NonMTbwH/OXBEM
    DuCxAyIOFSUzqzMzvFZu92cGQXV6ZfgYDENNUxygCwLJq67+SpQHbg3C7hlzLhTTtYkTAy
    /He4ijGt4iurXwACK2BCBN96pgXXmlIx7PtgqPlmwdoe4aP1ZFhv0dk+jYBsf89jplxH0D
    jWDVUYVIUnaVacMpSeSn7O28moLI6frAcpjuN2VpeWjPiaKUT/aiuy3nNwMPw+aPMxjTi6
    sjJrYYglKnVvBXo0uz4c7nYNC3inDyE+kQd9f62FBh017pk0PckBNmbspXz/fo6xBsgXl8
    ivxudcSo923yeXXYEcYsfaObq6KdTOlXrZf9YeYhFGGSSymI3TyHV+44pqkw
X-ME-Proxy: <xmx:BWRXahDizIhaw6HR5F5ZrxTVLVQL36GKjPQBLJLHJnBTK5NLUh6Iow>
    <xmx:BWRXaqoDgSAlM5Z5pCQnFoMiKfefcb6A9aH7yUQJ9p0qRacfoTPtVA>
    <xmx:BWRXar-PyuHxrKYZdDMQlURlN-8CBfI7MzyvYDyrjKCWLC2KkIXd3Q>
    <xmx:BWRXarC8Cj2W3Gz6qcJRcyMyVbvNiTzQiT_lN1C0H5dJcXgckMu4rw>
    <xmx:B2RXams3h0snFzACnpl-cqoUQniKCZjnjczy7GYYMZ4VnDI7e_uSlIr8>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jul 2026 06:42:12 -0400 (EDT)
Date: Wed, 15 Jul 2026 11:42:12 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Zi Yan <ziy@nvidia.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R . Howlett" <liam@infradead.org>, 
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, Hao Zhang <zhanghao1@kylinos.cn>, 
	Hao Zhang <hao_zhang_kdev@163.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/5] mm/memory-failure: keep the folio, not the
 poisoned subpage, locked across split
Message-ID: <aldjhtfVByHDQXe6@thinkstation>
References: <20260714122344.351895-1-kirill@shutemov.name>
 <20260714122344.351895-2-kirill@shutemov.name>
 <c4aa63df-30ab-464d-bd0b-48dc37c8e6ba@kernel.org>
 <alZNYYsybKZA0eJb@thinkstation>
 <18fe5529-2ad5-4330-a362-708a152bacee@kernel.org>
 <66A57599-EDA0-4E99-B073-F2AE0B2ED708@nvidia.com>
 <alZljHr4Nk3FOpCP@thinkstation>
 <DJYH202OLKZF.432DAJWF2MGA@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DJYH202OLKZF.432DAJWF2MGA@nvidia.com>

On Tue, Jul 14, 2026 at 01:31:54PM -0400, Zi Yan wrote:
> On Tue Jul 14, 2026 at 12:40 PM EDT, Kiryl Shutsemau wrote:
> > On Tue, Jul 14, 2026 at 11:44:39AM -0400, Zi Yan wrote:
> >> There is an alternative, only igrab() when @lock_at is at or beyond the EOF,
> >> as I was bouncing ideas with Codex.
> >
> > I saw this option too, but I wound rather not go this path.
> >
> > iput() still can lead to inode eviction an bunch of random filesystem
> > complexity under us. I don't think we want to think about other
> > fs-related locking issues in split context.
> 
> Your reasoning makes sense to me. Let's ignore this option.
> 
> For your patch 2, we might want something like below to avoid over
> rejecting splits. WDYT?
> 
> offset = folio_page_idx(folio, lock_at);
> 
> if (split_type == SPLIT_TYPE_UNIFORM)
> 	lock_at_index = folio->index + round_down(offset, 1UL << new_order);
> else
> 	/* @lock_at in non uniform split is always @folio */
> 	lock_at_index = folio->index;
> 
> if (lock_at_index >= end) {
> 	ret = -EBUSY;
> 	goto out_unlock;
> }
> 

Right. With the -EBUSY condition growing this hairy -- and having to stay
correct for non-uniform splits too -- just moving i_mmap_unlock_read() out
of the window looks more attractive.

This is really Hao's original patch with the reasoning corrected, so I kept
him as author. v3 below.

----------------------------------------------------------------------

From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Subject: [PATCH v3] mm/huge_memory: unlock i_mmap_rwsem before releasing
 after-split folios

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
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
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
-- 
  Kiryl Shutsemau / Kirill A. Shutemov
