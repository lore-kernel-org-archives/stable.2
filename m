Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795073630;
	b=MO0gWu1MFFemg8ouc3F4gdmn/SSImcC6XSKHCK8mvVEotXTLcvdT04afvlwl8Nta8WiJ
	 2kNZK9p70MVJo4PXFtZmU1BTkajxL+bDjXWzB9RdclABP6pi6jDUcZsxLR9phFe7b4d2x
	 M7bv56QRdUDiBmbf6HoN3bw6iAhJz2ede6yOhzCIMfSyyQsHsddWwiPw9pivQDPldQOMa
	 +1T28h1O1i+mVmG20rLz5d2aKlfPvMxI0uuq7eH1XvQ7MrugRHrUobdPtgh/aROksk7gU
	 96Xiws/BKplEaX0DKK0B+TvdgUinb8O6+F+aGhUe0jV7wT7LSEtnvqdi1q5oNs9qoOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795073630;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=GTCAL2yOJ+jQQbnCn7Hlo0KT5zWh6GMGz7xXwmGc5ss=;
	b=tZLbr9hVl6knw4QkuyYs4qspxmB/rzcoqyENXnEWkuBjG8ke4olhLGyTqKxs1VQ3qaSJ
	 jVZYL5elldKieHJeb7Y+3I+l0TrnMIgi+qrqnn29rghsElwIvQGZAOnql1QDVb5n3QK5J
	 Uh/jymyF7k+qT2tZmeit1hZJh2PKcAWPXp3UUOS7ijwAeR+8/KsLDiBpYl4jjDFi/zqBI
	 atIBs3SjGVNRlDxdXaEQOsu9wxFMNT7aJfzFJ8MXWkxHS34E7UBSsKIncf4cz3jdgfuJ7
	 M0NvtPV8F0v7XLmXPzAFzs0FHscwyL0vEAYFQFas9Sl5tkC17Q52i6eZnP2CqxIHqSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=fsInJLqq;
	arc=none smtp.remote-ip=117.135.210.5
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C155D606A324;
	Thu, 19 Nov 2026 07:33:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C155D606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=fsInJLqq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=GTCAL2yOJ+jQQbnCn7Hlo0KT5zWh6GMGz7xXwmGc5ss=;
	b=fsInJLqqh/5nZFYG9aPBxmiyWYr/Gl17seomR89uxY6gOiCzWRCjtXTbCTj04j
	byQGX8H5RqNpBcOSM3axnMFHZQGKL4apLenaNpWBO3nMGInzFpXEtDDP2KPmvkm8
	GzK9Fk9a45b9TdSE0OEdFNZHdArax8Rb80Y7b27VRc6l8=
