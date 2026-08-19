Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D1121B192;
	Wed, 19 Aug 2026 05:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787118370; cv=none; b=SP3esTnJbql/c2DYEfZWqhO6fj1idhc9Vj4ugmcFAVOIYsmYqfBeFSqkBRCCO+Nz9a2CLVlh3vTcGJboB+ifsgO80+bP/kUq1Svc/+mMr/QjYn1QrOvdPLMvmspHWyfyV/0d73RU1AD5tBzA/zqVEXFxk1CrNsj/C0RBexp2lvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787118370; c=relaxed/simple;
	bh=5+hsZocCmctiTgJ28ZevlX5WT8Ri8oNWYg4/JVef9/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sB6xkRLLpPalNkWQOP4vDbFL7h89m9VWrRW4UxloblJGaZleGbabNynYSoAaj2UZu/stgkaQ/fKOsdZBTcDL2fBYb/8itU+8pB3eNIDTBmrh+Y2/9t9qEfMDpXJnNUo9zOQewJfGBX/aZ/3mxthhiz1do8PAbHMmlp1QLKP6DX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 405dd3469b9111f19a56ed5b684f684d-20260819
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:943e49de-a050-4a7d-84eb-b0ba1e38e7f1,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:c9ae4c6940793613cf6a0b79a0ab56f2,BulkI
	D:nil,BulkQuantity:0,SF:80|81|82|83|102|136|865|898,TC:nil,Content:0|15|52
	,EDM:-3|-100,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
	,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 405dd3469b9111f19a56ed5b684f684d-20260819
X-User: xiaopei01@kylinos.cn
Received: from [10.42.12.251] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 87162550; Wed, 19 Aug 2026 13:45:57 +0800
Message-ID: <cc164348-2b5a-45a8-8322-7efa9a392248@kylinos.cn>
Date: Wed, 19 Aug 2026 13:45:55 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mtd: block2mtd: Fix divide error when erase_size is
 zero
To: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
 brauner@kernel.org, jack@suse.cz, hch@lst.de
Cc: syzbot+b320a4d5f65a61dbbf89@syzkaller.appspotmail.com,
 stable@vger.kernel.org
References: <25ec7ba58facdf29b42ca43dcf11cd98e2089a5f.1786589041.git.xiaopei01@kylinos.cn>
From: Pei Xiao <xiaopei01@kylinos.cn>
In-Reply-To: <25ec7ba58facdf29b42ca43dcf11cd98e2089a5f.1786589041.git.xiaopei01@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2026/8/13 10:48, Pei Xiao 写道:
> The erase size is parsed from the "block2mtd" module parameter and can
> be set to zero. add_device() then evaluates
> 
>         if (size % erase_size)
> 
> with a zero divisor, which triggers a divide error:
> 
> divide error: 0000 [#1] PREEMPT SMP PTI
> RIP: 0010:add_device drivers/mtd/devices/block2mtd.c:296 [inline]
> RIP: 0010:block2mtd_setup2+0x592/0xda0 drivers/mtd/devices/block2mtd.c:459
> Call Trace:
> block2mtd_setup+0x27/0xe0 drivers/mtd/devices/block2mtd.c:476
> param_attr_store+0x214/0x310 kernel/params.c:589
> module_attr_store+0x65/0x90 kernel/params.c:904
> kernfs_fop_write_iter+0x3a4/0x540 fs/kernfs/file.c:345
> ...
> 
> Reject a zero erase size before performing the modulo operation so the
> existing "erasesize must be a divisor of device size" error path
> reports the invalid argument and frees the device.
> 
> Fixes: ea6d833a3fdd ("mtd: block2mtd: check device size")
> Reported-by: syzbot+b320a4d5f65a61dbbf89@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/lkml/6a7b58ba.ac361c09.22ff0a.0045.GAE@google.com/
> Suggested-by: Jörn Engel <joern@barelysecure.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
Add cc Maintainers.
> ---
> changes in v3:
> 1.remove (long) cast due to build errors in 32bit config systems
> 2.changes git log about (long) cast
> 
> changlogs in v2:
> 1.Add Suggested-by tag
> 2.remove unnecessary (long) cast from the size
> ---
>  drivers/mtd/devices/block2mtd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/devices/block2mtd.c b/drivers/mtd/devices/block2mtd.c
> index 03e80b2c4f5a..349fa07be314 100644
> --- a/drivers/mtd/devices/block2mtd.c
> +++ b/drivers/mtd/devices/block2mtd.c
> @@ -293,7 +293,7 @@ static struct block2mtd_dev *add_device(char *devname, int erase_size,
>  	}
>  
>  	size = bdev_nr_bytes(bdev);
> -	if ((long)size % erase_size) {
> +	if (!erase_size || (long)size % erase_size) {
>  		pr_err("erasesize must be a divisor of device size\n");
>  		goto err_free_block2mtd;
>  	}

