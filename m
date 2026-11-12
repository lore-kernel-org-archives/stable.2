Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794487646;
	b=JpTyRkJJp9qErB1KqqzBzAa2dBLEGl3wPLFadP8iM86Wz6FmZPK4wlHA9KCO2zyAnX2M
	 pASB2ura4aBfvvbIM8dDQN+3c9YQcuGRG7W+7lMGFzdYWEOcHwnWzxNDDM42JRi3a2KlU
	 B5+HSmpD1UVRof43ZgG71xXeHZ/g4SYZVvLlUJHzkZ4f34RaVIo8icniPe47WYDh8GWnw
	 edJlonTelQjTNb488lfpPgBOeall1HLjzr3XmzdUc+YvNHM/VauJix/dNNUn1IBdNp+x7
	 7xYQBo4HUx+Tp/w3u6BxqpkhW9BYU04MO4qxfyFDuyMDJwNV1J+e87YyYAYQexrwWqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794487646;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=bIodlW/bGF3SACwOI0QkVLlPXGoTnRTCszVw/7/5ocE=;
	b=HOkPuKyI0Dn4s076tUPO6EVw2aJPzyLti7IV9M2uXAuJqVINbtmCbUzA+8GwpG5kW75M
	 OKPCGwvTU5huInlZFN9XhXnKaM+K0xSSdS3a/i1EMwXd1TNNlF2HpTvqLHMTKO5mU8nRR
	 Kp4zDAckL8idyiwm9EjuvuaSFANC4PhT9cSSiYoQzPvFfUH7dRo3MZ0ZwmY7vU+74QVU9
	 lN9jN6q0K9Yc+QAlEDLOM8aUE6xx0ExhSmvsrcfXO8iKZesSx714WJJTqVfFuHSroVYQy
	 0YjviO74KqQni/6SbV3QWVw+47HyARTShERURj1Q7+pf1W60JstIieVfXjuDjbpjY2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Yz17Czs7;
	arc=none smtp.remote-ip=220.197.31.5
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE7D606A321;
	Thu, 12 Nov 2026 12:47:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AE7D606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Yz17Czs7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=bIodlW/bGF3SACwOI0QkVLlPXGoTnRTCszVw/7/5ocE=;
	b=Yz17Czs7KWnf6eflRGRlnsYd7Mwdf7uzIicuw4k3IXTLrZb0aZbgYtc6ofxRrH
	ZtqVxD5lH5FeeuUMOQPzRsIq9HEra40QyGQBeaJcnRKM+KbiQWRD1x0NvLq/5sFv
	jmGOX1BktznnxENYCVuMQDsgonkTR9ewEAm5/q61ztqCw=
