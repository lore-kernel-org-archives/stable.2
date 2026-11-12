Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794464649;
	b=z23FLTTgWO22VlJ3+XSnVStD1mSZbWpOOLUwP6gAhfxbD5RXmk012jgz9J37X4a7W0ev
	 R1grZyj6qBhFaSMd3jlg5Gd4ictVWc9M0ZBfO+5pjXSUD9hXNBV0UNuhliNMy65lD1f2j
	 16w24fWC32cwCsjLNFybsAl3wbKeEKSlGOdnWtNhc+Jr3ppVEldmLEUfjqH/eWgRbalGt
	 vwSlopyLl9xZjF8E7R6smmZ5FNQYXTyoKGOTdpNw+3RRHriJVUSEFUYkSlMeahJK/e+1O
	 nLjY51QiT1CsUl87IF/N/U2PpHHKwpg+PwnwTHqktyVN0snnG7jFzvQPR/MYJmL7h9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794464649;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=aetu5cj6UdOKu42A/Y+FDN7Lw54rxn0+iQWvtHhl8Tc=;
	b=Mljz9/0ZM46764VKTRrtZdJVXKTBr/TMlJTmDPR2JvZQjLNWU7XYAcRbiZhkECOiQDYy
	 gxcnMFBqWtzKswRQvrkOaR0te+D+LD79H1IlcpaG4SjWbYF43HUkThvaB8v0CQDigLCcg
	 cX5WdEe9XF+kb1d0YQKuayeRyHhJsLCSxK5PeJcTu7RaNBPp19wD+JCrOYXiEJX6wNWZE
	 LESGR36ZmoTqrqnKsQ6q6y1DNG1U8trO6qi+ltuEXO0OH3kbTQYqoK9JKau3Opgk9ggsU
	 kVUy3vmdcdWw4f3wxAGoEG0pKFRLGsIb9Fa+COI+TVbMCiOkuRDseMgssGBkts0oHpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=D7zkoCCD;
	arc=none smtp.remote-ip=117.135.210.3
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52149606A321;
	Thu, 12 Nov 2026 06:24:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52149606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=D7zkoCCD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=aetu5cj6UdOKu42A/Y+FDN7Lw54rxn0+iQWvtHhl8Tc=;
	b=D7zkoCCDeunCBO9j58cC4cQtzcBG/TL9gVdM1uJTd/K2bx19TMH5mbkEAEMpfn
	Y2W0VOEBpFa+5/jq62MuiL5341f1X4Qg15UVZI8alnf0eljZO3D/L44LgIcyaAf3
	w8B1YadC5FajO9yY8oCAJ8eIGpN22wt5O5ZsaIREae33Q=
