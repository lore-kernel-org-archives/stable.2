Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793966973;
	b=mQBSUjCMjgEnQ7PDR4i/yb0gCtcmGeR4RGQizJGJXlXmwoN+9MwvN5uE3bur0vwnG9jQ
	 px+8E6/xxU47btX5GiMPMZ/3mZp2UbvCYwDKPyd45ZKpyoVuZURqvebeymv7+qSFJtIWz
	 MKhcSMSmjsBlYAiYm9gG89hD7T0QcFaTnbiujxQpCoDRuqDUZ2t3Wwk8NRO79ZNY8Yhy0
	 v1qYSemDBdOfppa3CHUka/faoa5j61Nu3lQkGyS0H3fMRtqSCPBoL0ltOcqGfNq9aI7C+
	 N/ysunjAZ4dS0cgF3uO4Lc+nf1nfZk7npb3UexC/a3HC1bLQRB9yFH7hEYJh/6Q+5og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793966973;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=3b/3qYRDMXJenPydA6vHboyvASPjz0NdoyZJUNW0tcQ=;
	b=ya43ERGBFEi1z/TSHpCk0aEO/nPH3ltAlbvAc6NITLpght60VxN/tnl5GWv4ceHn8TPZ
	 nDKri17ccj6mTpnQ0He0zMPybtHxXwr8ABKlGYegarU05Oxlf0JpZu4onJgTV0t1a7b/0
	 p11rTUKyCYVt11ZVsryoHZkVCya+odB6psBDi3VZIg5YFbqn5rJYxl0KizrZuKFCxovbO
	 UzirsNbMjvZoyjv3jkttT/EBlVr8f4B1MM66ILnU0JCy2G8IwetjNXuFtDqFOXu7Ynbh1
	 ZXv/24wQTJnCPuoB6j9V3BEoV0zulPFhdRDeBwcmft4sVsUENThRFjRsG0DrEA8Hy8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SSV8AS27;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D168A606EEA9
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 12:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SSV8AS27
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E85FA1F008A3;
	Fri,  6 Nov 2026 12:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793966972;
	bh=3b/3qYRDMXJenPydA6vHboyvASPjz0NdoyZJUNW0tcQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SSV8AS2751IGaedM251Pc4kK1DfG/a5bXt5MUyMNuFjb3V6Vn4xUp3iR/L8tIzXEg
	 fW4QFbnPW9W7EFxJK14UemEGPM3sJH8q9j+G7WwaoQm9O8Df1ERa66qRD3/FAlWTxP
	 nWUN+s/FNTSF/IFYYiRX6jmkcO0Mt1AF6vtN0rX+pwFm65+yXDKIlIIJfYN1GjRDLT
	 KHa+J7Uc512zgU/qKs5v0uq/r6j8OxdzBWrasIoTrJry2k59HpAyPhqYtJ5oUuZAMy
	 rq+F+fgBjIH1SumhykP5qDVrutk32EhXAjAhaJXPidbzARM6gy4/UgMIXctumJc/sr
	 tndge1RuvYGKg==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.ams.internal (Postfix) with ESMTP id A07FB1980047;
	Fri,  6 Nov 2026 07:09:26 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 06 Nov 2026 07:09:29 -0500
X-ME-Sender: <xms:dsPtaqxrJTBKMp7OtKltwm2epPFXcBPMCXjHSnvSTBZiEgpTCoszRw>
    <xme:dsPtaivhymwhYzphNsED75O-jVH3wrP7jKUF-fcFhrf_ltrIPQ1Mzf5fbdobahiN0
    DXR0fXbL_820ZYAyXeNBir1bUGTL_6fHcfbQL5d88PmyZsoB-KaOpjJ>
