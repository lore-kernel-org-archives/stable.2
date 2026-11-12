Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794452025;
	b=jZjB/FkcYgPlI+KwSKl2FJxPY9zPn3woKrvay8YEs/hy6Z1HFreMViuaV0A/zvMe72fc
	 RH4rg+uzvlALO+2pQZrqBu6idMte8NM6kABSVXtaUwY4n8mg9QNZQo7G88WNRKGXtgHkY
	 eCl7j+dfnCqllftNU//U9y0zZ5a+ISTehVAykSWUI8a1T9Kbi3mJfx50oxBAGXBeczT6P
	 6dhozgRNFiEk6C/y0DwBPHTnTNj0UJ2v5idHPiwqhmBG+uXu5TGBDq+9NqKYMXpe+bxj2
	 F04uROB5AiiREvRh4n0Cd/3tDIC15n89iEn6kdwVZKlY8XXqIOOyeSx2sKcW1IBMe9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794452025;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=/cOEvzfTmLtCNzwUoH+WlzB71QyL8D0I1pIinOCRzTI=;
	b=Dul/8+2YYNWTI9GDqMy7sHX9P4hGwOHurSKNV6E8WnsnoaDUXlTR33xnnopMZaJ3PvEA
	 SbVpZS18q4Hn76ifO0tpGYMCHUH42vjqcGR/5DOsDr+BaY8W7fJvijtlvlyaXYL3i9shQ
	 WDYgVDkn3GrnlT9hyFhlGSELhTZkGManUNUSEIfhgkADsilH4U99QWDpFAddNzRlzTfad
	 MjOCdec8vgkjwNIbOC+/Meq8gl0Bpwj1ChcEIN1gZediRveN7kK6Aq5VZ6wgcJWqgZY6x
	 jqZFcaAOgRCixt8zc9IXkGUlHxruxNEqMnxrKEBvmyUpaAOxuPunIP9J7Vzny9bjGDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=GwRr4NbL;
	arc=none smtp.remote-ip=115.124.30.100
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B542606A321;
	Thu, 12 Nov 2026 02:53:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B542606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=GwRr4NbL
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1794452015; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=/cOEvzfTmLtCNzwUoH+WlzB71QyL8D0I1pIinOCRzTI=;
	b=GwRr4NbL92PaE9dXiYqpfaEQmojlJoXCfa6qSp6fbxgp5NX9teVBnzg2EdupgfFdX/jj8Xbcz0FSRE0EUfnSfOvhd+nDcg0Qi3N+PJhFrljLap0oDnbRZu18Sf0icb9sQbHGslxknnSpCDuzDsrCQOP/3WNYmL8C492jwTifXvM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0XEaSnJV_1794452014;
Received: from 30.221.145.78(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0XEaSnJV_1794452014 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 12 Nov 2026 10:53:34 +0800
Message-ID: <c5d699e4-12cd-4321-9b23-7d340ea8e959@linux.alibaba.com>
Date: Thu, 12 Nov 2026 10:53:33 +0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] gfs2: release the statfs glock when
 gfs2_clear_beyond_eof() fails
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261105054609.2759418-1-joseph.qi@linux.alibaba.com>
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261105054609.2759418-1-joseph.qi@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Ping...

On 11/5/26 1:46 PM, Joseph Qi wrote:
> gfs2_file_buffered_write() acquires the master statfs glock before
> writing to the rindex and releases it once the write is done.  The only
> error path in between used to be the failure of that acquisition, which
> gfs2_glock_nq_init() unwinds by itself, so the cleanup code at the end of
> the function never had to deal with a held statfs glock.
> 
> Commit 4982e58669b1 ("gfs2: page poisoning fix") added a call to
> gfs2_clear_beyond_eof() right after the acquisition and made it jump to
> out_unlock on failure.  That path only drops the inode glock and then
> frees statfs_gh, so a failed write to the rindex leaves the master
> statfs glock held exclusively and frees a holder that is still linked
> into the glock's holder list.  The GL_NOCACHE demote is requested by
> __gfs2_glock_dq(), which is never reached, so the glock stays locked for
> the rest of the mount, and the glock and pid references taken by
> __gfs2_holder_init() leak as well.  Walking the stale list entry later
> on, for instance from do_promote() or from a demote callback, is a
> use-after-free.
> 
> gfs2_clear_beyond_eof() zeroes the space beyond eof, which for the
> rindex ends up in adjust_fs_space(), so the call cannot be moved out
> from under the statfs glock.  Release the holder in the error path
> instead, guarded by gfs2_holder_initialized() so that the paths which
> never acquired it and the one which already released it are unaffected.
> 
> Fixes: 4982e58669b1 ("gfs2: page poisoning fix")
> Cc: stable@vger.kernel.org
> Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
>  fs/gfs2/file.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
> index 1efd0679badd9..2452d3ecf09c7 100644
> --- a/fs/gfs2/file.c
> +++ b/fs/gfs2/file.c
> @@ -1087,6 +1087,8 @@ static ssize_t gfs2_file_buffered_write(struct kiocb *iocb,
>  		goto retry;
>  	}
>  out_unlock:
> +	if (inode == sdp->sd_rindex && gfs2_holder_initialized(statfs_gh))
> +		gfs2_glock_dq_uninit(statfs_gh);
>  	if (gfs2_holder_queued(gh))
>  		gfs2_glock_dq(gh);
>  out_uninit:

