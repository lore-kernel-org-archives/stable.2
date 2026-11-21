Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795265824;
	b=MSPMuKvy/GdknuaU8139LOwuAbnl+VLYh8DPoUaJOY+KHcbPrpiIevwmV1oEQMANY/y1
	 srHEe1gNqIY1dH9gOVd3KsRq8XyOumNHKvTLF5j2nWHIu3vJnpBFFUHa0pSscXEK4GnDk
	 Dl+aRD7ROvuFOQLB9K7RTBba33/1t+UstjOj21kcJjmQJAsKFqeOjddjuP3XEwEkaT7Ud
	 THjsBcdwWlg2nbfW0OTA5ROxJD03qfOhht/vFGcWPXNDcTV8YSE7t1US8jas9Of7s295X
	 MWCl0znDaCc7gmMPJA+gBeyWCiOO1eB8urMKtTvGME2wsIdZgbxUjWukybFIOhK8CEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795265824;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=nZlfSaU/KRR8LRuEz4bVGpZ1H+cZ7rUX3HbAVDD7qV0=;
	b=V1HvUNJoJX4IsIK688qRLguIFfUJkmSUqnry95fAxSA18bcO4oGKOvp+UFq01Covx7Nd
	 +rv130MNFmaFc1rirj0buCP9KOnO4VMtrgpX+fhy8rzcYi0P10ZLPLP7QvzM+prXd0vfm
	 ZyNouKLSJb0o673HaQx6v9w3Uoz0a07YNHPZyIz6t3e1ssknmzoZlG3/DylAK+3cYqWZs
	 374Y8MaUJn5+IhulV7LfazuFA0gbbmxyt777i8xO6gjmmBtDVqMDda4Wy9aYuJvs8PgfM
	 UtbDWcCx5cDk4B1ZYZ2AHvxQ/PDAjrmY2rqSCWFqbhXFciXnXW6bQFROEXbFCw6FUYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="2ZEOr/Jc";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45599606A320;
	Sat, 21 Nov 2026 12:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=2ZEOr/Jc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 647291F000CA;
	Sat, 21 Nov 2026 12:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795265824;
	bh=nZlfSaU/KRR8LRuEz4bVGpZ1H+cZ7rUX3HbAVDD7qV0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=2ZEOr/JcysBMblgGVp4X2qAr+SvVXtlUwycEuPrSVHpDO4Xr7Zqs8frBgLD5M+YLi
	 F6dhmftHC2a2zzId3o2QEFz0lfD/5Bj9NeuG7JDv1BK21ExAVEjAtNunOvm9DNnSQD
	 dIx8phoXWW8VtPdQWz5UtWMLUxuGgps3yJBzTncc=
Date: Sat, 21 Nov 2026 13:57:24 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Tanuj Sharma <ertanuj96@gmail.com>
Cc: ntfs3@lists.linux.dev, almaz.alexandrovich@paragon-software.com,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] ntfs3: fix out-of-bounds write in do_action() bitmap
 operations
Message-ID: <2026112152-delivery-synopsis-ada7@gregkh>
References: <2026112132-spending-smoking-5e7d@gregkh>
 <20261121122417.72854-1-ertanuj96@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261121122417.72854-1-ertanuj96@gmail.com>

