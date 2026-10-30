Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.216
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793353156;
	b=dzzBoQCuScqQJ3J0VT+TbMpiGDXpzVL/wl5fk7PFoOe8SmwnEtp9rrUDJ05VgUbcs+Bs
	 x+6xriUv2TihU9NA4/UMvwzMs0jrypoC1WRFhbfavzjJQmn8qPcr5wKsfYvzg0mhPprQy
	 UHXSlI246TZbouzF0W/npCxK4XvUKFHhLohp6w1HBEiMBMAz1BVnAHQtCq8bf0COYQfF+
	 XOfN7SwMkF7fSZuQBidY7KEICWaxEe9YAmzUsjIML3nHN2kmbCwTShITmZzFJvlbrIYaz
	 HgDfRHjvv8d2XGFj1na0G/X3Dq4jLe/uD1KDvCWetFoezTf5n4N5aEQSPTl/7sYKsZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793353156;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Subject:To:CC:
	 References:From:Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=p2p6dOL2KDWMR3mhYs0uPWdNBKHHcJR5aV59rO4jsGM=;
	b=Wwm7wcYig9oAa+aHFthKWTCiibg+0WJvWzw4kkbgWvwec+/cPdPdgOPS78h8Ym0gqTNb
	 ytM55QblZM3WBd13BYGRATgBdu9UMHi7H48A/GLeo3t+9oNEfDk4nPcvHOblyfFLf2fI+
	 JvMY+Z9zr7NCu/72QSJcjawaYdDJVnQ2+adf8+/pLlLXJudbMy+T3IV9CEq+XbyJPtD2O
	 frieq/lwrOvhK1RNyMK1wf97159lIMhQKzPKDp8sW5i1Ebz+r/v0mXSpj7lklPE8jhr9C
	 1+hxabvF/fq95Jg1/Zi0o9Bsx7UJ74Rfv7ro7Gp0LDAHWMovy4bssGNUl+FxlNliqgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b="CDIf/thi";
	arc=none smtp.remote-ip=113.46.200.216
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6312B606A31A;
	Fri, 30 Oct 2026 09:39:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6312B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=CDIf/thi
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=p2p6dOL2KDWMR3mhYs0uPWdNBKHHcJR5aV59rO4jsGM=;
	b=CDIf/thi6+FNUxoHVdaP7IeL1YfbVmvpaT9AK93IDixWVIZKAJsiQHjhPGL0lwpzhwpxdBdxm
	uEAbjyQiOnuSVHxqqspiUxgq736myvR2fL1lZHqoa2RtxaAD7pefU6wpocaorUfxQ9lYzgar0cf
	YJOGtC4m7NXrPbs1QPz9eNs=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4jGGJL3Bt6z1T4G5;
	Fri, 30 Oct 2026 17:38:58 +0800 (CST)
