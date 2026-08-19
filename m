Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A877492520;
	Wed, 19 Aug 2026 17:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787160122; cv=none; b=pHFRW8T50uIGwdbLMgi+H3lw8NRhDUe7G1/N+j10VWQstzXcr1i74R0uCAuEtETxwzxzHP9oWrnAEwU3PFnWMkgXT0d54/ZrWzCli2IF2cY4B/RZFPgu1kZFxzFmL/rdJquP1CxVgFq2Ckcv74hQzgBJrkZpIcF52Vojirb5OyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787160122; c=relaxed/simple;
	bh=/yPDJFo3BI9AXPSq1MCLeFrwB4SAoJ27qJLVuvTqeic=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=TYCEeGpfzNJswWzhJTVIVBKgvGPtbxijcT4iC1J8AV49I8QNliIwoXgataBhFpeJuu7yIWrKw5QepZOS9yT/b2QgSQMPmsq0Z3lF+UL96TCgn7ujzu7gPK185CRNrQMUowC0CrpMnZP3fvD7mYAml3o2OpsvHiIa8d0dtEf1iMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=isX09NEP; dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=lLVgo/FO; arc=none smtp.client-ip=160.80.4.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="isX09NEP";
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="lLVgo/FO"
Received: from smtpauth-2019-1.uniroma2.it (smtpauth.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 67JHL2AD011095;
	Wed, 19 Aug 2026 19:21:07 +0200
Received: from lubuntu-18.04 (unknown [160.80.103.126])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id C87631205C5;
	Wed, 19 Aug 2026 19:20:57 +0200 (CEST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1787160058; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IXp/w7vjpclMTyHwLmNKOVVg+V18u0MS/Dozdar0KWg=;
	b=isX09NEPD67URT3mk0AVxGIoCJsClYb8BXXqtJcC1yC3hrgyjXVW3mZHxPv+SeHmrshWTc
	pdGm/wfeJsyF2cCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1787160058; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IXp/w7vjpclMTyHwLmNKOVVg+V18u0MS/Dozdar0KWg=;
	b=lLVgo/FOT5rZguhJD93xges0z1xhD42itgxweYVGsG8WfDsg0xaeNIaQrOpp9PJdO1KRal
	/snzofdOzZkG5qxsDGAkGKzjuCwu3SlzTXYNuNRbWGc5SpAXalAOm6xIuh9rTSG5IqBc8X
	VkKBLtp5UQF9BRKyLDmv/g0NDvNTUIn+lCV2i0i3oten/tCg3z8Fj+fN8LIHmtxdgLmBf9
	P78D/qaetVrxDUDAur7FyP3I+BRMhd50Etogasr9m4ODdys8vsRFuKlh7MfWb9fmaHiJ8Q
	kEC9Hsrd2KxqlhXglsUW8gtXRip59ZaiJRKPhsLeTO5Ne5kUxpfLRDwsJshauw==
Date: Wed, 19 Aug 2026 19:20:57 +0200
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
Subject: Re: [PATCH net v4] ipv6: seg6: clear IPv4 control block on IPIP
 decapsulation
Message-Id: <20260819192057.fd671c00ce2227bc001ac862@uniroma2.it>
In-Reply-To: <20260817085839.946321-1-david.lee@trailofbits.com>
References: <20260817085839.946321-1-david.lee@trailofbits.com>
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

On Mon, 17 Aug 2026 08:58:38 +0000
David Lee <david.lee@trailofbits.com> wrote:

Thanks for the v4.

> From: Kyle Zeng <kylebot@openai.com>
>
> End.DX4 and End.DT4 decapsulate an IPv4 packet through
> decap_and_validate() and send it directly to IPv4 routing. The inner
> packet therefore bypasses ip_rcv_core(), which normally clears IPCB
> before IPv4 interprets skb->cb.
>
> The skb instead retains IP6CB data from the outer packet. IP6CB and
> IPCB use the same skb->cb storage, so IP6CB(skb)->lastopt overlaps
> IPCB(skb)->opt.optlen and srr, while IP6CB(skb)->nhoff overlaps rr and
> ts.
>
> The sender can make the stale optlen byte nonzero with a valid outer
> extension-header chain. The reproducers put an eight-byte Destination
> Options header immediately after the 40-byte IPv6 header and before the
> Segment Routing Header. ipv6_destopt_rcv() records the sender-controlled
> Destination Options offset in both lastopt and nhoff, setting them to
> 40. On the reproduced little-endian x86-64 kernel, IPv4 therefore sees
> optlen = 40 and rr = 40.
>
> Both tcp_v4_save_options() and __ip_options_echo() skip option copying
> when optlen is zero. Here optlen is 40, so the TCP SYN path allocates
> room for 40 bytes of option data and calls __ip_options_echo(). The
> stale rr value makes that function read inner packet byte 41 as the
> Record Route option length. The reproducers set that sender-controlled
> byte to 255, so __ip_options_echo() copies 255 bytes into the 40-byte
> option-data area.
>
> Separate End.DX4 and End.DT4 reproducers on the unpatched v7.2-rc5
> kernel both produced:
>
>   BUG: KASAN: slab-out-of-bounds in __ip_options_echo()
>   Write of size 255
>
> The relevant End.DX4 call path is:
>
>   __ip_options_echo
>   tcp_v4_route_req
>   tcp_conn_request
>   tcp_v4_conn_request
>   tcp_rcv_state_process
>   tcp_v4_do_rcv
>   tcp_v4_rcv
>   ip_protocol_deliver_rcu
>   ip_local_deliver_finish
>   ip_local_deliver
>   input_action_end_dx4_finish
>   input_action_end_dx4
>
> The relevant End.DT4 call path is:
>
>   __ip_options_echo
>   tcp_v4_route_req
>   tcp_conn_request
>   tcp_v4_conn_request
>   tcp_rcv_state_process
>   tcp_v4_do_rcv
>   tcp_v4_rcv
>   ip_protocol_deliver_rcu
>   ip_local_deliver_finish
>   ip_local_deliver
>   input_action_end_dt4
>
> tcp_v4_save_options() is inlined into the tcp_v4_route_req() path, so
> it does not appear as a separate frame.
>

Nit, not worth a respin: the two call paths are the same from
__ip_options_echo() to ip_local_deliver(), so one of them, plus the
frames after ip_local_deliver() for the other, would do.

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
> Changes in v4:
> - Explain how the stale occurs.
> - Include the observed End.DX4 and End.DT4 call paths.
>
> v3: https://lore.kernel.org/netdev/20260810154732.850472-1-david.lee@trailofbits.com/
>
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

Side note: before your patch IPSKB_L3SLAVE could read as set inside
the IPCB() on this path by chance (even with no VRF involved),
depending on how the outer IPv6 packet was fragmented:
IPCB->flags overlaps the outer IP6CB->frag_max_size (with
CONFIG_IPV6_MIP6).

Your patch clears IPCB->flags, which loses nothing: that bit did not
record an enslavement to a VRF; it was stale outer data.
And on End.DX4 nothing records one in the inner packet's IPCB.
That is a different bug from the out-of-bounds write you are fixing.

In other words, on End.DX4 the IPSKB_L3SLAVE propagation was missing
before this patch, and this patch sanitizes garbage that could have
accidentally set that bit. IMHO, the propagation should go in its
own patch. I will look at it.

Reviewed-by: Andrea Mayer <andrea.mayer@uniroma2.it>
