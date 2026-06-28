Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEAF2D592D;
	Sun, 28 Jun 2026 16:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782664865; cv=none; b=mvR2MYrQm1oc3jV5MIq2qnpxdyux1JC36a9oRxgghrDyFoCrHeqk3eUXkAUeBFkMZCndMqCYV9wWyuVKYAiiuZ3B62jOk1YfkJcgYMZLfY+VB15pepONVOO/IG60ynzQm+QVu77V64wMHphGdNwSja+huzX4LzmtBT07dYsWmv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782664865; c=relaxed/simple;
	bh=LSCUwICUqCuV2GVZLI+GD5iR/lyWdJWr3Z3gQRwcJQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LMwrPNleX60uWYbQQg2qerOFbalLrDOnR6BzHTqVvOwyYVOkkC0LvuWeeMB4oL8E+vs7CocKZsGFL3CblJKMscwMA9ATOhziDyseuRdkaeON5bn+KzBKdut9DhGAPg3d9v4P8AoO+h8YQ0qpxTIG4cYDQT090DtUfWc3fRFEN5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=OrimP6fT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OrimP6fT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=m/ThfnCA53xsojiK3CDkKqyB+7t20zZEYIXw4BzuvDA=; b=OrimP6fTdz343iL+WTwQ1+rjCS
	8uCXcEObsyaEJ4tFo7UPjtXRtkVAYWq1eDAKvM8AF8AIJmJSpt4TkO+0RA2DuU9/UPsi3xqtDFmIS
	3LdR6BjtQnk4UeM5HvJLK+tzAQzoBF1tsUg6jeFMwsPxo283gnklZmrBGmmIqv1kDWaA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wdsYo-009cMG-T7; Sun, 28 Jun 2026 18:40:46 +0200
Date: Sun, 28 Jun 2026 18:40:46 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yousef Alhouseen <alhouseenyousef@gmail.com>
Cc: Petko Manolov <petkan@nucleusys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	syzbot+9db6c624635564ad813c@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] net: usb: rtl8150: handle link status read failures
Message-ID: <31402931-dd4f-4dda-9637-2880350101d7@lunn.ch>
References: <20260628151835.GC14404@carbon.k.g>
 <20260628162528.8273-1-alhouseenyousef@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260628162528.8273-1-alhouseenyousef@gmail.com>

On Sun, Jun 28, 2026 at 06:25:28PM +0200, Yousef Alhouseen wrote:
> set_carrier() ignores the result of the USB control transfer and tests
> the stack variable supplied as its receive buffer. If the device rejects
> or aborts the request, that variable remains uninitialized and the driver
> chooses an arbitrary carrier state.
> 
> Leave the existing carrier state unchanged when the link status cannot be
> read. A transient USB error should not be treated as link loss.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: syzbot+9db6c624635564ad813c@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=9db6c624635564ad813c
> Cc: stable@vger.kernel.org

https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

Does this issue bother people?

I think it would be better to submit to net-next:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

Please don't thread patch versions together.

Also, a Suggested-by: might be appropriate here.

    Andrew

---
pw-bot: cr
