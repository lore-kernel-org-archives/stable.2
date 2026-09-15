Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBBF479895;
	Tue, 15 Sep 2026 09:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789464874; cv=none; b=UZUz4QOhfyPgKFOybPUCh3dqhF8ZajLR9vpbdAk7GI9rdeObyzq4ezO70iJJ8y2D8t+zlNJ6my6cQYrjHiIS4oSS4Wl/0LA//otUWAOJJrlTCIWtmsfhsMga2dRNH7nNwqjYIK4ZtWh4o/j6JCHccauqcHEicXBm9wK28t/ejms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789464874; c=relaxed/simple;
	bh=o9KaS8KBJ72/Au0ekLL9/EQYMdStMVO+l/jzmtDKFKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c8QmvowVnCC07FZbjanD0MeiweVYjvUGQbfbj/l3ba2s/WvhAXORM7WmyM7paNRHJLaJ4d3zL0TMkJ9RvCOa1cjcCM2Owp97oeaglSqtEFIjjLFPQ4txwhbzSuOZFVTklK260X8p2IrBaeDDhtnd0+a6viO1VjbNlXR+vdNfEnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=GNkh54Ux; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="GNkh54Ux"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=szx1QknHx3Zsu0Y2nXgVQcYYi0bvPJR5aNFYcqUE6Qk=;
	b=GNkh54UxJbnASO8hwg2cXjFLO9Sbo2DLi5vmv/TsD7RpNS6o9zysiMyb83/ezG
	clqVlfhXrS+hTTm18IzTmz2ySM0mLUkYV3Q/Fa++JZAgXO1ypJ8nFdxXi5dWWgtE
	oyaRk3bGSY/suGnHYnwlWz5pq/kN7QnIQJLC9Y6a50zIQ=
Received: from [IPV6:2409:8900:21a7:a33a:233e:9c3e:6224:4649] (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3X8MGEalqV7w+Aw--.63106S2;
	Tue, 15 Sep 2026 17:34:00 +0800 (CST)
Message-ID: <84bf7c04-fb14-42f3-9c0a-5924db576ac3@163.com>
Date: Tue, 15 Sep 2026 17:33:57 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ntfs: roll back the in-memory attributes if the
 metadata update fails
To: Hongling Zeng <zenghongling@kylinos.cn>, linkinjeon@kernel.org,
 hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev, linux-kernel@vger.kernel.org,
 zhongling0719@126.com, stable@vger.kernel.org
References: <20260915062742.750092-1-zenghongling@kylinos.cn>
 <20260915062742.750092-2-zenghongling@kylinos.cn>
Content-Language: en-US
From: liubaolin <liubaolin12138@163.com>
In-Reply-To: <20260915062742.750092-2-zenghongling@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3X8MGEalqV7w+Aw--.63106S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCrykZryrAr43JFyfur17Wrg_yoWrGr45pF
	Z3CFyrK398X3srKrnayr4UWa1S9w1xuryUJryaq3WIy3ZIgwnrKrWSg3y29FW8tryDCw10
	qa1Ut3y5uryUZrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U6xRgUUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbC6QhLFmqpEQj1+wAA3o



在 2026/9/15 14:27, Hongling Zeng 写道:
> ntfs_setattr() copies the new attributes into the VFS inode with
> setattr_copy() and only then writes them to disk: the POSIX ACL update
> and the ntfs_ea_set_wsl_inode() call that stores the uid, gid and mode
> in the metadata EAs.  When one of those fails, the error is returned
> but the in-memory inode keeps the new, uncommitted attributes, so
> memory and disk diverge until the inode is written back or evicted.
> 
> Remember the old mode, uid, gid and the FILE_ATTR_READONLY bit and
> restore them before returning the error.  This is best effort: the
> ctime update is left in place, ntfs_ea_set_wsl_inode() may have
> completed some of the EAs before failing, and a failed ACL update may
> leave the cached ACL divergent.  The error is still reported.
> 
> Fixes: 9c87959601e8 ("ntfs: update file operations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
> ---
>   fs/ntfs/file.c | 28 ++++++++++++++++++++++++++--
>   1 file changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
> index 1417a76788ed..524b33c0e97f 100644
> --- a/fs/ntfs/file.c
> +++ b/fs/ntfs/file.c
> @@ -325,6 +325,10 @@ int ntfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>   	unsigned int ia_valid = attr->ia_valid;
>   	struct ntfs_inode *ni = NTFS_I(vi);
>   	struct ntfs_volume *vol = ni->vol;
> +	umode_t old_mode;
> +	kuid_t old_uid;
> +	kgid_t old_gid;
> +	typeof(ni->flags) old_flags;
>   
>   	if (NVolShutdown(vol))
>   		return -EIO;
> @@ -351,12 +355,17 @@ int ntfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>   		ia_valid |= ATTR_MTIME | ATTR_CTIME;
>   	}
>   
> +	old_mode = vi->i_mode;
> +	old_uid = vi->i_uid;
> +	old_gid = vi->i_gid;
> +	old_flags = ni->flags & FILE_ATTR_READONLY;
> +
>   	setattr_copy(idmap, vi, attr);
>   
>   	if (vol->sb->s_flags & SB_POSIXACL && !S_ISLNK(vi->i_mode)) {
>   		err = posix_acl_chmod(idmap, dentry, vi->i_mode);
>   		if (err)
> -			goto out;
> +			goto out_restore;
>   	}
>   
>   	if (0222 & vi->i_mode)
> @@ -378,11 +387,26 @@ int ntfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>   		err = ntfs_ea_set_wsl_inode(vi, 0, NULL, flags);
>   		mutex_unlock(&ni->mrec_lock);
>   		if (err)
> -			goto out;
> +			goto out_restore;
>   

Hi Hongling,
    Thanks for the patch.  Restoring the in-memory attributes addresses 
the failure case where no on-disk update has been committed.
   However, ntfs_ea_set_wsl_inode() updates $LXUID, $LXGID and $LXMOD 
independently, so it can fail after partially updating the on-disk 
metadata.  In that case, restoring all VFS attributes to their old 
values can itself create an inconsistency with the disk state.  The ACL 
path has a similar issue if the ACL update succeeds before the later EA 
update fails.

   This requires transactional updates of the related EAs with atomic 
failure handling.  Maintainer Namjae is currently working on the NTFS 
journal support, which should provide the necessary transactional 
infrastructure.
   Could this patch be deferred until that journal work is available, so 
that the attribute updates and their rollback can be handled atomically?

Thanks,
Baolin.

>   	}
>   
>   	mark_inode_dirty(vi);
> +	goto out;
> +
> +out_restore:
> +	/*
> +	 * The on-disk metadata update failed: put the in-memory
> +	 * attributes back so that the inode does not keep the new,
> +	 * uncommitted values.  This is best effort: the ctime update is
> +	 * left in place, ntfs_ea_set_wsl_inode() may have completed some
> +	 * of the EAs before failing, and a failed ACL update may leave
> +	 * the cached ACL divergent.
> +	 */
> +	vi->i_mode = old_mode;
> +	vi->i_uid = old_uid;
> +	vi->i_gid = old_gid;
> +	ni->flags = (ni->flags & ~FILE_ATTR_READONLY) | old_flags;
>   out:
>   	return err;
>   }

