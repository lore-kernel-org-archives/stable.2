Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FED382373
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 17:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791567192; cv=none; b=u8XkgeRlCPbt6cNbbaSBHFHglD7qFBSm5ntYBTigHL/wVYNpd9Td6xeTW9eqeC2PFwle1wi0Pxmjmtv+S1eSw1k6NqcCA8SpBEIQGk8FsvPc/+AEDfkmMKsQ/6Qj5ikg/BzZyOKuM16L+TWzyqToiKji0O+cb44apPW6e1gdSHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791567192; c=relaxed/simple;
	bh=HkIkB+dqyxrAL4iBkZUM6mZrOi0zi8ugvAIKpk7F+dE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QlRVfTUZnmh49t2xfwvBvjEL9TmvBQoHprkKJO9gn+5U3yPa7HxYq+udBI7VeP+ylLq4qHDMqNuSF9VwUf2C91eVLhDmFfIgcanyXP64pSO4dlO11ebrqhQKH4FjUEcGHW61ehBTMowJtq5yoVAwUwpm6jGGCNKVRwmLOrHQtx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=Kz+M7ghT; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="Kz+M7ghT"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3a02551822eso1789790a91.1
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 10:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1791567190; x=1792171990; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:mail-followup-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c2jD9IJYGfmVcnhpThjvZylfTJOWRr2wSFSn38TwVbE=;
        b=Kz+M7ghToLcxEPLsGhNMENOREy02pE8g1DL2Ja3ecdo3GQulOGf9xLnItO87cAgrGp
         Ikh8XzTzeSNw8/EbIVGELTdxvEckVB6ibaRUgOW8RxS/BjysdykXS7/yMLjj18UNyMPn
         v+g5qkIM8vHoAIPx+ndnta9TuSiXJkOCZihznMh1FCJs8GQ/T6Uy3Wqgi43dRxUAunUP
         RoxQOD/7tr5hqsscCMwBUp7nTHSHH833BEaWFAqGtGwM7eadZmXul8V9FvVllr8OcX7a
         6btmH+5Dp/3OP2K0jYmLtI4EYmQ2dV6uQadQsZoPaop32HeT3mGzq//F8s9YyPw5uXvc
         nvew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791567190; x=1792171990;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:mail-followup-to:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=c2jD9IJYGfmVcnhpThjvZylfTJOWRr2wSFSn38TwVbE=;
        b=BQTyQgoHSUeizFKODxlHB/qMNdQL8WmWlfe8850eYZSelIdgxej6EQdVKxaNUmSXpU
         X8UjsMyZAiEj77ZrjeosK9Dnwm5eaSSGyxEeF5E3mN9r1XTc01NyisOJCprG9bSAZdu0
         EQNWJSgZRQ3sYQbIyxFBBEarOPvvUK3B/hUzMoYKZxiil0Clj5B9mD1UpuzN9bqbl8yB
         ut4t8LM8qL+sBeOEoXLHmMyMYIqHDoxAfEohuAoMIrdgrBLZ2wf5Vy5eoDhatT6hfay7
         6XieToB42VKODbWSmNE57xqQMiKxL8L/dCvZEE+9ggPrk/NClSC9AqoY6BcrYlwZSJ7p
         o3Mg==
X-Forwarded-Encrypted: i=1; AKwUvBwjuTE9/hOzJjqXjXQjWqd2M/Fu9ke85zcrbGxPZvCUZGpPyQ0ECdVslRxepwglQLkdqa6kxeE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKpryl0yCNzP9d4WjCOFXnWNEsO02X43YWy+EjhX8MPBxRIB6c7
	+Ujde2j9UTAD333v+lkQGrCB3duJew74Olh4KdHjLxKtZYyqJzYWI9wRpSubOJT/ejU=
