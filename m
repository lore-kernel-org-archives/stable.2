Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BED2D595B
	for <stable@vger.kernel.org>; Sat, 19 Sep 2026 05:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789795266; cv=none; b=Ne8bI/Ps/jaI4mVUZSQwgssFC+GB9wuL9GS7BKUodBEtjFFuqCGpVNKzD0aq9T3dHF99xGjhhH8JFNf2DH2dM8uRK/d1YShqmLxgpkbLH6cRNaMYfk2fEa8r6+Qp781hX0KfvcEvRi0e4FUGEB+jpKXRfqysVWjmozAhzFe+xYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789795266; c=relaxed/simple;
	bh=wbl/b1wY6W+ED0XWbMPTjA4NropJyaS+Z6oeRQIiRso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WKAg4TniqvBQ4+mmpDmOsXbSuiFpJlBkyWL1hQb5joOcysfjqCxq+nUqjvjRSZ8TOrNev7ZA4JxwmTYm+RoiS189MfuIrcEm8u+RxFDSHFvrAHAGU5DSYEPJK1ogYqxlfyYuOX/goCJPGjKjTS9d2RTuBv6HUzh5xGTiKJ3FGJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GbmYOiJd; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GbmYOiJd"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843172bff4so705913f8f.0
        for <stable@vger.kernel.org>; Fri, 18 Sep 2026 22:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789795262; x=1790400062; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=j71MR9mSV+x9BS9VkLQyl8CosM5qjIOpfqaZrZTUdQ8=;
        b=GbmYOiJdiQtLLFhAfH0/eR+T2OcdjMZzpLAAi9npE+7+DT+iK8AQ7lut6CLbBWwrmj
         6EEU7ouaJsJclQ0LpUGWg/aDVsV7yejy1um3XG6lOiuD5cn3+XJa2834AtgUZRj9z0dN
         0NoZjnXbN+Dxm4mtZkNaDUsEGRVIVITncRURYZ+icHE3rmDKxD19muatpD3Mo3gVbZah
         KxVOb9ZHciJNzRK2Sjd/nEySOl7lX9xxdcG6hoSMghnwSSGf53tLGrtPoOgY7e+2UStI
         LDXE9D3PPa4WF5i85+TnN2GNu/QqezYLtalvmTLVwWgq/7O42Rcsqk/mv93fQXRtvGxg
         FZKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789795262; x=1790400062;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j71MR9mSV+x9BS9VkLQyl8CosM5qjIOpfqaZrZTUdQ8=;
        b=WJViKZKfE4sNfzhQTJFtVFzCx+U7+BCUN8bTvcBUySkFJ+t2BlpnW9Sa7D60Q8u1CG
         FiEmmlM5MW3/zpnb04xffoyc4y4t/tyBOMokqK9fGn4xvY2PLILCwVC8DdqvM0yc49A8
         ew2IiM7IZJiwugeOCzKxsGxjIcTVXkAhP/IQd+96Em+FWyxPT1W0h0oCvLH61RvpqTCG
         1AIW3sVw2W/jwzjvWxp8HD8W1r8qD9AxDemwRwCXyuh6nuuzNXfsb7Bh4NUQIkPmyPxf
         XwPcO8eWJQ5BOtD9d8J5ev1wGhqxVfOdCotoWqYKSLL+YQWySt+/xIb9pKh20d720T/P
         NSPA==
X-Forwarded-Encrypted: i=1; AKwUvBxUB1BEFAZYOt4eDqSckEBr3Vw405p6DMovMHzfj4kT02RsjZEGTFmVVfSInHbZFfBq2EuMLMg=@vger.kernel.org
X-Gm-Message-State: AFuF++mV9KK/dx494xgoeeaLUoSsDSF6aoP0b+tzikhlaUbvveh3J/L+
	tWPJrisdcpUm1wm+f0ppD9xdM1PLY5ZIQaIfOffk53XKsG9vpxLTrK+R
X-Gm-Gg: AYBFou1I9fkCsRcQudm1DGf3R8mpC450sHUHyUcnGNM1c+kW6DbPIKizjvUdIltIeL+
	Xn1+LwxpFyuDBlN8L7jlDishAzqFCRkHE5mIKClqrMRhEhgNix5YbugN46kf2WywKjO9Zcp6u6u
	9fRgmmMcDHmQu6iQQTF2CMpEkx7KzUDtekK0acUyB4ZhAVMTUU+YYSD1cWWk3Bev1U0XkNvrX0+
	XBdKkqFx6IpucsaUCk0QVoEgLkYMHiI+fY/2T56seiAoXDz81MZKlwwT/+FrK02lpwfWMkS0YFW
	CwiQLpXFb9aKdnaUjx8AlB5Sp/Gyp50xv/AB+XuiI5GVoNpQET6xXkBH+aGiX8aXx+LT7l2c/vm
	0t417mZaESOnWwOnaso2dwHGHE/uBwFgF7NB5Vh0xyeqHLhW17OR3+gUheEQOi7MYHCBWagO2K1
	2uYeWjyrQw5e9X1nWdYkHX9upRzu72Qh4RgLAtF0Ea7JP377NonRgW4FhDqus9izd7IDyFUIaPK
	eVr0rg0J33O5/XyYGMR327Xbvmg2N34qvHO4TYYAw87nm7QfmAQmSBjAmI7+om/maThG2Ypj4ce
	NBKMozEh2DE0Pxfx4VhDOarqfWbrWJGCLMe3ZDeV/2rRzlyAOpbztIBkFCCi0jXWBqm7rgFUpCa
	hnQOwtVUzlFF4cKo=
X-Received: by 2002:a05:6000:4b09:b0:485:8ee0:dfc8 with SMTP id ffacd0b85a97d-4871e26e3ffmr6296658f8f.41.1789795262086;
        Fri, 18 Sep 2026 22:21:02 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-2a02-3100-a017-2b01-05fe-203b-7cd2-a640.310.pool.telefonica.de. [2a02:3100:a017:2b01:5fe:203b:7cd2:a640])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48724460753sm4170213f8f.10.2026.09.18.22.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 22:21:01 -0700 (PDT)
Date: Sat, 19 Sep 2026 07:21:00 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>, fuse-devel@lists.linux.dev
Cc: Joanne Koong <joannelkoong@gmail.com>, 
	Jingbo Xu <jefflexu@linux.alibaba.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] fuse: fix GCC 8 build with CONFIG_PROFILE_ALL_BRANCHES
Message-ID: <aq4bhxra9UsLG56n@gmail.com>
References: <20260811195733.38489-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811195733.38489-1-kmehltretter@gmail.com>

On Tue, Aug 11, 2026 at 09:57:33PM +0100, Karl Mehltretter wrote:
> diff --git a/fs/fuse/notify.c b/fs/fuse/notify.c
> index 29578104ae6cd..3370ae344f751 100644
> --- a/fs/fuse/notify.c
> +++ b/fs/fuse/notify.c
> @@ -153,7 +153,7 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
>  
>  	nodeid = outarg.nodeid;
>  	pos = outarg.offset;
> -	num = min(outarg.size, MAX_LFS_FILESIZE - pos);
> +	num = umin(outarg.size, MAX_LFS_FILESIZE - pos);
>  
>  	down_read(&fc->killsb);
>  

Friendly ping on this build fix. Is anything else needed from my side?

Thanks,
Karl
