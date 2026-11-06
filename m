Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793972477;
	b=1irlWPnG2bpNr8IXfEaniATcmIijfpEyyYAZS6vYnuNObx7HJofNDIL6bfFse9faILm/
	 taonK5EBD6E15fHPCym6nS9joI68/kCWR3i0Owa5qhkRxgSFWQuXf0sRB4w+EPm5Ze3cH
	 sn5NiVd52iUCTmglragkZu61atiBycodod/um6PTBbdhA0khUov4WRjMKHa7hjH8cNMSU
	 rqKREtk5yM9x4Fl2sR97B62bu6MU+wd1fWZO3vsw2de2ODkviMS/MDBA7wKbptvgWRwz2
	 nJOed4kXfI03Lrvp5S1wmVmoFiho88yx//SS48/+fDHqqGwY/iWSwqAaRZTACv3ev5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793972477;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=HHFIxXCaPKga6nPstJLsXOx0R+aPE2/7Ghw2d3Thvuw=;
	b=qoHHJAJKTX9fHdd7UrcdYKsoOu1yR5NJyEPgwMKc013vAIKl6atIBCshptXbuVJZy2Tr
	 H6C/9trshPeIRTEJm2M8b1vWHPGvlHB7MrkA0nIs1qbT6Ju7idMhKcFehGY3vHMQ7FgCz
	 mJbF3+wfGh/CBrP1cVZPnNlUMAIQrU83CDAFLzLYqMPpxOBxaEwWjvUoZT58cNHRZpn3L
	 VNvpzMRPKRS2cFySWNSkewcLnUiiyma0X9twiTv+V5vfQgSvZlIQGW+0S9SGpcHxosr7M
	 INIEMyCRlPNwdqbbaoa9w5GjRxnsFVEji4LNtvJlAtPjZf/5nZE5R4SF3RzgHDR835w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="R/8vaa/Y";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCC6606A331
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 13:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R/8vaa/Y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A47F1F0089F;
	Fri,  6 Nov 2026 13:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793972477;
	bh=HHFIxXCaPKga6nPstJLsXOx0R+aPE2/7Ghw2d3Thvuw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=R/8vaa/YJLABioKAZ4tEZ5ua53of0H+4BpD+/SXvYaOHK06E07ANfYizOx92eLISy
	 vLpWE1CirlB86vCDGui2doz9l2TKEFalsz8BmpA7cf2w9AXjmvYIpqZrwpp+Tl1h7w
	 dUCEqpyyMyOEnBd/Bb+ThckpTwF1fygLzNyI9XuDtihsEGpmXuwSDExaOyCKcd+egR
	 1ryR3FuX93wCy9bS6qPs9ralDkbPxzWTKmY0RGW08Mkd/ptnu7eRNxWr2aIbPQO1iL
	 WnYAnhBfbFeLek8YQnUCPusmVSFSv6YIHlwBVt6c6gjYBo3iu2S5uClwfkG7DJ6+/g
	 h9kobkiWEIvsg==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.ams.internal (Postfix) with ESMTP id 0C615198003A;
	Fri,  6 Nov 2026 08:41:10 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 06 Nov 2026 08:41:13 -0500
X-ME-Sender: <xms:9tjtahZPGgf_7Mahm6dyFWAiSzOyaPpJy0CJdd2KQR4SLi-gJSQr2Q>
    <xme:9tjtak3xGIlKg3ClGZx_nuLlEK-8f8vHVnOEbsvt6_mjfnUWH0YRMeNNfa2AIwbH_
    exb4qCSdi362NzQOfR2Eo3Qw0qqwd1JZfRou4W8qissDxgyEyCAuFeEJg>
X-ME-Received: <xmr:9tjtarM2RAzkloEnmJErFCGFZPTJdgRBXz20R1fjUAsMiOKwgdL64BcDjpo>
X-ME-Proxy-Cause: dmFkZTFVFaqrxdMA0Rdrdmsp+IP9B9mG/dxHIufxIo+xMkIcBSnN5hVLhkUBVzyjEV4JdK
    Bq8Vi7aogF17ZTGXov2XvAZgFCDHIzZ1XEMCali6ZPDPHgz81JW+gZfwpkmHRh84E617rC
    ahx81ZCaxhS+gJdFDJHUghjaitiOxaZlDtB9yoTdxdwNZEwU7fgFbA0LirO/asuE/CuRCW
    9U41q6izoAvPbSw1lF0KFBqKm4Q8PzBRTNxmqm/BVcpVogZmMFoTujTVS4zbZTjDyjc3bw
    v61ycqyrVpQGPm8Q1YhBM79/LSXec2moRI22lkXKfGd03YJNu+S+2c7N0OvVF6uO48jTrM
    fFIL9grvdTdMUrD2C4QZUqgAWZCtyLtK9B2jZ4goPrhuzTNJUFDDE7ZcFLlTg1mNZAPs1p
    +X7thflt3GXGXPKYGweuPvUhOtUGHOvsnPFXPnl/LS6whsO77murx4EIu/9cMeqg7JG6+c
    of/qkUbAzxKd9XHYtpZHF6l4M2cYrAc9bnBsEqk6PCiT7YfcFvCeMW0+BXLs7LJV7sMh3z
    5UMEQit26OJygfOSJtXIOVP78gP7LsNPGlN9dvAeB7IwvncyiDGYLJLYjuqqaqVYRdUocr
    sTna/nVF3l+i7zzPA3K75Sl+8L9syB21FOm4TZNdzoYe5KTaE8phGK5MIqEQ
