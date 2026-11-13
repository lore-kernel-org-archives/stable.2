Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794559562;
	b=cleYV9/mHgaTcxI0p5qfL86aat6/5srRbihZ+IJ16ITwZueBDuUBMZYMB5YY7XneAsqZ
	 uRNW9C5yHHoXTIEIBwYfUZt6TAJC16TL21ad2zuHjVeIRLNbxmTlkm8iNNm0laaI6Fn7W
	 7+6E/P6LaU6Bh70icTwBMQed/mBQibJWEC/yVshPuVgdmDM40mu14i2+AWy2stYCsp7YR
	 QBCpQ8LBJTsBZR8DniOhUdgdm8TLqF6LpCIGjJlOp8JgJO3bH3FKWe2umd3dz+YyJADT5
	 Qq/vjH6MDfbE6P+KuKgD6Y+A2NSwPNB/idu4ZzbW2YyNGpanAMHeMk9mjIQj+W9pMQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794559562;
	h=DMARC-Filter:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=+uM+ZJu79iI/GTnBz7rZQfjffm0TQRskgZytweI8nI8=;
	b=qNqIWZ9F/9TI6phxqeIqljIonjY/t1XVzvSvjFwAl54SQNsaArUHuNqBXrGcp59oQ4CO
	 /hgYdcPs2CK0yAykawe82t9RxoLch/vg+QTOpchwBZNGYhbQkFAi7bUlSn95X+WJr1aQe
	 nBrp6YRO1DOd//Ki+spZP71dn/7GW2kE46lweEIkxaq+khBnRUfQJxnWp1iRqyJ7huopG
	 U9t6bW2zyF+Fe7CEB7nJ7cRC/06RC6gVgjd1ChEteBRjV9TKpDMEafASuSSRa/p2Jwull
	 YeZfnPQRKUU6qjwaDdq4rLgLECS87YksE4jS6zHGPOGNoCj9hxI3zNBybanEcty8uvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=KW1FINwp;
	arc=none smtp.remote-ip=220.197.31.4
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD941606A321;
	Fri, 13 Nov 2026 08:46:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD941606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=KW1FINwp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=+uM+ZJu79iI/GTnBz7rZQfjffm0TQRskgZytweI8nI8=;
	b=KW1FINwpzed/XI8006sAlC6zQtBeRL+G16OYeQQfHbd39a6W1zJ8hIJ2/szfh3
	wKryEDG1T9LmSJMBXWzAff09xS8mPPA8vxOkVzBImS6Gu//DhOzzvqhDipeZq8RZ
	rMWOgZybUytPUjZsDjwrRjvTtgStR1WZhTOZ4Z2sxnkT8=
Message-ID: <6e7fd20e-918a-49cd-9634-78fc01249825@163.com>
Date: Fri, 13 Nov 2026 16:45:25 +0800
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
Subject: Re: [PATCH 1/2] exfat: fix iomap mapping when writeback races with
 truncate
To: Youling Tang <youling.tang@linux.dev>, Namjae Jeon
 <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>
Cc: Yuezhang Mo <yuezhang.mo@sony.com>, exfat@lists.linux.dev,
 linux-kernel@vger.kernel.org, Youling Tang <tangyouling@kylinos.cn>,
 stable@vger.kernel.org
References: <20261113080658.2440516-1-youling.tang@linux.dev>
 <20261113080658.2440516-2-youling.tang@linux.dev>
From: Chi Zhiling <chizhiling@163.com>
In-Reply-To: <20261113080658.2440516-2-youling.tang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3v74lzvZqbKqMGw--.46913S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFWfAFykZFyxCFWkZw43ZFb_yoW8CFW8pr
	Z8K3WrKF43Xa47uF4rWrs8Zw1Fv3Z7KF1UXw4F93y5u34DtF1SkF9F9Fy5u3W3Jw4kCF40
	qFZ5Kr17WwnrCFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Us18PUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC+AYVsmr2ziZguAAA31

On 11/13/26 4:06 PM, Youling Tang wrote:
> From: Youling Tang <tangyouling@kylinos.cn>
> 
> __exfat_iomap_begin() reads i_size twice: once to detect a range that
> starts beyond EOF, and once to clamp the mapping to EOF.  A concurrent
> truncate can shrink i_size between the two reads, so the clamp can
> produce a negative length.  The unsigned cluster index subtraction then
> underflows, making exfat_map_cluster() believe it has to allocate a huge
> number of clusters and report a hole.
> 
> Fix this by reading i_size once for both the EOF check and the
> block-aligned clamp.
> 
> Fixes: 82a81a7352bc ("exfat: add iomap buffered I/O support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Youling Tang <tangyouling@kylinos.cn>

Looks good to me:

Reviewed-by: Chi Zhiling <chizhiling@kylinos.cn>

> ---
>   fs/exfat/iomap.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/exfat/iomap.c b/fs/exfat/iomap.c
> index 4e6f3ed9dcc8..11823591b3a8 100644
> --- a/fs/exfat/iomap.c
> +++ b/fs/exfat/iomap.c
> @@ -51,8 +51,10 @@ static int __exfat_iomap_begin(struct inode *inode, loff_t offset, loff_t length
>   	bool balloc = false;
>   
>   	if (!may_alloc) {
> +		loff_t isize = i_size_read(inode);
> +
>   		/* Completely beyond EOF. Treat as hole */
> -		if (i_size_read(inode) <= offset) {
> +		if (offset >= isize) {
>   			iomap->type = IOMAP_HOLE;
>   			iomap->addr = IOMAP_NULL_ADDR;
>   			iomap->offset = offset;
> @@ -61,9 +63,8 @@ static int __exfat_iomap_begin(struct inode *inode, loff_t offset, loff_t length
>   		}
>   
>   		/* Clamp length if the requested range goes beyond i_size */
> -		if (offset + length > i_size_read(inode))
> -			length = round_up(i_size_read(inode),
> -					  i_blocksize(inode)) - offset;
> +		if (offset + length > isize)
> +			length = round_up(isize, i_blocksize(inode)) - offset;
>   	}
>   
>   	num_clusters = exfat_bytes_to_cluster_round_up(sbi,