X-ME-Received: <xmr:dsPtajnMMIFZRQqyyuMajejjm8d7hjO0epIrwV9knfZzeapZLHElEqOGctw>
X-ME-Proxy-Cause: dmFkZTFX6YYaRab9TtEmMZcJX+vH22GvpLmKiqkJD2aksNON1/L0ndlQvnX8flK4ouosr5
    YGDUsiJ7BeAviv4JgQQ7uP7Q+wJ/EXSI9CRs9yYssUQBr42HFWwk4wrtc4JQdlkef7n68F
    nkAp48OZv+C6deWppFMl1GEzsmXrXcRCtNlS1Qjs+aP6RV1JNO9OgT6J+XnDi7YVbuR8De
    igCglYK6lQoAS4zHclSb0LfjyhmpZ/wcRoRbFIW9Kn8GxKsVqVGW+GF6OeO+8eok3lBCtN
    1D4Z9CbSWh1tkn1l7VRQwMsJnnSTVAwraXBCXqv6KiYwLXUWwr7wRmk/4JXWi7hqf99OBt
    0SzFoIlQgDEpMlYLsmsV44GLRWl8+6hUNbvse1m9zA3MICJRu2RPFptHarOrLNY4CY9lHd
    cmD82b0qW6ldXjXoIYNwPaaIwA0Q1zJXsfoLpowA0oUagELfqFgfzmKhi9i7/hYJNMOboS
    I80WilBCOxVz/X+dB1z4YwMbbGsJxJ0YGcdxwQ+oHybZTSxD49/KuR4HEZryIuuvDqnvYE
    3NpNfqDnIjTqqTUq5Hcxvfxv3tsbi9yVToFzcrI3NWelhh3yRDTy2trG/3lYRieRDRkKmE
    QS6adowkJkf/1ha5D61Y49oD8WyVzsZKzFUIOwtIblhjfFzxbZ8NKjXzIhHw
X-ME-Proxy: <xmx:dsPtanBGI0m3xopWzemDYTi6JuRs1JLnAPlsouh3Y_0c8HYJfcb_CA>
    <xmx:dsPtasQCcTihdD87s1X0vrmqulaZ4IXi8iL-xm-1W4DFdbuO3MPh_A>
    <xmx:dsPtanI8ymsHX5TW3iOzWHpISJ_hH6rm0IAbh5X-NisdFWL8tDRDpA>
    <xmx:dsPtal0dZAG_OiwyPICzFkV9pDGpdlM5nDgnzQIMZkTnC1gpHob_1A>
    <xmx:dsPtajuRiOMZHIW4dzpShBuOzRcwTMEriXB5q7BFJkzYYX3quu2Zor2y>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Nov 2026 07:09:25 -0500 (EST)
Date: Fri, 6 Nov 2026 12:09:24 +0000
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
Message-ID: <au3C8lNElGg4LnR1@thinkstation>
References: <20261105-set_huge_pmd_uptodate-v1-1-a78d8a1b7117@kernel.org>
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
In-Reply-To: <20261105-set_huge_pmd_uptodate-v1-1-a78d8a1b7117@kernel.org>

On Thu, Nov 05, 2026 at 07:16:44PM +0100, David Hildenbrand (Arm) wrote:
> madvise(MADV_COLLAPSE) can map PMD-sized pagecache folios that are not
> uptodate. For example, shmem fallocate() can put such folios into the
> page cache.
> 
> collapse_file() already refuses to proceed with folios that are not
> uptodate. Let's just do the same in try_collapse_pte_mapped_thp() and skip
> such folios, leaving handling to the page faults.
> 
> Note that collapse_file() effectively clears shmem folios through
> shmem_get_folio(); let's keep this fix simple and simply let the page
> fault path deal with that.
> 
> Fixes: 34488399fa08 ("mm/madvise: add file and shmem support to MADV_COLLAPSE")
> Reported-by: Chris Mason <mason@kernel.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

Separately from this fix: nothing on the mapping side catches this.
Every caller checks uptodate on its own (next_uptodate_folio(),
filemap_fault(), shmem_get_folio()), and khugepaged was the one that
went straight from filemap_lock_folio() to do_set_pmd().

Should do_set_pmd() and set_pte_range() assert it? Something like

        VM_WARN_ON_ONCE_FOLIO(folio->mapping && !folio_test_anon(folio) &&
                              !folio_test_uptodate(folio), folio);

The ->mapping test is for set_pte_range(): finish_fault() also maps
driver pages that never get PG_uptodate.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
