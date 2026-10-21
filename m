Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792579536;
	b=tVLqW7GhgSRMTzRxqWV1g7RwiyrtDYeR6dE3nrvwJzdLr0bC3lv716+xPwjbkeax+/8D
	 QPxynfho4Mo7XwCFT/NfZG1ji0jW2AKW/+n+hkIx47zZwaZVxlWEPad8lMTulyhDP2q93
	 +34Vfj7j/txDpjyKQA+RksJMTNFeRFEnjJBSCslNm5F+pMOTjfQ4eZ6evSHroNsV/HJa3
	 MPPQRSqF95wmUW4wAOU2RH4YikQuSe9gAqJkTB7ImsQZGryL2adldNl+GtZHa+JytwFcH
	 anV8f7fclwpwVsjwpW9q2aV+ZsqR2dH7/LEAAG1SdjgEypENyElg1Kcf7CSiNzAG1aA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792579536;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=Zsif3MYLSFHQaVAeajAin29JnyY4ARKYrABwitLB9Rk=;
	b=nJyaebebcAMourIw1twb3ZGvpS/CYmwd1tt4947MDyjFGdlLEqjZrchpJN3qBP1Igbpy
	 8Du8bHcwR/97XWpN04t2Db8Xg/SiP5Z9T9prjgHrNZxqZkr9At4QR5rOrGPgTR/EtKEfI
	 q3n7FLyY8pPBS0j6lox5P7+dilSWJk9VbipdnSbeWXb26SX8kSrpA4YC4HX/MGsLho4sz
	 /uQ71Dp58QEAi4HpxF5fRE3pNWCuN8Be0RvLTlN0Z9C41aBdJ3kIPW1KNSnNbDF1m5MI9
	 ZSqZtT/fAO+9mpNiySpDaYWmj4VWr0K0rETN+FYKhcNcj7Sccb5BhM7ZS5UYAmpkvaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ITUoFWnm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE29606A319;
	Wed, 21 Oct 2026 10:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ITUoFWnm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E35AF1F000CA;
	Wed, 21 Oct 2026 10:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792579536;
	bh=Zsif3MYLSFHQaVAeajAin29JnyY4ARKYrABwitLB9Rk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ITUoFWnmtKQkesrydomGXhgVh6suxMt9U+eAPECm2bS6NIWx0OnvPgp9Ci8bzz5o6
	 Iw4Ta3oHfnBrpKhlThbz7Z+HS7vq88EiXKxUfLyiD2ijaCgNsKIhI/UDwYAUo7u2qe
	 oTOGCK44SOPftpzd89v+sYaI+GzO4C4TfHgsGc4lGIni6CwBrLfy3iFAUysMwAGhcn
	 hnTDFjkcAfrORGDAwClR3Z1a+sa6hu1UItqQdyCko4uXm3UN1g3QJECatsA6HKwygZ
	 zc+XUedibMaf7MSN2FOX/oXPlMUK8GlykhWPJprupCQHp92dFJPilNeY5pALSwobUT
	 zZD/tBhLzhnQQ==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.ams.internal (Postfix) with ESMTP id 3CC6E198004A;
	Wed, 21 Oct 2026 06:45:30 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 21 Oct 2026 06:45:33 -0400
X-ME-Sender: <xms:yZfYajk1SVwZJL2etJoKFZN-C4ohiZpbZg6EAmmaN_g5NuGrTYGYFw>
    <xme:yZfYareAtwR4eZ90nH3KOh4AXJMscwAu6JuENUOcilG46IIS2Uj8g_2T3FJ_h36Sk
    JBEyayXhq0nLsBqTf3T09M0SlavfTuRFAnif9mHAR6MF6l-rCL5qV1c>
