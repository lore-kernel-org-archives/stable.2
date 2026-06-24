Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD42225B0AE
	for <stable@vger.kernel.org>; Wed, 24 Jun 2026 09:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782294245; cv=none; b=tsvwSrnk93u1hnf+DWpFpDGFIhwzy4L8jF9CsUrrFqLzwnFv5Oeb1thd+ZcFUMJhmE66BDcFOTCzzEvUGE1omMM2etpyQuBPqNJyKakGtiKwcbUNalJ6GnPUe3XbMJRKn5XqKNdLI+1IAwn48/4qkq5WK1yBTZVDzLulgJuA/SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782294245; c=relaxed/simple;
	bh=DkfiNip9gvyz5mAVZwLGn9pHn6AMMbIR6YtLs/F+Pzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qvvdU9EHJENVwouyEFgF+g+T4O9eN2UMSDKGsP3t9DFFkr+LTsS2o1oFoy+19HEPnrULk/iBVDGZfccarW6ditj/GfSUQZOhj01b2pC6yagXrYsZeE1MDNBte242/zS3+HSEnCfHPE8WWAsyar10QJRCJ0xjwuwdlpV23mKvdaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SZlFEU4D; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZlFEU4D"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-37c867bd3e0so510447a91.0
        for <stable@vger.kernel.org>; Wed, 24 Jun 2026 02:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782294243; x=1782899043; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6/Nm8rMgcjSABP2aayKy6xYMf5YMQOQ2B23LheDWb6Y=;
        b=SZlFEU4DRN5PWCyOExNKaxPfneZlBdNKaVyj9a8muDXJwCqPU5l/40dT9DsOo3FgHo
         IpS1W9sXdmchlLgzsvhxsWbIUIyrkrWCJXUnL8LD7Wlmp1T9ZewxTaw1cVaqULM7XsZp
         98NqKslPgC1BQHqMRtA3czYs3YIZjTW/2nARLzVJGHpfA6AVxr6gP7mIOxaAwy4F279i
         pZpbMpnTHYhBu3cxp7U3G/1bzt4dlit3Ckoba4aGCPzdoPjxrzJ0WrBENpo6WXJ6QLX4
         F65XIXpOQWaxn6om/0QjV7G01lSvbQI/Uz0cmw+vhlUX8gF5o17qvEUFi3d0u+ujFj2/
         urdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782294243; x=1782899043;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6/Nm8rMgcjSABP2aayKy6xYMf5YMQOQ2B23LheDWb6Y=;
        b=Gen7rUgcd28+wqR5ZasRWjx6dYFJ/F1DRxqK1KPKot6WRuSstpduN9iEM7GbMpG+Ms
         O2e7ikWImS9lCL58BcBpP6+MYmjwNGaR3gpoQ6QIgP9pb2Mx33TezjkaheJl2oqzy8nL
         hSGTzAgkcgbbQ3v+Iv4v48z4C/oJjJ13xYVzrwWbZOykWSwXEFh1M4DjB9OM1zjy4fMP
         0PpGDFy8K8KeCZV/JIqQ9OeakTIE1fTiLpKoGmLK9RhHsBh/3otH4a3LGIo73cTYcmOp
         RKuGT0w8xH2MdZ/rw7uD38CnHMi42QIiRr1zP+HVbGv3OYWvOypf8eUjaZWr9pAtEt7i
         qsCA==
X-Gm-Message-State: AOJu0YxrPya2RBwgkret+LdBJr2acxLJP/0HomJmUYImHLaCnqtIlUiD
	FaxPWByp7QEVJxdvbAiXk+eTo+M7AOYLlmHd7B+0qs0kevIn6WEaCyMT
