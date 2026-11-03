Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.223
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793671583;
	b=g7Aoybj7QOw+3EVhzXqwksX26+TdW0bUybPDOlkINygREwNPuQUAvXHMvv/ofLQoS+OP
	 ETHHRo7XYEOQd8xvxiZOmWxrAB+R0AJzzg045oBcwDFDIgJk9/C9MyUqGewaM3nb67Axp
	 gn81umpMBsmbwR7wFRhaE+i+s8Qmieaxp2999/PZQKwlgfzwPhLJdjCMgfZzGXSxH5KGr
	 YOxQpItgY/hwIZ+QqrZJVB3XPSbdjbrFXZ3v1tXoukOf8gl2Y04P5xf0y/XhOjYODs3HE
	 sP61kfUgW7qqbi3+rl5+9mkEtvsK05ke2ltmI8p79xWIfEdOjKX8paJ3RyzYGksQ09A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793671583;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Subject:To:CC:
	 References:From:Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=RDTCUcSlzVCOYo5WGdhwHy5r1sMLRwFbwFD3/2YwmY4=;
	b=ef3oUsKd4GEcE6Si6e6N1TFvXpimzRVmH6sM3/BGAmqcnYDuEo6J0DK4gci+N/SZcShE
	 9oHbfDi7df0yoecGblQRRUtXYgeeFcYCoJ37E58ej9OA+LgEvjHdxfrPV7M7cKXmkc56A
	 vfT3kIpN+kmwYesaAueVq9fzFkJGI/pbGzRKFasNBxYryWocYTaKvfLmP0FiZSpKcstFv
	 BU07embQnIwxZ2lH/ylqVf/3JEOq8/rbeHHnCMfghhBmoVM854+D08Y96RqgDVVJdtSZF
	 ccv04nHi2FdiGpVId0SFcOhJ76pJs7R6yUNbwGzFLfAjH4XedBffbTFSQJVaTge7ImA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=GB4teFFp;
	arc=none smtp.remote-ip=113.46.200.223
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D50606A330;
	Tue,  3 Nov 2026 02:06:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9D50606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=GB4teFFp
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=RDTCUcSlzVCOYo5WGdhwHy5r1sMLRwFbwFD3/2YwmY4=;
	b=GB4teFFp6SrE4cyFSj7PgfvoF7yq1/7uTSDzZdlrNQr8imjxs/NYcJW67nUnvCBGHTM9tQ9ir
	PozA1Kojzy6ZJUTCfeIJ8nItBl09GHg9frCiSTwHlCNShq5z7UWeO5/GwSGjfAHwKQFMed0CdRM
	rD0Mib2CRyBHH4SFbAMPKFM=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4jJX3z5LcbzmV7Z;
	Tue,  3 Nov 2026 10:06:07 +0800 (CST)
Received: from whupemo200011.china.huawei.com (unknown [7.152.185.179])
	by mail.maildlp.com (Postfix) with ESMTPS id 9DA404048B;
	Tue,  3 Nov 2026 10:06:17 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 whupemo200011.china.huawei.com (7.152.185.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 3 Nov 2026 10:06:16 +0800
Subject: Re: [PATCH 2/5] ubifs: reject xattr inodes whose size does not match
 the value
To: <shao.mingyin@zte.com.cn>, <richard@nod.at>,
	<linux-mtd@lists.infradead.org>
CC: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20261102214934411GPsnXXiPDuCvO4pgPeTgU@zte.com.cn>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <9ff68e0a-18b4-fb7f-238c-105e5b247a9d@huawei.com>
Date: Tue, 3 Nov 2026 10:06:15 +0800
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
In-Reply-To: <20261102214934411GPsnXXiPDuCvO4pgPeTgU@zte.com.cn>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 whupemo200011.china.huawei.com (7.152.185.179)

在 2026/11/2 21:49, shao.mingyin@zte.com.cn 写道:
> An extended attribute inode stores the value in the inode node and
> UBIFS keeps inode->i_size equal to ubifs_inode->data_len (see
> create_xattr() and change_xattr()).  validate_inode() does not check
> this for inodes that carry UBIFS_XATTR_FL, so an image with a mismatch
> is accepted.  ubifs_xattr_get() and remove_xattr() then trip their
> ubifs_assert() on the invariant; with the assert=read-only or
> assert=panic mount option a plain getxattr() or removexattr() turns the
> file system read-only or panics the kernel.
> 
> Reject such inodes at iget time.
> 
> Fixes: 1e51764a3c2a ("UBIFS: add new flash file system")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
> ---
> diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
> index 38972786817e..9f608c10b39e 100644
> --- a/fs/ubifs/super.c
> +++ b/fs/ubifs/super.c
> @@ -91,6 +91,18 @@ static int validate_inode(struct ubifs_info *c, const struct inode *inode)
>   	if (ui->xattr && !S_ISREG(inode->i_mode))
>   		return 5;
>   
> +	/*
> +	 * Extended attribute inodes keep the value in the inode node and
> +	 * maintain i_size == data_len everywhere (see create_xattr() and
> +	 * change_xattr()).
> +	 */
> +	if (ui->xattr && inode->i_size != ui->data_len) {
> +		ubifs_err(c, "xattr inode %llu has size %lld, but %d bytes of data",
> +			  inode->i_ino, (long long)inode->i_size,
> +			  ui->data_len);
> +		return 6;
> +	}
> +

Above two ui->xattr check could be merged like:
if (ui->xattr) {
   if (!S_ISREG(inode->i_mode))
     return 5;

   if (inode->i_size != ui->data_len)
     return 6;
}
>   	if (!ubifs_compr_present(c, ui->compr_type)) {
>   		ubifs_warn(c, "inode %llu uses '%s' compression, but it was not compiled in",
>   			   inode->i_ino, ubifs_compr_name(c, ui->compr_type));
> .
> 

