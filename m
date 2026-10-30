Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.220
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793343018;
	b=kvXThNHbt7WJ+PqQwZWLaiTmA36f4X52aLSUNU8exs2iPR6AJj5/lIZ/7q6eHIQSx9Ze
	 CIg6XlkP8Om6rSjf2q78ZDVVE6BCOj9zUzOPBAXvhvNn9d8k9tRr7GMz95kBtHvXuc+JF
	 3iwNir9YLDLRNO6wXE/ySX+kpCwwRz+le1ncdQmqbQj1ReGqhHFV4X14buP4Pc+Puy9uK
	 KOiW4bzUEe2VnMIyfmkJT5qOlFe+7/k45aj4+ETai9rar6duB7QBVx6p0uo4Vj4H2uepZ
	 UyhNZ4myeH556HTNROIp16iC42MuSMJLgsMFNhiAvX9+zeDEDxhMof6UnV//FtgTUZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793343018;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Subject:To:CC:
	 References:From:Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=r1/R+aZcqsYR+3DPQv8/Fhe+b8fa/vAMKub/kpo2HNQ=;
	b=BFxuFyVPiBXDuJmK20UQshRLP6lfAZ1wF2/5xGb7GM1SNUT4iL59XpH48nO+vaopgIVm
	 MWjbqIEJfnn63Zz9ScNEPdHIWozWT+DVY4Zi5xqg84Ul1OFx54UdxFJ2qCmHEWwltHe7X
	 yTDixTGY+7/WwsnQTwAQqkwj2s9ESjbxO6yT4uR5lPZUwHL/QH5t3jKTbIArLVSuoyyuK
	 OTZuKmvD15Ln6R1edpjEID8THDbbBKKcDp3XEOQdnu/kCVjEJdtcMgtJqb0IV1W3qlvI+
	 sIZul8uqoFkZ5pfHkMHUhU1z9g8fBxYJuiHyMiKNnXLgdYSq7oVxc8jbm8YuHZDxJRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=CSGXn+rz;
	arc=none smtp.remote-ip=113.46.200.220
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05919606A31A;
	Fri, 30 Oct 2026 06:50:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05919606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=CSGXn+rz
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=r1/R+aZcqsYR+3DPQv8/Fhe+b8fa/vAMKub/kpo2HNQ=;
	b=CSGXn+rz75AHSq8H66iRqwFqFsxlO1cc7V+40y26/wPM4aTLtXZ/a/nOMnC1X803HB5tBvv6L
	w/dxJglMohKSf8b7v0L0Q06+wJHdtyPX0GgXIEck9Hw8ORdSz39BPzqii3BzOhd50DHFRXkQ8xF
	DZCFhMG2iaOqI6Oao/v90LA=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4jGBYY5hDCz12LFf;
	Fri, 30 Oct 2026 14:50:09 +0800 (CST)
