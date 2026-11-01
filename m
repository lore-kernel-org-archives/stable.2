Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793559769;
	b=eC1EvZ/pEzsFLaBe3rpJnqSboEtobUXIHu1xm1n6zYQvl3htLRSjqLtWxy/i7yxK0yiH
	 dVvVO4XFie5zC3NRT34IMX7RVI8tq+i1wdtVq9b1t55tz4gJwfr0LrzV9d58uiXdVNG5Q
	 3YJA5sbbAOdrX654/umSNgTvPxklGYUu/hJDg0+6DRQtkjKwIpB0IfDCSTcQx36pixU7m
	 pB8KePR4y180TiWlJYRtdFvrPSW5OzDSgvtN1AmX9WOfgVbChaKzhL5IEc7IFBVD6PqkM
	 i5QuSwMhVY8Jf2AwPH8UTzZas8b4n0Emt98fTY1oQj8ukUtU97spEaFoLUlLBOsCdeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793559769;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=WggtPILRKQmq1fPsXP3UeL8pjRSJDLX7wsrAkv0vb7g=;
	b=lC2Z4e9pLgK4S30On7p3tGFAMQ18bIehkND6vOwKbl160qnkDA0tFjRe2Yv5B+mUxBaE
	 Z6GERICDrSnUZTUEcTYY556b5l94f5VFoVzTbebn1uIfvG1gweYbpl8iG3ZnMocw78G0B
	 xQOd7fqvegFvu/l/4ccO2B7x9hyKBavVdTwlT6PiInXpGAS9QROe82EQAnVQH3hinV4r7
	 3skS+R/+DwX0hlS6pqSHk61d1IyoH7Ddxj5dIfKrUoQSPwHlstz0ZLTFFgII4fLEmBGD0
	 WBdFvORXBcfTMBACdKkaPc5it4j7qv3nwFHUiZmGiq56xVQFyvjPz2HiOXsq/kmmq0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=T32TZ0K0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1623D606A325;
	Sun,  1 Nov 2026 19:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=T32TZ0K0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 152201F000C1;
	Sun,  1 Nov 2026 19:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1793559768;
	bh=WggtPILRKQmq1fPsXP3UeL8pjRSJDLX7wsrAkv0vb7g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=T32TZ0K0bSUBw8B+3JGLMuQPRUCQd1CschZWipLljnoqd5xMJTLLQfZftxMB5iOFH
	 rKVBvPd66COoJcyapjdR00+vfV/yMdY2Wi2Q6HS7u/nY6XHwz7dxk/V30vL+dRmqxJ
	 av67p5tRMF6Lq3FUQ4psOH/sHMHqSHANOU0Bn+qs=
Date: Sun, 1 Nov 2026 11:02:47 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Kelvin Zhang <zhangxp1998@gmail.com>
Cc: linux-mm@kvack.org, David Hildenbrand <david@kernel.org>,
 "Liam R . Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro
 Falcato <pfalcato@suse.de>, Kalesh Singh <kaleshsingh@google.com>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] fs/proc/task_mmu: check THP exclusivity for each
 subpage
Message-Id: <20261101110247.95a03a5601f235ffb39c54c1@linux-foundation.org>
In-Reply-To: <4c1b393a4b04bd94e4f1c7879ae04e1793eb0931.1793552446.git.zhangxp1998@gmail.com>
References: <4c1b393a4b04bd94e4f1c7879ae04e1793eb0931.1793552446.git.zhangxp1998@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  1 Nov 2026 09:01:00 -0800 Kelvin Zhang <zhangxp1998@gmail.com> wrote:

> A PMD-mapped THP can contain subpages with different mapcounts. For
> example, after fork(), the child can unmap only part of the THP. The
> parent retains its PMD mapping, while the remaining child mappings
> are PTE mappings.
> 
> pagemap_pmd_range_thp() passes the same initial page to
> __folio_page_mapped_exclusively() for every pagemap entry. With
> CONFIG_PAGE_MAPCOUNT=y, this applies the first subpage's exclusivity
> to all entries, falsely setting or clearing PM_MMAP_EXCLUSIVE for
> subpages with different sharing.
> 
> Pass page + idx to check the subpage corresponding to each entry, as
> was done before converting to __folio_page_mapped_exclusively(). The
> index already accounts for reads starting partway through the PMD.
> The conservative whole-folio check without CONFIG_PAGE_MAPCOUNT is
> unchanged.

Thanks.

I don't want to pick on you at all, but this is a classic changelog - I
see this pattern so often.

	a) here's what the code does

	b) here's why that's wrong

	c) here's how I fixed it.

But that's missing a very important bullet point:

	a) here's what the code does

	b) here's why that's wrong

	c) here's how this affects users

	d) here's how I fixed it.

see?  This omission is so common!  And I might have sent one or two
emails asking people for the missing info.

For the missing c), how does this sound?

: With transparent huge pages, /proc/PID/pagemap can incorrectly
: report shared pages as exclusive, or vice versa, after fork() and
: partial unmapping.  This can mislead memory-analysis and
: checkpoint/restore tools.  Actual mappings and copy-on-write behavior
: are unaffected.

And now that we have our statement of userspace impact, busy non-mm
downstream readers of this patch can easily see why your proposed
cc:stable is justified.


Also, it would be helpful to show brief before-and-after excerpts from
/proc/PID/pagemap to help others understand the impact of the change. 
But I don't think we need a v2 just for this.

