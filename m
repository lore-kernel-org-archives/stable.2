Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793193992;
	b=5m7MDapAyoBVp3D6uXgOQp8rGyIJNWbOMJwub9TTE8mWw4kWxNMZiTN6Zphr3VMLqaiG
	 IVQb/6aK+psAwk8YRIqsWVj2DiCT7KNZy6Y6NmlpTQ6BF8xwH1GvM/04wKqFxLVptY4Ny
	 MrtGzuavAKqHTY/+J5hEjqt3saWbBZwXOWpqnW1sW6NOESzSBX4FyllBIxxXMOaGPi3Bn
	 KcrhT95sk442UtRsiTCC9zTbX9ML4wLGkEpyLPPsif7h1ZFXFOYL3bFnCXAU5KOZ7a+Oj
	 7sq3P8F+JagHAWT74pj6oT2seKYHFdThoTirk/NMqEa9TLtIEGI/zpojANWygkKXt7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793193992;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nGV8TGo/yLZr4o9PiqDwm5LBW5oZMSj/CX19OZeK0Do=;
	b=GugF2NLDedyXkyeU3JsfdlcFBIhFfCLRwZ4181uqOEu5gyFlwmT4hwrYcuC9+7wF+gSs
	 uS1BpF7ogsptgXnnW3LnNI4DDAF/DL2XIZdqYS2Vfl6LD2roZFBsVvllocE03yorfYgyP
	 Ssl3fF3g7mk4CfmNP+B709XqONS3H9Sl0F/yXB+OmU52Kcavu5ZpJRM59ziCYlvEo4eyq
	 /yYfAbfgonGPagP+2JGO9kOYsp3kAHN5+NsH/gUt6EXCDFXIhxmSSnqMMNrvNdMh0NygE
	 qVlLBTF5Of6WjyXu9yVLPsabsOqbHJDQenAuj1s9w42+AzZofUrsAZsUiKQRgTsqoMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=shutemov.name;
	spf=pass smtp.mailfrom=shutemov.name;
	dkim=pass header.d=shutemov.name header.i=@shutemov.name header.a=rsa-sha256 header.s=fm1 header.b=gy8OenAF;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=H8GnFBEZ;
	arc=none smtp.remote-ip=202.12.124.138
