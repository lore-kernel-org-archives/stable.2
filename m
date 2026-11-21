Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795262494;
	b=OlTjHamvzOGp7vhJLaBOzhggVV2+3e3/zRIcgs4J5HrXfvCsyHWxqpm04qbuH0lIf+ZW
	 Ip8qcR91cNr1ZZlyEd0oFv7+IMPdZ8lR9dHGBNtqYIwiwyAZjpIVta4ZG4QuKkvp3AKM0
	 LXp+ZZqtskxgzJneI1fiG0xG10bekaN14hHo/nodfmC5YPtUUYmCHy4nxYHqgGXh9AFCA
	 6Ll6oJ6H14JA/XTsE8uYWZ9uETVasBg/7Z/ymqO/6j5LMwJcHUCEvc7sLm0eOpeup275W
	 Ii0o3jumjag99hfeEpxvxZdaznrye+G+a3sC4e+JRbuw/rOMWmiWZ1MWmgNoQp7AcUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795262494;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=AfQ9gNn3aqTcvAEO006vJrJ0/kbXPFZS2ZASkbq3hXc=;
	b=I2EFIytc8PULt+OPUKDOLwBVrLQy6Nodqrv20gX4q2xXT7JXVx91roFumNBvdyBo2Dm8
	 TjgQU3y/zXy9/2+cY8mvw4z5Ntfea8cM8D471j9wbnHd5TpsZuA7xZyB63EkuEOxwSrFu
	 X34YcU2EDE2FDlTdwwdy318gAh+S1MINrqBqN7bcBenAyiivBP7Y5dnpE7JhqUdQ4f+KS
	 Ch76Qlr1lrieNIBVn54MT7x8jj3xLxI1BDxksI7gSFfh6bL3OTK14j6b3DMG50vJfpn9k
	 Q9QhBRra4BzmZW5CPoUAXa6UQKHBCmzTfpIGfS2GjTaxim4fESTEsQAqnthjXSI9W4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=uPnQU+vn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C0A606A32A;
	Sat, 21 Nov 2026 12:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=uPnQU+vn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CED31F000CA;
	Sat, 21 Nov 2026 12:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795262494;
	bh=AfQ9gNn3aqTcvAEO006vJrJ0/kbXPFZS2ZASkbq3hXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=uPnQU+vnzZ/xgSDYynuiwbPbCE2GscWhqEXaYbMIjzqKfTJPS4BqdkDGobI2KLEQ+
	 179tsBD38l3yxRNmRI3phlchHar4/IAvgu3RewOwY5SkuFhH+axdcFj0FMaO49ESCH
	 wTxHEdvTEz0H/h1UDnE/Ppjd9ogptS9uFNuOLaA4=
Date: Sat, 21 Nov 2026 13:01:54 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Tanuj Sharma <ertanuj96@gmail.com>
Cc: ntfs3@lists.linux.dev, almaz.alexandrovich@paragon-software.com,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] ntfs3: fix out-of-bounds write in do_action() bitmap
 operations
Message-ID: <2026112132-spending-smoking-5e7d@gregkh>
References: <2026112159-sampling-unmade-c123@gregkh>
 <6b0186b4.6dbf942f.174087.451e@mx.google.com>
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
In-Reply-To: <6b0186b4.6dbf942f.174087.451e@mx.google.com>

On Sat, Nov 21, 2026 at 03:55:32AM -0800, Tanuj Sharma wrote:
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
>  fs/ntfs3/fslog.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
> index 1879d04e3cd05..85590f56587c2 100644
> --- a/fs/ntfs3/fslog.c
> +++ b/fs/ntfs3/fslog.c
> @@ -3751,10 +3751,16 @@ static int do_action(struct ntfs_log *log, struct OPEN_ATTR_ENRTY *oe,
>  		off = le32_to_cpu(((struct BITMAP_RANGE *)data)->bitmap_off);
>  		bits = le32_to_cpu(((struct BITMAP_RANGE *)data)->bits);
>  
> -		if (cbo + (off + 7) / 8 > lco ||
> -		    cbo + ((off + bits + 7) / 8) > lco) {
> +		{
> +		u64 bmp_limit = attr->type == ATTR_ALLOC ?
> +			min(cbo + (u64)le32_to_cpu(oe->bytes_per_index), lco) :
> +			lco;
> +
> +		if (cbo + (off + 7) / 8 > bmp_limit ||
> +		    cbo + ((off + bits + 7) / 8) > bmp_limit) {
>  			goto dirty_vol;
>  		}
> +		}
>  
>  		ntfs_bitmap_set_le(Add2Ptr(buffer_le, roff), off, bits);
>  		a_dirty = true;
> @@ -3764,10 +3770,16 @@ static int do_action(struct ntfs_log *log, struct OPEN_ATTR_ENRTY *oe,
>  		off = le32_to_cpu(((struct BITMAP_RANGE *)data)->bitmap_off);
>  		bits = le32_to_cpu(((struct BITMAP_RANGE *)data)->bits);
>  
> -		if (cbo + (off + 7) / 8 > lco ||
> -		    cbo + ((off + bits + 7) / 8) > lco) {
> +		{
> +		u64 bmp_limit = attr->type == ATTR_ALLOC ?
> +			min(cbo + (u64)le32_to_cpu(oe->bytes_per_index), lco) :
> +			lco;
> +
> +		if (cbo + (off + 7) / 8 > bmp_limit ||
> +		    cbo + ((off + bits + 7) / 8) > bmp_limit) {
>  			goto dirty_vol;
>  		}
> +		}

That's obviously a coding style issue, please fix.

Also, no v2 information below the --- line?

thanks,

greg k-h
