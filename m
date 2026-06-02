Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EFA280CE5;
	Tue,  2 Jun 2026 04:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780374036; cv=none; b=ZenIH9Ibzfc4m0dlgPj/P9HzEZX24zw43itz6Hh7JubwqVstau7yAYMG1uiptdftgIDZPep1nJC5NnrQnNXgOkfTG6cjzxO0b9CcFMYhiY7at9jXH4XuzKALlUV/uu+t/KpKSpjWkzuiCId3OivWjGBm5Kizoa7xakED11pD65c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780374036; c=relaxed/simple;
	bh=/Axp2tTWOa4qnLPLjdaE4y+OctHPfIampNfZWnQlAZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aeECSDOO5YaRF6pfnT1V2rKl6sHHBX8WHGQT7NCNXhfr0PAbdpvhcpKlG21Q177gJpxV/6xGWiM2qm3y8243mlXT/KZ9sioWkk61/bGuOmH6KVyUNLpS6tDtRDqZfe2KjO3OB3hOcyZZdj/ghu5TGUFp4ksNKKV3h+kFnVCHM0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aIsWNXIT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aIsWNXIT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 941901F00893;
	Tue,  2 Jun 2026 04:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780374035;
	bh=nq78X8IAsN7c2Wk69I/yZyMLzhG6wRb/glfd/8QjMe4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aIsWNXIT0arPzB1Vjog/511JNudsPc5qce+mGYKUxfD9tKkHalM99dQFzilcyIdl6
	 WNBQR7HxXfXH2G3CjUVBfFoLuN3JAbhzPBQvXNvuFghufZy1Dt7blpE9nfTW0IWeZo
	 zXaoee+0c8gu/ghD3ByKNSWOG04HcBuWWoI3ib5eFwR2fdzYt8B3coKsIMab9e2DPW
	 amU/H9/sPNFTt1XNwL1XyqdNhcHnZpk3h/7j944IXu3FS6IoWpijoMpEJUUKvtnOxW
	 tqhw+Zc9SulL4+EleWlXefyvBLD9iSQ6ZajRUgKEERrOcMauttyzkhSH7jgrrNc0Gg
	 PAlLMc7td6uVA==
Date: Tue, 2 Jun 2026 06:20:26 +0200
From: "Oscar Salvador (SUSE)" <osalvador@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org,
	liam@infradead.org, ljs@kernel.org, jgg@ziepe.ca, leon@kernel.org,
	shuah@kernel.org, vbabka@kernel.org, jannh@google.com,
	pfalcato@suse.de, rppt@kernel.org, surenb@google.com,
	mhocko@suse.com, balbirs@nvidia.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, ryan.roberts@arm.com,
	anshuman.khandual@arm.com, stable@vger.kernel.org
Subject: Re: [PATCH] fs/proc/task_mmu: do not warn on seeing non-migration
 pmd entry
Message-ID: <ah5aCjLl1dx546SQ@localhost.localdomain>
References: <20260529111704.1078346-1-dev.jain@arm.com>
 <a62302f8-24ea-4d21-963d-48bec766766b@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a62302f8-24ea-4d21-963d-48bec766766b@kernel.org>

On Sun, May 31, 2026 at 09:11:53PM +0200, David Hildenbrand (Arm) wrote:
> The whole thp_migration_supported() guard is a bit shaky, right?
> 
> I guess device-private entries currently imply thp_migration_supported(), but
> that thp_migration_supported() check is really questionable and should likely
> just go away (else if -> else).
> 
> Staring at pte_to_pagemap_entry(), likely we'd also want
> 
> if (softleaf_has_pfn(entry))
> 	page = softleaf_to_page(entry);
> 
> to prepare for PMD swap entries.

Yes, that is what I was doing for non-present PMDs when implementing the
new API [1].

[1] https://lore.kernel.org/linux-mm/20260525165528.184397-5-osalvador@suse.de/

 

-- 
Oscar Salvador
SUSE Labs
