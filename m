Received: from smtp.uniroma2.it (smtp-2015.uniroma2.it [160.80.4.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E5A4825B0;
	Thu, 24 Sep 2026 16:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790265672; cv=none; b=gIo0rgXWTktq0G9Jmj8okvJXaWl3sFXp1pdf1O4isbBk8AU5+0i4DrXPBYUP/tLTITViZcVp21nvmAVYJc9m/OZmhOfIwOmDJoPPeY68rWiSakpSepNqCWsR28Z19pgvoL5ed7zbo5IfldHdQA2HANr3J0WY77Vh5RVU4pFCkII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790265672; c=relaxed/simple;
	bh=XeNHz13ULfMA2b1+O2mBPioLeq/Y4ctBbaxu6kae3XE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=HKePSmWxvr8YGpwMzr8h6E5Cz4v/su0063arHH187mzae9fKMZlE0V7NHXXaMU9rmqDRUeCIhqL7HyAbaxOTXTzXHVtbnfB/QxI8buys44WZOYfvsehPNSCXwyxfPkiiUDZe+QnMbRwONLS94mt+wyLZnSp04IVHv/yjd70I+e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=l9StfxJN; dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=WuPPe7+i; arc=none smtp.client-ip=160.80.4.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="l9StfxJN";
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="WuPPe7+i"
Received: from smtpauth-2019-1.uniroma2.it (smtpauth.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 68OG0MTU021248;
	Thu, 24 Sep 2026 18:00:27 +0200
Received: from lubuntu-18.04 (host-95-234-228-71.retail.telecomitalia.it [95.234.228.71])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id BF2171227F6;
	Thu, 24 Sep 2026 18:00:16 +0200 (CEST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1790265617; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZqTQ4TKcaUuTMiORSWhLajW+Q/jdKZkfzyxyFJ9V2Ro=;
	b=l9StfxJNNBMjtdvhJnH2tHe5LNbKHfQUm+DWsgQcWe78vDuRmSn6cdH8ireR5htvan0tuY
	9Y2hyftPAylzEhCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1790265617; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZqTQ4TKcaUuTMiORSWhLajW+Q/jdKZkfzyxyFJ9V2Ro=;
	b=WuPPe7+iAOBgsS5+95Pv6STPwgGR8VVxD7H0EJonqYlziJzH3CEswzATFzjBkdfrOi6rbt
	G2+IkqPDTdyzt72TSj754fYMhEZHHXNIPucKNj5YvwB2EaJVGfQF7c2uQkOIoSIYNWGmWy
	TjQ/SX7MIQZtA+x1MbugC6ldLSN9kBlzDcrwZ6XFOP/sFr1IgVs33Gzd2AKtbMxI8Wivbt
	oiQRzUz7jlr4HzAjEHRy6onx2F655uWxrNXXpT8X86wBQgL4PdP64u8klKdlrrYDfqUXcc
	HhlATJ/qgGPvAiWmBDDe+o2Ijg1o8dsH2H52NkW0CSRvyUqdBlv+sbFt9L9LpQ==
Date: Thu, 24 Sep 2026 18:00:16 +0200
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: Hui Peng <benquike@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, dsahern@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        hangbin.liu@linux.dev, leitao@debian.org,
        Andrea Mayer
 <andrea.mayer@uniroma2.it>
Subject: Re: [PATCH net v4] ipv6: sr: enforce exact attribute length for
 SEG6_ATTR_DST
Message-Id: <20260924180016.f1a9947223549a9a88c9a2fe@uniroma2.it>
In-Reply-To: <20260924093610.3286959-1-benquike@gmail.com>
References: <20260924093610.3286959-1-benquike@gmail.com>
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

On Thu, 24 Sep 2026 09:36:10 +0000
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
> uninitialized kernel heap memory; with this patch applied,
> SEG6_CMD_SET_TUNSRC is rejected by netlink policy validation with
> -ERANGE (-34) and tun_src remains zeroed.
> 
> Fixes: 915d7e5e5930 ("ipv6: sr: add code base for control plane support of SR-IPv6")
> Cc: stable@vger.kernel.org
> Reviewed-by: Andrea Mayer <andrea.mayer@uniroma2.it>
> Reviewed-by: Hangbin Liu <hangbin.liu@linux.dev>
> Reviewed-by: Breno Leitao <leitao@debian.org>
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>
> ---
> Changes in v4:
> - Drop raw hex memory dump string from commit message as suggested by Breno
>   Leitao.
> - Add Reviewed-by tag from Breno Leitao.
> 
> Changes in v3:
> - Add Reviewed-by tag from Andrea Mayer.
> - Send as a fresh standalone thread (no In-Reply-To header) as requested by
>   Jakub Kicinski.
> 
> Changes in v2:
> - Drop the redundant nla_len(info->attrs[SEG6_ATTR_DST]) !=
>   sizeof(struct in6_addr) check in seg6_genl_set_tunsrc() since
>   NLA_POLICY_EXACT_LEN() in seg6_genl_policy already enforces the exact
>   length, as pointed out by Hangbin Liu.
> 
>  net/ipv6/seg6.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

The v2 was applied to netdev/net.git (main) as commit 2d959c75c27f
("ipv6: sr: enforce exact attribute length for SEG6_ATTR_DST"):

https://git.kernel.org/netdev/net/c/2d959c75c27f90e9ec489d18ce5ee6b852ad4741

One general note for your future postings, not about this patch which is
already applied: please do not repost a patch less than 24 hours after
the previous posting. See the "Resending after review" section of
Documentation/process/maintainer-netdev.rst:

https://docs.kernel.org/process/maintainer-netdev.html#resending-after-review

Ciao,
Andrea
