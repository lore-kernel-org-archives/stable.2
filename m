Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795687017;
	b=16K+Vo9ozo3mCjHwQXko0jyvlut9pjxrEzZFIzLoEbo8DCwYlTaBvC+sHCaIBcch1h2q
	 Hs6qrDrtnkXQWK2R3QKQDP3cGioz7jp4y681VnRMGas4Um3eTMurzTGCJ4Qf4bsTl0anG
	 3Ybs2+sX+YNb1BVyaVhZKFqHYTu1oZWYzvCyMb9JvQ2+kJvgd37DQk+26tGxr5MPBO/EU
	 cD1B0oHDLNRyUjC+6e93Dw4pqUehBye4pG7BbaVv3EfAGzKxBeoV8fWc2JsZsTEO2gJ2q
	 St1U+Fj96GpgMS54DRZl+KFUQQExN8+zWdCi0Af2M6rtRY8vG6BPWeeEBvYaNNgM6TA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795687017;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=rHK7ugbX/RMzKr1pPu3mSFVGP/fH09WdJS5CXhJ99Os=;
	b=jn5aPSeckkVHXHrAnFZ0IzAdZEnIxFvkjKYokWGIiUWGiip9Lhl9gm+Q7aGWmnSv65tG
	 kzh/AMAui+lHwpALTSRJXQRlYGiKGRUywSBEMmD0wGOparbud5vAiXRUtbqZHxJdGHeUH
	 TTR0LPF8Dx37UkUVnsI07WF1IbtN2b+dosi2e0QgjijC6f5xf64QK616hsKomxzxgIAKQ
	 TGGt5ytcg8lmdIZdMuLycU3yTA18frZOvyEkUzoSRlU9OrjjpMOXBKHQ6w9PjprVxQBwu
	 hFS4BSnawCV8gOLaisPymhH3O/oOR0OwuPekN/3HVZEI3Xs8ctrk/DUDqgQJcM757XQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GPX3Wl7F;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9699606A326;
	Thu, 26 Nov 2026 09:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GPX3Wl7F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D7271F000CA;
	Thu, 26 Nov 2026 09:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795687017;
	bh=rHK7ugbX/RMzKr1pPu3mSFVGP/fH09WdJS5CXhJ99Os=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GPX3Wl7FbyrIagF0lBQcklbIYOAvUqR6p5Gv6f96/HnRYBZmrEtooA3U/Z5iwLVRN
	 nqqse/UGgLqHu9GagDHI2Ze48A+pQkaoRfPVxaHpoqrzOmdMbor3I5P7Z5XmyOpVqv
	 xkNO6H3QrQEv3ltZAjqFykTRczJXaZG4fshFSPKWR3og8XGF5wkNLGRx+LGW4qXLLT
	 513Y8RscNvzkHTW19JX7h7C0BAwpG5J3qzeGzYs9+9xiNFNEk1sTCBXBTbYGSQg4sk
	 /Msat1+pLGMQjnHu5/sTJOtSc22pw3hCEnkuNNgZJE+3iZLt9ZafFH0YxGcicdXgXr
	 P7Z6duZTQxNOA==
Date: Thu, 26 Nov 2026 10:56:40 +0100
From: "Oscar Salvador (SUSE)" <osalvador@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jinmeng Zhou <jinmengzhou22@gmail.com>,
	Hongfu Li <lihongfu@kylinos.cn>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Dave Airlie <airlied@redhat.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Gerd Hoffmann <kraxel@redhat.com>, Mike Rapoport <rppt@kernel.org>,
	Mel Gorman <mel@csn.ul.ie>,
	Dave McCracken <dave.mccracken@oracle.com>,
	Andy Whitcroft <apw@shadowen.org>, Adam Litke <agl@us.ibm.com>,
	Lorenzo Stoakes <ljs@kernel.org>, Rik van Riel <riel@surriel.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>,
	Jann Horn <jannh@google.com>, Lance Yang <lance.yang@linux.dev>,
	James Houghton <jthoughton@google.com>,
	Yang Shi <shy828301@gmail.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Pedro Falcato <pfalcato@suse.de>, Gregory Price <gourry@gourry.net>,
	Zi Yan <ziy@nvidia.com>, Joshua Hahn <joshua.hahnjy@gmail.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Byungchul Park <byungchul@sk.com>,
	Alistair Popple <apopple@nvidia.com>,
	Wanpeng Li <liwanp@linux.vnet.ibm.com>,
	Andi Kleen <ak@linux.intel.com>,
	Kenneth W Chen <kenneth.w.chen@intel.com>,
	Hugh Dickins <hugh@veritas.com>, Michal Hocko <mhocko@suse.com>,
	David Rientjes <rientjes@google.com>, Joern Engel <joern@logfs.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, Michal Hocko <mhocko@suse.cz>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
	"Kirill A. Shutemov" <kirill@shutemov.name>,
	Sasha Levin <sasha.levin@oracle.com>,
	Guillaume Morin <guillaume@morinfr.org>,
	Wanpeng Li <liwp.linux@gmail.com>, linux-mm@kvack.org,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	linux-doc@vger.kernel.org, Chris Mason <mason@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH 02/21] mm/hugetlb: fix truncated copy result in
 UFFDIO_COPY
Message-ID: <awgCWBs4rkuTTxBn@localhost.localdomain>
References: <20261125-hugetlb_fixes_2-v1-0-db27fd2f71a8@kernel.org>
 <20261125-hugetlb_fixes_2-v1-2-db27fd2f71a8@kernel.org>
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
In-Reply-To: <20261125-hugetlb_fixes_2-v1-2-db27fd2f71a8@kernel.org>

On Wed, Nov 25, 2026 at 11:33:00PM +0100, David Hildenbrand (Arm) wrote:
> From: Chris Mason <mason@kernel.org>
> 
> Folios that span more bytes than can fit into an unsigned integer (e.g.,
> 16 GiB folios on arm64) are problematic with UFFDIO_COPY: the result
> from copy_folio_from_user() can be truncated, possibly indicating
> success instead of an error.
> 
> We will then continue with the folio that has stale data, and make it
> accessible to user space.
> 
> For example, if copy_folio_from_user() fails such that the number of
> bytes not copied is a multiple of 4 GiB, we'll get an effective ret ==
> 0.
> 
> Let's fix it by simply testing the return value directly.
> 
> This has medium urgency, as it's an information leak.
> 
> Fixes: 8fb5debc5fcd ("userfaultfd: hugetlbfs: add hugetlb_mcopy_atomic_pte for userfaultfd support")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Chris Mason <mason@kernel.org>
> [ david: cleanup code and description ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Oscar Salvador (SUSE) <osalvador@kernel.org>

 

-- 
Oscar Salvador
SUSE Labs
