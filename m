Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795615747;
	b=nH9bTPFyMQV3gsCxEh84T5jzEnvuui6jRbt2UPfolSq/JUEP9Wompbrs+ueJBYUY6/sB
	 S9AaDokfF68bZiWGABjjRSHCwFP1dSXn67sf1GQnUcsRRpqHDHd4bgdgeyt6jPoQAtquK
	 2HohEDIbmoEtRMBuacUXEjdLqToHtwHDTNoEg14VkXMaAgWPuOGTzCKmoX2bhrG10F7ui
	 nboY+5UYPFzCBooVbYU1eDi3hKmNFAPLMzTdegbubWu1ChlRx3tEXcdhMx67OVGpoRaNT
	 NdgoOFy8HihytpVfrqKiiFEpCwFg/GMnBJkCSG2yEcNS29GwxZ9zA5/npPACgjXzHEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795615747;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=jz2sHRDsgOMXF3loU1YmxXnucHr35J5ATz4a4wdGZ3Q=;
	b=CC52NQv5ZslcV3sukZrids2IBLjqKZKbMrK68P77mzb0s2hxfeperus1IWkoYePtqv3R
	 hx66k9IS/Sl4xpPPAlOsxRweCK2rhAyuBJ/qVY57C6P0fp5ekM1ndbvYQDVhHaKmgfFxL
	 RlDKyRHESt4qZT/uMd+/5bCSHNrJFytSYt1XMY3ClSVMf5k1LZwguNvfMAauC9W58Gq52
	 EHMf2pX65RNrmlpemjLUGr0lNmNSkZ+ZZXSpueyZAEo6C2QIjw3GABgvXIbw6o34hwzXD
	 M1sf0S5WpAB2a9g/5AsSc8R2vuXoqe8frfJ+ICvk5V9ppRAXsL0v2/fEoJF3vdM/d2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Rmv+X3om;
	arc=none smtp.remote-ip=117.135.210.2
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6D2606A684;
	Wed, 25 Nov 2026 14:09:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD6D2606A684
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Rmv+X3om
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=jz2sHRDsgOMXF3loU1YmxXnucHr35J5ATz4a4wdGZ3Q=;
	b=Rmv+X3om2pJLZjbViec4YOfYOp4GbVL63Eb/wDZqzErmWmqTDWX9J+kEKR2brz
	3vhmCdP1hNl/V80V28SfFC9yPwQ/e/2T5GJp6my8w2eHhfwpYQQcuncJTvA/414p
	xhUIIn8OcznrrJY1hj9Pc0L9r/BOY3IHYOCFJmovMtL8Q=
Received: from [IPV6:2409:8900:1a90:8163:5fb3:f207:88ec:aa89] (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD3NzLk6wZrijuIJw--.25119S2;
	Wed, 25 Nov 2026 22:08:37 +0800 (CST)
Message-ID: <29998421-6c86-4130-a3b9-57aec80bc327@163.com>
Date: Wed, 25 Nov 2026 22:08:36 +0800
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
Subject: Re: [PATCH 6/6] ntfs: read initialized_size under size_lock in the
 mmap prepare path
To: Hongling Zeng <zenghongling@kylinos.cn>, linkinjeon@kernel.org,
 hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev, linux-kernel@vger.kernel.org,
 zhongling0719@126.com, stable@vger.kernel.org
References: <20261125073547.154150-1-zenghongling@kylinos.cn>
 <20261125073547.154150-7-zenghongling@kylinos.cn>
Content-Language: en-US
From: liubaolin <liubaolin12138@163.com>
In-Reply-To: <20261125073547.154150-7-zenghongling@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3NzLk6wZrijuIJw--.25119S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KryfZFW8uFWfZw1kXr1UZFb_yoW8Cr4xpr
	nIg3W5C395Zryjkwn3Kw45XFWFg3WxGw4UWw13uw17ArZ5Grn0gF15trWrWF48trsavw40
	vr1DJw1xu3WDJFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Ugo7_UUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbC6gWQW2sG6+UIlwAA3Y



在 2026/11/25 15:35, Hongling Zeng 写道:
> ntfs_file_mmap_prepare() reads ni->initialized_size without the
> size lock when deciding whether a shared writable mapping needs
> its initialized size extended before the faults start. The field
> is published under size_lock, so the read is a data race on the
> protocol the other readers follow: a stale low value causes a
> redundant call that __ntfs_extend_initialized_size() re-checks
> under the lock, and a stale high value skips the extension and
> leaves it to the write faults.
> 
> Take the snapshot under size_lock like the other readers.
> 
> Fixes: 9c87959601e8 ("ntfs: update file operations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
> ---
>   fs/ntfs/file.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
> index 70a86d6fee6b..1f08fe679a86 100644
> --- a/fs/ntfs/file.c
> +++ b/fs/ntfs/file.c
> @@ -1044,14 +1044,20 @@ int ntfs_file_mmap_prepare(struct vm_area_desc *desc)
>   
>   	if (vma_desc_test_all(desc, VMA_SHARED_BIT, VMA_MAYWRITE_BIT)) {
>   		struct inode *inode = file_inode(file);
> +		struct ntfs_inode *ni = NTFS_I(inode);
>   		loff_t from, to;
> +		loff_t initialized_size;
> +		unsigned long flags;
>   		int err;
>   
>   		from = ((loff_t)desc->pgoff << PAGE_SHIFT);
>   		to = min_t(loff_t, i_size_read(inode),
>   			   from + desc->end - desc->start);
>   
> -		if (NTFS_I(inode)->initialized_size < to) {
> +		read_lock_irqsave(&ni->size_lock, flags);
> +		initialized_size = ni->initialized_size;
> +		read_unlock_irqrestore(&ni->size_lock, flags);
> +		if (initialized_size < to) {
>   			err = ntfs_extend_initialized_size(inode, to, to);
>   			if (err)
>   				return err;

Looks good to me.

Reviewed-by: Baolin Liu <liubaolin@kylinos.cn>

