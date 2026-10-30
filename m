Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.217
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793335475;
	b=M+krzmjLiQmTmycgRDtwJSEn3wfyUPNbFJ3R+C5dzE4AiniUhvnJviqY7q/awH201i2l
	 7/xApm9/pRiKNbMSzzQiCGo0SID8ravzVVYMUdWUdRCzKrfR5uwaCzRi6+3vuftU0Yu7n
	 1YNcpN9R9I1guAjUiK3qgDC1nl32f8nyeYIhwms/HvjZ5v2UGClke8GgDVFgB7ZhwXAQZ
	 YFnpV9DOyMZrZhRqLpZbYGymiRd3oWlOVyWXtjerkIxPnf4/nQv53YSmmwo4Q3sITJZI9
	 0pf5Pua4/Jeqfqwj5L6yM8lY+mSSJB6UH+SzQG2d4S5mHg6CXa9CxqOa3eU7ddiHxMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793335475;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Subject:To:CC:
	 References:From:Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=GbNaL4M3tcHsdzF76BY+M5ZcMEBVt6cRuMm5Kwdf22Y=;
	b=VGQrWe9tc1M1dxn8e9kWSw/fZaWC5hidlytO7lKBUTjbiFl+UC55/pmsXI3wqF/7ToWe
	 1WTlfjiP+ZT38L13d5qmAMHqnZK52Xb48png2Wn0GRxyr5ctCl5AfMlcVSQA6n2EaaqZ7
	 2Lyr4XbAQLFuqhtiunEUDJa77stsESTAJ+EJ0xv5fkxim9B041lbT6zgy8SLWpH15B29L
	 RGCQSrFteNYWxbGeTUWG37jfJCiOjsuOLpsVbnnIA71qgI6IujWghgLNEXV7s7x4IDnFL
	 GUn94bq4vE5UxO38NpTSgMH/5OmQkbdQnzbgTw2fcbl1RZc6prIJpu7CJiIaiFb2c0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=5zhKz4Of;
	arc=none smtp.remote-ip=113.46.200.217
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98FE606A31A;
	Fri, 30 Oct 2026 04:44:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D98FE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=5zhKz4Of
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=GbNaL4M3tcHsdzF76BY+M5ZcMEBVt6cRuMm5Kwdf22Y=;
	b=5zhKz4OfT43LZvYaHIoNTFAf1MPjJg+7tR4HWVY8EHoVhzmOlFMVq4+yP7+FEWzYxHcJCHrDm
	ZqgFF3exSdDyWhAWwWRT4nHtKAIgATCNdDhveHYvvrQxHtHl3gNjxgxXiRkQ8wjYwPlu+BvAaa9
	XGz2jvH+yjQbyQwoF+EtwNk=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4jG7mF3N6JzcZyh;
	Fri, 30 Oct 2026 12:44:13 +0800 (CST)