X-Gm-Gg: AYBFou2LeyWwZi7gMudm5tRSTZH0Tw7lSfWmB41Be5Sd3qHKvGKtLUoJFqwuy4tiNkh
	REqEnZQBEwuyM+WcHDH4u5pS9LTx5+LpCnaqbi/wNHnu7vSWnHDzof4MuCwfxMVUyxHj1rByaWs
	qYk49B+e0hqeRccxBk/N6H4D7iSprnpqN4SEAPb9RmI4SsqLtZt/0Qj+GOVRuiekWs3rg9MtLZn
	hO5i9q+Yy1fl1UXXSFg/+EABYQsGDMXJT23BhmiNIRrfzs684U6MXaI7tiDqUHVczy38EcYnKJu
	mPMZSbF90MOCuVy++rn6L10CahnZiyvxXoMQpAyazR5w+kxbRsgS6tiMDTO4ubCNvesRflRTKoh
	+Dv+s/yKB8XDHqWD8KNSDorVJ9owb0083gF8G3754UhOQLmQeciDj5u6VKuXM2PsAHW1x0EUqMH
	mPExtlasGhi+StLV3XOmnCCravuHE16JRFY1yKXVp27NXlB89i2AdytUDZyponShu/+qNuJsDei
	dRYGSK79l4s
X-Received: by 2002:a17:90b:3912:b0:3a4:e735:b3a3 with SMTP id 98e67ed59e1d1-3ab3aceb920mr1536825a91.40.1791567190330;
        Fri, 09 Oct 2026 10:33:10 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:70::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab395e11a0sm2740419a91.2.2026.10.09.10.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 10:33:09 -0700 (PDT)
Date: Fri, 9 Oct 2026 10:33:08 -0700
From: Joe Damato <joe@dama.to>
To: Michael Chan <michael.chan@broadcom.com>
Cc: netdev@vger.kernel.org, Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	edumazet@google.com, horms@kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net 2/2] bnxt_en: Pad short SW USO segments to
 BNXT_MIN_PKT_SIZE
Message-ID: <asklVFvUJx8P/k1d@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Michael Chan <michael.chan@broadcom.com>, netdev@vger.kernel.org,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	edumazet@google.com, horms@kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
References: <20261008191114.3736826-1-joe@dama.to>
 <20261008191114.3736826-3-joe@dama.to>
 <CACKFLikWkH6QaOG=EO_zu8cqCFRxGqtA2-+R-btp0TwUbJjVBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACKFLikWkH6QaOG=EO_zu8cqCFRxGqtA2-+R-btp0TwUbJjVBg@mail.gmail.com>

On Thu, Oct 08, 2026 at 10:26:06PM -0700, Michael Chan wrote:
> On Thu, Oct 8, 2026 at 12:11 PM Joe Damato <joe@dama.to> wrote:
> 
> > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
> > index ef04c9d08066..f87e02ef3033 100644
> > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
> > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
> > @@ -82,11 +82,14 @@ int bnxt_sw_udp_gso_xmit(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
> >         if (unlikely(num_segs <= 1))
> >                 goto drop;
> >
> > +       if (unlikely(bnxt_sw_gso_pad_len(hdr_len, mss)))
> > +               goto drop;
> > +
> 
> This looks redundant since you already have the same check in
> bnxt_features_check().

It's redundant for skbs that go through validate_xmit_skb(), but generic XDP
doesn't AFAIU. Not sure how else to handle this case, but open to suggestions.

If you agree and are OK with dropping these, then I could add a comment
clarifying this in the v2. LMK what you think.

> >         /* Upper bound on the number of descriptors needed.
> >          *
> >          * Each segment uses 1 long BD + 1 ext BD + payload BDs, which is
> >          * at most num_segs + nr_frags (each frag boundary crossing adds at
> > -        * most 1 extra BD).
> > +        * most 1 extra BD). The last segment may need 1 pad BD.
> >          */
> >         bds_needed = 3 * num_segs + skb_shinfo(skb)->nr_frags + 1;
> 
> I don't quite understand why we don't need to add 1 more for possible
> padding here.

Re-reading the code, I think the +1 was never needed in the first place.
Payload BDs come from at most 1 + nr_frags DMA regions. Going from one region
to the next adds at most one BD on top of one BD per segment. There are
nr_frags boundaries at most, so I think the math is:

  2*num_segs + num_segs + nr_frags

which simplifies to 3*num_segs + nr_frags.

I would appreciate a double check on the math :) but I think the +1 from the
original code was actually unnecessary and so for this change we can use it
for the pad BD.

Shockingly: it seems sashiko didn't find any issues (?). If you agree with the
above I can respin to add the comment for the generic XDP path and re-send
later today.

Thanks,
Joe
