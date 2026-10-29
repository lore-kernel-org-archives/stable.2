Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793253891;
	b=d2ukWcGRWxElZHHhYjKjCAjYpWnJchQ8pG2UaUrKOlAVwd7IhKj1L96uRntwjlDVRCwZ
	 02VpZ2awHQYGND9col63jCMZlveAykechzuSmiE5Y1Ry14eo2RW/YNe96+/rDD9vlDhAD
	 44qpsB5N3hAOst7xwvFpAHuz9GDiCWCgcTjwOC2vNRF0c+XYoX4u0dHBmGT4e7QmUJu3Z
	 Ekg2pxULo7eI/eeeNIPPs70gsS9InuX/2er7DsVXpGMqoXgg0TTFlK92ncIqMRJaemqWJ
	 7MkdaPn1LIoJRIH06J8ezbzR08Lg68/V1VxQakEXYaWInnuiipBeUhKycTAL1XGBz/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793253891;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=o5W+Zg0rKLU9ViJ7Akn7TYVqUItF04jnCP8SftoaDZs=;
	b=aNH7LRtiboyz431UEc+GeoA5MPuQWlUVUT/Qs8iF3yjWimfwxp5YmQ/NHOj8isq5GT5n
	 acgDU/l+rIUu1/8G3DKbKQrHtBJaIMVxN7UW7qSlgoezH1kB29IElcaXQON5V49J4dUIf
	 plYZYWB9+Moq8aPd+MLomyLxtfttJdWDf0ClkR7kKXpWFzlV04jo3/L6G95ePOnGBqP/o
	 xkoutVwvRHIya78QXYYsvByLK9Q1h9Y6TjWQGeLewRri2oFQ1IL4J4uzWrn20X1PgKNP9
	 wXLxY/XTbO4cvBz7ixZBc+gE/HT5pg4z5KeNL2XsyFPw9dPEBvgtzDYumkcxxIyVvuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=j0QcXQXk;
	arc=none smtp.remote-ip=115.124.30.97
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F52D606A31A;
	Thu, 29 Oct 2026 06:04:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F52D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=j0QcXQXk
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793253886; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=o5W+Zg0rKLU9ViJ7Akn7TYVqUItF04jnCP8SftoaDZs=;
	b=j0QcXQXkFYCz4D2y+n1xiXPtYt7YEd2o7we+zZfrWreRsLO/Aul+bxYwW11InGmNbKlsacM40s2+E+b3aY11VCD7NbRZoovW2/xCab+IZD7p8phEabN/uVxL1BkyZWsYUpNgUYFUTMS+U8aDDbig/0spePvGNDwrgPuKY6tWjbE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R611e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0XDiZY8B_1793253884;
Received: from 30.74.144.149(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0XDiZY8B_1793253884 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 29 Oct 2026 14:04:45 +0800
Message-ID: <6e0968e0-e061-46a4-a7c4-be27aad91827@linux.alibaba.com>
Date: Thu, 29 Oct 2026 14:04:43 +0800
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
Subject: Re: [PATCH v4] khugepaged: fix readahead lock inversion in
 collapse_file()
To: Lance Yang <lance.yang@linux.dev>, akpm@linux-foundation.org
Cc: david@kernel.org, ziy@nvidia.com, liam@infradead.org,
 nico.pache@linux.dev, ryan.roberts@arm.com, dev.jain@arm.com,
 baohua@kernel.org, usama.arif@linux.dev, kas@kernel.org, jack@suse.cz,
 djwong@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 hch@lst.de, pfalcato@suse.de, ngocthang2710.1999@gmail.com,
 syzbot+16bf7cd0ebeb1de93aa5@syzkaller.appspotmail.com, stable@vger.kernel.org
References: <20261026152013.10511-1-lance.yang@linux.dev>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20261026152013.10511-1-lance.yang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/26/26 11:20 PM, Lance Yang wrote:
> collapse_file() can call page_cache_sync_readahead() while still holding
> source folios locked. If truncate holds mapping->invalidate_lock
> exclusively and waits for one of those folios, readahead waits for
> invalidate_lock and neither side can make progress.
> 
> We need to release those folio locks before starting readahead. On a page
> cache miss, roll back first, populate the collapse range, and retry once.
> Doing readahead after rollback avoids an extra pass when all folios are
> already present. If another miss occurs on retry, give up rather than keep
> retrying while truncate or reclaim removes folios.
> 
> Keep page_cache_sync_readahead() and wait for read I/O with
> filemap_lock_folio(), releasing each folio before moving to the next. The
> existing uptodate check during collapse still handles read errors.
> 
> Shmem uses shmem_get_folio() for swapin and fallocated folios without
> taking mapping->invalidate_lock, so it is unaffected.
> 
> Reported-by: syzbot+16bf7cd0ebeb1de93aa5@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=16bf7cd0ebeb1de93aa5
> Fixes: 730633f0b7f9 ("mm: Protect operations adding pages to page cache with invalidate_lock")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lance Yang <lance.yang@linux.dev>
> ---

Thanks. I'm fine with followups to clean up the code.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
