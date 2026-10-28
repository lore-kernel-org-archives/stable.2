Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.157.23.187
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793173114;
	b=THcurs7/KFQozKArMELwHq+VUvfIUZu3rw6hVUXT3ja9tUE1G7wDKvdaO97AwRKDRbu9
	 6R2Gzusu82FyGdEk0HrXWe78eHxQ4Ns9H8wkmdwVo09TbF6d3o0RmeEhJZm1G9IV3Je22
	 UkVbg3H/GBEHC648xHQU2XhFUPyhRxUBtsh4GmtJnFBRW4MZ12yYG9vWNo3+paeeuKoix
	 BwmeYTbxc2w4CyBzEmSLJjZ24CZ1pjjRXcz5WoRceO/vg4JwjagNl9U8URY0JPqi/TMVA
	 unXndV/ptoD8GL6nePtcYe/g1t1jrlt3szbXAXKEYaV9lEJkhywdlNO+7vAyaGfQeKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793173114;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:CC:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
	bh=iLWVqNA5ql0MHsthh1YnLfVO5+ygJTfilKNO3lm7vcc=;
	b=EoucQU/ikBWWo8dMXXsbrD+jqIyX/qREvPxsT9R2lmU5POgUJys4smHSfUdcOGIdW/zO
	 aizYJdWKUr2qpDgbf6CPRbCvuMg2h/suMPCuUnxzeu3N1W+TaXZyx6N4PVSHTbys7NCG2
	 MOWY11u8+3CXv/g3qx+qhXDmBSeVJSYHazSccFsa1+/rL82wZt0hTSgbUC9qqMm63hUiO
	 /uT0VJhQ+k/hMHOzbz4H5Z+hhYwW1nq4BDgJNS1rFN1/pabACUQAQVVtcKX9u+6RZv8j4
	 T7Nc5FKdGV/DnUUjK2X4z+nB2zfkfr5a02xxv8XIbFBT4QTooSH2aaFF9qWBUDSgQbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paragon-software.com;
	spf=pass smtp.mailfrom=paragon-software.com;
	dkim=pass header.d=paragon-software.com header.i=@paragon-software.com header.a=rsa-sha256 header.s=mail header.b=j52neKj9;
	arc=none smtp.remote-ip=35.157.23.187
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22A1606A31D;
	Wed, 28 Oct 2026 07:38:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B22A1606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.a=rsa-sha256 header.s=mail header.b=j52neKj9
