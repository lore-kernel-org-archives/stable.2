Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A752BE051
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 10:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784543091; cv=none; b=SYschnWYFh4Gup8LGOTeme11g3G3xxOdFSFpoHNsLdgCVE5LlUs00u64M+Xi7Qm+OM/Idv4G51mIGZuY2XRIiH+ChCPVzJbKUFPhjkh8DAyMDRnCny5FpgfAulUgsdDWQwxzy7RQQWVvinitGewLESluxeQzMFREao7FfrCntbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784543091; c=relaxed/simple;
	bh=ZQZICDYgbRgiUxmzpxgAJ9erLVWkdQLc9nJ8avEn+Vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RnLtgMggiLV7BLl6Xpc4IST81tBRe0kFkzm3/Uz9CR5v0vIdJEbW9/iYlo1y0Pl/ZN5SQluL7j0j01nVinExGA/t+P497IRdOoNFjOmkvMontM2eQA9mMtv4s+gV+J6KVEzBeJ5reyC4bvKRzD4txKQfsulV8eyvHwRmlj98kqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b=vg5IcwTi; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b="vg5IcwTi"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4954df200ddso14271685e9.0
        for <stable@vger.kernel.org>; Mon, 20 Jul 2026 03:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20251104.gappssmtp.com; s=20251104; t=1784543089; x=1785147889; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zd72l0RJ8ftcCUHhUbD81aNG9YQZtgyyjQP2cHWS9d4=;
        b=vg5IcwTim6+mko0v5reuGZG8ZIxKuY1jOOnPyegZZKYzqPyESW98Bgse4+tZfyjsUH
         BbDmk4bVMjgg5CUux2RYjSz5Wn27waC+NHp03PutvJNlJFCjKawqL3ijk3ub29LTAb/6
         42l4ly/okxkVmher7uYz/dIQo3upJKc+8jgjpR3jwbweagqO+nRqSWZcHmc3i3BVD9yz
         q1TrdfydVJOjMs2X+ki17sOllSYUumDeDL59nuwir1oahVIPQnRaBDA5bgAk+4yr9Vbh
         /2pj1R6+BPN/HQAkDAV2hrGxMyMxCvVb/GpxNMOp9lC5lq7d+OpfQTa8vab3BZFthzQ5
         vXWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784543089; x=1785147889;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zd72l0RJ8ftcCUHhUbD81aNG9YQZtgyyjQP2cHWS9d4=;
        b=OgsO01ejZbTkuWcHdcnuNj4dCGxOxmIpjsKkIDbE2jbekKyfr8u5StVOfy34UQBhZ7
         wrc9G0cyetnfcGmOYbcD692Eg/SVHGmpUDLRrRnPYS+ItR0LSQq5A4Vd73YwZLWKSOje
         sACMeqK8qlMYi2BBPRKVB0jltG2WAQH/VL43vJ/O9nGS5MZYowRV3hlQaiMx0dOn9gRE
         5VY+QueZNh4B8/43EQpef+8kNr028eVTt/WcxYSWRgh000RRcz9/if359jC9vEzZAQe+
         J79TIFuJpFWnSh0WH2WoBjsqOBMAu1nfDVoBWQMTuXjq06uhsWnCBcSKTaCiY6zObHKI
         IQ1g==
X-Forwarded-Encrypted: i=1; AHgh+RqZtLLXEeI00vugQmY68l9nFROQFvz97bomQmd2s1dXN0wZAP11ZfvjRL/NzOloseAV7E413+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCFJa508jAK8EUgDbITHiUuk83Sopb82y+cwKmUz+q7pmBHmhq
	JkXEmKPufzSsaNCeLyG3FMf9Sy6rhdaV2aT/PYQDB4JMTqvXEOB81G8eLY6Nv8hpXn8=
X-Gm-Gg: AfdE7cmJVMWIJgNB2oAf4hfaiB6DOJZp+gDYQv5WpyRRCP04yHZbxO37BHlWfpEztMX
	TgDXz//zFrAshhTuKIXwRbr4dwFMIhnFPcdIHMT6KG1592rwo7NTK7llAFv2tb50T8GmSa7GPEP
	EOCQ9guuxvNk3KAWxqU9fMcF0sgdMBs3E/En8WABONM/NgHERsm4VfKB1Fjl+v+kd9jxs4ZuekY
	Kt2hSvFav+Eup+AWfLk1rk01ixNpY13eSJAIfwZefUFILAh2MsohA9hhNdbxIQgH3rPeJ5TNBKA
	cG3qChhaJklsIaiFvSCOU3b/Xs+VbRHwxfZVyWUyfSs9vJ80jTlAzgFNesO/dUCtxNbp/WUpSXs
	bv77mEOmNS8DKLn6N2Vagzw5MWZxddP3RAlr/2nAtxquJPBrCc5R+8kyMPVFQ0pSQ
