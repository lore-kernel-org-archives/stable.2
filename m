Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388551F936;
	Mon, 20 Jul 2026 09:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784541554; cv=none; b=cxr41ff0AV09vkaJZUrPwgCby/9UtMPFzncsv4jzsr8O29OBuYeE+0JJHHrYveqN8OjkYuVgDDy6GdHhet8p5DIOprnC7NijHnRieDGEbVl6PlQkV9xue3QkobQMJboDnEFCv3vVEvNlQtUaVkUlhVNC2Nm8uN9YthoIYoBtItg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784541554; c=relaxed/simple;
	bh=vkZBH0Dv/ff7PHZRExCpf1ag3KUiIDp6AK9Cv26AtAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IWbyL3twPxtRtS9R8ma7qpNwrSbvP47WSjz03YqvdCWfLK1RMa2nvG4PzR0cqoFmL8z51FqmUfBkeMwY9rV4/MA2KR+CrKL6roIF+ybmUogpYJG4P4set2yBXyE1AULNzBagnPFBuSGPseeL8Y/bCNvqnwYz+U4nFcDHm4K/2e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Eme9M5Ig; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Eme9M5Ig"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 098F51F00A3A;
	Mon, 20 Jul 2026 09:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784541552;
	bh=kzrfRXAiX4Hu4kXoYmi1n5/DV4H+5STSh8/UbIu5Gxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Eme9M5IgGejVre/xameqf5XfphSy8SLE1OGq9UXSM2PvQxQlY68XQY5/VlVF850I1
	 HC8nvoVOlXpHITQyzN4K6t1moXiiPIy0d64x6Rlr1pEJfRAIy8FRJWuhhStZrDyEEz
	 svvr/niVKnQZ1Q/pl76w/WqHtH4tVESOMvezBzMs=
Date: Mon, 20 Jul 2026 11:59:03 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SJ Park <sj@kernel.org>, damon@lists.linux.dev, linux-mm@kvack.org,
	stable@vger.kernel.org, Yikai Zhao <yikai@z1k.dev>
Subject: Re: [PATCH] mm/damon/reclaim: fix typo in damon_reclaim_timer_fn()
Message-ID: <2026072041-rearview-unselect-3f92@gregkh>
References: <20260720094708.243937-1-aethernet65535@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720094708.243937-1-aethernet65535@gmail.com>

On Mon, Jul 20, 2026 at 05:47:08PM +0800, Liew Rui Yan wrote:
> Commit 2f54908fae211 ("mm/damon/reclaim: detect and use fresh enabled
> and kdamond_pid values") introduced a typo in damon_reclaim_timer_fn()
> where '!=' was used instead of '==' (unlike damon_lru_sort_timer_fn()).
> This caused damon_reclaim to return early during the delayed work,
> breaking early boot parameter configuration like
> 'damon_reclaim.enabled=Y'.
> 
> Fix this by changing '!=' to '=='.
> 
> Fixes: 2f54908fae21 ("mm/damon/reclaim: detect and use fresh enabled and kdamond_pid values")

Why is this a stable-only patch?  Did something go wrong with the
backport of this commit that is not in the upstream version?

thanks,

greg k-h
