Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793239680;
	b=K1Pwj4r2c25We2yDkRpMxIQXcXgi/5PBgpWzpC68oiiQ/1YnbWdcLgK719ZoZ4tWstiu
	 Fg7bha1hpaLoKahGmTm5fp62bE1Jw3nrGV/3spZIc3sPSQmV1jMfvLiayyvVrh+IV2wQV
	 igzBUuKh4QnrW2aXjJPHrypYJUnZpffZrkIY4FPV/JTovtwMm7cfnnBXtlCGLPr5daORN
	 pTfWLGfEK0UygAx5TzA7jBCwBiUwoNrotoWoQ3v19Hcix3HMiuyOLPHIZWEbxFpAOZzyS
	 wgLm6KMCLd0qHPlQh4xvHOpJYsTnDV9AcBpFPzM/qoTSXXP5bDJsGtUTvGF4FHN2Wvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793239680;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=6QMc3NFnEfSTWgB2JhsFHrcWT+FuLKz27ZY2NpBD2Gw=;
	b=0jX/mejMvS/M2VI5VwR5rCzAOZLIZrZfBZN+TbDUP4iBpMQbvtab10NjplYiYq9OAGGV
	 qzSgIEPpR4edOWwRpfRIhGFiJAMl8jNHy/rp0IYVh4HRhOJLCQSlQqrGzy0qbKwPvmjrP
	 OLyaG6QpJ/cljf88GniCKL7u5QPFNIz2y04Bb1Ohnlz7uJnw4LdUQK4hXqjEDvIRTUFQp
	 b3t0EpzuL6njuyQypiQpO3J3xQ27aDkAV1TC+gDAyvjR3PZaPYM8im9sm+eKx6aFeIfBd
	 MQkOO1ab5uvaCxCXuBZNN72NlFrcMhh5bqwHbNIbSoLBFVRHyo04atY02tDtwC6+OkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=ogP3hA3b;
	arc=none smtp.remote-ip=117.135.210.2
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0805606A325;
	Thu, 29 Oct 2026 02:07:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0805606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=ogP3hA3b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=6QMc3NFnEfSTWgB2JhsFHrcWT+FuLKz27ZY2NpBD2Gw=;
	b=ogP3hA3b7zRXk/8DUJ67TVjNSi81Yb9XREZ6BBCHg66xoWTkjBgubmGQa8F0+7
	GUPl2qR1juznGkYSlLy3U7bJ3xVdx+d5JteK4Iih1T0d3IcFzTR1lEfy/YjUmSNY
	1IigwFZCVvKZ0dZQYraHxM70bemylkJwLxLTJA0dkhXYA=