Received: from [IPV6:2409:8900:1a93:3634:9bae:9736:f6e5:b25c] (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3jyZxW_Vqzv1vHA--.25271S2;
	Thu, 12 Nov 2026 14:23:47 +0800 (CST)
Message-ID: <0b10e6be-f8ae-4b30-ac71-5cc6ede29103@163.com>
Date: Thu, 12 Nov 2026 14:23:45 +0800
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
Subject: Re: [PATCH v2] ntfs: trim the sizes after a short write
To: Zhan Xusheng <zhanxusheng1024@gmail.com>, linkinjeon@kernel.org,
 hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev, linux-kernel@vger.kernel.org,
 zhanxusheng@xiaomi.com, stable@vger.kernel.org
References: <20261112030815.982026-1-zhanxusheng1024@gmail.com>
Content-Language: en-US
From: liubaolin <liubaolin12138@163.com>
In-Reply-To: <20261112030815.982026-1-zhanxusheng1024@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3jyZxW_Vqzv1vHA--.25271S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuw45Wry7Ar18Gr13KFyfJFb_yoW7tFWfpr
	ya9r45trWkXrWxGrnxGa47XFWYqFWrWF1Uua45WFn3Arn3CrnIgF1Ut3yF9FWktrWkA3Wr
	tF4qqrZ5Wrn8ZaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UTCJQUUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbC6hML1Wr1W3N2nAAA36



在 2026/11/12 11:08, Zhan Xusheng 写道:
> From: Zhan Xusheng <zhanxusheng@xiaomi.com>
> 
> ntfs_file_write_iter() moves the data size and, for a non-resident
> uncompressed file, the initialized size to pos + count before the copy.
> __ntfs_extend_initialized_size() only zeroes [old initialized size, pos),
> so the range [pos, pos + count) is initialized only by the copy itself.
> When iomap_file_buffered_write() copies less than count, it returns a
> positive short count and the error rollback at out: does not run.  The
> file keeps the size pos + count, and [pos + ret, pos + count) reads back
> whatever the freed clusters held before, also after a remount.  A local
> user can read the old contents of freed clusters this way.
> 
> Run the existing rollback for a short write as well, and roll the two
> sizes back to the end of what was written instead of to the old sizes.
> A short copy that ends inside a block can also leave the rest of that
> block cached as read from disk, so clear the page cache beyond the new
> initialized size before shrinking it.
> 
> Fixes: b041ca562526 ("ntfs: update iomap and address space operations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
> ---
> v2: also clear the cached tail of the last block, which v1 left in
> place when the write stayed inside the old data size (Baolin).
> 
> v1: https://lore.kernel.org/all/20261111093459.660484-1-zhanxusheng1024@gmail.com/
> 
> Tested in a VM on ntfs-next b025f526c5d0, with all free space filled
> with a known pattern first.  Short buffered writes of 4M, old data
> readable after drop_caches and after remount, 3 runs each:
> 
>                                      unfixed    v1     v2
>    fallocated, ends block-aligned    3137536    0      0
>    fallocated, ends inside a block   3141332    212    0
>    fallocated, unaligned start       3137536    412    0
>    append                            3137536    0      0
> 
> A short write 1M past EOF, O_DIRECT, resident and compressed files and
> full writes give the same results with v2 as with v1.
> ---
>   fs/ntfs/file.c | 33 ++++++++++++++++++++++++++-------
>   1 file changed, 26 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
> index 3213a0c9f96b..1779110a0c4f 100644
> --- a/fs/ntfs/file.c
> +++ b/fs/ntfs/file.c
> @@ -928,10 +928,21 @@ ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>   		ret = iomap_file_buffered_write(iocb, from, &ntfs_write_iomap_ops,
>   				&ntfs_iomap_folio_ops, NULL);
>   out:
> -	if (ret < 0 && ret != -EIOCBQUEUED) {
> +	/*
> +	 * Both sizes were moved to end before the copy, so a short write,
> +	 * like a failed one, must take back what it did not write.
> +	 */
> +	if (ret < count && ret != -EIOCBQUEUED) {
> +		loff_t new_init_size = old_init_size;
> +		loff_t new_data_size = old_data_size;
>   		int init_err = 0;
>   		int data_err = 0;
>   
> +		if (ret > 0) {
> +			new_init_size = max(old_init_size, pos + ret);
> +			new_data_size = max(old_data_size, pos + ret);
> +		}
> +
>   		/*
>   		 * Like ntfs_setattr_size(): __ntfs_attr_truncate_vfs()
>   		 * expects the invalidate lock held across the size
> @@ -940,13 +951,21 @@ ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>   		filemap_invalidate_lock(vi->i_mapping);
>   
>   		/* ntfs_attr_set_initialized_size() rejects a resident one. */
> -		if (ni->initialized_size != old_init_size &&
> +		if (ni->initialized_size != new_init_size &&
>   		    NInoNonResident(ni)) {
>   			struct ntfs_inode *mrec_ni = ntfs_base_inode(ni);
>   
> +			/*
> +			 * A short copy can leave the rest of the last block
> +			 * cached as read from disk.  Clear what is no longer
> +			 * initialized before shrinking the initialized size.
> +			 */
> +			if (ni->initialized_size > new_init_size)
> +				truncate_pagecache_range(vi, new_init_size,
> +						ni->initialized_size - 1);

Hi Xusheng,
    Could the upper bound here still leave cached bytes beyond the 
temporarily extended initialized size?

   For example, with 512-byte blocks and 4 KiB pages, consider an 
allocated file with:
   old_data_size = 8192
   old_init_size = 0
   pos           = 0
   count         = 5000
   ret           = 4200

   Before copying, initialized_size becomes 5000. When preparing the 
last partial page, __iomap_write_begin() can read [4096, 5120) and mark 
those blocks uptodate. After the short-copy retry, the successful write 
ends at 4200. ntfs_iomap_put_folio_non_resident() still sees 
initialized_size == 5000, which lies beyond the last successfully 
written block, so it does not clear the tail.

   This call then clears only [4200, 5000), leaving [5000, 5120) cached 
with the contents read from disk. Since data_size remains 8192, the 
later truncate_setsize() is skipped, and a subsequent buffered read can 
still return those cached bytes.

   Could we extend the cache cleanup through EOF, using an upper bound 
such as max_t(loff_t, i_size_read(vi), ni->initialized_size) - 1, 
similar to the cleanup in __ntfs_extend_initialized_size()?

Thanks,
Baolin.

>   			mutex_lock(&mrec_ni->mrec_lock);
>   			init_err = ntfs_attr_set_initialized_size(ni,
> -					old_init_size);
> +					new_init_size);
>   			mutex_unlock(&mrec_ni->mrec_lock);
>   		}
>   		/*
> @@ -955,13 +974,13 @@ ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>   		 * the uninitialized tail, so skip it unless the rollback
>   		 * above restored that size.
>   		 */
> -		if (ni->data_size != old_data_size && !init_err) {
> +		if (ni->data_size != new_data_size && !init_err) {
>   			struct ntfs_inode *mrec_ni = ntfs_base_inode(ni);
>   
> -			truncate_setsize(vi, old_data_size);
> +			truncate_setsize(vi, new_data_size);
>   			mutex_lock(&mrec_ni->mrec_lock);
> -			data_err = __ntfs_attr_truncate_vfs(ni, old_data_size,
> -					old_data_size);
> +			data_err = __ntfs_attr_truncate_vfs(ni, new_data_size,
> +					new_data_size);
>   			mutex_unlock(&mrec_ni->mrec_lock);
>   			/* Like ntfs_setattr_size(): stay on the durable size. */
>   			if (data_err)
> 
> base-commit: b025f526c5d04929212c9d5fb7ffc96608f3eacc

