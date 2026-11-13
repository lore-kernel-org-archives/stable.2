Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564382;
	b=vLq4hhQMFF7gQ11mN38NRFo2tFmaWb2vrwTozztOrbBUlQrRW872HGZvYtgpSg2HVSYU
	 ZdG5L7EbrQJ/2P+fF/gX6adE9FM2rFVVjm/Kq6z4W6+B52U12qkbH1K4Kym6zUsD08DF+
	 fEWEPxc/VP+Lc1ltM32QpIZa4Huyj96lW5zir1K2o+AFoxGJySAJ+Ty6RvDHDiLcaah2i
	 QxDI0LZTbcGYz08EpB0/XSotCPoRWQ+5tTeHGIq9pe7kV08hxFkBeVd8GSYRbhgNL8yjL
	 9acJdkMRPBFgCRBLQzix5brCoOqaZ0PbyeySmuWPVMlYgPkjtVhnLvHFVTBGDdUeieg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564382;
	h=DMARC-Filter:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=px/1buHh7TMXhFEIrqiyErLcAOiPn6wL2fWet4+iHOY=;
	b=0c8wPa6NQSxhMKRtFG18bSSOiVgPntwxG223uWzL/VmztHMt+j61/YOSPNzGiUlrEKYe
	 ViY8EtuEICCRwWGjeq+AQoFAB3ItUDadjKBVBuKHOK4UXFN04yUSNvu3/YDjC+e5cqR2a
	 EQ8CvvFRTwxkz1UWzju5WMZfrvJjLfXBlDwJnFXVCwh4AHMh1A0DwqzllhDdUmJa3eg0B
	 uBm7V8+/c0WFBKGMW0D0dardTBCyGAHlvx+KNzPcynOyoBfCNkbZqw/k002W8vkBDo3W/
	 ChhCt3RhMTMAAlN62m4RvWlgfdvB05VEKZL5hMlWKTCuzJ82Jch7GVb9nPKw1uAc77Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=LJGw1WEN;
	arc=none smtp.remote-ip=220.197.31.4
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D54606A893;
	Fri, 13 Nov 2026 10:06:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9D54606A893
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=LJGw1WEN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=px/1buHh7TMXhFEIrqiyErLcAOiPn6wL2fWet4+iHOY=;
	b=LJGw1WEN4suwGDDsgi+I6m9gDhFjjOCA+VvXQK9GFlniRKdcCxoUVXKvL16o0h
	Lhw9IJuGzD/iPLjMhhVqSRj254imJM9OiUmoCbO6kMQU2Ayjc78mZKhHvoJqsPFC
	rYzubECKLJFILU4MBXz3du7+E0h7kO3R01hoa8PItCgJk=
Message-ID: <25aefd4f-8d1f-48b6-8915-86079cd19ed7@163.com>
Date: Fri, 13 Nov 2026 18:05:41 +0800
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
Subject: Re: [PATCH 2/2] exfat: don't map EXFAT_EOF_CLUSTER as a physical
 cluster
To: Youling Tang <youling.tang@linux.dev>, Namjae Jeon
 <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>
Cc: Yuezhang Mo <yuezhang.mo@sony.com>, exfat@lists.linux.dev,
 linux-kernel@vger.kernel.org, Youling Tang <tangyouling@kylinos.cn>,
 stable@vger.kernel.org
References: <20261113080658.2440516-1-youling.tang@linux.dev>
 <20261113080658.2440516-3-youling.tang@linux.dev>
From: Chi Zhiling <chizhiling@163.com>
In-Reply-To: <20261113080658.2440516-3-youling.tang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3Hzz14PZqyY2jHQ--.32088S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWFW5JF18Kr1xZw1rtryfXrb_yoW5CF4fpw
	4DK3W5tFsxJa9rWr43XF1DX34Fkw1fKF48Jwn7Gr15GF90vr40kryqk3Wa9wn8Gw48CF1q
	qr1Fgw17u3sxCFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UVMKtUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC+BfNa2r24PfV-wAA3o

On 11/13/26 4:06 PM, Youling Tang wrote:
> From: Youling Tang <tangyouling@kylinos.cn>
> 
> exfat_map_cluster() reports a hole by returning success with
> *clu == EXFAT_EOF_CLUSTER for !create.  __exfat_iomap_begin() does not
> check that sentinel and converts it into a physical address far beyond
> the device.  A writeback that races with the i_size/i_blocks window in
> exfat_cont_expand() can hit this: it submits a bio past the end of the
> device, and fsync() or msync() returns -EIO.  If the resulting iomap
> length is zero, iomap_add_to_ioend() can loop on a zero-length bio and
> hang a concurrent truncate.
> 
> When a range starts before the end of the cluster chain but extends past
> it, exfat_map_cluster() returns the sentinel for the whole range.  Map
> the valid prefix first and only report the part beyond the chain as a
> hole.  Otherwise a writeback that straddles the end of the chain would
> skip valid dirty data.
> 
> Report the remaining range as a hole instead of turning the sentinel
> into an address, matching the old exfat_get_block() behavior.
> 
> Fixes: 82a81a7352bc ("exfat: add iomap buffered I/O support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
> ---
>   fs/exfat/iomap.c | 29 +++++++++++++++++++++++++++++
>   1 file changed, 29 insertions(+)
> 
> diff --git a/fs/exfat/iomap.c b/fs/exfat/iomap.c
> index 11823591b3a8..d6b420f615d4 100644
> --- a/fs/exfat/iomap.c
> +++ b/fs/exfat/iomap.c
> @@ -74,6 +74,22 @@ static int __exfat_iomap_begin(struct inode *inode, loff_t offset, loff_t length
>   	iomap->bdev = inode->i_sb->s_bdev;
>   	iomap->offset = offset;
>   
> +	if (!may_alloc) {
> +		unsigned int ondisk_clusters =
> +			exfat_bytes_to_cluster(sbi, exfat_ondisk_size(inode));
> +		unsigned int clu_offset =
> +			exfat_bytes_to_cluster(sbi, offset);
> +
> +		/*
> +		 * exfat_map_cluster() returns the EOF sentinel for the whole
> +		 * range if it extends past the cluster chain.  Map the valid
> +		 * prefix first so the hole only covers the part beyond it.
> +		 */
> +		if (clu_offset < ondisk_clusters &&
> +		    num_clusters > ondisk_clusters - clu_offset)
> +			num_clusters = ondisk_clusters - clu_offset;
> +	}

It would be better to put this handling in exfat_map_cluster().

Thanks.

> +
>   	err = exfat_map_cluster(inode, exfat_bytes_to_cluster(sbi, offset),
>   			&cluster, &num_clusters, may_alloc, &balloc);
>   	if (err == -ENOSPC && !(flags & IOMAP_DIRECT)) {
> @@ -90,6 +106,19 @@ static int __exfat_iomap_begin(struct inode *inode, loff_t offset, loff_t length
>   	if (err)
>   		goto out;
>   
> +	/*
> +	 * exfat_map_cluster() reports a hole by returning success with
> +	 * EXFAT_EOF_CLUSTER.  Return it as a hole instead of turning the
> +	 * sentinel into a physical address.
> +	 */
> +	if (!may_alloc && cluster == EXFAT_EOF_CLUSTER) {
> +		iomap->type = IOMAP_HOLE;
> +		iomap->addr = IOMAP_NULL_ADDR;
> +		iomap->offset = offset;
> +		iomap->length = length;
> +		goto out;
> +	}
> +
>   	cluster_offset = exfat_cluster_offset(sbi, offset);
>   	cluster_length = exfat_cluster_to_bytes(sbi, num_clusters);
>   

