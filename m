Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.219
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793626234;
	b=dpIMggjsPskfQ9HCtK7dtRHD87+C1hrIAcnDv0uigumR3fpOaM+GiRFrB7/2y+LNDjU9
	 dTWDrzetzsUYW57SnodBqe5nvEXAlUsING0uUMubUJkjnmKaF7B9AUJDkMGk0wWxR2vhi
	 lXirEI0vW4aeLjUWwDSgioQYzT4eURByy7UseOxdQGyqIp8KNvkJCgjRDLWbWJAASReha
	 SH5492xWK+I1fOxqe+DJvHEater5+efln2lZ9qjRt+CpNG4TvSCpWhOXK7GDk5eyGLexE
	 9ASavlm9sE5r2ul536xd6zlOOdkhYRLv6qaSJSihIrnmpJmC04YW2rXOmj/SCi3/aRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793626234;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Subject:To:
	 References:From:Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=gAsl0/fGRzxImhBpxQUProJyIEV9RDm2i+P8L5BSV2A=;
	b=RP+q52i2h1J6aIqhiT+UiATCAJ5Gfxg2bldK7VMV/PVXOrmN3x/u6CmH3iO6gTFRpq/S
	 oZympdeNLdpqgJsFzXVs6Agqzx9KjDx/pHPvi4lRBLQL/nN7jmNJXRPpZGcAbhT4U3EwE
	 HTxckjUy+gZTemtsnSGs7tFVb4QJQdj2hbazv4tuiIOPGCtmDOovFLe3sTZ4U/+FQD6gu
	 vqyBWuKRqnx3xcUVyYRxidLCWwT7o3zLzfSY9wpfWgh9Y00JvwVqGFBx+ViHDDjVDzC4p
	 /g40XMKjj4n+PZ8Xamq09d2Jo+u++I+bI1tJBduMet/4t0NPvfDiiATInJkWpstRJxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=2fQLstKm;
	arc=none smtp.remote-ip=113.46.200.219
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14838606A326;
	Mon,  2 Nov 2026 13:30:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14838606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=2fQLstKm
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=gAsl0/fGRzxImhBpxQUProJyIEV9RDm2i+P8L5BSV2A=;
	b=2fQLstKmie1QZ2aSm8oKoxqw0FKScCiHUPxNLjnQr1MnbdsrYb6qWfZfKAemcKrJVVliqn4Y6
	cny4EEWiz9UJIto/JDCnEoOY6M+yi4ASxbYTqbOaDWWMuK9Aw5s2/yCa0+/DC68JVaGwM17faht
	wdHLx4V/vVqPrb8Uz6LBk0I=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4jJCJ05DCRz1prQQ;
	Mon,  2 Nov 2026 21:30:24 +0800 (CST)
Received: from whupemo200011.china.huawei.com (unknown [7.152.185.179])
	by mail.maildlp.com (Postfix) with ESMTPS id 3C2DF203C8;
	Mon,  2 Nov 2026 21:30:28 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 whupemo200011.china.huawei.com (7.152.185.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 2 Nov 2026 21:30:26 +0800
Subject: Re: [PATCH 1/3] ubifs: gc: fix authentication node leak
To: <shao.mingyin@zte.com.cn>, <richard@nod.at>,
	<linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <20261102195052961juHOv3LqlGtcYgvGv708m@zte.com.cn>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <ee613d53-5275-64dc-716b-a87880f7d6e6@huawei.com>
Date: Mon, 2 Nov 2026 21:30:26 +0800
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
In-Reply-To: <20261102195052961juHOv3LqlGtcYgvGv708m@zte.com.cn>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 whupemo200011.china.huawei.com (7.152.185.179)

在 2026/11/2 19:50, shao.mingyin@zte.com.cn 写道:
> move_nodes() allocates the authentication node, writes it to the GC
> write-buffer and only frees it on the error paths.  Every GC pass that
> moves nodes on an authenticated file system therefore leaks
> ubifs_auth_node_sz() bytes.
> 
> Free the buffer after it has been written to the write-buffer.
> 
> Fixes: 6f06d96fdf62 ("ubifs: Add auth nodes to garbage collector journal head")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
> ---
> diff --git a/fs/ubifs/gc.c b/fs/ubifs/gc.c
> index 933c79b5cd6b..2b0f29423f48 100644
> --- a/fs/ubifs/gc.c
> +++ b/fs/ubifs/gc.c
> @@ -427,6 +427,7 @@ static int move_nodes(struct ubifs_info *c, struct ubifs_scan_leb *sleb)
>   				kfree(auth);
>   				goto out;
>   			}
> +			kfree(auth);
>   
>   			ubifs_add_dirt(c, wbuf->lnum, ubifs_auth_node_sz(c));
>   		}
> .
> 

