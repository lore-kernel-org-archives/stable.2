Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795529555;
	b=rZBg+uvW4wHVqS9DyNZINpD/ITH+a0cxaCVI3QpzfHlCbI2Et53XykJh3G+12xIxDKQE
	 TinHBJguPf+ttgV3fSvt1Z0CcJc8D/fc9ICrnNW90oqOis6oZEPC6lkCT2rlvUkV701wG
	 ISLBvLr8PnguXni6ZA12zIOM4Xh40GpHXtfUkFpPIfPIQqE8+SCTebX34WmgpPakBrH0p
	 vNcrOFjQeu/XWinlq7iqFZf6izF1OULVB2kYOQ8IMZdJcG/13js1sz740jDdENdA8Wh8g
	 RUuVkspXg2nQLuNdvNF4DYJv7UyX5ROJu1/8f9dY/gvj8Dgu8leFrd1eeyc+b2YP0ZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795529555;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Ht6a9Ts55EUwl/9pAC+7DHZmdUzaMpvPagpqVmMJzTc=;
	b=h7jgYiLHW4qeTB6HEdGm9z9NEHYhYlHO+UHH/8Xj35qPK6G+/VeLbhoyv5+pOXKhZryc
	 o+wMfegTlCg6IBfetdDZVnI2MYBSSjYtWBJnr+ZpXUASifNcOLPrUaT/uilt597UZ/rue
	 U21x8XWkG6UkNTLdYzLkCeXTJwVl+iwhLueAXXf5G4PS0XWoBKoPVNZQiZY8FUVAu7AaQ
	 flUFUZENTLX1J55maDYzjxusjzVuS+Fj3MiKCbVMUAs3Ces9GTnB2SPg16tLZLp7JcQH2
	 XPHhdj9P5aiEm/saV9JlANt1J4Vrlm2Vw96UEF23xa00oNEhR5tFHzQSp9xcw58IkBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rowland.harvard.edu;
	spf=fail smtp.mailfrom=g.harvard.edu;
	dkim=pass header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=J1AsbAII;
	arc=none smtp.remote-ip=209.85.219.41
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C92606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 14:12:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6C92606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=J1AsbAII
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-9214032a2fdso37076276d6.0
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 06:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1795529554; x=1796134354; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ht6a9Ts55EUwl/9pAC+7DHZmdUzaMpvPagpqVmMJzTc=;
        b=J1AsbAIIOj558TKrW6Xgyf3YmEpePWEh7+GZrWJJVuOTPz9fsTZTbC2jOh2lLNnp8M
         v0ePVusdqcnTvjNEhXKaB1cXvBL2oVDRvE1+9WmZ8VatU29VhD/I4nvybjwpzXCaXlkH
         Z+y1WM+tdfRV9pY1QWh/BJgvxjWIGP93gPbVrZ1EsWkC7sLAN/GhXzZkpeo/BPcg7Md7
         AKdfjNvoRLE4OCoPfB8ccgVlTkMxnXigRGMSvpMjC9D1cTRq5ooBZ1nADHPukBhLsk1K
         74NyzDv9RvdLgxh/2qLb1JeBVIRvib0jW5+YaKjM12FKEpHrQ0Yy3wEj2cRT3Mbat1K8
         QFvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795529554; x=1796134354;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ht6a9Ts55EUwl/9pAC+7DHZmdUzaMpvPagpqVmMJzTc=;
        b=FIckuhX2CDsoJk+GGXjUP1y1Pbfjy+84FmleHcTDlleIR+LIIP3dtinWQxz6O+waNe
         rkRB/GedE7CzTZ7Ornhxxt/qdICjfqFhSyIYFXylbdWxsAgW6f8uIGgzuDohDWapYEPv
         w3/cmwcrWDejH0yYPfJXldq4EV9mvYIger0psLB9+40tYsq95NGIr0k1JpxFsaDhYo+b
         clY4HBMnO6O8K+b9qjkanh/0+KNrZwy8ot/aVTFu75Q71mj0MJNV2r154U63p/41GQdN
         z6uhTUEVlh3yU3Fj5wiD4WfG/X8658dqWBd2tctEZKUqQuij8cGLPM0FAxN8Ssp0bWc/
         UtZA==
X-Forwarded-Encrypted: i=1; AL+hErFKEnYqHihWvCOIR3Qhv7MNTZfUITfdXdZiRYGnz3VfvzjumoK8toK4US363RXL7amcHYih0hY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+i83NTIFwn3Fp+A5ljHTfiFnNtY1DlV3Y4C/Hf4Yl2fgN+IxEU
	v7P4ji4hQXC7sIrXvuatEUPUJ+egTHqcO3Qwrw9wnAZ3XVAIEsJgikqwJ6/7+iZH0g==
