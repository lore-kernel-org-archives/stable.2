Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009E833D4F0;
	Wed, 12 Aug 2026 14:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786544622; cv=none; b=Kt0AkI+Zh1Ow8qhY8QwuXgifR/ebsxbZysxq8X/58Kc44gNjAz083QiwRPi9Rlg4+doueKJWYQ6WAFwfvzuAyokiga2QmMO2qNWWf+LX/peWYWALEF6+zhCryJOsoJwgxkpKNMgI402q9VOaRbMZ8xAAEt5MPdQnCAjwymDPZVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786544622; c=relaxed/simple;
	bh=DaPAjmxog5owAR2BES1Ti0cJEW7rLRp2Yo/7zXarSZI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=QCs0AEwEz+0oRH8oJPVscCCbOREK9+GYTX1mQIZ57QKgJShEWF5JDzkZWOx5Z9rpZ++euShJIlY1dHUVe6HnSnLgShwCTQbtOFYKQuW3BmmI/Wps0OsQmmHsPdiIeEL9SNq8nxpKYCBkO75JPBxuWPc6SP2Uwfbsp3cARuC4Tj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=d9K4BAH0; dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=rNxS9Xp2; arc=none smtp.client-ip=160.80.4.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="d9K4BAH0";
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="rNxS9Xp2"
Received: from smtpauth-2019-1.uniroma2.it (smtpauth-2019-1.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 67CEMuHM006037;
	Wed, 12 Aug 2026 16:23:01 +0200
Received: from lubuntu-18.04 (host-80-183-189-234.business.telecomitalia.it [80.183.189.234])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id 72851122967;
	Wed, 12 Aug 2026 16:22:51 +0200 (CEST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1786544571; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OuVP8jn+2IQuzgwsSZXa4qlpdqRw4iDgXUxpue/OBpA=;
	b=d9K4BAH0H1Te43xsUyM+rk0ijrR/AI/imE5QpJyoHxk4MIcbYnD3dwuYRWRAA9eGhqFax6
	5aZUubZzLza91/Bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1786544571; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OuVP8jn+2IQuzgwsSZXa4qlpdqRw4iDgXUxpue/OBpA=;
	b=rNxS9Xp2/9NYCs2VzZteEggRS7h6wl1CEENjzg5ezIKO4eLMLzXqWW4oMQUueemN7eRAXJ
	BqXrQCjiUobTsT6Xs+wli7fAVYwG31MM+s/7g9q19836BvHLB635hE8vD3oT5SXwCC3OwA
	keLvz53/K3FjWS/felaHtOxX4RMIMlA62XNY3s5BKduYVhoSHYHsRVh1pg3viDoieFrsyM
	homntDN6hcHzYXmkfSiQhyCIcNLre+4hRZ/u4DmSu/ureCwb/dAMKMVVZIWUK1GA9LShGW
	H5fGOrkiJBAruI+Eq9zodg5otcuzQhnQd7Y8sE5VPeHi8nt6Nfgm4/ZEZOTCoQ==
Date: Wed, 12 Aug 2026 16:22:50 +0200
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: David Lee <david.lee@trailofbits.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, Kyle Zeng <kylebot@openai.com>,
        "Dominik 'Disconnect3d' Czarnota" <dominik.czarnota@trailofbits.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>, horms@kernel.org,
        stefano.salsano@uniroma2.it, dsahern@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Andrea Mayer
 <andrea.mayer@uniroma2.it>
Subject: Re: [PATCH net v3] ipv6: seg6: clear IPv4 control block on IPIP
 decapsulation
Message-Id: <20260812162250.71d6e1df06ee05fdc3fd5fe0@uniroma2.it>
In-Reply-To: <20260810154732.850472-1-david.lee@trailofbits.com>
References: <20260810154732.850472-1-david.lee@trailofbits.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean

On Mon, 10 Aug 2026 15:47:31 +0000
David Lee <david.lee@trailofbits.com> wrote:

Thanks Kyle and David for the v3. The code looks good. What follows is
about the commit message.

I think the commit message is missing some information that the review
needs now, and that anyone reading git log will need later, since this
patch is Cc: stable.

> From: Kyle Zeng <kylebot@openai.com>
> 
> End.DX4 and End.DT4 decapsulate an IPv4 packet through
> decap_and_validate() and send it directly to IPv4 routing. The inner
> packet therefore bypasses ip_rcv_core(), which normally clears IPCB
> before IPv4 interprets skb->cb.
> 
> The skb instead retains IP6CB data from the outer packet. IPv6
> extension-header offsets overlap IPv4 option fields, so IPv4 can treat
> those offsets as saved option metadata. __ip_options_echo() can then
> copy beyond the allocation for saved options.
> 

This says the offsets overlap, but not which stale field has to be
non-zero for the copy to be attempted. IPCB->opt.optlen shares a byte
with IP6CB->lastopt, and __ip_options_echo() returns before any copy
when the optlen it is given is zero. What the outer packet has to look
like for that byte to be non-zero, and whether the sender controls it,
are not stated.

> Separate End.DX4 and End.DT4 reproducers on the unpatched v7.2-rc5
> kernel both produced:
> 
>   BUG: KASAN: slab-out-of-bounds in __ip_options_echo()
>   Write of size 255
> 
> The End.DX4 trace passes through input_action_end_dx4_finish() and
> input_action_end_dx4(), while the End.DT4 trace passes through
> input_action_end_dt4().
> 

Pasting the call stack would show how __ip_options_echo() is reached.

> When decap_and_validate() handles IPPROTO_IPIP, save the ingress
> interface from IP6CB, clear IPCB, and restore the saved value. Doing
> this in the common decapsulation path covers End.DX4, End.DT4, and
> End.DT46's IPv4 arm.
> 
> Use IP6CB(skb)->iif rather than skb->skb_iif. These actions run after
> l3mdev processing, which can replace skb_iif with the L3 master;
> IP6CB iif still records the receiving interface set at IPv6 ingress.
> 
> Fixes: 891ef8dd2a8d ("ipv6: sr: implement additional seg6local actions")
> Cc: stable@vger.kernel.org
> Suggested-by: Andrea Mayer <andrea.mayer@uniroma2.it>
> Assisted-by: Codex:gpt-5.6-sol Codex:gpt-5.5-cyber
> Signed-off-by: Kyle Zeng <kylebot@openai.com>
> Co-developed-by: David Lee <david.lee@trailofbits.com>
> Signed-off-by: David Lee <david.lee@trailofbits.com>
> ---
> Changes in v3:
> - Clear IPCB in the common IPPROTO_IPIP decapsulation path so End.DX4,
>   End.DT4, and End.DT46's IPv4 arm are covered.
> - Preserve the ingress interface from IP6CB instead of skb->skb_iif,
>   which can identify the VRF master after l3mdev processing.
> - Update the Fixes tag to the commit that introduced End.DX4.
> - Include the End.DX4 and End.DT4 KASAN evidence.
> 
> v2: https://lore.kernel.org/netdev/20260804094625.715305-1-david.lee@trailofbits.com/
> v1: https://lore.kernel.org/all/20260731140832.567669-1-david.lee@trailofbits.com/ 
> 
>  net/ipv6/seg6_local.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
> index 2b41e4c0dddd..95ea0b62729a 100644
> --- a/net/ipv6/seg6_local.c
> +++ b/net/ipv6/seg6_local.c
> @@ -256,6 +256,13 @@ static bool decap_and_validate(struct sk_buff *skb, int proto)
>  	if (iptunnel_pull_offloads(skb))
>  		return false;
>  
> +	if (proto == IPPROTO_IPIP) {
> +		int iif = IP6CB(skb)->iif;
> +
> +		memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
> +		IPCB(skb)->iif = iif;
> +	}
> +
>  	return true;
>  }
>  

IMHO, the commit message is worth a new revision.

Thanks,

Ciao,
Andrea
