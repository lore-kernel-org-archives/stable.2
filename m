Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1823750CB;
	Wed, 17 Jun 2026 18:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781719777; cv=none; b=nJZkGJjdSzeBXIFkUR2/dj9zPjEoaIB0e6yguTcWyed3qOgGZq2kFDpYUA09QCGG2+fKfg4Vhh16amMEGAvOjO/8TcwCO2N2NJGjFVJK03hTFpcJ1FTtas8dURjA3MpxShtOQm6GGPzKJJDfcM2HxqsTFb9/nAeWQXAhFcXJbJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781719777; c=relaxed/simple;
	bh=tPxlq0qL8ZiBrQmoi8Rx8xtOxDUmm2s8o0hFeRA4jX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tBijIhHiuyh1luAIM6ugyFG6g2MdieUiZnyqN3Iqi8JB89Ds+1CumyXXdFLFs45GDNJWaCdm33YwEyzKxe926T9TK4ICYteN5UnCSHqH/4CRoLTQmgXdVrf2edrer/LD2CdTMYSuQCy5poYLJvG080RuT7SAWe6WZo1RQkG5Asw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FvR2WSXb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FvR2WSXb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F19B1F000E9;
	Wed, 17 Jun 2026 18:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781719776;
	bh=jWEa6RP1Pi3Ycy/oGmflXx0TMIdx6fHkv2r2sAHUe5M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FvR2WSXb120GdkouzMt5pxNolEXMByOMorJ2qh7bQ5fpzAlqYLc4BrvcueSaoHTXa
	 Cn1vkCsT+oHzPgJW2IWomMhsHj1FYD0FAlZURjHcNCRiqHpa11+nDYxxO95Adikfrm
	 Sy6AdDOCZBPOeDzqGhismne1s7GGF9TG81ifMqvtfgHuZg/nMwxfIwUdlL5FyVlBTP
	 qmMZm8/JW4us9Tpyy3+ZoJtliXwZ6/woJo0rnPBm2lTLVAeu14AcCiGWgMsSEre9je
	 e4kcQe46sD7adaUGKfRwq0A99LjZhoUGdYz3+ICnCC19PxB91DLbZ+lL+IfKvDRsym
	 n9s7yl3xl7NHQ==
Date: Wed, 17 Jun 2026 18:09:34 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Wenjie Qi <qwjhust@gmail.com>
Cc: chao@kernel.org, geoo115@gmail.com, yangyongpeng@xiaomi.com,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, qiwenjie@xiaomi.com
Subject: Re: [f2fs-dev] [PATCH v5] f2fs: use post-decrement count for cp_wait
 wakeup
Message-ID: <ajLi3nLqyS31Y6J4@google.com>
References: <20260616135637.1439319-1-qiwenjie@xiaomi.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616135637.1439319-1-qiwenjie@xiaomi.com>

On 06/16, Wenjie Qi wrote:
> f2fs_write_end_io() decrements the writeback page counter and then
> reads it again with get_pages() to decide whether the last
> F2FS_WB_CP_DATA completion should wake cp_wait.
> 
> Use atomic_dec_return() for F2FS_WB_CP_DATA completions so the wakeup
> decision is made from the value produced by the decrement itself. Keep
> the existing dec_page_count() path for other writeback counters.

Is there a race condition to do this? If so, can you describe? And, I think
we need a wrapper function instead of calling nr_pages directly.

> 
> Fixes: e234088758fc ("f2fs: avoid wait if IO end up when do_checkpoint for better performance")
> Fixes: ce2739e482bc ("f2fs: fix to avoid UAF in f2fs_write_end_io()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
> ---
>  fs/f2fs/data.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index d83a21998ec2..58d23eb74ec2 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -392,15 +392,17 @@ static void f2fs_write_end_io(struct bio *bio)
>  		if (f2fs_in_warm_node_list(folio))
>  			f2fs_del_fsync_node_entry(sbi, folio);
>  
> -		dec_page_count(sbi, type);
> -
>  		/*
>  		 * we should access sbi before folio_end_writeback() to
>  		 * avoid racing w/ kill_f2fs_super()
>  		 */
> -		if (type == F2FS_WB_CP_DATA && !get_pages(sbi, type) &&
> -				wq_has_sleeper(&sbi->cp_wait))
> -			wake_up(&sbi->cp_wait);
> +		if (type == F2FS_WB_CP_DATA) {
> +			if (!atomic_dec_return(&sbi->nr_pages[type]) &&
> +			    wq_has_sleeper(&sbi->cp_wait))
> +				wake_up(&sbi->cp_wait);
> +		} else {
> +			dec_page_count(sbi, type);
> +		}
>  
>  		folio_clear_f2fs_gcing(folio);
>  		folio_end_writeback(folio);
> 
> base-commit: c0b65f6129c7fbb526e921dd60261650f1b2bef9
> -- 
> 2.43.0
> 
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
