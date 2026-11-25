Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795615701;
	b=Iy47mtkgqbQD92qziifROEw6dyiizbmOqcpuU6gdoMPZPGQGrfzfpPRx+/dRUCbHI3to
	 44wDQqXMXO5gK9zPiU+vuHpZxu2pDBPbyhpYXwIlYxHyAsAN8x44m4CCCYj4QFckzPYYJ
	 KFXt5u6ASBcpCadmaBFxdV4JDzHqRw87I06bLkr6VI7gcNPHETEylhaBeiWAho35jx7XV
	 htGE4vi5kxfEuGCrsJtkLHnls9aLLGfTG8WErqy1sEuJGZxDBVHA9FGs/nzynpy0/VeBS
	 65D8hVsIcmn2vo3NVuzLmXT8gmDFrdBW4skpChCJw0Y2r80NWaCP0DUgDlsqesK4AvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795615701;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=mc2qLV5uNRVy5NpmO4vo8y6SB2m4HMCZXlTamdbRSJA=;
	b=jXDBDJLOu/b3Wi+9BoVjqYDzOLn2LSwlzh5JuNGWWvpUF5MGsfxjmR2XNkmy4H1d6q4X
	 giB99/hwtMxFmACCQ3DnQ33RSopEq9hkfppKFDg8K2lQTfU6AgMRq6uvl1V7H1XkhY+ej
	 cgHPXShkNmAQPrLw+eYSKSYzgppNj84K9GlGU0NZDwczV8HFGYbAlfuRQ++oU88s+9+tu
	 w2YwT7LpJU+O3jYDALQWInIZbZGKgIiR/CR+BysG1MmInqQDhwOiR0pLC5t7rjXHm9KcT
	 XkU2FpYPbUfUCicFSU5/BAjcs5oV0PpKNnvElqyxOvzo6tA0O0ph2+eBh1LUIWBeRvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=myuDVkUU;
	arc=none smtp.remote-ip=220.197.31.4
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13212606A33C;
	Wed, 25 Nov 2026 14:08:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13212606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=myuDVkUU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=mc2qLV5uNRVy5NpmO4vo8y6SB2m4HMCZXlTamdbRSJA=;
	b=myuDVkUUtpl4tHNuV2UjMZapmbc41MB5aA+ootlavo5oV3WbMC3ukRHo39iU64
	roczYEHId5L1Lhvk4eeYU1amrjZ8FsVpxvEv2oyy7SSXtoiytObP5PintckXAdO1
	HcfuBlgTTVrkG+t2ZzuHs1hpvaf5dyFilIUmJegobRInM=
