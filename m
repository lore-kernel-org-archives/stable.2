Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795682754;
	b=zzUlRM0wQxKE86S2wrHZ+ChegaURyHp4ymECqS20VfDhmx3cMEWWTY2TYSU26iycdryp
	 fLu4FwOeLmYNuCdimbbQSGhD+zdmd3R0DcBea5uTLGpx0+thEnuudjcuN3mGWuprM+Lmf
	 bHXxH4WVD5gv0//ulVUn1PyhaEn/k6+lL3qJ//0+uXAXMh6j2B6a0nvvGHfHoK5PjbnxT
	 HinVngg6yUAsAw+d6JK289T/e0j1d1CbYRWR7np/YaDIo1mzCgjU4l+lMy8UXdbuO2bkO
	 5WKvNWkyiemkRVDopWVn5zvypcbXeZ81gQWPZzJIXdPrDvG2r1BsnT7Msjo5jHhyyEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795682754;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=AJu04eNoB1sBlEXHCPuiDkza8mteAHzav0QvwSSwQK0=;
	b=IwBiRfHo7ZHdi6EDZ8H5PiEVbirsz2fQpN9aV/QTjvs0Q3z6feXHybS/Wbm+us/vFXMf
	 g071/kXd+HhuwgEdtOwU4+tPEYMFA7ZZyM5B5zRoaTM1jyz2UCVAfVyyVt5DY/xlqSevv
	 ywqI/lPMo/b+4UoMkNC404grOtE9eaLFkGwdVc4jRpzcoPaIbzrZdajRyS/yBudbZAJ/0
	 fbPPODpwx/deD2zCgYIix7u8NvFcAmaLzzorYhPpH5GflHySdlQIiyLQDJm8Jvs63Ryhj
	 RBZ1xd0r1hmMPrpjze1CDHV6v9pnSReP8YyoYqw1dehesbqj/eI9mZ5mx4Mw9MMMIQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eTfmiHtH;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057CA606A329
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 08:45:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 057CA606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eTfmiHtH
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2f02b9c1f6fso46699185ad.0
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 00:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795682753; x=1796287553; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AJu04eNoB1sBlEXHCPuiDkza8mteAHzav0QvwSSwQK0=;
        b=eTfmiHtHARlh1l3Oq0yk7fmF9qOswcLuF1wfU8hNzwn1a0VoAoJriwk3MBo0VZRpr1
         P8LblYEeCxa7e9hM/u81XQXgLYwLg55y2+Su6PSifNeLxtU6wwbKMINdpaKfJB00r7vI
         RQ6qm5MnDngwJxUNGj0XN3B3VrT6Oraae/FEGMCnel5Bj8wRmUN6pcnYb3svmmG43PUv
         J00A2xLLNs+Z8/AcWGDIoSoZQ/AsljOxoUQke4LNmzrMCJLCZY0ZvuM38iVxNuJ28g9w
         VbTd3lcTg/arMSbqh5lkwywdOJd24mr0KINa+lPOHjldODGhfyWpRWok+mKjol9d+Y+X
         Vy4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795682753; x=1796287553;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AJu04eNoB1sBlEXHCPuiDkza8mteAHzav0QvwSSwQK0=;
        b=MXF4v3NDGzZM6gKsVzk+CE7N+szv0K/tGGZJfEJ7y/GJveHjxIbp1/bhdaaneuzQxT
         eMmadbYOKnct/l9OqSTDbyhBYfkeDV0eOq5lCu4OjJ7yP2BsG6MJOPaG9EO4pFEM9Zk4
         aVGy6bj9as0g0+DZq1Grs49ZzRsxu6TgNByJ999AGDkzokX7S1OtX9lp+jdQodEY4fC8
         YOMkellFESOaClYR322vjFLLMuAw9fFNsrk3aE2UgU7sOFgDvtBDB/Cs0zyU6jUL0mPc
         fz9/eDx8WNPG6CtRMA87f/hP/uKzzu+4TOZCaBlnBlu6+2PMLR3GHeVQaMZYPCdgIET9
         xwfQ==
