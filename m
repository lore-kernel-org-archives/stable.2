Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D87242B311;
	Fri, 10 Jul 2026 12:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783688274; cv=none; b=vEP7DfFjh9VDAZAKSaIx5w6SylhV4dU9Z89oW/gpP2Rt/dZVVp0PqwICO/xbBlvH8aFfmGA7VOfX7pLA2qw92jWHOCMRrwA2aG7qlUZ9v0WBvxgalTD/VC9TZDSvGlh+ONp/EAS+Vd02CruwoaBIth2B2KWnF+sMnW7nmkYgMKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783688274; c=relaxed/simple;
	bh=GJ+ZZjoXshQwp4HjCw3hwahYLU+lQJ/F/RXGt07TIgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VeIqWMosxMU+kC3lxS2F1ShtSoFk7ExteWgQqGJI7ZSBo3qgQJpygGq5mtO33aRRm/JB9U6awmcnBRcyfrPvFkgFmgSRDD2fzJ+KKZI0jbZzqrtrpL0d8t0xom10EVA4ET9U2ygL6TLgi4XyBZKBV0AM36ZJ0R04KEhIlOzaUcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LZynFH0m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZynFH0m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 400BA1F000E9;
	Fri, 10 Jul 2026 12:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783688273;
	bh=GJ+ZZjoXshQwp4HjCw3hwahYLU+lQJ/F/RXGt07TIgQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LZynFH0m2Au0GulWeBOL9Se7/aaURATREjA+Ms9gJ6cf6EtMIjnSwTCzlx6N02XnT
	 dmeQJC81rdCvri3euXeoAfSFGRC9CIcPElPxCiLeWREStZCOdOcBu/+qjU0yCmT0QP
	 enmkG7dOtBv4nDyzVsVDneapP70gJ5rRL8UmcRvS6VjvhQn6RB008l2MD2l32xfGXG
	 5cYGi71NQAngfXSfymfzcPQ2MPJVVaecPUhTIsgTQH82cuEl6S9WmxjFwNuGAgHhNP
	 P2e2TfAIlREWpipjFo8pinavN75nYQAV2KudNOomqBE4nuw3/+drShM6jwi7qLxDtZ
	 ksyTR9LLiW0jQ==
Date: Fri, 10 Jul 2026 13:57:40 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
	Suren Baghdasaryan <surenb@google.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Uladzislau Rezki <urezki@gmail.com>, Toshi Kani <toshi.kani@hpe.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: David Carlier <devnexen@gmail.com>, Dev Jain <dev.jain@arm.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org, 
	syzbot+fd95a72470f5a44e464c@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/2] mm/vmalloc: acquire init_mm read lock on huge vmap
 promotion
Message-ID: <alDnFGncVvcjsvTg@lucifer>
References: <20260710-series-vmap-race-fix-v1-0-5b3794c113fe@kernel.org>
 <20260710-series-vmap-race-fix-v1-1-5b3794c113fe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710-series-vmap-race-fix-v1-1-5b3794c113fe@kernel.org>

As per Sashiko, we need to account for x86's slightly bat... interesting
ptdump of non-init_mm page tables.

The fix is to take a nested init_mm lock in ptdump_walk_pgd(), which is
safe as nothing depends on an init_mm lock prior to acquiring an arbitrary
mm's lock.

I think this could potentially be sent as an entirely separate patch, as it
doesn't change what this protects against, nor the x86 CPA patch, both of
which stand on their own.

Cheers, Lorenzo