Received: from [IPV6:2409:8900:1e87:c681:fc32:898e:e0f:92e9] (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgDXynZEpv5qrIp4GA--.24628S2;
	Thu, 19 Nov 2026 15:33:26 +0800 (CST)
Message-ID: <64e20a97-d6d1-4f3f-9303-2159aecbd7b6@163.com>
Date: Thu, 19 Nov 2026 15:33:24 +0800
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
Subject: Re: [PATCH v7] ntfs: trim the sizes after a short write
To: Zhan Xusheng <zhanxusheng1024@gmail.com>, linkinjeon@kernel.org,
 hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, zhanxusheng@xiaomi.com
References: <20261119022715.3636699-1-zhanxusheng1024@gmail.com>
Content-Language: en-US
From: liubaolin <liubaolin12138@163.com>
In-Reply-To: <20261119022715.3636699-1-zhanxusheng1024@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgDXynZEpv5qrIp4GA--.24628S2
X-Coremail-Antispam: 1Uf129KBjvAXoWfGF48ur4DXr1ktrWUKFWUtwb_yoW8GF4fZo
	WrAay5Zw1F934jyr4jvw4DJr93X39YgrW8JFZxXr47AFn09r4jk3y3Jw1rG3ySk3WFkF1D
	W34xtayrCFWjqF95n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUejjyUUUUU
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbC6QgW4Gr+pkiYJwAA3S



在 2026/11/19 10:27, Zhan Xusheng 写道:
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
> size back to the end of what was written, keeping the clusters that were
> allocated on disk before the write, such as space reserved with
> FALLOC_FL_KEEP_SIZE.  Keep the initialized size, as a page fault through
> a shared mapping may rely on it while the write is stalled on its
> source, and zero what the write did not reach, up to the end of the
> block holding pos + count.  Only if that fails, take the initialized
> size back to where the zeroing started, if it is above that.
> 
> Fixes: b041ca562526 ("ntfs: update iomap and address space operations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
> ---
> v7: when taking the data size back, keep the clusters allocated on disk
> before the write instead of truncating, which freed space reserved
> with FALLOC_FL_KEEP_SIZE; a failed write already did so before this
> patch (Hyunchul).  Holes and delayed allocations past the data size,
> such as the preallocation of an earlier extending write, are freed as
> before.  Baolin's Reviewed-by on v6 is not carried over, as this
> changes the data size rollback he reviewed.
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
> v6: https://lore.kernel.org/all/20261117082021.2947603-1-zhanxusheng1024@gmail.com/
> v5: https://lore.kernel.org/all/20261116091121.2547497-1-zhanxusheng1024@gmail.com/
> v4: https://lore.kernel.org/all/20261113050148.1466682-1-zhanxusheng1024@gmail.com/
> v3: https://lore.kernel.org/all/20261112093233.1118469-1-zhanxusheng1024@gmail.com/
> v2: https://lore.kernel.org/all/20261112030815.982026-1-zhanxusheng1024@gmail.com/
> v1: https://lore.kernel.org/all/20261111093459.660484-1-zhanxusheng1024@gmail.com/
> 
> Tested in a VM on ntfs-next 4862a81576e3, with all free space filled
> with a known pattern first.  Short buffered writes of 4M, old data
> readable after drop_caches and after remount, 3 runs each:
> 
>                                      unfixed    v6     v7
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
>                                            unfixed  v6     v7
>    buffered 4K at 128K, EFAULT             lost     lost   kept
>    O_DIRECT 12K at 0, EFAULT               lost     lost   kept
>    buffered 12K at 0, short 8192 (v3)      kept     kept   kept
> 
> 1M reserved with FALLOC_FL_KEEP_SIZE, then a 12K write at 0, 512-byte
> blocks after remount:
> 
>                                            unfixed  v6     v7
>    short, 8192 written                     2048     16     2048
>    failed, EFAULT                          0        0      2048
> 
> A short write past 8K reserved this way frees what it allocated beyond
> the 8K and keeps the 8K.  A store into [pos + ret, pos + count) itself
> during the write is zeroed, as that range belongs to the write.  With
> iomap_zero_range() failing (injected -ENOMEM), a 32K write to a 16K
> file that returns 12288 leaves the size at 28K with no old data, also
> after remount.
> fsx (buffered, no-mmap, O_DIRECT and mixed), compressed files,
> fallocate, insert/collapse range and punch hole give the same results
> with v7 as with v6.
> ---
>   fs/ntfs/attrib.c |  34 +++++++++++++
>   fs/ntfs/attrib.h |   1 +
>   fs/ntfs/file.c   | 121 +++++++++++++++++++++++++++++++++++++++++++----
>   3 files changed, 148 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
> index 29eae1eb3d02..8154c9b05d55 100644
> --- a/fs/ntfs/attrib.c
> +++ b/fs/ntfs/attrib.c
> @@ -2456,6 +2456,40 @@ int ntfs_attr_set_initialized_size(struct ntfs_inode *ni, loff_t new_size)
>   	return err;
>   }
>   
> +/*
> + * ntfs_attr_set_data_size - set the data size of a non-resident attribute
> + * without changing its allocation
> + *
> + * The caller holds mrec_lock.  @new_size must not be below the initialized
> + * size or above the allocated size.
> + */
> +int ntfs_attr_set_data_size(struct ntfs_inode *ni, loff_t new_size)
> +{
> +	struct ntfs_attr_search_ctx *ctx;
> +	struct ntfs_inode *base_ni = ntfs_base_inode(ni);
> +	int err = 0;
> +
> +	if (!NInoNonResident(ni) || new_size < ni->initialized_size ||
> +	    new_size > ni->allocated_size)
> +		return -EINVAL;
> +
> +	ctx = ntfs_attr_get_search_ctx(base_ni, NULL);
> +	if (!ctx)
> +		return -ENOMEM;
> +
> +	err = ntfs_attr_lookup(ni->type, ni->name, ni->name_len,
> +			       CASE_SENSITIVE, 0, NULL, 0, ctx);
> +	if (err)
> +		goto out_ctx;
> +
> +	ctx->attr->data.non_resident.data_size = cpu_to_le64(new_size);
> +	ni->data_size = new_size;

Hi Xusheng,
    Thanks for sending v7 and addressing the KEEP_SIZE case.
    Could we also set FileNameDirty for unnamed AT_DATA here, as 
ntfs_non_resident_attr_shrink() does?

         if (ni->type == AT_DATA && ni->name == AT_UNNAMED)
                 NInoSetFileNameDirty(ni);

   The expansion sets this flag, but __ntfs_write_inode() may have 
already cleared it and updated the FILE_NAME and directory index sizes 
while the write was blocked on its source buffer. Without setting it 
again here, those sizes could remain at the expanded value after 
rollback, since mark_mft_record_dirty() doesn't set this flag.

Thanks,
Baolin.

> +	mark_mft_record_dirty(ctx->ntfs_ino);
> +out_ctx:
> +	ntfs_attr_put_search_ctx(ctx);
> +	return err;
> +}
> +
>   /*
>    * ntfs_make_room_for_attr - make room for an attribute inside an mft record
>    * @m:		mft record
> diff --git a/fs/ntfs/attrib.h b/fs/ntfs/attrib.h
> index bee91c9f6f81..edb62826a6ab 100644
> --- a/fs/ntfs/attrib.h
> +++ b/fs/ntfs/attrib.h
> @@ -102,6 +102,7 @@ int ntfs_attr_make_non_resident(struct ntfs_inode *ni, const u32 data_size);
>   int ntfs_attr_set(struct ntfs_inode *ni, const s64 ofs, const s64 cnt,
>   		const u8 val);
>   int ntfs_attr_set_initialized_size(struct ntfs_inode *ni, loff_t new_size);
> +int ntfs_attr_set_data_size(struct ntfs_inode *ni, loff_t new_size);
>   int ntfs_attr_open(struct ntfs_inode *ni, const __le32 type,
>   		__le16 *name, u32 name_len);
>   void ntfs_attr_close(struct ntfs_inode *n);
> diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
> index a52483d16c6e..25034735d249 100644
> --- a/fs/ntfs/file.c
> +++ b/fs/ntfs/file.c
> @@ -843,6 +843,34 @@ static int ntfs_expand_for_write(struct ntfs_inode *ni, loff_t end)
>   	return err;
>   }
>   
> +/*
> + * End of the last run of clusters allocated on disk.  Holes and delayed
> + * allocations past it, such as the preallocation of an extending write,
> + * do not count.  Falls back to the allocated size if the runlist is not
> + * fully mapped.
> + */
> +static loff_t ntfs_allocated_end_on_disk(struct ntfs_inode *ni)
> +{
> +	loff_t end = ni->allocated_size;
> +	ssize_t i;
> +
> +	down_read(&ni->runlist.lock);
> +	if (NInoFullyMapped(ni) && ni->runlist.rl) {
> +		end = 0;
> +		for (i = ni->runlist.count - 1; i >= 0; i--) {
> +			struct runlist_element *rl = &ni->runlist.rl[i];
> +
> +			if (rl->length && rl->lcn >= 0) {
> +				end = ntfs_cluster_to_bytes(ni->vol,
> +						rl->vcn + rl->length);
> +				break;
> +			}
> +		}
> +	}
> +	up_read(&ni->runlist.lock);
> +	return end;
> +}
> +
>   ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>   {
>   	struct file *file = iocb->ki_filp;
> @@ -853,7 +881,7 @@ ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>   	ssize_t count;
>   	loff_t pos, end;
>   	int err;
> -	loff_t old_data_size, old_init_size;
> +	loff_t old_data_size, old_init_size, old_alloc_size;
>   
>   	if (NVolShutdown(vol))
>   		return -EIO;
> @@ -901,6 +929,10 @@ ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>   
>   	old_data_size = ni->data_size;
>   	old_init_size = ni->initialized_size;
> +	old_alloc_size = ni->allocated_size;
> +	if (NInoNonResident(ni) && !NInoCompressed(ni) &&
> +	    old_alloc_size > round_up(old_data_size, vol->cluster_size))
> +		old_alloc_size = ntfs_allocated_end_on_disk(ni);
>   
>   	if (end > old_data_size) {
>   		ret = ntfs_expand_for_write(ni, end);
> @@ -928,10 +960,21 @@ ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>   		ret = iomap_file_buffered_write(iocb, from, ntfs_write_iomap_next,
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
> @@ -939,14 +982,59 @@ ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
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
> +						ntfs_seek_iomap_next,
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
> @@ -955,13 +1043,30 @@ ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
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
> +			if (NInoNonResident(ni) && !NInoCompressed(ni)) {
> +				/*
> +				 * Only free what the write allocated, not
> +				 * clusters that were there before, such as
> +				 * space reserved with FALLOC_FL_KEEP_SIZE.
> +				 */
> +				loff_t keep = max(new_data_size,
> +						  old_alloc_size);
> +
> +				if (ni->allocated_size > keep)
> +					data_err = __ntfs_attr_truncate_vfs(ni,
> +							keep, keep);
> +				if (!data_err && ni->data_size != new_data_size)
> +					data_err = ntfs_attr_set_data_size(ni,
> +							new_data_size);
> +			} else {
> +				data_err = __ntfs_attr_truncate_vfs(ni,
> +						new_data_size, new_data_size);
> +			}
>   			mutex_unlock(&mrec_ni->mrec_lock);
>   			/* Like ntfs_setattr_size(): stay on the durable size. */
>   			if (data_err)
> 
> base-commit: 4862a81576e3b20ba40cb94a38c5df0450047ffe