X-ME-Received: <xmr:yZfYahzPCvaDuZUacNeT2K55W13M1htWPgwTKP9YN-qioxTqJG7W8T-32os>
X-ME-Proxy-Cause: dmFkZTGjd0a96U9V2vCQJLOMnRP+wBw1u1T1zryEKh7wa0310J6MaOgUiIze5CmLw2GV9H
    W7t6mlprVd+kvbSxqwnutYrDRHFq9thzgxnKvzoOneg/m+7lBF9h6ytrT+iKjxIUuf+vvN
    y9Cq7W4xWk7YVHBR3ir9mF0JQz+UsddF9RY9ecD9IhTffHR77HlcEV22e07OPYPqpykR1c
    Wbn4lcV/ZHNQlUrw+hxoN3dRq3FexhKkQBbUB2wMoaOQaVWFZvvUIADdR6OZTcM2mOgGbt
    Bk1nFt8UG7lG7K1JW9O5KIcUOduE5+An5YPc7EUyj56sUKNTOHdIARZs+z4z7vm38NyPkO
    wmSUXNPpxjcQFp7/JkJjUwG76pPAgcYBdQxvJ6P4aqeaJTbZM844gkr22S/ig48+kIad7U
    Djp1LfHzH3bPcjoFPQwRqL8I8jmrSMut7I64r3tTqNHUcas8SMKa5FnnfSxdJVyRdqBTSl
    vVoDVVid5tQMWpVWKGQYCcrdnpu7vGKgsS42F8BMXd7gKOroHVPpFDeswMEnjQSZA+yLvI
    HfWbQgiVG+kr8vmS0PrCdjOFK0y7wfS6DGhJFEjaRI953nvts016DGEPQevp3NpVH6Jkeg
    T228p1VaGhC1FU4fpGyxJy4addfW2sr1D6fUdC0yVGrxWHqoJ1vIwohGDkkA
X-ME-Proxy: <xmx:yZfYaltlWgJH0iQ_XyQYetAnpv1cS9Flskc6TVHt2Fm5HIUvXyQvyA>
    <xmx:yZfYamr-qW0eQ-X6lNXhK-8yGIC-YpTuJJ7qYGqeXvy0jPyt4c-Z_Q>
    <xmx:yZfYag07UcTns2rUJW6IaMSRlce-bFbGeqbDrUkmNwT3jtZFMerA0A>
    <xmx:yZfYaiU5cEwtulAkG0_t8jDRrXHGQ02KtO60MALEosyCFJ4hl88xHQ>
    <xmx:yZfYahf1xhEj98DBGsJaU0kLdz-iJVOf38BnjH6MqJBIFWtMqT9vyRO7>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Oct 2026 06:45:29 -0400 (EDT)
Date: Wed, 21 Oct 2026 11:45:28 +0100
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
	stable@vger.kernel.org, Chris Mason <mason@kernel.org>
Subject: Re: [PATCH 09/10] mm/hugetlb: don't leave a uffd-wp marker when
 zapping an RWP entry
Message-ID: <atiXpldwe6HbI-aV@thinkstation>
References: <20261015-urgent_fixes-v1-0-42796911043b@kernel.org>
 <20261015-urgent_fixes-v1-9-42796911043b@kernel.org>
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
In-Reply-To: <20261015-urgent_fixes-v1-9-42796911043b@kernel.org>

On Thu, Oct 15, 2026 at 06:07:15PM +0200, David Hildenbrand (Arm) wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> An entry that is protected with UFFDIO_RWPROTECT is PAGE_NONE with the
> uffd bit set, the bit that userfaultfd write protection uses too.  When
> __unmap_hugepage_range() zaps an entry with that bit it leaves a
> PTE_MARKER_UFFD_WP behind, whatever the VMA is registered for.
> 
> In a VMA registered with UFFDIO_REGISTER_MODE_RWP that marker means
> nothing.  The next fault has hugetlb_no_page() turn it into a present,
> read-only entry with the uffd bit.  That is not an RWP entry, since it is
> not PAGE_NONE, and the VMA has no VM_UFFD_WP (the two modes can not be
> registered together).  An earlier fix solved some side effects, now just
> stop the zap from wrongly installing a marker.
> 
> Leave a marker only if the VMA is registered for write protection, both
> for present and for non-present entries.  The zap of ordinary page
> tables has the same test, in cond_install_uffd_wp_ptes(), and
> hugetlb_change_protection() says that "uffd_rwp does not install markers".
> 
> After a zap the range of an RWP VMA is simply empty, as it is for
> anonymous memory and shmem.  Nothing changes for VMAs with VM_UFFD_WP.  In
> a VMA that is not registered at all a leftover uffd bit or marker is now
> dropped by the zap and no longer kept alive.
> 
> Original fix generated by an LLM and sent in private by Josef.
> 
> Fixes: 2d427bb01639 ("mm/userfaultfd: add RWP fault delivery and expose UFFDIO_REGISTER_MODE_RWP")
> Cc: stable@vger.kernel.org
> Reported-by: Chris Mason <mason@kernel.org>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> [ david: a bit of description overhaul+simplification ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
