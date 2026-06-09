Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0B7416D19
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 12:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781009020; cv=none; b=QhKB3NZo6okivo0fgLSudMevEthtTeyYdDZZE+XqYPlufyif9z+PR2MtyEwaGeiXtlpTzJlSeQlR7LUEzcqqiSZpwf+zWj6fagLK62t4IrnlpByzPajCbnbQQ+WBehvDEeC+h5vn7mM3CWNmEdCOp5czhb0dTpo8WbBGxAKesvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781009020; c=relaxed/simple;
	bh=r87AOgf09jBawFk7Oijp6ve8K4PXrB0C8y80U0hyvYY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oqv5bRamz7hpdxROI2JnnqJeWBv1TeuaQLvldMAscMClQ3Uz0E84+k+UomsRcq6U+2kNHR2oFuXJhkCb4spcNaslb335b9c889yJVZUcxv4cROH19hnVaSoKrPUU1d7ityqtCiPK9Negv0bnJzBfq3R1TjGJMM7McA1qzHY0WT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A72kV2gu; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A72kV2gu"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-490aebf33e9so30979695e9.3
        for <stable@vger.kernel.org>; Tue, 09 Jun 2026 05:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781009017; x=1781613817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kX0FouJIIFyZjl2k/xAPoma1e0chrivslO1nWJVjm1U=;
        b=A72kV2gueiUXShVnAFagtIoPsLnTEa3A8dCCgQXPKJBWG6IkUN2QHHl1CLX3hqr4vH
         uEhqBTqIknZ6+y1xTEHVudrjG33b73eWBabN6IJ0jrYu+7WGPoorxvSZdS08LlXeBPI9
         pWCLm+VYqQEBKrH742GuK5UnUk/DesrNflzxYhtUaDXDLG+QpNWvymRNSnbMKsNt5ATq
         W3eOm7MY7d9Hmj41DdrJ5dgRQrAZ/+d/s+j4p6YdwN4tIx82SUDOFrYYEyf6bIRNu1l7
         f6/A4rimCgAUiG0ZSiGJdZUK+1UdevfS19CbaxSU/S5nSupBPLr/68joQPCPT4vJT8Bb
         PyLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781009017; x=1781613817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kX0FouJIIFyZjl2k/xAPoma1e0chrivslO1nWJVjm1U=;
        b=C85QQu0211B20ieRQAzqtpxG9E5MyUT8oYsbVzi57A6OW9nt2rYXzyU54+Mat0vj5A
         0jbWa/1PuhCKLJoxyXpmXKu+SMVSllgeEq74vqcIMdGzQWBe52qJnAeGATILFiUZevGi
         K1WuvaSgaJnBQQwuHo1ltvTay+nIVUclvV5G9Bfzz0AV0U6TlaQF7RHncfLmnrlFQ+qw
         Yr20rMZ0TaYUPM9Kl0v0xFlKNk2aniJdS2beqjKLkiANol7+J8oK0zhEslKH60jEGZjY
         ZIIdA/JoWT3M9kpCY6iaYm6jvuPhNleADcrd7g2BZt+ztytLeAyYhFfQhkAYQSqAJov7
         Yw5w==
X-Forwarded-Encrypted: i=1; AFNElJ8RcGXyCzQrBTXpbFIFYvvqOHpXdKjkevE7r6Xii5wW/LNpM6MbzNPzekKHOX9ljeZo3OfgTjI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxzdkUUXobaMHbQevprDYHKj6d//1P4vvtolFFadvQ+I8QL475
	iWRIYiG3FhBZ0FEP+Rgx+1elGyouUwPv4MYzCMRnshI8dc+iwH1X9k8K
X-Gm-Gg: Acq92OFXqrx3O7ZKccUsHxa1dW8ITNDnqltsLQ6HIPB+sYzobMzOfAkbutNJSgdfMOn
	BQxBLbnwbfGt5fQeruIuGH5G/jtAUIDAxaFE3PtMfkqJ0Kb2DTv2NqW82Mz0swRe8Sa7wvkIzUW
	za08qtA3P5PjvSE6Dmfs0+iw5gV/FX4ndaIfBvkOw/Wj0O5Di7o7NQEtQtd8QXUUWS4V/1vfJFo
	uXw+nTBiRiSqp+SybwqGLPKr1VA3si0MOJbWgBZvx6IQfac+2UlKtpTi4roEnz8vREQ2LGTVlQE
	+hkMaJoZoU2YqQeoEmuxnIpu74iUKeNCvxP5guw/BnF3Taw1er6tsqu+NfTTgmjZhVKczENbCHB
	QNvBZH7sKTz3AeDv+14e7HwokdhBnd0bFKNkWv7jQgTvgfbyNnQGSHTYsnHxEAasKaQHnpsHNGp
	ADa3hYUB17/afyGfHluzloLfRpqmFF8MvLjmYqjO0hVZ1b2rXKhaPVwfveYJ7W0OeNeddJUbM=
