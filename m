Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794467804;
	b=v2h/NRNYeiwmychZc5Soh3/WpMh1ETA8XCf5qmv50aX+MEiCHwfn478kGQEJ9HaJKAHE
	 DGu0CUnU5BEYIEwspY7u57OUaiHMndcIhaTwCj255YidDtH9M6zRaGvKOEbKb7eNFu/Bw
	 3HsuA474AfihscbVHkDXrKHk0tz1YVZypWHkAMeHEZ+wWb9le3oX1Q613nP41OpbYs/eO
	 zq6+Y1FK+DSEptFjuDN2KYz6ilNolmzJCvT1m4nqGGn3Fy4fdPueTtJ2VE4rmRkKJDGyw
	 LStnN8jsOgh/9DJv+NlgtzUQkMWq1CGl2OQ96iGnFxzFtmSsZ8wy/8H/jqjlkMhfk3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794467804;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=JQI6EwSlsPtuclLjJZxJ5CXmReWwBQ7kHNHZwvtFiGU=;
	b=yaozV637q1Xqa4C3gU2zw6MV0GEteeeDn8JvOC4rP/pLfbQwxljycK83QOSvlLHP06A3
	 uyk78v92OykGM7E+OJ6ircJyx7Z5FPUg2atTCXuV7WufRojpnz+sU1ZC+jyIeOY55yJVy
	 5BlfbwipRxQtcTK3DbMG++tlwOE1CXHBpL2DtExzjUL8P4IFXeMoCoMgUJQaujLE30/od
	 AMSg4mkfyD9kJyFwkdOacE05zcHfm3L5/HxHWU10NvRLP+gazECvnJblkLYkrLIz7Qlb5
	 2qGq5ThMHeQ8snAUYJY65DO5nwNoCPhZGq+0lhxFsrUKE7CrPHx43RabAevpUYt/7BA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=TBBKXB2x;
	arc=none smtp.remote-ip=115.124.30.124
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D805606A891;
	Thu, 12 Nov 2026 07:16:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D805606A891
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=TBBKXB2x
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1794467795; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=JQI6EwSlsPtuclLjJZxJ5CXmReWwBQ7kHNHZwvtFiGU=;
	b=TBBKXB2xxDByYcM5nSZrxxbU8sRjKIthZRlt+F3aR70C4fy+P/+gYfdRsNGTUFv9bKKmDnzgoiT6O5HRREreXsEsZzolP45ddOkvPnnE8f4l46i9weROo1pJvBZIK2x71JBHZV4OotNkTT/YFwugOicfyNUYFjQ7GlBlJtwo6iA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0XEbBZGA_1794467792;
Received: from 30.74.144.134(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0XEbBZGA_1794467792 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 12 Nov 2026 15:16:33 +0800
Message-ID: <08ae2f1d-964e-4f20-a66c-d2ce3460220b@linux.alibaba.com>
Date: Thu, 12 Nov 2026 15:16:31 +0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] mm/rmap: fix PTE table overruns during batched unmap
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>,
 Lokesh Gidra <lokeshgidra@google.com>, Barry Song <baohua@kernel.org>,
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>,
 Jann Horn <jannh@google.com>, Lance Yang <lance.yang@linux.dev>,
 Ryan Roberts <ryan.roberts@arm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Chris Mason <mason@kernel.org>
References: <20261111-pte_table_clamped_end-v1-0-2dbe339c487a@kernel.org>
 <20261111-pte_table_clamped_end-v1-2-2dbe339c487a@kernel.org>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20261111-pte_table_clamped_end-v1-2-2dbe339c487a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/12/26 6:00 AM, David Hildenbrand (Arm) wrote:
> With a folded PMD, pmd_addr_end() simply returns the supplied end.
> folio_unmap_pte_batch() can therefore walk past the PTE table when
> unmapping a large folio.
> 
> Folded PMDs are uncommon, but can occur even on arm64, for example
> with 64K pages and a 42-bit virtual address space.
> 
> Use pte_table_clamped_end() to clamp the range to the PTE table and
> VMA boundaries.
> 
> Fixes: 354dffd29575 ("mm: support batched unmap for lazyfree large folios during reclamation")
> Cc: stable@vger.kernel.org
> Reported-by: Chris Mason <mason@kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---

LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