Received: from whupemo200011.china.huawei.com (unknown [7.152.185.179])
	by mail.maildlp.com (Postfix) with ESMTPS id 01A6C4057F;
	Fri, 30 Oct 2026 17:39:11 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 whupemo200011.china.huawei.com (7.152.185.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 30 Oct 2026 17:39:09 +0800
Subject: Re: [PATCH v2] ubifs: fix auth node space and padding in journal
 buffers
To: <shao.mingyin@zte.com.cn>, <richard@nod.at>,
	<linux-mtd@lists.infradead.org>
CC: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20261030172650531F_VlxVrMiDglCJJ9rESWI@zte.com.cn>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <6a391820-7fc6-eabd-e22e-5940b6da2f82@huawei.com>
Date: Fri, 30 Oct 2026 17:39:09 +0800
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
In-Reply-To: <20261030172650531F_VlxVrMiDglCJJ9rESWI@zte.com.cn>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 whupemo200011.china.huawei.com (7.152.185.179)

在 2026/10/30 17:26, shao.mingyin@zte.com.cn 写道:
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
> The same write path also writes uninitialized heap data.
> ubifs_jnl_write_data() and ubifs_jnl_write_inode() build their node
> groups in kmalloc()ed buffers, and when the last node length is not a
> multiple of 8 the padding up to the next auth node goes to the flash
> uninitialized.  That padding is covered neither by the node CRC nor by
> the rolling hash.
> 
> Size the reserve buffer for the largest possible auth node (the mount
> path allocates it before authentication is initialized, so it cannot use
> ubifs_auth_node_sz()), clear the padding after the data node before it is
> written, and allocate the node group buffers of ubifs_jnl_write_inode()
> and ubifs_jnl_truncate() with kzalloc().  The data write path cannot just
> use kzalloc() because it may fall back to the reused reserve buffer.
> ubifs_jnl_truncate() refills its data node with ubifs_tnc_lookup(), so
> what is left after the re-compressed node comes from the old node on the
> media, not from the heap.
> 
> The padding is not part of any node, so ch.len and the CRCs stay
> unchanged.  With a zeroed truncation buffer, zero_trun_node_unused() is
> redundant, so remove it and the comments which refer to it.
> 
> Fixes: 6a98bc4614de ("ubifs: Add authentication nodes to journal")
> Link: https://lore.kernel.org/all/ab51df45-f763-358b-642c-8efe06f33ffb@huawei.com/
> Cc: stable@vger.kernel.org
> Suggested-by: Zhihao Cheng <chengzhihao1@huawei.com>
> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
> ---
> v2: Keep the explicit padding clear only in ubifs_jnl_write_data(), which
>      may fall back to the reused write reserve buffer; allocate the node
>      groups of ubifs_jnl_write_inode() and ubifs_jnl_truncate() with
>      kzalloc(), and drop zero_trun_node_unused() together with the
>      comments pointing at it.  Thanks to Zhihao Cheng for the review.
> 
>   fs/ubifs/journal.c     | 39 ++++++++++++++++++++++++++-------------
>   fs/ubifs/super.c       | 18 ++++++++++++++----
>   fs/ubifs/ubifs-media.h |  6 ++----
>   3 files changed, 42 insertions(+), 21 deletions(-)
> 
Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
> diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
> index 40a95a2fad50..449bc8c0a224 100644
> --- a/fs/ubifs/journal.c
> +++ b/fs/ubifs/journal.c
> @@ -68,16 +68,6 @@ static inline void zero_dent_node_unused(struct ubifs_dent_node *dent)
>   	dent->padding1 = 0;
>   }
> 
> -/**
> - * zero_trun_node_unused - zero out unused fields of an on-flash truncation
> - *                         node.
> - * @trun: the truncation node to zero out
> - */
> -static inline void zero_trun_node_unused(struct ubifs_trun_node *trun)
> -{
> -	memset(trun->padding, 0, 12);
> -}
> -
>   static void ubifs_add_auth_dirt(struct ubifs_info *c, int lnum)
>   {
>   	if (ubifs_authenticated(c))
> @@ -840,6 +830,28 @@ int ubifs_jnl_update(struct ubifs_info *c, const struct inode *dir,
>   	return err;
>   }
> 
> +/**
> + * ubifs_zero_node_pad - zero the padding after a journal node
> + * @c: UBIFS file-system description object
> + * @node: node to pad
> + * @len: length of the node
> + *
> + * When authentication is enabled the auth node is placed at the next
> + * 8-byte aligned offset, so the bytes between the end of the node and
> + * that offset are written to the media.  They are covered neither by the
> + * node CRC nor by the rolling hash, so clear them instead of writing
> + * stale buffer contents.
> + *
> + * This is only needed when the buffer is reused, i.e. for the write
> + * reserve buffer of ubifs_jnl_write_data().  Buffer owners which get a
> + * fresh allocation use kzalloc() instead.
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
> @@ -925,6 +937,7 @@ int ubifs_jnl_write_data(struct ubifs_info *c, const struct inode *inode,
>   	if (err)
>   		goto out_free;
> 
> +	ubifs_zero_node_pad(c, data, dlen);
>   	ubifs_prepare_node(c, data, dlen, 0);
>   	err = write_head(c, DATAHD, data, write_len, &lnum, &offs, 0);
>   	if (err)
> @@ -1007,9 +1020,10 @@ int ubifs_jnl_write_inode(struct ubifs_info *c, const struct inode *inode)
>   	else
>   		write_len += ilen;
> 
> -	ino_start = ino = kmalloc(write_len, GFP_NOFS);
> +	ino = kzalloc(write_len, GFP_NOFS);
>   	if (!ino)
>   		return -ENOMEM;
> +	ino_start = ino;
> 
>   	/* Make reservation before allocating sequence numbers */
>   	err = make_reservation(c, BASEHD, write_len);
> @@ -1716,7 +1730,7 @@ int ubifs_jnl_truncate(struct ubifs_info *c, const struct inode *inode,
>   	sz =  UBIFS_TRUN_NODE_SZ + UBIFS_INO_NODE_SZ +
>   		dn_size + ubifs_auth_node_sz(c);
> 
> -	ino = kmalloc(sz, GFP_NOFS);
> +	ino = kzalloc(sz, GFP_NOFS);
>   	if (!ino)
>   		return -ENOMEM;
> 
> @@ -1725,7 +1739,6 @@ int ubifs_jnl_truncate(struct ubifs_info *c, const struct inode *inode,
>   	trun->inum = cpu_to_le32(inum);
>   	trun->old_size = cpu_to_le64(old_size);
>   	trun->new_size = cpu_to_le64(new_size);
> -	zero_trun_node_unused(trun);
> 
>   	dlen = new_size & (UBIFS_BLOCK_SIZE - 1);
>   	if (dlen) {
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
> diff --git a/fs/ubifs/ubifs-media.h b/fs/ubifs/ubifs-media.h
> index 3c9792cbb6ff..7d4702f3e15f 100644
> --- a/fs/ubifs/ubifs-media.h
> +++ b/fs/ubifs/ubifs-media.h
> @@ -591,14 +591,12 @@ struct ubifs_data_node {
>    * @old_size: size before truncation
>    * @new_size: size after truncation
>    *
> - * This node exists only in the journal and never goes to the main area. Note,
> - * do not forget to amend 'zero_trun_node_unused()' function when changing the
> - * padding fields.
> + * This node exists only in the journal and never goes to the main area.
>    */
>   struct ubifs_trun_node {
>   	struct ubifs_ch ch;
>   	__le32 inum;
> -	__u8 padding[12]; /* Watch 'zero_trun_node_unused()' if changing! */
> +	__u8 padding[12];
>   	__le64 old_size;
>   	__le64 new_size;
>   } __packed;
> .
> 

