Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7416F3CE4A7;
	Thu, 17 Sep 2026 19:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789672295; cv=none; b=U0Q+8x/SVpycq8S+cNDxbTHLtzZpZFr1mqsp4dblBu0TI1dPsGk3n8j1om8WFnEXBfP6zGZtgUYDFSo05xdPLtVJPJ7xlH2FMpc6hyVN1f/qFQrw5lL9u4N+ZSfK+K3DaNMKp/glVLvq0NRNfkOTVnun+aI31sM4qKwoodz1n98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789672295; c=relaxed/simple;
	bh=8dYhBMXq0lCNW7h93AAm4heQkK2nmjWl479zcNgduso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nCuzK4P3r5LlDwvFBBvxMFM6+GAHmEKbfn+tmZWb2rl86RrUakP93o7xhotOn087Vt81SlikywTckNsekV6l6feIjD6HBZwOjy33A8V7kro894gl6iDDF9uwkcsT+MW4yz+xKmTE4loeEv9sSbZdqrkE0+XSbIdFiuvW39rpBY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ubw9lIfx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ubw9lIfx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80A1E1F000FF;
	Thu, 17 Sep 2026 19:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789672294;
	bh=MTTm78Ankb9u9LQFqOxbeYNmtoWKaSyc6HDOI0Os6I8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ubw9lIfxYo84FLhWxI5gCf4j8KFHqBkva54/0sA3Ev+gkcw2VhaYfRiAQqrAxuhna
	 mCEPG7KLQJhkZvVaxgA7xZ7dP2YkDpEgI/nAA32ZdMhQ4zZaQ0mISKNZ6NT3J5vGhX
	 Yz1ltnlWQf0zr4lCIrWY5GsBy+gEvbujYgo+iEAw=
Date: Thu, 17 Sep 2026 18:40:47 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Adarsh Das <adarshdas950@gmail.com>
Cc: rafael@kernel.org, dakr@kernel.org, driver-core@lists.linux.dev,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot <syzbot+4393dfdddf166f2de2b0@syzkaller.appspotmail.com>
Subject: Re: [PATCH v2] kobject: fix uevent socket use-after-free on net
 namespace delete
Message-ID: <2026091732-armored-lilac-fec9@gregkh>
References: <20260917144206.85836-1-adarshdas950@gmail.com>
 <20260917170826.102362-1-adarshdas950@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917170826.102362-1-adarshdas950@gmail.com>

On Thu, Sep 17, 2026 at 10:38:26PM +0530, Adarsh Das wrote:
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
> Assisted-by: Cursor AI
> Signed-off-by: Adarsh Das <adarshdas950@gmail.com>
> ---
>  lib/kobject_uevent.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
> index ddbc4d7482d2..ecba33abb6b1 100644
> --- a/lib/kobject_uevent.c
> +++ b/lib/kobject_uevent.c
> @@ -411,9 +411,15 @@ static int kobject_uevent_net_broadcast(struct kobject *kobj,
>  						    devpath);
>  	else {
>  		const struct net *net = container_of(ns, struct net, ns);
> +		struct uevent_sock *ue_sk;
>  
> -		ret = uevent_net_broadcast_tagged(net->uevent_sock->sk, env,
> -						  action_string, devpath);
> +		mutex_lock(&uevent_sock_mutex);

Can't you use a guard to make this a lot cleaner?

thanks,

greg k-h
