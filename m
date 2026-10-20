Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792517078;
	b=VOg/lNwJIDq+QT3K3/c8H0wTphmqoA13YQHTPPtcSo9Lt/OCxFmBJvSfWQG/hHccjMht
	 f6KxE7jKGs2NFD94rdjmxawpEy4KKiiTlMG+wieDuR4jr+s9jh4MvtCG1UGexI3+aok21
	 B47NDcGklZma1x1W1ccppH7KS1GcdgaBqqxWXTSf+I8SKKt38jWQiHPE3q8G+oLXjpryz
	 CZKNlbEKuJYK7xF6XOxhX3d6B023DORABC7LVLyyKn/X01e36IM6US+RCMfHlOexfT1OS
	 iqkVc9UVx6Zxakw+X02ObdpfzSeV4Xxo3rx6iqmoeU5Lp1sYuvEAowaD969sUHh8VRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792517078;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=eIkjRlsFPywszfhUFpbnPpHK8HmKO88itIC4z19/psA=;
	b=KeQ4VojA7fR9BETtnApOZ7lC6QjZkglU8RirU9xqaNnfhKO20Cyf3j3CBbzYPnnw7jT6
	 1IsJG/Ts8sesG6uvHCdxiLQcu/BPPMeAAgs57NuQr+qETfxeUiZSJna9YDyW48MfDuTo0
	 YAR97KQ4NF49I9d7Z3uWeOKOdm/5LOhTqDuEOOZa8F9qx54P7dWvjCUoJzEPX5FAqxdD2
	 PlVce9w2ycCIjPEbRfvVwTT7kkBSxQFTSxz4RuKkCCxi34hbpO2pQwqT+L34GHEJMwshR
	 IhU7pph8FKaqbUmr6/YKIyi5j4GAZHI9Pc6ziSbFxRERgwruzvTbCJAjPewRDdfAv2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m4a1CBQI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A97606A31F;
	Tue, 20 Oct 2026 17:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m4a1CBQI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48B6E1F000C9;
	Tue, 20 Oct 2026 17:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792517077;
	bh=eIkjRlsFPywszfhUFpbnPpHK8HmKO88itIC4z19/psA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=m4a1CBQI69BfnR6v51xmRl1DWdqoqGsY4yb0Kihckq4c+33a+V/KyXnYJaXsQSg74
	 jTZ1EXsaQkKhCVP4m4qL88RV67sbmshZlLbF/SJ+unh8Hfg3RR0Tq8FobU9CVhGUsP
	 Pnf/vU4gjuVTU9eM0RQ06UOUh+7J/zinSetIXZqYoWgDbPaPwjCT9Kl4RSAlbYwF2r
	 FEsvMuNQRqUKHZwMN4xV6IMD3vgEJlxTcrrPDUsqvOjV3gJjstG47qWEVAQcDKzfwS
	 pg1sfWVAXbMOPf/NMZnyRAPTBEyYJGTp7qLtbJ3XxxcVBciZnkt33WaZem33tCB7jP
	 ahKWX5JZx3+Eg==
Date: Tue, 20 Oct 2026 18:24:31 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Kiryl Shutsemau <kas@kernel.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Mike Rapoport <rppt@linux.vnet.ibm.com>, Peter Xu <peterx@redhat.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, shaos <shawnq1@163.com>, stable@vger.kernel.org
Subject: Re: [PATCH] mm/vma: avoid broken uffd merge on mremap
Message-ID: <atejkJlBfeX66_7E@gremlin>
References: <20261020-uffd-remap-fix-v1-1-0f34fc181f0a@kernel.org>
 <b61cbf73-b92a-4869-af94-72c30bbe9527@kernel.org>
 <atede4rPZKNVqwDr@thinkstation>
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
In-Reply-To: <atede4rPZKNVqwDr@thinkstation>

On Tue, Oct 20, 2026 at 06:03:03PM +0100, Kiryl Shutsemau wrote:
> On Tue, Oct 20, 2026 at 05:51:12PM +0200, David Hildenbrand (Arm) wrote:
> > @Kiryl that should solve the issue I was raising the other day with leftover
> > uffd PTE bits outside of uffd areas? Can you review?
>
> Yes, it is the same copy_vma() merge.
>
> With the merge refused, the reset in mremap_userfaultfd_prep() only
> covers the moved range, and move_ptes() has already cleared the uffd
> bits there.

Yes, that's my understanding also.

>
> Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

Thanks!

>
> P.S. vma_has_uffd_without_event_remap() is a mouthful. With negation in
> the name...

Yeah, I thought so too, but a pre-existing mouthful :) could do with a rename at
some point though!

--
Cheers, Lorenzo