Received: from whupemo200011.china.huawei.com (unknown [7.152.185.179])
	by mail.maildlp.com (Postfix) with ESMTPS id 9F5B740579;
	Fri, 30 Oct 2026 12:44:30 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 whupemo200011.china.huawei.com (7.152.185.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 30 Oct 2026 12:44:29 +0800
Subject: Re: [PATCH] ubifs: propagate ubifs_shash_copy_state() errors
To: <shao.mingyin@zte.com.cn>, <richard@nod.at>,
	<linux-mtd@lists.infradead.org>
CC: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20261030114406371EZw_orIqSRlCTxnz_L39Z@zte.com.cn>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <4bdb09dd-bbaf-111f-adb6-4d9970ebedcc@huawei.com>
Date: Fri, 30 Oct 2026 12:44:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261030114406371EZw_orIqSRlCTxnz_L39Z@zte.com.cn>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 whupemo200011.china.huawei.com (7.152.185.179)

在 2026/10/30 11:44, shao.mingyin@zte.com.cn 写道:
> From: Shao Mingyin <shao.mingyin@zte.com.cn>
> 
> ubifs_shash_copy_state() duplicates the rolling hash state with
> crypto_shash_export() and crypto_shash_import().  The export buffer is
> allocated with kmalloc(), so the function can fail with -ENOMEM, and
> crypto_shash_import() can fail as well.
> 
> Five callers ignore the return value.  The target descriptor then has no
> valid state, and the crypto_shash_final() that follows computes a digest
> from uninitialized data.  When preparing an auth node this stores a
> wrong HMAC on the media, so the affected journal head no longer
> authenticates after a remount.  During replay it makes the verification
> of a valid image fail with -EPERM, and in replay_bud() and
> add_replay_bud() it leaves the replay hash state inconsistent with the
> media, which corrupts the auth nodes written by later commits.
> 
> Check the error at all five call sites and propagate it.  In
> add_replay_bud() the descriptor belongs to the new bud, so free it on
> the added error path.
> 
> Fixes: 6a98bc4614de ("ubifs: Add authentication nodes to journal")
> Fixes: da8ef65f9573 ("ubifs: Authenticate replayed journal")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
> ---

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
> diff --git a/fs/ubifs/auth.c b/fs/ubifs/auth.c
> index 1f770795ee70..62dfacfb6d6b 100644
> --- a/fs/ubifs/auth.c
> +++ b/fs/ubifs/auth.c
> @@ -70,7 +70,10 @@ int ubifs_prepare_auth_node(struct ubifs_info *c, void *node,
>   		SHASH_DESC_ON_STACK(hash_desc, c->hash_tfm);
> 
>   		hash_desc->tfm = c->hash_tfm;
> -		ubifs_shash_copy_state(c, inhash, hash_desc);
> +
> +		err = ubifs_shash_copy_state(c, inhash, hash_desc);
> +		if (err)
> +			return err;
> 
>   		err = crypto_shash_final(hash_desc, hash);
>   		if (err)
> diff --git a/fs/ubifs/log.c b/fs/ubifs/log.c
> index c6edcbf35ebc..42cadf558a4f 100644
> --- a/fs/ubifs/log.c
> +++ b/fs/ubifs/log.c
> @@ -412,7 +412,11 @@ int ubifs_log_start_commit(struct ubifs_info *c, int *ltail_lnum)
>   					 UBIFS_REF_NODE_SZ);
>   		if (err)
>   			goto out;
> -		ubifs_shash_copy_state(c, c->log_hash, c->jheads[i].log_hash);
> +
> +		err = ubifs_shash_copy_state(c, c->log_hash,
> +					     c->jheads[i].log_hash);
> +		if (err)
> +			goto out;
>   	}
> 
>   	ubifs_pad(c, buf + len, ALIGN(len, c->min_io_size) - len);
> diff --git a/fs/ubifs/replay.c b/fs/ubifs/replay.c
> index 263045e05cf1..0b82c67a2dcc 100644
> --- a/fs/ubifs/replay.c
> +++ b/fs/ubifs/replay.c
> @@ -566,10 +566,14 @@ authenticate_sleb_hash(struct ubifs_info *c,
>   		       struct shash_desc *log_hash, u8 *hash)
>   {
>   	SHASH_DESC_ON_STACK(hash_desc, c->hash_tfm);
> +	int err;
> 
>   	hash_desc->tfm = c->hash_tfm;
> 
> -	ubifs_shash_copy_state(c, log_hash, hash_desc);
> +	err = ubifs_shash_copy_state(c, log_hash, hash_desc);
> +	if (err)
> +		return err;
> +
>   	return crypto_shash_final(hash_desc, hash);
>   }
> 
> @@ -694,8 +698,10 @@ static int replay_bud(struct ubifs_info *c, struct bud_entry *b)
>   		goto out;
>   	}
> 
> -	ubifs_shash_copy_state(c, b->bud->log_hash,
> -			       c->jheads[b->bud->jhead].log_hash);
> +	err = ubifs_shash_copy_state(c, b->bud->log_hash,
> +				     c->jheads[b->bud->jhead].log_hash);
> +	if (err)
> +		goto out;
> 
>   	/*
>   	 * The bud does not have to start from offset zero - the beginning of
> @@ -915,7 +921,9 @@ static int add_replay_bud(struct ubifs_info *c, int lnum, int offs, int jhead,
>   		goto out;
>   	}
> 
> -	ubifs_shash_copy_state(c, c->log_hash, bud->log_hash);
> +	err = ubifs_shash_copy_state(c, c->log_hash, bud->log_hash);
> +	if (err)
> +		goto out_free_log_hash;
> 
>   	ubifs_add_bud(c, bud);
> 
> @@ -924,6 +932,8 @@ static int add_replay_bud(struct ubifs_info *c, int lnum, int offs, int jhead,
>   	list_add_tail(&b->list, &c->replay_buds);
> 
>   	return 0;
> +out_free_log_hash:
> +	kfree(bud->log_hash);
>   out:
>   	kfree(bud);
>   	kfree(b);
> .
> 

