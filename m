Received: from mta1.migadu.com (out-239.mta1.migadu.com [95.215.58.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4114CF47C
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 08:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792312480; cv=none; b=OvwBfVAQ4de8ol/VKWLxcWu0UYkjO1EknhYLQCbzgLZ+hZtdrPM5bdTd/1MDchQCWAfexpwulhKGxET3cLakutc6mkHJTSsC95DezRnKN583vXbEMQibwJlMp6sTjs32B2K/ZVAAtEMQ0Q/3MeOO8qX7CF1ajjDpIku3zjRy6KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792312480; c=relaxed/simple;
	bh=4FHu0SrOXnVIwNP/Tb0Qhbw7/vflkiK9DWXkwldrzj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pxuXXFFrziIOP1wuFdQdsYXPI35VWojzzXomC5SGlYc2UBDL/rpeljZYg2WeFTHjCNT52Boh4i3l3b5T3FxnhjbdW6Cj2Cgye/PTUt10bht/tdfYKMHFl3FHgrB3B/gjy8pSpIPRih1gwSKNPsiqvbPAoX681nwDwbSprO6Ck/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LCx1+dVW; arc=none smtp.client-ip=95.215.58.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LCx1+dVW"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=4FHu0SrOXnVIwNP/Tb0Qhbw7/vflkiK9DWXkwldrzj4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792312476; v=1; x=1792917276;
 b=LCx1+dVWxKkFYHab4iGMbh4EiGbeivfzobmOF7Km6kkmJSxkOiz9oHwe3BM5yIsDkkwE5kOk
 sR64MbrCwbAOOqc0b8/TEmLuk9aDDbsRMyGciKn55NMMKCnTJ2r6qvn2ke5kNlh9YGvx+bf1BU5
 uNVhmc/+sqCMbSbUVmTgA4oA=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 5616a91c2f12ed25;
	Sun, 18 Oct 2026 08:34:36 +0000
X-Mizu-Trace-ID: 5616a91c2f12ed25
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: david@kernel.org
Cc: akpm@linux-foundation.org,
	liam@infradead.org,
	ljs@kernel.org,
	vbabka@kernel.org,
	jannh@google.com,
	pfalcato@suse.de,
	muchun.song@linux.dev,
	osalvador@suse.de,
	linmiaohe@huawei.com,
	nao.horiguchi@gmail.com,
	agl@us.ibm.com,
	mel@csn.ul.ie,
	riel@surriel.com,
	peterx@redhat.com,
	kas@kernel.org,
	rppt@kernel.org,
	josef@toxicpanda.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 10/10] mm/mremap: fix calling fixup_hugetlb_reservations() on the wrong VMA
Date: Sun, 18 Oct 2026 16:34:31 +0800
Message-ID: <20261018083431.15699-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261015-urgent_fixes-v1-10-42796911043b@kernel.org>
References: <20261015-urgent_fixes-v1-10-42796911043b@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Thu, Oct 15, 2026 at 06:07:16PM +0200, David Hildenbrand (Arm) wrote:
>In case we fail to move the page tables, for example, because we fail
>to allocate a page table, we actually keep the old VMA.
>
>Calling fixup_hugetlb_reservations() on the old VMA is wrong. Fix it
>by just calling it on the VMA that will be removed.
>
>The user-visible impact is that the VMA loses its reservations, meaning
>that the existing reservations get stranded (leaked) and new hugetlb folios
>that are getting allocated in the VMA cannot make use of the
>reservations, failing these allocations.
>
>Fixes: b714ccb02a76 ("mm/mremap: complete refactor of move_vma()")
>Cc: stable@vger.kernel.org
>Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>---

Reviewed-by: Lance Yang <lance.yang@linux.dev>
