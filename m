Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FC244E67A;
	Mon, 17 Aug 2026 16:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786984203; cv=none; b=qHaDM++a8sQyjnDUeMxWS4uvkcecDU+u9rGC2PHNNv3KrN8OW0hxOzayRYoDQ0pQpmfb8Psbtz2xffNBhqkh2H8JaFMcQnq5qaDPi3s0UGaUD9jpJ+FZobKnGi8CzyrnpRjmbOaucNsvEGGIL2ghYhPE0ljSjVK7QXoiJN3TGdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786984203; c=relaxed/simple;
	bh=SSt6Jc5NlsZOhtaj7jirxeAg2gOOIvG336WvTpXoGlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qfkbrrKsPZo2Ltsg60vG0fQlE8a10OtSY8GiOGQz/EL4TeHlRj9afp8hsmiQb0kQ1hc4nzC1dQCmHSOW0sBio3Js61v95ia16yDyM7Ks8KZzNxl7D7CM92lXjHI0aUXyH/NXZC7LDwyRrVSsSdGEQ1eTZ9hbxO2eZAjsuu64oL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VwOEf1yM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VwOEf1yM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E011F000E9;
	Mon, 17 Aug 2026 16:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786984201;
	bh=SSt6Jc5NlsZOhtaj7jirxeAg2gOOIvG336WvTpXoGlo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VwOEf1yMXe96Q8PKjzX/91j8sVh665aI2y+5Y0LVVlTqa59ZzxnsqpuiV+lPJh7xy
	 hp/j6q6dCpnWBF4zkNWvuAWUVRGK77NUas9YyofzOEjg99k82gtnT3w5fzYDTpHE13
	 whYrmxu1KdPAG2BxjYzcp/UnAHHSxLFZ6/4iHV5+b7QlNB5vGNyLuanxXGX9WI4+N9
	 GViRqRz1c5jBvZZD656cAKEfaTcLGC4LABq+Bo2drpmytDMH0pSzgqTMfXVs0EcXor
	 b5oySlCYcDOxKEuwP+ndAMV+oJJpalzCLVBUoUUlTTrMtYOXb8MMzn3V1lve66+718
	 JFDYkl7W5qwWg==
Date: Mon, 17 Aug 2026 17:29:42 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Vernon Yang <vernon2gm@gmail.com>, akpm@linux-foundation.org, 
	nico.pache@linux.dev, ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, 
	lance.yang@linux.dev, usama.arif@linux.dev, zokeefe@google.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, Vernon Yang <yanglincheng@kylinos.cn>, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2 2/3] mm: khugepaged: fix folio is used after
 pte_unmap_unlock()
Message-ID: <aoM10Z0wAKOMzsEO@lucifer>
References: <20260815051924.194810-1-vernon2gm@gmail.com>
 <20260815051924.194810-3-vernon2gm@gmail.com>
 <aoMynfFI2XK2UXXN@lucifer>
 <cd555188-2b51-4559-a315-0e8af6b2572a@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd555188-2b51-4559-a315-0e8af6b2572a@kernel.org>

On Mon, Aug 17, 2026 at 06:20:02PM +0200, David Hildenbrand (Arm) wrote:
> On 8/17/26 18:11, Lorenzo Stoakes (ARM) wrote:
> > Same comment as 1/3 I don't see why we should be storing a pfn value used
> > nowhere else just for tracing.
>
> I prefer it that way. Even if just for tracing. :)

This is moot because you have to store the PFN for lifetime for museum-piece
architectures.

But anyway FWIW:

Yes I agree accessing a now-invalid folio isn't great, but the reason I dislike
this pattern is that you're tracking this state in a different way that now has
maintenance overhead (if anybody reassigns folio or does weird control flow
etc. they must now update 2 things and etc.)

For the sake of CONFIG_SPARSEMEM and tracing for a value that is not at all
intuitive as to what it means, that's not great.

Let me go back and review this again accounting for the lifetime issue that I
missed first time.

>
> --
> Cheers,
>
> David

--
Cheers, Lorenzo
