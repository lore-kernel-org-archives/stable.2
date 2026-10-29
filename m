Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.210.214.84
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793238777;
	b=oKwwsotZGqMyqDCQ7yjeADjpkzxpNazrC76nOCTpYLKTMGksT+SnU/L0zss+h0eYTrYb
	 Glm5jrM21bm0J0b0qQRe3YxVPLh/q5nV9Ixp4Aw4q2Lu3JZo/67O6S4qW14tc2v1Fb9Ph
	 6c442JInFLD44og9QpKe3lzw2xd76OtZb3qZBDFUllr70zBnA+L3jdhDSg7UMxsSN8Z6p
	 s/eZQZwcUTJrdxFPJJyANeOOGG/o1RSJ7H2mYvqBdq3KnhYyQJYEERmw8nNX4gbdalsCG
	 xmzd34Uq3IFOwEiOMZliDiKY5LZc/MaauFByINMGcHxndqgE8hDmSL50QXMZiN9y9eQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793238777;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=C9c/FinTKni5fjiOAL3dhHGyqemiEY429uzOPHxoiic=;
	b=L9RJHlkpk3iP0rjS8tSWNT3xL9hBO0kv5xmY41z4MjMQ3pOBqG1TxCAAyuT4oi1AkUu3
	 UE0gCQONBZU31yeUpg4GiPf+TtuV8GDYN7QdJCoVlat3vQpjctePmscb/hFaP/FrER8J2
	 nAthuK+4a2nkNVzNSAXMgaf3qFOTqzTXQLHYlWB4RkYDiQQ0/jCQyHO2VAyO5RSDNcEIB
	 +/Al8eB3CDgdztbA7Y5dMX33TJJQBrdB91MvTxoHzlK42ejioYdpGHAwrUqD04aPibaDI
	 vDW+9rpo+09djYDH//yqZlbIrCZ3JwH34Mdbw/SYGRGMUq3YiJ7p6a9o1kZY1+iLQtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=codewreck.org;
	spf=pass smtp.mailfrom=codewreck.org;
	dkim=pass header.d=codewreck.org header.i=@codewreck.org header.a=rsa-sha256 header.s=2 header.b=WdSJVkYE;
	arc=none smtp.remote-ip=62.210.214.84
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B215606A31C;
	Thu, 29 Oct 2026 01:52:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B215606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=codewreck.org header.i=@codewreck.org header.a=rsa-sha256 header.s=2 header.b=WdSJVkYE
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 4452414C2D6;
	Thu, 29 Oct 2026 02:52:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1793238773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C9c/FinTKni5fjiOAL3dhHGyqemiEY429uzOPHxoiic=;
	b=WdSJVkYEncQ7JoKxIzgAvvzPNkdA0CDsHhEVEvxglGObX3NhvLvjgp4Q6ZGdIFB2lysLJ4
	LUL4seZVg/mEDPfqxDzlGFtLG85LcefQiiQKKVHUlq6Lgrpwj7YTjpZYAwG1ZuiWDX9Iq+
	qqxKvobBBCVzRvkSJh7rEyEUozTJg/CC0X3WMUoIHTPjuvgXWeMS+4huQNF/UEGapMnClY
	/3GzyqFaLMKyT9q9nEduSPXCBHH6zFCf7iENQDTQlRxjn0CcpT2uYrFkKjSdHMwijt8C0N
	L1pYG2mFMbMnbK2tkg/yqq9p84A8uiGgSLEVN9NbjfHz858YO1cBrXlmAWyxQA==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 66ff3547;
	Thu, 29 Oct 2026 01:52:49 +0000 (UTC)
Date: Thu, 29 Oct 2026 10:52:34 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Yuanfu Xie <yuanfuxie@stu.pku.edu.cn>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] 9p: don't decrement a server-owned zero nlink
Message-ID: <auKm4tewzgNX6VLh@codewreck.org>
References: <8B490036-EBB0-4A36-AE39-F294F7C79649@stu.pku.edu.cn>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8B490036-EBB0-4A36-AE39-F294F7C79649@stu.pku.edu.cn>