X-Gm-Gg: AZFdTZc5iW77v7TV/WXmcZEP0ZB8D1tvvp4IKYd/KNJt70pF2YNDeTZdGjwqYrM1TVL
	LSK7CQe4+NKx/z8AMgxd8+oe5Gshmh0EkoTaUean+OikM8Lgzba+b65pIL6b1tNaazDGRQAbLTO
	mRwEVaTzN6yuAfCd6yqqN8l2pBP8dbW1eCpSb6/U/OQuM3+sCpnoX1H6/YBMJjcfM/x3tGAllcl
	DAqaMuVzpY0Uylcj2kfExV2kv0xtSmPziEDT+HS7458WcRSfH/aHph50U7jsqblmWNdpPvLjGVI
	Xva+QW0NIYceUyKGROww01AuHHTs2s5ledidcMDnQ4r0UTH5FMk31Nn3bKOccjJSU4ZG7NEpujT
	1lOdhnNPQgmTSvJBlUa7V9ZpN/AgT/pLGrX0oqI23c+M0FzhGYiUJ5BAZP5BpcsCddzmEoEQ3mo
	vt1LIC85ix+AYwfqt55CUFPAlHI0DF4INJ+4GzaluSlw1bJNIVanaGDHe1tWOcZ4PBFj2ytcfRo
	sd06Cu/ayEQfgPpBE8U3DJVfZYZmJ3REwzZ3YpQDATg5v+51cGqshmifmg7nSMP7PoX/BMc9kT7
	qECWvx2ZdeOcbIHyikqvV5OnFcIGlw==
X-Received: by 2002:a05:6214:27e6:b0:917:af36:df30 with SMTP id 6a1803df08f44-92134a69ac9mr267449386d6.16.1795529553760;
        Tue, 24 Nov 2026 06:12:33 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:d00:161a::9a34])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921349cd592sm138586576d6.16.2026.11.24.06.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 06:12:33 -0800 (PST)
Date: Tue, 24 Nov 2026 09:12:30 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Adriano Cordova <adrianox@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org,
	syzbot+7bf725ed337e37307001@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] usb: gadget: inode: fix use-after-free of struct
 ep_data
Message-ID: <a47bfaa7-b82b-44ce-a4d7-573e212b9594@rowland.harvard.edu>
References: <20261124084144.3208824-1-adrianox@gmail.com>
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
In-Reply-To: <20261124084144.3208824-1-adrianox@gmail.com>

On Tue, Nov 24, 2026 at 05:41:44AM -0300, Adriano Cordova wrote:
> gadgetfs_unbind() -> destroy_ep_files() frees each struct ep_data via
> put_ep(), but the inode still points at that ep_data through ->i_private
> with no reference of its own.  A concurrent openat() on an endpoint file
> can therefore reach ep_open() and dereference the freed ep_data (the
> mutex fast path), even while the inode outlives it.
> 
> Give the inode its own reference: take get_ep() when the endpoint inode
> is created and drop it again from a new gadgetfs_evict_inode(), so an
> ep_data can never be freed while any inode still points at it.  This is
> also safe against dcache pruning, since the inode reference keeps the
> count >= 1 until the endpoint is removed from dev->epfiles.
> 
> The inode now holds ep_data for its whole lifetime, so an open() racing
> with an unbind never dereferences freed ep_data.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: syzbot+7bf725ed337e37307001@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?extid=7bf725ed337e37307001
> Tested-by: syzbot+7bf725ed337e37307001@syzkaller.appspotmail.com
> Cc: stable@vger.kernel.org
> Signed-off-by: Adriano Cordova <adrianox@gmail.com>
> ---
> Changes in v3:
> - Add a Fixes: tag.
> - Add Cc: stable.
> - v1: https://lore.kernel.org/all/20260904163827.216389-1-adrianox@gmail.com/

Acked-by: Alan Stern <stern@rowland.harvard.edu>

>  drivers/usb/gadget/legacy/inode.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
> index cc059a6ee262..20453214e35e 100644
> --- a/drivers/usb/gadget/legacy/inode.c
> +++ b/drivers/usb/gadget/legacy/inode.c
> @@ -1748,6 +1748,8 @@ static int activate_ep_files (struct dev_data *dev)
>  		if (!data->req)
>  			goto enomem1;
>  
> +		/* The inode keeps this ep_data alive via ->i_private. */
> +		get_ep(data);
>  		err = gadgetfs_create_file (dev->sb, data->name,
>  				data, &ep_io_operations);
>  		if (err)
> @@ -2138,9 +2140,20 @@ static int gadgetfs_create_file (struct super_block *sb, char const *name,
>  	return 0;
>  }
>  
> +static void gadgetfs_evict_inode(struct inode *inode)
> +{
> +	/* EP inodes hold the reference on their ep_data via ->i_private. */
> +	if (inode->i_fop == &ep_io_operations)
> +		put_ep(inode->i_private);
> +
> +	truncate_inode_pages_final(&inode->i_data);
> +	clear_inode(inode);
> +}
> +
>  static const struct super_operations gadget_fs_operations = {
>  	.statfs =	simple_statfs,
>  	.drop_inode =	inode_just_drop,
> +	.evict_inode =	gadgetfs_evict_inode,
>  };
>  
>  static int
> -- 
> 2.51.0
> 
