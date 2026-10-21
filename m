Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792579451;
	b=X42iyThq+C/FnfH+xMv2FKYvG3GTB8GTE+QlzG8nn8esjSXS+mN9viYQ6heZAPcGA5w5
	 ObG8IrLJb4A3CI8U7QdCziLFmHy3zg7M5NNguPabV6yuAezlMlKRIXaamjqrvDbQhQuSU
	 DB6A7i0r8x/KrfO8E5hkERpHA72khV9YObPrfYlZJl4qTMBDo1TyFjurT5XD31txzLMBd
	 IOQjhLuuP3iWWxB7sMoknpeHpmSmZAF37fyODHdjOveNv8WBkoM0RJH7kxCE+1X8sN1aW
	 YEjoJGxRH9085YLuHFRoms4mZk8Yiw5/EYKnyDDBTdvex4qK/crYf/FGcrwK5EcQ83Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792579451;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=Us9MblHdqheExL+x3XL9+16dU0fSlqkrDNwTx8ZinSI=;
	b=i2jPygHG+c00NzxPWEKqMZt5n44eZDAby19qLr7ihp71AXoMSbMN0pHlwv+OryXrss6s
	 LMUE95yxEFlPaw4IetsKtmMEdRMsmoDYoDSaNqjir9G0p/7oMSZFOW5awCrD3v4uN/7YV
	 5UtVAzYrKYBdFPBxAk7MLeyyhjUJ63q+FvXRK70K4g4zfxjFNEzFyWikEMdb2Y3l5dQss
	 aAUR9Uqf7aaDhAc5tdDEMbrx+V7tunvlU1yMDK2QGR0FFk67oj/LqaDEwnmSiEzVzMs9K
	 0YpajIVjbyuBBXrF5VWrvDeAXkKtC+//qifj6kn+4mCmgRs5lcxC6tx4gbw5BO3VUhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cpWdr09j;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8E3606A319;
	Wed, 21 Oct 2026 10:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cpWdr09j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2CD71F000CC;
	Wed, 21 Oct 2026 10:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792579450;
	bh=Us9MblHdqheExL+x3XL9+16dU0fSlqkrDNwTx8ZinSI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cpWdr09jPEBb0bc9LwNOJEzRdZjJF/BmJqcBNQwEwkzMr688MKrLiEmNM9hjiMWey
	 UQslgbqyADbfbVDMyMEghX6Y3z23Ket3+TL6VEwjtJ44VtWdzyt0HsypjPDiwsY+fA
	 yDpGl8ZcSRDnArSkUdQkEs9PZCf9/8uOYWJnIIAdmxFu6F1WYK0Jt0z3NCLzcT/rpu
	 n2TsT61w2zbwBJhuJX9+wr6MbpT7ybuL2En/4PmCLIwcmn/M4Sm+0QVo8heQa2W29r
	 TKAxBEHIWbH2lF2Il7Um6mDpwMbYMbIHyC6XH1LPbyv+gqfS6li7UEM4nTraVAVNKa
	 Ypkq0uk2Xaj5A==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.ams.internal (Postfix) with ESMTP id 2AD67198004A;
	Wed, 21 Oct 2026 06:44:04 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 21 Oct 2026 06:44:07 -0400
X-ME-Sender: <xms:c5fYajUSghtNgFI70pcZQneEQiKH-7lS9ZiDirnB17TnEvHBNdbCoA>
    <xme:c5fYanAQyxuwZwdQplhyZWO5Bdi2T3DvThxLwzqn_3RnCTqpb-X4KPqEKjKDGlTZ7
    oKcZRIZfz-3S6jmsuUKK8xOpGS7tHrzX8oz-CmCJCmsjXvaBHq7Ui28>
