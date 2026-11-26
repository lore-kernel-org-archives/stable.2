Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795703045;
	b=2h8UL4kheu6CMQrUA6jQzf8hGlp3pkUmWNsdazQVsRrD5uMN/uyLR11DMVTFfa8F2ddV
	 iuISeU8FuIK/egG9aSondHQbAsqFZEYYGHTGPGNu+Ep4AoY6WZB4SHuqx3V15mZspI8Jh
	 LjYyJcVuj/OBxTV343RoVdHCrGnsujpEvBWkLFopk+Xd0vbZNZtR7WaqiNeA1ZdjMr4jZ
	 z+LFdGXIdDi/Nq7iXzBBUpbRvcF5TNkIm+Pp44cQzXyDD7R+pMf+NS5WkvSWfUxJFWzGL
	 RYFlGsV4OOOGFBDPkEzounDtwJ6HtTACKv0h3hGoJ7R/04YdmZAAlVRBxSJJq16f1oQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795703045;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=nGDviZu4wWbCw/94ZJVbbOlqdCrfKBOx/sMrkNJCHBs=;
	b=AKn1Y+IqYtCobl22D3HoTOtbxoX2A9ORTrv8RbEOlCnOuE/YfRDRZ+PjHG4JdaJIN74Q
	 7+NdmYbUaziKqJ5fuzgAHMJAoGNUAV7XdUOVK4ahUMbMM3Ph9UlEMlGWpT617/kFOm5YO
	 LBV1tl0qcRStP4/YF33EvRso38R84VX8fd/6FEF3Sm/89We7uVHBd1+vcr64i+PEqHaG1
	 Ytj3F5I1FVU8v/ZCf2JtarEe468VEvnhYM/v3LryNzb5A2vjQyKlsPnbTjKNcD5KumKgp
	 wammfY3OXsj1WOzPv8yMUBm6uk53u/Gvl3vE7mXivkEmOvf96FI+76Xs/Xb9HIm6rVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dJDPIgoI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A44606A31C;
	Thu, 26 Nov 2026 14:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dJDPIgoI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33AA41F000CA;
	Thu, 26 Nov 2026 14:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795703045;
	bh=nGDviZu4wWbCw/94ZJVbbOlqdCrfKBOx/sMrkNJCHBs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dJDPIgoIEY6adsxiBKLj31BpxdocV45Ho0ZXndsXTByUCNQSeqJbisV76kX96NGTm
	 lP8PTWZkBAGAaf4ROQhL4YqNqDUlIg+OsBLvEgyfgtkWB+XlbUoT0R/bzjR59GoZSP
	 N5+A4KpckrQdwruGKB/c/3DFMnTOqERUzcvPzJZpY/g4Kdxp2gDzUy1JYrmyX8XKYP
	 TXxxUruqjjJGGyB011S20azsLDh52IjKOk0t101eKEo/U3oNrczd8Vk1ozeO6EL1DP
	 x3OTUL1cheR2+0oIxHePd2pDgUmFL2xhTfFh30DsPsjg1hCIsQI/y4vtjeD7HByrbT
	 yF43DQKEx+kfQ==
Date: Thu, 26 Nov 2026 14:23:55 +0000
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
Message-ID: <awhAygxxEKQ7TVuY@gremlin>
References: <20261125-huge-pfnmap-fault-races-v3-0-bbc44489341b@kernel.org>
 <dc62bf2a-9188-4cc6-9850-14ab3a2e5274@kernel.org>
 <awg3r1kVqhQy7wlZ@gremlin>
 <e60ef611-5e67-41b3-9c5a-ade4d183c492@kernel.org>
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
In-Reply-To: <e60ef611-5e67-41b3-9c5a-ade4d183c492@kernel.org>

On Thu, Nov 26, 2026 at 03:15:57PM +0100, David Hildenbrand (Arm) wrote:
> Can you resent against mm-core/for-next? That would help a lot.

[ ... ]

> I dropped the series from mm-core/for-next and pushed the branches.
>
> If you're fast I can apply it there again even before I merge -next this evening ;)

Sure, on it, will get that out in a sec!

--
Cheers, Lorenzo
