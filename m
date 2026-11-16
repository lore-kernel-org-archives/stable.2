Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794844649;
	b=g+SBel91zhtLNPHD9Gzz74qqMW2VwNJCSRDHhR9EW9aSHWhBg6RBhX5b+jVSQ1mzamnT
	 kbllE7J/8jbmYElDJS46jSN17pgzWjxsD/1BzxjP4RKFVyzlkSDxQMpqeh3nG+EjRp/U6
	 imHWcWTt9EebHzsj1m7W2+7himWplXgPWZAVZfgybP1CTg3sQbCFwDGBJDqAn3c9XJ0Iq
	 4oYGvV21MtP1U3QSdgaeejiyXxv7mPRtNB1dQ3PSOgtZgnwIEfjfYMV4ayzkpcTTcXV0K
	 wRGy+xZ19nXkIWtLHQawYzKeTUGYDtkpi3JMhHUCr6veSaKwmp5sdydTe1hwUIpDYtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794844649;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=Ko62fks3HdUFJERJbaidaf8/9NyAdqZsfNsy+M8rI7E=;
	b=EojgrPMI0yReo5asjUC1Ofq2Q256BPopcPyyPS9ONkk/TSJ8V17MuB6XBMw3p/sle53O
	 70N/NrJU5m2xd20RgvLSCA0Qlp3LTTz7ThUPd27ZrxkFyAkOrs65Bc0LNR7pvSvhGPtqJ
	 9QRGBfgyaZrAAT/bN++m7j9BUeT1TMRnXe1TMW74HlzeVOKPEUGwHXKBOdYXfu/RGFd7W
	 /5G/PSbPFHfRHQ7SUROYj3rBdlxWGpUmLfjwVizjoSX35/OkoL1aukMha9J2XewK17lBr
	 SoIv1pH7+YyKI/bXx3QYt7WNGn3zcNlfFfkZ6swXySDCg46R92dUbLPso9msoe7vm4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="bz/YgBxq";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9ED1606A31C
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 15:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bz/YgBxq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C86C1F000CA;
	Mon, 16 Nov 2026 15:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794844649;
	bh=Ko62fks3HdUFJERJbaidaf8/9NyAdqZsfNsy+M8rI7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bz/YgBxqC7bQ6A5vwCn5B5zt8h6Vujoe/s4NX9IUNxZh3fgAsCK4uoO92CIfIZodX
	 kCHCtnQpCJPewEGp8sCK8Put3td3e6idPHi8n+tnmPeJEhQwPFr+fzL0Ldpp4EGeix
	 2LFYhlEQfl/ZnYrdXRk+b6iAbzrwzpZB940T2IG6F+lPt7Q7WlNeisA/APYuquMWj6
	 opFt9D/6uS81vz2l/5/E4H7+OOZQeP/VAYuZd0bIoJEOAgh821Q0j+rsVCnWUmlUq8
	 e+AlIoMnw0qtbwIg2gMVprZ08pHnkXN7RbveuRMAsBr7HSyqXD4WgSYALyDbBY0hyp
	 oMGpAbvsyHMxQ==
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfauth.ams.internal (Postfix) with ESMTP id 0D09E198003A;
	Mon, 16 Nov 2026 10:57:21 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 16 Nov 2026 10:57:26 -0500
X-ME-Sender: <xms:4Sf7aiLjdYKlrGwpeD5NINDxohS2dJ_lyTrpJIZoKMOgstVJOBStlA>
    <xme:4Sf7ahgH744rwVK1EyjuOymivLuQfK5MtgaGG2x1LQrUmvqUOMtgTPwdz4UeaAgoV
    mnNgeE9xHqwQicjv0hGgIPb3mwB9uYEMGPbnTUFjCL9AsbXDnhTp8vU>
