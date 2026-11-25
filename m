Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795618576;
	b=fW2oDLi8LRP9BoisRaYOoQINH81wFNw5dTfvNFYu6vZVY/cbtkeftqfIqKnoSOhc5qn5
	 1YuG+1qYvhsze7U9OAEr4YB08GlYqOXtjLij2UadRYGpeuylnNkc8KoihsLJnYkeZSO7j
	 aI14CkSp/SD8j3o+rpY5cxkyWwRNTDHfqAL/3lIYJnqvV10e8Elxbbn/vCRgvL/9p/tjN
	 21jN/3jBOXWvzQs2Z9fWBInzLUX3npJAMFTaELq6xEDDA0ugCkhQVanbJlfv6iooKVqx3
	 l5784NxTUtwOTeWclEb5UeSu4bltXhBjMnDcjl3gHnasPilMJd1Y0rm0d+IwPiS7z9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795618576;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=H2v9m8o2ZyN6mJNXof8J2YJUJ0qz0MjiMku6/OumPR8=;
	b=Xvay945oTYwNRxEd5Pl+b1rJCtnV5pQMPd9oRD0gomOz9ht1ajCBVfvbdJKpSraxcXrY
	 GLw+cbEJngBH+N3d930KGF0ojBjXHIit2dFtUif9p8mX1wD+i03E4LawpdZSShwhUqWZw
	 JSDhJ/WeCNwTQ/BJKJWv6lybEvSIpn7OgIq3puUE75vsA48yKig13XnCXns7XAA0rImS/
	 +aAlFjdarWGXoF9HY0eP+DWZd1NghDG9Q5C1cR3HGHO7q6CBEWDEoqEgR70ioFg8rbPey
	 eaHp1DgNKzt0p+svyss0Kddj5P3zJbHO8vgzFfYDhKibUhmFLtaozwZ92aAPzaveyBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=OYNxKfNH;
	arc=none smtp.remote-ip=209.85.222.175
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9FE606A331
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 14:56:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF9FE606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=OYNxKfNH
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-949680e6d83so529763285a.3
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 06:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795618575; x=1796223375; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=H2v9m8o2ZyN6mJNXof8J2YJUJ0qz0MjiMku6/OumPR8=;
        b=OYNxKfNHfP6AwkYsERu63zDzJAQPUGhYsCT43HZkjStcluGygKe12LuAexit9a5c6I
         2xHd+rFeUUWgQz3UD4v6ixaaQHjS+rxO6ULdO3fhPiUPK01Xq8/mBmvNXb1FFx0+5h+y
         txmt8Qu7dTrHwsvfmdLvBZVh1tYGu5ws2UTAxhQ4QQZ6wJ9BJZ0AHoMR77wCIUE8irGw
         yOJVXSOfdvyNe/kwEsFYcbGWMENmzqdQGwGisbGOpmrz0P+cscixGw43F3nRwhBp4hXK
         oAi1vBIDqzDf2RFEYLAzJgTZsaAnHnNnhRfu705bDSb63uQLNQ3FjPvM/ZEIm9FBbf+L
         49WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795618575; x=1796223375;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H2v9m8o2ZyN6mJNXof8J2YJUJ0qz0MjiMku6/OumPR8=;
        b=IXEjSly9O679py5jTmoTF+DgezR0JSDIEcN9QDgsHWIFd6ngCB8+0rAPpTb8xYMkiL
         diJkJMT0v36Q+/J0xGJLCpYUrS3pnaGmP1hSTIlcfPwh779v0vDj1B2Gi3x15orzGVvW
         l1uNYMmjKYcRI3X2hxriGtnmaXZGM8ykgQi0ZdT+hSggRU7qKoEhc93UlAbjX7SH/XW9
         KyVwvu/LbxadIflY1LafLhIz62KzzoPu2lAa3zlkojJKhn3oyoCHcg+vEVo4U3gANmav
         984uEXv+V3YaClNsLHI0xT7kd1RTQQyinkyli26nHxW4DpofgMbMEkP/kd5tmytMOTve
         vXTg==
