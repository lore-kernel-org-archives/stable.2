Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418E530AAD8;
	Wed,  2 Sep 2026 05:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788328415; cv=none; b=GVo5jgV6YjTBUyYv8kCpeOtvBk41U+TucQInkXrrYdOlvSzMVIHfyronjZFP5BUJYibzUCxqUBmojqQjcwRuNzpwwGg89HE+/HDDg9EBDHFnw5xz6VTkCoxQONx2ilYweJoJnexI2KNhETuv5dK/Lq25RcZeIsseM5CXBt5+o2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788328415; c=relaxed/simple;
	bh=QbGcAg7DzOG1xY8ZQxl9eD5Kx8O9q+LQLW0/p+9fgIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jdQnvAR7dHcoljq09Tl4yzM/qTaQEmLOdxVkOaxf9begcRpmnBl7NU5RrzG8nItmXLbinRw8iT3fOpWQkwUHsZ6WUsG5qC0veTe2d18KlIp6OleoQuYMqRUwN/8thFl416QCVtmMP9LeqHqV0yB/+qmxGjtqiXWIjdf2f8cIcI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vUYPo0qU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vUYPo0qU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 430FE1F000E9;
	Wed,  2 Sep 2026 05:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788328413;
	bh=++ZImsw2/TuLJ+7X/9pG8+ABOc63e0/zSWfu4HVuACg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=vUYPo0qUYKiPkTPYhUrVRrqnd6daS1+nDeUygyCt3tQTPHBk/5zYc5+Vj0TkrJhPv
	 ZBV3rqEWATXFK+lDT+Ids4dDaAZBwUiTzmZRQfytY7gXp7HhOxQdBG9evehx34w+Lb
	 p2zl7t9WY3fXATtH3YkbwcPG+R2S8lj8hRzK/SBI=
Date: Wed, 2 Sep 2026 07:53:28 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Cen Zhang (Microsoft Security FORGE Labs)" <cenzhang@linux.microsoft.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	jkoolstra@xs4all.nl, neil@brown.name, sandeen@redhat.com,
	kees@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com, xmei5@asu.edu,
	tgopinath@linux.microsoft.com, kys@microsoft.com
Subject: Re: [PATCH] ufs: validate cylinder group free bitmap offset
Message-ID: <2026090207-threaten-shakiness-a0bc@gregkh>
References: <20260901180600.10394-1-cenzhang@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901180600.10394-1-cenzhang@linux.microsoft.com>

On Tue, Sep 01, 2026 at 02:06:00PM -0400, Cen Zhang (Microsoft Security FORGE Labs) wrote:
> ufs_read_cylinder() copies cg_freeoff from the on-disk cylinder group
> without checking that the free-fragment bitmap fits in the loaded
> cylinder group buffers. A crafted image can place cg_freeoff past those
> buffers so that allocation later indexes ubh->bh[] out of range.
> 
> UBSAN: array-index-out-of-bounds in fs/ufs/balloc.c:752:15
>   ubh_scanc()              fs/ufs/balloc.c:752
>   ufs_bitmap_search()      fs/ufs/balloc.c
>   ufs_alloccg_block()      fs/ufs/balloc.c
>   ufs_alloc_fragments()    fs/ufs/balloc.c
>   ufs_new_fragments()      fs/ufs/balloc.c
> 
> Reject the cylinder group unless the full BITS_TO_BYTES(s_fpg)
> free-fragment bitmap starting at c_freeoff fits in the bytes actually
> loaded for that cylinder group.

Why not fix the userspace fsck tool to fix this instead of working
around it in the kernel?

thanks,

greg k-h
