Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792473720;
	b=ttMdPZW7nj6+ewrsARB/jleA+SbH2s8UixrekyQRZsCbYL7+iVJv0IAOuQYv2Dudv2YC
	 07UoyQb2NTRpC6le3pQjV9gW+zXJknXdNGo9feS9DiqE7bdBwSlPu/UUcYOCWsZyyiAHY
	 BLf5DhTSx1NXjr9s4SeHt9qMlriJaa+Ih5oGASQ+0CaF+LJrQe9mNvp5gUA91LdX1xkI0
	 wDGvMycJhiUzsTPzZVhBKMkJ07OT5zKz/lrj67sMZL8u1MODQMajlS7bUHIkHXVZCiyzv
	 zxo3IUxNpFFaAwEpeUzLAgOxi2A2TXUIDmkZZomtbsDc7ZJ04Ez18MbwWhgo5PLL97Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792473720;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=8MIsDqFQ3ihoPCDCZv6W7JkqazHoCN4iCAhc1qoiKLY=;
	b=q36/YOpj98W6bjjaURpl4KFgySDytONvwqmCW9XEgPrrvqMhIz8QQ/rcH2VwWbPQXfKS
	 GqrwJHfJBsMfPLrp5A7o36LwdiOrih79w2d5a2kAwGGJRxVujW1d+ylaVGuaJN+vp6+BP
	 fvjuwVfft4iXZVzDlfXw7ppBWu/lnLkwrNkeJWDAfJl8fZ+/hJ9Iem7wYnMc3MXmQeIV/
	 r/MQJVc8yfHUMvAS6lwOo+JNdPaj4O/FCkixk4FDBfGpG1KioNpxMztQTgkN/ZNKP17V5
	 yTNGEs0cZKV2pTv/uZE4EoTkLX6JtxxO7rYX9bTvd1bl2o+HPqx6sk5eIm+61oEPGew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=nBgmagcy;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C5C606A319;
	Tue, 20 Oct 2026 05:21:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98C5C606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=nBgmagcy
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52A6D1596;
	Mon, 19 Oct 2026 22:21:54 -0700 (PDT)
Received: from [10.164.19.55] (unknown [10.164.19.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3DAF03F7B4;
	Mon, 19 Oct 2026 22:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1792473717; bh=1o8mKDhc+h5Omef+qHo/0xtyFQGZ0v3bKBCuB7AmPEc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nBgmagcy6gXNs2r1qVZzAn2A046/Ya8MlDRVZ4VZN5idWhICsLIq++TgG70EeFiNq
	 ORlW0zUDtNd+geIAAi2Tc6ir6HXcZhsoT/NBksqLegc8kN9ihaCN/9C9MVxoDlOUtg
	 hWmz/Zweg7lkaK0sv34MJs5RR55TwGm5mKk0sZn8=
Message-ID: <bd7c7fd5-8543-429c-8618-4fb881723890@arm.com>
Date: Tue, 20 Oct 2026 10:51:48 +0530
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
Subject: Re: [PATCH v2 2/5] mm/kmsan: skip vunmap_range_noflush when KMSAN is
 disabled
To: Hao Ge <hao.ge@linux.dev>, Suren Baghdasaryan <surenb@google.com>,
 Uladzislau Rezki <urezki@gmail.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>, Andrew Morton
 <akpm@linux-foundation.org>, Dennis Zhou <dennis@kernel.org>,
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-mm@kvack.org,
 Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
References: <20261019054531.87652-1-hao.ge@linux.dev>
 <20261019054531.87652-3-hao.ge@linux.dev>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20261019054531.87652-3-hao.ge@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 19/10/26 11:15 am, Hao Ge wrote:
> kmsan_vmap_pages_range_noflush() returns 0 when kmsan_enabled is
> false.  The unmap side does not, so it still walks the shadow and
> origin page tables even though KMSAN never installed any metadata
> there.
> 
> Add the matching early return.
> 
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Hao Ge <hao.ge@linux.dev>
> ---

Reviewed-by: Dev Jain <dev.jain@arm.com>


>  mm/kmsan/hooks.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/kmsan/hooks.c b/mm/kmsan/hooks.c
> index a706666db097..107f66841274 100644
> --- a/mm/kmsan/hooks.c
> +++ b/mm/kmsan/hooks.c
> @@ -138,6 +138,9 @@ static unsigned long vmalloc_origin(unsigned long addr)
>  
>  void kmsan_vunmap_range_noflush(unsigned long start, unsigned long end)
>  {
> +	if (!kmsan_enabled)
> +		return;
> +
>  	__vunmap_range_noflush(vmalloc_shadow(start), vmalloc_shadow(end));
>  	__vunmap_range_noflush(vmalloc_origin(start), vmalloc_origin(end));
>  	flush_cache_vmap(vmalloc_shadow(start), vmalloc_shadow(end));