X-ME-Received: <xmr:4Sf7auvitGg7ZB1hhgLqrZCYGhCBvjsH_dmqXCr8m6_tK6n364wcwa7PROU>
X-ME-Proxy-Cause: dmFkZTGKqzOa9mbkYud3YjoAdT1iCdWHe+MpJQTExtWEpMQAweCMisAu2fcJvNFVrlprJb
    kBiEFF59rEPiAv0vQT4Psar852PZawWsc9M4fGFjohDuxRFin/4q/+8xyQWAbSrkwljSoU
    4rmE+DxE3v+h4LMCrsrqmslUmtHuwueZIa2ex6mJxDPKhC8iaNtNx+7O6aMCXO7zzBmfHx
    SK2XAafreqbFzSu3BJmjGtAd1nt5pcnYgA3x9ja943Y/8VPDiEIGf4si3MQObEeu/3Uz09
    e6p8vXN5Zm+usMe6EV+LZjcFFV9n3iaDNu4UXlB/1Ra30F4Be3puKVA6MJJslCgy3U+dR8
    h0tt9LphgI6AFChLOB+pzUimlXAQL2YO8wShOx5UD4yUyHhCVpF0Es6BqRZwLYi4rqv8zR
    PRfWc2tU2QeZrKAtOgj8cyweAiXt7AVId6Htj/5KppKUt+PZi3Rhuafxtn606pOXABoLbA
    LeKL+j+OjGLLawrQ6H0o8Ww8cPUN31NT8vdtgl0MhAo3SFQWbk1CG4+Npb++EscEFEg5nF
    Jh3R3hst54wGNCqm4n4SN7MCfqlwgstgFtpDPqcieM9sOwUKcAAj++yBpCq8lzzbSrvCky
    JPz1YWZRrQreS18C9iqQvEh4a23aft7kLtIX6nKoig1yVAoty/KS+2PMjjKA
X-ME-Proxy: <xmx:4Sf7ahBVDQeYIVmgdYsjLp3PoRjrOXsf1QJ4cqhnAErySQkuV7EPIQ>
    <xmx:4Sf7aiyQOxPSozr2n08Wd5Kl128TA_4_GRsAD5i0keFqMufCrZuEEw>
    <xmx:4Sf7akHHlkjsc6O07PEaiyz1kXBJxcZwU86lQjOuhS9CSiD2Aw-Adw>
    <xmx:4Sf7apZPOG-7JeZlVXQ8JfqtZTaZacy_nWH6gOIKrBMWoDEAuCyWRw>
    <xmx:4Sf7anitX5I8YkETpY_ueCUQE6nswoO6qv3Dje7kUNQrHIUmpJOoADB1>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Nov 2026 10:57:20 -0500 (EST)
Date: Mon, 16 Nov 2026 15:57:19 +0000
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
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
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm/mmu_gather: delay rmap removal on UP as well
Message-ID: <avsnsRqHQIgeSf6W@shutemov.name>
References: <20261116-dirty_file_pmd-v2-0-571883053174@kernel.org>
 <20261116-dirty_file_pmd-v2-1-571883053174@kernel.org>
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
In-Reply-To: <20261116-dirty_file_pmd-v2-1-571883053174@kernel.org>

On Mon, Nov 16, 2026 at 04:06:58PM +0100, David Hildenbrand (Arm) wrote:
> Commit 5df397dec7c4 ("mm: delay page_remove_rmap() until after the TLB
> has been flushed") introduced delayed rmap removal of dirty pages until
> after the TLB flush, so writeback cannot clean a page that is still
> writable through a stale TLB entry.
> 
> It skips this on UP, because on UP there are no remote TLBs (single CPU)
> and because the PTL prevents preemption.
> 
> The PTL prevents preemption while removing the rmap, but the local TLB
> flush is usually only performed after dropping the PTL.
> 
> Consequently, after dropping the PTL we could reschedule to another
> thread of the same mm, which does not flush the TLB. A kworker could
> then run into the original race with writeback: it cleans the folio,
> but the other thread can still modify it through the stale TLB entries,
> and these writes get lost.
> 
> Fix it by simply not special-casing UP. Now, only architectures that
> select MMU_GATHER_NO_GATHER (s390) will skip delay_rmap handling.
> 
> Fixes: 5df397dec7c4 ("mm: delay page_remove_rmap() until after the TLB has been flushed")
> Cc: stable@vger.kernel.org
> Reported-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Link: https://lore.kernel.org/r/avrxOt_GyXLXNqtR@gremlin
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
