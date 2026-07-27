Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20BF23536B;
	Mon, 27 Jul 2026 18:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785175860; cv=none; b=tVZzWKj2UCXn0B6jEdbufWztyKO524mYD8qzI9KfWYbb4pV34wNhgX/7x6B6UGW/MScRAeIqTqfCD3LQsSJ4WYqqIO0JdzmxmQCSQ2GVC9MzKw8315TAaNvCHKeotVO1BKy0UGCqEHaKPI871AReqZvcaXrCJq9lHIJWkwd7nuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785175860; c=relaxed/simple;
	bh=g0FQY8S0fSEGU3Bf2IiWPQIBoC5M7eurHC+TOVfMyOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cwoz1kDkm79SQpcn3LOIuqz7GKkBWRczSai3/SfRfnXAGj0S5j1scyPjU3weGd2zfYM9JIg1UL/XZbGP2tEAOeRRrZQwpwwE92v2x8oXdMRe207G2PWOsFPZ3TDIk3lFrcjStLFzG+xQTZrvHl02RNCYO2eaC4MhbVypuNrGz9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kgz4UnNG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kgz4UnNG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D66F31F000E9;
	Mon, 27 Jul 2026 18:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785175859;
	bh=g0FQY8S0fSEGU3Bf2IiWPQIBoC5M7eurHC+TOVfMyOw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kgz4UnNGnMDJbFr07Zh72UjZH37rBDSu3pDdHnjvST3PtVaglZ0RbYr2PHFzYrk1h
	 SlbBhrfc+G7FubA9BTHNccBjGkZYD68jK21POgOuVbCGoLRXfzOE2sejZXtze6kgHq
	 T3l/wrQnD/GLAcSLqu65sdTuJ+8KnwRvmR814fqzWsIj/TX/0cTU38uIRgc9Dqs7Yn
	 UngsKRJyTYLv0iK0n/lb6V90BPCTbORtKT/UKHKdH4IW7dJByUvCbnR3+CKmIU8q8p
	 ChpTyC/A8dDursKm7O7xufMBxn1tPVD/Ibp0kd0JYbTpYRm7qo0wCg6eFnYS8OPN/b
	 fhkFfog7mvWkg==
Date: Mon, 27 Jul 2026 19:10:42 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Hengbin Zhang <uqbarz@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>
Subject: Re: [RFC PATCH v3] mm/thp: serialize huge-zero folio state
 transitions
Message-ID: <amee2qZ5HqwoLug3@lucifer>
References: <4146d4f5-c8fb-42cf-9dc8-a9d4c26055da@kernel.org>
 <20260727154001.4102341-1-uqbarz@gmail.com>
 <b915b058-f5b1-423a-a835-5891e7997080@kernel.org>
 <ameC4IWCOVBGlXZu@lucifer>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ameC4IWCOVBGlXZu@lucifer>

On Mon, Jul 27, 2026 at 07:09:10PM +0100, Lorenzo Stoakes (ARM) wrote:

> Overall I am not confident you understand this so as per above I think

Trailing sentence... tired :) delete 'so as per...'

>
> > >
> > > Suggested-by: David Hildenbrand <david@kernel.org>
>
> Should be a S-o-b and David should handle this.

Oops left this in by mistake (tired, late in UK :) this was when I was hoping I
could get David to handle it :P

Cheers, Lorenzo
