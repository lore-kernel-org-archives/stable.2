Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794557714;
	b=hgatnrIVbOnJ/PNo0Kh49jPzlXyup6TR5ZdZvW6pXoIpPLHgCwBx48OhXJ+TBgxIfFx7
	 BABQzmpBtiUFa0O/gQe780dl+VkGgzipIZkb6yZ7M5hIcDlhvd8FrxQJ/APgTVRxCzlVr
	 A0bgZ48jr3GcFyxO8Uhv9FEVinvuBR2c77IJeqiPwBsbt36+63S1hkAKiVBo3B7rPApiU
	 aTIEausSNgydtCQigzhPlXXlT01YMak1oefjR2lj8wZvS6nBV1kBfuxl0eYc4u/BkLPOv
	 l0+IINmXYJQU2rXh3y+fLjllr0XIwvShJ+2UyQNXRq0j3wLlD39sNJFRhnV+wiyIcxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794557714;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=pJ2zRB2nOtupazWtDNzTwEvlTT+D3QQlaUT9Cj9fttQ=;
	b=SMo4A59I8SuTRjcR9Fp676i1lBwYJTCW6l8KrjwSwKiJPWHG7P4vJ7cdZ1vQVsSZSFWI
	 IPgYEDii2xxpNZZsDUFI61lFFNex8hG0PRXno+0zFxqLyOf0kAi3LctNHMk0pd3XfZjeV
	 5LIyFpJ6ein9uIz3iML1OypidvP/rmv5h/apJMsXPyoOORDlOFdPjhh+x+JhQwFq8MOR/
	 jUR5uNpU36+kLiQfVh1wX+SpJalj3678h0dGJmAizzNbqXgX1SdtLXuHk7msuNbxGJHVn
	 rf3UL17ANdYvNZKF1VHCFkSppJtv7zhjPOCV1ab2R1CPlnnseSetvI+bp4pLbwBXc9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Ez4k+jeP;
	arc=none smtp.remote-ip=117.135.210.3
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDF3606A883;
	Fri, 13 Nov 2026 08:15:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFDF3606A883
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Ez4k+jeP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=pJ2zRB2nOtupazWtDNzTwEvlTT+D3QQlaUT9Cj9fttQ=;
	b=Ez4k+jePeLZedPNuIjdwRLGk41oaHHiydI+MuFfRT33uDA9kaq7+7S2etCl4C8
	ExrSDW02BK6Bh5n3gec7b9E7ib2AVR9nZgugxp7SbQXmUidoRbtCoXnWYQIIGDkI
	dCj1t5gs1CCm/VF2lyTzePVk2OZF78y4RD7BhO/t7iVEc=
