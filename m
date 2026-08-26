Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C9123D7CE
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 02:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787709739; cv=none; b=Gg/ILSzFNPGHUdxsN7KCeQ1gJHKJKQOD5eLzKKn1N/auJx/OfdmsTgC+xolsZHAsws9t3zYHZdU/tCXrjcQxe3mYgSLaRtxtJEMJ1x0aUrpLrmKIkeriDIWlMCleMROz3n5GKVvh47GSp+3xtgTOS1i0kQgi6ZLk69jJRJEVbBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787709739; c=relaxed/simple;
	bh=NJCCto9wLlVWCInGQDNhRaPAkrXW3Ymoo5rST/Wij80=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=jwpGtfHYxDQNPEX4iKUeplFApB3m7WulWf1Xb+ykR0fNr76pw1s9PitfytQBUDiqTq3FPvbpkNvlpt1enTxpcXy2Or0h3oEQdEWRHRAlEi0+6J0h5Oog4kGmN2B1++wiYdUg03ZUujOTg2bhymg2yUXCKl3o94hqkRH/KXOz1zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fN1Xq/4g; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fN1Xq/4g"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-66d03ff78abso642267d50.2
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 19:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787709737; x=1788314537; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/j2cKbyDnLqH/Uv8OCdqOUyQE63/GyK6ijE5X1RB5ZA=;
        b=fN1Xq/4glB5q+SsFCeTwUbnBh8SV+IW7YEbqYlWcu57h/N80AHskRkSIWIPhQhCGA/
         QPb8OwVMPVwL8gvlKKE6QkFn58bjm9sylkWXuO/dmtrFI3cIA/Mphvck32BhGH/2wmXk
         tIGOSbqaPRh7whFWXMI3Ml+JzFEBQ7497bKB+ZMPaT6fX/6zlBynC+BB5fCV9LdVES1M
         d4+yANHhMzuNlSp96tdBXrsLhB8TyUeKhQmdWTGVYvunkzfWiQV00ontRkgQT4xnA5qr
         vHa0SVTFln7+7VzUn8I350DUm2+t0EL4+2mugRcQencWIvIwwVAzwvFVihopug1DXWKX
         XTWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787709737; x=1788314537;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/j2cKbyDnLqH/Uv8OCdqOUyQE63/GyK6ijE5X1RB5ZA=;
        b=Z5ApQeD4gLXsC0Iard7+e50UOAcci8+1avwkc/97m6ty/8H83R8xYLEtUNfAYgfUhD
         UF3x0DXHVmpQ1j1J3o+KWP2n+89Bp6D5/lKNI1p/8mQ5U/Qrsu7zrzJjD0IHI4wFHaDs
         BrGOG16B45p5PLO/uhTkjGsKR+WCQ185+YP8YLntBMkhyDK76zRIpcMw1ZKvWzhlXDLv
         +XGtm20QkWE6zWH8LqdkczSq/kWIVSTOIl/xyHh9zPuyeP5uTeo6gtNmR+Xx1vF2A6V5
         nYAclfrXjE8LL5JdrHqAOIA3Jjc46ncRpuGDVdypXT9kKXSn0UUVgj6y7E19B4R/QsCA
         IMBg==
X-Forwarded-Encrypted: i=1; AHgh+RpFYV/yE/edDny9ewMDGV0sxkeNbSdTXBMFNuVtnr6c2j6fXlYjT+T6SvCKXiz+ybrwAX393Hs=@vger.kernel.org
X-Gm-Message-State: AFuF++lGGFeso1hVVSC4lnT/tc1fNCIDWwTUi1T1p01wSILVZu/rxI6j
	9TLgjaL4R8U4XGTEdjQB3xpRxqdq6kQm4cGluqKcXOkMKdGnzEq5FGDf
X-Gm-Gg: AR+sD12+hnsIc1uPLsIKMf3DOdZOmTwWbvpc+hAjA4lnMCq7MvgtsAugIS07G9O4fcd
	JL0ZEFM0urovHyin0ZEsPbGYSlfr7d/H5YoxAzlyN7zL8aqBna38o9tKYwF/Unbppxp1AKXeyPF
	Mn0GHdCTo1W+RVUT+d93GKpZBdtK9zfAy+ZhKLPh+di4FZ1CVEUUJ8GZCXdfznxZ/uax4vQzyPA
	/HPoTRpGsWbomRIUDqoZwfzDb9w5MBM+/1sdMjDogsjPM0/SeOm48nu9upFtYlY3sTE8j0qa4Hy
	+4Jbzs4bFrt88L2nqDO9RCE02fuwl33TynLTyvow7cOvxzcde/hPg1K6Nmgm2DEaIRpPyTujQrC
	upbgFi7vpgxXN+D7ZygHA4QuUFc9jIRtfkRW23TlhY9juOXGyUs/lp6xwG2S+YGIs9+KTPaAqIm
	2ZhFpl04agh1Pkqmqq8Pfe1KsDGke9dH9pQz86ZxPMF3QzcvXe0N96ejVluIoRfZkLYROIh3E/I
	LlBcs9YgvcAf+6cTci/vtAea086Vl6+cFe/8pbRYQ==