X-Forwarded-Encrypted: i=1; AL+hErFrKaNCP5MDXGbPghTxPL8rLGKbPZujm3S2M5cR299DuUTRIks3iOlEXDOxBcTYScLpE3KNuWk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+UUpxDtRpESsPRptW30I9LgrSfr/utGUM4ANPWFQ2NNeqTNVhr
	16+I6iqK5ple+rmf4IwdGpcEmpzn+od42lEl6q4OjbAhXQcoAmanwuXP
X-Gm-Gg: AZFdTZfinQAGlBo5ZPi6esrfFGtd7a4hCP6olnVo63LGEks0KkiZvij0yrESPh0QmLx
	W3jg9ZbgvWmNmWeuvdIYQzvRET2u8ThUiIXZ1zItv/EPv5hhX6EagsSBzdTQRbw01NA8ixHzCXn
	dr/2C38ydfxCF2iQ6SYsu7CjPwIF+YdvDzfwShZOoqwHQqpIC3EFxKAxfcsrAr6WyQ0TGc7zHor
	H6cnNJh7OeGuOF6RFiZD/wYQA9ZBkmv3s/Gq5EDifTKxnqu7aYs6RcUpSRjheyOqs2mIpie3kj6
	W8xbIUFkhacgEfCHa9kLBN8EJDtaKtds9+UatQyzJf4mXGXyhxk5zSc4+ncgae3G/aB+dPmlYzT
	e2bQkAfhKfHo0Z86JNiukISKtcSw9SOgZlyXtq5O3kFAZM5jakzv8wSDefX5eh9/PmjKMFl+Zsl
	bsa1a6ElqyFBd21aeWh7r4GH2oOjwQD5SMUoH+wqXYKVtglfZ9xLeMNrYYDjyKLIPsDJO4AfJAq
	Ft7sTv3q7t8tGodfpX/gmC8KCrn1SXMuLfCmrpJjjqtn3efBMwjONzxY86dFHyLBSYu4LYH8c1K
	Zp0bxhhcQo12q2/j8kM=
X-Received: by 2002:a17:902:ec8b:b0:2ed:662:e485 with SMTP id d9443c01a7336-2f03efa420fmr137669995ad.2.1795682753264;
        Thu, 26 Nov 2026 00:45:53 -0800 (PST)
Received: from localhost ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f08d73dfe0sm65354835ad.69.2026.11.26.00.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 00:45:52 -0800 (PST)
Date: Thu, 26 Nov 2026 17:45:50 +0900
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Hongling Zeng <zenghongling@kylinos.cn>
Cc: linkinjeon@kernel.org, liubaolin12138@163.com, ntfs@lists.linux.dev,
	linux-kernel@vger.kernel.org, zhongling0719@126.com,
	stable@vger.kernel.org
Subject: Re: [PATCH 3/6] ntfs: read initialized_size under size_lock in the
 iomap paths
Message-ID: <awfxvg7w_i49JxBv@hyunchul-PC02>
References: <20261125073547.154150-1-zenghongling@kylinos.cn>
 <20261125073547.154150-4-zenghongling@kylinos.cn>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261125073547.154150-4-zenghongling@kylinos.cn>

>  	if (!(flags & IOMAP_ZERO) &&
> -			iomap->type == IOMAP_MAPPED &&
> -			iomap->offset < ni->initialized_size &&
> -			iomap->offset + iomap->length > ni->initialized_size) {
> -		iomap->length = round_up(ni->initialized_size, 1 << inode->i_blkbits) -
> -			iomap->offset;
> +			iomap->type == IOMAP_MAPPED) {
> +		loff_t initialized_size;
> +
> +		read_lock_irqsave(&ni->size_lock, irqflags);
> +		initialized_size = ni->initialized_size;
> +		read_unlock_irqrestore(&ni->size_lock, irqflags);

Is it safe to read the size again instead of reusing the first one?
And the size_lock is missing in ntfs_iomap_read_end_io.

-- 
Thanks,
Hyunchul
