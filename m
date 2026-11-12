Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794493684;
	b=coQCBmVgVMI2OGUvCk273gv00hViD6G42G0cGtZy7JiuGIgoRjR8ZMbv4Xu90+7yhbXM
	 Iiua9AK96K6bb6GFI14RoIVZmEBgy4tHHba0TlTxvqPRIE8zrqj7gf6Kd2WHMl2UYeewr
	 QfGibWSsEMejGEQbVwfcxNUX/g8pdi+P0m/r2KHG+HYYRnHCmtwj46XLjIUw8RegLFOzs
	 e0Mq+TERVlLdWEzsYz4CjDJmQjplanuA6bXr75k2ltZ5za1YNdQCl/gmGvMdBVzC+GKWi
	 jRzw0IpAPwBiwoi4resPf1HJeSQs0ZlRnyZ+1cHhdu+JC09vDS1B8MJL7y5lcH9WhmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493684;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=LRCFxxK72YnuYLXCePfEDWC2leUkT+Fr7VmdbYfYzpw=;
	b=T1JT5zQKMwhYt5pB0hXGb86sY5AHNOnw4cJSDThY3pHxBjbsoUpo9HTSS5+mLxQS/NL0
	 iT0WwVWh30XCcbiDLcrEp5rYNVg4v/WD110m1dtvwJaT50CSIDfAvDfLQtW0JvbIhAqUd
	 LPGC1MAC15Io1g1OPyMHqkFwBAWkpsLhuojEWB1ZlZwxZhpLEntLybQlpsxvONB4TuDvI
	 ksP8TzVVBS8cLfDUrBgyuFLbAPWQzLXB2M7FM43g53cie50HZOlIbBaO3z4QC3PGBJWV9
	 c+b9B7rLsw6xKbhULhEWR6HUeudI+rj7hyRHr0G7QRjyxr6yiB70T97CUJ+XC2e4OSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="E/IA795s";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D16606A327;
	Thu, 12 Nov 2026 14:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E/IA795s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D8571F00A05;
	Thu, 12 Nov 2026 14:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794493683;
	bh=LRCFxxK72YnuYLXCePfEDWC2leUkT+Fr7VmdbYfYzpw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E/IA795sioaIfUe5qJXcEcdduAIziyMy8hiAZpvRh6fKvAW+9knanXwBHPspQALOg
	 ZeVR6HwnIRrEusAhXaXTCxdYNLE4T3lsb1TvklUJekS+PtEiiJmvFPsNrplx4tzuPZ
	 Y5px27vNcmX5N7MFzZYoae5VbJ/IDYwisbMam9uf1aZ6pV0yBCKk2zEtfNLUV/yaRf
	 /Mefjj9cFsRf9nbJy6sX2ZSD6slH3p49/kYAEQjmTvrF60oAbkHMKmOozpcNjE4Zdt
	 UXFnscDz/wzrVzSOk/WB1oALyaIdIynYt2+A8zHlxvKEq4YIRPE0Tw/retoTNVlnbq
	 YFpOlDq9yndkA==
Date: Thu, 12 Nov 2026 14:27:51 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Michal Hocko <mhocko@suse.com>
Cc: David Hildenbrand <david@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	David Rientjes <rientjes@google.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>, Usama Arif <usama.arif@linux.dev>, 
	Kairui Song <kasong@tencent.com>, Balbir Singh <balbirs@nvidia.com>, 
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>, Kiryl Shutsemau <kas@kernel.org>, 
	Yu-cheng Yu <yu-cheng.yu@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, 
	Peng Fan <peng.fan@nxp.com>, Josef Bacik <jbacik@fb.com>, Chris Mason <mason@kernel.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	"Borislav Petkov (AMD)" <bp@alien8.de>, Mark Brown <broonie@kernel.org>, 
	"Dennis Zhou (Facebook)" <dennisszhou@gmail.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH 01/13] mm/mmap: free gathered pages before MMF_OOM_SKIP
Message-ID: <avXMvdu-R_Fjrt7U@gremlin>
References: <20261111-mason-migrate-et-al-fixes-v1-0-3d2454362e8d@kernel.org>
 <20261111-mason-migrate-et-al-fixes-v1-1-3d2454362e8d@kernel.org>
 <avWmfXu39vtp0DM9@tiehlicka>
 <avWsG-zmuniUFio7@gremlin>
 <avW1s2wvz1PB0-Ln@tiehlicka>
 <avXJPw17fWvLtCO8@tiehlicka>
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
In-Reply-To: <avXJPw17fWvLtCO8@tiehlicka>

On Thu, Nov 12, 2026 at 03:12:15PM +0100, Michal Hocko wrote:
> On Thu 12-11-26 13:48:53, Michal Hocko wrote:
> > > This only matters for the OOM victim, hence reinstating MMF_OOM_VICTIM, which
> > > made the patch _way_ smaller than the one proposed :)
> >
> > Should we simply do that flushing unconditionally before setting MMF_OOM_VICTIM
> > then?
>
> Sorry, I was caught in calls and didn't get much time to think about
> this.  I have only now found some time to look into that and to do the
> above we would need to make tlb_batch_list_free visible and conditional.
> Which is a bit of undertaking, not anything major but still kind of
> ugly. So your solution seems better in the end.

No worries, and yeah, I went through this one a fair bit to try to find the best
way of doing it but I think this is the least invasive way. Tricky one!

>
> Please clarify the changelog wording to be really about this and with
> that

Will do!

> Acked-by: Michal Hocko <mnhocko@suse.com

Thanks :)

>
> Thanks!
> --
> Michal Hocko
> SUSE Labs

--
Cheers, Lorenzo
