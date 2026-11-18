Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794987412;
	b=Ld71UHFbiZ8kDUHg0j0fNFHceyXyhRjY1xJ43uNGlzrHwnu9pEf6v6rwXpHowJuijjN1
	 9nEzp3JmsbEP7zt8qoQHdm/l9IhTsZANNpiEsNftshHus3Q9SDAF+fgPliAPcRrCquM6X
	 dK1sscCXGzyekrbpUJj1RMv57SmTGZ3AKAYaj6d60M2vhnaktd9emJpB8i7PAW6v5WC8n
	 0OozLP4JnfSxsbtlrYO/2/opWAgQCaAV5FhQO8Q8MIgWReRsPeXiaosYqoDIBTEVd2CBQ
	 +G8M8fL1SDlm7GHYgVcDRp/m0GkrmxuoQyPwX1roN340AisaXZ+AIEOG5haL5FNw+hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794987412;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=2AQusGkZeF7By8v8HcNlOm3Ynbjfbz2pOngGJJFpkaE=;
	b=dK29dcmj1k9DZQbtnI5uOOd52G9ba0B6sSP+4JC19f9BvOnJ2kSjLUfUQy03Gx2u/eXp
	 9WCsQAP5vX7h0yzLUli7XH7pntMGkE77/MMwUg4/EjZ/wiE4pyMetIq6LD3kwmvHY5ZVL
	 1gmi+IEQxfGjd/ILlro0gpWE+aSrNGOOeMs99McdqKy9Lnc5oNFO51JCrXgKmXDeFtuwb
	 R7tietkji4/mUvFQiB4RHqeauxlCqih6fj8bVy0hDe71LZx0Au+Jzcwkvl04+y/FkmK2H
	 MzmYb2EcY1rTcrdQMpyczdxfK2VVwnmaGwe5jFL+nZAfkwDMnJ4ytHF0TDB9mXgPkZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UgHKCBli;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C26F606A32A
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 07:36:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C26F606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UgHKCBli
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3b08a162d4bso360300a91.3
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 23:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794987411; x=1795592211; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2AQusGkZeF7By8v8HcNlOm3Ynbjfbz2pOngGJJFpkaE=;
        b=UgHKCBlit4MCzNdLnO6taNF618WnyG2ORTn7sKiAWDsFyTVflRKUWXUeZ7dRCW1aB/
         cDG6dWHfCNP7IYsIu08mOWNT7bgV17vIdJP8xJ+gtN5p8fpUgZ3t4kVMRnsjCV7ZWek2
         Ms4Y8Th2PaoafXKj7KuSxOTwhJLe2Pquxd00PO/eyLIYwgZpCvCK5C2mFh2vtOl57saQ
         VwZcwRg7iVQOzE+CN2NcHmluF7rVeXCF4Y/p/PV/4XqGiNBimjkuacE9pr1a67h9HX3y
         /CQN54ltNSifYR0/4AnF+sNHNglQ3ourhgRJYuSq7Yc09mJRN28uqS+/TCKyu21+um2Z
         UfXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794987411; x=1795592211;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2AQusGkZeF7By8v8HcNlOm3Ynbjfbz2pOngGJJFpkaE=;
        b=WrhRdC1v4vUOZP2aDhuoAmAzuE+OOHbTT8/e0U0ygVHh3nSnCSKwOENzBqNOxbZGBc
         I2+RCV5CqpxwLC6jwP+4dEcwrz82IbL14HAOkC4X4bLPUN4qGmJC/wxCGPk9kj9MTwCH
         lR8+MtFx8P7A0agXpQ+QIYCXq/g31f5hiGhg456lxp3Bck87bgTcvI+vHczHBiVNLn+z
         AE7WUY4rm2an4l+54gaytMT78OwWohdVRW2KExAyjhaHn3jWFTSqNksOZQUEzDSJYbEb
         mfBkOBMzymf7QWit1yXXD7SAFBUIwXIcCSTO+Mx1yeFxngWnzMdYy7Hs05QMWuGz7q4k
         8baw==
