Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793930167;
	b=PKknn+knR6PyWRGgsTd12cmYtAfpccbWOJwDS88Mb6G2A3jb6oKv++SYzvrlfAb432PE
	 uSQb765zQhZX8egqKzqwll/39usGsxU2yS0ZQJmZKYCTSguBrubmunz5qeQEl6Zeko71R
	 8E6HThYA+ynJm4qhuG7SyfHotA8rwbIHsia9nHFhrqLOLqZmQP57lm6bG2sbOi8ZBK9Wa
	 r2y61x4LSwEkaS6ulBIq+si/exujQjsxwEWhEgsyyQAlf2AjtAlbM06GPcszWqPS65sto
	 M2xYWkRV3XhtMv8E4kwnUbxfaYYzWz8ZU8AeM3R61bsgofLVNxx9KvgZzh/Nzx7iYng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793930167;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=2IwaaquVGNd7gM6MhL4GlZ3FLZbafuQnYr1jszjtRIw=;
	b=uJ/MbyHo7ujPtxIZ5cvmlkwq2/nSxlk1Y6g66W6ZR/V+bqaGc7yf4nU7447v/VWxyXbE
	 XnjTALd30vHrONvC9h2sJsO+3JtOIziFz3lIsykGnyGIDnUDwhj/lFBljTJWfEeLGaaGF
	 fGy9F/QuX9IfJASRpANQvBskS/mAt1MO5lgQb20jHv7Ybz//XPxlPhGSTwuriShohctAx
	 myLizZ48VPFdjcuq+Drzxf25F6qiO5IAgzeZ4CUe03G3TWE7wBBzsLP9xey3hn+KNgnYO
	 Dgc4bcm597fEMNLlyYWUnJFPh5ENroxjrWWr+fOxBAVMGElDX2g5ETUXtfgbHHwQQig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Anu424r9;
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A296606A328
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 01:56:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A296606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Anu424r9
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cc1bc88a20eso73969a12.3
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 17:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793930166; x=1794534966; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2IwaaquVGNd7gM6MhL4GlZ3FLZbafuQnYr1jszjtRIw=;
        b=Anu424r9svMljH5y5MvSy8eIfkZeKXitPff2rHMsTxbWq3XimrnwcSHNVn3hZYKA+w
         K1KiBRnmP1gHlbb9wbVYp5J62APYCXS6ff+e4TV55obmi94N5b7RWLP6VKnAZ2/AzuEq
         f4L2kaTPRKyzhG1KEEXinFTDVO2baVhaeGTo79MskLcoq7sY9X7WoOpVQ1jhrB3yxOiy
         9bMKjR5JEUP6O5GilVu/zraExlK6sqGe/WBHvzbDO5xy43w9sWnrQW39FRaPXDrkxKwM
         WzjsFMSSdfNYYRg22lNoznAm3l2KxKHaiCSCeGERyicnX9g5i7+5avNj2wRhwJx1fVdp
         c8Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793930166; x=1794534966;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2IwaaquVGNd7gM6MhL4GlZ3FLZbafuQnYr1jszjtRIw=;
        b=GNGKPyXj4TBD/Z6PXKo5/oPA2qcKp3F4AHuyeRK80bhiI0NNUrThTk/efuDEOUvkjk
         MVlmeBt7a6VgcEN3Lmeor/4xUIUWKB59z5iTXIwVhnnQ1Q1EuHXdWI5ITfRBz72cO7RM
         UsubbJYxFABjTjg80evpujl27gqv5XiDrO35ObfUaNap+hmSLDWV1WeccqpGSlRuC9md
         Tu+pjmnR80IUmwo7w7GAhyijiYxxaPrZjZH0B1HsSbYfLOK3uiGKh+XsRPc6eSvzpXSF
         4KasdZhmnKauGziKhMk1Nx0U5SrVwcPq62NW7u0949S6z8MNKoWXseu/fO6NqIIFHbEG
         ETvA==
X-Forwarded-Encrypted: i=1; AL+hErGwqRU8fvWyhq2/vw1w4NSohbsd0QggU9lzwHfBPkvBOrK6/ooCz/TpOeXtVqii+Z4xpfJTSzo=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Y0h6XUo6+LoeKGKsVB9z3nPWXgcS9AcvMJxx5IE92TpSEUQ1p
	AGkZCG5SvA8+P0k1+C3l3HR9jaLKXIcGxTgAbCOwqHZrPDB2KkL7qkRs
