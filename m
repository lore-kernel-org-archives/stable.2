Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2033538839E;
	Wed, 16 Sep 2026 17:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789580832; cv=none; b=a4lqWjCKCIkdywE0EIwig0Jlm7rxH8CXH6VrdPo+5jvpcGjJ80Aw33U4FgQvIGxEFe1x0uY+psy7tU7B52/DD9M260UeLThDzVw7+B6qO+YoU48Z4zPBWTfg3O6ZejzFgf3JKY4JQ3WcwkFbGLMjVX7wo7NhYkHtT7k370zNXoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789580832; c=relaxed/simple;
	bh=K88iATTTm7kGCuRKeep3yTvPvZ8+d76icY2NrKIx3aE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YOM935u3raohePZY9OnBzx5+qNNQsBxUi+BDElZgQLYG2ri3VmCLrTSDTowjcNrOyL5pXVuxm7THMs26VtXkreLiUOhINm7LDiDZ7nlaDRQQlLZzbk0g1J3bfpSWrGs7aDOz7O43z2BjEDgzuwb2mqh1a/7YCLpFjpf+TDbxcQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tbZMYTk7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tbZMYTk7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5EC21F000FF;
	Wed, 16 Sep 2026 17:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789580817;
	bh=5GG/GMPNjBmm503BWiOnO6Jmq6NNLao06rv1hFeAYrA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=tbZMYTk7YjxSV50/UFDC929r1et7OzkAlLI7oAY6IDNYMaSIgiqU3tVBuIBAv4H0B
	 eEz4XXfiDBvNWGS3+zJzhwcdAN0pcC4xMKD/zsep2hpMsQU0kUTA3DKPG5LGwvOPnW
	 Wh79uxvLzk4bf1JDwYIF6RqJoEE4tg2zeY69/IVc=
Date: Wed, 16 Sep 2026 18:38:12 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: b-liu@ti.com, balbi@ti.com, fabio.baltieri@linaro.org,
	linusw@kernel.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] usb: musb: ux500: Fix transceiver leak in
 ux500_musb_init()
Message-ID: <2026091648-ozone-opponent-8a42@gregkh>
References: <20260916165055.2085246-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916165055.2085246-1-vulab@iscas.ac.cn>

On Wed, Sep 16, 2026 at 04:50:55PM +0000, Wentao Liang wrote:
> ux500_musb_init() takes a reference on the USB2 transceiver with
> usb_get_phy() and stores it in musb->xceiv. If the subsequent
> usb_register_notifier() call fails, the function returns without
> releasing the reference, leaking the transceiver. The only place the
> reference is put is ux500_musb_exit(), which is not run when the init
> fails.
> 
> Put the transceiver before returning on the notifier registration
> failure path. The notifier itself does not need to be unregistered
> since usb_register_notifier() failed.
> 
> Fixes: 0135522c4898 ("usb: musb: ux500: add otg notifier support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/usb/musb/ux500.c | 1 +
>  1 file changed, 1 insertion(+)

Again, you need to add an assisted-by tag.  Please go back and fix up
_ALL_ of these to have that.

thanks,

greg k-h
