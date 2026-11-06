Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793927304;
	b=1sZdGaIAnboNbWs4y4K5yMYgK7Je6BA0J5tQmQJONObpOld/P9QOcd7YQ7QdDJaQgkNO
	 g9JKWlkRp57/zReZe5H32gFwPgFSEvb9Hr7ctCin2MQ1/+cBW+z8O6uJ9V3wqYvMkMC+m
	 GZPA1XjydhGCbVZTjig95BsXVnbsJIg7Ocilu6ON0Crz+BNZOuYQSF/HzMEIzc0QOELLl
	 R1Lc6HZOOQFmI9T+7LFmdGIOBTO45ai3zdGm18vIhbnji8hn65EvNS0DtGawlX5Q1laE/
	 5T2w5oPjIrKjJst5zjb9JFM5lzrr2hfrgD8nmLW36vfhWR0/7l1/Em6xzsAgCLoI4Ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793927304;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=o15vljGBPrSpL6tMsJUEx5VdBCBrFc3GWWO7AUCavZk=;
	b=J+N0GEG3cC3HyHbb8sPtUSLCoI8gdthBbmXXmFmqU1zTLVVA2sRLZ1SxTr+Z+Yq4qn06
	 jVRUi0GFYwMxEEicOHvYx2Bw09LAcledRGgd6ROYbYwSwoNBbmyIAXOZgd3yY/b0AKzB8
	 oOLnX0JXNNKN4N0qHHzp6QPsQM+hmKheBeI+e0AVtKXT4ZKiSjDrWhCyTqXECv3vcAAS8
	 7QSwNB2yIO2lLT4TJAotG80XOXH8zhc36nCudzP3naNNCK5+d+RTzfHGRsCEMCzPWBrWH
	 Ao1+2gsDlTFuSWjOgCsSSGgAi9alKhZerBXjLWVVY63P86kWlW0X7J3NJitA3j6ykEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eKlv0PJ4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CC1606A31B;
	Fri,  6 Nov 2026 01:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eKlv0PJ4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E4861F0089F;
	Fri,  6 Nov 2026 01:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793927303;
	bh=o15vljGBPrSpL6tMsJUEx5VdBCBrFc3GWWO7AUCavZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eKlv0PJ4nSS4qNLgELPDMzv0j+nfNuim5X8z1T9q39haF7J6fKy0LDjwoQY4hKCpf
	 fG5ozCC1vmpXNzqHinwk3z1P5OEX3Aq8IHwpy8ooneik6e+xd8An2RRUmeyiyMDSUv
	 QJdtwY7eogm5qP11enkOnLaIkiXmFGG+Oi22Xa5otOOrVjy8LBQxfo6dINM4HFZfJ0
	 Th5hXodoj0PbDNFQveDNgj9HjI/h6lZ1PafW0JxjZ4qfFTAudhUNUuvXQ3esZ3p1wl
	 c4YVRiRuC3g3oatsyXM5h19dUzKi0fE7HqWOrjZHgz2GpyXCQeoaCJ24wsQzzT+usT
	 L10FfxLsfqhmw==
From: SJ Park <sj@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Hugh Dickins <hughd@google.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Nico Pache <nico.pache@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Usama Arif <usama.arif@linux.dev>,
	Kiryl Shutsemau <kas@kernel.org>,
	Zach O'Keefe <zokeefe@google.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Chris Mason <mason@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/khugepaged: don't map folios that are not uptodate in MADV_COLLAPSE
Date: Thu,  5 Nov 2026 17:08:15 -0800
Message-ID: <20261106010815.96125-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261105-set_huge_pmd_uptodate-v1-1-a78d8a1b7117@kernel.org>
References: 
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

On Thu, 05 Nov 2026 19:16:44 +0100 "David Hildenbrand (Arm)" <david@kernel.org> wrote:

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

Makes sense to me.

> 
> Fixes: 34488399fa08 ("mm/madvise: add file and shmem support to MADV_COLLAPSE")
> Reported-by: Chris Mason <mason@kernel.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: SJ Park <sj@kernel.org>


Thanks,
SJ

[...]
