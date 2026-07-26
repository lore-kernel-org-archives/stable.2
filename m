Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BFD18DF80;
	Sun, 26 Jul 2026 00:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785027213; cv=none; b=ZdFF7Du0SgPAKJsvgcZ9cBCZ6IJn0WoIBKwHx921ILnMOc6uyqzQtkNpMw6S0RcwPOaaDpLZd576RN0MBCjHxXFRT3iFpuKXqBkDlboTKVHffZXftF6s3XtbUwyKGTp1OhMi4zTgK67ecwH33r1g7LxsOr0O49xhV0qrb+8oIXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785027213; c=relaxed/simple;
	bh=/RmQD9hoZG17WBETm21gPm0RE5HkLZe4j5i4Bf17L2o=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=QpuLGC9rO2MU7eZGcW58EtYmNbr9lnRfcL5cQmLGA9LNfffB5i1M6rDkhytTiW++pjEKaUczPBSuOnVx06EJ0ivC242RBosQ4JTQ7ddLvE9zOVH2nA8oVzITi0cbVXXvuJXmd4sqZGNb04vLfi2hQkcUMzBYJeMA85EOLL73EHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FMabStzN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FMabStzN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05CE61F000E9;
	Sun, 26 Jul 2026 00:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1785027211;
	bh=D9RJYrPyKu4j2C1jazqGEHEdAG3mVPG/Lir/eORzk/o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FMabStzNIfu4BbASuRyUJpfWNjOtTeoXLye+5n6j+SyyzME5KViEIVwVi552hWN7z
	 K+V3VXq6r/hMEnTwAecCk3iT20TTRVyUCWwE92HChBFBQuYN2UwlY2BGOoGjGXekpm
	 1WmVE0lbN3o2krSVS5ne6vZZeceftxEnprBiJ5dc=
Date: Sat, 25 Jul 2026 17:53:30 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Matt Fleming <matt@readmodwrite.com>
Cc: David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache
 <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain
 <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, Lance Yang
 <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, Dave Chinner
 <david@fromorbit.com>, Qi Zheng <qi.zheng@linux.dev>, Roman Gushchin
 <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, Kairui
 Song <ryncsn@gmail.com>, Shakeel Butt <shakeel.butt@linux.dev>, Matthew
 Wilcox <willy@infradead.org>,
 syzbot+c5b060ce82921a2fd500@syzkaller.appspotmail.com,
 stable@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 kernel-team@cloudflare.com, Matt Fleming <mfleming@cloudflare.com>, Roman
 Gushchin <roman.gushchin@linux.dev>, Chris Mason <clm@fb.com>
Subject: Re: [PATCH v2] mm/huge_memory: Initialise workingset state before
 folio split
Message-Id: <20260725175330.dd30f4e9b6f9fd28c5b41aa9@linux-foundation.org>
In-Reply-To: <20260725101419.3938406-1-matt@readmodwrite.com>
References: <20260725101419.3938406-1-matt@readmodwrite.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 25 Jul 2026 11:14:19 +0100 Matt Fleming <matt@readmodwrite.com> wrote:

> xas_try_split() adds __GFP_ACCOUNT for page-cache xa_nodes, but
> __folio_split() leaves the xa_state's xa_lru unset. That lets a live,
> memcg-charged xa_node exist without being linked into the mapping's
> shadow_nodes list_lru; when reclaim later walks the list_lru it trips
> VM_WARN_ON(!css_is_dying()).
> 
> Use mapping_set_update() to install both the workingset update callback
> and the shadow_nodes list_lru on the xa_state.

Thanks, I'll queue this as a hotfix.

Sashiko is wrong, methinks.  "Calling local_irq_disable() strictly
disables hardware interrupts" isn't true on PREEMPT_RT.

	https://sashiko.dev/#/patchset/20260725101419.3938406-1-matt@readmodwrite.com  
