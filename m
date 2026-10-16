Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5295396B76;
	Fri, 16 Oct 2026 14:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792162084; cv=none; b=d5gGm3pVefOeKWt8cBU8Fk5GNttAwEs9bQZUWjv8pdpjKWj1sDotdcYyaliXakjknRWESfoYzsq5Lp4nZXQHCJaoei1My+Xkr91CKA2f39dXlvlaiMssQ6aZNwF6klaTYWv2/dYjWdO6kEpNTwr7U03L+vaMtkdJV4EriqQXnbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792162084; c=relaxed/simple;
	bh=AVfe8Mm5q2VVmCo8KEYkC0UPNhmmY/SXODvv1Glw114=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VjQ+McbPg1ulY1hXurFvogXofkEZmybFFl7XeVClA43VO5v0Jwg5tfJle2OWoQiIwDkRibuux4/C4bd1FrEjapqYLEBWn5bW2YsxMuS9VKCYmPN5T0YNI+Nw+X51FvrMkAZCezHniNmmBX1jGOXtHYyh6fO6T0N4qQJSuqMKZpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=bbfGVrNZ; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="bbfGVrNZ"
Received: from relayfre-01.paragon-software.com (relayfre-01.paragon-software.com [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id C152B1D5D;
	Fri, 16 Oct 2026 14:48:49 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=bbfGVrNZ;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id E0ADD2269;
	Fri, 16 Oct 2026 14:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1792162079;
	bh=DH6KUdMhhaLtiVKtHdzYz5Fr0kqhafTH3n1AYYvoUTo=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=bbfGVrNZKSOJkOHNxBkEi85vXDxENY1snS6Fa7mQJUNnhD7v/WHAT0Fz75ikXaL2R
	 9VyP0dsXGfqHCVtj/jTkyrWmTbVTCL7+iAQbel7D5Wo+iBttuKo/Cob9zYuM+hhenB
	 gK9JQa2wHAOhOV3NRkCAB/L58RRtbHllEiRvodJQ=
Received: from [192.168.95.128] (172.30.20.132) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 16 Oct 2026 17:47:58 +0300
Message-ID: <2cb5b61a-f16b-4dcb-b7f2-73409da192df@paragon-software.com>
Date: Fri, 16 Oct 2026 16:47:55 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/ntfs3: bound CreateAttribute asize against record_size
 in do_action
To: Hyeontae Lee <wonju345@naver.com>, <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20260731141440.52168-1-wonju345@naver.com>
Content-Language: en-US
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <20260731141440.52168-1-wonju345@naver.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

On 7/31/26 16:14, Hyeontae Lee wrote:

> In do_action()'s CreateAttribute case (fslog.c:3286), attr2 points into
> the on-disk log record and asize = le32_to_cpu(attr2->size) is therefore
> attacker-controlled on mount.  The guard bounds asize only against the
> log record itself,
>
>          Add2Ptr(attr2, asize) > Add2Ptr(lrh, rec_len)
>
> where rec_len is the client data length, and separately bounds dlen
> against the MFT record.  Nothing bounds asize against record_size, but
> all three writes that follow are into rec, a kmalloc(sbi->record_size)
> buffer allocated by mi_init() (record.c:105):
>
>          memmove(Add2Ptr(attr, asize), attr, used - roff);
>          memcpy(attr, attr2, asize);
>          rec->used = cpu_to_le32(used + asize);
>
> With record_size 0x400, roff 0x38, used 0x160 and asize 0x800 the memcpy
> writes 2048 bytes at rec + 0x38, 0x438 bytes past the allocation, and
> rec->used is left at 0x960.  dlen is 0x18 here, so the existing
> dlen check passes: dlen bounds nothing about the size of the copy.
>
> The equivalent non-replay path already refuses this.  mi_insert_attr()
> performs the same insert and starts with (record.c:488):
>
>          if (used + asize > sbi->record_size)
>                  return NULL;
>
> Apply the same bound, spelled as a subtraction to match the neighbouring
> clause.  used <= record_size holds here because check_file_record()
> validates it (fslog.c:2826) and is called on this record at fslog.c:3172;
> roff <= used - 4 follows from check_if_attr() together with the ATTR_END
> check at fslog.c:2844, so bounding used + asize bounds both copies.
>
> The sibling WriteEndOfFileRecordSegment case does the equivalent check
> against record_size at fslog.c:3277.
>
> Reproduced by mounting a crafted image on v7.2-rc5 under KASAN:
>
>    BUG: KASAN: slab-out-of-bounds in do_action.isra.0+0x41f6/0x83a0
>    Write of size 2048 at addr ffff888005c74838 by task mount/69
>
>    CPU: 0 UID: 0 PID: 69 Comm: mount Not tainted 7.2.0-rc5-00300-g8ba098e6b6ff #2
>    Call Trace:
>     kasan_report+0xce/0x100
>     kasan_check_range+0x105/0x1b0
>     __asan_memcpy+0x3c/0x60
>     do_action.isra.0+0x41f6/0x83a0
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
>    Allocated by task 69:
>     __kasan_kmalloc+0x8f/0xa0
>     __kmalloc_noprof+0x1b4/0x460
>     mi_init+0x81/0x110
>     mi_get+0x6a/0x220
>     do_action.isra.0+0x1db4/0x83a0
>     log_replay+0x920a/0xd300
>     ntfs_loadlog_and_replay+0x3ef/0x510
>     ntfs_fill_super+0x1d23/0x4550
>
>    The buggy address belongs to the object at ffff888005c74800
>     which belongs to the cache kmalloc-1k of size 1024
>    The buggy address is located 56 bytes inside of
>     allocated 1024-byte region [ffff888005c74800, ffff888005c74c00)
>
> Fixes: b46acd6a6a62 ("fs/ntfs3: Add NTFS journal")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Hyeontae Lee <wonju345@naver.com>
> ---
>   fs/ntfs3/fslog.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
> index f038c799e7ac..2230a4a77872 100644
> --- a/fs/ntfs3/fslog.c
> +++ b/fs/ntfs3/fslog.c
> @@ -3288,10 +3288,15 @@ static int do_action(struct ntfs_log *log, struct OPEN_ATTR_ENRTY *oe,
>                  asize = le32_to_cpu(attr2->size);
>                  used = le32_to_cpu(rec->used);
>
> +               /*
> +                * attr2->size is taken from the log record and is bounded only
> +                * by the log record length, not by the MFT record.  Refuse an
> +                * attribute that does not fit, as mi_insert_attr() does.
> +                */
>                  if (!check_if_attr(rec, lrh) || dlen < SIZEOF_RESIDENT ||
>                      !IS_ALIGNED(asize, 8) ||
>                      Add2Ptr(attr2, asize) > Add2Ptr(lrh, rec_len) ||
> -                   dlen > record_size - used) {
> +                   dlen > record_size - used || asize > record_size - used) {
>                          goto dirty_vol;
>                  }
>
> --
> 2.43.0

Hello,

Your patch was applied, thanks.

Regards,
Konstantin

