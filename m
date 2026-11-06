Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=188.121.53.83
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794001911;
	b=0GH5YwzmedVAwAV5hK9qUDrDYWsO8fM1/ls5wfNOoXahrstGipCN99qgM/h4h0PYqA1K
	 /O+XMqLHcMQVqLpkp+hJ06VYjfZphJ8awfsYjQrmc30FWJX6cEFz3DH9hSq6uEhSHdm5G
	 z567SBToDib6gM9M8TSCgjX/V2xpFyLXhDFeJavAT4kvy70jv+ZgmbxxOZL7I8A3oRGbz
	 FSjZpXykcza302VrhdSo4UzeBnVJCDe6w45BvgUuD8jhFdW5cirPbWgGfbO5R7YVwStvc
	 tdIDGH2AkHs3ho6T82PIVbDN4pbtLoJDg/9PQOeveUwd+jmtmlA9Frl6pcjS+UCusxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794001911;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:X-CMAE-Analysis:
	 Feedback-ID:X-SECURESERVER-ACCT:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CMAE-Envelope;
	bh=Xo6/X2F0OqQcatrchSUm9ysP9suJgZBOLydNW4sGVt4=;
	b=aQQVH0J6H2DU3S9wRh9TTkC5EZGSt1g8RgluglXrQs2l25oKo5Lw1W8U1jSzY8jlMJkG
	 IE/U5naAzD+w1aOzqP6Ur0tyVqV0NhlkGNQPusHBsKyoOpAogSM8cxElRgN3d64cKp9mp
	 v1UVW4aJa4OShLJSv1xx/tRHJbtfworCzskL0EHcoKjerUZMkNLxuK6iPdAw+cxZTZVyo
	 2Q1qIxpLY6WPY+1ylcCrWnS4bpZeNCB1PGqN5Wwxx9uS0sbDJWb+6LYSxo8Son99Bg/JR
	 CsHxJeM9GG94F8QPzfYGxYQlk7bnNWdErAskFFWe720ygL5X8LMOJ9VI+K8BBq1B9lA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=squashfs.org.uk;
	spf=pass smtp.mailfrom=squashfs.org.uk;
	dkim=pass header.d=secureserver.net header.i=@secureserver.net header.a=rsa-sha256 header.s=secureserver2 header.b=j4tDH9qz;
	dkim=pass header.d=squashfs.org.uk header.i=@squashfs.org.uk header.a=rsa-sha256 header.s=secureserver1 header.b=DbdKxFEj;
	arc=none smtp.remote-ip=188.121.53.83
Received: from sxplsmtpa04-08.prod.sxb1.secureserver.net (sxplsmtpa04-08.prod.sxb1.secureserver.net [188.121.53.83])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DC6606A32C
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 21:51:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4DC6606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=secureserver.net header.i=@secureserver.net header.a=rsa-sha256 header.s=secureserver2 header.b=j4tDH9qz;
	dkim=pass (2048-bit key, unprotected) header.d=squashfs.org.uk header.i=@squashfs.org.uk header.a=rsa-sha256 header.s=secureserver1 header.b=DbdKxFEj
Received: from [192.168.178.101] ([82.69.79.175])
	by :SMTPAUTH: with ESMTPSA
	id PRqOxLkRTpJLKPRqRxa9AP; Fri, 06 Nov 2026 21:51:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secureserver.net;
	s=secureserver2; t=1794001897;
	bh=Xo6/X2F0OqQcatrchSUm9ysP9suJgZBOLydNW4sGVt4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=j4tDH9qzvsUancNAw+UUcMYPnT8+LMfiUJoGv57HzuRh7Y66FTVrA/94+oXqxDXX0
	 +VZllAGc2sB0gNmVH28xybr6wlwmK/IyjUSekRbVpdu+W2jMV8ngDdedEcsrLiMMf/
	 6foBMloxcYvyB7e+UTjJzA5XsM1vTn3pHhlFr6ge1dTlUfrlHhLb1CXLOJ7uYPOj13
	 irXg3s7zfHbL1TCwl81hHwfyAYDp5LHLei2J1XWMTKpTBvVMd5yMIFPdJIlVbxfvj8
	 AY/USHi4ZBZ1YmwSkqjMyc3boHdzHurus5zPS1YB34y9mbXSYzdROx+FMZK2KL5sON
	 +ZfzmrKhrBNFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squashfs.org.uk;
	s=secureserver1; t=1794001897;
	bh=Xo6/X2F0OqQcatrchSUm9ysP9suJgZBOLydNW4sGVt4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=DbdKxFEj+dMEMiRPS4JKNVOm2mDdwAqOA829Ox7biGEnDLAnEKnvktqA/wHPFYFP8
	 2L1+/zwx4iIUoTaS3hWwLRUK8Al+JNeSx0AW8MtVSTqpDxU/WpkYYjeusCEjwTAefe
	 enbpcdPv/mliOJneM5Y16lWeSSQg9usUILCujzO+QIcXkyv9OIwsMi5o7DzAJBgWwt
	 9mqxcLgtIC0wOlU7wicel4ONVbt55Yc6pF+7uONXnOEo86qfqK/ljWYtpA++KMMy9z
	 jhnKgyC7dtWsCWpYxnWaZF8CrrOcjP2U1Z0fyT8vF2L9q+Z4sKVOzuQBNuK/IyTHzv
	 Mum9EWzi9gqqg==
