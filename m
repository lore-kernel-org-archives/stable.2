Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0C818FDBE
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 08:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785053354; cv=pass; b=j86hXV+lxfaUQGjSVGUEfvcICePcQW2KsVcOH2UN2Suv278bZtX1Mo2kv1uevXwr8mo3jPFPGhq0hm1Pxs48rsE9FmuZ1AsjKs+XkvDUz8lzpI3AbVILnxCvmN52EqDMquo8Dt7nMIZj0NlKDQUFR6CGjyiKyAAO4X5XyCRfRi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785053354; c=relaxed/simple;
	bh=LXBtFs8J/GN5t5oidscR4+Hk+9/K4k9aulrh+Uz1ANs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BcxdRoIp4tk9NjbbRbywj3yk1B5zBjv2zAV8IPNKpVfPNUS2qkA24O3xvSwNwQWrNzr6zkwkOEjOEhP332hwsqrPlJSc4Vq/Sj8v7Bu+i3MSjx+7mOR2dQO6qC6xwEunc5pCZmIXwbMPc0qNdgH3RqhH6/qYoHQ+7bhXT2zF6Cg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=IKXOtwXz; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=yo0k74W5; arc=pass smtp.client-ip=85.215.255.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="IKXOtwXz";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="yo0k74W5"
ARC-Seal: i=1; a=rsa-sha256; t=1785053332; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Bw2Mf/ZxzFSfqRvMu5WKw+O5LTZj1snsl916YpHFcA5+LaA4jr+E8DJkgNbIMY5Ys5
    1ACBnCsX74py6R8W+N3zdA3FPgyQtVTeYXh1WYKBL+FiDVpade/DW18Ct0tShjdmi+9Y
    KI++GgOKM6au94XS0ccowl49XDqHY+7IyV4RHfy8WDdcNkaCkYTuCl9H1O9/fhXzWXrL
    qLo20BbvyJZnFITGp3+fnIZljd52Z8SdHHEgFlyjmAg+h15OZvluIY6lqdLYOrfTfsEf
    /7uQwfQBasdPo9ny1DGTN+IphKeduMdr4h7HNFbnsXJj1yqClK8NQ6sj3ZKWAs2xVLQW
    zdig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1785053332;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ZMYAbFMjfM3rf0ScLwVqlYLaJ3t+J8GkMCo8Ndx5leQ=;
    b=Zq4BfQscteKuYftaTm7OH2c81ufXzRlrTGkpQJcP4bZJEaOxCqp/YEmPEOBPTzZ07H
    p15Sq3DCo+oNhzF6yS7C1Vu2Fkfu7jUjcroJhOyhftCug2DYYwjcIo3/NYOHC/3YpFdx
    FqwQR6ryl1IuSWymo4XnA8zQxrYZ+I/s/iwdq+KlOuixxqNI4KE3R6iqsObx7MCyLVvf
    dSgPgmMrf3RwMBpNgtKi2nmtncvdreLpfqdK4J7dOETQ2pZLqJzz+PxnvxlZ+8/FpAjt
    UPDoth+rUCKP/686neUDGPVP8YueABrwXXIfcO1o6x8mkTDU66394U48PA1cU6VrfpXA
    sMcQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1785053332;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ZMYAbFMjfM3rf0ScLwVqlYLaJ3t+J8GkMCo8Ndx5leQ=;
    b=IKXOtwXzApz+IuwrgbHoCs3aKFJH68bxyfha/eWP3KAnPzXN0M+auJKYE8y4JVECAt
    y8rQdI9CKsM7UqIw3oNrt6WkNJlMXXckrUSMnTfi53F+bzF2SG4SuS26R57vciqaFufX
    ENXsXSPwXpxqx3Kd0ACdTTFcMdSj5zONDLZKPYCI/gdt6DGCrv6afaB3CzgkNl6MXTA+
    QuYzCDqNya+JukIqWYLSnLcY9Q85wBPuOJyDo4SMCp4vGj8C5LqxJ6CtpBhJP2x3ivri
    haz1oAHNtcJ9o0m9DPhUw97q1M5CBqcRMSGCkemoznue0ukC9JQxxc5wIKmZCQy7wstG
    +DKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1785053332;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ZMYAbFMjfM3rf0ScLwVqlYLaJ3t+J8GkMCo8Ndx5leQ=;
    b=yo0k74W5dcA8KGVQEzK3cp0ORwnpo1v0baMGXvU5yzO5RBHkGR/nDVN/cZXN5UkwIu
    JVVErZwjHWfU+zq/BpAQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from [192.168.20.231]
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926Q88q3an
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 26 Jul 2026 10:08:52 +0200 (CEST)
Message-ID: <0f3b44bc-41bd-446a-bceb-bb2c9581ee6b@hartkopp.net>
Date: Sun, 26 Jul 2026 10:08:52 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 03/19] can: raw: add locking for raw flags bitfield
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc: Vincent Mailhol <mailhol@kernel.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>
References: <20260716155528.809908-1-mkl@pengutronix.de>
 <20260716155528.809908-4-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260716155528.809908-4-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Upstream commit 1e5185c090589f4146d728ab36417d8a5419f127

is missing in stable.

Best regards,
Oliver