X-Received: by 2002:a05:600c:3495:b0:490:bf1a:ed04 with SMTP id 5b1f17b1804b1-490c258995fmr317840935e9.1.1781009017249;
        Tue, 09 Jun 2026 05:43:37 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2ec711sm60328903f8f.12.2026.06.09.05.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 05:43:36 -0700 (PDT)
Date: Tue, 9 Jun 2026 13:43:34 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Justin Lai <justinlai0215@realtek.com>
Cc: Simon Horman <horms@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
 <edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "stable@vger.kernel.org"
 <stable@vger.kernel.org>, "richardcochran@gmail.com"
 <richardcochran@gmail.com>, "aleksander.lobakin@intel.com"
 <aleksander.lobakin@intel.com>, Ping-Ke Shih <pkshih@realtek.com>, Larry
 Chiu <larry.chiu@realtek.com>
Subject: Re: [PATCH net v2] rtase: Workaround for IP fragmented UDP packet
 hardware bug
Message-ID: <20260609134334.3225b076@pumpkin>
In-Reply-To: <1340406ab190498ab857ad9017529722@realtek.com>
References: <20260604101356.15611-1-justinlai0215@realtek.com>
	<20260608190627.182292-2-horms@kernel.org>
	<1340406ab190498ab857ad9017529722@realtek.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 9 Jun 2026 08:20:10 +0000
Justin Lai <justinlai0215@realtek.com> wrote:

> Simon Horman <horms@kernel.org> wrote:
> > 
> > From: 'Simon Horman' <horms@kernel.org>
> > 
> > This is an AI-generated review of your patch. The human sending this email has
> > considered the AI review valid, or at least plausible.
> > Full review at: https://sashiko.dev
> > ---
> > rtase: Workaround for IP fragmented UDP packet hardware bug
> > 
> > The hardware parser incorrectly interprets 319/320 in a short IP fragmented
> > UDP packet payload as standard PTP destination ports and treats the fragment
> > as a PTP packet for further parsing. Pad these packets so the transport data
> > reaches RTASE_MIN_PAD_LEN before transmitting to avoid triggering the
> > hardware issue.
> >   
> > > diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > > b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > > index ef13109c49cff..b686b84e15fe2 100644
> > > --- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > > +++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c  
> > 
> > [ ... ]
> >   
> > > @@ -1247,6 +1248,52 @@ static u32 rtase_tx_csum(struct sk_buff *skb,  
> > const struct net_device *dev)  
> > >       return csum_cmd;
> > >  }
> > >
> > > +static bool rtase_skb_is_udp(struct sk_buff *skb) {
> > > +     int no = skb_network_offset(skb);
> > > +     struct ipv6hdr *i6h, _i6h;
> > > +     struct iphdr *ih, _ih;
> > > +
> > > +     switch (vlan_get_protocol(skb)) {
> > > +     case htons(ETH_P_IP):
> > > +             ih = skb_header_pointer(skb, no, sizeof(_ih), &_ih);
> > > +             return ih && ih->protocol == IPPROTO_UDP;
> > > +     case htons(ETH_P_IPV6):
> > > +             i6h = skb_header_pointer(skb, no, sizeof(_i6h), &_i6h);
> > > +             return i6h && i6h->nexthdr == IPPROTO_UDP;  
> > 
> > [Severity: High]
> > Does this check fail to traverse IPv6 extension headers?
> > 
> > If an IPv6 packet contains extension headers, such as an IPv6 fragment
> > (IPPROTO_FRAGMENT), the nexthdr field will contain the extension header's
> > protocol number instead of UDP.
> > 
> > Doesn't this bypass the workaround for the exact fragmented packets it is
> > intended to fix?
> >   
> Thanks for the review.
> 
> Unlike IPv4, IPv6 does not require extension header parsing for
> this workaround. The hardware only treats IPv6 packets without
> extension headers as PTP packets for further parsing.
> 
> Therefore, IPv6 packets carrying extension headers, including
> fragments, do not enter this parsing path and are not affected
> by the hardware issue addressed by this workaround.
> 
> Skipping such packets is intentional.

I thought you said that the problem only arose with packets that are
fragmented by IPv[46], in particular short final fragments.
If your hardware checks for extension headers then doesn't that mean
that you never have a problem with IPv6 packets.

-- David

...
