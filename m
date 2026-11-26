Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795701701;
	b=bqrzanYr2p40ui28iZwz8nGPKssF5GlugR2QtAUKfw8XhJjYTxDAshbUnyREEKUY85h8
	 vl84eanH2KSpNL/FzqWkWt9CO9OLtiOmtaRFB7gulnFOXjWrkXDZbhQoO52JQJJ98XIuD
	 QNH0EYP4OrL2BtiraiASUIgbTJQEuPfCBKOqGDMpBjb9N6HMcqaGx2eebxw4BeWBOAXd1
	 lZf0l165SDQZahlC10hHzwcRAFyLCvzNye1StJsu8+PmqeUPnVa6NWk8qlIb1ylw+uSrQ
	 04daeqDSoZIEwUiq8wzbhkqAsbRghqc3GOlRCKCjC24M5gC8qpRnGV/Gb+Okw/l7SSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795701701;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=axz7TbyZfCz1r+C0ASr08xilH+HCS96/gQXwmQi+6d4=;
	b=BdHT/1ybjSK4kFFwTnF4EbyIKIyDLm+RAPLY3MHo4hEdTsx3CoxwuxFtV5Nh+aRr6PRo
	 oDPjeMmYzbAA03wS62e1hcoMTexZj+79WV3qqUkpD9roUaptCCDkEidfDonG+yC1Th3mI
	 fEPswUXPGWSTVjHRBuazsfktmvng6iwXa/YXl1onrdEIUP3q2WcmUJGtc3ZQJp294W8v2
	 I0rI7sY/PweyrWR5zxrGz9NOACofxiTDFGM73ODRnw5c40FcrPwjk0ZKaSAzcYJmrhUy8
	 5AeltzOBALEFKKDyR5khHyDJA0rWcEi4GoCZO3e12XzybhG08t+jK7b3KwYuqtQo36A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LoQ73B1M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED926606A31C;
	Thu, 26 Nov 2026 14:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LoQ73B1M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EB881F000C0;
	Thu, 26 Nov 2026 14:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795701700;
	bh=axz7TbyZfCz1r+C0ASr08xilH+HCS96/gQXwmQi+6d4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LoQ73B1MVqtATP8QZPwwSeTiprDc2wKSxjj01xje7iiEZgFfFU0KMru+M3MzGYI6/
	 Z6IqQcigpkNMo+6TO64XzXg6lZeZFiH/cY4GU5L2dyxgUAOqjQTClaOdObsxyiVdh9
	 ea7pQkJOyMN/oizgooKeWq7KdJ5GqD3S1CKyilOlFQt7V9ZoFibHNTdPK9WxEi03lX
	 funu331pIcghv+yY2brcDDtYHCiiA+n8B+W+8zqkiJoVAVjs9d0vsW2V8gsajhSi6l
	 fJfkNvH5b5RPeFPnAUVv7x/3dbt4X6PSTJCIPFaOfrkoW3rg3xS0dn/RXOaXvQX68u
	 FYfcM26VxRC6A==
Date: Thu, 26 Nov 2026 14:01:30 +0000
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
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	"Jose A. Perez de Azpillaga" <azpijr@gmail.com>, "T.J. Mercier" <tjmercier@google.com>, 
	Eliav Farber <farbere@amazon.com>, "Gregory Price (Meta)" <gourry@gourry.net>
Subject: Re: [PATCH v3 0/4] mm: fix races between huge and non-huge faults in
 PFN mappings
Message-ID: <awg3r1kVqhQy7wlZ@gremlin>
References: <20261125-huge-pfnmap-fault-races-v3-0-bbc44489341b@kernel.org>
 <dc62bf2a-9188-4cc6-9850-14ab3a2e5274@kernel.org>
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
In-Reply-To: <dc62bf2a-9188-4cc6-9850-14ab3a2e5274@kernel.org>

On Thu, Nov 26, 2026 at 02:26:37PM +0100, David Hildenbrand (Arm) wrote:
> Dropped v2, tried to apply v3, doesn't apply.
>
> Against which branch was it based? mm/hotfixes-stable?

mm-new. I can resend against mm-core for-next-fixes if that helps?

Only one patch is changed anyway - patch 3/4 'mm/memory: do not report OOM if
insert_pfn() races a huge fault'.

Let me know if you want a resend!

>
> I this really urgent stuff or can this wait until the next merge window?
>
> I had v2 staged for the next merge window.

It's currently broken in linux-next so you probably want to fix _that_ next
sooner rather than later to avoid further reports :)

As to the urgency stuff, as far as I + claude can tell nothing crazy here, so
can wait for 7.5.

OTOH I'm not sure how I feel about the triaging for hotfixes stuff, it feels
like it makes it random what gets taken for that/not (if you sent a hotfix early
more likely > late).

Also meanwhile Linus moans about that but then took a 41k line 'hotfix' PR
from ext4 ;) https://lore.kernel.org/all/awW86EI5fYafQx-o@mit.edu/.

Anyway nothing to get too worried about here, as long as it's queued.

--
Cheers, Lorenzo
