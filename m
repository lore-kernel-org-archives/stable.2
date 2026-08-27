Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5505C231C91;
	Thu, 27 Aug 2026 03:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787801541; cv=none; b=dELKs+aa3L8/zH40YEWgRa81sRZc4uiRs+NFfRrt/lJvplm4OPnPMFrgBf4y7GdfDUS8zthXq9tRiYrbBMz1N9dMyaJRUoE1l26kDFzf+lhLi4TWr+GBsouztSXsvMxxrSBWVVAKaeq/PmkCkKcPiDUaNBE+mwY1cu/gKUTTPvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787801541; c=relaxed/simple;
	bh=mZU+bHuKSS4vwoYAIJpf3CZXEb4VfXpwIOUMrqbgxOA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=EP/MXZeU/AvdclNQ+K9iDUUbEVwOKxa9rrw62CtNAG+2onjYzN36ysbglPP5Bg4Wyegwf/CsXyhBFgDF5zQEYuWj/1qGz2X/1KBuMZqJgvwLzsFfmx1+PijqcCMyA8S5iqE1VsCMruygpvzP0P5GgAeSTHIJFYQ0rPaK8TsRtXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VSM0sYi8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VSM0sYi8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65BB41F000E9;
	Thu, 27 Aug 2026 03:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1787801539;
	bh=jWOHS8TyoHKRTLSUkAPNBR3Q6pJ9KdiACWk7PEG8wK8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VSM0sYi89j9wTZPXhMBkh+2yj/ZPg8EGm/LmhBtuDnlDDN+l5MhYPn5/hqK8QXJOq
	 MJZxD8aTPUDmGjsAlCbWggyZuD/gx6KKbsl3thtlrqCvynOVDhToKdZsCVpsQzxfbs
	 4adVCLvL5h0lyuEf9gg0mGy0aaUIzNV9NXvfInNM=
Date: Wed, 26 Aug 2026 20:32:18 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: David Hildenbrand <david@kernel.org>, Xu Xin <xu.xin16@zte.com.cn>,
 Chengming Zhou <chengming.zhou@linux.dev>, Hugh Dickins <hughd@google.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/ksm: mark migration stores with WRITE_ONCE()
Message-Id: <20260826203218.a8690c6bdeb7504ee7fd9ad5@linux-foundation.org>
In-Reply-To: <20260824112433.191301-1-nicoyip.dev@gmail.com>
References: <20260824112433.191301-1-nicoyip.dev@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Aug 2026 19:24:33 +0800 Chengfeng Ye <nicoyip.dev@gmail.com> wrote:

> ksm_get_folio() deliberately samples stable_node->kpfn and
> folio->mapping without taking the folio lock because the KSM folio may be
> migrated concurrently.  folio_migrate_ksm() updates the same state using
> plain assignments.
> 
> The reader can load the old kpfn, then the migrator can store the new kpfn,
> execute smp_wmb(), and clear the old folio's mapping before the reader
> checks that mapping.  Thus the initial kpfn load can overlap its update and
> the subsequent mapping load can overlap the clear, with no common lock.
> This leaves marked READ_ONCE() accesses racing with plain stores.
> 
> The kernel reported:
> 
>   BUG: KCSAN: data-race in folio_migrate_ksm / ksm_get_folio
>
> ...
>
> Use WRITE_ONCE() for both stores to pair them with the existing lockless
> reads.  This preserves the existing smp_wmb()/smp_rmb() migration protocol
> and control flow while preventing compiler transformations of the shared
> accesses.
> 

As usual, AI review looked at the surrounding code and went
nuts.  Please check?

	https://sashiko.dev/#/patchset/20260824112433.191301-1-nicoyip.dev@gmail.com

I don't think any of these are truly pertinent to your fix (which I shall
apply), but maybe while you're in there and all fired up ;)

Thanks!
