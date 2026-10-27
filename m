Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793109365;
	b=vwUy8ghiD/DEkXnltejvUw1YjNUYplQPP8DoyH54/5rKOPVgrADK7uD/k1uPfwOF21qF
	 0v6f+rMwJCihSJmqWt1EOjz2yb4dpazwBJh11La6SjNnMiuSOmpqQLkk8dXkHHG2d6QLv
	 8THb6r9nMjr7LwCOgUxiLJPdpJJIXNbYPFh2/dWhQ+UHdsRUCSvx630AJMuNzX/Ovw2XC
	 eoyIizJY/BxRWUHmjwtrlEGVuHBUtSbbxHJNbPRNPoEhsEe81EpSnQdsjpkNwNItavQKy
	 egkBNcmnuhu4uZmKttfCcnN4w87kcD1OoxiSYR+9M3h+WGvut3L/YyQ3fyr3XmTLoDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793109365;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Zr1jTThDFAddOSK457sc66293xmVyHCCi9iGlWUeddU=;
	b=sTn0sPUqmFAiDPy8q4VCKVadAtQ4U7hzk36VR7xSnNVqJ+5EPk14VKvEKtsRzrEUA+0q
	 op1OPE+AGKMxtlBC/t4J1a+XK2L5dUfiljQ7Jrn/JwY+Xovh+XFuSuljgXMZFnFYayagG
	 A9rhU2zthJO0D6dqxXS6hhvcbJ4pM9k0x7/kjWUs2rPnLGDAIgR+OOfM9cMflS8n2ezrj
	 Eyj42HhNQd+p3ajGytJbWWYI4BB6vLdNanhG42lp5b3RVBxomK/winobZI0QsE4SpHJdy
	 o46wu3sWbHm3PYM5psYlDRKlJUdHpUaj8aO0J55ixiAi8exC7bvqD1EDugpkRJw2UIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jIhYLNBN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E5C606A320;
	Tue, 27 Oct 2026 13:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jIhYLNBN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B17E81F01825;
	Tue, 27 Oct 2026 13:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793109364;
	bh=Zr1jTThDFAddOSK457sc66293xmVyHCCi9iGlWUeddU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jIhYLNBNpp0NexZNmMUHOUCY+eEy16NfWjuSuwLJqmFHwNWPY9BdmcaHZW+1fGIg9
	 fiBkl7KehfwTpd4R+QE8pIbz2ex/lWNl//inoU+svKsu/oI0sqh9JGs4nayk/63cZa
	 PuQtRNz2s2eqW5o62hUTfQo+difIHb2bfTQI3wmFE48eH1hqvasX2J061wIVJ/8XLp
	 B8iwzzJIHvVnrgkO1CLMhM/dtnxK1pMp932wcPpTyDMf/mtjlI6T7bM2e0ImgLpb5G
	 itjSlM0i78ybkEbvAJ0jTU2GNXWaOjkHSgMcq3b5iw8EB94IUavJ0yBcssBsMi8xzh
	 0HHSAVhaSG0Nw==
Date: Tue, 27 Oct 2026 13:56:02 +0000
From: Harry Yoo <harry@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Baoquan He <baoquan.he@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Hugh Dickins <hughd@google.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>, 
	Rik van Riel <riel@surriel.com>, Alistair Popple <apopple@nvidia.com>, 
	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
	Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
	Nick Piggin <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>, 
	Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>, Xu Xin <xu.xin@linux.dev>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Youngjun Park <youngjun.park@lge.com>, Gregory Price <gourry@gourry.net>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org, stable@vger.kernel.org, 
	Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 02/46] fork: take mmap_lock before copying mm_struct
Message-ID: <auCtP8SCiHFcSGci@thinkstation>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-2-6f74bec9a5bb@kernel.org>
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
In-Reply-To: <20261027-fixes_core-v1-2-6f74bec9a5bb@kernel.org>

On Tue, Oct 27, 2026 at 12:17:22AM +0100, David Hildenbrand (Arm) wrote:
> dup_mm() copies the parent's mm_struct before dup_mmap() takes the
> mmap_lock. A concurrent brk() can leave the child with a stale mm->brk
> and newer heap mappings, causing later brk() requests to fail.
> 
> Other operations (e.g., PR_SET_MM) on the parent's mm_struct can similarly
> cause inconsistencies.
> 
> As a simple and robust fix, grab the parent's mmap_lock earlier. This
> way we don't need to update individual mm fields in dup_mmap() and
> keep missing ones. Stop updating the 4 existing members (total_vm, data_vm,
> exec_vm, stack_vm), as that is now no longer required.
> 
> Keep releasing the parent's mmap_lock in dup_mmap(), before
> userfaultfd completion, to avoid moving the userfaultfd handling into the
> caller. This should get cleaned up later.
> 
> Move uprobe_start_dup_mmap() to preserve the lock ordering.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Reported-by: Josef Bacik <josef@toxicpanda.com>
> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---

Looks good to me,
Reviewed-by: Harry Yoo (Meta) <harry@kernel.org>

-- 
Cheers,
Harry / Hyeonggon
