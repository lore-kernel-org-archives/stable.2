Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794845431;
	b=I4nYTFQ1crAhHmF6pjhtgH0z1urvSt8PD7UpxYL5wk9NkKMHZeM7CCwiUl/U4aermD1B
	 SNNbuyOwVcigQspkxxultmyjWf+JAGlcFipDgkBwnSE35cDIgQFrOmsYnr97frPDWkY6t
	 KkjJtKOf0lHLbBDH3BEAGPaOqXuuPY1BPCZMNpOPY7sSyehi6fRZGJEwNggTzS9GFAnL2
	 rpzCZx1awH+3Zjy6ReKn1nh5bijv4CMAkYzGtjzC1n23Q85R11xzYye3qaMiDaj77RlgL
	 TVZ0ZIKZ+/T1+ojCTNGkz997FxJufDrjQOFY5/hkfOIyHW4BWmLIYWl817r1F6uUcIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794845431;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=NA1C7yoroVL06quzgnLBMUHJrAMFyXt5rvTfApVfqGU=;
	b=DUpD35tGLFTFCRBg4w4Sj7m/zZLalwzzp1V9zvrzXK4zTKeAbz88kwP0D1Gz9i7weLTe
	 qNWgQNxAGhguwqLTNpIOzNv00WcNZtmJ5d0owOzo04PrefXAle6gtLzE+JQilUbXkIWwv
	 S2qDsptyq/d1FjUFMNSMiE7rIXlROzUH4urCwcQ1wQFGKaQHWh7vpXquvBlqggSxqg3qG
	 9MRwE9S6BL/95ykZfVn7P/ISwRAVb1XyJoGlUGLxxh4BOQOCpxkNyPHQry4/CbocKhDFY
	 vnqRXwQoHWpughZUWA71ZN1LaC8PMTWmHWxCiyC6xSoVW3lGGWAf+yu4xuss5R1rLZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gt5aVK2I;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68E4606A880;
	Mon, 16 Nov 2026 16:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gt5aVK2I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 083081F000C9;
	Mon, 16 Nov 2026 16:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794845430;
	bh=NA1C7yoroVL06quzgnLBMUHJrAMFyXt5rvTfApVfqGU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Gt5aVK2Io7gyf94m4U4ixmmw6U01jBsq4wOuBkAnsn68OwFVODhWLKPjTD3NofB2P
	 JHKSVsIUDZ3NNJN2R4+MOtgqLeDSCy3f6h+uUmRQYmb/7wIbiC7Zv9RCIoltjV1AGD
	 RvvcxiqouhkQsnmZPRHozJRYgKHuuwDNZz6D8b42NJENcRYVN3Yp2vFA1/JL6f5XeY
	 65tjhUKzJLvs3rWccmUzgcMZaGVUAbRscz2cY1VB9W6BI5gMspk0tlp9Tbidw745e0
	 elrtoBKvRAta69Jc4Z1GruvLfZrKng4LNnrgkpvku1ew1K4ki6Zjn40SAVXXN6v1cT
	 XsMK62KioYMZg==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.ams.internal (Postfix) with ESMTP id CB6BA198003A;
	Mon, 16 Nov 2026 11:10:21 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 16 Nov 2026 11:10:27 -0500
X-ME-Sender: <xms:7Sr7amEFp3rk5kS4DhQPCDN5C_AyJnjEn8SVMZhAktj3A4iaY7EpJw>
    <xme:7Sr7am4u9iieCqodw0t1Eb-RZq9Q6plVwPapUsWD9pQXYoVcIoGGAdxnSMjn8R26c
    NiRzAPXBLnIY-yu4ocBx2SZI-GQSJjUzkgEM2LQjW_1ejI77qzaN7yW>
X-ME-Received: <xmr:7Sr7akM6pC0z-xuIcebY4YkhZIWya_v8EXzeAcFnJv6Um8NCQN23H9ADXas>
X-ME-Proxy-Cause: dmFkZTF/ImuQq9XU23DBSCdicYzV1eBj/E7gxuq27UlHGpvX3pRJFOxPTG4J3QLoRiBcdw
    RQU6URnB9LLd303PYEzHQLl3dmM/e+lBoUoG7GK5Nu9rTFsJV7gBRlyQpOVWCu2jzVoIPX
    ZJvZ9T/y+PuMBH6peZtK4XbQxCnASHrnGYknJc5BsB0kD3ckjVfY4Y07pYP20q0OtB0hXF
    SMyPWjPp1ElqtMMJzVOIBEuWG8aWsirL3bThfOwzmfce1AWMbsSDPu6aVF3AVVHpGrMMFB
    bo9QkWqStmL8IWHE235Cm0++DFOOM/0uXHClf4HD7RJceyF+40JQMDQ0Uh6nM531nxwIcn
    vcmHWEHvRzJSJMg2GxNnULJMFYtvhYWSjzMrJ2OlCurAEDTnyVTeRFyDY83zgRG0Hny1tz
    S5GWqrkBbqjbLe2zDVmLP+oBYBouCvEkhnJ7CP9TM+CxXCeQBAqG4oLCviTGitzRHJvA64
    kYEzK5EUP+SJK7O+MN/dryYMEcFyjaq/rS5A+b5beRrkndRaztbAgSvEIZQoel2tEc9Kbu
    94yDwyXhXWstqJZVX5L+mvJ9cYx25vZx0aZS9CrNLPbR7ab76oMBGavzg6NqwJgdE1q5w9
    nn7ojmaCsocFooIbgh+OSCiOOTTbMmL7lBRWYr5AONBBRZ581jeCPChpHwXg
