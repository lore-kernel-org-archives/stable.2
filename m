Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37661A238F;
	Wed, 14 Oct 2026 03:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791947215; cv=none; b=gxwpTzyiZLVk3BD0vRFMKJ99wOV/DUcFouuiCPlOo6TKcX5Rv4AcMQ5PmSh3RiqngCSNngPm0B18gQhwAqBSh2DgkjXHcf/Wc0cfQ/CX8KUsiqEl/RbAVYlV2pQFDIwxbOZ0WKKXd2OMpBZkJqv5p+Y2a7iYNkJ1ATPwFaXU0Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791947215; c=relaxed/simple;
	bh=iAdtGGroBDrnH01XaivvazF6E44G+ubkAKJ1JSqjwXc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LzzVxlsD6SM3m3XgjSw4Cci6MOPzSHTgYUlbEcY7/M+Yx11dYCJHa4eOjbuq57qvOB2xmTUxKdMrsfNP8n7GP0WJb79kWhydcTYhdXJZOtzlD3Y0YJ4s1N6XB8RGjX7z2FDdNTD3k2/v1uffnXA+JSw0KSPRqAoiR4CIxn0cn7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dCz/PBOO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dCz/PBOO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6D251F000FF;
	Wed, 14 Oct 2026 03:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791947213;
	bh=cvcIIENUcGj0kcDKv2wmnPJXR3e/hKvV0fryXSGNyHE=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To;
	b=dCz/PBOOdDSwPo8ILpNDTPs4g5UXsv/xPqXBP5Ov/2OZeatVU1g6XxkH2SnQQWjxf
	 m8iz5wLKScuM0LkBZU+bxz7ffjkbhKcUQE356SRlbFGf5u9rvSD0rLDqMAg2rHeJTT
	 +1DhxxiHGbW+HiQtJx0wZTi7MnVIH3v6dSzdi7ird07+LYpV0FANDjtUi7sy8mzW08
	 CoTfK/BpQbxgYHZozmXIBkKDFTpzjfAWIbhYAqpE5mYg3PkyPBX/zOEcFn0QSzaBzj
	 EMak0b0Pgliwt8hKAMkvyr3AQrG78wC+QZOz+grBd5aVimdSKuhHFy4kBpR+3ICTIa
	 aCZnmUruKcKXw==
Message-ID: <520e921e-1bfd-4c45-b134-f0677a3c656a@kernel.org>
Date: Wed, 14 Oct 2026 11:06:51 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Daeho Jeong <daehojeong@google.com>,
 stable@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH] f2fs: release a removed xattr node in
 roll-forward recovery
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20261013020941.4025355-1-daeho43@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20261013020941.4025355-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/13/26 10:09, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> When xattrs shrink enough to fit in the inline xattr area,
> write_all_xattrs() truncates the xattr node and clears i_xattr_nid. If
> the file is then fsynced without a checkpoint, only the inode block is
> written, with i_xattr_nid of 0.
> 
> Roll-forward recovery starts from the checkpointed inode, whose
> i_xattr_nid still points to the old xattr node.
> f2fs_recover_inline_xattr() copies only the inline xattr area, and
> f2fs_update_inode() writes the old i_xattr_nid back. So the inode keeps
> the stale xattr node:
> 
>  - The node block is never released, and fsck reports "nonzero bytes in
>    xattr space after end of list".
>  - If the inline xattr list ends exactly at the end of the inline area,
>    its terminator is read from the stale node, and the removed xattrs
>    come back after recovery.
> 
> When the fsynced inode has no xattr node but the checkpointed one has,
> release the old xattr node in the same way as f2fs_recover_xattr_data().
> 
> Fixes: 28cdce0459cc ("f2fs: recover inline xattr data in roll-forward process")
> Cc: stable@vger.kernel.org
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
>  fs/f2fs/node.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 55008f18afd..590fdedf9c2 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -2831,6 +2831,29 @@ int f2fs_recover_inline_xattr(struct inode *inode, struct f2fs_cached_block *ent
>  	f2fs_cache_wait_writeback(ientry);
>  	memcpy(dst_addr, src_addr, inline_size);
>  update_inode:
> +	/*
> +	 * The xattr node of the checkpoint was removed before fsync, e.g. the
> +	 * xattrs became small enough to fit inline. Release it as well, or
> +	 * the inode keeps pointing to the stale xattrs.
> +	 */
> +	if (!ri->i_xattr_nid && F2FS_I(inode)->i_xattr_nid) {
> +		struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> +		struct node_info ni;
> +		int err;
> +
> +		err = f2fs_get_node_info(sbi, F2FS_I(inode)->i_xattr_nid,
> +								&ni, false);
> +		if (err) {
> +			f2fs_put_cache(ientry, true);
> +			return err;
> +		}
> +
> +		f2fs_invalidate_blocks(sbi, ni.blk_addr, 1);
> +		dec_valid_node_count(sbi, inode, false);
> +		set_node_addr(sbi, &ni, NULL_ADDR, false);
> +		f2fs_i_xnid_write(inode, 0);

I think we need to clear dirty on xnode as well, refer to truncate_node(), otherwise
f2fs_writeback will write a dirty xnode w/ blkaddr = NULL_ADDR.

Thanks,

> +	}
> +
>  	f2fs_update_inode(inode, ientry);
>  	f2fs_put_cache(ientry, true);
>  	return 0;

