Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794510764;
	b=cEUIECiSI6KVyQFJ3CiOv01/UvPSM5o8uk7FlJsZIWI7MVCvvVdDTFl4hZ8283Af9uWl
	 mv0npYJofMuelCDfhgY01DMz3g+BuuTPdIpjGD3ThEPhF5YCJMaCgrpJ4SiGZ2rtx6u9I
	 Eq5Tmaktl38VZYCoN3FoDgVEfP9MC+Cfh1H2GJBIHlv4jhxqQ+ps/iGeXX3OG5CkgfxvX
	 lQNtkX9n1ydLXVh++Cw6bA/vDboY73/e1YmsBgaH7zvfkFPDFijA5eI04PZT6YIYs4dj1
	 iOcfENkwGHEHF3e73EWOSgNSF/ON8oVqquhRdKiG2ZDahQop5qO92yKsIE/AFYxU5JQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794510764;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=7j0/jh5K7WkVjbCX+ro6AcPTgGQkDu7OOgaa2OHvFf0=;
	b=LHY4uTA3LeWOuIsXfstwoK8TjqGCz5i/8XYtT3+mUqD31M3qY3Br+pD4ByH3pj3xIvYf
	 OeJd+GmvG4P3OyRYLUSrshdGs/V44wdteXN3n2PO0nVV2VFNRgow3qsXImpsLhMJ+mcGT
	 l+/Fqo2f8QR2XKGVNfFUgHB7ew5wvm7BCgYVeuMpoFV2W5gT08ZqEia8AtlvjjHCs9tY7
	 DTGjp6wbiMaZ9IDSG2d0EsG8cQtEEy55oli4vBT25e8Gl76GsKnYoc4iq6Phb9cQRoopF
	 AqmfajuHpUdEAOdUqdUEJMQnSX2GHBQFBh57io57HByD3s/H9owWSE3c4L1UDyRbCgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X2DcnQfi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D85F606A8A8;
	Thu, 12 Nov 2026 19:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X2DcnQfi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35DA01F000C7;
	Thu, 12 Nov 2026 19:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794510764;
	bh=7j0/jh5K7WkVjbCX+ro6AcPTgGQkDu7OOgaa2OHvFf0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=X2DcnQfispasGV6jq7eKqrWXQYe9QdoB0WVIKnVBn+qVUXoDQaMa2JP35NqG0rUDZ
	 Yrmii1CSQ2kC+kVMFrVPqXYqjbzLC+HPEtZK2S2L8c6rNB2GFxYyNJPZ5sRzmWjMFu
	 +dIYoXUFT/gQ+opKnKXgubaf3HqIYUBd2dghgWCQthT19T/pjLsHIlhSv2PdGSxZ72
	 Y6caRTdN4ASxjDMe8nlGd346MADQ4oacttKHM+fIxsG0Y7JqOVkTW9E8QoISZYwDzA
	 cnXP1rnM8wHxMGKeIsrR63rxWcT49L3AMLJO5Cgb7ay9St5N9w6vYoCxGoRx1+yipR
	 fXEha8CbDyJjw==
Date: Thu, 12 Nov 2026 19:12:32 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "Gregory Price (Meta)" <gourry@gourry.net>
Cc: David Hildenbrand <david@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Usama Arif <usama.arif@linux.dev>, Kairui Song <kasong@tencent.com>, 
	Balbir Singh <balbirs@nvidia.com>, =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>, 
	Kiryl Shutsemau <kas@kernel.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Christoph Lameter <cl@gentwo.org>, Peng Fan <peng.fan@nxp.com>, Josef Bacik <jbacik@fb.com>, 
	Chris Mason <mason@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, "Borislav Petkov (AMD)" <bp@alien8.de>, 
	Mark Brown <broonie@kernel.org>, "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org
Subject: Re: [PATCH 07/13] mm/migrate_device: look up fault folio after a
 split
Message-ID: <avYPiLcx5okHyOZG@gremlin>
References: <20261111-mason-migrate-et-al-fixes-v1-0-3d2454362e8d@kernel.org>
 <20261111-mason-migrate-et-al-fixes-v1-7-3d2454362e8d@kernel.org>
 <179450492332.482102.8905567682196853763.b4-reply@b4>
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
In-Reply-To: <179450492332.482102.8905567682196853763.b4-reply@b4>

On Thu, Nov 12, 2026 at 12:35:23PM -0500, Gregory Price (Meta) wrote:
> On 2026-11-11 18:13 +0000, Lorenzo Stoakes (ARM) wrote:
> > From: Josef Bacik <josef@toxicpanda.com>
> >
> > migrate_vma_collect_pmd() looks up the folio of migrate->fault_page once,
> > when it is entered, at which point the folio is locked.
> >
> > The fault folio is assumed not to change after this, however if
> > migrate_vma_split_folio() splits a PTE-mapped large folio which contains
> > the fault page, the fault page ends up in a different folio.
> >
> > Resolve the issue by looking up fault_folio again after each restart of the
> > walk.
> >
> > Fixes: 022a12deda53 ("mm/migrate_device: handle partially mapped folios during collection")
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > [ ljs: pared down commit message ]
> > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>
> Was able to reproduce this, and i think this also reveals (and fixes)
> another bug in Nouveau (memory leak).  I think the Nouveau driver still
> needs a patch, but this otherwise looks correct.

I think there was also another in the series that touched nouveau actually
also... worrysome :)

>
> Tested-by: Gregory Price (Meta) <gourry@gourry.net>

Thanks! :)

--
Cheers, Lorenzo
