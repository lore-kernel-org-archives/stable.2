Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795661894;
	b=WS5tCvjHx/3tnAtvwOah4B8MKpuvXd7uQMGxnAiXBMmPF/jksOqKcpfrIVGATtQ8B/Wx
	 3SaaZ5Hr7ucBsJrOy0gmb/mk/pZucBOqatwDB0qWG8vyh0KTXvscZaj6086nFkeW6t1NX
	 7uDDkQgbIarorPrFBlXeKt37rkAUvTlvt3bezU4A2PGbdBrrhAE22hsRPWgYJYejMcRc2
	 jfQ9MtAsB0GeLAwO/F5EaLQ/nC2/ONMKk3UZBpeJyzc8K9JclLdpKF0pQLXTWPmQkoaR7
	 MWSrbHUJY73cGJPaUIEadUqUeBOvFJVWQCclRxUxkflXPSKClbNoWi9zIcCcgzCZwOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795661894;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=QOEcDp+7IJMgNzkrkV18FLHjUkTLg5/xxzENnntmIO4=;
	b=csEwBGYOrdGvdgs0GCeIf+/Dxt/wADdPbs/yGPgUZ3iz2CbVWsQCB5wrPSyk+C+BmOPp
	 kdXX9KJsBiCqdcjMOOy4HDXNlD5AnRSxow0XgKsBf0c7XpSip0L7DKnLrzD64Yiglimja
	 BdXkhMp/fup31kn4WMnskFCHgfsZTY6rXjXp5AhOvm+W2fMeEy6NFwhTmUBpTiNj0Yn8a
	 kVbAjmX62WocZijjHhZYFmz1xu2bHNUTw7wufTEqEiBEJ6d+oKZHdrUQ6rBSGxUdkIhlL
	 QFgCwicdqYJWaHzs5MuRFa6hA20ZvI6OQkAUVCdVWsqZFQbF2ULfPpVwDdalZS092eQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=ODM4lkrQ;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93992606A31E;
	Thu, 26 Nov 2026 02:58:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93992606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=ODM4lkrQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QOEcDp+7IJMgNzkrkV18FLHjUkTLg5/xxzENnntmIO4=; b=ODM4lkrQQTpzXvAYlWv/BdS8w6
	tndkhnfEVh4+YNxGBfECQczmlIJC4xUe0jnM06N8XOTTRw7ghYE9tj/DYsMEdxkbW4l06rCNWHrv3
	m/cFV0/FXtz6cW3WpcHaY3YOLIMyQ9JTbGHAeGhldUSMEFAccOttJmE3wh5W3XxeO65M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xWPgR-001ULd-68; Thu, 26 Nov 2026 03:58:03 +0100
Date: Thu, 26 Nov 2026 03:58:03 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Bin Yu <byu@xidian.edu.cn>, Cheng Wen <wencheng@xidian.edu.cn>
Subject: Re: [PATCH v2] net: ethtool: do not call get_regs() for zero-length
 dumps
Message-ID: <366216bc-ccc3-4547-8587-87cdf35f552f@lunn.ch>
References: <20261126015239.6038-1-25031212351@stu.xidian.edu.cn>
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
In-Reply-To: <20261126015239.6038-1-25031212351@stu.xidian.edu.cn>

On Thu, Nov 26, 2026 at 09:52:39AM +0800, YuanZhe Liu wrote:
> ethtool_get_regs() passes the user-supplied regs.len to the driver
> unchanged, including zero.  A driver that uses that length for its I/O
> then issues a zero-length transfer.  Such a transfer has no data stage
> and the USB core treats it as an OUT transfer, so a driver submitting
> it on the receive pipe trips the direction check:
> 
>   usb 1-1: BOGUS control dir, pipe 80000380 doesn't match bRequestType c0
>   WARNING: drivers/usb/core/urb.c:411 at usb_submit_urb

Your commit message is focusing on USB too much. Very few Ethernet
drivers are USB. Since you are modifying the core, you should make the
commit message generic.

> A zero-length dump cannot return any data, so there is nothing for the
> driver to do.  Return success without calling into the driver, the same
> way a zero-length read is a no-op, instead of making every driver check
> regs->len.

> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

Who does this bother?

> diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
> index 80b7930b3fe0..e8af861ee5de 100644
> --- a/net/ethtool/ioctl.c
> +++ b/net/ethtool/ioctl.c
> @@ -1779,6 +1779,10 @@ static int ethtool_get_regs(struct net_device *dev, char __user *useraddr)
>  	if (copy_from_user(&regs, useraddr, sizeof(regs)))
>  		return -EFAULT;
>  
> +	/* A zero-length dump has nothing to fill in. */
> +	if (!regs.len)
> +		return 0;
> +

Some of the kAPIs consider passing 0 as being special. It is user
space asking the kernel how big a buffer is needed to hold the full
dump. The kernel sets the value in the structure and returns. User
space then allocates a buffer of that size, and makes the request
again.

I don't know if this API actually does this. You need to look at the
logic and decide. But by returning this early, if it did, you have
broken that.

       Andrew