X-Received: by 2002:a05:600c:4f09:b0:495:5b32:df72 with SMTP id 5b1f17b1804b1-4955b32e0c7mr61903515e9.35.1784543088526;
        Mon, 20 Jul 2026 03:24:48 -0700 (PDT)
Received: from localhost ([2a09:bac6:37a8:1cdc::2e0:ea])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49549c96fecsm318116205e9.11.2026.07.20.03.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 03:24:47 -0700 (PDT)
Date: Mon, 20 Jul 2026 11:24:47 +0100
From: Matt Fleming <matt@readmodwrite.com>
To: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, stable@vger.kernel.org, kernel-team@cloudflare.com, 
	Matt Fleming <mfleming@cloudflare.com>
Subject: Re: [PATCH bpf] veth: convert frag_list skbs before running XDP
Message-ID: <al3oXdjTYM_PziJp@matt-Precision-5490>
References: <20260716100605.939654-1-matt@readmodwrite.com>
 <87jyquj5wm.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87jyquj5wm.fsf@toke.dk>

On Fri, Jul 17, 2026 at 11:56:41AM +0200, Toke Høiland-Jørgensen wrote:
> Matt Fleming <matt@readmodwrite.com> writes:
> 
> > diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> > index 1c5142149175..efb24aae1f26 100644
> > --- a/drivers/net/veth.c
> > +++ b/drivers/net/veth.c
> > @@ -756,7 +756,7 @@ static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
> >  	u32 frame_sz;
> >  
> >  	if (skb_shared(skb) || skb_head_is_locked(skb) ||
> > -	    skb_shinfo(skb)->nr_frags ||
> > +	    skb_shinfo(skb)->nr_frags || skb_has_frag_list(skb) ||
> 
> Isn't 'skb_shinfo(skb)->nr_frags || skb_has_frag_list(skb)' basically
> the same as 'skb_is_nonlinear(skb)'? Which, incidentally, is what
> generic XDP uses in the check that guards calling into the
> skb_pp_cow_data() path.
 
Yeah, you're right. I tested that expression and it still fixes the
bug. I'll update v2 to use skb_is_nonlinear().

> Looking at those two places, generic XDP checks for 'skb_cloned(skb)',
> while veth checks 'skb_shared(skb) || skb_head_is_locked(skb)'. AFAICT,
> the latter is stricter; should we update the generic XDP check?
 
Possibly, but the surrounding code isn't set up to deal with
skb_shared() SKBs so that'd be a larger change. I can take a look at
that too but I'm going to need more time to get my head around making
that change correctly given that there's different fallback rules than
veth.

> >  	    skb_headroom(skb) < XDP_PACKET_HEADROOM) {
> >  		if (skb_pp_cow_data(rq->page_pool, pskb, XDP_PACKET_HEADROOM))
> >  			goto drop;
> > @@ -771,7 +771,7 @@ static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
> >  	xdp_prepare_buff(xdp, skb->head, skb_headroom(skb),
> >  			 skb_headlen(skb), true);
> >  
> > -	if (skb_is_nonlinear(skb)) {
> > +	if (skb_shinfo(skb)->nr_frags) {
> >  		skb_shinfo(skb)->xdp_frags_size = skb->data_len;
> >  		xdp_buff_set_frags_flag(xdp);
> >  	} else {
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > index 18dabb4e9cfa..1e837d01a908 100644
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -936,12 +936,11 @@ int skb_pp_cow_data(struct page_pool *pool, struct sk_buff **pskb,
> >  	int err, i, head_off;
> >  	void *data;
> >  
> > -	/* XDP does not support fraglist so we need to linearize
> > -	 * the skb.
> > +	/*
> > +	 * skb_copy_bits() handles both frags[] and frag_list input. If the
> > +	 * copied skb remains non-linear, it uses frags[], which is the
> > +	 * representation used by XDP multi-buffer.
> >  	 */
> 
> This comment sorta reads like a function documentation comment, but it
> ends up sitting weirdly in the middle of the function body. The comment
> you're replacing was tied to the statement below, but this one isn't,
> really. Should we turn it into an actual function doc comment instead?

Good point. I'll make this a function doc comment.

Thanks,
Matt