On 16.07.26 17:47, Marc Kleine-Budde wrote:
> From: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> With commit 890e5198a6e5 ("can: raw: use bitfields to store flags in
> struct raw_sock") the formerly separate integer values have been integrated
> into a single bitfield. This led to a read-modify-write operation when
> changing a flag in raw_setsockopt() which now needs a locking to prevent
> concurrent access.
> 
> Instead of adding a lock/unlock hell in each of the flag manipulations this
> patch introduces a wrapper for a new raw_setsockopt_locked() function
> analogue to the isotp_setsockopt[_locked]() approach in net/can/isotp.c
> 
> Fixes: 890e5198a6e5 ("can: raw: use bitfields to store flags in struct raw_sock")
> Reported-by: Eulgyu Kim <eulgyukim@snu.ac.kr>
> Closes: https://lore.kernel.org/linux-can/20260503112200.22727-1-eulgyukim@snu.ac.kr/
> Tested-by: Eulgyu Kim <eulgyukim@snu.ac.kr>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> Reviewed-by: Vincent Mailhol <mailhol@kernel.org>
> Tested-by: Vincent Mailhol <mailhol@kernel.org>
> Link: https://patch.msgid.link/20260504111928.41856-1-socketcan@hartkopp.net
> [mkl: use Closes tag instead of Link]
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>   net/can/raw.c | 66 +++++++++++++++++++++++----------------------------
>   1 file changed, 30 insertions(+), 36 deletions(-)
> 
> diff --git a/net/can/raw.c b/net/can/raw.c
> index a26942e78e68..82d9c0499c95 100644
> --- a/net/can/raw.c
> +++ b/net/can/raw.c
> @@ -562,8 +562,8 @@ static int raw_getname(struct socket *sock, struct sockaddr *uaddr,
>   	return RAW_MIN_NAMELEN;
>   }
>   
> -static int raw_setsockopt(struct socket *sock, int level, int optname,
> -			  sockptr_t optval, unsigned int optlen)
> +static int raw_setsockopt_locked(struct socket *sock, int optname,
> +				 sockptr_t optval, unsigned int optlen)
>   {
>   	struct sock *sk = sock->sk;
>   	struct raw_sock *ro = raw_sk(sk);
> @@ -575,9 +575,6 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
>   	int flag;
>   	int err = 0;
>   
> -	if (level != SOL_CAN_RAW)
> -		return -EINVAL;
> -
>   	switch (optname) {
>   	case CAN_RAW_FILTER:
>   		if (optlen % sizeof(struct can_filter) != 0)
> @@ -598,17 +595,11 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
>   				return -EFAULT;
>   		}
>   
> -		rtnl_lock();
> -		lock_sock(sk);
> -
>   		dev = ro->dev;
> -		if (ro->bound && dev) {
> -			if (dev->reg_state != NETREG_REGISTERED) {
> -				if (count > 1)
> -					kfree(filter);
> -				err = -ENODEV;
> -				goto out_fil;
> -			}
> +		if (ro->bound && dev && dev->reg_state != NETREG_REGISTERED) {
> +			if (count > 1)
> +				kfree(filter);
> +			return -ENODEV;
>   		}
>   
>   		if (ro->bound) {
> @@ -622,7 +613,7 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
>   			if (err) {
>   				if (count > 1)
>   					kfree(filter);
> -				goto out_fil;
> +				return err;
>   			}
>   
>   			/* remove old filter registrations */
> @@ -642,11 +633,6 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
>   		}
>   		ro->filter = filter;
>   		ro->count  = count;
> -
> - out_fil:
> -		release_sock(sk);
> -		rtnl_unlock();
> -
>   		break;
>   
>   	case CAN_RAW_ERR_FILTER:
> @@ -658,16 +644,9 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
>   
>   		err_mask &= CAN_ERR_MASK;
>   
> -		rtnl_lock();
> -		lock_sock(sk);
> -
>   		dev = ro->dev;
> -		if (ro->bound && dev) {
> -			if (dev->reg_state != NETREG_REGISTERED) {
> -				err = -ENODEV;
> -				goto out_err;
> -			}
> -		}
> +		if (ro->bound && dev && dev->reg_state != NETREG_REGISTERED)
> +			return -ENODEV;
>   
>   		/* remove current error mask */
>   		if (ro->bound) {
> @@ -676,7 +655,7 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
>   						   err_mask);
>   
>   			if (err)
> -				goto out_err;
> +				return err;
>   
>   			/* remove old err_mask registration */
>   			raw_disable_errfilter(sock_net(sk), dev, sk,
> @@ -685,11 +664,6 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
>   
>   		/* link new err_mask to the socket */
>   		ro->err_mask = err_mask;
> -
> - out_err:
> -		release_sock(sk);
> -		rtnl_unlock();
> -
>   		break;
>   
>   	case CAN_RAW_LOOPBACK:
> @@ -769,6 +743,26 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
>   	return err;
>   }
>   
> +static int raw_setsockopt(struct socket *sock, int level, int optname,
> +			  sockptr_t optval, unsigned int optlen)
> +{
> +	struct sock *sk = sock->sk;
> +	int err;
> +
> +	if (level != SOL_CAN_RAW)
> +		return -EINVAL;
> +
> +	rtnl_lock();
> +	lock_sock(sk);
> +
> +	err = raw_setsockopt_locked(sock, optname, optval, optlen);
> +
> +	release_sock(sk);
> +	rtnl_unlock();
> +
> +	return err;
> +}
> +
>   static int raw_getsockopt(struct socket *sock, int level, int optname,
>   			  sockopt_t *opt)
>   {