Yuanfu Xie wrote on Mon, Sep 28, 2026 at 03:25:48PM +0800:
> A 9P2000.L server can report nlink=0 for a regular file that still
> exists.  On a cache=loose or cache=fscache mount, lookup stores that
> value with set_nlink().  A later successful unlink calls
> v9fs_dec_count(), which still calls drop_nlink() for a non-directory.
> drop_nlink() warns, and the unsigned link count wraps to 4294967295.
> fstat() on a descriptor opened before the unlink shows 0 before and
> 4294967295 after.
> 
> The warning on the unpatched kernel, trimmed:
> 
> WARNING: fs/inode.c:408 at drop_nlink+0xac/0xd0, CPU#1: trigger/188
> CPU: 1 UID: 0 PID: 188 Comm: trigger Tainted: G                 N  7.3.0-rc4-00537-ga3ff15db6820 #1 PREEMPT(lazy)
> RIP: 0010:drop_nlink+0xac/0xd0
> Call Trace:
>  <TASK>
>  v9fs_remove+0x529/0x750
>  vfs_unlink+0x2f0/0xbd0
>  filename_unlinkat+0x340/0x6c0
>  __x64_sys_unlink+0x46/0x70
>  do_syscall_64+0xe8/0x4f0
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>  </TASK>
> ---[ end trace 0000000000000000 ]---
> 
> Directories whose cached nlink is at most 2 already skip this
> decrement, because the exported filesystem may not maintain nlink
> (commit ac89b2ef9b559).  cache=none skips it as well (commit
> 574aa0b479947).  cache=mmap does not take this path: it sets neither
> CACHE_META nor CACHE_LOOSE.  A regular file on cache=loose or
> cache=fscache still does.  Its count came from GETATTR and may
> already be zero, so skip the decrement when i_nlink is already 0.
> 
> Verified on 7.3-rc4-00537-ga3ff15db6820 with only this change.  A
> server that advertises nlink=0 and accepts the unlink no longer
> warns, and the open descriptor stays at nlink 0.  An honest server
> on the same mount still goes from 1 to 0.  A rejected unlink leaves
> the count unchanged.  cache=none is unchanged.  With panic_on_warn
> the unpatched kernel panics on the warning; the patched kernel does
> not.
> 
> Fixes: ac89b2ef9b559 ("9p: don't maintain dir i_nlink if the exported fs doesn't either")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yuanfu Xie <yuanfuxie@stu.pku.edu.cn>


This is the same as part of what was sent in [1], but they never
bothered resending split commits, so picking this up instead

[1] https://lore.kernel.org/r/20260919221734.3708000-1-benquike@gmail.com

> ---
>  fs/9p/vfs_inode.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
> index d7e678de0a036..347739b81513f 100644
> --- a/fs/9p/vfs_inode.c
> +++ b/fs/9p/vfs_inode.c
> @@ -495,6 +495,12 @@ static int v9fs_at_to_dotl_flags(int flags)
>   * nothing and races with concurrent metadata fetches that may already
>   * have observed the post-unlink value (nlink == 0).
>   *
> + * The same applies to a regular file whose cached nlink has already been
> + * driven to zero by the server: in the cached modes the attributes come
> + * from GETATTR and are applied verbatim, so decrementing a link count the
> + * server does not maintain only trips the drop_nlink() WARN_ON and
> + * underflows i_nlink.
> + *
>   * @inode: inode whose nlink is being dropped
>   */
>  static void v9fs_dec_count(struct inode *inode)
> @@ -503,6 +509,8 @@ static void v9fs_dec_count(struct inode *inode)
>  
>  	if (!(v9ses->cache & (CACHE_META | CACHE_LOOSE)))
>  		return;
> +	if (inode->i_nlink == 0)
> +		return;
>  	if (!S_ISDIR(inode->i_mode) || inode->i_nlink > 2)
>  		drop_nlink(inode);
>  }
> 
> 

-- 
Dominique Martinet | Asmadeus
