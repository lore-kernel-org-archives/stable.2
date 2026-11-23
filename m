Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795412883;
	b=T9smg6bnkPugCptpny2aLPcqC9yXYDkhXXavnUOPd5ETztbJDREPxgYm7C9KmA1keGYT
	 +4BMy6ZBNFusn3VK6ehKkrUq6YxoGTXf7AmEVE2t3H2n+2Obw7kpx3DPHGYBwjvyYSZ76
	 7w8HVEorxHU7yfElS8EIMKXeLIF1qKBg8yiJTrnmwwGf6INlgG4bvdx7b8c0Hihg93Yjd
	 mIflXSWMyGzPHbgi9pFDKV2nArFwlTNU8whnqoXC4BUDCJWb/0mhi8V3RnJjmOoRZ81at
	 dAtHLE1t1qMkpVz4oFIyt0CUgWA+7nI5Ubk9e/V9q269dU/JFM/y8xd9JTWewRg5HuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795412883;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=C6kM09UB5CIeWG4FIgxtnyVAELn2QRDca2eMQrsTeqQ=;
	b=LZHqAPSFPIhqyNB4L1Ll3HyXrH3M0Ms9fMGIt3lfXxyuuGhNDFltb3kjYE5ihOdtoCYH
	 lIRbVjNizqXPIeedtwX1g7gseJvFxz5M9lCaJFHwu21b50fhiIRMA4gWfBRgnl5LowRUH
	 akNtIpLyL1l8Pn1n0gewnkNFPt7gPsGWLPLQvbqoOtL8FopCfe6JArbRVi/xk73zqdwQB
	 PyxLGM4kDMhHbjJq87aZpkD4WbYrALGZdkC+GXxpszsBCDSE1Kz+wE0XupVXzUjAGVZTn
	 TngQ29vsDdptYBdaiuT3fkSP9uiGxWJTs6MWe+T+W8QfGBjAPlQ0ZqQwrDibm6DlN0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="h5SdWTB/";
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCBE606A338
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 05:48:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCCBE606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h5SdWTB/
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3b3af93b85cso1598633a91.1
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 21:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795412882; x=1796017682; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C6kM09UB5CIeWG4FIgxtnyVAELn2QRDca2eMQrsTeqQ=;
        b=h5SdWTB/v7wyZhpNrcmgo1SNIjajCPUmI9d0MCFdxyMSJfvufysZVF2Qw+IyjwpvVc
         cZ0OwdjRMJgphoYPAMR8nM+xdTRdp2Szta2uAxjCCzS9EFw6bQ4iQigVK7STeUOtcjs3
         /aOoqF0HQwlRUDgJyM++yZPIK0AVSrYLVfEVN2w5b3zMcVGD5T9xl6mPxODWZXFJIESK
         kzg09OmsSqJA6J9OA5my1lY8X+QMvD3gC4Fm8Gb//paY22IDrJl5QOZXGd5cWG2FrpKq
         347Gj6oqY/2A2rW9ZR16D1gTuU3vZfort3rZCdNfIseXZKaj1G0217TjCjx/ES56hLhJ
         9Sug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795412882; x=1796017682;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C6kM09UB5CIeWG4FIgxtnyVAELn2QRDca2eMQrsTeqQ=;
        b=sr6soQjWUWEFPkE+3KAc/cW7KrYifJNbFtuI67YxLlpf5gvm5vYA/J+htyq2FRaaZ4
         V0TCzHVBSD3JMI6XkE1DkzLVbgkP9yFth3qmthPGfZvYOqShcLLZcLYOCCTEc3QwIvVE
         TIMeMR5NUbqT+pK80siZ1lMRr7xeHHYFM+/txCDgs04eIKfeJ++1n0OjAOJSLH2uGCbe
         H4LOGKObQKvE0vezkfp9QXp85USKQpiw8+VFqVlq8wVeC30lAefT8gXwgqgM9Mn1IOA1
         wUaB4M0I9uTHTSYrV9YcClUpZQqrd2HYPWcKK0YqCpsJzNFeTKoJ1xy2+jCFIFbIQ3cO
         +k+A==
