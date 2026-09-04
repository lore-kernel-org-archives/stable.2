Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E4230E821;
	Fri,  4 Sep 2026 13:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788527270; cv=none; b=jh09IKh4OK9hEnn2rhqK2hfab/q2dbv3qDpdUePby4T2Mnz9OdlZ+AtrJ0QmrWNW1T158YqTi/z82/HmeMJ8xpuhapp5739nat9Wg2MkCXmIJ36bIbVdVNPctB7eSAS+kxnl5DEtZq/p98Nb5skn8I//V+VRmUO4leK0sBt9+xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788527270; c=relaxed/simple;
	bh=82UbyFFlSFDA5JHo18dWlRG5YWp1dckC2lUkBScJn5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Upk9NxGUIB4Je/RTRdteQkoJSuYCE78Fe0e2Wp9HEEVe0R9YP9ZBSyzTgcOX2JUNd0DY+vGufzTl2we/DSP6jZfTuhGTdnR0s7mMEW67EwKeJ+u2pam9hQ6ocMXhLwk44fJJmx00v7TeL+yAC+4T/7stSWgFuYRpFhk+/O1bH50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=e9sR93uD; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="e9sR93uD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=0q4XESU1G2VpQXiZhaiUsWjnfo84cCwLJnuMdevvSKQ=;
	b=e9sR93uDopeN3vHvpralLJomR0DDccMVXEa8j+QA7pDYIivnyfj+QhSyPM0/ag
	29tec7MNkRgXIuyzgAUzv7upgOQ5orOIAmSxnU3W/sRu+D4XTQKbF2MGWbob+Tu0
	Q/v+KQ8HSFdeSnhgrgUySr6InUpQhGxk7iV555oBlH3WU=
Message-ID: <ff64e1c3-8c08-4d60-8429-c5c3f4810e77@163.com>
Date: Fri, 4 Sep 2026 21:07:07 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] ntfs: convert runtime error paths to mark volume
 dirty after recording errors
To: Hongling Zeng <zenghongling@kylinos.cn>, linkinjeon@kernel.org,
 hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev, linux-kernel@vger.kernel.org,
 zhongling0719@126.com, stable@vger.kernel.org
References: <20260903075438.306793-1-zenghongling@kylinos.cn>
 <20260903075438.306793-3-zenghongling@kylinos.cn>
Content-Language: en-US
From: liubaolin <liubaolin12138@163.com>
In-Reply-To: <20260903075438.306793-3-zenghongling@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgCHMwN7wppqgOWwQw--.63894S2
X-Coremail-Antispam: 1Uf129KBjvAXoW3KFWkZw45WF1DGw1fWw4fGrg_yoW8XF4DWo
	WFkr1qyw40ga45Aayqv3Z5Aasxua98Cw4kJr4rCr4kZ3ZFqryj93y3Gw43uayaga15Krs2
	9rykJw4rZFZ3JFyUn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUnZXoDUUUU
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbCwRwR22qawny-7QAA3L