X-Forwarded-Encrypted: i=1; AL+hErF+sNukGjCz19dhEfizTypq4XOhWVsRSFbKVXEPK03RAWHShSNh+lUWC3DKd1l0jfv6HTBvOuk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8j/CucdNB8QXq2q7SquqkPFiqWGlAq268dChDtgdTaUce7T6/l
	+A8LgF3h8bHyw9ssioSrWwrktDCPYtFtuvrPeE86XyAc3g54rHFp0/Q4
X-Gm-Gg: AZFdTZdS+ClJ0/l2Ziqp8g0DHgCRva2yihlPUqXOHiAUcjQUPGOAbi7sm8wtxxOsAp2
	k9mGTTLythi4e6a49G9725pbe4Np2thSZbtsRSd1sr1/vJTUVWrq1IH6sPxsbT4HkviRGR7pam7
	t0yFT6OskXfUVE5a7QS8qsXbBGETRD0t6w80TFW0jDjvU07GKmJnxunIhCkXrZMXGVAaXvajTPH
	RsbHbdfJys8m6nQvAXxFykpWyNqS1fFfjI98JLvExEKGh1tUC2hjG5d9m/j6oKwGamlECKzd49d
	ygTPAGt7jVG1m7xQc/PBa0AWMk7K5RrrTfQPk2UVYWcEtwTSexCudiE86KTSol7HjkV5l4IXnvb
	HPxu5dHHlcyIJotMdI005x/71Oz19QLaHCQlKUDMWSE/k9PpTJLcJs6FghrLcVx6lpU0kiwJBGb
	sRl9x0hxDt20L5ixKA8Sf5hx2H8YRtMAE8DfDrVgARiE276tv43rwaaLdt4ZFOHCB1HHSkybFO3
	+IyItUYZZkxuJtM0rQ9f832AnuvuEKgpKKtp1yE1zxFMy6RadFiukH7LfeosFbL8WdsE8Yrkm8n
	GdrbvgqO7WYF1CK7EJkWXrktJ/jo/mwRrXogMVpN
X-Received: by 2002:a17:90b:2b4b:b0:3b1:a1d:3fb6 with SMTP id 98e67ed59e1d1-3b3d07b909amr1784590a91.51.1794987411394;
        Tue, 17 Nov 2026 23:36:51 -0800 (PST)
Received: from localhost ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3ac2cca15sm7716193a91.11.2026.11.17.23.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 23:36:50 -0800 (PST)
Date: Wed, 18 Nov 2026 16:36:48 +0900
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Zhan Xusheng <zhanxusheng1024@gmail.com>
Cc: linkinjeon@kernel.org, liubaolin12138@163.com, ntfs@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	zhanxusheng@xiaomi.com
Subject: Re: [PATCH v6] ntfs: trim the sizes after a short write
Message-ID: <av1VkHMxr0lTVjWw@hyunchul-PC02>
References: <20261117082021.2947603-1-zhanxusheng1024@gmail.com>
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
In-Reply-To: <20261117082021.2947603-1-zhanxusheng1024@gmail.com>

Hi Zhan,

