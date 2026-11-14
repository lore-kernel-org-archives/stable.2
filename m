Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794658799;
	b=eZbh/nrvrOcYxWc7s9rIGQ6aFC23Y+oD0G2bwL46He5IiTKI3WQwqiOt+EXrdYgHw7MF
	 kLL8P4lIhI9WeymH2ZnWkpkApkvid7DX+10GfOD4w1cm3eDZQhC2Ia9qQ1JEL5Tra73O6
	 K9gQLp7xtmEQRlIkCLlbIGKoDeY5ZAnuPdn5r8ustTeoAc2pmHv+cZkQ/7MLaJoevxQUv
	 vQgySlPQKpZPHKgXvWNfAdhGW7TbV6D9ubV6iw8UoryKSlV9TxgoVvUmDdzT99H7/2RNa
	 D5yXogNvWjJRnehJXZa42mOg6n3glA0+IKHERjFWP70MRObjaSBjXfH7+xS2DTCJ7vQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794658799;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=nkM3J4QAu8kIsGHpB1EKb0NRF0JxtY2T/gqGpQ/nt0Q=;
	b=A0dTZS71XvyVEs3TTo0kHI0/f78TXDjFz2lr3jP7XTfscFmRDBLR7lFngZ1EMBzPbOpr
	 Tfr+OZZ8PGmBqZNIFIP8gNkQrkrkPEdl+b8v9aIBm34bgmSmJTNIOaGMYEo9ARjel3kL6
	 8OFnsyjajKjP73Cxa3eDF0Q1wOGacerQ4qmgvzszGVMTdGK5OLoK7xeMZShcleMmbkvYX
	 hj8glj9i+zVG0C3ZahHeT5j5imA8r4Edo55+izB9iM6MK7GR/qhA82FEPMs0EEoRwDsQl
	 H2Q4nu5mjuZ6vwRko7y7nAwdCfOwVY9+FVUdNBqzj/I1wnBT9voFMlVPr2pKkmqDSqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Zvg2B30u;
	arc=none smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A6A606A335
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 12:19:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38A6A606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Zvg2B30u
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c169ae1cb26so387166166b.1
        for <stable@vger.kernel.org>; Sat, 14 Nov 2026 04:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794658797; x=1795263597; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nkM3J4QAu8kIsGHpB1EKb0NRF0JxtY2T/gqGpQ/nt0Q=;
        b=Zvg2B30uBzOFFo54OpfHCzqSK6TOyxTRmwNZV7t2nfrBwunaCrRH+5tI09/jIosXZS
         GdYk6iMfyO0nJ3moVzjaSKnXCCWxcV1Ye+R/4YjiwdwGG8ofIv4PWH24MjP/VV4CkNiq
         nSM7j6UNEdEDdNWpjUjn43q9YL/wt1IFltOrsPhL2VYrn8g/yyR7Uz6PFelA0j1tolIT
         QTqiv37OCVMy+5oEwlNBsw2cKiejzgZGAC7AZW2QPAu9cR2dMcfIteYf8vq02JyCIN53
         /PYiFz/vA+fp7KPo0fCiRfu55fCeLd5qLFIcUMGbAUVH1mkivaDzQTprXnn5n1PDT9pn
         6ZTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794658797; x=1795263597;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nkM3J4QAu8kIsGHpB1EKb0NRF0JxtY2T/gqGpQ/nt0Q=;
        b=k3JdSgJcE58B9xdailSLSDosIwlqzTlSC1QJtC4/v05smLg9ajF58AAN96XQboDhFJ
         7vHVyCz4MspLr3LPnwF9WKgjhUnRGg01JJpJVdoQ5FXiDupSIy8HeQhW280hxAZapMxp
         Q3gOMD8piQ2dQ/Dv783balAB2Yy+kuypZWZFEkHbheBoCmaJKicV/HkoOirEdqtQlGaD
         PwTW1bjSq9KLV8D5YmXqV9kZMChLKBuh0VANGAMeLERGough4cacT2CORck0+gGbPG7U
         vnIOsnT3f4NAnbVXmJY4TIc6KqjiTBE+8TzGzsfnXH+dTWN0ULYdnZypN3M2Ij+XauKS
         YKRw==
X-Forwarded-Encrypted: i=1; AL+hErFke7NgaYAMpRr1DWjCcg+20Fx6BEYF/IIix7YAcKSpKVD3TH4OjlIJDQo/GPKuv/nTk8Y/quY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8XOKvsHpDvPJmtezOlJotH8gHiFEtndM55n7Hkm3KFdhM+Q9yG
	hZOY/ct0/ofHsxzDVjsQtfE7mUBaVNVQ9ejFNtgevLwajUgMzfUI1Vzo
