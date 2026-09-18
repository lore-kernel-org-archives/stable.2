Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA8717D6
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 03:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789702323; cv=none; b=izLs3fPs6MZEBLYQ6+id6wqSOeJ3rGDok/INcKsksoo/PsKixP/NvSHLgTXlJspzvEcxvAU+Sgfjgws6oRqIoSd6EKBKDl9g2zic//3dQwtDQO4Ra31DpT9W3HURK1aTH7gHDH7o11ywARum7x6Ux5N1qnJJdjg7PRxDsAbtNMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789702323; c=relaxed/simple;
	bh=ofbGnonuhMWHIHVrMioDm+COfo4E6fbBUBFRCUoAZGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YddZB/g/dJEGy4BQQBEvnjwadvcoL7OU6ujhESby0o6NPIjjiPXPkzRRo3kQObWPDmfT1Ouc1oDar8D3/tZNBty4EDyzaateZyhhOFjO3uS8a/TJzNQf1AqMJw0x7fnhq1Y41Df/EIaQ0f9wBH5LH6pr6IY893AaDrPiDlxycUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XQqCAIzo; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XQqCAIzo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=gDqFiXsIFxVLwgl8nROCme0E0boM641YgzTeXdujsAQ=;
	b=XQqCAIzoaocwtrH7zcDHh9K4fHB/J1Oi/oqYAM0D1gJmm0dnHlyK5x1KLMtjH3
	xUtAIpnsiJiMxoiOjGFsGnaLkVWsVvdK4JCZBgGuiLgh8eW56uR8VEkCJQ2XXQXZ
	dwSwRwa8DzzkdjQtLiKemA8gmYqYfZ/WQ0c27eL3gji4g=
