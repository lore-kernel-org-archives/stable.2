Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793021985;
	b=FPQimlQp12dDaCwIvGD4HtuxcaW/3pHMDTP82TMcT0KOwbnZM6zPb8bjXWTbuK698fgk
	 IYUl1lsX6zOk59wd+niTswzpK5mujY6uk0n3Kdz6NrOhVIMjzqSjLX46SdxJNIZM1bS7l
	 OhmKYGGv3AiVnEyNgTM12nJ/QifZriYOuoBFrf+yr8XaTt0CyYb2dCBX3FE2sdxh1qkND
	 WckciVqc2XI8xovuueoPEaoGMqmvubHdh0lqemU209t2jJRoo4f+1zuRI2Qq6xeZ336O1
	 swKfA4smzeyF+IACUkbhqxM9wLVqWex59uY9RysyxGuC/recc5msSMBZJlZK7gLMlXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793021985;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=+29/JeDTgI2q6Zdd2oPF6MhnTmquWtxwp3oevCRZyMI=;
	b=Z4JKQNR0yYKTIclB46BXsZSrEzdhkxnvJMxi/6wwwS4Id4NJJC+w9JvS7RkA3xsHqzYT
	 mLZ5aVf5l70QTaJc0/waliH4LJM5k+4E0M5gCy0bw32py9pho5KUgj9QKfzirrwkc7LuX
	 8QJDeVSImsaXiuEDMAXrFajI5XjkH/xYC4U5TJxou49srKll5rBrGicO2b8yhmjH6CoeP
	 iWNSq9ghJFKoHz20AFyiCfl6qGr1a0px6m4nTAzP4xIKOLqzKTshND51jrLIOvz433VBK
	 HZmmqZRGycP5nCvrey61p3f3LyrXI1tVHZRweHDxfTa+hOUKQdlLlTwq5Lsun/StIhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i5V4VCQr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1B3606A31A;
	Mon, 26 Oct 2026 13:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i5V4VCQr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8DFA1F01825;
	Mon, 26 Oct 2026 13:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793021984;
	bh=+29/JeDTgI2q6Zdd2oPF6MhnTmquWtxwp3oevCRZyMI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=i5V4VCQrdHU+uG2pJYqRPhqkSzGsM4xSLU1XJ0z+Tn+sGBvGl6PS5AjTKVdmcv7K9
	 UfzYyrhEX+CTogKDpTIY8lSfX1ObveUxmAkok+oz+mpAYPvI8fHZHyt0umP7bvrRHs
	 BeNRToBTnOZoQW8aS/ryia3YZ/4UTSkJso5hJLv3xJLZ2C51/dd1tulN+/RHimZul7
	 DiXbkdNPUq/Nv5Ktmq35EoqixXG6MoyeZZg4wNF0PxRH4sBVkkbdL3yOv4vcKZi4tz
	 BpWuka+s9hoS3MQ0yrRcYrO7hYd8o7kThsrGemf08Ua37ljn+RT6XbUviQ0AeCcBh0
	 YvlSe4qWWm1Sw==
Date: Mon, 26 Oct 2026 13:39:39 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Ngoc Quy <ngocquy0700@gmail.com>, liam@infradead.org, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] fs/proc/task_mmu: pin mm_users in do_pagemap_scan()
Message-ID: <at9YDZXEccL0a1Pn@gremlin>
References: <20261014095540.3261469-1-ngocquy0700@gmail.com>
 <20261019174659.42c3529d5e35563cc6e5244c@linux-foundation.org>
 <9aa49812-1132-458e-9bf5-6dba8b476b26@kernel.org>
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
In-Reply-To: <9aa49812-1132-458e-9bf5-6dba8b476b26@kernel.org>

On Sun, Oct 25, 2026 at 11:55:59AM +0100, David Hildenbrand (Arm) wrote:
> On 10/20/26 02:46, Andrew Morton wrote:
> > All looks good and checks out for me, thanks.
> >
> > Except...
> >
> >> --- a/fs/proc/task_mmu.c
> >> +++ b/fs/proc/task_mmu.c
> >> @@ -3231,15 +3231,18 @@ static long do_pagemap_scan(struct mm_struct *mm, unsigned long uarg)
> >>  	size_t n_ranges_out = 0;
> >>  	int ret;
> >>
> >> +	if (!mm || !mmget_not_zero(mm))
> >> +		return -ESRCH;
> >
> > Why the new test for !mm?  The current call chain guarantees this is a
> > cant-happen and the current do_pagemap_scan will cheerfully oops if
> > mm==NULL.
>
> I'd just keep it for consistency with all the other checks in this file?

Agreed.

--
Cheers, Lorenzo