X-CMAE-Analysis: v=2.4 cv=U4kHnuru c=1 sm=1 tr=0 ts=6aee4be9
 a=84ok6UeoqCVsigPHarzEiQ==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=IkcTkHD0fZMA:10 a=edf1wS77AAAA:8 a=FXvPX3liAAAA:8 a=pGLkceISAAAA:8
 a=hSkVLCK3AAAA:8 a=VwQbUJbxAAAA:8 a=fRafXCwJDMqIuDAOK7wA:9 a=QEXdDO2ut3YA:10
 a=DcSpbTIhAlouE1Uv7lRv:22 a=UObqyxdv-6Yh2QiB9mM_:22 a=cQPPKAXgyycSBL8etih5:22
Feedback-ID: 925414b8c9b40187a3749bea899587e1:squashfs.org.uk:ssnet
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
Message-ID: <e5e1796a-428a-4d1b-ae59-be1db690b216@squashfs.org.uk>
Date: Fri, 6 Nov 2026 21:51:32 +0000
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
Subject: Re: [PATCH] squashfs: fix leaked page locks when page actor
 allocation fails
To: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, syzbot+65b1e2d8f2d618a93e96@syzkaller.appspotmail.com
References: <20260927060541.45780-1-ngocthang2710.1999@gmail.com>
Content-Language: en-US
From: Phillip Lougher <phillip@squashfs.org.uk>
In-Reply-To: <20260927060541.45780-1-ngocthang2710.1999@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfMN6jVjiAStnjbI5hkjsEC5AB2dRhoxeUj/Uzz+G4XVwk0EKvrO9E3samvL1/AYniOj1BhTDdHqr076xtPlkB/119Z7YNJ5xNffV++vH8kMmQS/VuIe7
 iuzm7coiXke82aDW/TLLse9ZuCglPGwEGF50deGbkkDkcxGSmdNo4C7iOhDsNJDbLEQM4rzLAxVOzFKKDBufimPr71pFxvO0IjOSR5l+htSz5FkUx4vsH5D9
 59T9zNblewQjljr6ZsNLDOfTTH5GP3ZbTIPJJVbhtiQKXK/C64xLSd4GZ4ToPYfJ/NVO6GE2ExyT5TCWAAz59xFKKFlhsSLW+1DXFya4ci6zAegGnFPK/UqM
 nKQT90sUJOwEuuDd1DZWfk8Fb/NC1IJ8TGFMLLRBhufTaYffwgM=

On 27/09/2026 07:05, Nguyen Ngoc Thang wrote:

> Hi Phillip,
>
> syzbot reports a hang in evict() during umount of a squashfs mount
> (INFO: task hung in evict (2)):
>
>    https://syzkaller.appspot.com/bug?extid=65b1e2d8f2d618a93e96
>
> Root cause: squashfs_readpage_block() grabs and locks the sibling pages
> of the block with grab_cache_page_nowait(), and only afterwards allocates
> the page actor.  If squashfs_page_actor_init_special() fails, the code
> does "goto out", which only kfree()s the page array. The locked, referenced
> sibling pages are never unlocked or put. A later truncate_inode_pages_range()
> from evict() blocks on the leaked folio lock forever.
>
> The ordering was introduced by f268eedddf35 ("squashfs: extend "page actor"
> to handle missing pages"); before it the actor was allocated first.
>
> Fix: use "goto mark_errored", which already unlocks and puts every page
> except the target page (owned by the caller, which unlocks it via
> folio_end_read()). res is still -ENOMEM at that point.
>
> Testing: QEMU (KVM, KASAN, lockdep, IMA tcb policy) running the syzbot C
> reproducer, with fail-nth swept over 1..400 in openat().  The failslab
> hit lands in squashfs_page_actor_init_special() from
> squashfs_readpage_block() via ima_calc_file_hash().
>    - before: hung task in evict()/truncate_inode_pages_range() after ~12s,
>      same trace as the syzbot report
>    - after: 170s of runs, 174 injected failures at that site, no hang
>
> The patch is below / attached.
>
> ----- patch -----
>  From f686b39f997dc20222f455c5ac6421f6a5d6c8d8 Mon Sep 17 00:00:00 2001
> From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
> Date: Sun, 27 Sep 2026 12:40:12 +0700
> Subject: [PATCH] squashfs: fix leaked page locks when page actor allocation
>   fails
>
> squashfs_readpage_block() grabs and locks the sibling pages of the
> target block before it allocates the page actor.  If that allocation
> fails it jumps to "out", which only frees the page array, so the locked
> pages are never unlocked or released.
>
> A later truncate_inode_pages_range() on the inode, e.g. from evict() at
> umount, then waits forever on the leaked folio lock and the task hangs.
>
> Go through mark_errored instead, which unlocks and puts every page
> except the target, which the caller handles.
>
> Fixes: f268eedddf35 ("squashfs: extend "page actor" to handle missing pages")
> Reported-by: syzbot+65b1e2d8f2d618a93e96@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=65b1e2d8f2d618a93e96
> Cc: stable@vger.kernel.org
> Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
> ---
>   fs/squashfs/file_direct.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/squashfs/file_direct.c b/fs/squashfs/file_direct.c
> index 2c3e809d6891..177357443543 100644
> --- a/fs/squashfs/file_direct.c
> +++ b/fs/squashfs/file_direct.c
> @@ -70,7 +70,7 @@ int squashfs_readpage_block(struct folio *folio, u64 block, int bsize,
>   	actor = squashfs_page_actor_init_special(msblk, page, pages, expected,
>   						start_index << PAGE_SHIFT);
>   	if (actor == NULL)
> -		goto out;
> +		goto mark_errored;
>   
>   	/* Decompress directly into the page cache buffers */
>   	res = squashfs_read_data(inode->i_sb, block, bsize, NULL, actor);

Sorry for the delay, I'm currently snowed under with AI reports and bugs;

But, it looks good.

Reviewed-by: Phillip Lougher <phillip@squashfs.org.uk 
<https://squashfs.org.uk>>