X-Forwarded-Encrypted: i=1; AL+hErEE1L52pLVAmnIi61bIGtUd/kxOqUXIjdbbzIgVmewxwt95Fxn4sm3f7OUUUHF3sWSS0IBw6wc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9MbVtZsjFyNYkwIi6kj8ytid2/QV5iwTsDaMhKU5yrtkae/ZlS
	Syzq7xpUGBgIh7lhQj/Hox9ySQfrnQe/x6emdtzoIv5nc+dizdCDzAzq6BtmZQ==
X-Gm-Gg: AZFdTZdcfXrFhU5v/brj3genhHBBPwBL3FhXEEKEeAPoOpl4VYi+t08NverDHU+fzG1
	gxdj+lYwCC8wz0D4Fw09/8BVOr+Ag4SX3HwUZ7XgnSIw67GAXt/7OfGrGH6Ju5OAyGcYAjBNCTl
	10ITlsBIql45jmjgNkHa7kyBsN1puR+ig0KM6+rE8s3cf63SasbTkHXSR5vpnlHT5lK7rId/9uj
	bRHDZ0Sp5JSizKqJkjn+MUn94kf6LK8t0VnugjKuIEcGL98/25nKPyj0A/O5+QYloHmDjSHgHio
	RAKhGGCvA24ntwWeIyYVvn+MKVknvVeJLBpySSADrBLSNieXVDbpEDxdWyIbUD8brURCCOSswL/
	8EV163w1qtXo22uLaEbUI/oBScareZOTO/WMiGiWM2hOEjmam+3ckp4jhho7ePMKljzXTlNbXYv
	5L5awSjCVOabffkmK/ME/kKGD6BB0icA+yGue2O+icOsOo0jIqGNICjip9X36ITou/g4xaDM3ae
	lZATJUjthsLSL1i6GIH3COUdF7wWx8SO7w0Tkf4rHKnv6HCFjWOVnFPaTrYPGzhIqTxTUVv++rf
	pCDZENXcoYv1yUDEFMA=
X-Received: by 2002:a17:90b:4a48:b0:3b1:2d60:66cc with SMTP id 98e67ed59e1d1-3b41c7b56bemr9221452a91.8.1795412881662;
        Sun, 22 Nov 2026 21:48:01 -0800 (PST)
Received: from localhost ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405d97356sm18719260a91.13.2026.11.22.21.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 21:48:00 -0800 (PST)
Date: Mon, 23 Nov 2026 14:47:58 +0900
From: Hyunchul Lee <hyc.lee@gmail.com>
To: ernest.borowski.git@proton.me
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Baolin Liu <liubaolin12138@163.com>, ntfs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Zhan Xusheng <zhanxusheng1024@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH 5/7] ntfs: punch out the delalloc reservation of a failed
 buffered write
Message-ID: <awPTjheQrp6sxB5W@hyunchul-PC02>
References: <20261122-b4-ntfs-delalloc-fixes-v1-0-0726f0dce403@proton.me>
 <20261122-b4-ntfs-delalloc-fixes-v1-5-0726f0dce403@proton.me>
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
In-Reply-To: <20261122-b4-ntfs-delalloc-fixes-v1-5-0726f0dce403@proton.me>