在 2026/9/3 15:54, Hongling Zeng 写道:
> Follow-up to the helper introduction: the runtime metadata-corruption
> paths in mft.c, lcnalloc.c, bitmap.c and inode.c still record the error
> flag with a bare NVolSetErrors(), leaving the same window in which
> ntfs_sync_fs() can acquire ni->mrec_lock, find NVolErrors() unset, and
> persist the volume as clean before the erroring thread records its
> error.
> 
> Convert the call sites that can run concurrently with sync and hold no
> mrec_lock:
> 
>   - the mft record allocation and $MFT data/$BITMAP extend rollback
>     paths (mft.c), which hold the runlist, mftbmp and lcnbmp locks;
> 
>   - the cluster allocation/free rollback paths (lcnalloc.c), which
>     hold vol->lcnbmp_lock;
> 
>   - the bitmap rollback failure path (bitmap.c), which holds no
>     relevant lock;
> 
>   - the inode read and writeback failure paths (inode.c), which run
>     under I_NEW or with the mrec_lock already released at err_out.
> 
> Blocking on the $Volume mrec_lock from those paths is safe: it is a
> leaf lock, its critical sections never acquire the locks the callers
> hold, and it carries its own lockdep class so the validator does not
> report an inversion against the shared mrec_lock class.
> 
> The remaining call sites keep calling NVolSetErrors() directly, now
> with comments explaining why:
> 
>   - the mft record writeback paths (write_mft_record_nolock() and
>     ntfs_write_mft_block()) can run with a caller's mrec_lock held,
>     which for the $Volume inode itself would self-deadlock the helper;
> 
>   - the ntfs_attr_lookup() failure paths (ntfs_attr_find(),
>     ntfs_external_attr_find() and the ntfs_attr_make_non_resident()
>     rollback) run with the caller's mrec_lock held for the same
>     reason.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
> ---
>   fs/ntfs/attrib.c   | 18 ++++++++++++++-
>   fs/ntfs/bitmap.c   |  2 +-
>   fs/ntfs/inode.c    |  8 +++----
>   fs/ntfs/lcnalloc.c |  4 ++--
>   fs/ntfs/mft.c      | 55 ++++++++++++++++++++++++++++------------------
>   5 files changed, 58 insertions(+), 29 deletions(-)
> 
> diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
> index 60264833bb63..5965a67b5971 100644
> --- a/fs/ntfs/attrib.c
> +++ b/fs/ntfs/attrib.c
> @@ -964,6 +964,11 @@ static int ntfs_attr_find(const __le32 type, const __le16 *name,
>   	}
>   	ntfs_error(vol->sb, "mft %#llx, type %#x is corrupt. Run chkdsk.",
>   		   (long long)ctx->ntfs_ino->mft_no, le32_to_cpu(type));
> +	/*
> +	 * ntfs_attr_lookup() runs with the caller's mrec_lock held, so the
> +	 * dirty bit cannot be written here (it would self-deadlock for the
> +	 * $Volume inode); record the error flag only.
> +	 */
>   	NVolSetErrors(vol);

Hi Hongling,
    I understand why ntfs_mark_volume_dirty_with_error() cannot be 
called directly here: if the caller is holding the $Volume inode's 
mrec_lock, the helper would deadlock trying to acquire the same lock again.

   However, keeping the bare NVolSetErrors() does not seem to resolve 
the dirty-bit issue.  If the caller is holding a regular inode's 
mrec_lock, it is different from $Volume->mrec_lock, so the following 
sequence is still possible:

   ntfs_sync_fs()                    error path
   --------------                    ----------
   acquire $Volume->mrec_lock        hold a regular inode's mrec_lock
   observe NVolErrors() == false
                                     detect metadata corruption
                                     set NVolErrors()
                                     do not set VOLUME_IS_DIRTY
   clear VOLUME_IS_DIRTY
   release $Volume->mrec_lock

   If the caller is holding $Volume->mrec_lock itself, the sequence 
above cannot occur concurrently, but the operations may still be ordered 
as follows:

   ntfs_sync_fs()                    $Volume error path
   --------------                    ------------------
   acquire $Volume->mrec_lock
   observe NVolErrors() == false
   clear VOLUME_IS_DIRTY
   release $Volume->mrec_lock
                                     acquire $Volume->mrec_lock
                                     detect metadata corruption
                                     set NVolErrors()
                                     do not set VOLUME_IS_DIRTY
                                     release $Volume->mrec_lock

   In either case, only the in-memory NVolErrors() flag may be set while 
the on-disk VOLUME_IS_DIRTY bit remains clear.

   The other runtime error paths in this patch that retain a bare 
NVolSetErrors() because they may hold an mrec_lock appear to have the 
same issue.  The new comments explain why the helper cannot be called 
directly, but these paths still do not set the on-disk dirty bit again.