Received: from [IPV6:2409:8900:1a90:8163:5fb3:f207:88ec:aa89] (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgD3H7Gv6wZrX1tHIA--.12889S2;
	Wed, 25 Nov 2026 22:07:44 +0800 (CST)
Message-ID: <e291353e-7aa2-4c78-97e2-b5c8d2acbb93@163.com>
Date: Wed, 25 Nov 2026 22:07:43 +0800
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
Subject: Re: [PATCH 3/6] ntfs: read initialized_size under size_lock in the
 iomap paths
To: Hongling Zeng <zenghongling@kylinos.cn>, linkinjeon@kernel.org,
 hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev, linux-kernel@vger.kernel.org,
 zhongling0719@126.com, stable@vger.kernel.org
References: <20261125073547.154150-1-zenghongling@kylinos.cn>
 <20261125073547.154150-4-zenghongling@kylinos.cn>
Content-Language: en-US
From: liubaolin <liubaolin12138@163.com>
In-Reply-To: <20261125073547.154150-4-zenghongling@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgD3H7Gv6wZrX1tHIA--.12889S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3JF43Cw4DCrWUKrW7tFyDAwb_yoWxuw4fpr
	9F9FZ8KF43Zr92gw4rtwn8XayF9w18Kr1Uur1fGw1fA3s5Kr1vgF1Fka45uFWjqrZFyF1v
	vF4Dtw48u3ZrAr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Ug4SwUUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbC6hCDTmsG67D+LQAA3S



在 2026/11/25 15:35, Hongling Zeng 写道:
> The iomap read paths read ni->initialized_size without size_lock.
> ntfs_read_iomap_begin_non_resident() reads it twice in the length
> adjustment condition and once more in round_up(), so a concurrent
> update in between lets the condition pass with one value while the
> length is computed from another, which can yield a length matching
> neither boundary.
> 
> Read initialized_size once under size_lock in the resident clamp,
> the non-resident unwritten mapping, the length adjustment and
> ntfs_iomap_put_folio_non_resident(), so each decision is made on one
> value.
> 
> The buffered write and direct I/O paths read initialized_size
> unlocked too, when deciding whether the head or the tail of a newly
> allocated cluster has to be zeroed first. The mmap write fault path
> can extend initialized_size while holding neither the inode lock nor
> the MFT record lock, so snapshot the field under size_lock there as
> well.
> 
> Fixes: b041ca562526 ("ntfs: update iomap and address space operations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
> ---
>   fs/ntfs/iomap.c | 50 +++++++++++++++++++++++++++++++++++++++----------
>   1 file changed, 40 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/ntfs/iomap.c b/fs/ntfs/iomap.c
> index 8933f432aa68..afc4494822e1 100644
> --- a/fs/ntfs/iomap.c
> +++ b/fs/ntfs/iomap.c
> @@ -17,11 +17,14 @@ static void ntfs_iomap_put_folio_non_resident(struct inode *inode, loff_t pos,
>   {
>   	struct ntfs_inode *ni = NTFS_I(inode);
>   	unsigned long sector_size = 1UL << inode->i_blkbits;
> +	unsigned long flags;
>   	loff_t start_down, end_up, init;
>   
>   	start_down = round_down(pos, sector_size);
>   	end_up = (pos + len - 1) | (sector_size - 1);
> +	read_lock_irqsave(&ni->size_lock, flags);
>   	init = ni->initialized_size;
> +	read_unlock_irqrestore(&ni->size_lock, flags);
>   
>   	if (init >= start_down && init <= end_up) {
>   		if (init < pos) {
> @@ -88,6 +91,7 @@ static int ntfs_read_iomap_begin_resident(struct inode *inode, loff_t offset, lo
>   	loff_t i_size;
>   	u32 attr_len;
>   	int err = 0;
> +	unsigned long irqflags;
>   	char *kattr;
>   
>   	base_ni = ntfs_base_inode(ni);
> @@ -106,8 +110,10 @@ static int ntfs_read_iomap_begin_resident(struct inode *inode, loff_t offset, lo
>   		goto out;
>   
>   	attr_len = le32_to_cpu(ctx->attr->data.resident.value_length);
> +	read_lock_irqsave(&ni->size_lock, irqflags);
>   	if (unlikely(attr_len > ni->initialized_size))
>   		attr_len = ni->initialized_size;
> +	read_unlock_irqrestore(&ni->size_lock, irqflags);
>   	i_size = i_size_read(inode);
>   
>   	if (unlikely(attr_len > i_size)) {
> @@ -200,6 +206,7 @@ static int ntfs_read_iomap_begin_non_resident(struct inode *inode, loff_t offset
>   	struct ntfs_volume *vol = ni->vol;
>   	loff_t vcn_ofs;
>   	loff_t rl_length;
> +	unsigned long irqflags;
>   
>   	vcn = ntfs_bytes_to_cluster(vol, offset);
>   	vcn_ofs = ntfs_bytes_to_cluster_off(vol, offset);
> @@ -231,7 +238,12 @@ static int ntfs_read_iomap_begin_non_resident(struct inode *inode, loff_t offset
>   			iomap->type = IOMAP_HOLE;
>   		iomap->addr = IOMAP_NULL_ADDR;
>   	} else {
> -		if (need_unwritten && offset >= ni->initialized_size)
> +		loff_t initialized_size;
> +
> +		read_lock_irqsave(&ni->size_lock, irqflags);
> +		initialized_size = ni->initialized_size;
> +		read_unlock_irqrestore(&ni->size_lock, irqflags);
> +		if (need_unwritten && offset >= initialized_size)
>   			iomap->type = IOMAP_UNWRITTEN;
>   		else
>   			iomap->type = IOMAP_MAPPED;
> @@ -255,11 +267,17 @@ static int ntfs_read_iomap_begin_non_resident(struct inode *inode, loff_t offset
>   	up_write(&ni->runlist.lock);
>   
>   	if (!(flags & IOMAP_ZERO) &&
> -			iomap->type == IOMAP_MAPPED &&
> -			iomap->offset < ni->initialized_size &&
> -			iomap->offset + iomap->length > ni->initialized_size) {
> -		iomap->length = round_up(ni->initialized_size, 1 << inode->i_blkbits) -
> -			iomap->offset;
> +			iomap->type == IOMAP_MAPPED) {
> +		loff_t initialized_size;
> +
> +		read_lock_irqsave(&ni->size_lock, irqflags);
> +		initialized_size = ni->initialized_size;
> +		read_unlock_irqrestore(&ni->size_lock, irqflags);
> +		if (iomap->offset < initialized_size &&
> +				iomap->offset + iomap->length > initialized_size) {
> +			iomap->length = round_up(initialized_size, 1 << inode->i_blkbits) -
> +				iomap->offset;
> +		}
>   	}
>   	iomap->flags |= IOMAP_F_MERGED;
>   
> @@ -383,6 +401,7 @@ static int ntfs_write_simple_iomap_begin_non_resident(struct inode *inode, loff_
>   	struct runlist_element *rl, *rlc;
>   	bool is_retry = false;
>   	int err = 0, map_err = 0;
> +	unsigned long flags;
>   	s64 vcn, lcn;
>   	s64 max_clu_count =
>   		ntfs_bytes_to_cluster(vol, round_up(length, vol->cluster_size));
> @@ -511,9 +530,14 @@ static int ntfs_write_simple_iomap_begin_non_resident(struct inode *inode, loff_
>   		iomap->flags = IOMAP_F_NEW;
>   		if (lcn <= LCN_HOLE) {
>   			loff_t end = offset + length;
> +			loff_t initialized_size;
> +
> +			read_lock_irqsave(&ni->size_lock, flags);
> +			initialized_size = ni->initialized_size;
> +			read_unlock_irqrestore(&ni->size_lock, flags);
>   
>   			if (vcn_ofs || ((vol->cluster_size > iomap->length) &&
> -					end < ni->initialized_size)) {
> +					end < initialized_size)) {
>   				loff_t z_start, z_end;
>   
>   				z_start = vcn << vol->cluster_size_bits;
> @@ -527,7 +551,7 @@ static int ntfs_write_simple_iomap_begin_non_resident(struct inode *inode, loff_
>   			if ((!err || err == -EPERM) &&
>   			    max_clu_count > 1 &&
>   			    (iomap->length & vol->cluster_size_mask &&
> -			     end < ni->initialized_size)) {
> +			     end < initialized_size)) {
>   				loff_t z_start, z_end;
>   
>   				z_start = (vcn + max_clu_count - 1) <<
> @@ -581,6 +605,7 @@ static int ntfs_write_da_iomap_begin_non_resident(struct inode *inode,
>   	s64 vcn, start_lcn, lcn_count;
>   	bool balloc = false, update_mp;
>   	int err;
> +	unsigned long irqflags;
>   	s64 max_clu_count =
>   		ntfs_bytes_to_cluster(vol, round_up(length, vol->cluster_size));
>   
> @@ -622,16 +647,21 @@ static int ntfs_write_da_iomap_begin_non_resident(struct inode *inode,
>   		if (flags & IOMAP_DIRECT ||
>   		    ntfs_iomap_flags & NTFS_IOMAP_FLAGS_MKWRITE) {
>   			loff_t end = offset + length;
> +			loff_t initialized_size;
> +
> +			read_lock_irqsave(&ni->size_lock, irqflags);
> +			initialized_size = ni->initialized_size;
> +			read_unlock_irqrestore(&ni->size_lock, irqflags);
>   
>   			if (vcn_ofs || ((vol->cluster_size > iomap->length) &&
> -					end < ni->initialized_size))
> +					end < initialized_size))
>   				err = ntfs_dio_zero_range(inode,
>   							  start_lcn <<
>   							  vol->cluster_size_bits,
>   							  vol->cluster_size);
>   			if (!err && lcn_count > 1 &&
>   			    (iomap->length & vol->cluster_size_mask &&
> -			     end < ni->initialized_size))
> +			     end < initialized_size))
>   				err = ntfs_dio_zero_range(inode,
>   							  (start_lcn + lcn_count - 1) <<
>   							  vol->cluster_size_bits,

Looks good to me.

Reviewed-by: Baolin Liu <liubaolin@kylinos.cn>