On Sun, Nov 22, 2026 at 07:19:41PM +0100, Ernest Borowski via B4 Relay wrote:
> From: Ernest Borowski <ernest.borowski.git@proton.me>
> 
> ntfs_write_simple_iomap_begin_non_resident() turns the holes a buffered
> write covers into LCN_DELALLOC runs and reserves their clusters before
> any data is copied.  If the copy then fails or comes up short (EFAULT
> from the user buffer, a fatal signal), the clusters that no dirty folio
> covers stay delalloc.  Writeback never allocates them, so the
> reservation is kept until the inode is evicted, and the stale runs
> survive the writeback that fallocate() relies on before it edits the
> runlist.
> 
> Reproducer: a pwrite() of 512 KiB from an unmapped address into a hole
> of a 1 MiB sparse file fails with EFAULT and leaves 128 (4 KiB) clusters
> reserved after sync.  A FALLOC_FL_PUNCH_HOLE or COLLAPSE_RANGE through
> the range then hits the run splitting bug fixed by the previous patch.
> 
> Do what XFS does: in ->iomap_end() of a delalloc mapping that was not
> written completely, let iomap_write_delalloc_release() find the ranges
> without dirty data and turn the clusters entirely inside them back into
> holes, releasing their reservation.  Clusters that still hold dirty data
> stay delalloc, including the partial first and last clusters of an
> unaligned write that ->iomap_begin() zeroed in the page cache; those are
> written back as zeros, as before.  Delalloc runs are holes on disk, so
> the mapping pairs do not change.
> 
> The error path of ->iomap_begin() itself, taken when zeroing the edges
> of the new run fails, only subtracted the reservation and left the run
> and i_dealloc_clusters in place, so a later truncate or eviction would
> release it a second time.  Use the same release there.
> 
> Fixes: b041ca562526 ("ntfs: update iomap and address space operations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ernest Borowski <ernest.borowski.git@proton.me>
> ---
>  fs/ntfs/attrib.c | 63 +++++++++++++++++++++++++++++++++++++++++++++++++
>  fs/ntfs/attrib.h |  1 +
>  fs/ntfs/iomap.c  | 71 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 134 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
> index 39fa983cd8..7c19e4534a 100644
> --- a/fs/ntfs/attrib.c
> +++ b/fs/ntfs/attrib.c
> @@ -4416,6 +4416,69 @@ void ntfs_release_delalloc_from(struct ntfs_inode *ni, s64 start_vcn)
>  	ni->i_dealloc_clusters -= min_t(s64, nr, ni->i_dealloc_clusters);
>  }
>  
> +/*
> + * ntfs_attr_punch_delalloc - turn delalloc runs back into holes
> + * @ni:		non-resident ntfs attribute
> + * @start_vcn:	first vcn of the range
> + * @len:	number of clusters in the range
> + *
> + * Turn the LCN_DELALLOC parts of [@start_vcn, @start_vcn + @len) into holes
> + * and give back their reservation.  Used when a buffered write that reserved
> + * them failed before it dirtied any folio over them, so that writeback will
> + * never allocate them.  Runs that are not delalloc (anymore) are left alone.
> + * Delalloc runs are stored as holes on disk, so the mapping pairs need no
> + * update.
> + *
> + * The caller holds the mrec_lock of the base inode and the runlist lock for
> + * writing.
> + */
> +void ntfs_attr_punch_delalloc(struct ntfs_inode *ni, s64 start_vcn, s64 len)
> +{
> +	struct runlist_element *rl, *punch_rl;
> +	s64 vcn = start_vcn, end_vcn = start_vcn + len, run_end;
> +	size_t new_rl_count;
> +	int rl_count, err;
> +
> +	lockdep_assert_held_write(&ni->runlist.lock);
> +
> +	err = ntfs_attr_map_whole_runlist(ni);
> +	if (err) {
> +		ntfs_error(ni->vol->sb,
> +			   "Failed to map the runlist to drop delalloc runs: %d", err);
> +		return;
> +	}
> +
> +	while (vcn < end_vcn) {
> +		rl = ntfs_rl_find_vcn_nolock(ni->runlist.rl, vcn);
> +		if (!rl || !rl->length)
> +			break;
> +		run_end = min(rl->vcn + rl->length, end_vcn);
> +		if (rl->lcn != LCN_DELALLOC) {
> +			vcn = run_end;
> +			continue;
> +		}
> +
> +		for (rl = ni->runlist.rl, rl_count = 0; rl->length; rl++)
> +			rl_count++;
> +		rl = ntfs_rl_punch_hole(ni->runlist.rl, rl_count + 1, vcn,
> +					run_end - vcn, &punch_rl, &new_rl_count);
> +		if (IS_ERR(rl)) {
> +			ntfs_error(ni->vol->sb,
> +				   "Failed to drop delalloc run at vcn 0x%llx: %ld",
> +				   vcn, PTR_ERR(rl));
> +			break;
> +		}
> +		kvfree(punch_rl);
> +		ni->runlist.rl = rl;
> +		ni->runlist.count = new_rl_count;
> +
> +		ntfs_release_dirty_clusters(ni->vol, run_end - vcn);
> +		ni->i_dealloc_clusters -= min_t(s64, run_end - vcn,
> +						ni->i_dealloc_clusters);
> +		vcn = run_end;
> +	}
> +}
> +
>  /*
>   * ntfs_non_resident_attr_shrink - shrink a non-resident, open ntfs attribute
>   * @ni:		non-resident ntfs attribute to shrink
> diff --git a/fs/ntfs/attrib.h b/fs/ntfs/attrib.h
> index faa2dfba3a..ca2a8b53a4 100644
> --- a/fs/ntfs/attrib.h
> +++ b/fs/ntfs/attrib.h
> @@ -110,6 +110,7 @@ int ntfs_non_resident_attr_insert_range(struct ntfs_inode *ni, s64 start_vcn, s6
>  int ntfs_non_resident_attr_collapse_range(struct ntfs_inode *ni, s64 start_vcn, s64 len);
>  int ntfs_non_resident_attr_punch_hole(struct ntfs_inode *ni, s64 start_vcn, s64 len);
>  void ntfs_release_delalloc_from(struct ntfs_inode *ni, s64 start_vcn);
> +void ntfs_attr_punch_delalloc(struct ntfs_inode *ni, s64 start_vcn, s64 len);
>  int __ntfs_attr_truncate_vfs(struct ntfs_inode *ni, const s64 newsize,
>  		const s64 i_size);
>  int ntfs_attr_expand(struct ntfs_inode *ni, const s64 newsize, const s64 prealloc_size);
> diff --git a/fs/ntfs/iomap.c b/fs/ntfs/iomap.c
> index ce916707f6..1909824c30 100644
> --- a/fs/ntfs/iomap.c
> +++ b/fs/ntfs/iomap.c
> @@ -372,6 +372,10 @@ static int ntfs_zero_range(struct inode *inode, loff_t offset, loff_t length)
>  				NULL);
>  }
>  
> +static void ntfs_write_delalloc_release(struct inode *inode, loff_t pos,
> +					loff_t length, ssize_t written,
> +					unsigned int flags, struct iomap *iomap);
> +
>  static int ntfs_write_simple_iomap_begin_non_resident(struct inode *inode, loff_t offset,
>  						      loff_t length, struct iomap *iomap)
>  {
> @@ -543,7 +547,13 @@ static int ntfs_write_simple_iomap_begin_non_resident(struct inode *inode, loff_
>  			if (err == -EPERM)
>  				err = 0;
>  			if (err) {
> -				ntfs_release_dirty_clusters(vol, max_clu_count);
> +				/*
> +				 * Nothing will be copied: drop the delalloc
> +				 * clusters that no zeroed folio covers.
> +				 */
> +				ntfs_write_delalloc_release(inode, offset,
> +							    iomap->length, 0,
> +							    IOMAP_WRITE, iomap);
>  				return err;
>  			}
>  		}
> @@ -762,6 +772,61 @@ static int ntfs_write_iomap_end_resident(struct inode *inode, loff_t pos,
>  	return written;
>  }
>  
> +static void ntfs_write_delalloc_punch(struct inode *inode, loff_t offset,
> +				      loff_t length, struct iomap *iomap)
> +{
> +	struct ntfs_inode *ni = NTFS_I(inode);
> +	struct ntfs_inode *mrec_ni = ntfs_inode_is_named_stream(ni) ?
> +			ntfs_base_inode(ni) : ni;
> +	struct ntfs_volume *vol = ni->vol;
> +	/* Clusters that still hold some dirty data stay delalloc. */
> +	loff_t start = round_up(offset, vol->cluster_size);
> +	loff_t end = round_down(offset + length, vol->cluster_size);
> +
> +	if (start >= end)
> +		return;

Could this leave clean dealloc clusters reserved?

For example, with 1 KiB clusters and 512-byte blocks,
iomap_write_dealloc_ifs_punch() calls this callback seperately for each
clean block in a dirty folio. For a cluster covering [1024, 2048),
the callback receives [1024, 1536) and [1536, 2048) separately. Rounding
each range produces an empty punch range, so neither call removes
the reservation, even if the entire cluster is clean.

> +
> +	mutex_lock(&mrec_ni->mrec_lock);
> +	down_write(&ni->runlist.lock);
> +	ntfs_attr_punch_delalloc(ni, ntfs_bytes_to_cluster(vol, start),
> +				 ntfs_bytes_to_cluster(vol, end - start));
> +	up_write(&ni->runlist.lock);
> +	mutex_unlock(&mrec_ni->mrec_lock);
> +}
> +
> +/*
> + * A buffered write that failed or copied less than it mapped leaves delalloc
> + * clusters that no dirty folio covers: writeback never allocates them, so
> + * their reservation would stay until the inode is evicted, and the stale
> + * delalloc runs would outlive the flush done by fallocate() and friends.
> + * Punch them out again, keeping every cluster that has dirty data in the
> + * page cache.
> + */
> +static void ntfs_write_delalloc_release(struct inode *inode, loff_t pos,
> +					loff_t length, ssize_t written,
> +					unsigned int flags, struct iomap *iomap)
> +{
> +	struct ntfs_volume *vol = NTFS_I(inode)->vol;
> +	loff_t start_byte, end_byte;
> +
> +	/*
> +	 * Delalloc is reserved per cluster, which can be larger than the
> +	 * block size iomap_last_written_block() would round to.
> +	 */
> +	if (written)
> +		start_byte = round_up(pos + written, vol->cluster_size);
> +	else
> +		start_byte = round_down(pos, vol->cluster_size);
> +	end_byte = round_up(pos + length, vol->cluster_size);
> +	if (start_byte >= end_byte)
> +		return;
> +
> +	filemap_invalidate_lock(inode->i_mapping);
> +	iomap_write_delalloc_release(inode, start_byte, end_byte, flags, iomap,
> +				     ntfs_write_delalloc_punch);
> +	filemap_invalidate_unlock(inode->i_mapping);
> +}
> +
>  static int ntfs_write_iomap_end(struct inode *inode, loff_t pos, loff_t length,
>  				ssize_t written, unsigned int flags,
>  				struct iomap *iomap)
> @@ -769,6 +834,10 @@ static int ntfs_write_iomap_end(struct inode *inode, loff_t pos, loff_t length,
>  	if (iomap->type == IOMAP_INLINE)
>  		return ntfs_write_iomap_end_resident(inode, pos, length,
>  						     written, flags, iomap);
> +	if (iomap->type == IOMAP_DELALLOC && iomap->flags & IOMAP_F_NEW &&
> +	    !(flags & IOMAP_FAULT) && written < length)
> +		ntfs_write_delalloc_release(inode, pos, length, written, flags,
> +					    iomap);
>  	return written;
>  }
>  
> 
> -- 
> 2.56.1
> 
> 

-- 
Thanks,
Hyunchul
