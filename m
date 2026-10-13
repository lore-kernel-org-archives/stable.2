Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38A44A1DF6;
	Tue, 13 Oct 2026 06:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791871772; cv=none; b=rvvBVXa/2vnBoPy6QCnhuTeWT7K2PmE6K8XgOYApbw9SExWusBC/TZ9BM/b+zk+lF74sFh6G5l9KGT4ykVj9N50+rc6UWgqBQGlSCJPTmAtFVTMv4qjr/m1xW4znUlQMNkXPe0zgV8UeaGQH3ikCKPUFlGfehiAZJSJdNjWCTeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791871772; c=relaxed/simple;
	bh=I0j7RbCrTfKM1uhXvZfToRpPgD/9ZzE7Ma2FksYWCKs=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=PqqoxeBNN/LBk0VkvgnTFnm6TrWmiXQ6ukS8MnlWcWDC265Xs7D8KEJpicM6iwiORi9sg2XFNH/eAS1fE3r1r7mSiPGTpG9weUCulfhD1/hIy/j/vZ7ZXVBztuE23ZtedKPkZPWozCFpLCQQ9WRokolpSGhg5k/T92s4GVREArg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=hOQfiPjp; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="hOQfiPjp"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=40uAvGtB89UrnliI+trk4ouePijCjFhtYsvGS/V1SXw=;
	b=hOQfiPjpIAoFpTW1jY9Ti5gnF0iwjU3DR6NTOIfes5GK6oIFW7bsMn0lqUZmvK9+JLH4MP7SV
	X3T9Ef2shjvcNOYGMuLeSBG4rPd+r8FTJmDRkIKNUfHwDCPMuVxHtKNDaLxG/5Tjgj5liCLbqp+
	TNzKTgKVAzqAfD5uI4Yr7Mc=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4j3kBC0H3hzLlSh;
	Tue, 13 Oct 2026 13:57:07 +0800 (CST)
Received: from whupemo200011.china.huawei.com (unknown [7.152.185.179])
	by mail.maildlp.com (Postfix) with ESMTPS id AAD9940578;
	Tue, 13 Oct 2026 14:09:24 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 whupemo200011.china.huawei.com (7.152.185.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 13 Oct 2026 14:09:23 +0800
Subject: Re: [PATCH v2] ubifs: fix host inode TNC offset when deleting an
 xattr
To: Nan Lin <lin.nan@h3c.com>, <richard@nod.at>
CC: <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
	<wangxiaoqing@h3c.com>, <zhou.kete@h3c.com>, <stable@vger.kernel.org>
References: <mv5oa6u2.f135b439-8d58-4f22-b346-3aacaa66e9e4@nod.at>
 <20261013052953.1401741-1-lin.nan@h3c.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <e9bde32f-753c-a803-3fab-cb49e1031aeb@huawei.com>
Date: Tue, 13 Oct 2026 14:09:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261013052953.1401741-1-lin.nan@h3c.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 whupemo200011.china.huawei.com (7.152.185.179)

ÔÚ 2026/10/13 13:29, Nan Lin Ð´µÀ:
> ubifs_jnl_delete_xattr() writes a group of three nodes: the xent, the
> xattr inode and the host inode. The host inode is packed at
> xent_offs + aligned_xlen + UBIFS_INO_NODE_SZ, but its TNC position is
> computed backwards as xent_offs + len - hlen. Since len includes the
> group's tail padding, ALIGN(hlen, 8) - hlen, the two differ whenever
> the host inode's inline data length is not a multiple of 8. This
> affects symlinks and device nodes.
> 
> The unaligned offset ends up in the on-flash index and the next mount
> rejects the index node, turning the filesystem read-only.
> 
> Fixes: 1e51764a3c2a ("UBIFS: add new flash file system")
> Cc: stable@vger.kernel.org
> Tested-by: Zhihao Cheng <chengzhihao1@huawei.com>
> Signed-off-by: Nan Lin <lin.nan@h3c.com>
> 
> Changes since v1:
>   - compute the host inode offset into a new host_offs variable instead
>     of open-coding the offset (Richard Weinberger);
>   - shorten the commit message.
> 
> ---
>   fs/ubifs/journal.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
> 
> diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
> index 40a95a2fad50..0b2dae57e467 100644
> --- a/fs/ubifs/journal.c
> +++ b/fs/ubifs/journal.c
> @@ -1858,7 +1858,8 @@ int ubifs_jnl_delete_xattr(struct ubifs_info *c, const struct inode *host,
>   			   const struct inode *inode,
>   			   const struct fscrypt_name *nm)
>   {
> -	int err, xlen, hlen, len, lnum, xent_offs, aligned_xlen, write_len;
> +	int err, xlen, hlen, len, lnum, xent_offs, host_offs, aligned_xlen,
> +		write_len;
>   	struct ubifs_dent_node *xent;
>   	struct ubifs_ino_node *ino;
>   	union ubifs_key xent_key, key1, key2;
> @@ -1915,6 +1916,8 @@ int ubifs_jnl_delete_xattr(struct ubifs_info *c, const struct inode *host,
>   		ubifs_wbuf_add_ino_nolock(&c->jheads[BASEHD].wbuf, host->i_ino);
>   	release_head(c, BASEHD);
>   
> +	host_offs = xent_offs + aligned_xlen + UBIFS_INO_NODE_SZ;
> +
>   	ubifs_add_auth_dirt(c, lnum);
>   	kfree(xent);
>   	if (err)
> @@ -1943,7 +1946,7 @@ int ubifs_jnl_delete_xattr(struct ubifs_info *c, const struct inode *host,
>   
>   	/* And update TNC with the new host inode position */
>   	ino_key_init(c, &key1, host->i_ino);
> -	err = ubifs_tnc_add(c, &key1, lnum, xent_offs + len - hlen, hlen, hash);
> +	err = ubifs_tnc_add(c, &key1, lnum, host_offs, hlen, hash);
>   	if (err)
>   		goto out_ro;
>   
> 