Thanks,
Baolin.


>   	return -EIO;
>   }
> @@ -1501,8 +1506,14 @@ static int ntfs_external_attr_find(const __le32 type,
>   		err = -EIO;
>   	}
>   
> -	if (err != -ENOMEM)
> +	if (err != -ENOMEM) {
> +		/*
> +		 * ntfs_attr_lookup() runs with the caller's mrec_lock
> +		 * held, so the dirty bit cannot be written here; record
> +		 * the error flag only.
> +		 */
>   		NVolSetErrors(vol);
> +	}
>   	return err;
>   not_found:
>   	/*
> @@ -2236,6 +2247,11 @@ int ntfs_attr_make_non_resident(struct ntfs_inode *ni, const u32 data_size)
>   		if (ntfs_cluster_free_from_rl(vol, rl) < 0) {
>   			ntfs_error(vol->sb,
>   				"Failed to release allocated cluster(s) in error code path.  Run chkdsk to recover the lost cluster(s).");
> +			/*
> +			 * The caller may hold the mrec_lock of the inode
> +			 * being modified, so the dirty bit cannot be
> +			 * written here; record the error flag only.
> +			 */
>   			NVolSetErrors(vol);
>   		}
>   		kvfree(rl);
> diff --git a/fs/ntfs/bitmap.c b/fs/ntfs/bitmap.c
> index b1436b3151b9..6120cb301665 100644
> --- a/fs/ntfs/bitmap.c
> +++ b/fs/ntfs/bitmap.c
> @@ -284,7 +284,7 @@ int __ntfs_bitmap_set_bits_in_run(struct inode *vi, const s64 start_bit,
>   		ntfs_error(vi->i_sb,
>   			"Failed to map subsequent page (error %i) and rollback failed (error %i). Aborting and leaving inconsistent metadata. Unmount and run chkdsk.",
>   			err, pos);
> -		NVolSetErrors(NTFS_SB(vi->i_sb));
> +		ntfs_mark_volume_dirty_with_error(NTFS_SB(vi->i_sb));
>   	}
>   	return err;
>   }
> diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
> index 32edb4045178..0288f6a101dc 100644
> --- a/fs/ntfs/inode.c
> +++ b/fs/ntfs/inode.c
> @@ -1245,7 +1245,7 @@ static int ntfs_read_locked_inode(struct inode *vi)
>   		ntfs_error(vol->sb,
>   			"Failed with error code %i.  Marking corrupt inode 0x%llx as bad.  Run chkdsk.",
>   			err, ni->mft_no);
> -		NVolSetErrors(vol);
> +		ntfs_mark_volume_dirty_with_error(vol);
>   	}
>   	return err;
>   }
> @@ -1473,7 +1473,7 @@ static int ntfs_read_locked_attr_inode(struct inode *base_vi, struct inode *vi)
>   			err, ni->mft_no, ni->type, ni->name_len,
>   			base_ni->mft_no);
>   	if (err != -ENOENT && err != -ENOMEM)
> -		NVolSetErrors(vol);
> +		ntfs_mark_volume_dirty_with_error(vol);
>   	return err;
>   }
>   
> @@ -1725,7 +1725,7 @@ static int ntfs_read_locked_index_inode(struct inode *base_vi, struct inode *vi)
>   		"Failed with error code %i while reading index inode (mft_no 0x%llx, name_len %i.",
>   		err, ni->mft_no, ni->name_len);
>   	if (err != -EOPNOTSUPP && err != -ENOMEM)
> -		NVolSetErrors(vol);
> +		ntfs_mark_volume_dirty_with_error(vol);
>   	return err;
>   }
>   
> @@ -2883,7 +2883,7 @@ int __ntfs_write_inode(struct inode *vi, int sync)
>   		mark_inode_dirty(vi);
>   	else {
>   		ntfs_error(vi->i_sb, "Failed (error %i):  Run chkdsk.", -err);
> -		NVolSetErrors(ni->vol);
> +		ntfs_mark_volume_dirty_with_error(ni->vol);
>   	}
>   	if (need_iput)
>   		iput(vi);
> diff --git a/fs/ntfs/lcnalloc.c b/fs/ntfs/lcnalloc.c
> index aa2e017a4384..dd6854f16136 100644
> --- a/fs/ntfs/lcnalloc.c
> +++ b/fs/ntfs/lcnalloc.c
> @@ -763,7 +763,7 @@ switch_to_data1_zone:		search_zone = 2;
>   			ntfs_error(vol->sb,
>   				"Failed to rollback (error %i). Leaving inconsistent metadata! Unmount and run chkdsk.",
>   				err2);
> -			NVolSetErrors(vol);
> +			ntfs_mark_volume_dirty_with_error(vol);
>   		}
>   		/* Free the runlist. */
>   		kvfree(rl);
> @@ -1044,7 +1044,7 @@ s64 __ntfs_cluster_free(struct ntfs_inode *ni, const s64 start_vcn, s64 count,
>   		ntfs_error(vol->sb,
>   			"Failed to rollback (error %i).  Leaving inconsistent metadata!  Unmount and run chkdsk.",
>   			(int)delta);
> -		NVolSetErrors(vol);
> +		ntfs_mark_volume_dirty_with_error(vol);
>   	}
>   	ntfs_dec_free_clusters(vol, delta);
>   	up_write(&vol->lcnbmp_lock);
> diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
> index 984a0827f9ac..d8791d7b9678 100644
> --- a/fs/ntfs/mft.c
> +++ b/fs/ntfs/mft.c
> @@ -657,8 +657,15 @@ int write_mft_record_nolock(struct ntfs_inode *ni, struct mft_record *m, int syn
>   			"Not enough memory to write mft record. Redirtying so the write is retried later.");
>   		mark_mft_record_dirty(ni);
>   		err = 0;
> -	} else
> +	} else {
> +		/*
> +		 * The writeback path can run with the caller's mrec_lock
> +		 * held, so the dirty bit cannot be written here (it would
> +		 * self-deadlock for the $Volume inode); record the error
> +		 * flag only.
> +		 */
>   		NVolSetErrors(vol);
> +	}
>   	return err;
>   }
>   
> @@ -1150,7 +1157,7 @@ static int ntfs_mft_bitmap_extend_allocation_nolock(struct ntfs_volume *vol)
>   			if (ntfs_cluster_free_from_rl(vol, rl2)) {
>   				ntfs_error(vol->sb, "Failed to deallocate allocated cluster.%s",
>   						es);
> -				NVolSetErrors(vol);
> +				ntfs_mark_volume_dirty_with_error(vol);
>   			}
>   			kvfree(rl2);
>   			return PTR_ERR(rl);
> @@ -1285,7 +1292,7 @@ static int ntfs_mft_bitmap_extend_allocation_nolock(struct ntfs_volume *vol)
>   		 * The only thing that is now wrong is ->allocated_size of the
>   		 * base attribute extent which chkdsk should be able to fix.
>   		 */
> -		NVolSetErrors(vol);
> +		ntfs_mark_volume_dirty_with_error(vol);
>   		return ret;
>   	}
>   	a = ctx->attr;
> @@ -1306,7 +1313,7 @@ static int ntfs_mft_bitmap_extend_allocation_nolock(struct ntfs_volume *vol)
>   	down_write(&vol->lcnbmp_lock);
>   	if (ntfs_bitmap_clear_bit(vol->lcnbmp_ino, lcn)) {
>   		ntfs_error(vol->sb, "Failed to free allocated cluster.%s", es);
> -		NVolSetErrors(vol);
> +		ntfs_mark_volume_dirty_with_error(vol);
>   	} else
>   		ntfs_inc_free_clusters(vol, 1);
>   	up_write(&vol->lcnbmp_lock);
> @@ -1317,16 +1324,16 @@ static int ntfs_mft_bitmap_extend_allocation_nolock(struct ntfs_volume *vol)
>   				a->data.non_resident.mapping_pairs_offset),
>   				rl2, ll, -1, NULL, NULL, NULL)) {
>   			ntfs_error(vol->sb, "Failed to restore mapping pairs array.%s", es);
> -			NVolSetErrors(vol);
> +			ntfs_mark_volume_dirty_with_error(vol);
>   		}
>   		if (ntfs_attr_record_resize(ctx->mrec, a, old_alen)) {
>   			ntfs_error(vol->sb, "Failed to restore attribute record.%s", es);
> -			NVolSetErrors(vol);
> +			ntfs_mark_volume_dirty_with_error(vol);
>   		}
>   		mark_mft_record_dirty(ctx->ntfs_ino);
>   	} else if (status.mp_extended && ntfs_attr_update_mapping_pairs(mftbmp_ni, 0)) {
>   		ntfs_error(vol->sb, "Failed to restore mapping pairs.%s", es);
> -		NVolSetErrors(vol);
> +		ntfs_mark_volume_dirty_with_error(vol);
>   	}
>   	if (ctx)
>   		ntfs_attr_put_search_ctx(ctx);
> @@ -1420,20 +1427,20 @@ static int ntfs_mft_bitmap_extend_initialized_nolock(struct ntfs_volume *vol)
>   	mrec = map_mft_record(mft_ni);
>   	if (IS_ERR(mrec)) {
>   		ntfs_error(vol->sb, "Failed to map mft record.%s", es);
> -		NVolSetErrors(vol);
> +		ntfs_mark_volume_dirty_with_error(vol);
>   		return ret;
>   	}
>   	ctx = ntfs_attr_get_search_ctx(mft_ni, mrec);
>   	if (unlikely(!ctx)) {
>   		ntfs_error(vol->sb, "Failed to get search context.%s", es);
> -		NVolSetErrors(vol);
> +		ntfs_mark_volume_dirty_with_error(vol);
>   		goto unm_err_out;
>   	}
>   	if (ntfs_attr_lookup(mftbmp_ni->type, mftbmp_ni->name,
>   			mftbmp_ni->name_len, CASE_SENSITIVE, 0, NULL, 0, ctx)) {
>   		ntfs_error(vol->sb,
>   			"Failed to find first attribute extent of mft bitmap attribute.%s", es);
> -		NVolSetErrors(vol);
> +		ntfs_mark_volume_dirty_with_error(vol);
>   put_err_out:
>   		ntfs_attr_put_search_ctx(ctx);
>   unm_err_out:
> @@ -1587,7 +1594,7 @@ static int ntfs_mft_data_extend_allocation_nolock(struct ntfs_volume *vol)
>   		if (ntfs_cluster_free_from_rl(vol, rl2)) {
>   			ntfs_error(vol->sb,
>   				"Failed to deallocate clusters from the mft data attribute.%s", es);
> -			NVolSetErrors(vol);
> +			ntfs_mark_volume_dirty_with_error(vol);
>   		}
>   		kvfree(rl2);
>   		return PTR_ERR(rl);
> @@ -1721,7 +1728,7 @@ static int ntfs_mft_data_extend_allocation_nolock(struct ntfs_volume *vol)
>   		 * The only thing that is now wrong is ->allocated_size of the
>   		 * base attribute extent which chkdsk should be able to fix.
>   		 */
> -		NVolSetErrors(vol);
> +		ntfs_mark_volume_dirty_with_error(vol);
>   		return ret;
>   	}
>   	ctx->attr->data.non_resident.highest_vcn =
> @@ -1729,17 +1736,17 @@ static int ntfs_mft_data_extend_allocation_nolock(struct ntfs_volume *vol)
>   undo_alloc:
>   	if (ntfs_cluster_free(mft_ni, old_last_vcn, -1, ctx) < 0) {
>   		ntfs_error(vol->sb, "Failed to free clusters from mft data attribute.%s", es);
> -		NVolSetErrors(vol);
> +		ntfs_mark_volume_dirty_with_error(vol);
>   	}
>   
>   	if (ntfs_rl_truncate_nolock(vol, &mft_ni->runlist, old_last_vcn)) {
>   		ntfs_error(vol->sb, "Failed to truncate mft data attribute runlist.%s", es);
> -		NVolSetErrors(vol);
> +		ntfs_mark_volume_dirty_with_error(vol);
>   	}
>   	if (mp_extended && ntfs_attr_update_mapping_pairs(mft_ni, 0)) {
>   		ntfs_error(vol->sb, "Failed to restore mapping pairs.%s",
>   			   es);
> -		NVolSetErrors(vol);
> +		ntfs_mark_volume_dirty_with_error(vol);
>   	}
>   	if (ctx) {
>   		a = ctx->attr;
> @@ -1750,16 +1757,16 @@ static int ntfs_mft_data_extend_allocation_nolock(struct ntfs_volume *vol)
>   					a->data.non_resident.mapping_pairs_offset),
>   				rl2, ll, -1, NULL, NULL, NULL)) {
>   				ntfs_error(vol->sb, "Failed to restore mapping pairs array.%s", es);
> -				NVolSetErrors(vol);
> +				ntfs_mark_volume_dirty_with_error(vol);
>   			}
>   			if (ntfs_attr_record_resize(ctx->mrec, a, old_alen)) {
>   				ntfs_error(vol->sb, "Failed to restore attribute record.%s", es);
> -				NVolSetErrors(vol);
> +				ntfs_mark_volume_dirty_with_error(vol);
>   			}
>   			mark_mft_record_dirty(ctx->ntfs_ino);
>   		} else if (IS_ERR(ctx->mrec)) {
>   			ntfs_error(vol->sb, "Failed to restore attribute search context.%s", es);
> -			NVolSetErrors(vol);
> +			ntfs_mark_volume_dirty_with_error(vol);
>   		}
>   		ntfs_attr_put_search_ctx(ctx);
>   	}
> @@ -2322,7 +2329,7 @@ int ntfs_mft_record_alloc(struct ntfs_volume *vol, const int mode,
>   			folio_unlock(folio);
>   			kunmap_local(m);
>   			folio_put(folio);
> -			NVolSetErrors(vol);
> +			ntfs_mark_volume_dirty_with_error(vol);
>   			goto search_free_rec;
>   		}
>   		/*
> @@ -2475,7 +2482,7 @@ int ntfs_mft_record_alloc(struct ntfs_volume *vol, const int mode,
>   undo_mftbmp_alloc_nolock:
>   	if (ntfs_bitmap_clear_bit(vol->mftbmp_ino, bit)) {
>   		ntfs_error(vol->sb, "Failed to clear bit in mft bitmap.%s", es);
> -		NVolSetErrors(vol);
> +		ntfs_mark_volume_dirty_with_error(vol);
>   	}
>   	if (!base_ni || base_ni->mft_no != FILE_MFT)
>   		up_write(&vol->mftbmp_lock);
> @@ -2815,8 +2822,14 @@ static int ntfs_write_mft_block(struct folio *folio, struct writeback_control *w
>   			iput(ref_inos[nr_ref_inos]);
>   	}
>   
> -	if (unlikely(err && err != -ENOMEM))
> +	if (unlikely(err && err != -ENOMEM)) {
> +		/*
> +		 * The writeback path can run with a caller's mrec_lock
> +		 * held, so the dirty bit cannot be written here; record
> +		 * the error flag only.
> +		 */
>   		NVolSetErrors(vol);
> +	}
>   	if (likely(!err))
>   		ntfs_debug("Done.");
>   	return err;

