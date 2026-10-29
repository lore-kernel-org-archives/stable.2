Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793264081;
	b=2jqftjdmWicOgi1DLf8iz1vm0Lrz0glbgShq9qGQfqn0p790t8wnlfmHwOa63yLbxt8O
	 GPVyNeDeWuY9QzLAu7HMqGjqYgebpUGQqW3Aogl7lg733TFd8Zcl/cjP1Fn7W9IUKy8rt
	 zG9Hy9NTYrqeld0X+P9o71hS3xWeCg5hakQT2zKbBgXV6ZvNmiBgdkVWwh0jz2f0L8pJJ
	 IvH4dS6SvoMPzx6JhbNjBo7b5aL74wEoctyLKfL+QGH8TUS/8GHW1Kxc87dUlCMqrcIJ3
	 XvToGEpyM1ZeGGoSHw3I2fV88QQ44gy/j2KWdIZzHKVBfYj/bUF4aB3lwhZxtRHFZ1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793264081;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Subject:To:CC:
	 References:From:Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=Q70iv8hgHPImGJwByc0Z4M1+rMHdNArmQ9AkIYYXNY0=;
	b=sgEVdWUBG+eW8u9lN1b6TfUvD3vZy2aIToXFGA01iZTfNEX63rgop/Dz9Bf0pQGezIMg
	 rwT+Ao+2tMxtsQDOYDWK8vP26s0ATu4MSKotlFMjAeNAMhKR+nfisq+XwVLxKMksRtjSL
	 UzynzUe3sO4REgEz9jLDohL+THHTIwhw6VTqvfrMGA/Df3vmposfu7vOWup6VkAe2mbQ3
	 LkKM/Y6nJ30NkyUniQm1rJj2JMqQEBB9VXUedbNbIl1CFdMJG7rMpfKFwQBiUZknaH6Q6
	 JPO15MGgfvW34zKuhb6scq08uidk9HyDkviKWd1kb7sx4vQWot+z4nYsy5vK0Y8YfEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b="tXRuL6/x";
	arc=none smtp.remote-ip=113.46.200.226
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B295606A31A;
	Thu, 29 Oct 2026 08:54:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B295606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=tXRuL6/x
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Q70iv8hgHPImGJwByc0Z4M1+rMHdNArmQ9AkIYYXNY0=;
	b=tXRuL6/xPq9TBBk+P1aKoWdgSV4+tindXcCZsh8kohvox+SUEeNu4so695q0CP5msi7f36Ki2
	2GixcqT16Uot/LZADeCLoFx0yFJzCZfUx+IZ+NMIwMWnp0DWvxyhdgtmZ8iqsvLtey7f/ZSljY+
	5cWpY+8lLIh0phmG9Mm5c5U=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4jFdMH5fdFzKm61;
	Thu, 29 Oct 2026 16:54:19 +0800 (CST)
Received: from whupemo200011.china.huawei.com (unknown [7.152.185.179])
	by mail.maildlp.com (Postfix) with ESMTPS id 5EE104057C;
	Thu, 29 Oct 2026 16:54:29 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 whupemo200011.china.huawei.com (7.152.185.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 29 Oct 2026 16:54:28 +0800
Subject: Re: [PATCH] ubifs: fix fscrypt_name leak when purging xattrs fails
To: <shao.mingyin@zte.com.cn>, <richard@nod.at>,
	<linux-mtd@lists.infradead.org>
CC: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20261029164549455vmvRvpHkZ8cVjNxAzoyoO@zte.com.cn>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <07e98a63-b9d0-4f94-24f1-f394390389d1@huawei.com>
Date: Thu, 29 Oct 2026 16:54:27 +0800
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
In-Reply-To: <20261029164549455vmvRvpHkZ8cVjNxAzoyoO@zte.com.cn>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 whupemo200011.china.huawei.com (7.152.185.179)

在 2026/10/29 16:45, shao.mingyin@zte.com.cn 写道:
> From: Shao Mingyin <shao.mingyin@zte.com.cn>
> 
> ubifs_unlink() and ubifs_rmdir() call fscrypt_setup_filename() and
> then ubifs_purge_xattrs().  For an encrypted directory the former
> allocates the buffer holding the encrypted on-disk name, and every
> later error path of both functions releases it through the out_fname
> label.  The purge failure path returns directly instead, so that
> buffer is leaked.
> 
> ubifs_purge_xattrs() only does real work when the inode claims more
> xattrs than UBIFS allows, in which case it deletes them one by one.
> That can fail, for example with -ENOSPC from ubifs_budget_space() or
> with an I/O error.  Every such failed unlink() or rmdir() then leaks
> one buffer of up to NAME_MAX bytes, so repeated attempts leak memory
> without bound.
> 
> Jump to the existing cleanup label instead.  do_rename() is not
> affected: it purges the xattrs before it calls
> fscrypt_setup_filename().
> 
> Fixes: 9ca2d7326444 ("ubifs: Limit number of xattrs per inode")
> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
> ---
> diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
> index c67954f6bee0..73594d476fe3 100644
> --- a/fs/ubifs/dir.c
> +++ b/fs/ubifs/dir.c
> @@ -846,7 +846,7 @@ static int ubifs_unlink(struct inode *dir, struct dentry *dentry)
> 
>   	err = ubifs_purge_xattrs(inode);
>   	if (err)
> -		return err;
> +		goto out_fname;
> 
>   	sz_change = CALC_DENT_SIZE(fname_len(&nm));
> 
> @@ -955,7 +955,7 @@ static int ubifs_rmdir(struct inode *dir, struct dentry *dentry)
> 
>   	err = ubifs_purge_xattrs(inode);
>   	if (err)
> -		return err;
> +		goto out_fname;
> 
>   	sz_change = CALC_DENT_SIZE(fname_len(&nm));
> .
> 