X-Gm-Gg: AYBFou0KoMuJgIFjIbTDsJ1OP+9jk0kLKuNsqGUGyuPhC08Orr7GFYScZ0rIOyagIhl
	aKFhloa3XLuK3vQ7oTqnFPPi5oRNmDPdmg6fyYbpqJ4upJx5B5jDPyBJpIv/K8Q7ft5oMDKwx1D
	MohC2BM+jCu9Vvw5tzDv8JtTsbxzaPijYxyhi+0m/JTH65CMVaHo/8EWSh71hmqJatZBkr5a6/0
	HLzw155BvebiuRhVPSmSREFnRA+BxwojcvWhoc1Q3GQJ5Szi1pwjMx6VYwee2lsCDYOi9k1eSct
	sQqSYeIwSfG05c4cbZGFOx7EqyOTrO3CdhsiXjOx+akdN6tUx0+Iytaoy6RSH6GlzqNu0zYhFOS
	I54PVrW7SpNmqMOblVxUqMiRAYenayvOawbdlUtr9ATrcps8MDj3IgMzglZU8pe+G5TLyLgHFmU
	Tpgq3WMer4/kA3fuD+tMAUikUAh6pYWHhGejIwFgGSvak2uK6O1syD5Mm/81E4aJ/f3v7qzTQCj
	3mm8t1HCFcN9HAz5bwowXCkMJ9U9n3GO0oQtJ6TtDVqBY3YkRVAwl6sqUGlXr+X4Gk0INO3UNLS
	ItD/dnBzbCaRAOI0LKzJIiVc1v3GSxpSLqiZoQvBjyme+TQQQPCRms0tcJiLMuS+zfDPloiKg1I
	xIhs38PdPN0nh
X-Received: by 2002:a17:906:1001:10b0:c41:4512:560d with SMTP id a640c23a62f3a-c5096387b02mr309942166b.16.1794658797424;
        Sat, 14 Nov 2026 04:19:57 -0800 (PST)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b5ac2asm211518966b.55.2026.11.14.04.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 04:19:56 -0800 (PST)
Date: Sat, 14 Nov 2026 13:19:56 +0100
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Shakeel Butt <shakeel.butt@linux.dev>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org, linux-unionfs@vger.kernel.org,
	bpf@vger.kernel.org, linux-nfs@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 10/12] ovl: take freeze protection when storing the uuid
Message-ID: <avhR7DbNbVDCyPDO@amir-ThinkPad-T480>
References: <20261114-work-fs-frozen_writes-v1-0-f5ae61c898b1@kernel.org>
 <20261114-work-fs-frozen_writes-v1-10-f5ae61c898b1@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261114-work-fs-frozen_writes-v1-10-f5ae61c898b1@kernel.org>

On Sat, Nov 14, 2026 at 11:47:17AM +0100, Christian Brauner wrote:
> ovl_init_uuid_xattr() stores the persistent uuid in an xattr on the
> upper root. That happens after ovl_make_workdir() dropped its write
> access to the upper mount and before ovl_get_indexdir() takes it
> again. So a freeze of the upper filesystem that lands in between lets
> the mount modify a frozen filesystem.
> 
> Take write access to the upper mount around the xattr update.
> 
> Fixes: d9544c1b0d9e ("ovl: store persistent uuid/fsid with uuid=on")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.

> ---
>  fs/overlayfs/util.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
> index 521717209b2e4..67aa7b71e9c83 100644
> --- a/fs/overlayfs/util.c
> +++ b/fs/overlayfs/util.c
> @@ -829,8 +829,12 @@ bool ovl_init_uuid_xattr(struct super_block *sb, struct ovl_fs *ofs,
>  
>  	/* Try to store persistent uuid */
>  	set = true;
> -	res = ovl_setxattr(ofs, upperpath->dentry, OVL_XATTR_UUID, uuid.b,
> -			   UUID_SIZE);
> +	res = mnt_want_write(ovl_upper_mnt(ofs));
> +	if (!res) {
> +		res = ovl_setxattr(ofs, upperpath->dentry, OVL_XATTR_UUID,
> +				   uuid.b, UUID_SIZE);
> +		mnt_drop_write(ovl_upper_mnt(ofs));
> +	}
>  	if (res)
>  		goto fail;
>  
> 
> -- 
> 2.53.0
> 

