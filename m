Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794906484;
	b=Hqmd7nJiEaLJZp6nZScgq2ASdlSd4+q1EcTeGQUkgP2tMeq9Kypg9zSzX7H5EfSALxZM
	 jkirMZyuB6PlmVUjBQkOHykC63viCtkD6yD5WamfWe5lRuRiBcvwBDFeZciKIz3gsfdpe
	 fqzUPOx7cQ1jcacW4u2DSvGx8CJWs7vGBdOSWYTIPRhNCYUlahOI/QAYf/NxExAQFG0oD
	 mkVUppXf9/StwuNcY8XXVoCTmhf8tiiog1CpjkTsXEXxYyUbexU9jROleBBY3GgqXTWF0
	 b5VyHiJ/daHdZg3V38WJAgs/RQu2n1uknF2YY4kuV2Lqi8TPzOElcSH1kjaztW/Qyhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794906484;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=qnWHBF7/CrL3v/UaPQ3D9TUr4mSedb6GT4QDxJOnqGU=;
	b=jol/QuLV+AUGiqmNEI4yYR59MUsOELp9h9coJH+/uuzfxxIkI/gVnEiu1ioYQ3xWd4xj
	 rGIRL81l8sPgLwQr8gMq4TKunEUphSRjBfH0HWOqBJXOiSbLVEhHcSH5BjnjoWFRmKdAB
	 Mpyc/NJmCKrl1XIKyfFgpy6DSNQM3dFkziQDipfDBdRwbFaEzMaKBANBVkUhyceJCriP+
	 bvPXv8kYhwpPLsROXwShilR9gbpOCuCP+oO9XbifRq5QkGPi5aUBBNVT0JqRMm9kwKPeN
	 Yp/fUy4dfX5YWiWUZmOgM9twgpqwg4b1LI1ODB2sQc1UmND4RlnglfjJB3mjYFO/xFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=LCs1f+RU;
	arc=none smtp.remote-ip=220.197.31.3
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4F3606A31C;
	Tue, 17 Nov 2026 09:08:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D4F3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=LCs1f+RU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=qnWHBF7/CrL3v/UaPQ3D9TUr4mSedb6GT4QDxJOnqGU=;
	b=LCs1f+RUGsbrP4WTmPM9ppp0r1+F7AbvUWTQDhEkkpV3pwk4HCXey30Ilgl0pa
	dA3ss9N1EpbnYptkAxZNewxxSYDMxvQcsFKAToHSpYtNlTsXGV6x8e0Th6GTGn5R
	CGoce3EripQzp08kRk1Z4e/U1VKRTcxbagKK3k8dkhF1w=