X-ME-Proxy: <xmx:9tjtamI4ieZk2t1h2e7TrdxSr8WRa0nkLNU6y9HkZOc4xn6p54IiOw>
    <xmx:9tjtas5yULsRxxSgzHZEkdMMZNXYy6NCoZQYeZQAQSbgmhCIou9o7Q>
    <xmx:9tjtarTszdhzO2TYo4wyeMrDKRgx39K026_RI1D6gGbKDq5bU0pcUA>
    <xmx:9tjtand1KXXf_qlaCXE5vPXegDRYcgMQ20CkK2kpRZTN8SVwogP7sQ>
    <xmx:9tjtak1wrj_BF14J7-J0wDrZQD_zvCfvlmvdV9QWVsVih_sWxdRgb013>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Nov 2026 08:41:10 -0500 (EST)
Date: Fri, 6 Nov 2026 13:41:09 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Hugh Dickins <hughd@google.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Zach O'Keefe <zokeefe@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Chris Mason <mason@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] mm/khugepaged: don't map folios that are not uptodate in
 MADV_COLLAPSE
Message-ID: <au3YD92l6BwCQIPJ@thinkstation>
References: <20261105-set_huge_pmd_uptodate-v1-1-a78d8a1b7117@kernel.org>
 <au3C8lNElGg4LnR1@thinkstation>
 <254c6f0a-9353-4806-a5ab-a071cd59c64f@kernel.org>
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
In-Reply-To: <254c6f0a-9353-4806-a5ab-a071cd59c64f@kernel.org>

On Fri, Nov 06, 2026 at 01:29:31PM +0100, David Hildenbrand (Arm) wrote:
> > Separately from this fix: nothing on the mapping side catches this.
> > Every caller checks uptodate on its own (next_uptodate_folio(),
> > filemap_fault(), shmem_get_folio()), and khugepaged was the one that
> > went straight from filemap_lock_folio() to do_set_pmd().
> > 
> > Should do_set_pmd() and set_pte_range() assert it? Something like
> > 
> >         VM_WARN_ON_ONCE_FOLIO(folio->mapping && !folio_test_anon(folio) &&
> >                               !folio_test_uptodate(folio), folio);
> 
> I think so. But looking at these hard-to-trigger but in the end very nasty
> problems, should we actually reject the operation and do a pr_warn_once() or
> something?

Yes, rejecting sounds better.

Not in set_pte_range() as I suggested, though. Fault-around only gets
there with folios that next_uptodate_folio() checked under the folio
lock, and for CoW it maps the new anon folio after do_cow_fault() has
already copied from the page cache one.

Checking the folio ->fault() returned in finish_fault() covers PTE, PMD
and CoW; do_set_pmd() covers khugepaged. Both return VM_FAULT_SIGBUS.

Something like this, only compile-tested:

diff --git a/mm/memory.c b/mm/memory.c
index 6fe0b7dab927..ff2f2deff761 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5674,6 +5674,22 @@ static vm_fault_t __do_fault(struct vm_fault *vmf)
        return ret;
 }

+/*
+ * A page cache folio that is not uptodate holds data that was never read in
+ * or cleared, and mapping it leaks stale memory to userspace. The callers are
+ * expected to check, so treat a hit as a kernel bug and refuse the mapping.
+ */
+static bool file_folio_not_uptodate(struct folio *folio)
+{
+       if (likely(folio_test_uptodate(folio)))
+               return false;
+       /* Driver pages from ->fault() never get PG_uptodate */
+       if (folio_test_anon(folio) || !folio->mapping)
+               return false;
+       WARN_ONCE(1, "refusing to map a page cache folio that is not uptodate\n");
+       return true;
+}
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 static void deposit_prealloc_pte(struct vm_fault *vmf)
 {
@@ -5714,6 +5730,9 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct folio *folio, struct page *pa
                return ret;
        page = &folio->page;

+       if (file_folio_not_uptodate(folio))
+               return VM_FAULT_SIGBUS;
+
        /*
         * Just backoff if any subpage of a THP is corrupted otherwise
         * the corrupted page may mapped by PMD silently to escape the
@@ -5849,6 +5868,16 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
        unsigned long addr;
        bool needs_fallback = false;

+       /*
+        * Check the folio ->fault() returned. For CoW that is the source of the
+        * copy; DAX CoW has none.
+        */
+       if (vmf->page) {
+               folio = page_folio(vmf->page);
+               if (file_folio_not_uptodate(folio))
+                       return VM_FAULT_SIGBUS;
+       }
+
 fallback:
        addr = vmf->address;
-- 
  Kiryl Shutsemau / Kirill A. Shutemov