Received: from relayfre-01.paragon-software.com (relayfre-01.paragon-software.com [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 36B701D15;
	Wed, 28 Oct 2026 07:39:19 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=j52neKj9;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 8FAE6213E;
	Wed, 28 Oct 2026 07:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1793173111;
	bh=iLWVqNA5ql0MHsthh1YnLfVO5+ygJTfilKNO3lm7vcc=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=j52neKj9uCMT3oMcgq70s+qx+B3cl5SEOPUWE/Gl5clZYiXSJM7u4jk5+1CPLiw+Z
	 sSOCrHVy6eB+1Obn1p04eSTC/vyVydt4qEoSXKLKY65yVAToaJvH/QRW1uxZ9YDXKb
	 FXaDD1+2gBPeXCGiXtk0G/7TY6gtRS8IDrutgAJI=
Received: from [192.168.95.128] (172.30.20.183) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 28 Oct 2026 10:38:30 +0300
Message-ID: <644d8241-eca6-41aa-b6bc-1ab4a1594da4@paragon-software.com>
Date: Wed, 28 Oct 2026 08:38:28 +0100
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
Subject: Re: [PATCH] fs/ntfs3: bound DeleteAttribute asize against rec->used
 in do_action
To: Hyeontae Lee <wonju345@naver.com>, <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20260803052145.71949-1-wonju345@naver.com>
Content-Language: en-US
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <20260803052145.71949-1-wonju345@naver.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

On 8/3/26 07:21, Hyeontae Lee wrote:

> In do_action()'s DeleteAttribute case (fslog.c:3316), attr is
> Add2Ptr(rec, roff) with roff taken from the on-disk lrh->record_off, and
> asize = le32_to_cpu(attr->size) is read straight out of the MFT record:
>
> 	asize = le32_to_cpu(attr->size);
> 	used  = le32_to_cpu(rec->used);
>
> 	if (!check_if_attr(rec, lrh))
> 		goto dirty_vol;
> 	...
> 	memmove(attr, Add2Ptr(attr, asize), used - asize - roff);
>
> check_if_attr() (fslog.c:2869) walks the attribute chain from
> rec->attr_off and returns o == ro.  Its loop breaks on ATTR_END, so ro may
> legitimately equal the offset of the ATTR_END marker; that is exactly how
> CreateAttribute appends to a record.  But check_file_record()'s walk
> (fslog.c:2831) also stops at ATTR_END, so check_attr() never inspects the
> bytes there.  When roff is the ATTR_END offset, those never-validated bytes
> are what gets read as attr->size, and used - asize - roff underflows.
>
> The read itself is also unbounded: roff is a u16 and attr->size is
> dereferenced at fslog.c:3317, before check_if_attr() has constrained roff
> at all, so it can be up to ~64K past a record_size-sized object.
>
> Commit 0ca0485e4b2e ("fs/ntfs3: validate rec->used in journal-replay file
> record check") added at fslog.c:2844
>
> 	if (used < PtrOffset(rec, attr) + sizeof(attr->type))
> 		return false;
>
> and its changelog names this very memmove.  It bounds rec->used against the
> ATTR_END offset; it does not bound asize.  With record_size 0x400,
> attr_off 0x38, a valid three-attribute chain ending in ATTR_END at 0x158
> and used 0x160, a record whose four bytes at 0x15c read 0x100 gives
>
> 	used - asize - roff = 0x160 - 0x100 - 0x158 = 0xffffff08
>
> i.e. a ~4 GiB memmove whose source and destination both run off the end of
> rec, a kmalloc(sbi->record_size) object (record.c:105).
>
> The equivalent non-replay path already refuses this.  mi_remove_attr()
> performs the same removal and starts with (record.c:548):
>
> 	if (aoff + asize > used)
> 		return false;
>
> Apply the same bound, spelled as a subtraction to match the neighbouring
> cases, and move the attr->size read after check_if_attr() so that the
> header is known to lie inside the record before it is dereferenced.
> Requiring roff + SIZEOF_RESIDENT <= used rejects the ATTR_END offset
> without rejecting any real attribute: for an attribute the walk validated,
> roff + asize <= off(ATTR_END) <= used - 4, and any attribute a
> DeleteAttribute record can legitimately name carries a full resident
> header, so roff + SIZEOF_RESIDENT <= roff + asize <= used - 4.
> check_attr() itself imposes no lower bound on asize, so a crafted
> sub-header asize can still pass the first test; the second test then
> bounds it and the memmove stays inside the record.
>
> Reproduced by mounting a crafted image on v7.2-rc5, which already contains
> 0ca0485e4b2e, under KASAN.  The image is an ordinary mkfs.ntfs volume with
> four bytes of one MFT record changed and a crafted $LogFile:
>
>    BUG: KASAN: slab-out-of-bounds in do_action.isra.0+0x3211/0x83c0
>    Read of size 4294967048 at addr ffff888002423258 by task mount/66
>
>    CPU: 1 UID: 0 PID: 66 Comm: mount Not tainted 7.2.0-rc5 #3
>    Call Trace:
>     kasan_report+0xce/0x100
>     kasan_check_range+0x105/0x1b0
>     __asan_memmove+0x23/0x60
>     do_action.isra.0+0x3211/0x83c0
>     log_replay+0x920a/0xd300
>     ntfs_loadlog_and_replay+0x3ef/0x510
>     ntfs_fill_super+0x1d23/0x4550
>     get_tree_bdev_flags+0x2ef/0x550
>     vfs_get_tree+0x82/0x2f0
>     fc_mount+0x10/0x1b0
>     path_mount+0x517/0x1df0
>     __x64_sys_mount+0x20b/0x270
>     do_syscall_64+0xf9/0x540
>     entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
>    Allocated by task 66:
>     __kasan_kmalloc+0x8f/0xa0
>     __kmalloc_noprof+0x1b4/0x460
>     mi_init+0x81/0x110
>     mi_get+0x6a/0x220
>     do_action.isra.0+0x1dbf/0x83c0
>     log_replay+0x920a/0xd300
>     ntfs_loadlog_and_replay+0x3ef/0x510
>     ntfs_fill_super+0x1d23/0x4550
>
>    The buggy address belongs to the object at ffff888002423000
>     which belongs to the cache kmalloc-1k of size 1024
>    The buggy address is located 600 bytes inside of
>     allocated 1024-byte region [ffff888002423000, ffff888002423400)
>
> KASAN reports the source side because __asan_memmove()
> (mm/kasan/shadow.c:94) validates src before dest and returns without
> copying.  Both ends are out of bounds, and on a kernel built without
> KASAN the copy is performed.
>
> rec->used is also left at used - asize by fslog.c:3323 before the memmove,
> so the record stays inconsistent even when the copy is suppressed; the same
> mount goes on to report "ino=1a, mi_enum_attr" and marks the volume dirty.
>
> Fixes: b46acd6a6a62 ("fs/ntfs3: Add NTFS journal")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Hyeontae Lee <wonju345@naver.com>
> ---
>   fs/ntfs3/fslog.c | 15 +++++++++++++--
>   1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
> index f038c799e7ac..f415785c60f9 100644
> --- a/fs/ntfs3/fslog.c
> +++ b/fs/ntfs3/fslog.c
> @@ -3314,10 +3314,21 @@ static int do_action(struct ntfs_log *log, struct OPEN_ATTR_ENRTY *oe,
>   		break;
>   
>   	case DeleteAttribute:
> -		asize = le32_to_cpu(attr->size);
>   		used = le32_to_cpu(rec->used);
>   
> -		if (!check_if_attr(rec, lrh))
> +		/*
> +		 * check_if_attr() accepts a record_off that points at the
> +		 * ATTR_END marker, which is how CreateAttribute appends.  The
> +		 * bytes there are not an attribute and check_attr() never
> +		 * validated them, so refuse an offset that cannot hold a
> +		 * resident header before reading attr->size, and then bound it
> +		 * as mi_remove_attr() does.
> +		 */
> +		if (!check_if_attr(rec, lrh) || roff + SIZEOF_RESIDENT > used)
> +			goto dirty_vol;
> +
> +		asize = le32_to_cpu(attr->size);
> +		if (asize > used - roff)
>   			goto dirty_vol;
>   
>   		rec->used = cpu_to_le32(used - asize);

Hello,

Your patch was applied, thanks.

Regards,
Konstantin