On Tue, Nov 17, 2026 at 04:20:21PM +0800, Zhan Xusheng wrote:
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
>   overwrote data stored through a shared mapping below pos
> - do the same for a direct write, instead of truncating the page cache
>   and taking the initialized size back
> - if the zeroing fails, take the initialized size back to where it
>   started, instead of skipping both rollbacks
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
>                                     unfixed    v5     v6
>   fallocated, ends block-aligned    3137536    0      0
>   fallocated, ends inside a block   3141332    0      0
>   fallocated, unaligned start       3137536    0      0
>   same, pos + count in that page    -          0      0
>   append                            3137536    0      0
> 
> Marker stored through a shared mapping at 64K while pwritev() is
> stalled on a userfaultfd source page, state after remount, with and
> without fallocate():
> 
>                                           unfixed  v5     v6
>   buffered 4K at 128K, EFAULT             lost     lost   kept
>   O_DIRECT 12K at 0, EFAULT               lost     lost   kept
>   buffered 12K at 0, short 8192 (v3)      kept     kept   kept
> 
> A store into [pos + ret, pos + count) itself during the write is
> zeroed, as that range belongs to the write.  With iomap_zero_range()
> failing (injected -ENOMEM), a 32K write to a 16K file that returns
> 12288 leaves the size at 28K with no old data, also after remount.
> fsx (buffered, no-mmap, O_DIRECT and mixed), compressed files,
> fallocate, insert/collapse range and punch hole give the same results
> with v6 as with v5.
> ---
>  fs/ntfs/file.c | 70 +++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 63 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
> index 3213a0c9f96b..866aaca1887e 100644
> --- a/fs/ntfs/file.c
> +++ b/fs/ntfs/file.c
> @@ -928,10 +928,21 @@ ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  		ret = iomap_file_buffered_write(iocb, from, &ntfs_write_iomap_ops,
>  				&ntfs_iomap_folio_ops, NULL);
>  out:
> -	if (ret < 0 && ret != -EIOCBQUEUED) {
> +	/*
> +	 * Both sizes were moved to end before the copy, so a short write,
> +	 * like a failed one, must take back what it did not write.
> +	 */
> +	if (ret < count && ret != -EIOCBQUEUED) {
> +		loff_t new_init_size = old_init_size;
> +		loff_t new_data_size = old_data_size;
>  		int init_err = 0;
>  		int data_err = 0;
>  
> +		if (ret > 0) {
> +			new_init_size = max(old_init_size, pos + ret);
> +			new_data_size = max(old_data_size, pos + ret);
> +		}
> +
>  		/*
>  		 * Like ntfs_setattr_size(): __ntfs_attr_truncate_vfs()
>  		 * expects the invalidate lock held across the size
> @@ -939,14 +950,59 @@ ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  		 */
>  		filemap_invalidate_lock(vi->i_mapping);
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
>  		/* ntfs_attr_set_initialized_size() rejects a resident one. */
> -		if (ni->initialized_size != old_init_size &&
> +		if (ni->initialized_size != new_init_size &&
>  		    NInoNonResident(ni)) {
>  			struct ntfs_inode *mrec_ni = ntfs_base_inode(ni);
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
>  			mutex_lock(&mrec_ni->mrec_lock);
>  			init_err = ntfs_attr_set_initialized_size(ni,
> -					old_init_size);
> +					new_init_size);
>  			mutex_unlock(&mrec_ni->mrec_lock);
>  		}
>  		/*
> @@ -955,13 +1011,13 @@ ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  		 * the uninitialized tail, so skip it unless the rollback
>  		 * above restored that size.
>  		 */
> -		if (ni->data_size != old_data_size && !init_err) {
> +		if (ni->data_size != new_data_size && !init_err) {
>  			struct ntfs_inode *mrec_ni = ntfs_base_inode(ni);
>  
> -			truncate_setsize(vi, old_data_size);
> +			truncate_setsize(vi, new_data_size);
>  			mutex_lock(&mrec_ni->mrec_lock);
> -			data_err = __ntfs_attr_truncate_vfs(ni, old_data_size,
> -					old_data_size);
> +			data_err = __ntfs_attr_truncate_vfs(ni, new_data_size,
> +					new_data_size);

It seems that this could free preallocated space reserved with
KEEP_SIZE.

>  			mutex_unlock(&mrec_ni->mrec_lock);
>  			/* Like ntfs_setattr_size(): stay on the durable size. */
>  			if (data_err)
> 
> base-commit: b025f526c5d04929212c9d5fb7ffc96608f3eacc
> -- 
> 2.43.0
> 

-- 
Thanks,
Hyunchul
