Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795254225;
	b=ZQUyW33Jjbeg0UtQFirLNycTkp3KS4c3CSEIKnHYUFfwh4TEuGsr7idcwclGa6CebpXW
	 xFi6euVRTfvlA+hTe/t67W/nr97RaqkEF1WzaOU6J9ct3FU4XRBA9xTY0ZQiBIENi6jHv
	 UgCNk77gujHjDE708Rc4nQHYeeweduR4PogC8qH2X+/iiHnfhGhkHhtmsNs1LrMu5T6Bt
	 Oh21TUGa7HXVwXer4vHakQyl/crNhSg+KeRLrGmTZQa78V9KH2nsX27oaOm/Z0eOHQM1f
	 cjlClgLXJIR4VcBoP3SlAQe1SUUO9rX+26Qmz8xug4+TS+vbyyJ13QfFyZMk63uk6zA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795254225;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=z+aEWnt2ulJEOd/rZgLmfZW3wOAZN9sdeAZ+G9aUovU=;
	b=4bx76QDzah51IRgg1HivWHtdh0oeQpSr0Qi5GJaW3HcUwqEHjWFINKNdkCj8ezJiuEfD
	 t/kR+bqmx4E1MnWPWD3esboIooARongZTnvaPZo9rQUjulFzjumTyPpfNDXdVM+S+YV1u
	 Ds9HZgLcF0f1ld+sSPG03EHE1Dl36KaVT4AGnBwn6aTvUnV13O1E7rW06q1ltTGS+TQ95
	 SSpqRtfsxm/Ivc1zKkhNf8UIbzST5TdZoBgSi01mP+452siFv/bGy7CEiCzpBuTI9YDrN
	 KObrIXR2TZ4x6rDTxHmfz2Vx46PTaP06FrtL6YoTnE6W78qJ+84L6BIMXnclUZ5bxmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=uK1hPum3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B668606A320;
	Sat, 21 Nov 2026 09:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=uK1hPum3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 413FD1F000C4;
	Sat, 21 Nov 2026 09:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795254224;
	bh=z+aEWnt2ulJEOd/rZgLmfZW3wOAZN9sdeAZ+G9aUovU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=uK1hPum3pMYBzlvfWRPwP61d7pQIohBnjhCMqdlt+OX8EQOQHt7SyyuofwfDEhF5D
	 2dMo9NpumcCHVqD3Pi4+huBLer0jbQy6EK7skzdJYYhdtZILlXAbXRrJ9zp2N/zfh5
	 PEGPv9wKWeBe7FRHJXaSH2cFA5FY1B17nFEvGrqs=
Date: Sat, 21 Nov 2026 10:43:41 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Tanuj Sharma <ertanuj96@gmail.com>
Cc: ntfs3@lists.linux.dev, almaz.alexandrovich@paragon-software.com,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] ntfs3: fix out-of-bounds write in do_action() bitmap
 operations
Message-ID: <2026112159-sampling-unmade-c123@gregkh>
References: <CAAnb6FRwYjE0jXUxqFHKu8ZAmLyX_+hwpjSuuD1RHjKGVeAOcg@mail.gmail.com>
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
In-Reply-To: <CAAnb6FRwYjE0jXUxqFHKu8ZAmLyX_+hwpjSuuD1RHjKGVeAOcg@mail.gmail.com>

On Sat, Nov 21, 2026 at 07:52:32AM +0530, Tanuj Sharma wrote:
> Hi,
> 
> This patch fixes an out-of-bounds heap write in the ntfs3 log replay
> path triggered by mounting a crafted NTFS image. The buffer is sized
> by bytes_per_index but bounds-checked against the larger lco, allowing
> bitmap operations to write past the allocation.
> 
> Thanks,
> Tanuj Sharma

None of this goes in the body of the email.

> >From d6abed28f9eb5941da61bbe2b59876f93b4c75de Mon Sep 17 00:00:00 2001
> From: Tanuj Sharma <ertanuj96@gmail.com>
> Date: Sat, 21 Nov 2026 02:15:09 +0000
> Subject: [PATCH] ntfs3: fix out-of-bounds write in do_action() bitmap
>  operations

Neither does this, just send the patch using git send-email or the like.

> 
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
> @@ -3751,10 +3751,16 @@ static int do_action(struct ntfs_log *log,
> struct OPEN_ATTR_ENRTY *oe,
>   off = le32_to_cpu(((struct BITMAP_RANGE *)data)->bitmap_off);
>   bits = le32_to_cpu(((struct BITMAP_RANGE *)data)->bits);
> 
> - if (cbo + (off + 7) / 8 > lco ||
> -    cbo + ((off + bits + 7) / 8) > lco) {
> + {
> + u64 bmp_limit = attr->type == ATTR_ALLOC ?
> + min(cbo + (u64)le32_to_cpu(oe->bytes_per_index), lco) :
> + lco;
> +
> + if (cbo + (off + 7) / 8 > bmp_limit ||
> +    cbo + ((off + bits + 7) / 8) > bmp_limit) {
>   goto dirty_vol;
>   }
> + }
> 

The patch is corrupted and can not be applied :(

thanks,

greg k-h