Received: from [IPV6:2409:8900:1fc4:b5fb:f427:8008:88bf:afb9] (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3P2NXGfxqLzsVHw--.54292S2;
	Tue, 17 Nov 2026 17:07:37 +0800 (CST)
Message-ID: <f35ed0ad-aece-4d8a-b6f3-5ad8c4f1a13f@163.com>
Date: Tue, 17 Nov 2026 17:07:35 +0800
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
Subject: Re: [PATCH v6] ntfs: trim the sizes after a short write
To: Zhan Xusheng <zhanxusheng1024@gmail.com>, linkinjeon@kernel.org,
 hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, zhanxusheng@xiaomi.com
References: <20261117082021.2947603-1-zhanxusheng1024@gmail.com>
Content-Language: en-US
From: liubaolin <liubaolin12138@163.com>
In-Reply-To: <20261117082021.2947603-1-zhanxusheng1024@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3P2NXGfxqLzsVHw--.54292S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuw45Wry3GFWxWF4rWw45ZFb_yoW3ur45pr
	Wa9r13KrWIvryxCrnxGa4UXF4Yg395Cr4UC343GF9xCr93Crn7WFyUtrW0gayvyrZ2yw1F
	vF4vvrWkWwn8Zw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uf8nrUUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbC6Ro2AWr8GVqCMQAA3i



在 2026/11/17 16:20, Zhan Xusheng 写道:
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
> Run the existing rollback for a short write as well, and roll the data
> size back to the end of what was written.  Keep the initialized size,
> as a page fault through a shared mapping may rely on it while the write
> is stalled on its source, and zero what the write did not reach, up to
> the end of the block holding pos + count.  Only if that fails, take the
> initialized size back to where the zeroing started, if it is above that.
> 
> Fixes: b041ca562526 ("ntfs: update iomap and address space operations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
> ---
> v6: cap that fallback at the current initialized size, which a failed
> extension before the write can leave below pos (Baolin).
> v5 (Baolin):
> - start the zeroing at pos, not at the old initialized size, which
>    overwrote data stored through a shared mapping below pos
> - do the same for a direct write, instead of truncating the page cache
>    and taking the initialized size back
> - if the zeroing fails, take the initialized size back to where it
>    started, instead of skipping both rollbacks
> v4: for a buffered write, zero the unwritten range instead of
> truncating the page cache and taking the initialized size back, which
> dropped data stored through a shared mapping during the copy (Baolin).
> v3: clear the cache up to EOF, not up to the extended initialized
> size, which left the rest of the block holding pos + count (Baolin).
> v2: also clear the cached tail of the last block, which v1 left in
> place when the write stayed inside the old data size (Baolin).
> 
> v5: https://lore.kernel.org/all/20261116091121.2547497-1-zhanxusheng1024@gmail.com/
> v4: https://lore.kernel.org/all/20261113050148.1466682-1-zhanxusheng1024@gmail.com/
> v3: https://lore.kernel.org/all/20261112093233.1118469-1-zhanxusheng1024@gmail.com/
> v2: https://lore.kernel.org/all/20261112030815.982026-1-zhanxusheng1024@gmail.com/
> v1: https://lore.kernel.org/all/20261111093459.660484-1-zhanxusheng1024@gmail.com/
> 
> Tested in a VM on ntfs-next b025f526c5d0, with all free space filled
> with a known pattern first.  Short buffered writes of 4M, old data
> readable after drop_caches and after remount, 3 runs each:
> 
>                                      unfixed    v5     v6
>    fallocated, ends block-aligned    3137536    0      0
>    fallocated, ends inside a block   3141332    0      0
>    fallocated, unaligned start       3137536    0      0
>    same, pos + count in that page    -          0      0
>    append                            3137536    0      0
> 
> Marker stored through a shared mapping at 64K while pwritev() is
> stalled on a userfaultfd source page, state after remount, with and
> without fallocate():
> 
>                                            unfixed  v5     v6
>    buffered 4K at 128K, EFAULT             lost     lost   kept
>    O_DIRECT 12K at 0, EFAULT               lost     lost   kept
>    buffered 12K at 0, short 8192 (v3)      kept     kept   kept
> 
> A store into [pos + ret, pos + count) itself during the write is
> zeroed, as that range belongs to the write.  With iomap_zero_range()
> failing (injected -ENOMEM), a 32K write to a 16K file that returns
> 12288 leaves the size at 28K with no old data, also after remount.
> fsx (buffered, no-mmap, O_DIRECT and mixed), compressed files,
> fallocate, insert/collapse range and punch hole give the same results
> with v6 as with v5.
> ---
>   fs/ntfs/file.c | 70 +++++++++++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 63 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
> index 3213a0c9f96b..866aaca1887e 100644
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
> @@ -939,14 +950,59 @@ ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>   		 */
>   		filemap_invalidate_lock(vi->i_mapping);
>   
> +		/*
> +		 * A page fault through a shared mapping may have used the
> +		 * extended initialized size while the write was stalled on
> +		 * its source, so keep that size and zero what the write did
> +		 * not reach instead.  [old_init_size, pos) was zeroed before
> +		 * the write.  Past end, zero the rest of the block that a
> +		 * buffered copy may have read from disk, unless such a fault
> +		 * already moved the initialized size past end and zeroed it.
> +		 */
> +		if (NInoNonResident(ni) && !NInoCompressed(ni) &&
> +		    ni->initialized_size > new_init_size) {
> +			loff_t zstart = max(pos, new_init_size);
> +			loff_t zend = ni->initialized_size > end ? end :
> +				      round_up(end, i_blocksize(vi));
> +			int err = 0;
> +
> +			zend = min(zend, new_data_size);
> +			if (zend > zstart) {
> +				err = iomap_zero_range(vi, zstart,
> +						zend - zstart, NULL,
> +						&ntfs_seek_iomap_ops,
> +						&ntfs_iomap_folio_ops, NULL);
> +				/* A direct read must not see the old blocks. */
> +				if (!err && iocb->ki_flags & IOCB_DIRECT)
> +					err = filemap_write_and_wait_range(
> +						vi->i_mapping, zstart, zend - 1);
> +			}
> +			if (!err)
> +				new_init_size = min(ni->initialized_size,
> +						    new_data_size);
> +			else
> +				new_init_size = min3(ni->initialized_size,
> +						     zstart, new_data_size);
> +		}
> +
>   		/* ntfs_attr_set_initialized_size() rejects a resident one. */
> -		if (ni->initialized_size != old_init_size &&
> +		if (ni->initialized_size != new_init_size &&
>   		    NInoNonResident(ni)) {
>   			struct ntfs_inode *mrec_ni = ntfs_base_inode(ni);
>   
> +			/*
> +			 * Only reached when the zeroing above failed or did
> +			 * not apply.  Drop what was cached past the new
> +			 * initialized size, as __ntfs_extend_initialized_size()
> +			 * does.
> +			 */
> +			if (ni->initialized_size > new_init_size)
> +				truncate_pagecache_range(vi, new_init_size,
> +						max_t(loff_t, i_size_read(vi),
> +						      ni->initialized_size) - 1);
>   			mutex_lock(&mrec_ni->mrec_lock);
>   			init_err = ntfs_attr_set_initialized_size(ni,
> -					old_init_size);
> +					new_init_size);
>   			mutex_unlock(&mrec_ni->mrec_lock);
>   		}
>   		/*
> @@ -955,13 +1011,13 @@ ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
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

Looks good to me.

Reviewed-by: Baolin Liu <liubaolin@kylinos.cn>