X-Forwarded-Encrypted: i=1; AL+hErEIwusOMH0RVxEWkVAZ7PZHbaY1Jrh7fZvIjut9IF3+HLj2gf3zs0L0k5fIIMm/2lr9ANJrvPw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/dn3NHMyj6k3qklbSZkdes/HjUz3izryvOMws9LXJULkoQYKiL
	8/d2gTBa8TG0l8NKLbS/6Mbb0l9jQzrhDWx0ysG0ezWCU6QYpdUOAcwgIsS75TqXwOg=
X-Gm-Gg: AZFdTZedf6yRxJgMVcXEvn8hzuSuosvFhPy2jxYEqemN8iLVGPZxSu7eNiPujhhneS3
	ii74vwAXhMz24K3YHv/7lBEqIvScqZN7X1QUTfQ/i21rn8mHPpTe1b76I4qNiHy19xWOKH7pyEH
	H5yEq9yQpQVz+Xj8Q3RQX5qwsMI3yjuOQKk5kd1XYyPL54qa5byz5CVBa4T+Z25fyQAlaEemzrm
	O80ybMIVZM7qaM3xPZ01j0oI5KO1MkGFzxUwzQPT1C9ohVkFNo4H54XvqBJx8KHbglcIOKyyUzh
	beS6btBupq5xkeTprYud4E8YYS/haRvieDP7L1k4aDQtXKE+MNqU6GghOH7HsFRB76DN/Q4OmZH
	gJwxCjnJxIMC5NsHdZPwSPcjttTt/a3p9FXPmzygdQJL5DhrweZfkqSscC0yoL6rjOCVivn2iUn
	kgoyZvOmuyr9ViNUPtqM5hwIvgW6QRgeGl4Ex8nX1+wSOzSirZYj9o2bNDQ0at6XVwrnrtkFGX8
	wicsVxhEP2xECSQ2Xo04JZTroEk2iLziXHJk2kKpXTw3N9/BxPbwfLDq18o3GHHf1EsHOKDELf9
	ohq8vw==
X-Received: by 2002:a05:620a:2956:b0:949:9cf0:badd with SMTP id af79cd13be357-949bab2f511mr3135941485a.73.1795618574856;
        Wed, 25 Nov 2026 06:56:14 -0800 (PST)
Received: from ziepe.ca ([142.177.118.84])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb38c903sm1327013585a.19.2026.11.25.06.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 06:56:14 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xWEPt-00000001o1M-2tKn;
	Wed, 25 Nov 2026 10:56:13 -0400
Date: Wed, 25 Nov 2026 10:56:13 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jaeyeong Lee <lee@jaeyeong.cc>, Artemy Kovalyov <artemyko@mellanox.com>,
	Yishai Hadas <yishaih@mellanox.com>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] RDMA/mlx5: Preserve DEVX objects after failed output
 copy
Message-ID: <20261125145613.GJ246011@ziepe.ca>
References: <20261111105346.3220427-1-lee@jaeyeong.cc>
 <20261115135123.GD42525@unreal>
 <20261122103715.51731-1-lee@jaeyeong.cc>
 <20261122103855.51859-1-lee@jaeyeong.cc>
 <20261125131244.GB14811@unreal>
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
In-Reply-To: <20261125131244.GB14811@unreal>

On Wed, Nov 25, 2026 at 03:12:44PM +0200, Leon Romanovsky wrote:
> On Sun, Nov 22, 2026 at 10:39:01AM +0000, Jaeyeong Lee wrote:
> > As requested, below is the full dmesg from the reproducer run.
> 
> <...>
> 
> > [   13.847526] mlx5_dct_repro: loading out-of-tree module taints kernel.
>
> What value does this change provide if it is based on an AI-generated sequence?

More importantly you are not allowed to call
uobj_finalize_uobj_create() from new style methods, it is only for the
old write interface. I guess it is in the wrong header.

It should be uverbs_finalize_uobj_create() if you want to use this
sequence.

And it should probably cover devx_handle_mkey_indirect() as well.

The idea itself seems reasonable, once we have done the actual create
command to FW it should use the normal destroy sequence. That is
exactly why we have the finalize helper in the first place.

But to do that right the entire obj_destroy should be removed.

IDK about the claim that DRAIN_DCT can fail, but I suppose it is
possible for a hostile userspace to immediately refcount any kind of
object and cause its destruction to fail and that does seem like a
legitimate problem to me, so this is worth adjusting.

Please send a v3.

Jason
