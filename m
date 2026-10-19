Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B5F3264F5;
	Mon, 19 Oct 2026 01:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792372514; cv=none; b=nDpH6Cnaqy8cZB0L745g/NnQ5rZ7nXDbKTBoJkSF48t9tXSLy3fCjQStFW2VY16DSiuid4FAN1O71KbVJS0ZpDn+D+w/iFWw6y28QUK6LdZkkGpMxLUzvdqF9eZq1+Dqq89Iaxc4j5sFjJRWgj4aAFbnhru4TNI/nUK3tY79D+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792372514; c=relaxed/simple;
	bh=gFUH0hUEQAuvKc755yM2YuSpEPoTTMXzBkRPVTBcQts=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=GKVfeizYHWgB0Kovg3t7t469PoY4JcRUfBozGDF4923fm3XFkqFYDqb2IWZr42oYjH6lkcb9y2bS7HLQ/9rza2v8WBUiLB7ap9SSxiJlL071eoZgjpcNk43AZbz58CkSYD8T7mby2nqSvCguCsVOhuJkk1dujUpMppMqUYLszvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=d9BZw3EE; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="d9BZw3EE"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=V7FqMxsUcKwN0UwLr5HSM14+Ny3a42v8ifOoh1UDt2k=;
	b=d9BZw3EE8n8oabxVe7b56ypiueA58tefns0jCYfa4V4ONVtHBPbUCp6jaLVn2fWZpyV5PT6cG
	Ok9nw2ORQpXgdc64+9RYYEKv6AUr5HD17Y1kAbAasRvi0PSW4kRbczdSOtVxltFH7ZGeVVy1UI6
	Kmd8NHkzWEuT20eiyMFj1aE=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4j7Hdr5gmdznTb2;
	Mon, 19 Oct 2026 09:14:56 +0800 (CST)
Received: from whupemo200011.china.huawei.com (unknown [7.152.185.179])
	by mail.maildlp.com (Postfix) with ESMTPS id 73A7040580;
	Mon, 19 Oct 2026 09:14:56 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 whupemo200011.china.huawei.com (7.152.185.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 19 Oct 2026 09:14:54 +0800
Subject: Re: [PATCH] mtd: phram: fix name leak when phram_setup() fails
To: Palla Raghunath <raghunathpalla.0209@gmail.com>, <joern@lazybastard.org>,
	<miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<shuah@kernel.org>, <me@brighamcampbell.com>,
	<linux-kernel-mentees@lists.linux.dev>, <stable@vger.kernel.org>,
	<syzbot+c9d8bc9f8ccc03799e1f@syzkaller.appspotmail.com>
References: <20261017235733.14667-1-raghunathpalla.0209@gmail.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <577933c6-f1b5-0a45-1cf6-0c5607c6d382@huawei.com>
Date: Mon, 19 Oct 2026 09:14:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261017235733.14667-1-raghunathpalla.0209@gmail.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 whupemo200011.china.huawei.com (7.152.185.179)

ÔÚ 2026/10/18 7:57, Palla Raghunath Ð´µÀ:
> parse_err() is a macro that prints the message and then does "return 1".
> phram_setup() still uses it after parse_name() has allocated the device
> name, with a "goto error" right after each call. That goto is never
> reached, so the kfree(name) under the error label never runs and the
> name leaks every time one of these checks fails.
> 
> syzbot hit this by writing "p0,0x8000000000000000,0" to
> /sys/module/phram/parameters/phram. The zero length fails the
> erasesize/len check and the "p0" string is leaked.
> 
> Use pr_err() for these five messages so we really jump to the error
> label and free the name. This also means the real error code goes back
> to the caller instead of 1, which sysfs returned to userspace as if one
> byte had been written.
> 
> Fixes: 49c64df88057 ("mtd: phram: fix a double free issue in error path")
> Cc: stable@vger.kernel.org
> Reported-by: syzbot+c9d8bc9f8ccc03799e1f@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=c9d8bc9f8ccc03799e1f
> Signed-off-by: Palla Raghunath <raghunathpalla.0209@gmail.com>
> ---
>   drivers/mtd/devices/phram.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
> 
> diff --git a/drivers/mtd/devices/phram.c b/drivers/mtd/devices/phram.c
> index b42cadcd76b1..7aed57b31967 100644
> --- a/drivers/mtd/devices/phram.c
> +++ b/drivers/mtd/devices/phram.c
> @@ -289,34 +289,34 @@ static int phram_setup(const char *val)
>   
>   	ret = parse_num64(&start, token[1]);
>   	if (ret) {
> -		parse_err("illegal start address\n");
> +		pr_err("illegal start address\n");
>   		goto error;
>   	}
>   
>   	ret = parse_num64(&len, token[2]);
>   	if (ret) {
> -		parse_err("illegal device length\n");
> +		pr_err("illegal device length\n");
>   		goto error;
>   	}
>   
>   	if (token[3]) {
>   		ret = parse_num64(&erasesize, token[3]);
>   		if (ret) {
> -			parse_err("illegal erasesize\n");
> +			pr_err("illegal erasesize\n");
>   			goto error;
>   		}
>   	}
>   
>   	if (len == 0 || erasesize == 0 || erasesize > len
>   	    || erasesize > UINT_MAX) {
> -		parse_err("illegal erasesize or len\n");
> +		pr_err("illegal erasesize or len\n");
>   		ret = -EINVAL;
>   		goto error;
>   	}
>   
>   	div_u64_rem(len, (uint32_t)erasesize, &rem);
>   	if (rem) {
> -		parse_err("len is not multiple of erasesize\n");
> +		pr_err("len is not multiple of erasesize\n");
>   		ret = -EINVAL;
>   		goto error;
>   	}
> 

