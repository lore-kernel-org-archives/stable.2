Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E895F3D994;
	Sun, 12 Jul 2026 09:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783848464; cv=none; b=A36y7Vru6M/uTdVFcOL9Z8PCGLwrxX/pb0t4U5CSTmTxRJKcJzjolyb6YRWOS9Nqrb+ZWVpM/KVBO3AZd6y9Ox0du1Ir218oV/tyPtoz5BDj3TU/Bs7C7TSHZQXnYnXP2LIJBXKogAoC/mdzNY9ZpeD1avLnqBNt0iO35LE3a0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783848464; c=relaxed/simple;
	bh=eleGJpEnYFxDxqONcdE0kQSQcyi7bZFQeN5aLXAYq54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p+DM3CX6orBIYUubO2dPZ3El56Ingia0BMMyE6YGzXFl9y30FPKjfcgKoZeNXgnZnugsW5ROceA6wk19lRnznBy3fxVnacI7WN320qh0HUtyoWUoUcHnUP4xVUaC4BAmCYI8Db7uRmUsyvf+mU6gp22Dy6FnRL1dfrogW4C2z+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ka37fTyx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ka37fTyx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF8961F000E9;
	Sun, 12 Jul 2026 09:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783848463;
	bh=eleGJpEnYFxDxqONcdE0kQSQcyi7bZFQeN5aLXAYq54=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ka37fTyx+JNPlw83sQi68vWVt8JMjJt2tNkTNPcKRGzmTHPEEqiJoChin9qpQaxdN
	 /rYCH6H7Z1cI4GEPWa3N05fu+XaZVbqXO0bTtAfzkrQtEVOet2dZu2zq1Dsv9vo7M3
	 g4W0NgQ6hGAIE3IRw3DjY28ZxEL+BjdyGjpEfnfVd5xtn7ieaanNN4Hgs9k2lh6++i
	 GoP0a+nUeqhZs8X1j9ldvGavcQcytsjw050iyvWcXY2kpcn6/If3pfAfmqOd7Ry0N3
	 pwIaCPMKfn8lnm7IIw/KCYQpv0rSDRJuPucmqY+wFy7e4NEG7c01WITL05nPeNZepM
	 3SCtswq0L8OpQ==
Date: Sun, 12 Jul 2026 10:27:28 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Dev Jain <dev.jain@arm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Suren Baghdasaryan <surenb@google.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Uladzislau Rezki <urezki@gmail.com>, Toshi Kani <toshi.kani@hpe.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	David Carlier <devnexen@gmail.com>, Ryan Roberts <ryan.roberts@arm.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org, 
	syzbot+fd95a72470f5a44e464c@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/2] mm/vmalloc: acquire init_mm read lock on huge vmap
 promotion
Message-ID: <alNcMpAtslog2wPW@lucifer>
References: <20260710-series-vmap-race-fix-v1-0-5b3794c113fe@kernel.org>
 <20260710-series-vmap-race-fix-v1-1-5b3794c113fe@kernel.org>
 <d47ac961-4767-4ce4-9c75-f281beb24e42@arm.com>
 <2026071252-sweep-quirk-a068@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026071252-sweep-quirk-a068@gregkh>

On Sun, Jul 12, 2026 at 10:01:37AM +0200, Greg KH wrote:
>
> And scoped guard has been backported to many of the LTS branches
> already.

That's really handy :)

>
> thanks,
>
> greg k-h

Cheers, Lorenzo
