Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A3C524AE3;
	Wed, 14 Oct 2026 15:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791991368; cv=none; b=I322p/PH1dMCotmUH5cT31djaWcQ6cPlBtY1UQ13sRbZktM7yqFG8NZczeHwBVEVuB3f4S97scvYqlhn7166lNJn5ikVn8uDnVtiW5qozdGnaD+pV19G8uOS0V85VQboGVVgqTXb+MWOgHH5gi6Wt2vfmRLV5W+dqxzYSrlmD/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791991368; c=relaxed/simple;
	bh=z4/KILe9h6AG65fvMrS3TzrPnhmDDErK68zn/OTZ/DY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ehgQYBEKhck+ccBUpWq/1QmB88Dz0ATiycunBMTHHFYfAKeSbQo9E7IHVgWR6RyLIZQYuBgw+9IQTwMsgcffQQdGqZZLO1v1K+SnJIUge9x0tfgfHNBtVqERx7efdt3HBLfmVZDRimlFFF9x5xJSnEJoyoED78V6lr6CNXvX/Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JF2RXRnO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JF2RXRnO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB2F31F000C4;
	Wed, 14 Oct 2026 15:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791991366;
	bh=z4/KILe9h6AG65fvMrS3TzrPnhmDDErK68zn/OTZ/DY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=JF2RXRnOGOF9KlVthYBoCYRl108o9cSB4waUMUnVVRyDfmlN72nuxyg3aLcSU6tLs
	 JGcq48E8drHDplsNvn9c2uns7JAb15bDbCGcRY5huhnxMsIkf84tY5YwBp2oLDXwQJ
	 g2zrxmxSTF5CbvXzr4C0CJ57g4SiFPOsaeBwf54MYCpn4d8SYfbSymoEC29hrtTo9s
	 upAIzSb1wZWm0W8pau7PJjA6iRmIvpEAaoCkM8x44UMEqqKe+gWhaaMB/ZSJSWuPQK
	 9xs9gQO9VQYA9vEgFiIKQ3Z8Lew7pyKzCnt/b9ZNiqK6SjyY8F2dtZf3VEAFycnl6t
	 oQp58CjlyzjKg==
Date: Wed, 14 Oct 2026 17:21:41 +0200 (CEST)
From: Imre Kaloz <kaloz@kernel.org>
To: Harry Yoo <harry@kernel.org>
cc: Vlastimil Babka <vbabka@kernel.org>, 
    Andrew Morton <akpm@linux-foundation.org>, Hao Li <hao.li@linux.dev>, 
    Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
    Roman Gushchin <roman.gushchin@linux.dev>, Jann Horn <jannh@google.com>, 
    linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm/slab: sample slab_state once in
 kmem_cache_destroy()
In-Reply-To: <as96u-sh8BbjXW24@thinkstation>
Message-ID: <d1579925-2067-5a7d-8f30-fd56ccf89c26@kernel.org>
References: <20260930195110.13296-1-kaloz@kernel.org> <ar5pESlkEMqNsgxv@thinkstation> <aef97b97-0bd7-d720-7f59-8c0078747370@kernel.org> <as4QhUscRVtBzYpm@thinkstation> <481e9a16-cd30-d463-14ee-b5602bcd5a21@kernel.org> <as4q2WlR7mLhMBpG@thinkstation>
 <e4184209-75ee-929d-0103-ca15d5886000@kernel.org> <as96u-sh8BbjXW24@thinkstation>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

Hi Harry,

On Wed, 14 Oct 2026, Harry Yoo wrote:

<snip>

>> So it takes both. The read that hurts is the one at release time,
>> after rcu_barrier(); fixing only the double read keeps it, and so
>> does moving only the unlink check under the mutex. Reading once
>> right after the unlock didn't trigger it, but that is still racy,
>> just a much smaller window.
>
> Thanks for verifying that.
>
>> For stable, as far as I can tell the release-side read has been
>> outside slab_mutex since d50d82faa0c9 ("slub: fix failure when we
>> delete and create a slab cache") in v4.18
>
> For SLAB_TYPESAFE_BY_RCU caches, yes.
> and others since 0495e337b703.
>
> I think Fixes: d50d82faa0c9 should be fine.
>
>> , so that would cover
>> 5.10.y. The patch doesn't apply before 6.12, so the older branches
>> need their own backports.
>
> Ack.
> Are you willing to backport it to -stable kernels as well?
>
> And could you please post v2 with updated Fixes: and the
> commit message ;)
>
> Thanks for fixing this!

Sure thing. v2 is out:
https://lore.kernel.org/all/20261014150844.8536-1-kaloz@kernel.org/

I'll send the backports for 6.6, 6.1, 5.15 and 5.10 once it's in
mainline; 6.12 and later should take it as is.


Best,
Imre