X-ME-Received: <xmr:c5fYai81E17U72TQR6cBaVLxynEL8Mf3FphrFIRT7W66q-afIjHNwVhOSWI>
X-ME-Proxy-Cause: dmFkZTGjd0a96U9V2vCQJLOMnRP+wBw1u1T1zryEKh7wa0310J6MaOgUiIze5CmLw2GV9H
    W7t6mlprVd+kvbSxqwnutYrDRHFq9thzgxnKvzoOneg/m+7lBF9h6ytrT+iKjxIUuf+vvN
    y9Cq7W4xWk7YVHBR3ir9mF0JQz+UsddF9RY9ecD9IhTffHR77HlcEV22e07OPYPqpykR1c
    Wbn4lcV/ZHNQlUrw+hxoN3dRq3FexhKkQBbUB2wMoaOQaVWFZvvUIADdR6OZTcM2mOgGbt
    Bk1nFt8UG7lG7K1JW9O5KIcUOduE5+An5YPc7EUyj56sUKNTOHdIARZs+z4z7vm38NyPL+
    HMeJaBxs1tnJ0vyAx9C/DXs6nkO5W+SROu2gcLvgiyeg+rJm8DzqGFpZRqkGkzLHbSENiJ
    HBbb/QiPxtnII8Uk1Aw0fsQFr4bsOMXrpJpP4o9kQ6A6DpRyVen1lHrEEJ4L9yapznEJAj
    3PpKWlBNVcyf/NsutF0IPRW7//mfti3i/gbQX23xqmAqPmynlQt9p6EB2slaCusRSNwU2q
    TqhR1AuKmJ9+wlHfDyYPNRZ6p0We8D+oBsW/o3vn35BTXm8B9lt5J6jeuOcZJ/s43Qu9gD
    mjnUcWTYfxtc0HJnryuldPPfmsEjTZQJq09ZQ5pAmUiMVHNuJ4+1inCL5tDg
X-ME-Proxy: <xmx:c5fYanX-UOwD1UJMljja19LTZSvPp6QGcT0h-ll81DosJRWQO3Hp0w>
    <xmx:c5fYaqveaLErmdg4TlIzJ8FZHHZWWJWD8PxVjFCrfhuzfBv-JlBQhQ>
    <xmx:c5fYapwXBuSeNxn6ADFbdlYq0tTrchCfRfxXKfJJahhF3GaoUflqoA>
    <xmx:c5fYatQlMd7RbKCdCqBqcY3jcV_k3NMeVXticf3wiq0mfAzk1ElIMQ>
    <xmx:c5fYaj_ICU5Mn5lVmICEv_wySfwlt4Bp4UxwPMTYguEn6y9bPCJ8cNWj>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Oct 2026 06:44:02 -0400 (EDT)
Date: Wed, 21 Oct 2026 11:44:01 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
	Adam Litke <agl@us.ibm.com>, Mel Gorman <mel@csn.ul.ie>, Rik van Riel <riel@surriel.com>, 
	Peter Xu <peterx@redhat.com>, "Mike Rapoport (Microsoft)" <rppt@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH 07/10] mm/hugetlb: tolerate uffd bits set without uffd
 for PROT_NONE PTEs
Message-ID: <atiXUuyXM89u-XBV@thinkstation>
References: <20261015-urgent_fixes-v1-0-42796911043b@kernel.org>
 <20261015-urgent_fixes-v1-7-42796911043b@kernel.org>
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
In-Reply-To: <20261015-urgent_fixes-v1-7-42796911043b@kernel.org>

On Thu, Oct 15, 2026 at 06:07:13PM +0200, David Hildenbrand (Arm) wrote:
> The whole uffd handling when a VMA is unregistered from UFFD is shaky:
> there are still some scenarios where we might have stale uffd PTE bits
> in VMAs no longer registered for UFFD, which confuses other code.
> 
> Let's just tolerate that for now and simply clear the PTE bit. Add a
> TODO to really clean up any uffd leftovers when unregistering a VMA from
> userfaultfd.
> 
> The handling is now more similar to what we have in handle_pte_fault().
> 
> Fixes: 2d427bb01639 ("mm/userfaultfd: add RWP fault delivery and expose UFFDIO_REGISTER_MODE_RWP")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
