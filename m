Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7063374A18;
	Thu,  8 Oct 2026 06:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791440420; cv=none; b=ZQVe+NhWbyGulDwCirT+qUCj7od4tyXD6CkpFvght+KZbbGUZDKFLcD4tIbewXhOuHBEapjYbcS1Y47ESgW1XsPPbiyPFFtnUR/GZyY4N7q6yVPrDdlogNdVLoD9XZc6/5YM4ChJTHqDwsiBKObs5+vD6C3W8PcmKsGyC0+32LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791440420; c=relaxed/simple;
	bh=vwzTWUbUQKatK9wUdKc+TRyb/9Y7s5K2CTPcXxELCMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CvaiVW3d3HdOhR/JxrXTslniyL3tExHB2bT+PiXg/Hz13bDBhC2g8r23BBdXzSa7hwq6vWy27lj3Qxn6E5xPY0XmNGuKWDm/IzZ7RhzAOIpEBYTluac14BLAeVlBhv3/VsWjNOuo6suqkk5W5U5Ir6WEqKVvSxhY2nmrKpI20UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Tuu0Hd8I; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Tuu0Hd8I"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1791440412; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=WBjIFJjH1YSESX6XKsyH3s55ktCin3Q3Ic6wYond1xU=;
	b=Tuu0Hd8IiYOe3SLKD9YPP1Z34nLpz0jLg6AAJEwVPuKyJ/sFp9LBzzyAwr4Wa35pUt2h8j70YmDwf49+7DceoJC0Gs/Knvrrx3S25K+H5EtolY1M4bjwe25lXHnDSTqKVujeYnnqxljWQYETjJtr+cSGuibvVKoVdXY79z+JX8s=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XCKvm76_1791440411;
Received: from 30.74.144.149(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0XCKvm76_1791440411 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 08 Oct 2026 14:20:11 +0800
Message-ID: <fb549f87-c6ca-43e2-be19-ef0bfbc5e085@linux.alibaba.com>
Date: Thu, 8 Oct 2026 14:20:10 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/khugepaged: flush deferred unmaps before dropping a
 failed folio
To: Kyle Zeng <kylebot@openai.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>,
 outbounddisclosures@openai.com, stable@vger.kernel.org
References: <20261007041001.43181-1-kylebot@openai.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20261007041001.43181-1-kylebot@openai.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/7/26 12:10 PM, Kyle Zeng wrote:
> collapse_file() can fail its reference-count or dirty-folio check after
> unmapping with TTU_BATCH_FLUSH.  Both paths put back the isolated folio,
> then unlock it and drop the lookup reference before reaching the common
> try_to_unmap_flush().
> 
> The page-cache reference does not keep the folio stable once the lock is
> released.  Another collapse can replace and free it.  With its PTEs
> already gone, that collapse cannot flush the first task's per-task TLB
> batch, and retract_page_tables() skips short or unaligned VMAs.  A CPU
> can therefore retain a user translation to the freed folio.  This has
> been reproduced with unprivileged MADV_COLLAPSE on a memfd.
> 
> Flush at out_unlock while the lookup reference and folio lock are still
> held.  The common flush continues to cover the accumulated pagelist on
> both success and rollback, preserving batching on successful collapses.
> 
> Fixes: 6d9df8a5889c ("mm/thp: collapse_file() do try_to_unmap(TTU_BATCH_FLUSH)")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Kyle Zeng <kylebot@openai.com>
> ---

Good catch. LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
