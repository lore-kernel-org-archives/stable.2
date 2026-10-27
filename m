Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793089337;
	b=fnGinr6dQmCqb+Es6HCI7vZvdkrDBetQeUmVtY2BfanKvoUv944846ZIRNm9y9H7v7nX
	 H9SS+yFkXOfN/NIQ/mFx+ekdnc7944nY4p2vg8AK7t5jfXwuhkOtgfpCHLR2zIH1ck8TE
	 nz0GaAJT5pVqMA1xi1i+HNgPhtehmm+MQ3RYqyd5UTxAT7rt1k55DvSGFznaBTq8vSjKB
	 YMvJsWQuSLRoA+YIc5g/tl0NZ9I6zfRextGiFwycmca31Y+I52uBTvPsCQGBgbhCFjYgf
	 p9M2KCBKg8fH85uLh7Wu5e+X0sVkOlLd9JEJHNU20YVYDG9AEBOUtz9HUmwMrzDtjnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793089337;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=F88x0w6RcEa+c5taIt0Fmt+oPbV+qXUJjPjIECkCifM=;
	b=M6X4yo5jwel8zkxyU9TFt07DwsVOGDkRitqcOT4Qg25rrJxu7CMUT2wZ3aJ2401bV6v6
	 IL4No/DogJvJafMlwv6vUiTaomYa0HBOf86T+ZauGj28AiRsVP0Hdi7dz85YDFG2IgVHj
	 ipiRRVqLhFIfHKmZ8RkeP5jCvkioXgvC1J0WmhT9KjtiSp113O0uNL31AmHHZrHIclwPT
	 zpHThuKlfjJlue3oJzTpXFiJDjM3j9vqUR2Qr5g4P37zyZ6tgQ3a7d9M+BffRlc7yo6u7
	 cfSHx93nY8IqEJ/dj+11OmnkrXHLXTwlwQBHZ1CzPNTlCoTmQojKkI4u71NGt/iwsQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XcnbEhAI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5DA606A31A;
	Tue, 27 Oct 2026 08:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XcnbEhAI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 132EB1F01825;
	Tue, 27 Oct 2026 08:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793089336;
	bh=F88x0w6RcEa+c5taIt0Fmt+oPbV+qXUJjPjIECkCifM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XcnbEhAIT53D3Hun+lr/E6g8U6iRmEJKDft/fCMNmTrAnwk0hAOsyjOokbVPvXEp4
	 /DPpT5Su9B/w3gWyP9HIp6tCbM8SpfFZQEHmk9xZRAFv8vtovKBHP6oMqM2laor/ar
	 P09hpU7MLdF9KtuqzyyOT3LFejOV+LPLAbIgOliERfOsJ89eZuESqQurxPzGdarj2T
	 8EyrmmZ5UZbvTI7dzlnWbVesHv53x07RfUr1UgzVZx1w/Da9SXe+VMmXlfYIiXPrGF
	 gCrBiBDheLyK5D4iKWh7VKsJm6UWGTipezUjwklfkuNFfwKK/QHJ4IhVCDB+Sy/wHO
	 TpCkfYmmCp5fQ==
Date: Tue, 27 Oct 2026 10:21:54 +0200
From: Mike Rapoport <rppt@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>,
	Barry Song <baohua@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>,
	Lance Yang <lance.yang@linux.dev>, Rik van Riel <riel@surriel.com>,
	Harry Yoo <harry@kernel.org>, Alistair Popple <apopple@nvidia.com>,
	Nico Pache <nico.pache@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
	Matthew Brost <matthew.brost@intel.com>,
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>,
	Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Nick Piggin <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>,
	Minchan Kim <minchan@kernel.org>,
	Muchun Song <muchun.song@linux.dev>, Xu Xin <xu.xin@linux.dev>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Chris Li <chrisl@kernel.org>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Youngjun Park <youngjun.park@lge.com>,
	Gregory Price <gourry@gourry.net>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-cxl@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 25/46] mm/userfaultfd: wake waiters when registration
 modes are removed
Message-ID: <auBfIuDnoICBXoGj@kernel.org>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-25-6f74bec9a5bb@kernel.org>
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
In-Reply-To: <20261027-fixes_core-v1-25-6f74bec9a5bb@kernel.org>

On Tue, Oct 27, 2026 at 12:17:45AM +0100, David Hildenbrand (Arm) wrote:
> UFFDIO_REGISTER can replace MISSING or MINOR tracking without waking
> faults that are already queued. For example, switching an anonymous
> range from MISSING to WP leaves a missing-fault waiter asleep until
> userspace explicitly wakes it.
> 
> When a registration change removes a UFFD mode, wake waiters in the
> affected interval after updating the VMA. The VMA is write-locked at
> this point, so no new faults can queue under the old modes and woken
> threads cannot retry until mmap_write_unlock(). Waiters for retained
> modes in the same interval may also wake and refault.
> 
> The hang reproduces for MISSING-to-WP and MINOR-to-MISSING transitions,
> with both read and unread fault events.
> 
> Fixes: 63b2d4174c4a ("userfaultfd: wp: add the writeprotect API to userfaultfd ioctl")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  mm/userfaultfd.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)

-- 
Sincerely yours,
Mike.
