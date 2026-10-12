Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8C949DBBE;
	Mon, 12 Oct 2026 15:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791818799; cv=none; b=fS9wwV5d0thP04q74tHZcx+O6XcSUK8rcZ6X0rTf+TUIQLxJUtWRlUPleZeWfHTuM2uhrUbFPP6aYnbX5b2epE4Y02DlSVjdFayw7WwbuzSmUBgh2on0zN2Eksb9vUAJh5icONNcWZayeziNPgKwzcUuP+Ye6+kUwWc+vqUil60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791818799; c=relaxed/simple;
	bh=wLEJOmKB2D1sT8Kd+NykOzJne812G24b12XN/JMTXnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZLVVLRXyZgjuzj9ujEchsznC6241DGumL/fcuDQLL1zmyzUn1OaxRJMuEB/TN+OEEx70ZfsLPkeuPz7QQK2vAvxgHHGJR6o9tbiI0ZTbFNzSN/teJkbIbUi668gROdmyi+lyQbe19QVwmGa1jQR7AFDzW3zPDMOIsi1wfIPdHHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hkEsJf8r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hkEsJf8r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0A081F0089B;
	Mon, 12 Oct 2026 15:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791818796;
	bh=wLEJOmKB2D1sT8Kd+NykOzJne812G24b12XN/JMTXnU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hkEsJf8rILO2y5vMNiI61WRnKDE00ir2qR7BiAjX7q9VyaDPuENri+7cN7obIIpBn
	 1TCIiOSES415TOEfhPmB5jK6t08rFaNhD6SQfVRyvlVW+3SkMmCOdjTjLy6Doss57X
	 pL2UwxQSAFMHFabgkkwXYo6orBPrOUBC0cZWA1tMVymAbSMRHoEjoQqVgDU7lAURdn
	 ABCSX+5X3cskdpWqGD1q/xLQJBJtu7fGLSl4WwVvQ6pvGAHuTO09i9l3lvjVLI2boP
	 /j3OHg4EfMU4hVKlxlKDZng+1vUEIxOiy/+BkyOna+h5PE/cO3SIhkycB+e7eUpudU
	 BwW4kDnrIuVKA==
Date: Mon, 12 Oct 2026 16:26:31 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Zi Yan <ziy@nvidia.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, 
	akpm@linux-foundation.org, liam@infradead.org, vbabka@kernel.org, jannh@google.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Pedro Falcato <pfalcato@suse.de>
Subject: Re: [PATCH] mm/madvise: keep the hardware dirty bit in MADV_COLD's
 THP path
Message-ID: <asz7YUXhdmlenXvh@gremlin>
References: <20261011132227.413217-1-samarth.colleges@gmail.com>
 <42087cd7-473e-40a7-ae63-3c841c615c8f@kernel.org>
 <asyy7Nwik5yMTNbo@gremlin>
 <asy4c7zkkmSRln1H@gremlin>
 <D964ECBC-59B6-4A4B-83D5-935EA2D06D30@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D964ECBC-59B6-4A4B-83D5-935EA2D06D30@nvidia.com>

+cc Pedro

On Mon, Oct 12, 2026 at 11:17:57AM -0400, Zi Yan wrote:
> On 12 Oct 2026, at 6:38, Lorenzo Stoakes (ARM) wrote:

> > [0]: https://lore.kernel.org/linux-mm/20261009-lazyfree-stable-fix-v1-1-70997958ef8d@nvidia.com
>
> No. Without lazyfree PMD level THP discard, the affect PMD will be split
> into PTEs without dirty bit and the dirty folio is still discarded.

OK thanks for clarifying!

>
> We will need Samarth’s fix for backport, then we can think carefully
> about David’s per-arch solution for mainline.

It's AI slop, and we don't accept that in mm (also -cc slopper).

Somebody from the core team will take of this fix separately.

Pedro - you mentioned you were interested in this, will you send a patch?

--
Cheers, Lorenzo