Received: from [IPV6:2409:8900:1a93:3634:9bae:9736:f6e5:b25c] (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3HxU7tfVq6T9HHA--.54112S2;
	Thu, 12 Nov 2026 20:46:53 +0800 (CST)
Message-ID: <ba92fa60-caff-49d8-b1f8-62c8d93ca912@163.com>
Date: Thu, 12 Nov 2026 20:46:51 +0800
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
Subject: Re: [PATCH v3] ntfs: trim the sizes after a short write
To: Zhan Xusheng <zhanxusheng1024@gmail.com>, linkinjeon@kernel.org,
 hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev, linux-kernel@vger.kernel.org,
 zhanxusheng@xiaomi.com, stable@vger.kernel.org
References: <20261112093233.1118469-1-zhanxusheng1024@gmail.com>
Content-Language: en-US
From: liubaolin <liubaolin12138@163.com>
In-Reply-To: <20261112093233.1118469-1-zhanxusheng1024@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3HxU7tfVq6T9HHA--.54112S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuw45Wry7Ww4kXF4rCrWktFb_yoW3Jw18pr
	yagr45t3s7Gr4xGrnxK3WxXa1YqFWrWF4UuryrKF1fAwn5GrnxWFyUt3y09ayktrWkt3WY
	qF4qvrZ5urn8Z3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UTCJQUUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbC6h2UX2r1tT0dcQAA3H



在 2026/11/12 17:32, Zhan Xusheng 写道:
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
> block, and of the block holding pos + count, cached as read from disk,
> so clear the page cache from the new initialized size to EOF before
> shrinking it.
> 
> Fixes: b041ca562526 ("ntfs: update iomap and address space operations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
> ---
> v3: clear the cache up to EOF, not up to the extended initialized
> size, which left the rest of the block holding pos + count (Baolin).
> v2: also clear the cached tail of the last block, which v1 left in
> place when the write stayed inside the old data size (Baolin).
> 
> v2: https://lore.kernel.org/all/20261112030815.982026-1-zhanxusheng1024@gmail.com/
> v1: https://lore.kernel.org/all/20261111093459.660484-1-zhanxusheng1024@gmail.com/
> 
> Tested in a VM on ntfs-next b025f526c5d0, with all free space filled
> with a known pattern first.  Short buffered writes of 4M, old data
> readable after drop_caches and after remount, 3 runs each:
> 
>                                      unfixed    v1     v2     v3
>    fallocated, ends block-aligned    3137536    0      0      0
>    fallocated, ends inside a block   3141332    212    0      0
>    fallocated, unaligned start       3137536    412    0      0
>    same, pos + count in that page    -          -      436    0
>    append                            3137536    0      0      0
> 
> A short write 1M past EOF, O_DIRECT, resident and compressed files and
> full writes give the same results with v3 as with v1.
> ---
>   fs/ntfs/file.c | 35 ++++++++++++++++++++++++++++-------
>   1 file changed, 28 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
> index 3213a0c9f96b..aa58afd729d0 100644
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
> @@ -940,13 +951,23 @@ ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>   		filemap_invalidate_lock(vi->i_mapping);
>   
>   		/* ntfs_attr_set_initialized_size() rejects a resident one. */
> -		if (ni->initialized_size != old_init_size &&
> +		if (ni->initialized_size != new_init_size &&
>   		    NInoNonResident(ni)) {
>   			struct ntfs_inode *mrec_ni = ntfs_base_inode(ni);
>   
> +			/*
> +			 * A short copy can leave the rest of a block read
> +			 * from disk in the cache, also past the temporarily
> +			 * extended initialized size.  Clear everything that
> +			 * is no longer initialized, as
> +			 * __ntfs_extend_initialized_size() does.
> +			 */
> +			truncate_pagecache_range(vi, new_init_size,
> +					max_t(loff_t, i_size_read(vi),
> +					      ni->initialized_size) - 1);
>   			mutex_lock(&mrec_ni->mrec_lock);

Hi Xusheng,
    I missed the concurrent mmap case in my earlier suggestion to 
truncate the page cache.
    Sorry for overlooking this. This truncation can discard valid data 
written through a shared mapping while the buffered write is copying 
user data.

    I reproduced this with the following sequence on an x86_64 VM using 
4 KiB pages and 4 KiB NTFS clusters:

1. Create an empty file and extend it to 1 MiB with ftruncate().
2. Start a buffered pwritev() at offset 0 with three 4 KiB source 
buffers: a valid page, a missing page registered with userfaultfd, and a 
PROT_NONE page.
3. Wait for the userfaultfd event on the second buffer, leaving the 
writer paused during the copy.
4. Create a writable MAP_SHARED mapping at file offset 64 KiB and store 
a known marker there.
5. Resolve the missing source page with UFFDIO_COPY. The inaccessible 
third buffer then causes pwritev() to return a short count of 8192.
6. Read the marker back with pread().

    Before applying v3, the marker is preserved. After applying v3, it 
is lost and its first byte reads back as zero. The file size remains 1 
MiB in both cases.

    The mmap operation has already extended initialized_size beyond the 
marker, but new_init_size is calculated from the pre-write snapshot and 
this write's return value, so it becomes 8 KiB. The cache truncation 
discards the marker, and the subsequent initialized-size rollback also 
fails to preserve the initialization established by mmap.

    Taking invalidate_lock here is too late to prevent this sequence: 
the mmap initialization and store have already completed. The inode lock 
held by the write iterator does not serialize against mmap 
initialization either.

    We need to revise the rollback approach to preserve initialization 
and data established by concurrent mmap activity. Simply narrowing the 
cache truncation range would not address the initialized-size rollback.
    One possible direction is to initialize newly exposed bytes before 
publishing initialized_size and retain that initialization after a short 
write. This would also need careful handling of direct I/O and NOWAIT, 
since populating pagecache before NOWAIT direct I/O can itself cause EAGAIN.

Thanks,
Baolin.


>   			init_err = ntfs_attr_set_initialized_size(ni,
> -					old_init_size);
> +					new_init_size);
>   			mutex_unlock(&mrec_ni->mrec_lock);
>   		}
>   		/*
> @@ -955,13 +976,13 @@ ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
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

