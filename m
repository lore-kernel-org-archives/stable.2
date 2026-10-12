Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6828A479890;
	Mon, 12 Oct 2026 09:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791799117; cv=none; b=Wy1gU1PADZ+C1eX/yq8XyZreI3tjs3YAqKaYTSXkZ3ppR6Fwbbu8IEIqNC+6TnYgfdEDvJ1L7EQTFDD1AHRyadyT49MXmNIkVueOCsuVttJdPHWzH4wwn1SzC5f5LZT89/pYynnyHOHw8AyoHS86Y9rwBBa02h0A/3JWDVfSj+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791799117; c=relaxed/simple;
	bh=+0f4GNzyeQlRDy1ukiUXW+g+ERwYOdihOT5XL4IRX04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GQqTdTpu9BQC8PDZ18D6iSIxCPpZm2JvBDWi8ntkplA1nJU1czNxmYhUIbiz3zqvf3EmLLt3iVYtEHWyknPLbLOkX4CrVXexZUdxDaa7yL/ShiuUJlxQuf+WDUkfRD7bxoe4krDfZvGtEr3JqgLItKZalBlTdYQNTkWhaoFskQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dGoIpRNF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dGoIpRNF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 476AD1F0089B;
	Mon, 12 Oct 2026 09:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791799114;
	bh=PkoyxlI4OiMEMuywtpfFKclHTWhgbqKFjNw6JB8CL60=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dGoIpRNFt+CuDVxJ2uPyA5Hm5mmzrTstTL3R/lTmqs/mwOAv1a4wDDB/B9fib5UTg
	 NFZAzE5HstfDmiT0uSfPqdqYdnFzbzSim7tGTbaUybo3oC10gZq+Q5zPl/ra8hvyNJ
	 qz7KupSPg2UBSGAC2pp4vjKpMKNRlaTDcognvs1oJM/SWG4y3nHcfuebKTjkysSf9s
	 gmP+cmYIkzJRU624MiSzRMwNx2wNzpBFw3VkpovfxbAIuPSQXvtIi7hwjG7JLCcTPA
	 bYArA0r63mJjYTuYMZaQDi2vOsz4h2SIklx1qZbSVTdHe4vUw9LFs3IqbseL4ABC4b
	 yetxWYM3nR1YA==
Date: Mon, 12 Oct 2026 10:58:27 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Ivy Lopez <skunkolee@gmail.com>
Cc: akpm@linux-foundation.org, david@kernel.org, liam@infradead.org, 
	vbabka@kernel.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com, 
	fvdl@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/cma: fix list_insert_sorted() ordering
Message-ID: <asyvPcMxeH9kyU3S@gremlin>
References: <20261011003059.169430-1-skunkolee@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261011003059.169430-1-skunkolee@gmail.com>

Hi,

Please send patch series of two patches or greater with a cover letter,
with each email sent in-reply-to the cover letter.

The easiest way of accomplishing this (+ our preference) is to use
b4 [0], otherwise format patches like this:

$ git format-patch --cover-letter --thread ...

[0]: https://b4.docs.kernel.org/en/latest/contributor/send.html

-- 
Cheers, Lorenzo
