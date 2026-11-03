Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.92
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793717363;
	b=HCCax0FIbMa7jRY0fnsRPWgIwLKxJgkdQ7Q6TE8wA9Mr/ev4jFt6pRIoULN1k/IK61Nt
	 gjr1w01wUrd1JuYQTUFVgqq3CIy/+3rbKbFlClLkTymJ7Q3k9qyvzwZ0HiBIOIq5TFlx9
	 Z3OtQF6KC8Hn3vSEC39/uIG+7JvOPW1i4QCGTZwdTRpqjtso4zzNAy0JzPXnU/SJNS+lo
	 0KKk7MO+UQ9Kwb5O1/OQNNSvUnXf3XC6kDxz8dtc60jDjKfkAVt8M/cn9b73cwGa9wdg5
	 8vXWJx/W1HX1PAYnx+vgvqLFSlEOt/0kJqu9Drs0FMgHJHWwlfzsSWqQxuwFv55v7rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793717363;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=0jU0FKXBVK1IwPB+pnplBif7xzGvyqeYd/rvs2r/ax0=;
	b=0xt+NKXnZzvyhfAHXcQ+8mlGpIZRrx/on1UkspHutz9MLHPx3lAHbvIPUNj38KrhWp1R
	 mXFjzbtoujo1sCnYi/pykk61d5VQuExH4TKYs7/0vFeI6ribLtPtkIEsz20NyvP1NO+ip
	 h3npyZ9T5YLIGO9DqK3L3/fMBBfDLbeo+94djzvSl9D3OGD8a0SjiBxG+vDe84lFYYMOM
	 bMGe6Rfyf8DNUUaFBIK6/QgXurcrgcO9/+8riUQzImjRf5yhlHY1Z8rME5LG2WxueVX4L
	 aQfPiEA99C8/a3DHdgZexRzbO0y7EcY2i180aZ2FEhfhFrRyjIScVsPYjPDXQwSpEGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=QzuU3YVM;
	arc=none smtp.remote-ip=91.218.175.92
Received: from mta0.migadu.com (out-92.mta0.migadu.com [91.218.175.92])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601A4606D82F
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 14:49:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 601A4606D82F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=QzuU3YVM
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=dOHWqJbFAMJYJY9pYQ0G9QdWl3ff5fr4nC5HvUAG8+A=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793717360; v=1; x=1794322160;
 b=QzuU3YVMkybToy3jCx589JuXk6v7arOjZKVMIuzVTtcNW67BI2N1Sv/tO1vpXZew6+OWlgh+
 BtzfOsvNi5KxLjRGGqGPhJtBN3VmFTvpgdWNR8NKH7Gp6SbMkzFQdncMIrRdzS1uk7Hz+9X+9N+
 g3oq2Ln4/BioZxzKZymYhmOg=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 632a76e6b0da1a08;
	Tue, 03 Nov 2026 14:49:18 +0000
X-Mizu-Trace-ID: 632a76e6b0da1a08
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: david@kernel.org
Cc: akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	ljs@kernel.org,
	kasong@tencent.com,
	baohua@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	baoquan.he@linux.dev,
	baolin.wang@linux.alibaba.com,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	kees@kernel.org,
	peterz@infradead.org,
	jannh@google.com,
	pfalcato@suse.de,
	hughd@google.com,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	willy@infradead.org,
	jack@suse.cz,
	ziy@nvidia.com,
	lance.yang@linux.dev,
	riel@surriel.com,
	harry@kernel.org,
	apopple@nvidia.com,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	usama.arif@linux.dev,
	kas@kernel.org,
	matthew.brost@intel.com,
	jhubbard@nvidia.com,
	peterx@redhat.com,
	will@kernel.org,
	aneesh.kumar@kernel.org,
	npiggin@gmail.com,
	osalvador@suse.de,
	minchan@kernel.org,
	muchun.song@linux.dev,
	xu.xin@linux.dev,
	chengming.zhou@linux.dev,
	chrisl@kernel.org,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	youngjun.park@lge.com,
	gourry@gourry.net,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	ying.huang@linux.alibaba.com,
	jgg@ziepe.ca,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	mason@kernel.org,
	stable@vger.kernel.org,
	usama.anjum@arm.com
Subject: Re: [PATCH v3 42/47] mm/vma: call ->may_split() before a partial merge
Date: Tue,  3 Nov 2026 22:49:09 +0800
Message-ID: <20261103144909.6138-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261031-fixes_core-v3-42-d6437171ecc3@kernel.org>
References: <20261031-fixes_core-v3-42-d6437171ecc3@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Sat, Oct 31, 2026 at 10:40:11AM +0100, David Hildenbrand (Arm) wrote:
>From: Chris Mason <mason@kernel.org>
>
>A driver can use the ->may_split() hook to forbid a VMA boundary at
>certain addresses.
>
>A device-dax device is a character device that gives raw access to a
>range of memory through mmap(). device-dax refuses any address that is not
>a multiple of the device's alignment through vm_ops->may_split.
>
>vma_merge_existing_range() can move boundaries, but does not call
>vm_ops->may_split.
>
>If a range at the edge of a VMA gets the attributes of the adjacent VMA,
>the function moves only that range over to the neighbour: one VMA shrinks
>and the other grows. This is a partial merge, and vma_modify() tries it
>before any split.
>
>Take a device-dax VMA that lies next to another VMA of the same file.
>The user calls mprotect() on the one page of the first VMA that touches
>the second VMA, and asks for the protection that the second VMA already
>has. The result is a partial merge. It puts the boundary inside a 1 GiB
>mapping, which is a single leaf entry at the PUD level.
>
>As part of the merge, the kernel looks for a huge PMD to split at the
>new boundary. That code does not expect a PUD leaf:
>
>    vma_merge_existing_range()
>      commit_merge()
>        vma_adjust_trans_huge()
>          split_huge_pmd_address()
>            mm_find_pmd()
>              treats the PUD leaf as a pointer to a PMD table,
>              so the "table" is the device memory that the leaf maps
>            __split_huge_pmd()
>              reads a PMD that the user wrote to the device memory
>              folio_put() on the folio that this PMD names
>
>Bad. While the code must at some point be taught to split PUD entries as
>well, the issue here is that we move VMA boundaries such that they are
>incompatible with the driver.
>
>Fix this by calling ->may_split() on the address that a partial merge
>would move the boundary to, and by abandoning the merge if the driver
>refuses. vma_modify() then tries the split, which fails with -EINVAL.
>
>Factor out existing split handling into check_split() and reuse it.
>
>Fix generated by an LLM and sent by Chris Mason in private.
>
>Fixes: 38607c62b34b ("fs/dax: properly refcount fs dax pages")
>Cc: stable@vger.kernel.org
>Signed-off-by: Chris Mason <mason@kernel.org>
>Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>[ david: improve description; cleanup the code ]
>Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
>Tested-by: Gregory Price (Meta) <gourry@gourry.net>
>Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
>Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>---

Reviewed-by: Lance Yang <lance.yang@linux.dev>