Received: from whupemo200011.china.huawei.com (unknown [7.152.185.179])
	by mail.maildlp.com (Postfix) with ESMTPS id DF60340538;
	Fri, 30 Oct 2026 14:50:11 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 whupemo200011.china.huawei.com (7.152.185.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 30 Oct 2026 14:50:10 +0800
Subject: Re: [PATCH] ubifs: fix auth node space and padding in journal buffers
To: <shao.mingyin@zte.com.cn>, <richard@nod.at>,
	<linux-mtd@lists.infradead.org>
CC: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <202610301145238169CxodJv5_0n5vd-Vbd4XA@zte.com.cn>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <ab51df45-f763-358b-642c-8efe06f33ffb@huawei.com>
Date: Fri, 30 Oct 2026 14:50:10 +0800
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
In-Reply-To: <202610301145238169CxodJv5_0n5vd-Vbd4XA@zte.com.cn>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 whupemo200011.china.huawei.com (7.152.185.179)

在 2026/10/30 11:45, shao.mingyin@zte.com.cn 写道:
> From: Shao Mingyin <shao.mingyin@zte.com.cn>
> 
> write_head() appends an authentication node to the node group when
> authentication is enabled and writes
> ALIGN(node_len, 8) + ubifs_auth_node_sz(c) bytes from the buffer.
> ubifs_jnl_write_data() allocates its buffer for that, but when the
> allocation fails it falls back to c->write_reserve_buf.  That buffer is
> sized for a data node only (COMPRESSED_DATA_NODE_BUF_SZ plus the cipher
> block, 4144/4160 bytes), while an incompressible 4 KiB block needs
> 4144/4160 bytes plus the auth node (24 + the HMAC length, 56 bytes with
> sha256).  ubifs_hash_nodes() then writes the auth node past the end of
> the reserve buffer, and write_head() reads it back from there.
> 
> The same write path also leaks uninitialized heap data.
> ubifs_jnl_write_data(), ubifs_jnl_write_inode() and
> ubifs_jnl_truncate() build their node groups in kmalloc()ed buffers, and
> when the last node length is not a multiple of 8 the padding up to the
> next auth node is written to the flash.  That padding is covered neither
> by the node CRC nor by the rolling hash.
> 
> Size the reserve buffer for the largest possible auth node (the mount
> path allocates it before authentication is initialized, so it cannot use
> ubifs_auth_node_sz()) and zero the padding after the last node of each
> group before it is written.  The padding is not part of any node, so
> ch.len and the CRCs stay unchanged.
> 
> Fixes: 6a98bc4614de ("ubifs: Add authentication nodes to journal")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
> ---
> diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
> index 40a95a2fad50..38fb59225f27 100644
> --- a/fs/ubifs/journal.c
> +++ b/fs/ubifs/journal.c
> @@ -840,6 +840,24 @@ int ubifs_jnl_update(struct ubifs_info *c, const struct inode *dir,
>   	return err;
>   }
> 
> +/**
> + * ubifs_zero_node_pad - zero the padding after the last node of a group
> + * @c: UBIFS file-system description object
> + * @node: last node of the group
> + * @len: length of the node
> + *
> + * When authentication is enabled the auth node is placed at the next
> + * 8-byte aligned offset, so the bytes between the end of the last node
> + * and that offset are written to the media.  They are covered neither
> + * by the node CRC nor by the rolling hash, so clear them instead of
> + * writing stale heap contents.
> + */
> +static void ubifs_zero_node_pad(const struct ubifs_info *c, void *node, int len)
> +{
> +	if (ubifs_authenticated(c))
> +		memset((char *)node + len, 0, ALIGN(len, 8) - len);
> +}
> +
>   /**
>    * ubifs_jnl_write_data - write a data node to the journal.
>    * @c: UBIFS file-system description object
> @@ -925,6 +943,7 @@ int ubifs_jnl_write_data(struct ubifs_info *c, const struct inode *inode,
>   	if (err)
>   		goto out_free;
> 
> +	ubifs_zero_node_pad(c, data, dlen);
>   	ubifs_prepare_node(c, data, dlen, 0);
>   	err = write_head(c, DATAHD, data, write_len, &lnum, &offs, 0);
>   	if (err)
Hi Mingyin,
Since ubifs_jnl_write_data() could use c->write_reserve_buf, we can keep 
the modification in ubifs_jnl_write_data(). I suggest that replace 
kmalloc with kzalloc in ubifs_jnl_write_inode() and 
ubifs_jnl_truncate(), and remove zero_trun_node_unused from 
ubifs_jnl_truncate().
> @@ -1062,6 +1081,7 @@ int ubifs_jnl_write_inode(struct ubifs_info *c, const struct inode *inode)
>   	}
> 
>   	pack_inode(c, ino, inode, 1);
> +	ubifs_zero_node_pad(c, ino, ilen);
>   	err = ubifs_node_calc_hash(c, ino, hash);
>   	if (err)
>   		goto out_release;
> @@ -1781,6 +1801,7 @@ int ubifs_jnl_truncate(struct ubifs_info *c, const struct inode *inode,
>   	ubifs_prep_grp_node(c, trun, UBIFS_TRUN_NODE_SZ, dlen ? 0 : 1);
>   	if (dlen) {
>   		ubifs_prep_grp_node(c, dn, dlen, 1);
> +		ubifs_zero_node_pad(c, dn, dlen);
>   		err = ubifs_node_calc_hash(c, dn, hash_dn);
>   		if (err)
>   			goto out_release;
> diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
> index 38972786817e..538907aba8a0 100644
> --- a/fs/ubifs/super.c
> +++ b/fs/ubifs/super.c
> @@ -1263,8 +1263,16 @@ static int mount_ubifs(struct ubifs_info *c)
>   		bu_init(c);
> 
>   	if (!c->ro_mount) {
> -		c->write_reserve_buf = kmalloc(COMPRESSED_DATA_NODE_BUF_SZ + \
> -					       UBIFS_CIPHER_BLOCK_SIZE,
> +		/*
> +		 * The reserve buffer is also used as a fallback for data
> +		 * nodes which are followed by an authentication node, so
> +		 * reserve room for the largest possible one.  Authentication
> +		 * is initialized only later, hence the maximum sizes.
> +		 */
> +		c->write_reserve_buf = kmalloc(COMPRESSED_DATA_NODE_BUF_SZ +
> +					       UBIFS_CIPHER_BLOCK_SIZE +
> +					       UBIFS_AUTH_NODE_SZ +
> +					       UBIFS_MAX_HMAC_LEN,
>   					       GFP_KERNEL);
>   		if (!c->write_reserve_buf)
>   			goto out_free;
> @@ -1723,8 +1731,10 @@ static int ubifs_remount_rw(struct ubifs_info *c)
>   		goto out;
>   	}
> 
> -	c->write_reserve_buf = kmalloc(COMPRESSED_DATA_NODE_BUF_SZ + \
> -				       UBIFS_CIPHER_BLOCK_SIZE, GFP_KERNEL);
> +	c->write_reserve_buf = kmalloc(COMPRESSED_DATA_NODE_BUF_SZ +
> +				       UBIFS_CIPHER_BLOCK_SIZE +
> +				       UBIFS_AUTH_NODE_SZ +
> +				       UBIFS_MAX_HMAC_LEN, GFP_KERNEL);
>   	if (!c->write_reserve_buf) {
>   		err = -ENOMEM;
>   		goto out;
> .
> 

