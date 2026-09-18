Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443854ABBCF;
	Fri, 18 Sep 2026 08:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789719368; cv=none; b=NRdBADxSsEJg9JPioj9TVjlLoEvXYtIw8FXU0CWqsZKyERzIp9uG3DHTXCtnOO28DzN2TuF/bYuCKTMrwKNX59zAOKgWiCDDEr0HQboAb/MPJ/phOdHSYDdGdyX0kufuXieiA1ErX+i0yIVD2GquwslWR1sk7FLuBKfyWxwvPcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789719368; c=relaxed/simple;
	bh=+V3/1DOqgMaYKjleHm6xIwW/ABtuVUtXvkQ1Fc4EzVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZTgECG5XtrkW/+d5Ce7/5wKeAKEpWwzZH6XJRs18/M2HNFAsZpP5YAooYTWFaa/5zai+GL0jlOJboMWP7jJQorbxmRWuzbw2QDUJ/LqygEO41ktpPJNENtiKdxrw2zYEUGVYoaB2fFLn5mGKlAgba1GZ7poHLNbBwCkv0Sl5V+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MRF1hfJz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MRF1hfJz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD4411F000FF;
	Fri, 18 Sep 2026 08:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789719360;
	bh=+Cp3hSVo5L5ISVN/5ayEdJk1wfGN18KBr6Nt7dKeASo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MRF1hfJzDSWFuLJlj0zPUYNfcbdHVExqxdsAg3xCJyO3QhEPsa8TnbUU/7cMmdWFB
	 b+YbxxrravLMtkK8H/Lqr2+6RtGAJoNbVsnw+M2HGy4MEHfAk2/uv9+AEVrOZiADP+
	 3q69CrcmGPSlbOPim8lJiUWes8DHrowdUGa+xJyY=
Date: Fri, 18 Sep 2026 09:14:03 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Adarsh Das <adarshdas950@gmail.com>
Cc: rafael@kernel.org, dakr@kernel.org, driver-core@lists.linux.dev,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+4393dfdddf166f2de2b0@syzkaller.appspotmail.com
Subject: Re: [PATCH v3] kobject: fix uevent socket use-after-free on net
 namespace delete
Message-ID: <2026091847-comfort-magical-5535@gregkh>
References: <2026091732-armored-lilac-fec9@gregkh>
 <20260918060826.8434-1-adarshdas950@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918060826.8434-1-adarshdas950@gmail.com>

On Fri, Sep 18, 2026 at 11:38:26AM +0530, Adarsh Das wrote:
> When a network namespace is deleted, we free its uevent socket. But
> sometimes a device in that namespace is still being removed and tries to
> send a uevent through that socket. The socket is already freed, so KASAN
> reports a use-after-free.
> 
> This patch attempts the fix of taking a lock around both the send path
> and the free path, and clear the pointer before freeing so nobody uses
> it after free.
> 
> Reported-by: syzbot <syzbot+4393dfdddf166f2de2b0@syzkaller.appspotmail.com>
> Link: https://syzkaller.appspot.com/bug?extid=4393dfdddf166f2de2b0
> Tested-by: syzbot <syzbot+4393dfdddf166f2de2b0@syzkaller.appspotmail.com>
> Tested-by: Adarsh Das <adarshdas950@gmail.com>
> Assisted-by: LLM
> Signed-off-by: Adarsh Das <adarshdas950@gmail.com>
> ---
>  lib/kobject_uevent.c | 27 +++++++++++++++++++--------
>  1 file changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
> index ddbc4d7482d2..cb674c2c3432 100644
> --- a/lib/kobject_uevent.c
> +++ b/lib/kobject_uevent.c
> @@ -13,6 +13,7 @@
>   *	Greg Kroah-Hartman	<greg@kroah.com>
>   */
>  
> +#include <linux/cleanup.h>
>  #include <linux/spinlock.h>
>  #include <linux/string.h>
>  #include <linux/kobject.h>
> @@ -411,9 +412,14 @@ static int kobject_uevent_net_broadcast(struct kobject *kobj,
>  						    devpath);
>  	else {
>  		const struct net *net = container_of(ns, struct net, ns);
> -
> -		ret = uevent_net_broadcast_tagged(net->uevent_sock->sk, env,
> -						  action_string, devpath);
> +		struct uevent_sock *ue_sk;
> +
> +		guard(mutex)(&uevent_sock_mutex);
> +		ue_sk = net->uevent_sock;
> +		if (ue_sk && ue_sk->sk)
> +			ret = uevent_net_broadcast_tagged(ue_sk->sk, env,
> +							  action_string,
> +							  devpath);
>  	}
>  #endif
>  
> @@ -804,14 +810,19 @@ static int uevent_net_init(struct net *net)
>  
>  static void uevent_net_exit(struct net *net)
>  {
> -	struct uevent_sock *ue_sk = net->uevent_sock;
> +	struct uevent_sock *ue_sk;
>  
> -	if (sock_net(ue_sk->sk)->user_ns == &init_user_ns) {
> -		mutex_lock(&uevent_sock_mutex);
> -		list_del(&ue_sk->list);
> -		mutex_unlock(&uevent_sock_mutex);
> +	{
> +		guard(mutex)(&uevent_sock_mutex);
> +		ue_sk = net->uevent_sock;
> +		net->uevent_sock = NULL;
> +		if (ue_sk && sock_net(ue_sk->sk)->user_ns == &init_user_ns)
> +			list_del(&ue_sk->list);
>  	}
>  
> +	if (!ue_sk)
> +		return;
> +
>  	netlink_kernel_release(ue_sk->sk);
>  	kfree(ue_sk);
>  }
> -- 
> 2.55.0
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