X-Gm-Gg: AYBFou1ftVyCxrdWj0iuPJ6dlIQw/X7kh1PHQS1MLtJtK0Wstwe69dCUFIovuiNYkVi
	PAGcaYBujSFLemnGkptJyDKeaiU4XQ1WSAuLldnXwk1BOZ9wnK0P0JSub79hOL8YTHdRFXlXjXP
	B6UmBK1lakaCB6azjFhTxVRL2mv4wg50nSyEOjtYeufkyGk8LwE/CuzuNmlZC20V/sg01cw0pEN
	SJM8efKpmBYtAuEZ8mh4vt0xSfi+sryLzKOTGQUMOO0I3cV9M50mAqik/yUQIBeF6EZHDAeEkn0
	lQJd6AP5hUj8mO5RyPrF69L0GuW+sb4lMot4DV9TFdlaTfYaHvf9umdjEYqSKZE0JUAk1TiFhXH
	JzW3R6RqKDLNFM+/H90xfh7DzkQypvR9h6ZvcGD7U4tA4Ri43XWMlsBHk1hQRAOm7SwUzjtd9Zu
	YgPpYatk2A9TAeVOK6ki2+EUFxP+I37rjmr4E1w7ZeaZrVf+rQho9AmIEf2qqnCmEsFjrAPLr91
	rMpVdo9tucDM6Gc5A0rvo7BmUa0xAnSzBUWsamXU7tfXcVX9pcDWTvUJ4NBoqYA83w0FX8rYSgO
	u2lWGOSJzTcIGxGphg==
X-Received: by 2002:a17:90b:2c86:b0:3b0:9a1b:b6fe with SMTP id 98e67ed59e1d1-3b0db70871dmr983678a91.62.1793930165680;
        Thu, 05 Nov 2026 17:56:05 -0800 (PST)
Received: from localhost ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b32678ecsm6138265a91.9.2026.11.05.17.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 17:56:04 -0800 (PST)
Date: Fri, 6 Nov 2026 10:56:02 +0900
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Zhan Xusheng <zhanxusheng1024@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, ntfs@lists.linux.dev,
	linux-kernel@vger.kernel.org, zhanxusheng@xiaomi.com,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] ntfs: don't write a compression block after a short
 copy
Message-ID: <au0zsi-oLfcprQxI@hyunchul-PC02>
References: <f385711f8772132f64462e1d6c13efadadc51bc2.1793874221.git.zhanxusheng@xiaomi.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f385711f8772132f64462e1d6c13efadadc51bc2.1793874221.git.zhanxusheng@xiaomi.com>

Hi Zhan,

On Thu, Nov 05, 2026 at 09:01:58PM +0800, Zhan Xusheng wrote:
> From: Zhan Xusheng <zhanxusheng@xiaomi.com>
> 
> ntfs_compress_write() does not read in the folios of a compression
> block that the write covers completely. If the copy from user space
> then comes up short, the rest of those folios still holds whatever
> the memory held before; ntfs_write_cb() compresses that to disk and
> the folios are marked uptodate.
> 
> The copy can come up short after fault_in_iov_iter_readable() has
> succeeded if the source buffer is unmapped in between. On a volume
> with 4K clusters, writing 64K at offset 0 of a compressed file while
> another thread unmaps and remaps the last page of the buffer leaves
> 61440 new bytes followed by 4096 bytes of another process's freed
> memory in the file. The write returns -EFAULT.
> 
> Treat a short copy into a full block like a copy that made no
> progress.
> 
> Fixes: 5b676a77f3e4 ("ntfs: skip reads for full compression unit overwrites")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>

This patch looks good to me. But the second patch in this series
appears to be missing.

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>

> ---
> Tested in QEMU on ntfs-next with KASAN, 4K clusters, page cache
> dropped and freed memory filled with 'Z' before each write:
> 
>   before: 16 of 41 writes failed, 3 of them changed the file, each
>           time bytes 61440-65535 read back as 0x5a
>   after:  286 of 731 writes failed, none changed the file
> 
> The same loop on rootfs gives short writes and no corruption. I can
> send the reproducer if it helps.
> 
>  fs/ntfs/compress.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/fs/ntfs/compress.c b/fs/ntfs/compress.c
> index 82c7c7d29073..287bd47282d9 100644
> --- a/fs/ntfs/compress.c
> +++ b/fs/ntfs/compress.c
> @@ -1567,6 +1567,16 @@ int ntfs_compress_write(struct ntfs_inode *ni, loff_t pos, size_t count,
>  			}
>  		}
>  
> +		/*
> +		 * The folios of a full compression block are not read in, so
> +		 * after a short copy the rest of the block holds whatever the
> +		 * folios contained.  Don't write that out.
> +		 */
> +		if (full_cb && copied < cb_size) {
> +			iov_iter_revert(from, copied);
> +			copied = 0;
> +		}
> +
>  		if (!copied) {
>  			err = -EFAULT;
>  			goto release_pages;
> 
> base-commit: 564c7753647731d19170914c1c637d3b33d88d3b
> -- 
> 2.43.0
> 

-- 
Thanks,
Hyunchul
