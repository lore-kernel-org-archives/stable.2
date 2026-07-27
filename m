Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577EC3B47D7;
	Mon, 27 Jul 2026 15:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785166981; cv=none; b=Mn6tYsjm4dHcW5suWpXhuixhB67Ryri1oW/ArR7XxHbDPFnZ0aCVuUyD5+pUq5mglm+FLMRMDLIQhXP5h5cV+ZZsAyNFNHva/nU3bNN2qgIeMSTz9MM3n1XGnbsSwFewCygZBaQ9ri3GJbObwmIztiHpQmARF2HVPypYfkUlAV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785166981; c=relaxed/simple;
	bh=VuYOh1JKwZ2XJMarHuaV0AoNXdrVbwJIswnBoRs9oyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rfRCE+kFEZ+JCpfHcYgq6t1GymaNVv7Qa7tN0s8voPX/JDRsT0AAANZHoylLogeJFYQf6gKVDb8G5lDqtvKIrdjWPOnhC1Y49C8etk2kXPAFwDZo4JHHujbsXtohkWKHMRhZXPg20As6sxPyasdkBj6k9mCX5y8tyJTCPBBxM+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K7bzdiTw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7bzdiTw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 450BA1F000E9;
	Mon, 27 Jul 2026 15:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785166980;
	bh=VuYOh1JKwZ2XJMarHuaV0AoNXdrVbwJIswnBoRs9oyk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=K7bzdiTw7EEiKbDzCDfYrSNyDSx6kn1yiNvjDY7+aZLe3pToRFzi07hyIYh0136k0
	 nebhboEwxLm1CD7YDveJKi4hMxT8w9F5PR/5bkgxu5IEunRgik2BNNBYP/x1ZcL7j9
	 m1Fawbc5GExHBr+Gql4l4MwFPprf/L0SiYGdfLwl+XAesdtCKIoywZ07X6ifgFbvQm
	 8zDR3zkDcJP+ANGfQj00N5CC776nw5PvkeTxEDKZHIsn1MOOYpkIMdmcFjCZ0UQRmW
	 frBIvWjhkSU2wjVWnYjES2iqXjGrfrV+lpQq/496+XtQlc1A0LOdaY2mCxuMPEWEkq
	 IUfrJIdBf5tlw==
Date: Mon, 27 Jul 2026 16:42:43 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Hengbin Zhang <uqbarz@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>
Subject: Re: [RFC PATCH v3] mm/thp: serialize huge-zero folio state
 transitions
Message-ID: <amd8LmZdA6SPMAtE@lucifer>
References: <4146d4f5-c8fb-42cf-9dc8-a9d4c26055da@kernel.org>
 <20260727154001.4102341-1-uqbarz@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727154001.4102341-1-uqbarz@gmail.com>

Please stop sending new revisions in response to review!

Respond to the review, then send the new revision as an entirely separate email.

Also do not respin this quickly, leave at least a delay of a day between respins
so people can have a chance to keep track and review, the workload is high
enough already.

Thanks, Lorenzo
