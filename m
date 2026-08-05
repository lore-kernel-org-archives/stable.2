Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603CD3603F6
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 07:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785916347; cv=none; b=WKsOy7boE5MZmw5W3KCxdjNlQ+Y8QgfYbeEViFmcynKtkuebv4Xgc0e9q/Sck8mp2tg1bTrlw/N9trHSOWVUXCOKFKVkpOP80QwQkRl6df68Eq8tE4o5VaGYPPZoI45D9FONtXJrbu1nUUQM4aVffqxXE3YrsaEQRYcxUPF7ol8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785916347; c=relaxed/simple;
	bh=7dSFb+twFlWMSsdiGYvz5fluO8g1RLT3MUlJuUwjpmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lTBvdGga4PJ8zj7nb0G3+3cviq23eESSooIZG9MzRQlDENGT9HdhSv76VZ3HIsj7S0PHH9XKBEatouQdKjX/VvN/9kDT51YhTcJklufeVBKMztDKRHMH1SarcfGHYAsGNxlCJ23FXcqKjOnKbTZrYQ4FGiDMVHV1wdxwlXMmIRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=Iw/XNB7F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mFmJzGUy; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="Iw/XNB7F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mFmJzGUy"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CFFEA7A0184;
	Wed,  5 Aug 2026 03:52:24 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Wed, 05 Aug 2026 03:52:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1785916344; x=1786002744; bh=7dSFb+twFl
	WMSsdiGYvz5fluO8g1RLT3MUlJuUwjpmI=; b=Iw/XNB7FJpvYuVSdWo0woF+rnJ
	i6kV/u7lmtR4Y/FztNPscNT2XG0jXQiK6irp+zn4EEnEhUynO4tm6ZnYG7T7Bz0B
	jtsGGvnZ6u5W6aeVi0WVWflbuphcl4uRsIp1S6jawLLhWHKHmJGjofXrDcVu9QhZ
	u9a4l9fbNUqwY42zI5Tdwo3Ws+VkyVqKV7iqOq/5U5QYK81VUM0XuUV9VXEg18dJ
	EC7VyV6LFy6fRBRSM8AoXZZ+OVvjLaT2znx0zTN0Da+eK3871vBfu0IvcwKU6bsv
	l8p/6p3qokEKVCcjK7DtLkM3I1rNbHW1smhbEuhRkCwAXBE+sLYLxqFSkuYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785916344; x=1786002744; bh=7dSFb+twFlWMSsdiGYvz5fluO8g1RLT3MUl
	JuUwjpmI=; b=mFmJzGUyJv31dKU3p/a78+pEyF6HR5KOL1lJDWyveVhC2ZkvpEK
	MU7e04yvYsNCi1nf5o/3czvejwgaiw72KaRjtcVuGFwyQo4zmgJiuSqvm5IwHc7w
	VmcP5+Nv0G1kHJ7OvoD6F5m2umdj7FZX3flf+BwzrCh+II1sc/FsFt/9IoSe++dC
	ZFV0+4bK+CCkJPloPq1MLhTwGAVxu3Hqo+EuwOlvAamqEEWnguiNQ8aH8rI/j4pc
	/nmy7OMNG4aSgaAE9v1mfomvMW68sLyzwFhoFOAnDMnh+1KF6bpw96QccJu8Gwui
	2aiQ1kJAwwLbFEhwJCPafQ/ZPhZ3zfkWF+g==
X-ME-Sender: <xms:uOtyasz4-Lzm2IaDN8LH5rNoikvWKbizVVYlcgk0JZU8SoWV7TOIxw>
    <xme:uOtyaq8PP4yRmYsZkOe8ZXnJ8hjxjy9eUx2052usueJMHWtTrzx1Y7FxPYO23P0NH
    ZvmN-C1WEbBmQMu3KVSfMtziCFH-RLZqwkq8VLS2I-0bb1AhB8>
X-ME-Received: <xmr:uOtyak-aBKMqqUPjCQEkc10YPtSA56LP0TCDlOt2LQtT52N2kqZ1_mZpNarM6zkFw10QuQY97OJ1acjQ91hXbeHm7RQirmDcMljosJ0M_SA>
X-ME-Proxy-Cause: dmFkZTGzDTqs0VoUF5Hbo0kp33jNGh6y0/167eUXoUAvBXZXBg54ixquY2YD6TTz+/h1ma
    qMTgEAr84zACToWtd7VV9hTNBZgzeBeVspfs6VZ41sfrVDwzcrch2ifuKUejBbrs6iWmGp
    ezXdBogxxGnwbMPNi3wq4ZXCO6swQl2iOk25EdIPJ6IQE84VI6kg5bfuPbxW367yNVoyJH
    8GZC/xckjZ3VsyUxXYtivDZTrvmaBPPBPAKsDwhRrPZDizSFi1i09V5xbaDOqeGegQfLo4
    ak2rgOmb+DhKW1Hs0BvfOz/ZXWflDYJL8gWulK7iQMcLNnPf1h5LohhGMIB8A6d/B3t8fm
    XMl6cj7QVEb23RsNh37SZ0Io+75GD7D8bUUvoxPkKrjkMV9Tyi8L5iL9x7NmqHteCh+epC
    m8UPRL56rDxSCcbwSMA/CwpmWJazyY3m/2xMao1svjueM7OCf0u+WMcZ6XlgGIl9WUK0rz
    VFnjblkkTll/dUdpwJdRrK19nNu26nVISCmYNz1ZTDZJYZS3GLQsTtDUzIxaO+4hfbWw9s
    zSRIDd3JxNvSpZcI6Xa3qAPKNElemCFBmJI1FaK/OQ3QMY4GwsUocjf4fbfAREWlMLZxVq
    ywvB05/ME0mqhpDwSROP5/Co4tPw3/kyicF/HnKEgXnv8jL3OIhwmvuAlshQ
X-ME-Proxy: <xmx:uOtyaldJles4VawVGZxEyKLzG_DKgfHgQJU4FKwuCHCuUO0JbMVVYA>
    <xmx:uOtyaouDR8dpCBrh-rLZduVCuCIzIp3Qb2p3qteYLivOIwCbXBMGqQ>
    <xmx:uOtyam174EkivarNskFOka8Jqn3uyrI4kcovgciRhrzENh3T61yrkQ>
    <xmx:uOtyatA6qw1t1sr3hmbKMBk6u1xkUAXaJ2HZmZc4lkXmIZm0pg1Pqg>
    <xmx:uOtyapJbXTB2OBeeux-w8G7x3nOkLJCF5oMkSKboQgY1oixCo6kFbR9P>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 03:52:23 -0400 (EDT)
Date: Wed, 5 Aug 2026 09:52:06 +0200
From: Greg KH <greg@kroah.com>
To: dayou5941@163.com
Cc: akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org,
	ziy@nvidia.com, linux-mm@kvack.org,
	liyouhong <liyouhong@kylinos.cn>, Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/memory-failure: fix concurrent access issue in
 min_order_for_split()
Message-ID: <2026080559-expert-encode-c1b0@gregkh>
References: <20260805072625.2437636-1-dayou5941@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805072625.2437636-1-dayou5941@163.com>

On Wed, Aug 05, 2026 at 03:26:25PM +0800, dayou5941@163.com wrote:
> From: liyouhong <liyouhong@kylinos.cn>

Real name please.

thanks,

greg k-h
