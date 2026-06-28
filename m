Received: from lan.nucleusys.com (lan.nucleusys.com [92.247.61.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF3B5A79B;
	Sun, 28 Jun 2026 15:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.247.61.126
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782660318; cv=none; b=G5vNOrgJtN+wjjwPmsacZIUQSJ6XnTH2/IumL4tpLcljmTAjG9zV8Md65hK5msiHxCyQs8sGlp0ldv65YTJRzwJeUUS7Pi7umLSoft/dd8mecr9xQmzWhethBj3XaRL6xNJVhIU7ZZrbkKrBfTtsjgmqcZKgUfwZlOHPF+JctBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782660318; c=relaxed/simple;
	bh=w/epT0ahS6q94buTFyAQH/uBAn9kJQHvuxCbCRAFn7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pjh5+Iuy+YEH68gJRvcrRvdHCEfE0spBMxxk3W4hRRYriVOubILec9WJ5MJitD0D4BPA+XfoROQ5wS7UtUmk2CWa4WyX7yeuKpdISdM7RKJ6FVPa2EX7M3eKC3H95ocWDR7OuIPhRT6f3xPBZokWYKwbnM6/enXaBuWTSCD8ubc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nucleusys.com; spf=pass smtp.mailfrom=nucleusys.com; dkim=pass (2048-bit key) header.d=nucleusys.com header.i=@nucleusys.com header.b=PrTr3khF; arc=none smtp.client-ip=92.247.61.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nucleusys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nucleusys.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nucleusys.com header.i=@nucleusys.com header.b="PrTr3khF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nucleusys.com; s=xyz;
	t=1782659915; bh=w/epT0ahS6q94buTFyAQH/uBAn9kJQHvuxCbCRAFn7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PrTr3khF9brmi02LWzuiNOkw+TePq9rB+8wtA2F8urhbxgOUj2iTUm92/ffkVFE5c
	 p3o6MOZF5VMepLu9sHzrNRbq9KCE//icMrmMAetfJUmkvXaQHIuFxuNEPVtTMus5q0
	 zYHmcKXO8Mfheuh4Q0aUwW8h/TOABZzLMPleRYxxJJc9BVtd9VBJw4s9u5adct9XFR
	 ek8tsyJoP6zfKq11bA/Rw1B5qfVdObXd9NZLEJPctDXhAywg6/OqbCZRuNd2dP5EAO
	 dHzMXep4txsoWiu95LPsq/DW/ljOL/JxV25AN/ct+UnHmtEFhfmIeXNYNXzp/4wisz
	 ya+GRC3bOuXfA==
Received: from carbon.k.g (unknown [85.187.61.220])
	by lan.nucleusys.com (Postfix) with ESMTPSA id DB5B53FBC8;
	Sun, 28 Jun 2026 18:18:34 +0300 (EEST)
Date: Sun, 28 Jun 2026 18:18:35 +0300
From: Petko Manolov <petkan@nucleusys.com>
To: Yousef Alhouseen <alhouseenyousef@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	syzbot+9db6c624635564ad813c@syzkaller.appspotmail.com
Subject: Re: [PATCH] net: usb: rtl8150: handle link status read failures
Message-ID: <20260628151835.GC14404@carbon.k.g>
References: <20260628093929.44214-1-alhouseenyousef@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260628093929.44214-1-alhouseenyousef@gmail.com>

On 26-06-28 11:39:29, Yousef Alhouseen wrote:
> set_carrier() ignores the result of the USB control transfer and tests the
> stack variable supplied as its receive buffer. If the device rejects or aborts
> the request, that variable remains uninitialized and the driver chooses an
> arbitrary carrier state.
> 
> Report carrier down when the link status cannot be read.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: syzbot+9db6c624635564ad813c@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=9db6c624635564ad813c
> Cc: stable@vger.kernel.org
> Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
> ---
>  drivers/net/usb/rtl8150.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/usb/rtl8150.c b/drivers/net/usb/rtl8150.c
> index c880c95c41a5..5606490aaea0 100644
> --- a/drivers/net/usb/rtl8150.c
> +++ b/drivers/net/usb/rtl8150.c
> @@ -732,7 +732,11 @@ static void set_carrier(struct net_device *netdev)
>  	rtl8150_t *dev = netdev_priv(netdev);
>  	short tmp;
>  
> -	get_registers(dev, CSCR, 2, &tmp);
> +	if (get_registers(dev, CSCR, 2, &tmp)) {
> +		netif_carrier_off(netdev);
> +		return;
> +	}
> +
>  	if (tmp & CSCR_LINK_STATUS)
>  		netif_carrier_on(netdev);
>  	else

I'd rather do something along these lines:

@@ -732,7 +732,9 @@ static void set_carrier(struct net_device *netdev)
 	rtl8150_t *dev = netdev_priv(netdev);
 	short tmp;
 
-	get_registers(dev, CSCR, 2, &tmp);
+	if (get_registers(dev, CSCR, 2, &tmp)
+		return;
+
 	if (tmp & CSCR_LINK_STATUS)
 		netif_carrier_on(netdev);
 	else

IIRC it is possible for the message get lost in bus noise while the device is
still operating correctly.  So if my memory isn't failing me, it is better to
not do anything if usb_control_msg_recv() is non-zero and only change the
carrier status if 'tmp' contains meaningful value.


		Petko
