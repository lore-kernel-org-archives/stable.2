Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793017851;
	b=FWTC1pVfWKdEawjkw84TC0oJN6+91Vphw1RkepZ9+VzHTJeVO95+WA6FXi7k9K9RaKSW
	 5pnZFlXo4Z/2RT1vfl4pQF6rK6WPOh5MVnJBAWU2B1lLiJX5ym86XvDviGThNejKiHqm+
	 aB5pzYKc1hqzXWplL/hHPKrdbaa7XyLPVHBFTZzWZI0TTt7HewfBzOSMNcLe8ZaOuL5aR
	 806ZGx7F/RdA0mp0MjC/BwEhnCiKvcycBbnTP1toNySQSRsZlK7IHgEBOeucax7OYpHw9
	 DmSzxHBQ7fDjMPJNBY0WtRY+HmWRpT9CuEyfp0KJUzNnLlb5nU1AmgafJA4e+K4G88Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793017851;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=TRZt7x37p8LUgQOIpKaz3b3988dBzwRGltnd5ZVeEBQ=;
	b=G41DU1QSAd6rK2iQYhxGigKpSfVVx5WVHer2nL0G38YyjHMH0f79iOGwhA7HK9xbAc1o
	 yRR5uolyYz5B8HDm+Fx8r0weaIW/oytUfS0BzSm2iadt6xxzwliq0r4YYNFLotXxnvNW8
	 Zko9M4c94Q2+yux5ozqyjj78RsUGEQyE2R3am4l5CmnArlYUTgGaWtYZN500KKyFbxddA
	 MrMv3owNGDGzMyAn+HFDFN4MgOEnbux8Jk+Bfg5uODzFUbiDUkuEQSpfi8i75qX147+6G
	 1b8SuuTFKhFdf+xGW9mvQrDI+VTidlBnfyUNzfsy739r4+w5lw9hSSSTI1eGmqEk14Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=a51umk1S;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8EC0606A31F;
	Mon, 26 Oct 2026 12:30:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8EC0606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=a51umk1S
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F3F025DF;
	Mon, 26 Oct 2026 05:30:47 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 16F583F7B4;
	Mon, 26 Oct 2026 05:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793017850; bh=X7sXgG5KeOSy1aHvYxzPYxQhid9EVso1C+EnXtpcXiA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a51umk1SJn3Qg0uasCVQzZnOrDFKghUAEP7EkrWFXdPPNFIMzLLrV9N8cjkr3aGKF
	 z8GG4zNZ3Tm/0q6VoX6Psp3ZxfySUkB3fkJWOhbNWs22m0DRA+otCMqkcURphbPTl5
	 fFeWa3OFzRFlj5VqI9kqkZNToJ4SuBOlO68fncXY=
Date: Mon, 26 Oct 2026 12:30:45 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Zhao Gongyi <zhaogongyi@bytedance.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, will@kernel.org,
	Ryan Roberts <Ryan.Roberts@arm.com>, dev.jain@arm.com,
	baolin.wang@linux.alibaba.com, lance.yang@linux.dev,
	mark.rutland@arm.com, akpm@linux-foundation.org, ljs@kernel.org,
	liam@infradead.org, vbabka@kernel.org, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com,
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] arm64/mm: restrict transparent contpte mappings to valid
 PTEs
Message-ID: <at9H9Vkx57pIcPos@arm.com>
References: <20261013093600.54995-1-zhaogongyi@bytedance.com>
 <daab2f45-56c2-48ad-a24f-aa4f889e4da2@kernel.org>
 <e0f60526-bb95-4d39-9a7a-72cdf32ca5b6@bytedance.com>
 <cc2e3af6-bb56-41b1-9cde-151797c3068d@kernel.org>
 <3b57c214-6a43-4fc7-a531-fb5eac196465@bytedance.com>
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
In-Reply-To: <3b57c214-6a43-4fc7-a531-fb5eac196465@bytedance.com>

On Sun, Oct 25, 2026 at 12:00:33AM +0800, Zhao Gongyi wrote:
> On 10/24/26 4:55 AM, David Hildenbrand (Arm) wrote:
> > If we have the spare PTE bit, why shouldn't we just use it?
> > 
> > It will make batching over PTEs faster. And we care about that for present PTEs.
> > 
> > So I don't quite see why the stable fix couldn't just do it right away? Do you
> > have a prototype that shows that it would require significant code changes?
> 
> I tried a small prototype that keeps PTE_CONT on present-invalid PTEs.
> It leaves contpte_set_ptes() unchanged and makes contpte_try_unfold()
> recognize pte_present(pte) && pte_cont(pte), instead of checking only
> pte_valid_cont(pte).

I think it's worth doing but currently not sure it buys us much unless
we also change pte_batch_hint() to cover such entries. However, if we do
this, we need to audit the other pte_valid_cont() callers (e.g.
ptep_get() needs updating as well).

So, if we aren't going to change pte_batch_hint() as a backport fix (I
don't think we should, it's an optimisation), I'd rather take v2 now and
continue with a proper pte_present_cont() etc. patchset on top.

-- 
Catalin
