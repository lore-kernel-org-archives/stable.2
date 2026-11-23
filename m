Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795398111;
	b=K6DuBSTzcPvmWTEvF4oCWoR2XRzLNuftBL9plWn3xk38zw/nVJcYx+4hV8LxgU1DxZMZ
	 UagdY1XJWGD64PHDvAY6f3OwOqgyUyPX1Qqne51g3rEyDtVFEEdWcMnMYBUtPoPfAaT1V
	 ep42dwHquOggqsnrAZuyW+hk58CfHseZuvL89/dMdSRGVbD41GlI0aZjfl3cJcGmWhRsT
	 RsMt07WMrb7dFgfI05E2grWaC0flnTR+JA9Vvd0CGa6FaIhVWp4CiHiLIHW9iwXWLTD/F
	 RoMrC91/0OTXg57vPhrLBkJMhclsWuIatVrG2YjqeJGabw/YeOMP2aM78J535gcI3sA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795398111;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=Z9jlXwi4tHZJCnx1nQHaaW2a8Tr/fjKN52qDHg9VT74=;
	b=c05VnPcMh20OlMn6s1gFdlJnebnyPqDz6vuZsaNGunBlRf/h+x0dxUjOeiHsn0a3flSN
	 cGi6oZ94v08sjtguUjVqw3ebdmtLmhznhIDXstIxUtlcAiUApERArY5kLrWiND8LZ3Aw2
	 6t8Z9wgu3K1A8XIq+HD7z5dBK3g0SxllsPxcErNugHRV1fP8KmPGJ6FycgK/NJQex99zr
	 F8UjTUzHOkZmqjVhVSsaGFmPqvWIxvvrL37bNIq3SwLpeTrLOht7n58pa6eSZljkrJ6lf
	 yl/+mnpPx7zMuJuU7f0KqrzNxV/R9L7yQ0+8LFiwTWL+LUhK8Dt9AAZsTX8D6QEY+AA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=sBQpjXnl;
	arc=none smtp.remote-ip=115.124.30.111
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCBC606A31D;
	Mon, 23 Nov 2026 01:41:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CCBC606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=sBQpjXnl
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795398101; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Z9jlXwi4tHZJCnx1nQHaaW2a8Tr/fjKN52qDHg9VT74=;
	b=sBQpjXnlh4t0gcuKgQoP/Lia8cQVdOpG29UX8omVbik/pF/j0tYuiR0ivh6eq1tFOpuQD+eFNaiBEwg8pc7iE7aaulHrFOT9Ml3FAtWgUhXk3Bq6hgPN5YssmMGneI7luM21KXkI9wtMoVSfU0fq8E5+ZUaXydZEUXEVY23tHTE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0XFC3KBS_1795398099;
Received: from 30.74.144.153(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0XFC3KBS_1795398099 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 23 Nov 2026 09:41:39 +0800
Message-ID: <1a5563d1-6f72-4530-935b-975bd3674ea1@linux.alibaba.com>
Date: Mon, 23 Nov 2026 09:41:27 +0800
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
Subject: Re: [PATCH] mm/memory: don't map hardware-poisoned pages in
 finish_fault()
To: "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
 David Hildenbrand <david@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>,
 Usama Arif <usama.arif@linux.dev>, Zi Yan <ziy@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 stable@vger.kernel.org
References: <20261119134236.3745231-1-kas@kernel.org>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20261119134236.3745231-1-kas@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/19/26 9:42 PM, Kiryl Shutsemau (Meta) wrote:
> When memory_failure() cannot split a large file folio, the folio stays in
> the page cache with the poisoned page in it. do_set_pmd() refuses to map
> such a folio with a PMD, so that the poisoned page gets its own fault and
> SIGBUS. finish_fault() then falls back to PTEs, but maps the whole folio:
> 
>      do_shared_fault()
>        __do_fault()
>          PageHWPoison(vmf->page)
>            // the faulting page only
>        finish_fault()
>          do_set_pmd()
>            // backs off on has_hwpoisoned
>          set_pte_range(vmf, folio, &folio->page, folio_nr_pages(folio), ...)
>            // maps the poisoned page as well
> 
> A process that touches the poisoned page takes a machine check instead
> of SIGBUS from the fault.
> 
> Map a folio with a poisoned page one page at a time. The poisoned page
> then takes its own fault, which __do_fault() turns into SIGBUS.
> 
> Fixes: 43e027e41423 ("mm: memory: extend finish_fault() to support large folio")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> ---

LGTM. Thanks.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
