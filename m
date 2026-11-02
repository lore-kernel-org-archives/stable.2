Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.217
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793626530;
	b=x1f944XTTqL7WcVZP35cCpDzHWqwL5eeeOuDKoM/9ZoFWei5DF86wZHaGjQ8JmB3xo1k
	 MUOFl8t4wFZJ/g1msnO00oxRLHo3sNufhsJtQTP/9ushgWZFH6W84Q2d40vo79z6K+MlN
	 4p0sPf3J0FBtvwYjJRCQxrQWxtbe0YcbNvWSZqOm8X0veNoRvmiQOWSsAqTvePlaHbb+M
	 c8dI+vxqxsGNy01GTTorafFKzt8fOg8hHvVXOMp4oZocEzOs1OK/S1v7B0IjgG4PBBlE4
	 mjAzP2yEpb05blolEJmpiLSf5LPsFi4encNeckZ1+h09DAs2b0rBv1gGk7/MuJ3sf4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793626530;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Subject:To:
	 References:From:Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=EVQ1vt5IOHfbKCljKX6ruZ5U/TgA9shpEQ/gchFOu6o=;
	b=z/Af1X/9EpwnNPb1uBqLW80FguBIJ3eHeQCVb3XwXnFuydQFn5iNht/3bbY1Jx5AFMkd
	 PFrPBZAWSJ2l42k4j0gI688m1J5ZJxU6rVm7RHE5UMjbT2hVO0cuyD70/knkcSOz++QC+
	 yceSR1JzIIZj2aaNaMw82bLjUNUXac6uwRM7de3XnXnfXsNcbDtzlXL//8u6pVz2jh6Se
	 LsJ0qTLw4KM5etBNLiCxFtG6urRK/Xyln0YuPFBcvF7zLuud6X3LLyG+2UoYAh1w3fu6X
	 /bifI/3/6anlqKqyrjXfBzsRvWT7DzZI1lARIwF942Agv1sE5mo09BeH/NkcgWFh7WQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=fj7nE0QQ;
	arc=none smtp.remote-ip=113.46.200.217
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E95C606A326;
	Mon,  2 Nov 2026 13:35:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E95C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=fj7nE0QQ
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=EVQ1vt5IOHfbKCljKX6ruZ5U/TgA9shpEQ/gchFOu6o=;
	b=fj7nE0QQBrFVgelGUx5/bAjuyRDhVopUTwWxLH5Eq303JkvheDHXcYwTVWlS2a9DVOSk9nDi6
	n8rziU8/imZmV0QEIDsNBb+Lg4eV3zFhT5p+uZ4kDFe7gsNRvnob+ds155Smaa5QtMHLgZwd0DC
	r3ELel2G/i5s6AnzdtsSzkU=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4jJCPJ2fsfzcbNv;
	Mon,  2 Nov 2026 21:35:00 +0800 (CST)
Received: from whupemo200011.china.huawei.com (unknown [7.152.185.179])
	by mail.maildlp.com (Postfix) with ESMTPS id B7AC540537;
	Mon,  2 Nov 2026 21:35:23 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 whupemo200011.china.huawei.com (7.152.185.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 2 Nov 2026 21:35:22 +0800
Subject: Re: [PATCH 2/3] ubifs: xattr: preserve the encryption flag when
 creation fails
To: <shao.mingyin@zte.com.cn>, <richard@nod.at>,
	<linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <20261102195625207uxpYcc94_VO6Ir71GcQ99@zte.com.cn>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <485421cb-458a-4608-1453-09443df2ccd2@huawei.com>
Date: Mon, 2 Nov 2026 21:35:17 +0800
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
In-Reply-To: <20261102195625207uxpYcc94_VO6Ir71GcQ99@zte.com.cn>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 whupemo200011.china.huawei.com (7.152.185.179)

在 2026/11/2 19:56, shao.mingyin@zte.com.cn 写道:
> create_xattr() clears UBIFS_CRYPT_FL in its error path regardless of
> whether this call set the flag.  The flag is also set for every inode
> that already carries an encryption context, so a failed setxattr() on
> such an inode clears it from the in-memory inode.  The next inode write
> then packs ui->flags without UBIFS_CRYPT_FL, and after the next mount
> the inode is no longer treated as encrypted although its names and data
> still are.  ubifs_jnl_update() can fail before anything is written, for
> example when its journal buffer cannot be allocated.
> 
> Remember whether this call actually set the flag and only clear it in
> that case.
> 
> Fixes: d475a507457b ("ubifs: Add skeleton for fscrypto")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
> ---
Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
> diff --git a/fs/ubifs/xattr.c b/fs/ubifs/xattr.c
> index 3b0e8a270f59..7f82ddb9e3f2 100644
> --- a/fs/ubifs/xattr.c
> +++ b/fs/ubifs/xattr.c
> @@ -69,6 +69,7 @@ static int create_xattr(struct ubifs_info *c, struct inode *host,
>   			const struct fscrypt_name *nm, const void *value, int size)
>   {
>   	int err, names_len;
> +	bool set_crypt = false;
>   	struct inode *inode;
>   	struct ubifs_inode *ui, *host_ui = ubifs_inode(host);
>   	struct ubifs_budget_req req = { .new_ino = 1, .new_dent = 1,
> @@ -133,8 +134,10 @@ static int create_xattr(struct ubifs_info *c, struct inode *host,
>   	 * To avoid multiple updates of the same inode in the same operation,
>   	 * let's do it here.
>   	 */
> -	if (strcmp(fname_name(nm), UBIFS_XATTR_NAME_ENCRYPTION_CONTEXT) == 0)
> +	if (strcmp(fname_name(nm), UBIFS_XATTR_NAME_ENCRYPTION_CONTEXT) == 0) {
> +		set_crypt = !(host_ui->flags & UBIFS_CRYPT_FL);
>   		host_ui->flags |= UBIFS_CRYPT_FL;
> +	}
>   
>   	err = ubifs_jnl_update(c, host, nm, inode, 0, 1, 0);
>   	if (err)
> @@ -152,7 +155,8 @@ static int create_xattr(struct ubifs_info *c, struct inode *host,
>   	host_ui->xattr_size -= CALC_DENT_SIZE(fname_len(nm));
>   	host_ui->xattr_size -= CALC_XATTR_BYTES(size);
>   	host_ui->xattr_names -= fname_len(nm);
> -	host_ui->flags &= ~UBIFS_CRYPT_FL;
> +	if (set_crypt)
> +		host_ui->flags &= ~UBIFS_CRYPT_FL;
>   	mutex_unlock(&host_ui->ui_mutex);
>   out_free:
>   	make_bad_inode(inode);
> .
> 

