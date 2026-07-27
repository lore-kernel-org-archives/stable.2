Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FD73CFF46;
	Mon, 27 Jul 2026 08:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785140305; cv=none; b=cHkR/EalxzAU2nV1IgZdvTU1I8WUqRTmeZLw40OQ0d6SeQdVjg5rWLfYTKfLjJne4Jc9j8m3edrJ803W3d3vdgIoxAqDvoLWvKNAGQYHiRyc1Hbg+TIH4KOAZZMUmVXGb/wi93KzQ1NECE9Y33pc7qK+HuEoU4I7qR8GUPjCb5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785140305; c=relaxed/simple;
	bh=zY48Y6El/48sSVOyFlW+fwchlkNp7fWHZSxZamfHqhs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qc780vaf421JdBV28XwJaaptchEvSdUD6mInrKpVMsdRwyeEmm6fpOrEpAiAhwfw5ylf21V7b6HSkhwHzZUiZ+VYbuHRlLVKiFITYaASJdeEigLZAJMXXrOO2qnhT/dzd+/HqNLhMADb+iHio9ozLTpl0lMsB4YvRtea9n2Q+1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=S/4O1ox/; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="S/4O1ox/"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id E34B5206D0;
	Mon, 27 Jul 2026 10:18:19 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JkXNZPJ0Zokn; Mon, 27 Jul 2026 10:18:19 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id F2F8E20523;
	Mon, 27 Jul 2026 10:18:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com F2F8E20523
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1785140299;
	bh=RtG9lxViQDlHXlTYnbnDA9XWHam+JC3ie2AWetNOxU4=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=S/4O1ox/0P6ALoJgkWmOkaj0bCJpU2gVF1wFuGjFHyp1DlPH0ajsCOEaU0FFKWeuC
	 xwUBgR6aGy55PGSlkf1i+qedXTGVVSq6y2wd9VHv9P8jcVMQUUpW39GCKdCzcVI6Rq
	 oGTUzpnVkTE5KJqddWDspvW7jHV/tizXu1SSJFaJiw13t7YSo6MReL+9X+N3hnkGyB
	 l/zGRGpAe7+byPyU1GgZwafFUf+0vAC9ovFg2nnMhnHb4MqMOSWaaDi/W/vlqDNgkI
	 TNiau7CESbOVYDhlTLePNpA4zQWsAT+dTpqkBEn2uCkMG4I0HjYbSOflflyFrDj0LO
	 k/oQvoex0zeoA==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 27 Jul
 2026 10:18:18 +0200
Received: (nullmailer pid 3858205 invoked by uid 1000);
	Mon, 27 Jul 2026 08:18:17 -0000
Date: Mon, 27 Jul 2026 10:18:17 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
CC: <netdev@vger.kernel.org>, <herbert@gondor.apana.org.au>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>, Ao
 Wang <wangao@seu.edu.cn>, Xuewei Feng <fengxw06@126.com>, Qi Li
	<qli01@tsinghua.edu.cn>, Ke Xu <xuke@tsinghua.edu.cn>, <yyxroy22@gmail.com>
Subject: Re: [PATCH net] xfrm: enforce hard byte lifetime in xfrm_input()
Message-ID: <amcUSYGFPCWkXOqQ@secunet.com>
References: <20260724104517.3852159-1-yangyx22@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260724104517.3852159-1-yangyx22@mails.tsinghua.edu.cn>
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-01.secunet.de
 (10.32.0.171)

On Fri, Jul 24, 2026 at 10:45:17AM +0000, Yuxiang Yang wrote:
> xfrm_input() checks an inbound state's hard lifetime before processing
> the current packet, but accounts the packet only after the transform
> succeeds. The check therefore sees only the previous byte count.
> 
> If the current packet makes the new count exceed the hard byte limit,
> that packet is still delivered. The state is not expired until the next
> matching packet arrives. The effect is limited to the packet that crosses
> the configured limit.
> 
> This affects only states configured with a finite hard byte limit. The
> default XFRM_INF lifetime is unaffected. IPComp makes the issue especially
> visible because decompression can increase skb->len before it is accounted.
> 
> Account the actual post-transform length, then enforce the finite hard byte
> limit before delivering the packet. Use a strict comparison so a packet
> that brings the count exactly to the limit remains accepted.
> 
> Saturate the byte counter at XFRM_INF - 1 because XFRM_INF is also the
> unlimited-lifetime sentinel. Carry a separate saturation flag so a finite
> lifetime still expires if the addition overflows or reaches the sentinel.
> 
> The transform and replay update have already completed when an overshooting
> packet is dropped. Checking the compressed length before the transform
> would not enforce the correct limit because IPComp can increase skb->len
> during decompression.
> 
> With this change applied to net at 78f75d632f74, a local QEMU/TCG test
> dropped a 136-byte packet at a hard limit of 135 and accepted the same
> packet at limits of 136 and 100000. XfrmInStateExpired increased by 1, 0,
> and 0, respectively. A characterization-only kprobe module seeded
> curlft.bytes at U64_MAX - 100 for an unlimited lifetime; two packets were
> delivered, the counter saturated at U64_MAX - 1, and XfrmInStateExpired
> did not change.
> 
> This change is limited to hard byte lifetime handling in xfrm_input().
> xfrm6_input_addr() and the output path use separate byte accounting and
> are not changed here.
> 
> The faulty ordering predates the available Git development history, so
> there is no accurate introducing commit to reference with a Fixes tag.

A fix needs a 'Fixes:' tag. If the bug predates the git history,
then use the first commit in the git history for the fixes tag.

> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
> ---
>  net/xfrm/xfrm_input.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
> index eecab337b..6846ccb39 100644
> --- a/net/xfrm/xfrm_input.c
> +++ b/net/xfrm/xfrm_input.c
> @@ -14,6 +14,7 @@
>  #include <linux/slab.h>
>  #include <linux/module.h>
>  #include <linux/netdevice.h>
> +#include <linux/overflow.h>
>  #include <linux/percpu.h>
>  #include <net/dst.h>
>  #include <net/ip.h>
> @@ -582,6 +583,9 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
>  	daddr = (xfrm_address_t *)(skb_network_header(skb) +
>  				   XFRM_SPI_SKB_CB(skb)->daddroff);
>  	do {
> +		bool saturated;
> +		u64 bytes, len;
> +
>  		sp = skb_sec_path(skb);
>  
>  		if (sp->len == XFRM_MAX_DEPTH) {
> @@ -689,10 +693,24 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
>  
>  		xfrm_replay_advance(x, seq);
>  
> -		x->curlft.bytes += skb->len;
> +		len = skb->len;
> +		saturated = check_add_overflow(x->curlft.bytes, len, &bytes);
> +		if (saturated || bytes == XFRM_INF) {
> +			bytes = XFRM_INF - 1;
> +			saturated = true;
> +		}
> +		x->curlft.bytes = bytes;
>  		x->curlft.packets++;
>  		x->lastused = ktime_get_real_seconds();
>  
> +		/* IPComp may expand skb->len during the input transform. */

Please don't make the xfrm input path more complicated just for
an IPcomp lifebyte check. Nobody uses this anymore and we
discussed to deprecate it at the IPsec Workshop last week.

