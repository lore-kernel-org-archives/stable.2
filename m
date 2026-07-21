Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EF88C1F;
	Tue, 21 Jul 2026 13:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784639201; cv=none; b=Sy36ByxNe7QNwcKvzfH010OwqpHxlrPaapibVOTzmze2qcoKS/ubFPKhSI2uG39gpjsS3ddmzGP50Jwy0mTPlP/zW6/rl4UDl/wCHKj95bn1aJlc5ggM+gnWqr13QG17bgULICeiGiJ87QcEjOK/z86ZDIyNagGS5ziiUB7Z9+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784639201; c=relaxed/simple;
	bh=mtQgKkjhyqYeAv6bKMJO8QlWbMOjOrEaIyYXWPwblmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=az+xqEK2GwBOpkmzkhLMrdH2BKxSzl0U9dJwxI/mHxowFS0K/UgLLo7gsyCX3txzftqWE2Lj11KC1thA3RMjH4btadbpzRY/LGbkK8KFr5+XkZxFHiFzrnpeqsyiUTMXI861Zr3KXo/cwMMwWNJDXi2MCCTim3Qe4sMh5J9OC7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TflpULBP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TflpULBP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21BC41F000E9;
	Tue, 21 Jul 2026 13:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784639199;
	bh=gAvC7NZ0aC43RFdOVjevlRnmxAEAMYI/EG3Kb+rwdd8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TflpULBPsUF9aflAlRjqyKq3bZoqXA2/SV7TZ8SpHM0qr532SxGo94jmG94f/8458
	 pmBaVGp1KUH9wdN+7AiMIEUWNhJFcN0SWo7CmJjMnenC/WRsOeSx2D3ONFlOfJws+X
	 C98g4DPooh9J2Ox2vubP94bX6CJqIetdqjvDeXhU=
Date: Tue, 21 Jul 2026 15:06:30 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Qi Xi <xiqi2@huawei.com>
Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>,
	Jane Chu <jane.chu@oracle.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, sunnanyong@huawei.com,
	wangkefeng.wang@huawei.com, stable@vger.kernel.org
Subject: Re: [PATCH stable/linux-6.6.y] mm/memory-failure: fix missing
 ->mf_stats count when hugetlb folio already poisoned
Message-ID: <2026072112-lapping-turf-bf90@gregkh>
References: <20260706084118.1284271-1-xiqi2@huawei.com>
 <6a756801-f4a5-44a5-abfd-e9ae57432c56@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a756801-f4a5-44a5-abfd-e9ae57432c56@huawei.com>

On Tue, Jul 14, 2026 at 09:45:03AM +0800, Qi Xi wrote:
> Add stable@ to Cc.
> 
> On 06/07/2026 16:41, Qi Xi wrote:
> > When a new subpage is poisoned on a hugetlb folio that has already been
> > marked hwpoison (MF_HUGETLB_FOLIO_PRE_POISONED), hugetlb_update_hwpoison()
> > increments num_poisoned_pages directly, but the per-node ->mf_stats is
> > not updated because this path bypasses action_result(). This leaves the
> > two accounting counters inconsistent within the hardware memory-failure
> > path: a new poison event is counted in num_poisoned_pages but not reflected
> > in the per-node mf_stats.
> > 
> > In mainline, commit a148a2040191 ("mm/memory-failure: fix missing
> > ->mf_stats count in hugetlb poison") fixed this by removing the direct
> > num_poisoned_pages_inc() from the helper and adding action_result() calls
> > in try_memory_failure_hugetlb() for the already-poisoned cases. The
> > backport to linux-6.6.y as commit 252bb328b36f ("mm/memory-failure: fix
> > missing ->mf_stats count in hugetlb poison") applied the refactoring
> > (naming, constants, switch-case) but omitted the core counting fix,
> > leaving the inconsistency in place.
> > 
> > Fix this by adding a matching update_per_node_mf_stats() call alongside
> > the existing num_poisoned_pages_inc() in the same block, so both counters
> > stay consistent without restructuring the error path.
> > 
> > Fixes: 252bb328b36f ("mm/memory-failure: fix missing ->mf_stats count in hugetlb poison")
> > Signed-off-by: Qi Xi <xiqi2@huawei.com>

We need acks/reviews by the relevant maintainers before we can accept
something like this.

thanks,

greg k-h