X-Gm-Gg: AfdE7cnzHWmOWxq6Zd4yW0/GAHtuJrcjgCYD5qlt98Dxr+ILPUtnl/KK6QKxMh1xDwj
	sFAKTf7Q/OmPpEDvEoXnT07y1MlEWpuvWa1fvLcS5fG1O5l4ZF/bJYveZ4LyEZLS9gp6pWPndVi
	ZjU73JM9bg8ujqHTBI/effa9nThgLXXY86wTkPb8ODGFEDbJ4m2ww8lzhZs4WpSRUur0qk3EX3k
	xbGB1RySCYQ0qXy/T81BsUpgvoYJwVh7TjreZ5EEmHX6yIUNH4e4rHTA1JLL2MFuyjXtOLHMzeG
	IIbZNwtcbYWvZqPi1ZAkTNH6uHCjEuDSz/PHkv2MD3qM9UjWpWO4nd+BEoYnUCLG2524eNlPZoG
	ON7j3+yda5aq4baUkupLB4hhBuiyp19XIpzpE7NDwkQMTwjon7AstQOgvD+J52/Qcx8swCn9v1C
	I0BexcW3tztVgzkV0pEWcM43JEslOEwpQIdJpWAwXsrmyPjxBf1KF9Xqji8VOxfy4l9A==
X-Received: by 2002:a17:90b:4b10:b0:36c:e254:4db with SMTP id 98e67ed59e1d1-37de41aa52dmr2724532a91.6.1782294242992;
        Wed, 24 Jun 2026 02:44:02 -0700 (PDT)
Received: from DESKTOP-19IMU7U.localdomain ([125.242.148.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37de4d4b0cdsm619527a91.1.2026.06.24.02.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 02:44:02 -0700 (PDT)
Date: Wed, 24 Jun 2026 18:44:00 +0900
From: Wongi Lee <qw3rtyp0@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jungwoo Lee <jwlee2217@gmail.com>
Subject: Re: Please apply 736b380e28d0 and eca856950f7c down to 6.1.y
Message-ID: <ajum4HXbhgdRl6Vz@DESKTOP-19IMU7U.localdomain>
References: <ajuR7rZYU943EG6p@DESKTOP-19IMU7U.localdomain>
 <2026062417-conceal-driving-0ebd@gregkh>
 <ajujm9+82N1g/HgF@DESKTOP-19IMU7U.localdomain>
 <2026062416-amulet-paradox-cf7c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026062416-amulet-paradox-cf7c@gregkh>

On Wed, Jun 24, 2026 at 11:37:29AM +0200, Greg Kroah-Hartman wrote:
> On Wed, Jun 24, 2026 at 06:30:03PM +0900, Wongi Lee wrote:
> > On Wed, Jun 24, 2026 at 11:00:45AM +0200, Greg Kroah-Hartman wrote:
> > > On Wed, Jun 24, 2026 at 05:14:38PM +0900, Wongi Lee wrote:
> > > > Hi,
> > > > 
> > > > Could the following upstream commits be queued for the active stable
> > > > trees?
> > > > 
> > > >   commit 736b380e28d0480c7bc3e022f1950f31fe53a7c5
> > > >   ("ipv6: account for fraggap on the paged allocation path")
> > > 
> > > I do not see that commit id in Linus's tree, are you sure it is correct?
> > > 
> > > >   commit eca856950f7cb1a221e02b99d758409f2c5cec42
> > > >   ("ipv4: account for fraggap on the paged allocation path")
> > > 
> > > Same here, no id of that one in Linus's tree that I can see.
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > 
> > 
> > Hi Greg,
> > 
> > First, sorry for confusing you.
> > 
> > The commit IDs are from netdev/net.git:
> > 
> >   736b380e28d0480c7bc3e022f1950f31fe53a7c5
> >   https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=736b380e28d0
> > 
> >   eca856950f7cb1a221e02b99d758409f2c5cec42
> >   https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=eca856950f7c
> > 
> > They were applied to netdev without Cc: stable@vger.kernel.org, so I
> > wanted to flag them for stable handling but I send it too fast (before
> > merge).
> > 
> > I will resend the request with the Linus tree commit ID.
> 
> They have to be in Linus's tree, before we can take them in a stable
> release, right?
> 
> And why were they not originally tagged with the cc: stable?  That would
> save you time in the future as it would all just happen automatically.
> 
> thanks,
> 
> greg k-h

Right, my fault.

Also I just forgot cc'ing stable when sending it. I'll apply it next time.

thanks,
Wongi