Received: from [IPV6:2409:8900:1fd1:c0be:78be:cbf2:dfd7:c36a] (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3l0VhquJq285TDw--.39462S2;
	Thu, 29 Oct 2026 10:07:31 +0800 (CST)
Message-ID: <374bf856-f880-4fa2-abec-c4b2a063bf57@163.com>
Date: Thu, 29 Oct 2026 10:07:29 +0800
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
Subject: Re: [PATCH] ntfs: wait for bitmap folio writeback before modifying it
To: Shengzhuo Wei <me@cherr.cc>, Namjae Jeon <linkinjeon@kernel.org>,
 Hyunchul Lee <hyc.lee@gmail.com>
Cc: ntfs@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
References: <20261029-b4-ntfs-bitmap-writeback-wait-v1-1-e2ba711b2dbf@cherr.cc>
Content-Language: en-US
From: liubaolin <liubaolin12138@163.com>
In-Reply-To: <20261029-b4-ntfs-bitmap-writeback-wait-v1-1-e2ba711b2dbf@cherr.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3l0VhquJq285TDw--.39462S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuw17Zw15Ar1xtFykXF15twb_yoW7XFyfpr
	ZIkFnxtFW5XF12qrnFgFWjq3W0k3s8WF47JFWxWw42vF98ZwnxKFy5K3W0qF1rtrZxJrWx
	Xrs5uFWxZa4jvFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UStCcUUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbC6gMW4GriqmOWjgAA3G



在 2026/10/29 04:09, Shengzhuo Wei 写道:
> The bitmap update paths lock their page cache folios before modifying
> them, but the folio lock does not wait for an earlier writeback to
> finish.  Writeback can release the lock while its BIO still references
> the folio memory, allowing bitmap changes to race with that I/O and
> expose partially updated contents to it.
> 
> Wait for existing writeback after locking each folio and before
> modifying it in ntfs_attr_set(), both bitmap setter loops, the cluster
> allocator, and the two MFT bitmap allocation paths.  This follows the
> lock-then-wait sequence already used for attribute and raw MFT updates.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Shengzhuo Wei <me@cherr.cc>
> ---
> The change was checked against the existing attribute/MFT waits and
> the iomap completion path.  Existing base and patched NTFS object
> builds with W=1 and CONFIG_WERROR=y complete without warnings.  No
> runtime reproduction or filesystem stress test was performed.
> ---
>   fs/ntfs/attrib.c   | 2 ++
>   fs/ntfs/bitmap.c   | 4 ++++
>   fs/ntfs/lcnalloc.c | 2 ++
>   fs/ntfs/mft.c      | 4 ++++
>   4 files changed, 12 insertions(+)
> 
> diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
> index fce7144d7bef..b460d2223314 100644
> --- a/fs/ntfs/attrib.c
> +++ b/fs/ntfs/attrib.c
> @@ -2332,6 +2332,8 @@ int ntfs_attr_set(struct ntfs_inode *ni, s64 ofs, s64 cnt, const u8 val)
>   		attr_len = min_t(size_t, (size_t)cnt, folio_size(folio) - offset);
>   
>   		folio_lock(folio);
> +		if (folio_test_writeback(folio))
> +			folio_wait_writeback(folio);
>   		addr = kmap_local_folio(folio, offset);
>   		memset(addr, val, attr_len);
>   		kunmap_local(addr);
> diff --git a/fs/ntfs/bitmap.c b/fs/ntfs/bitmap.c
> index af86fb1c199b..057b315789ec 100644
> --- a/fs/ntfs/bitmap.c
> +++ b/fs/ntfs/bitmap.c
> @@ -213,6 +213,8 @@ int __ntfs_bitmap_set_bits_in_run(struct inode *vi, const s64 start_bit,
>   	}
>   
>   	folio_lock(folio);
> +	if (folio_test_writeback(folio))
> +		folio_wait_writeback(folio);
>   	kaddr = kmap_local_folio(folio, 0);
>   
>   	/* Set @pos to the position of the byte containing @start_bit. */
> @@ -277,6 +279,8 @@ int __ntfs_bitmap_set_bits_in_run(struct inode *vi, const s64 start_bit,
>   		}
>   
>   		folio_lock(folio);
> +		if (folio_test_writeback(folio))
> +			folio_wait_writeback(folio);
>   		kaddr = kmap_local_folio(folio, 0);
>   		/*
>   		 * Depending on @value, modify all remaining whole bytes in the
> diff --git a/fs/ntfs/lcnalloc.c b/fs/ntfs/lcnalloc.c
> index 3ebcac4c2864..aac8627a9283 100644
> --- a/fs/ntfs/lcnalloc.c
> +++ b/fs/ntfs/lcnalloc.c
> @@ -348,6 +348,8 @@ struct runlist_element *ntfs_cluster_alloc(struct ntfs_volume *vol, const s64 st
>   		}
>   
>   		folio_lock(folio);
> +		if (folio_test_writeback(folio))
> +			folio_wait_writeback(folio);
>   		buf = kmap_local_folio(folio, 0) + pg_off;
>   		ntfs_debug("Before inner while loop: buf_size %i, lcn 0x%llx, bmp_pos 0x%llx, need_writeback %i.",
>   				buf_size, lcn, bmp_pos, need_writeback);
> diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
> index 89288b794348..b8aa8b0891dc 100644
> --- a/fs/ntfs/mft.c
> +++ b/fs/ntfs/mft.c
> @@ -1206,6 +1206,8 @@ static s64 mft_bitmap_alloc_free_rec(struct ntfs_volume *vol,
>   				return PTR_ERR(folio);
>   			}
>   			folio_lock(folio);
> +			if (folio_test_writeback(folio))
> +				folio_wait_writeback(folio);

Hi Shengzhuo,
    Could this deadlock during MFT bitmap 
expansion？ntfs_mft_bitmap_extend_allocation_nolock() can recurse into MFT
record allocation while holding mftbmp_ni->runlist.lock.

   With L being that lock, could we get the following interleaving?
A and B are $MFT::$BITMAP folios; B is outside the cached iomap.
Time flows downwards.

   Writeback                        Bitmap expansion
   ---------                        ----------------
   lock A
   set PG_writeback(A)
   map A (take/release L)
   add A to wpc->wb_ctx
   unlock A
   [BIO still unsubmitted]
                                    take L
                                    extend bitmap mapping pairs
                                    need another extent record
                                    ntfs_mft_record_alloc()
                                      mft_bitmap_alloc_free_rec()
                                        lock A
                                        folio_wait_writeback(A)
                                    [wait for A's I/O, holding L]

   lock B
   set PG_writeback(B)
   ntfs_writeback_range(B)
     __ntfs_write_iomap_begin()
       down_write(L)
       [blocked on L]

   Cannot reach iomap_add_to_ioend()
   to submit A's pending BIO.        Cannot release L until
                                    A's writeback completes.

    ntfs_writeback_range() obtains the next mapping before 
iomap_add_to_ioend() can submit the pending BIO.
    Would we need to submit that BIO before taking the mapping locks?

Thanks,
Baolin.


>   			buf = (u8 *)kmap_local_folio(folio, 0) + folio_ofs;
>   			bit = data_pos & 7;
>   			data_pos &= ~7ull;
> @@ -1402,6 +1404,8 @@ static int ntfs_mft_bitmap_extend_allocation_nolock(struct ntfs_volume *vol)
>   
>   	down_write(&vol->lcnbmp_lock);
>   	folio_lock(folio);
> +	if (folio_test_writeback(folio))
> +		folio_wait_writeback(folio);
>   	b = (u8 *)kmap_local_folio(folio, 0) + (ll & ~PAGE_MASK);
>   	tb = 1 << (lcn & 7ull);
>   	/*
> 
> ---
> base-commit: d135ab453a7400a34930bdda1ef4bdc8acfac80e
> change-id: 20261029-b4-ntfs-bitmap-writeback-wait-d4561fa54c97
> 
> Best regards,
> --
> Shengzhuo Wei <me@cherr.cc>