X-Received: by 2002:a05:690c:6a10:b0:81e:c972:e8c3 with SMTP id 00721157ae682-8574087e819mr16641587b3.29.1787709736910;
        Tue, 25 Aug 2026 19:02:16 -0700 (PDT)
Received: from gmail.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85705f35aebsm9805617b3.15.2026.08.25.19.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 19:02:16 -0700 (PDT)
Date: Tue, 25 Aug 2026 22:02:15 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Qihang <q.h.hack.winter@gmail.com>, 
 jv@jvosburgh.net, 
 jiri@resnulli.us
Cc: andrew+netdev@lunn.ch, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 willemb@google.com, 
 netdev@vger.kernel.org, 
 Qihang Tang <q.h.hack.winter@gmail.com>, 
 stable@vger.kernel.org
Message-ID: <willemdebruijn.kernel.2ec10017f4836@gmail.com>
In-Reply-To: <20260824021802.90369-1-q.h.hack.winter@gmail.com>
References: <20260824021802.90369-1-q.h.hack.winter@gmail.com>
Subject: Re: [PATCH net 1/2] bonding: reject frames with insufficient headroom
 in bond_header_create
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Qihang wrote:
> From: Qihang Tang <q.h.hack.winter@gmail.com>

Thanks for working on this Qihang.

Minor: a patch series should generally have a cover letter

> AF_PACKET SOCK_DGRAM sends reserve skb headroom from a snapshot of
> bond_dev->hard_header_len.  A concurrent bond type change can switch the
> active slave to one with a larger hard_header_len between that snapshot
> and bond_header_create(), so the slave's create() pushes or writes past
> skb->head.

Are we certain that bond and team are the only devices that implement
header_ops->create?
 
> The hard_header_len snapshot series that fixed the SOCK_RAW send paths
> deferred this SOCK_DGRAM race: dev->header_ops is the stable
> bond_header_ops, so snapshotting header_ops in the caller does not help.
> 
> Reject the frame if skb headroom is smaller than the active slave's
> hard_header_len, before delegating under the existing rcu_read_lock.
> 
> Fixes: 950803f72547 ("bonding: fix type confusion in bond_setup_by_slave()")

What's the rationale behind blaming this SHA1?

> Cc: stable@vger.kernel.org
> Cc: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Qihang Tang <q.h.hack.winter@gmail.com>
> ---
>  drivers/net/bonding/bond_main.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 522eab060f9e..9ec663610dfd 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -1524,10 +1524,24 @@ static int bond_header_create(struct sk_buff *skb, struct net_device *bond_dev,
>  	slave = rcu_dereference(bond->curr_active_slave);
>  	if (slave) {
>  		slave_ops = READ_ONCE(slave->dev->header_ops);
> -		if (slave_ops && slave_ops->create)
> +		if (slave_ops && slave_ops->create) {
> +			unsigned int hlen = READ_ONCE(slave->dev->hard_header_len);
> +
> +			/* Headroom was reserved from a snapshot of
> +			 * bond_dev->hard_header_len that may predate this
> +			 * slave (concurrent bond type change); reject if
> +			 * insufficient for the slave's create(), which
> +			 * pushes its own hlen.
> +			 */
> +			if (skb_headroom(skb) < hlen) {
> +				ret = -EINVAL;
> +				goto unlock;
> +			}
>  			ret = slave_ops->create(skb, slave->dev,
>  						type, daddr, saddr, len);
> +		}

Ideally we could fix this in dev_hard_header or PF_PACKET itself,
rather than in each implementation that's in scope.

But there seems no way around holding this rcu reference on the slave
device while re-checking.



>  	}
> +unlock:
>  	rcu_read_unlock();
>  	return ret;
>  }
> -- 
> 2.50.1 (Apple Git-155)
> 


