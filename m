Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795659107;
	b=1FRAHy6GmnvlHO2fcpHm5agOqIH3RyVm9ELzuamNUTyKnrS0nhqDcJ3yk/MJQaBBO6OT
	 omzzCLDsCAy/TYO/gdaTl8n0RIL1jP4kiIj03raBeRhcKZEGZmOrHZWfI9b3YjP7ihfLI
	 4TTdjVhtQ0Xrj6hNxurHN1VSZUv1F41oL3Gi4Of6OZJLH55+vfxhFImn2lypKCCNBeLMS
	 VSAf5g+kt+noXCVYik+eKyXh+WMddqaDbOt6/k/uXp54QwbpvtlwKQz85s15LHMk+TLHD
	 csZ7UpE06YOmwOKarpX7aogu3wXfURrGsjOT/vpODzYQymy53AAsFBxOcT0qnGXLZHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795659107;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Content-Type:Mime-Version:Subject:From:
	 In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:References:
	 To:X-Mailer;
	bh=vtrF8jusFMf2lW/rRdAFBKENFPwZGZsrZsRLf4xeGz0=;
	b=CAAy497c6REMOgiCgJp5xQTOXl7gwhfRiIm0JZzTUqrNLVN8DVScoLPJ1ARPLsZW795n
	 IZ7/ALOJn3Ue//TJVRNUzQh8Q3JmO8XAtaJOohGLB74iHLBUcIjuK7OEkUU1LL2sHYWvJ
	 o1rC29BYBDW16Ddh2VybDWJ20nZVkfLi9M520YBmUV1XDapTE2aSj7D/Q1/QYomjsW5yf
	 9yT38IY8mrRSI7hiJ7rYnmWt0MiyJ2TnQcrZOAyEqT2obKfyfi6L2hWQtZRkvtBZkXMQb
	 ewZu/AgrtJVEOdTE7QM5kISKpcMZdJipum9fggQFeoWjFji6100V7AJC6Y5FjMBG4jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=apKRlw4O;
	arc=none smtp.remote-ip=95.215.58.211
Received: from mta1.migadu.com (out-211.mta1.migadu.com [95.215.58.211])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B05606A334
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 02:11:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28B05606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=apKRlw4O
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=BHZECrat/VYigSRXJnPVnKZEhBZ342/Z/aVBvJO8P8c=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795659104; v=1; x=1796263904;
 b=apKRlw4OJ/iUTjdTjtKfmaZvZmP93yrnR4YaVPWtyMoZpH0zA6JBpaw9dLqt5qDJ+RImpECE
 wnRo5WHV+Qxab5pOo6vNUjz+XagG9FYJB5Set5pLSD2SJXL6XvHP46fsyNf6WkNQaXG1s/LffBJ
 EtT8x5Zz88Sudde189gYg8NM=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 925c7fbcc772d409;
	Thu, 26 Nov 2026 02:11:43 +0000
X-Mizu-Trace-ID: 925c7fbcc772d409
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain;
	charset=us-ascii
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [PATCH 18/21] fs/proc/task_mmu: don't clear VM_SOFTDIRTY on
 hugetlb VMAs
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20261125-hugetlb_fixes_2-v1-18-db27fd2f71a8@kernel.org>
Date: Thu, 26 Nov 2026 10:11:14 +0800
Cc: Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>,
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
 Gerd Hoffmann <kraxel@redhat.com>,
 Mike Rapoport <rppt@kernel.org>,
 Mel Gorman <mel@csn.ul.ie>,
 Dave McCracken <dave.mccracken@oracle.com>,
 Andy Whitcroft <apw@shadowen.org>,
 Adam Litke <agl@us.ibm.com>,
 Lorenzo Stoakes <ljs@kernel.org>,
 Rik van Riel <riel@surriel.com>,
 "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>,
 Harry Yoo <harry@kernel.org>,
 Jann Horn <jannh@google.com>,
 Lance Yang <lance.yang@linux.dev>,
 James Houghton <jthoughton@google.com>,
 Yang Shi <shy828301@gmail.com>,
 Suren Baghdasaryan <surenb@google.com>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 Pedro Falcato <pfalcato@suse.de>,
 Gregory Price <gourry@gourry.net>,
 Zi Yan <ziy@nvidia.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>,
 Rakie Kim <rakie.kim@sk.com>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Byungchul Park <byungchul@sk.com>,
 Alistair Popple <apopple@nvidia.com>,
 Wanpeng Li <liwanp@linux.vnet.ibm.com>,
 Andi Kleen <ak@linux.intel.com>,
 Kenneth W Chen <kenneth.w.chen@intel.com>,
 Hugh Dickins <hugh@veritas.com>,
 Michal Hocko <mhocko@suse.com>,
 David Rientjes <rientjes@google.com>,
 Joern Engel <joern@logfs.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Michal Hocko <mhocko@suse.cz>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
 "Kirill A. Shutemov" <kirill@shutemov.name>,
 Sasha Levin <sasha.levin@oracle.com>,
 Guillaume Morin <guillaume@morinfr.org>,
 Wanpeng Li <liwp.linux@gmail.com>,
 linux-mm@kvack.org,
 Jason Gunthorpe <jgg@ziepe.ca>,
 linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@osdl.org>,
 linux-doc@vger.kernel.org,
 stable@vger.kernel.org,
 Chris Mason <mason@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7E44AC1A-59A4-4FD5-B5CB-4CFF49282C93@linux.dev>
References: <20261125-hugetlb_fixes_2-v1-0-db27fd2f71a8@kernel.org>
 <20261125-hugetlb_fixes_2-v1-18-db27fd2f71a8@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: Apple Mail (2.3901.200.71.1.16)



> On Nov 26, 2026, at 06:33, David Hildenbrand (Arm) <david@kernel.org> =
wrote:
>=20
> hugetlb does not support soft-dirty tracking: since commit =
f96f7a40874d
> ("mm/hugetlb: fix hugetlb not supporting softdirty tracking"),
> vma_wants_writenotify() ignores VM_SOFTDIRTY for hugetlb VMAs, and
> clear_refs never clears the soft-dirty bits of hugetlb entries.
>=20
> However, clear_refs still clears VM_SOFTDIRTY on hugetlb VMAs. With
> CONFIG_MEM_SOFT_DIRTY, a FOLL_FORCE write to a private hugetlb mapping
> without VM_WRITE can then loop in __get_user_pages() until the task is
> killed, with the mmap_lock held for reading:
>=20
>    __get_user_pages()
>    retry:
>      follow_page_mask()
>        follow_huge_pmd()
>          can_follow_write_pmd()
>            pmd_needs_soft_dirty_wp() is true
>          returns NULL
>      faultin_page()
>        hugetlb_wp()
>          set_huge_ptep_maybe_writable()
>            no VM_WRITE: the entry stays as it is
>        returns 0
>      goto retry
>=20
> Let's fix it by not clearing VM_SOFTDIRTY on hugetlb VMAs, so we =
always
> treat hugetlb pages as soft-dirty.
>=20
> This has low urgency, as the loop can be killed.
>=20
> Fixes: 052ccfbcc6cd ("mm/hugetlb: support FOLL_FORCE|FOLL_WRITE")
> Cc: <stable@vger.kernel.org>
> Reported-by: Chris Mason <mason@kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Muchun Song (ByteDance) <muchun.song@linux.dev>


