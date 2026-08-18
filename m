Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07836846A
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 02:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787021978; cv=none; b=OoilcTxKaYHfdagsDVFWlU8zn4CYs3rbUiYSsfpn2rlKDkLaRaw0zA6laLe+eCjUOHI9STnxdaMNaNZMrnS2eJUu0NQm2MpNNM9rKQ8PF4YI/gnETYVosF7TjfrsEWylkcz2xU3ksvieetQ5CFxjSjPh8sbv68KM+V8TX72i8Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787021978; c=relaxed/simple;
	bh=OFzNqmcZS4R4FV+pXkH5Cb8qCpxPZIA03eLKeqvWgUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=grFvFbxATcJK7p3CYegJ7JchKfqZBd0LrozHdRe6skKD7p6UasCnWxUqhNbQnMt1uVLl41FD6qpnEPv6hbMvXM72LYgQFA99f5ABoLiUKmbcyBqDVbjQsaZKiRiGPuGeipoN6Dwv826AbMwfiArjmM9POQxc71h2/TgOf6vTzpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=W5oOFXVs; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="W5oOFXVs"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-92edb12cdf2so341396685a.3
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 19:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1787021975; x=1787626775; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tpYS9nogSeC5YAWQyKVXdj3E5kPL+kfXuGGttfptnTE=;
        b=W5oOFXVsl7RcB+qjH5+yaIBHNytAtANpHR2EiiPMPx1/ozgVUp/6Tz7pHwLilL9e4i
         fFe3GNvOAORnsyR7KUwROC8gFfV8ohdmyeg0mGclcYvyYCaHdhzb9gA9kVtGayI5OB0S
         pfHqI6GCdyKScP48gx8Nb2IskCl+sfvC/q0QKtZZl07w4CL/tZ+8OKgEDnjpZpK33slo
         976/chq8IwHEKAhSq8zNq5xUxlfawtjQv9SlyVQuE2kYJuz6hSDb82TeTtAh4hniIjXP
         jmLQvC0xjtriMJWiE7k9P2dCOQw0X1cc8BzC+cq/x2G3yJ/grv0fD/szGpw6qGvAcyyG
         MiYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787021975; x=1787626775;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tpYS9nogSeC5YAWQyKVXdj3E5kPL+kfXuGGttfptnTE=;
        b=RxXvmnLAvCt6MCDxcY19pvSprCLi6r05zjiWWVo41uRU8KAZVi6mQzV/OmwGXvwPzg
         Yu74fG9PDKxRlQKwhfI3cCexje9ZtMau2lkQ4r7SU9YVJw98FAm+93LODeuKlJCJdqYM
         AHN/IHhGArIMCMJMVPC7sxQpqWdEjbqCiuYikBkDDdNTmJGza2GEp4qgNv3Zs9QLfh+k
         0tKmSjE0dDZ28MwONvocwNvJWzjune2BmeLoc6NfoWttY6pBWWw9iDkdlxaB3dYZ/f2p
         q2XgpTn5WX2oGaU+GsdDqwPE1sQuWwznNqmKAWmzozaIvsqpyaVHhXJUWYjw1NqES27K
         MRbQ==
X-Forwarded-Encrypted: i=1; AHgh+RqqN5xY2RXWTb5fNB/dQUU3FH/DYrXCzEDS7QHEm4BO2SZzZGTRjKsD3F0rEqyBRQPobKbBATs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv6H7HoKrM/0nFb0LKngW6XsRSjstl6sMDLFuWE5zm4dWEOz1O
	Vih20GmZ+jyh6FT1m6n+5d/K1xbwClNPaSrXq8mj2N8bi/DpPIFY6Ch0tS7NPzro/Q==
X-Gm-Gg: AR+sD10ej9y0N5h9hI5j/60ILsDeC8EKeFnAILqDwbHNs4y28nIJoKL2WpU84R3TWf8
	0zna2uEsF6iSiMobn242WohNEa+qjK3qqHn2JtQejeEqLlItjRwtRYKdOMHRDFWjxm4QJPj9bjF
	BPZm+eZ1aIqdFOXQAM60xQpU3giERa6yY/7G06yemAJdqjxiTgYsFNlDwdIxc16Wp09yVEd3YRG
	QedNlFgezFuw2HQ51I6pWF77IRRENJ1i5Q5bFbTHCTCc/HovAjcHGRbKXp+Kddx9Vqqg51ImoL6
	N4nrCXURL1YDPKAS0OvI2k6qXuCfvp9LGGJKqyouxmz+i78iKVkGa4QSOde4l9NDTAHgnzxqn4g
	O8G7sBo7txlhnhJKn09PnfovFqb9jtUtgX0HGak5c15DYuueafEBEw9LPDYL9g37YEhe2KdpPzu
	y4QYRIQ2oLM/eta2hByMqFQlAWcn79Z/B25g82ZvXpFg+yizwfRQNg573FXXZx3w==
X-Received: by 2002:a05:620a:2683:b0:915:83fa:b3e0 with SMTP id af79cd13be357-936d1fdb95bmr2738326885a.5.1787021974874;
        Mon, 17 Aug 2026 19:59:34 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d01:d210::dfd8])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-937033ceb9bsm191865685a.23.2026.08.17.19.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 19:59:34 -0700 (PDT)
Date: Mon, 17 Aug 2026 22:59:31 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Zi Yan <ziy@nvidia.com>
Cc: Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	syzbot+805630f1453e490427fa@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/slab: reject unsupported kmalloc sizes
Message-ID: <3ec57a22-3096-418f-b10f-b0993a352007@rowland.harvard.edu>
References: <20260817-limit_kmalloc_size-v1-1-5bef487701cc@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817-limit_kmalloc_size-v1-1-5bef487701cc@nvidia.com>

On Mon, Aug 17, 2026 at 04:40:18PM -0400, Zi Yan wrote:
> kmalloc is used to allocate physically contiguous memory for kernel
> allocations. For requests larger than KMALLOC_MAX_CACHE_SIZE, kmalloc uses
> the page allocator and can only support up to KMALLOC_MAX_SIZE. For request
> sizes bigger than KMALLOC_MAX_SIZE, the page allocator can emit a WARN
> because kmalloc allocates an order greater than MAX_PAGE_ORDER. Systems
> with panic_on_warn=1 crash because of this WARN. Fix it by rejecting any
> kmalloc size bigger than KMALLOC_MAX_SIZE.
> 
> Fixes: aadb4bc4a1f9 ("SLUB: direct pass through of page size or higher kmalloc requests")
> Reported-by: syzbot+805630f1453e490427fa@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/6a820ebc.9ebadd4d.20b15e.001b.GAE@google.com/
> Tested-by: syzbot+805630f1453e490427fa@syzkaller.appspotmail.com
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Cc: stable@vger.kernel.org
> ---
> It fixes a page allocator warning (order > MAX_PAGE_ORDER) when gadgetfs
> requests excessively large memory from kmalloc. Instead of adding
> __GFP_NOWARN to suppress the warning, as was done for usbfs[1], change
> kmalloc to return NULL without a warning for this specific issue.
> 
> [1] commit 4f2629ea67e72 ("USB: usbfs: Don't WARN about excessively large memory allocations")

Thanks for doing this.  If you like, I can write a follow-up patch to 
remove the __GFP_NOWARN added in 4f2629ea67e72, now that it isn't needed 
any more.

Alan Stern
