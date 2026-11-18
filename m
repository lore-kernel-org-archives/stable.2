Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795010848;
	b=aQsjoIf7b6Ct7thTlLVWi95n5HkRHV2lLZyOHWRyhah6YGkTDWXiaN4JxLA201hqQuaG
	 fN6F0ehavSpiNtdVs651g48ZF9MWC2W5tTIHUn56PF38dz3OUcTNF8gwMde/mcu9uj8ZZ
	 +8eRsvHc1Ro4Yf6DIQHXGjjHiDO1PaSyMlPOfT4iGxPU48GXWs3x8L7QpSrQh+3B5U5p0
	 A+43TuC1uap5d0B6bsUOH4zjD74ieHTXBwenx7vCzw+Iph4U3S3JErfz/CLNz7Z87sEQy
	 +DFyj09q1+Zx+dECzdJYVL9s9FumPRSoLeT3jiE8lMjoW1aJfLi2buE3HGgmNT7d+Kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795010848;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=k5lNlxAoGPg806PTxIoKtyPv+dx1Gfpw3t9P/RGtzac=;
	b=cS+g2y0V4uhGu5TX4lceJJtDuzybOvtqtjiXwbEXlOYiR7YZBF119wzijjPKfL/CWcaF
	 bIzGcuqK4T6hZL1Oy06dxFXvPLH7m+g1BaaFKGNisyFT9g04anYWExkFvSeaZ7LJvNKRg
	 M9uBoG69J5EYEfM2ewCcK+Hv9SKv9a4HQc4RNRld09sFSD9sYHWfHxLlG7ZYk+0EQLKOQ
	 cN7FLQhZMgXKmWchg3+TAjFNvwx6oX8KTVG4zI6AoVDa2YY1cRt0jjtsU8kph8q5bfTrt
	 vJAPr8rwz5TpPwUegkO6MCOboJy8inYP3wr6v1gVOUwbm3srBTz0+JTcvV8ODUUGA9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="i/qK1c/w";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BA8606A332;
	Wed, 18 Nov 2026 14:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i/qK1c/w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8272C1F000C4;
	Wed, 18 Nov 2026 14:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795010848;
	bh=k5lNlxAoGPg806PTxIoKtyPv+dx1Gfpw3t9P/RGtzac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=i/qK1c/wDYDTdZDrhx9JaMqoN3swoPbXUD1ba1bvT++6dL51gYeXNUGjk906z7mNR
	 N5LunQHFijq2OsxbhpkGl8x4vTEiTlogtfEGDocavH0SHDxxHzu+3TQnqlGkS4omm+
	 +bDmYrQ7QInWgvSb4LnBz3ATcFuc6vOu9bGerA1kydBbmytp+KpFquhRzIieBKQNLv
	 IiHenjryKZh7DyXL4y22k4yfRthPyz+rcx4g6d1LtDFw/RoLtW4FYfzBjne5gVwMdP
	 ymyrHvS04VW8CQJVKsqBG8FzSxG2TImUyo17+tALc1Og71joQgK18heBqZHYLkE/bw
	 lnVG3mtOmkRxQ==
Date: Wed, 18 Nov 2026 14:07:18 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Alex Williamson <alex@shazbot.org>, Peter Xu <peterx@redhat.com>, 
	Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, Wei Liu <wei.liu@kernel.org>, 
	Roman Kisel <romank@linux.microsoft.com>, Saurabh Sengar <ssengar@linux.microsoft.com>, 
	Naman Jain <namjain@linux.microsoft.com>, Michael Kelley <mhklinux@outlook.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, Eliav Farber <farbere@amazon.com>, 
	"Jose A. Perez de Azpillaga" <azpijr@gmail.com>, "Gregory Price (Meta)" <gourry@gourry.net>
Subject: Re: [PATCH v2 0/4] mm: fix races between huge and non-huge faults in
 PFN mappings
Message-ID: <av2cagI4ccMR7jJz@gremlin>
References: <20261117-huge-pfnmap-fault-races-v2-0-276007e73bcb@kernel.org>
 <d7edeec8-d9c8-4516-8426-de2d8854ae06@kernel.org>
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
In-Reply-To: <d7edeec8-d9c8-4516-8426-de2d8854ae06@kernel.org>

On Wed, Nov 18, 2026 at 10:47:48AM +0100, David Hildenbrand (Arm) wrote:
> Lorenzo,
>
> all of these are not super urgent and can wait for the next merge window, right?

Sure.

--
Cheers, Lorenzo