On Sat, Nov 21, 2026 at 05:54:17PM +0530, Tanuj Sharma wrote:
> In do_action(), when replaying log records for ATTR_ALLOC attributes,
> the buffer is allocated based on bytes_per_index (typically 4096 bytes,
> kmalloc-4k) but bitmap operation bounds checking uses lco -- a larger
> value derived from lcns_follow << cluster_bits (typically 8192).
> 
> This allows SetBitsInNonresidentBitMap and ClearBitsInNonresidentBitMap
> opcodes to write past the allocated buffer into the adjacent slab object
> when processing crafted NTFS images with malicious $LogFile records.
> 
> The bounds check compares against lco (the full LCN extent size) but
> should compare against the actual buffer capacity. For ATTR_ALLOC, the
> buffer is only bytes_per_index bytes, allocated here:
> 
>   if (attr->type == ATTR_ALLOC) {
>       t32 = le32_to_cpu(oe->bytes_per_index);
>       if (bytes < t32)
>           bytes = t32;
>   }
>   buffer_le = kmalloc(bytes, GFP_NOFS);
> 
> But the bounds check uses the larger lco:
> 
>   if (cbo + (off + 7) / 8 > lco || ...)
> 
> With bytes_per_index=4096 and lco=8192, any bitmap_off >= 32768
> (byte offset 4096) passes the lco check but writes past the buffer.
> 
> Fix this by computing the bounds limit as the minimum of the buffer
> extent (cbo + bytes_per_index) and the LCN extent (lco). This ensures
> bitmap operations cannot exceed either the allocated buffer or the
> on-disk extent, and also prevents a crafted bytes_per_index larger
> than lco from weakening the existing check.
> 
> Found by code audit and confirmed with a crafted NTFS image that
> triggers the OOB write on mount.
> 
> Cc: stable@vger.kernel.org
> Fixes: b46acd6a6a62 ("fs/ntfs3: Add NTFS journal")
> Signed-off-by: Tanuj Sharma <ertanuj96@gmail.com>
> ---
> Changes in v3:
> - Fix coding style: move bmp_limit declaration to function scope,
>   remove bare blocks
> 
> Changes in v2:
> - Resend with proper formatting (git send-email)
> 
>  fs/ntfs3/fslog.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
> index 1879d04e3cd05..373d84545a8fe 100644
> --- a/fs/ntfs3/fslog.c
> +++ b/fs/ntfs3/fslog.c
> @@ -3125,6 +3125,7 @@ static int do_action(struct ntfs_log *log, struct OPEN_ATTR_ENRTY *oe,
>  	u16 roff = le16_to_cpu(lrh->record_off);
>  	u16 aoff = le16_to_cpu(lrh->attr_off);
>  	u64 lco = 0;
> +	u64 bmp_limit;
>  	u64 cbo = (u64)le16_to_cpu(lrh->cluster_off) << SECTOR_SHIFT;
>  	u64 tvo = le64_to_cpu(lrh->target_vcn) << sbi->cluster_bits;
>  	u64 vbo = cbo + tvo;
> @@ -3751,8 +3752,12 @@ static int do_action(struct ntfs_log *log, struct OPEN_ATTR_ENRTY *oe,
>  		off = le32_to_cpu(((struct BITMAP_RANGE *)data)->bitmap_off);
>  		bits = le32_to_cpu(((struct BITMAP_RANGE *)data)->bits);
>  
> -		if (cbo + (off + 7) / 8 > lco ||
> -		    cbo + ((off + bits + 7) / 8) > lco) {
> +		bmp_limit = attr->type == ATTR_ALLOC ?
> +			min(cbo + (u64)le32_to_cpu(oe->bytes_per_index), lco) :
> +			lco;
> +
> +		if (cbo + (off + 7) / 8 > bmp_limit ||
> +		    cbo + ((off + bits + 7) / 8) > bmp_limit) {
>  			goto dirty_vol;
>  		}

Did you run checkpatch on this?  Why are these { } needed here?

>  
> @@ -3764,8 +3769,12 @@ static int do_action(struct ntfs_log *log, struct OPEN_ATTR_ENRTY *oe,
>  		off = le32_to_cpu(((struct BITMAP_RANGE *)data)->bitmap_off);
>  		bits = le32_to_cpu(((struct BITMAP_RANGE *)data)->bits);
>  
> -		if (cbo + (off + 7) / 8 > lco ||
> -		    cbo + ((off + bits + 7) / 8) > lco) {
> +		bmp_limit = attr->type == ATTR_ALLOC ?
> +			min(cbo + (u64)le32_to_cpu(oe->bytes_per_index), lco) :
> +			lco;
> +
> +		if (cbo + (off + 7) / 8 > bmp_limit ||
> +		    cbo + ((off + bits + 7) / 8) > bmp_limit) {
>  			goto dirty_vol;
>  		}

Or here?

thanks,

greg k-h