X-ME-Proxy: <xmx:7Sr7av2Pe35n9oTpH4wPcAZblzTkwqyY6weHWa70rKj8JtQWoTL4sw>
    <xmx:7Sr7ahIz34DCDvEVlpGWvJrHN_4biw8sPsOs4cdxaKgb_9eBfhGF8w>
    <xmx:7Sr7avKwH9sAFIIyyXXR7X38OJHFNQRwNp2606BKozDVWVfpjbjuJw>
    <xmx:7Sr7aigaxIHYnBQdGOl9SktAKmi69OhJMcNbHT3Rdij-YUo09kXhfQ>
    <xmx:7Sr7aqR_uP6B_-4nCNVopbBpmZ2Kqts_hEKkhMZSoB6Z9VCW6a_i4MCR>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Nov 2026 11:10:20 -0500 (EST)
Date: Mon, 16 Nov 2026 16:10:19 +0000
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>, 
	Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, Andi Shyti <andi.shyti@linux.intel.com>
Cc: Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Arnd Bergmann <arnd@arndb.de>, Johannes Weiner <hannes@cmpxchg.org>, 
	Hugh Dickins <hughd@google.com>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jan Kara <jack@suse.cz>, 
	Ross Zwisler <zwisler@kernel.org>, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, Chris Mason <mason@kernel.org>
Subject: Re: [PATCH v2 2/2] mm/huge_memory: flush dirty file PMDs before
 removing rmap
Message-ID: <avsn7l_QxT3rzkXI@shutemov.name>
References: <20261116-dirty_file_pmd-v2-0-571883053174@kernel.org>
 <20261116-dirty_file_pmd-v2-2-571883053174@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261116-dirty_file_pmd-v2-2-571883053174@kernel.org>

On Mon, Nov 16, 2026 at 04:06:59PM +0100, David Hildenbrand (Arm) wrote:
> Unmapping a file PMD can lose concurrent stores when it races with
> writeback. zap_huge_pmd() removes rmap and drops the PMD lock before the
> gather flushes the TLB. Writeback can then clean the folio while another
> thread can still write through a stale writable TLB entry. Those stores
> do not fault and dirty the folio again. Filesystem DAX has the same
> problem with its dirty tags.
> 
> Commit 5df397dec7c4 ("mm: delay page_remove_rmap() until after the TLB
> has been flushed") fixed the same race for PTEs by adding delayed rmap
> removal to the mmu_gather infrastructure. The PMD path still removes
> rmap before flushing.
> 
> Flush the TLB under the PMD lock before removing rmap for dirty file
> PMDs. Skip the early flush at address-space teardown, when no users
> remain, and for mappings without writeback, including shmem and device
> DAX.

The patch looks good and you can use

Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

But my LLM machinery flagged that __shmem_writeback() might need
fixing. Normal shmem doesn't have writeback, but i915 does its own, and
it is subject to the race.

+i915 folks.

Possible fix:

-- >8 --
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Subject: [PATCH] drm/i915/gem: Skip writeback of shmem folios with extra
 references

__shmem_writeback() writes out every dirty folio that is not mapped. A
folio stops being mapped when munmap() removes its rmap, but the TLB
flush comes later. Until then another thread can still store to it
through a stale TLB entry:

    CPU0 (munmap)            CPU1 (same mm)       CPU2 (i915 shrinker)
    zap_huge_pmd()
      folio_remove_rmap_pmd()
                                                  __shmem_writeback()
                                                    clear dirty
                                                    !folio_mapped()
                                                    shmem_write_folio()
                             store via stale TLB
    tlb_finish_mmu()

The store leaves the folio clean in the swap cache. Once reclaim frees
it, the object reads back from swap without that store.

The legacy mmap ioctl maps the shmem file directly, and i915 mounts it
with huge=within_size on some platforms, so the folio can be PMD-mapped.
The core mm keeps the rmap until after the flush for PTEs, but not for
shmem PMDs: shmem has no writeback, and pageout() refuses a folio with
an extra reference.

Do the same here. The unmapping side holds its reference until the TLB
is flushed, so a folio with references beyond the page cache and
writeback_iter() is left to reclaim, as a mapped one already is.

Fixes: 2d6692e642e7 ("drm/i915: Start writeback from the shrinker")
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
index bf9e7480f0f5..748772c358ac 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
@@ -316,9 +316,15 @@ void __shmem_writeback(size_t size, struct address_space *mapping)
 	 * leaving only CPU mmapings around) and add those folios to the LRU
 	 * instead of invoking writeback so they are aged and paged out
 	 * as normal.
+	 *
+	 * The same goes for a folio with references beyond the page cache
+	 * and writeback_iter(). A folio that was just unmapped can still be
+	 * written through a stale TLB entry until the unmapping side flushes
+	 * the TLB and drops its reference. pageout() checks the same.
 	 */
 	while ((folio = writeback_iter(mapping, &wbc, folio, &error))) {
-		if (folio_mapped(folio))
+		if (folio_mapped(folio) ||
+		    folio_ref_count(folio) != 1 + folio_nr_pages(folio))
 			folio_redirty_for_writepage(&wbc, folio);
 		else
 			error = shmem_write_folio(folio);

--
  Kiryl Shutsemau / Kirill A. Shutemov