Received: from flow-b3-smtp.messagingengine.com (flow-b3-smtp.messagingengine.com [202.12.124.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6E3606A31D
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 13:26:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD6E3606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=shutemov.name header.i=@shutemov.name header.a=rsa-sha256 header.s=fm1 header.b=gy8OenAF;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=H8GnFBEZ
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailflow.stl.internal (Postfix) with ESMTP id 36F471301F1A
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 09:26:30 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 28 Oct 2026 09:26:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1793193986; x=1793201186; bh=nGV8TGo/yL
	Zr4o9PiqDwm5LBW5oZMSj/CX19OZeK0Do=; b=gy8OenAFMLHfaZG0qmRFdJB67l
	2fdnIqzhzrXbNNxQwblZ6fJC/9T3uIZpJVPeVkYlSlSrwr2HmVyg7+nixwLiNTZy
	m+lOrTOcbrjqrXxD4J8Su0i4QF8hn56tFUJs/T/w/G9uUaqkeah42XO4glWc7aZC
	5qS2fA+F6MLR4FEE3cKDHbbgdCB4TBj/NvL0JeXjZyj6HED78UMY4bR+3lieqR4U
	yD5zrL2/WurM8KF8xvTIFukBwNilVrnqjyteq/Tac11pYShlDy0eMcb7sihS7EcY
	MllQAm5tGQuUylHSBQxU/2Bxavc4F3xM/0DXCjT6Ua/O2GwUqKrBuLhqFvcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793193986; x=1793201186; bh=nGV8TGo/yLZr4o9PiqDwm5LBW5oZMSj/CX1
	9OZeK0Do=; b=H8GnFBEZYw4ImYs4/EgX41yMD2bVchofdDp5MgKLd7TDbqo/uqp
	YYFsgRUXKR5BZTKIrQZ42ASDrpoYoffMP9yWHZV8Hf0wJKMmbfkRTX8ePRaTagsL
	ihy+vQh/aebhd70bPT2OaUBq3tOSt901l4j/ENCwyzfvmMnSaqscaYhUtIoHxNwh
	GRRB+3QaILezQc4gyBhlGi8vDhaK4FoeX2HHrO+k5EkRY6J4iCT8YTzzTqa4Nrki
	/nYmsNWQTufXvPOASD0/Vc/TVEhiV1p6TcjrZsIOAHMRLs1vHpO8PdfARTaTiKv9
	BQAQs+a11S0Jle1pzWUv14AgfUXfMqRFpWA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=shutemov.name a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793193986; d=shutemov.name;
	mf=PGtpcmlsbEBzaHV0ZW1vdi5uYW1lPg==;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:LmeDWWDlMDIEnFhOg4NEA6alzJduepxqHmd8vLACvnrj4B9
	qljei/iONTm7vzWojkF44gGxPcb9EKaty83gPfp38zwOBbyRDk84C39VewoYZO3d
	oqx/f/Qs08l8GnRUn8Psd1a4Ae2+UuzL3ebMhp1P34V90O+06xHxmYy8vGRMbO5v
	40lNwlknqqdbnbU76bOMRwzbgYO6wRT6pYuynPea/p/TJC6JIasbCRQHBCwsa3n0
	+jT//wmsLFhnEbaJn0KrbuPcl1mbO6tssI203JJ1bEpEGfs2s1meyAQ/KvFisi3G
	xlxlh38EprUfYnrO6NM4v40ae1s1EnMSI8dk44g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=9;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:OA/Jt433qooHZMN1h1WfoAm++DE0cH2Dg90+cuGoGF0=:ry0dPA1lG7EjfUdotOKwWx/qimPuaUA0TcFFKTFqWn4=;
X-ME-Sender: <xms:AfjhatVj2es6gkQDMYQSgr9nxnbON-bIYFOsUIt37tagNRyuhwXm9Q>
    <xme:AfjhaoGHWCR8fomC0IqSeRFAEWFbBKJnCKrOAfDp7VV62yKXdXHI6Th7JE8cDZCyb
    HNvoQyqIPqVQkeARlQ_2a6odwsaiNCfaip38ojLX4wTk4NYEMtzARg>
X-ME-Received: <xmr:AfjhamU1gRIgp1j7PumnllJnE-T69J7QMo2nhORsgGaGgqrJRxqUWrfyq3I>
X-ME-Proxy-Cause: dmFkZTEBob7BBdDUpiR/GngnoqTsMBf2/lBIU/4HIblrHHKKO1LG8nWmV+7kthh8R/a2+K
    vcfJ3uMRW+8EZo1Is4k2ufyPCCwrsPei6dHydg9OvN+DJ9ptNt4hF/42xgm86G3vfDFHFj
    rdodipbfc74DZ5B354ocfR6zFiENC1woBoZk1x/ZFax9UASuUX/LRAr4Qoo7LtIuZAV8VH
    OztBs+qrN3d8zQvSyiTswcoP/a8mprmxxZ/Wzc/DE2pxN1fA2dga3xnGCDSCF7IiQoJS3C
    B9pIX8YIbUTKmafQ4a6iV/l7Ku/n4maIj2OlC3uit0Ir3lO1BxAO7Hfq2OD9EQ9EOO0ljG
    B4Q3IRTbmCFH2ma40rgv4JCOmdm+r8iEJ6icf2+NG2H6lOA/Ax4QrzuN2phS+JzcCTn9E/
    kLVAnQI4wjHgFI2u7cS3K+U76cFQfnfRsJEtk4k5nLoK+xaEVpCg8x9dxO3DXiIQTABV/r
    XiBZGg41Qbn9j23Fk4tRQviTsR+xLuH+RiCgV60VFsQ5URba42Yhm7FI9epUrEYXDKYdO/
    nDkGBnLdaj2XXiW4bsemjDHZlRNY5u2M7ZyIE8HioffVyz8YblTM4a1CyIMMTrYtNIEUEI
    cTQ9jIRCDK8BNbXYM1vpt7b5C62QKRUgZGqyoOOYaMHzf6rPuK+xZN2MmRSw
X-ME-Proxy: <xmx:AfjhajBBheFrS7CaCUtr6xJEUuZdFR4f0RoSMw1N3bD-YtO15xUe4A>
    <xmx:Afjhav0kTEtLGRfMbaAhFlI8SghYxSexJbZJf_j1gEOAR1c0M89G2A>
    <xmx:AfjharRkGw49QdBD_N4SdpyevUijtPGNurC0nUexAALVMuotUFlC2w>
    <xmx:AfjhakYRy4M27O9Is9nnt_U7V-j5DomIw2ZtZr2732YsXq13Fp1Fxw>
    <xmx:Avjhag5tmHV-eZkrvxuU6XGq8oClFUrtxYsrXKOXtWHKbZUb5YanxnFJ>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Oct 2026 09:26:25 -0400 (EDT)
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>
Cc: "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Frank van der Linden <fvdl@google.com>,
	Matthew Wilcox <willy@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	kernel-team@meta.com,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] mm/hugetlb_vmemmap: map the shared tail page writable
Date: Wed, 28 Oct 2026 13:26:21 +0000
Message-ID: <20261028132623.2560146-1-kirill@shutemov.name>
X-Mailer: git-send-email 2.56.0
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

From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>

page_ref_add_unless_zero() reads the refcount and then updates it with
a cmpxchg.  A lockless get, such as a page cache lookup or a PFN
scanner, can read a non-zero refcount from a page that is then freed
and reused as a hugetlb tail page.  If HVO remaps its struct page to
the shared tail page in between, the cmpxchg writes to read-only
vmemmap:

    CPU0 (lockless get)               CPU1
    c = atomic_read(&page->_refcount)
                                      page freed
                                      page allocated as a hugetlb tail
                                      HVO remaps the struct page RO
    try_cmpxchg(&page->_refcount, &c, c + 1)
      -> write fault on read-only vmemmap

The refcount is zero by then and the compare fails, but a
compare-and-swap instruction needs write access whether or not it
succeeds.  The kernel oopses when hugetlb pages are allocated at
runtime with HVO enabled while a lockless get races with it.

Commit bd225530a4c7 ("mm/hugetlb_vmemmap: fix race with speculative PFN
walkers") closed the window with RCU on both sides.  The RCU was removed
together with fake heads, on the wrong belief that it was only needed
for them.

Map the shared tail page writable instead of restoring the RCU.  Every
struct page on it is a tail with a zero refcount, so a late cmpxchg
fails and leaves the page unchanged.  RCU would put rcu_read_lock()
back around every get and synchronize_rcu() back into hugetlb
allocation and freeing.

The cost is the protection against stray writes to tail struct pages.
The shared page is shared by all hugetlb folios of the same order in
the zone, so such a write now corrupts all of them instead of oopsing.

Bootmem folios optimized when the memmap is set up keep their tails
read-only.  Nothing does a lockless get on them before hugetlb takes
them over.

Fixes: 32c440d67e6c ("mm: drop fake head checks")
Fixes: 01b1d0ffb6f7 ("hugetlb: remove VMEMMAP_SYNCHRONIZE_RCU")
Reported-by: David Hildenbrand (Arm) <david@kernel.org>
Closes: https://lore.kernel.org/r/ebc7bde1-f52e-4da8-b16f-822d6c0a4d74@kernel.org
Cc: stable@vger.kernel.org
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
Changes since the draft posted inline in the report thread [1]:
 - keep the pre-HVO write-protect for bootmem folios (Muchun);
 - describe the fault in arch-agnostic terms (Muchun).

[1] https://lore.kernel.org/r/auDkbDlgSZxqlk2G@thinkstation

 Documentation/mm/vmemmap_dedup.rst | 15 +++++++++++++--
 mm/hugetlb_vmemmap.c               |  8 +++++---
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/Documentation/mm/vmemmap_dedup.rst b/Documentation/mm/vmemmap_dedup.rst
index 9fa8642ded48..66d58fbea5b1 100644
--- a/Documentation/mm/vmemmap_dedup.rst
+++ b/Documentation/mm/vmemmap_dedup.rst
@@ -131,8 +131,19 @@ pages of ``struct page`` (page 1 to page 7) are tail pages.
 The optimization is only applied when the size of the struct page is a power
 of 2. In this case, all tail pages of the same order are identical. See
 compound_head(). This allows us to remap the tail pages of the vmemmap to a
-shared, read-only page. The head page is also remapped to a new page. This
-allows the original vmemmap pages to be freed.
+shared page. The head page is also remapped to a new page. This allows the
+original vmemmap pages to be freed.
+
+The shared page is mapped writable. A lockless get of a page reference can
+read a non-zero refcount before the remap and attempt its atomic update
+after it. The refcount of a tail page is zero, so the update fails without
+changing the page. Nothing else may write to the shared page: it is shared
+by all HugeTLB pages of the same size in the zone, and a stray write would
+corrupt all of them.
+
+HugeTLB pages whose vmemmap is optimized when the memmap is first set up at
+boot keep a read-only mapping of the shared page. Nothing can do a lockless
+get on them before they are handed to HugeTLB.
 
 Here is how things look after remapping::
 
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 917db0984143..8e5981888937 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -222,10 +222,12 @@ static void vmemmap_remap_pte(pte_t *pte, unsigned long addr,
 		VM_WARN_ON_ONCE(!PageTail((const struct page *)addr));
 
 		/*
-		 * Remap the tail pages as read-only to catch illegal write
-		 * operation to the tail pages.
+		 * Map the shared tail page writable. A lockless get that read
+		 * a non-zero refcount before the remap can still do its
+		 * cmpxchg after it. The refcount is zero, so the cmpxchg
+		 * fails and leaves the page unchanged.
 		 */
-		entry = mk_pte(walk->vmemmap_tail, PAGE_KERNEL_RO);
+		entry = mk_pte(walk->vmemmap_tail, PAGE_KERNEL);
 	}
 
 	list_add(&page->lru, walk->vmemmap_pages);

base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
-- 
2.54.0

