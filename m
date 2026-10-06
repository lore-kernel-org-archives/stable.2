Received: from smtp05-ext.udag.de (smtp05-ext.udag.de [62.146.106.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85AC49EC43
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 16:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791302460; cv=none; b=L31Y+rbWmBuwaX3ulvA7034jJqdTLRbc+G70MfrYr9Nftx6FQG2l8Pm2y6GhURF/kySN7SMw7taalGEUDBtjRRr7ms5EDx66Ks3THXfAxrPdO0wXhAAxc6izbPN2xscS7b4kUmLGJNLB8mFHtK4R/qB4dw4O95fHV4jax7Ef/JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791302460; c=relaxed/simple;
	bh=CwtCgc7GmHfPCHrSkhc+aX8cJgCS9OW2ZiU43jG8zec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NtBfxKgRSGMrxbsE2mYlOqCICrdKul5PHI9k6PRIxN+CqTCj/Q0If8RsvABTdRRH9t3WKVfTiLL2Q4QnGkkT/iY6yKi1jZ7yobhF00KE0FhnDy5X13Rw9Syi1R1s+vY4GeAJCivfB7vmn+uAVYa0Wy5LhPmF42qAFWOo3f4tycM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de; spf=pass smtp.mailfrom=birthelmer.de; arc=none smtp.client-ip=62.146.106.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.de
Received: from localhost (043-134-067-156.ip-addr.inexio.net [156.67.134.43])
	by smtp05-ext.udag.de (Postfix) with ESMTPA id 39C59E01A6;
	Tue,  6 Oct 2026 17:55:31 +0200 (CEST)
Authentication-Results: smtp05-ext.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.de
Date: Tue, 6 Oct 2026 17:55:30 +0200
From: Horst Birthelmer <horst@birthelmer.de>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, fuse-devel@lists.linux.dev, 
	syzbot+e8200299b0556976e13c@syzkaller.appspotmail.com, stable@vger.kernel.org
Subject: Re: [PATCH v1] fuse: don't launder folios of a bad inode
Message-ID: <asUZLV-0YeC5BTvz@fedora.fritz.box>
References: <20261006105136.3751196-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261006105136.3751196-1-joannelkoong@gmail.com>

On Tue, Oct 06, 2026 at 03:51:36AM -0700, Joanne Koong wrote:
> fuse_flush() and fuse_writepages() reject writing back dirty data for
> any inode that has been marked bad, but fuse_launder_folio() doesn't.
> 
> This can cause the following warning in fuse_write_file_get() to
> trigger, as reported by syzbot:
> 
> WARNING: fs/fuse/file.c:2043 at fuse_write_file_get fs/fuse/file.c:2043 [inline]
> WARNING: fs/fuse/file.c:2043 at fuse_iomap_writeback_range+0x7c8/0x18f0 fs/fuse/file.c:2227
> Call Trace:
>     iomap_writeback_folio+0x1526/0x2490 fs/iomap/buffered-io.c:2022
>     fuse_launder_folio+0x17b/0x240 fs/fuse/file.c:2331
>     folio_unmap_invalidate+0x4cd/0x830 mm/truncate.c:634
>     invalidate_inode_pages2_range+0x629/0xb30 mm/truncate.c:726
>     fuse_open+0x5a6/0x770 fs/fuse/file.c:297
> 
> This can be hit on a writeback cache mount:
> 1) a writeable file is open and a buffered write dirties some pages
> 2) another thread opens the same file read-only. fuse_open() passes the
>    bad inode check and sends OPEN to the server.
> 3) a SETATTR reply with the wrong file type marks the inode bad
> 4) the writeable file is closed. Flush and release skip writeback
>    because the inode is bad. The pages stay dirty but the file gets
>    removed from write_files.
> 5) server replies to the OPEN. The reply has no FOPEN_KEEP_CACHE, so
>    fuse_open() calls invalidate_inode_pages2().
> 6) the invalidation finds the dirty pages and calls
>    fuse_launder_folio(), which finds no wriable file and hits the
>    WARN_ON in fuse_write_file_get().
> 
> Instead of trying to write back dirty data for the bad inode,
> fuse_launder_folio() should return -EIO.
> 
> Fixes: 5d069dbe8aaf ("fuse: fix bad inode")
> Reported-by: syzbot+e8200299b0556976e13c@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=e8200299b0556976e13c
> Cc: stable@vger.kernel.org
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/fuse/file.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 6d707f2b3bff..0ef46f6e0267 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -2351,6 +2351,9 @@ static int fuse_launder_folio(struct folio *folio)
>  		.wb_ctx	= &data,
>  	};
>  
> +	if (fuse_is_bad(wpc.inode))
> +		return -EIO;
> +
>  	if (folio_clear_dirty_for_io(folio)) {
>  		err = iomap_writeback_folio(&wpc, folio);
>  		err = fuse_iomap_writeback_submit(&wpc, err);
> -- 
> 2.52.0
> 
> 

Hi Joanne,

I have tested a lot of notification invalidation lately.
Did not hit this one yet.

LGTM!

Feel free to add
Reviewed-by: Horst Birthelmer <hbirthelmer@ddn.com>
