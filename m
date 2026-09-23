Received: from smtp.uniroma2.it (smtp-2015.uniroma2.it [160.80.4.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1EAA46AF1B;
	Wed, 23 Sep 2026 22:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790204023; cv=none; b=P0+vkeBHdf7MFOeGM0DBpeY8rqUkfiyyjhtndq9Irizu9jcxEOlXOIGxTXbWJe+IDy3cIdXj7Vh76BWoz9GrK03iDi6O/KkdbGgB5C7ktyZtr06PnfSTlNk6Us4nRt1xU6ofiSHuO0gIXOz6JQ+BfgJxATcPEAqBMShCeKshMbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790204023; c=relaxed/simple;
	bh=W8S48tbaPTnLUEOz3HvvWSqKmgMP3Wwkjm55l323Nwk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=m+0U+NUmG3Zdi+JBkIVhT70Lu/gR8pvRY1j3c6F4fMU272bVoYtrgfGits8XylHa4oPQivhWLXRZHG4zAd7bi1HyXSBoeJLc2FsQg9a912IfZTHZm7u1gYEMo3QEvQAM0aiOLNXKEUkk5Nbxvq/Ahx6Y5niK6KqhQ3Yo/Tfy1i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=CdbA89bQ; dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=jOgsmJu7; arc=none smtp.client-ip=160.80.4.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="CdbA89bQ";
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="jOgsmJu7"
Received: from smtpauth-2019-1.uniroma2.it (smtpauth-2019-1.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 68NMr3Wo019426;
	Thu, 24 Sep 2026 00:53:09 +0200
Received: from lubuntu-18.04 (host-95-234-228-71.retail.telecomitalia.it [95.234.228.71])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id 479D9122885;
	Thu, 24 Sep 2026 00:53:00 +0200 (CEST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1790203980; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1StVDwsPdpfkCmAnM7HUPkMtndRgp/KLXORxVAS5bV4=;
	b=CdbA89bQ0lLjP3/DrwQx7LvG4XmwxTMGZTYQLj4bsxSIomFKrRHWYFnNF3UeZXxDsIl+40
	TABMkE12wCsoG+BQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1790203980; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1StVDwsPdpfkCmAnM7HUPkMtndRgp/KLXORxVAS5bV4=;
	b=jOgsmJu7ZRauc6MQDfHpzRA0PmQ5IorBj8k41nMAwJv2gZ5nhiU8LaZS+l6vo07gNnyYRG
	MwOEvnduloL6adGnElU1xXlYZvnzcVhEdQstaDX7P2QYfqYCbTZcOOQlPvJIQI2zyeo6+l
	p8AQ6d81IQs3Om8GtScq/k3zITwzVuSpcaA9DW4TdUlsHmVP91j6eoWWPXzZ8d3ulsSGYL
	SojqWlWQM6i3Vjb1pWv98JZYdsRRADdM8u0sjdHfDyQ3kKI2GLdN4zT/nlFYo1kj8M5wtV
	cBz8lB1ST6OI3fQIPwbRb1JvuKG+/87GMb+u5LD9x+3ga3ytm9R4SgtGVcJNIw==
Date: Thu, 24 Sep 2026 00:52:59 +0200
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: Hui Peng <benquike@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
 <pabeni@redhat.com>, Hangbin Liu <hangbin.liu@linux.dev>,
        Simon Horman
 <horms@kernel.org>,
        David Lebrun <david.lebrun@uclouvain.be>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: Re: [PATCH net v2] ipv6: sr: enforce exact attribute length for
 SEG6_ATTR_DST
Message-Id: <20260924005259.191035d085d7638ac6c0f97b@uniroma2.it>
In-Reply-To: <20260921044025.1535982-1-benquike@gmail.com>
References: <aq-E5MPYZS5s9_bk@fedora>
	<20260921044025.1535982-1-benquike@gmail.com>
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

On Mon, 21 Sep 2026 04:40:25 +0000
Hui Peng <benquike@gmail.com> wrote:

> In seg6_genl_policy, SEG6_ATTR_DST is defined with .type = NLA_BINARY and
> .len = sizeof(struct in6_addr). For NLA_BINARY, .len only enforces the
> maximum payload length and permits shorter payloads (e.g., 0 bytes).
> When seg6_genl_set_tunsrc() copies sizeof(struct in6_addr) bytes via
> kmemdup(val, sizeof(*val), GFP_KERNEL), a short SEG6_ATTR_DST attribute
> triggers a 16-byte out-of-bounds read past skb->tail into uninitialized
> skb->head memory, which is stored in sdata->tun_src and leaked back to
> userspace via SEG6_CMD_GET_TUNSRC.
> 
> Switch SEG6_ATTR_DST in seg6_genl_policy to
> NLA_POLICY_EXACT_LEN(sizeof(struct in6_addr)) so that generic netlink
> validation rejects any attribute whose length is not exactly
> sizeof(struct in6_addr) with -ERANGE.
> 
> Tested in QEMU against Linux 7.3.0-rc3 by sending a SEG6_CMD_SET_TUNSRC
> Generic Netlink message with a 0-byte SEG6_ATTR_DST attribute followed
> by SEG6_CMD_GET_TUNSRC. On the unfixed kernel, SEG6_CMD_SET_TUNSRC
> succeeds (err = 0) and SEG6_CMD_GET_TUNSRC leaks 16 bytes of
> uninitialized kernel heap memory (tun_src =
> 836a61ecc4d25a1042a8d60411cfb378); with this patch applied,
> SEG6_CMD_SET_TUNSRC is rejected by netlink policy validation with
> -ERANGE (-34) and tun_src remains zeroed.
> 
> Fixes: 915d7e5e5930 ("ipv6: sr: add code base for control plane support of SR-IPv6")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>
> ---
> Changes in v2:
> - Drop the redundant nla_len(info->attrs[SEG6_ATTR_DST]) !=
>   sizeof(struct in6_addr) check in seg6_genl_set_tunsrc() since
>   NLA_POLICY_EXACT_LEN() in seg6_genl_policy already enforces the exact
>   length, as pointed out by Hangbin Liu.
> 
>  net/ipv6/seg6.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks,
Andrea

Reviewed-by: Andrea Mayer <andrea.mayer@uniroma2.it>
