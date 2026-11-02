Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.222
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793626912;
	b=cUPJsXReuL8C6ltJI+Idi36/kQf8od1n9TabyhtI6ZpdH0Li6qhzHXnNhNXJjdb6iyNY
	 cZh5oKSEv2URAbKAXwVr4mJY063tjWtwka5sbto3NbKjQfE1TaLcJSUvOGdNE/IhGqGrN
	 4SI0F8sS3OoEO0ZnyZK4nTrC8P48Si03LUc3FiKdp5Wk3atWeoshlf0qbXr5FnL+aYGSY
	 h/8dnfuWQcoTU7Yr/jLuePRtOFxohD5ZAOlign96f6464U6XuZ5oKZdTicl45TSoNHeqi
	 5g91qGX2BLZkSCytIftksS15S07EUbEQ2jSSsWjyh/E0Vgcx29UpcZjB7v5QbwzPabA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793626912;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Subject:To:CC:
	 References:From:Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=fNLxPmfF5iOP6VBGiv9ly7jRrpfCi96AxdL2bHwH7mI=;
	b=MXaY+jmDEptvCNI+llMd5yqfOD6mjmF8kEyOTdfFGBOcrb97YTHLG4P3SCANOFOu8Ngj
	 Jjk7uETXVFcQOrRBUjHw64bSwVQ4edz7KBLSxt6Bf3wQ8S/iJahaVcs8UAAVQJusxk420
	 XX1aCBwXxv9pcj/AbcEyBBa5Wq8z9p5Kpe8sTzhNl24KAcAoLgoXAFVCoARpvePbwPgYt
	 8X723BluckIoAHqM/rnbtpK8bIm0W2RRA6D8y2k3VJGQVPSuMUFP2ogmMoZbBNeuhQniw
	 +UZ7HjtyAnKfvfL/YzJ2bThxjmQsC5Yrg1IZOVajRxdmrc5oL39zo8TyMH86FRt5fdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=TwyyYEyO;
	arc=none smtp.remote-ip=113.46.200.222
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C55F606A33C;
	Mon,  2 Nov 2026 13:41:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C55F606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=TwyyYEyO
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=fNLxPmfF5iOP6VBGiv9ly7jRrpfCi96AxdL2bHwH7mI=;
	b=TwyyYEyOEN3aUj1kjI1mjCxe1ezOva1vhveshpKccqj8miwYXnmodIuQTuN+RX4WAJFSOm2xW
	PTJ16NBPd1V0cMYeIdBYkXYmNVx8JM3aoZ//UKCZDufgBnRWY4lrjfpgw9C/fH0OVfVllWBikbP
	hHOsJs1hE2S95pH0wjHQd+w=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4jJCXw00MvzLlTq;
	Mon,  2 Nov 2026 21:41:35 +0800 (CST)
Received: from whupemo200011.china.huawei.com (unknown [7.152.185.179])
	by mail.maildlp.com (Postfix) with ESMTPS id AACF440572;
	Mon,  2 Nov 2026 21:41:45 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 whupemo200011.china.huawei.com (7.152.185.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 2 Nov 2026 21:41:44 +0800
Subject: Re: [PATCH 3/3] ubifs: check node hash calculation errors
To: <shao.mingyin@zte.com.cn>, <richard@nod.at>,
	<linux-mtd@lists.infradead.org>
CC: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <202611022014201140sh13oFtWkIgBr7UQKyMK@zte.com.cn>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <2bf579ac-cc55-b88a-3ce5-9214d8434909@huawei.com>
Date: Mon, 2 Nov 2026 21:41:43 +0800
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
In-Reply-To: <202611022014201140sh13oFtWkIgBr7UQKyMK@zte.com.cn>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 whupemo200011.china.huawei.com (7.152.185.179)

在 2026/11/2 20:14, shao.mingyin@zte.com.cn 写道:
> ubifs_node_calc_hash() can fail when authentication is enabled and the
> crypto operation fails.  Five calls ignore the return value and use the
> uninitialized stack buffer as the node hash: replay_bud() stores it in
> the replay entry, make_idx_node() and write_index() copy it into the
> parent branch or the index root, and create_default_filesystem() copies
> it into an index branch and into the master node.  Verifying those nodes
> later then fails with a hash mismatch.
> 
> Propagate the error from all five call sites.
> 
> Fixes: 16a26b20d2af ("ubifs: authentication: Add hashes to index nodes")
> Fixes: 104115a3eb54 ("ubifs: Add hashes and HMACs to default filesystem")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
> ---
> diff --git a/fs/ubifs/replay.c b/fs/ubifs/replay.c
> index 263045e05cf1..442493dc18c6 100644
> --- a/fs/ubifs/replay.c
> +++ b/fs/ubifs/replay.c
> @@ -730,7 +730,9 @@ static int replay_bud(struct ubifs_info *c, struct bud_entry *b)
>   			goto out_dump;
>   		}
> 
> -		ubifs_node_calc_hash(c, snod->node, hash);
> +		err = ubifs_node_calc_hash(c, snod->node, hash);
> +		if (err)
> +			goto out;
> 
>   		if (snod->sqnum > c->max_sqnum)
>   			c->max_sqnum = snod->sqnum;
> diff --git a/fs/ubifs/sb.c b/fs/ubifs/sb.c
> index e7693b94e5b5..1c176be261e0 100644
> --- a/fs/ubifs/sb.c
> +++ b/fs/ubifs/sb.c
> @@ -329,14 +329,18 @@ static int create_default_filesystem(struct ubifs_info *c)
>   	if (err)
>   		goto out;
> 
> -	ubifs_node_calc_hash(c, ino, hash);
> +	err = ubifs_node_calc_hash(c, ino, hash);
> +	if (err)
> +		goto out;
>   	ubifs_copy_hash(c, hash, ubifs_branch_hash(c, br));
> 
>   	err = ubifs_write_node(c, idx, idx_node_size, main_first + DEFAULT_IDX_LEB, 0);
>   	if (err)
>   		goto out;
> 
> -	ubifs_node_calc_hash(c, idx, hash);
> +	err = ubifs_node_calc_hash(c, idx, hash);
> +	if (err)
> +		goto out;
>   	ubifs_copy_hash(c, hash, mst->hash_root_idx);
> 
>   	err = ubifs_write_node_hmac(c, mst, UBIFS_MST_NODE_SZ, UBIFS_MST_LNUM, 0,
> diff --git a/fs/ubifs/tnc_commit.c b/fs/ubifs/tnc_commit.c
> index 7bf2672062a2..1a62739c3731 100644
> --- a/fs/ubifs/tnc_commit.c
> +++ b/fs/ubifs/tnc_commit.c
> @@ -52,7 +52,9 @@ static int make_idx_node(struct ubifs_info *c, struct ubifs_idx_node *idx,
>   		}
>   	}
>   	ubifs_prepare_node(c, idx, len, 0);
> -	ubifs_node_calc_hash(c, idx, hash);
> +	err = ubifs_node_calc_hash(c, idx, hash);
> +	if (err)
> +		return err;
> 
>   	znode->lnum = lnum;
>   	znode->offs = offs;
> @@ -887,7 +889,9 @@ static int write_index(struct ubifs_info *c)
>   		}
>   		len = ubifs_idx_node_sz(c, znode->child_cnt);
>   		ubifs_prepare_node(c, idx, len, 0);
> -		ubifs_node_calc_hash(c, idx, hash);
> +		err = ubifs_node_calc_hash(c, idx, hash);
> +		if (err)
> +			return err;
> 
>   		mutex_lock(&c->tnc_mutex);
> .
> 

