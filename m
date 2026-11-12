Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794510323;
	b=sDrcID2HRxr1XYHjPk1SByCKuqa8dFfceLZdpb9UkqLtB6xQu6SyG+Js2fWZYEvqwopl
	 m3Hg4/xvFiaVYJjZGpMb9ZNRfPGg3wGyix5SjQwxQld8/J0Y0ps3bPCST9Uyab5jWmxw/
	 O49XBQbedFc1E7C0Q2UtfBC24Cxh+iNBhpWzQ1vBziHDP8/1PlLRld22UpIeZxOO/IkgF
	 sK+cBLUrcpSzUP3MkowDa7C+5ySewihgR3KH5AxtoiKZ1Jx01TyPzOaNFa1flPO2mlEnT
	 pYHEHe5Bk+F6Z74x7DvhHZzpCc6sI7nnEQQwNZB14ISeBUOqup5uh9T5vP/XkG0mcdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794510323;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=DlAcOR69Sgyo6744hoqwcMZzZ6mU9x3ks7Z3NCbX8Wc=;
	b=jtHLtWDoGvp8KFcAHlN6BwSVi9VYRmPcm7pp159L0+iuX3r5hQEiuxn1IwBMFU/cVtxW
	 wM/AKuDVVkYVX+jyVyvQdm9HAhY2nhUYPGwzka7eVIzwXaS74HEFKDUeeSEClpVRP4TEc
	 unATa8z1NkXVJFGIXcfwve8DU4+WeL5KKbhbUP5TA44vs+lSVTcxiLj2E2edz9VEk+NMT
	 54Tw0lCdhiHFrahbOD7PS0kW/A0TPEnrA4BmsAOCjOp7QeGihn9LEJ4+vMBfRhRUSAk+X
	 Kef5Jqw6aZDX5PfM128KZ4B3p8MZh3r8eK3vK7ec7KTWSRulVYYpNh2xeWKR3eQt0zA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CXqmFHQT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D144606A31C;
	Thu, 12 Nov 2026 19:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CXqmFHQT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2C601F000C4;
	Thu, 12 Nov 2026 19:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794510323;
	bh=DlAcOR69Sgyo6744hoqwcMZzZ6mU9x3ks7Z3NCbX8Wc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CXqmFHQTRmv1gRj1r+pYbCbA8wHqWEzRRHyS8pfqO0TTrL+uMJ68pW9Cw4rMuUyUQ
	 IQZ9fs14ahUAid+leUsj9RpRJ3nno9JfuWnrJf4xVpTNsMk6APV19c/Q1+165+I4h8
	 ZxKs1t5LsuvSNVmLJBrQUR3oxP4IvIwsU5WrY1GAKrRnW+J+EVEOAX/lHFdmqjhZsI
	 6jmKil9NC8S0AXK83iEBO4AJd/1BRLpkrYX/+CH20b3dlAyQyC9hb6P/XGpm2c56Q/
	 UGCnYKdK5A1ZJVoOO8bVctfLnV9Abu+lwPO5ibRHJYTWAUxoWJEimxjpYDdVwNDiI6
	 Zke8B84mfEeDA==
Date: Thu, 12 Nov 2026 19:05:11 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Alistair Popple <apopple@nvidia.com>
Cc: David Hildenbrand <david@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Usama Arif <usama.arif@linux.dev>, Kairui Song <kasong@tencent.com>, 
	Balbir Singh <balbirs@nvidia.com>, =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>, 
	Kiryl Shutsemau <kas@kernel.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Christoph Lameter <cl@gentwo.org>, Peng Fan <peng.fan@nxp.com>, Josef Bacik <jbacik@fb.com>, 
	Chris Mason <mason@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, "Borislav Petkov (AMD)" <bp@alien8.de>, 
	Mark Brown <broonie@kernel.org>, "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH 09/13] mm/migrate_device: fix use-after-free of the anon
 rmap
Message-ID: <avYNv-bmQAGE0ktf@gremlin>
References: <20261111-mason-migrate-et-al-fixes-v1-0-3d2454362e8d@kernel.org>
 <20261111-mason-migrate-et-al-fixes-v1-9-3d2454362e8d@kernel.org>
 <avTzHDlCiaNSzhtX@nvdebian.thelocal>
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
In-Reply-To: <avTzHDlCiaNSzhtX@nvdebian.thelocal>

On Thu, Nov 12, 2026 at 10:04:10AM +1100, Alistair Popple wrote:
> > Resolve this by pinning the anon rmap of each folio which possesses one in
> > migrate_device_range(), migrate_device_pfns() and
> > migrate_device_coherent_folio() before its PTEs are replaced, and
> > unpinning it once the walk is done.
>
> I was going to ask why this wouldn't also be an issue for migrate_vma_setup()
> which does something similar. But in that case mmap_lock is held across setup
> and finalize which I guess is what saves us there?

Yeah, exactly.

--
Cheers, Lorenzo