Received: from [IPV6:2409:8900:1ef3:1936:e899:996a:6176:8c69] (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgD3f434xvZq1upLFA--.65211S2;
	Fri, 13 Nov 2026 16:14:50 +0800 (CST)
Message-ID: <73cf5c4c-d650-40f9-9e2c-4d8b993f0b5a@163.com>
Date: Fri, 13 Nov 2026 16:14:48 +0800
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
Subject: Re: [PATCH v4] ntfs: trim the sizes after a short write
To: Zhan Xusheng <zhanxusheng1024@gmail.com>, linkinjeon@kernel.org,
 hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, zhanxusheng@xiaomi.com
References: <20261113050148.1466682-1-zhanxusheng1024@gmail.com>
Content-Language: en-US
From: liubaolin <liubaolin12138@163.com>
In-Reply-To: <20261113050148.1466682-1-zhanxusheng1024@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgD3f434xvZq1upLFA--.65211S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuw45Wry3GFW7JrWxXFy3CFg_yoWfKF1xpr
	Wa9r45KrWkGw4xGrnIqa1UX3WYqrWrCF45C345GFy7Awn5CrnFqFyUtFW0ga9Fyrs7t3WF
	yFWkZrWkurn8Zw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UTCJQUUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbC6RpIE2r2xvqErwAA3j



在 2026/11/13 13:01, Zhan Xusheng 写道:
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
> size back to the end of what was written.  For a buffered write, keep
> the initialized size and zero what the copy did not reach, up to the
> end of the block holding pos + count, because a page fault through a
> shared mapping may already rely on that initialized size.  A direct
> write rolls the initialized size back as before.
> 
> Fixes: b041ca562526 ("ntfs: update iomap and address space operations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
> ---
> v4: for a buffered write, zero the unwritten range instead of
> truncating the page cache and taking the initialized size back, which
> dropped data stored through a shared mapping during the copy (Baolin).
> v3: clear the cache up to EOF, not up to the extended initialized
> size, which left the rest of the block holding pos + count (Baolin).
> v2: also clear the cached tail of the last block, which v1 left in
> place when the write stayed inside the old data size (Baolin).
> 
> v3: https://lore.kernel.org/all/20261112093233.1118469-1-zhanxusheng1024@gmail.com/
> v2: https://lore.kernel.org/all/20261112030815.982026-1-zhanxusheng1024@gmail.com/
> v1: https://lore.kernel.org/all/20261111093459.660484-1-zhanxusheng1024@gmail.com/
> 
> Tested in a VM on ntfs-next b025f526c5d0, with all free space filled
> with a known pattern first.  Short buffered writes of 4M, old data
> readable after drop_caches and after remount, 3 runs each:
> 
>                                      unfixed    v3     v4
>    fallocated, ends block-aligned    3137536    0      0
>    fallocated, ends inside a block   3141332    0      0
>    fallocated, unaligned start       3137536    0      0
>    same, pos + count in that page    -          0      0
>    append                            3137536    0      0
> 
> With the sequence from the v3 review (marker stored through a shared
> mapping at 64K while pwritev() at 0 is stalled, short count 8192), the
> marker is kept on unfixed and v4 and lost on v3, 3 runs each.  A store
> into [pos + ret, pos + count) itself during the copy is zeroed with v4,
> as that range belongs to the write.  fsx (buffered, no-mmap, O_DIRECT
> and mixed), compressed files, fallocate, insert/collapse range and
> punch hole give the same results with v4 as with v3.
> ---
>   fs/ntfs/file.c | 57 +++++++++++++++++++++++++++++++++++++++++++-------
>   1 file changed, 50 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
> index 3213a0c9f96b..5ac11d60be37 100644
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
> @@ -939,14 +950,46 @@ ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>   		 */
>   		filemap_invalidate_lock(vi->i_mapping);
>   
> +		/*
> +		 * A page fault through a shared mapping may have used the
> +		 * extended initialized size while a buffered write was copying,
> +		 * so taking it back could drop that data.  Zero what the write
> +		 * did not reach instead, including the rest of the block at end
> +		 * that the copy may have read from disk, unless such a fault
> +		 * already moved the initialized size past end and zeroed it.
> +		 */
> +		if (!(iocb->ki_flags & IOCB_DIRECT) && NInoNonResident(ni) &&
> +		    !NInoCompressed(ni) && ni->initialized_size > new_init_size) {
> +			loff_t zend = ni->initialized_size > end ? end :
> +				      round_up(end, i_blocksize(vi));
> +
> +			zend = min(zend, new_data_size);
> +			if (zend > new_init_size)
> +				init_err = iomap_zero_range(vi, new_init_size,
> +						zend - new_init_size, NULL,
> +						&ntfs_seek_iomap_ops,
> +						&ntfs_iomap_folio_ops, NULL);

Hi Xusheng,

    Thanks for v4. I reran the buffered mmap test from my v3 review and 
confirmed that the marker is now preserved.

    However, there is still a problem with the zeroing range here.
    If the write fails without copying any bytes, new_init_size remains 
old_init_size, which can be below pos. A concurrent mmap write may have 
already stored valid data in that gap.
    For example, start with a 1 MiB file with initialized_size == 0. 
Pause a 4 KiB buffered write at 128 KiB on its first source page, then 
store a marker through a shared mapping at 64 KiB. If source access 
subsequently fails with EFAULT, this code starts zeroing at offset zero 
and overwrites the marker, although it is outside the requested write range.

   I reproduced this both with and without fallocate(). The marker is 
also lost after remount.

   Could we use a separate zeroing start, bounded by max(pos, 
new_init_size), while keeping new_init_size for the metadata update?

Thanks,
Baolin.

> +			new_init_size = min(ni->initialized_size, new_data_size);
> +		}
> +
>   		/* ntfs_attr_set_initialized_size() rejects a resident one. */
> -		if (ni->initialized_size != old_init_size &&
> +		if (!init_err && ni->initialized_size != new_init_size &&
>   		    NInoNonResident(ni)) {
>   			struct ntfs_inode *mrec_ni = ntfs_base_inode(ni);
>   
> +			/*
> +			 * A direct write did not use the page cache; drop what
> +			 * a concurrent reader may have cached past the new
> +			 * initialized size, as __ntfs_extend_initialized_size()
> +			 * does.
> +			 */
> +			if (iocb->ki_flags & IOCB_DIRECT)
> +				truncate_pagecache_range(vi, new_init_size,
> +						max_t(loff_t, i_size_read(vi),
> +						      ni->initialized_size) - 1);
>   			mutex_lock(&mrec_ni->mrec_lock);
>   			init_err = ntfs_attr_set_initialized_size(ni,
> -					old_init_size);
> +					new_init_size);

Hi XuSheng,
    The mmap race can also happen on this DIO path. A direct write can 
block while faulting in its source pages, and another thread can 
complete a shared mmap write during that time. The inode lock held by 
the write does not serialize that mmap activity.

    I tested a 12 KiB O_DIRECT pwritev() at offset zero, paused on a 
source-page fault, with a concurrent mmap store at 64 KiB. When 
pwritev() subsequently returned EFAULT, the marker was lost,including 
after remount.

    The initialized-size rollback already had this race before the 
patch. This cache truncation also discards the concurrent writer's data, 
so we cannot assume that the pages being dropped only contain data 
cached by a reader.

    We need to preserve the initialization established by mmap on this 
path too. Removing the cache truncation alone would not be enough,since 
rolling initialized_size back would still hide that data.

Thanks,
Baolin.

>   			mutex_unlock(&mrec_ni->mrec_lock);
>   		}
>   		/*
> @@ -955,13 +998,13 @@ ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>   		 * the uninitialized tail, so skip it unless the rollback
>   		 * above restored that size.
>   		 */
> -		if (ni->data_size != old_data_size && !init_err) {
> +		if (ni->data_size != new_data_size && !init_err) {

Hi XuSheng,
    What happens if the new iomap_zero_range() call fails?
    Both the initialized-size update above and this data-size rollback 
are skipped, leaving the extended sizes in place. Setting NVolErrors and 
logging the failure does not prevent subsequent reads.

   I made folio acquisition return -ENOMEM during zeroing after a short 
write, to simulate an allocation failure. With an old file size of 16 
KiB, a 32 KiB request returned 8192 but left the file size at 32 KiB. 
fsync() succeeded, and the size was still 32 KiB after remount. Without 
the injected failure, it was restored to 16 KiB.

   This test only checked the sizes, not the contents of the unwritten 
range. But if zeroing fails, we cannot assume that the range covered by 
the published initialized_size has been initialized.

   Could we handle this failure without leaving that range exposed?
Simply returning an error would not repair the initialized size that has 
already been published.

Thanks,
Baolin.

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