Received: from [IPV6:2409:8900:1a8a:969c:2bfb:b58b:268a:b9c5] (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wC3h5eMsKxqfAaeBQ--.14493S2;
	Fri, 18 Sep 2026 11:31:26 +0800 (CST)
Message-ID: <81eb8e1b-b20a-4b50-a46f-a425465e4ef7@163.com>
Date: Fri, 18 Sep 2026 11:31:24 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ntfs: fix incorrect VCN units for index blocks in
 large clusters
To: Hyunchul Lee <hyc.lee@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>
Cc: ntfs@lists.linux.dev, stable@vger.kernel.org
References: <20260918-fix-c8k-index-v2-1-7c7c5d0b78ac@gmail.com>
Content-Language: en-US
From: liubaolin <liubaolin12138@163.com>
In-Reply-To: <20260918-fix-c8k-index-v2-1-7c7c5d0b78ac@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3h5eMsKxqfAaeBQ--.14493S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3JF4kWF48KFyDKrWDCrWkCrg_yoW7CFy3pr
	9Iyr1Skw47Jr12ywsxKa1jvryru34DK3WUKw4UJr17tr97Jrnag3W8KryrWF9ay395A3s7
	XFn0gr4ru398Xr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uj385UUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbC6Q4V32qssI6vhAAA3+



在 2026/9/18 08:18, Hyunchul Lee 写道:
> NTFS stores VCNs for index blocks smaller than their cluster in fixed
> 512-byte units, independent of logical sector size. Use correct block
> units when initializing and traversing these indexes so directory indexes
> are located correctly.
> 
> Verified on a Windows-created 4Kn/32KB-cluster NTFS volume that when the
> index block is smaller than the cluster, the VCN unit is 512 bytes.
> 
> Fixes: 27d5cd2d940b ("ntfs: fix directory lookup on large-page systems")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
> ---
> Changes in v2:
>    - Add a Fixes and Cc tags
> ---
>   fs/ntfs/index.c  | 2 +-
>   fs/ntfs/index.h  | 2 +-
>   fs/ntfs/inode.c  | 8 ++++----
>   fs/ntfs/layout.h | 6 +++---
>   fs/ntfs/namei.c  | 7 +++----
>   5 files changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/ntfs/index.c b/fs/ntfs/index.c
> index 46a8b19c0723..3e901004bcbf 100644
> --- a/fs/ntfs/index.c
> +++ b/fs/ntfs/index.c
> @@ -852,7 +852,7 @@ int ntfs_index_lookup(const void *key, const u32 key_len, struct ntfs_index_cont
>   	if (ni->vol->cluster_size <= icx->block_size)
>   		icx->vcn_size_bits = ni->vol->cluster_size_bits;
>   	else
> -		icx->vcn_size_bits = ni->vol->sector_size_bits;
> +		icx->vcn_size_bits = NTFS_BLOCK_SIZE_BITS;
>   
>   	icx->cr = ir->collation_rule;
>   	if (!ntfs_is_collation_rule_supported(icx->cr)) {
> diff --git a/fs/ntfs/index.h b/fs/ntfs/index.h
> index 9a03f53bba47..a898e348f2c9 100644
> --- a/fs/ntfs/index.h
> +++ b/fs/ntfs/index.h
> @@ -37,7 +37,7 @@
>    *		(maximum is MAX_PARENT_VCN)
>    * @ib_dirty:	true if the current index block (@ia/@ib) was modified
>    * @block_size:	size of index blocks in bytes (from $INDEX_ROOT or $Boot)
> - * @vcn_size_bits: log2(cluster size)
> + * @vcn_size_bits: log2 of the VCN unit size
>    * @sync_write:	true if synchronous writeback is requested for this context
>    *
>    * @idx_ni is the index inode this context belongs to.
> diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
> index 4375ad477809..d389d89b3ff5 100644
> --- a/fs/ntfs/inode.c
> +++ b/fs/ntfs/inode.c
> @@ -1021,8 +1021,8 @@ static int ntfs_read_locked_inode(struct inode *vi)
>   			ni->itype.index.vcn_size = vol->cluster_size;
>   			ni->itype.index.vcn_size_bits = vol->cluster_size_bits;
>   		} else {
> -			ni->itype.index.vcn_size = vol->sector_size;
> -			ni->itype.index.vcn_size_bits = vol->sector_size_bits;
> +			ni->itype.index.vcn_size = NTFS_BLOCK_SIZE;
> +			ni->itype.index.vcn_size_bits = NTFS_BLOCK_SIZE_BITS;
>   		}
>   
>   		/* Setup the index allocation attribute, even if not present. */
> @@ -1612,8 +1612,8 @@ static int ntfs_read_locked_index_inode(struct inode *base_vi, struct inode *vi)
>   		ni->itype.index.vcn_size = vol->cluster_size;
>   		ni->itype.index.vcn_size_bits = vol->cluster_size_bits;
>   	} else {
> -		ni->itype.index.vcn_size = vol->sector_size;
> -		ni->itype.index.vcn_size_bits = vol->sector_size_bits;
> +		ni->itype.index.vcn_size = NTFS_BLOCK_SIZE;
> +		ni->itype.index.vcn_size_bits = NTFS_BLOCK_SIZE_BITS;
>   	}
>   
>   	/* Find index allocation attribute. */
> diff --git a/fs/ntfs/layout.h b/fs/ntfs/layout.h
> index 9438fd9b668e..8f5792139d71 100644
> --- a/fs/ntfs/layout.h
> +++ b/fs/ntfs/layout.h
> @@ -1880,8 +1880,8 @@ struct index_header {
>    * @index_block_size:   Size of each index block in bytes
>    *                      (in $INDEX_ALLOCATION).
>    * @clusters_per_index_block:
> - *                      Clusters per index block (or log2(bytes)
> - *                      if < cluster).
> + *                      Clusters per index block, or 512-byte units when
> + *                      the index block is smaller than a cluster.
>    *                      Power of 2; used for encoding block size.
>    * @reserved:           3 bytes reserved/alignment (zero).
>    * @index:              Index header for root entries (entries follow
> @@ -1921,7 +1921,7 @@ struct index_root {
>    * @lsn:                Log sequence number of last modification.
>    * @index_block_vcn:    VCN of this index block.
>    *                      Units: clusters if cluster_size <= index_block_size;
> - *                      sectors otherwise.
> + *                      512-byte blocks otherwise.
>    * @index:              Index header describing entries in this block.
>    *
>    * When creating the index block, we place the update sequence array at this
> diff --git a/fs/ntfs/namei.c b/fs/ntfs/namei.c
> index 3e0adb9a0ea4..75e201096525 100644
> --- a/fs/ntfs/namei.c
> +++ b/fs/ntfs/namei.c
> @@ -433,9 +433,8 @@ static struct ntfs_inode *__ntfs_create(struct mnt_idmap *idmap, struct inode *d
>   			ni->itype.index.vcn_size_bits =
>   				vol->cluster_size_bits;
>   		} else {
> -			ni->itype.index.vcn_size = vol->sector_size;
> -			ni->itype.index.vcn_size_bits =
> -				vol->sector_size_bits;
> +			ni->itype.index.vcn_size = NTFS_BLOCK_SIZE;
> +			ni->itype.index.vcn_size_bits = NTFS_BLOCK_SIZE_BITS;
>   		}
>   	}
>   
> @@ -569,7 +568,7 @@ static struct ntfs_inode *__ntfs_create(struct mnt_idmap *idmap, struct inode *d
>   				NTFS_B_TO_CLU(vol, ni->vol->index_record_size);
>   		else
>   			ir->clusters_per_index_block =
> -				ni->vol->index_record_size >> ni->vol->sector_size_bits;
> +				ni->vol->index_record_size >> NTFS_BLOCK_SIZE_BITS;
>   		ir->index.entries_offset = cpu_to_le32(sizeof(struct index_header));
>   		ir->index.index_length = cpu_to_le32(index_len);
>   		ir->index.allocated_size = cpu_to_le32(index_len);
> 
> ---
> base-commit: 27d5cd2d940b53718f66fb682475587aa993d760
> change-id: 20260918-fix-c8k-index-e91b078b1290
> 
> Best regards,

Looks good to me.

Reviewed-by: Baolin Liu <liubaolin@kylinos.cn>

