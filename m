Received: from smtp.uniroma2.it (smtp-2015.uniroma2.it [160.80.4.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1934EB856;
	Thu, 17 Sep 2026 17:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789666932; cv=none; b=K8Ua2icDb+W/+jmLSJltwoo2Yep/zFUHJuqBI7lQ08AhF9CC3mPKnyolJAo+K3sr15JmCwoUbVnCEh2V9XRQDh5qNP6y4QfnSVS5AJctFYUM+3LM213Zb48AmEHIvW29qJ+dxMV3z/s+5zVdMOOHXXjqq589aIdaZgL+/T72FiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789666932; c=relaxed/simple;
	bh=NHHc4y0Y32HjeDzKmPrMdvv7ABkyjJFUGzW3+qTTm5o=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=cpYBAQznCaXaSFXbYprPJtd/gaMimZWhEZMOTwFcCxWIQRU7wgoxI4JBxtF50MnfhY/Xed6and/weN2io37KYJo0/nNHybs88S2nP9HaxRaG/xkmtPvct9HmebnJOG4N2vjciSiKaVSpTx2sc9raxk+BsE86E8pRwU63WUHLz4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=678ts7bp; dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=FByVuGTJ; arc=none smtp.client-ip=160.80.4.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="678ts7bp";
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="FByVuGTJ"
Received: from smtpauth-2019-1.uniroma2.it (smtpauth-2019-1.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 68HHfXJD010699;
	Thu, 17 Sep 2026 19:41:38 +0200
Received: from lubuntu-18.04 (unknown [139.28.148.6])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id 4EEA7122885;
	Thu, 17 Sep 2026 19:41:29 +0200 (CEST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1789666889; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MJh67ZsdoSJ2VmJoLbPlfwH2YuC1ln+5OOMOZoHQIrk=;
	b=678ts7bp5LQYI8HW0nWSCa58BwtZvLooPHZV/M11wB+DVpPtX8H13m7svOVdRTtK+BYm2k
	ZU1MQTFk6N0kaxCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1789666889; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MJh67ZsdoSJ2VmJoLbPlfwH2YuC1ln+5OOMOZoHQIrk=;
	b=FByVuGTJKF9FHIm5QswKlv3uIMzQIMd7UpmBBBecBXdq6j+X9+FXSJrlyjwFcn1QTlHyGZ
	JtZK2RH+l3Ecm9DkaJkGNX7yYrTE/CYkCqEhrnaMjsekJlAX/ymZLgUMV2X9vBmtx7+GnC
	1EAVM1r2X3ww1zOweZGJKR05p65Gtsw0+eNNTmAMaCP5bc0zbkAe2bbi89eo/pH6S8P/Jz
	XX+0X/AiGBX53rwcXzY7y/2wzsWO6Xupes4Psg/vhqXY9mGNqA8BiPVt2w2Qcs7QCa8AFL
	gwR81H59Vm2oNewjha48zrRh4XIhI75VQFgMkPh1FN0TFCL6KmfADBvsa3vJWw==
Date: Thu, 17 Sep 2026 19:41:28 +0200
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: Hangbin Liu <hangbin.liu@linux.dev>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, dsahern@kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, horms@kernel.org, idosch@nvidia.com,
        alex.aring@gmail.com, justin.iurman@gmail.com, bestswngs@gmail.com,
        stefano.salsano@uniroma2.it, xmei5@asu.edu, stable@vger.kernel.org,
        Andrea
 Mayer <andrea.mayer@uniroma2.it>
Subject: Re: [PATCH net v3] ipv6: rpl: fix NULL dereference of idev in
 ipv6_rpl_srh_rcv()
Message-Id: <20260917194128.c078117a13eca6f3c97e3dde@uniroma2.it>
In-Reply-To: <aqk49jT8tGsqn61d@fedora>
References: <20260817132644.2223-1-andrea.mayer@uniroma2.it>
	<aqjflqdySFG51YEa@fedora>
	<aqk49jT8tGsqn61d@fedora>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean

On Tue, 15 Sep 2026 20:24:22 +0800
Hangbin Liu <hangbin.liu@linux.dev> wrote:

> On Tue, Sep 15, 2026 at 02:03:12PM +0800, Hangbin Liu wrote:
> > Hi Andrea,
> > 
> > While reviewing the SRv6 code, I noticed you added an `idev` check in
> > `ipv6_rthdr_rcv()`. I’m wondering whether it makes sense to also halt
> > processing for `IPV6_SRCRT_TYPE_2` when `!idev`, given that IPv6 is
> > disabled on that device.
> > 
> > If so, could we drop the skb early at the entry point of `ipv6_rthdr_rcv()`?
> > The downside is that subsequent processing and `__IP6_INC_STATS()` would be
> > skipped.
> 
> Oh, another behavior change. At present, if !idev, we can still process the
> IPV6_SRCRT_TYPE_2 message. And the process will be skipped if we return early.
> I'm not sure if this kind of change is acceptable or not in kernel.
> 
> But on the other hand, is it correct to accept and forward SRCRT Type 2
> packets on device that IPv6 is disabled?
> 
> Thanks
> Hangbin

Hi Hangbin,

One case is when IPv6 is already disabled as the packet arrives:
ip6_rcv_core() drops the packet before ipv6_rthdr_rcv().
The other is the transient window: dev->ip6_ptr can be cleared after
that check, and ipv6_rthdr_rcv() can then find idev NULL.
In that window the TYPE_2 path can run without idev. ipv6_srh_rcv() and
ipv6_rpl_srh_rcv() cannot: they read idev->cnf. That is why the check
sits before those two calls.

On the counters: __IP6_INC_STATS() goes through _DEVINC(), which skips
the per-device bump when idev is NULL and still increments the per-net one.
Stopping TYPE_2 in that window as well is a behaviour change, and I think
it would need a reason of its own.

Thanks
Andrea
