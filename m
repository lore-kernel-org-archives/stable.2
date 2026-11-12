Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794468346;
	b=HlZoQyWTm/rk6oriLqB75tJlCyjpmfRfaznrcIFTEcvgijQDT0cgihwKehyetGEiRjsa
	 3go+8BSu+pQTdspbhLiz2Mbe3NCmxrsBH3q4ehiOUos/3EV9SLr6NFWw5BTEgjg3cPdPS
	 xxvoyIIUO9toa1IsRTYXkEyNKZNk9oecy9upMj8hhltdAj6PHicq9STtPTUhkp59PlZjS
	 2iEvWZCUtkwcN9+BR5tIAU4quF4FeNQT/YR6xAx9PU4dFWbG4AtGVjoH9I4dcaFKTjioZ
	 PJ99DIBK2ufR6WCO2lkdtjlekD2+Zjer9EFN0TP2FcrA/uEsT1vEGClH8/JWDoHKPaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794468346;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=gcbzg60BUmwgQefKURo3dOVz/J0aYIf5oGU7VN0hQhc=;
	b=HV8RLdOWFAhZsb4g51WBi+Gp93KsE5Qw6AoIpXoExGGKjiis1rjNZzXr8YfgAwQI+xCN
	 1ztWEiS6lZqD6NIEeHJEV3RXMa/PBsgnAE1/5ewIC+ruEog4UEpiMlMHFg/S6JPRs4u3o
	 3PLig5OOX4AeAo5jHPfcfIzCs9TMu/bc0gSYADVulpn0fpk1uI4ixZMs75efPGpVWSHM7
	 w5+KYw83PjGmeTLJk+hH2fjfNnQ3rAR/VMXNdgfsn1doJhmNS900SQ3s5T/EVd5fqP77X
	 7IwDJaNKanIP9R3xUAF2DEiZv9jMYMdz3MR/5PFMyNWDQmg3tISG7zMTmQ0qxY5UmqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=sXZNwqIa;
	arc=none smtp.remote-ip=115.124.30.99
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794DB606A321;
	Thu, 12 Nov 2026 07:25:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 794DB606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=sXZNwqIa
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1794468341; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=gcbzg60BUmwgQefKURo3dOVz/J0aYIf5oGU7VN0hQhc=;
	b=sXZNwqIa92f9Bzr3TecgccK1462rTpZ9C9H8dYnzMSwCrI5nM6AwUx+asuig7w5o3iH+4xvjrq6N0xVp4pMurfBk8naZH2ISPXYXfjFPXeUHwzTpmdX7ZIUZ/wH9MMHpge8Ref7Ng61AbVIdaXtA7z3mBS3ru4ylQd61k3iGIcg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R251e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0XEbCMpv_1794468338;
Received: from 30.74.144.134(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0XEbCMpv_1794468338 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 12 Nov 2026 15:25:39 +0800
Message-ID: <c31cc8a0-c098-4784-a843-f13f51914094@linux.alibaba.com>
Date: Thu, 12 Nov 2026 15:25:38 +0800
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
Subject: Re: [PATCH 3/3] mm/rmap: fix PTE table overruns during batched
 reference checks
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
 <20261111-pte_table_clamped_end-v1-3-2dbe339c487a@kernel.org>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20261111-pte_table_clamped_end-v1-3-2dbe339c487a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/12/26 6:00 AM, David Hildenbrand (Arm) wrote:
> With a folded PMD, pmd_addr_end() simply returns the supplied end.
> folio_referenced_one() can therefore walk past the PTE table when
> checking references to a large folio.
> 
> Folded PMDs are uncommon, but can occur even on arm64, for example
> with 64K pages and a 42-bit virtual address space.
> 
> Use pte_table_clamped_end() to clamp the range to the PTE table and
> VMA boundaries.
> 
> Fixes: 52e054f71840 ("mm: rmap: support batched checks of the references for large folios")
> Cc: stable@vger.kernel.org
> Reported-by: Chris Mason <mason@kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---

LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

BTW, the 'end' calculation for the batch operation in 
lru_gen_look_around() could also use the pte_table_clamped_end() helper. 
But this can be a follow-up.

end = min(addr | ~PMD_MASK, vma->vm_end - 1) + 1;
