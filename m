Received: from mta1.migadu.com (out-193.mta1.migadu.com [95.215.58.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813553F0A92
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 08:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788339165; cv=none; b=drE1jgw7dVsxfKFvcAYSGSTWSXuRQu2U0tRTmVH9tmzsMvFkYpqRlpbzsGtYfzZ6WRnO8CwF/AF2OnNZpSaRD/0vd0Au66XZqKbAbepelo8U7pYpqjTSUcy8IypCRRd9DdcY8+eiXFgDa3kpPH3AT5pxU7sL7JuK2ulazaghS38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788339165; c=relaxed/simple;
	bh=xDVzMeg650MunH9/kpFZMjCl6QAJ9c1jDh4WC3/q5t8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=KHRIoTYFKgcTY6aWeuAUDfT4XRVQMOvhxN28z0rtjXgyLyqSNHIiWF8PK3DCzE1eEGK2Z4HIDDk7L4C8hrqVZcR3OKMGOq9JkrkWlYi6XUW1dS6h1pF6Ua/3CRtSlugML5W49QTe0ecA1tXkAVAsDcH58xNWeLMjPFEhqWeLM0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=C8erkTWr; arc=none smtp.client-ip=95.215.58.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="C8erkTWr"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=xDVzMeg650MunH9/kpFZMjCl6QAJ9c1jDh4WC3/q5t8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788339161; v=1; x=1788943961;
 b=C8erkTWrVaAmiyQ5xUjlXdZ+1BgyEimKZ4jqeLEuc5iK/hPhO07eF8+kmp2JuwY/VFTeO5KH
 9KXWg4cSXp4ko5fbbtdHAu5PIdSbn46ZrgJuYHeM60DjLP96bTJ4uXEO9wRywTs7wLrsU0O6+8W
 va5KTqtV9YdHg2SaucB7/6Ko=
X-Envelope-To: stable@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 8c8624c68a37385f;
	Wed, 02 Sep 2026 08:52:40 +0000
X-Mizu-Trace-ID: 8c8624c68a37385f
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.700.51.1.1\))
Subject: Re: [PATCH 1/2] mm: hugetlb: Return -ENOSPC on memcg charge failure
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20260902-hugetlb-alloc-folio-memcg-charge-error-handling-v1-1-e3e8942c141b@google.com>
Date: Wed, 2 Sep 2026 16:52:20 +0800
Cc: Alex Shi <alexs@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 Dongliang Mu <dzm91@hust.edu.cn>,
 Hongxiang Lou <louhongxiang@huawei.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Joshua Hahn <joshua.hahnjy@gmail.com>,
 "Liam R. Howlett" <liam@infradead.org>,
 Lorenzo Stoakes <ljs@kernel.org>,
 Miaohe Lin <linmiaohe@huawei.com>,
 Michal Hocko <mhocko@kernel.org>,
 Mike Rapoport <rppt@kernel.org>,
 Nhat Pham <nphamcs@gmail.com>,
 Oscar Salvador <osalvador@suse.de>,
 Peter Xu <peterx@redhat.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 Shuah Khan <skhan@linuxfoundation.org>,
 jthoughton@google.com,
 fvdl@google.com,
 rientjes@google.com,
 vannapurve@google.com,
 Suren Baghdasaryan <surenb@google.com>,
 Vlastimil Babka <vbabka@kernel.org>,
 Wupeng Ma <mawupeng1@huawei.com>,
 Yanteng Si <si.yanteng@linux.dev>,
 linux-kernel@vger.kernel.org,
 linux-mm@kvack.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <8C2135DF-25DF-4D88-B2A5-B5F7440E84E4@linux.dev>
References: <20260902-hugetlb-alloc-folio-memcg-charge-error-handling-v1-0-e3e8942c141b@google.com>
 <20260902-hugetlb-alloc-folio-memcg-charge-error-handling-v1-1-e3e8942c141b@google.com>
To: ackerleytng@google.com
X-Mailer: Apple Mail (2.3864.700.51.1.1)



> On Sep 2, 2026, at 16:22, Ackerley Tng via B4 Relay =
<devnull+ackerleytng.google.com@kernel.org> wrote:
>=20
> From: Ackerley Tng <ackerleytng@google.com>
>=20
> When mem_cgroup_charge_hugetlb() fails with -ENOMEM, =
alloc_hugetlb_folio()
> currently propagates this error. This results in the page fault =
handler
> returning VM_FAULT_OOM.
>=20
> Because HugeTLB allocations are high-order and use =
__GFP_RETRY_MAYFAIL,
> they bypass the OOM killer. Returning VM_FAULT_OOM to the #PF handler
> without triggering the OOM killer (or having it make progress) leads =
to
> an infinite loop of retrying the fault.
>=20
> Avoid this loop by returning -ENOSPC when charging fails, which maps =
to
> VM_FAULT_SIGBUS, terminating the process cleanly.
>=20
> Make mem_cgroup_charge_hugetlb() fault handling use a common error =
handling
> path, the same handling used for =
hugetlb_cgroup_uncharge_cgroup{,_rsvd}(),
> which also don't trigger the OOM killer and hence opt to terminate the
> process with a SIGBUS.
>=20
> Fixes: 991135774c0e0 ("memcg/hugetlb: introduce =
mem_cgroup_charge_hugetlb")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>

It looks like someone fixed a similar issue before, but I don't remember =
the
details. Anyway:

Reviewed-by: Muchun Song <muchun.song@linux.dev>

Thanks.

