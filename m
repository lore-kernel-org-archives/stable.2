Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793443942;
	b=nFbIaEE/bR8P3tfUnx3mkZRvn0IyKt/qxuMkP1uUdm8T9MKXfgCfBJAbr4V+YW3ertrH
	 +FZAiFzAUbF0LDmtxRlR4IZod5+P4S4wH1A8TYuW7U2N2Gq0DfIBlhmD4LSARjSNyJYip
	 OS1zMZ45gyuWaaLn2XCW1QGBUCw6wMgm50BWyEbcrszDXMB9nY1Bh8pRzRMgxCy1gR5It
	 emSO2BY/+SI5fT/FMNg+OcGiju+F4Ziz6Y3DIamgShbCFhhnk4OXDfLgsZqXOJejrzD09
	 BLsaV6vRZqTOn6jQU4fvNVolnSW8jPfp6JEoxAcjZqpqDRraXR3YQLu9LUiAwt2RbVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793443942;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=azxbKHt38N4B5kQZ49B6bUjw72JkjofeSg5fPfNhX3E=;
	b=uJhcOrBP/muVF3IApU7YQoeFqdyxd8Ls2MFG6OYQsB+aeYMj7YYDw24oVW8llEd8d2Xo
	 xdDQwKcZnBGPATK8UMLgexVz8V3cKnmRlqAULC2rrpJoCFArt8pX9NXHIe/5CPKVt0eUk
	 AAeU1XgSkuLS8kxQZmzT7qXoi/BPWFhoVhm7RhKF+2keTvDtAfqmeFG/ZNzrOmxJWBk67
	 TkmbhV+2SXBSGD6Y2RAf2ZtmDQjltA5r5oKsawIl+Es73qmVUcBQEDSvsmv1oEh/D82Dp
	 qJ1SQXuSufqYWmg9RzSv3OWiy+3q4VZe1iMAlXX1wUEIsI5n6RECIdmn9tVsPJN9agw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=0wna6Yhg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A263606A31C;
	Sat, 31 Oct 2026 10:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=0wna6Yhg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DC011F000C1;
	Sat, 31 Oct 2026 10:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793443942;
	bh=azxbKHt38N4B5kQZ49B6bUjw72JkjofeSg5fPfNhX3E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=0wna6YhgYVRQLUvIOtfqyW+N2bov/qAiA2iQMDZfRPxufZJQ+aNO+73UiW6tNsNel
	 hMo9OizPVDDJTidUc8ZMdxANQvFlLZxSi3j1a6qjYFQhSZEKxcZGDydp0FbDl9bQLX
	 bXVG0bOqpgJKJX103nYOdcluQPtommkb159qiCzQ=
Date: Sat, 31 Oct 2026 11:52:15 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Struan Bartlett <struan.bartlett@newsnow.co.uk>
Cc: stable@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Tonghao Zhang <tonghao@bamaicloud.com>,
	Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH 6.12.y] bonding: re-check pending peer notification under
 RTNL in ARP monitor
Message-ID: <2026103137-stowaway-evade-1250@gregkh>
References: <20261030225119.40765-2-struan.bartlett@newsnow.co.uk>
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
In-Reply-To: <20261030225119.40765-2-struan.bartlett@newsnow.co.uk>

On Fri, Oct 30, 2026 at 10:51:19PM +0000, Struan Bartlett wrote:
> commit 70fc6649b36cf22167bbd7e2a6cc0960b746316e upstream.
> 
> This is not a backport of that commit but a minimal equivalent of it
> for 6.12.y, as explained below.

Yeah, it's not close to that at all, so please don't claim it is :)

We can take this if you get approval from the maintainer of the
subsystem for it.  But really, why not move to 6.18.y instead?

thanks,

greg k-h
