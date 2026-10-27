Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793141523;
	b=2Y86uZgFc6UsFH2NFu03j5y+4OyQUrbo41PuFgRHe+F4nXEpjpxudPPbQfBOryx1zRYv
	 hWI3rRcagVQ7Vx8H+loHzv2Kym44AACFZWbxSV8hrxvEzM3UUMcRRxocXb1wfALz0tnNI
	 fqPcm1C+r9tM9UieSyS9UZV8rYD5E1JH8k6t6d0xl+Y6LYoAqgm2w5wikP3mu8QtOF20P
	 CfrW9nvHV0OMV2gfQciYspW/grlLyLukrcvfxBVfOUpE9CY02801yvD4G2Uua2JeSr5YB
	 3wDZjI/mA04yeYgglDd2QZVwijkhchOxV4XPgdEjjuVyE7YNJ7ptYCEUg1ipaDNgWmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793141523;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=9nLhzNnuR7rMVo3Esh8395rEk4roZFjv/lWnMw/Mzgw=;
	b=4MdX2rmWyRZ7JH38SlhUW06Eu0+Tx/vXIFjPDEeU12bgzxcv39mqpLXV0UBHUUs0k0ii
	 fnj7MTcPo+BvSSdrWQoxRdCTs/nTc097SBUw7QQAjichPSoG7bxnXvDR8UxXdx3NKwqRq
	 fkj8qeQ31Zpv894UoT8nU7a9b6LKTm0i859mVbjpx8OrQVuf8qjRApUt+hSIeCY+463/X
	 H1h19WiPkusUPT4qOZHg8pg1KGPr9B9s4kk12L5AxEtpY8qnPi68IxNT2OLpzSXpcKNbR
	 RCojg8X6+4BkykJoV5HddHwuFWihZJQWSp7sCkueOb/QiRTp/I+16ZrvQvodPZMOJZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h+IpKiM9;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DDE606A31E
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 22:52:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49DDE606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h+IpKiM9
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3ab41538192so311989a91.0
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 15:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793141522; x=1793746322; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9nLhzNnuR7rMVo3Esh8395rEk4roZFjv/lWnMw/Mzgw=;
        b=h+IpKiM9EJt2thLQz1fBkjo/WZpclRTehidHTaDMWs/2As2J1KRXkq5WjU7mWFvA6f
         m+ETDsnZifKaqRyTJrVwxTJDB4rvr+WvlMqgB9CQpDZsnkPSEtaXUki5XL/ER0lEg/I6
         7jeUBtEbST9g7e7iqOTug9MPf5PBwbqnJt6Ai2rqj0GNGcEMLFYZuxoMwSefCjD06X3b
         I46MVsDVHmB+yhlFZaUkLkJMov+Bj5XmNkBoTc3uI617g8yxV7ZID6NiYhDmBIijL4/F
         RSpIudgAxUs06IE2i4kne682u9l1XiM0c6JUWyy48dFyk7DdBR6zuOjW5UqnRPBHoUaw
         ZLWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793141523; x=1793746323;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9nLhzNnuR7rMVo3Esh8395rEk4roZFjv/lWnMw/Mzgw=;
        b=qmvKg4BxZ1I27asjba1/BWtOASLZ1uNo2i/hW6xyQO3MLiNbZoI/aOawMAmwtP//bA
         nVxIF+osRmJ7jN5NBlD0CVYMwCeWCfFQ0XTtYU4yxwOhKRnGefnRaBmQyjAoC0DIsfD4
         dLrZ7baQxFZvN6pWuyVshb0mIi1Dz6ASij6dNZ3RvrtjvCUTfhDfCA5gOx8Q81JtaSIW
         7wfsz20ic0f4lDjfQ1oRJHNbPktTCjtZjgaLt3NUgls2h4U6UXbLv1X2dDHeMYnIsSvX
         oPb5X5jmpFkTge2u4P9VoY2IeBXg7Oy53WFpJA/ku0M+0eE3nr8mZLEJVN+rjFYHV2pz
         ygjA==
X-Forwarded-Encrypted: i=1; AKwUvBz+zx+RXZT2DGAcT7GMU89TfKs7qtnYd1N2FsqhtdpThsjrwaDssmFxq506kX6DMadkZ+oFczI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKlA9l+JPP6GOG5v/flfJ9kYGk8V9KqXI2miroDFyXl6oNKaiZO
	RY2vbcEaBCfqxEtHbWFqrXm6A5hKrIGVeVAGpyqMNW/Vm9/z06ZIKcT1
X-Gm-Gg: AYBFou06uWgWtb/37I2WuVk4MBfieVoMt0tzSmky0kM072e6RnAzDzclLJ5n6/BCJeR
	J1bGHr6sR2xFeagtHIuCrcbiE9MHJw92IO9jEeXUs7AX046l3hxbWxchh6tDHUAQSqW2hqS+MbF
	/vbYJEbigTtl4L3a3ymCb7ClAJZdNCbYKzkc0gcQaK4qtbP5bw/Sg2wfBLtvkj5UokO7RWO1KLJ
	HaqATrpckYsb/4S+K+b1Z+oO8hW4HaDn0+JfDbDar+RtY6yv7FxGApkt8/aDr3P7hv8KRb1kiht
	nlGhDu0ho9EiXEd5icKHmk72FfX0dsrcu9lTnjM7Tz+v8GuhHmcXPN3NNDd4pLOglRi8FaQy7+Q
	MD9ygLfYnZ0g5Zv6KWpxNiNuigcTq+Oe4TyIgJ1XQVb3qxA+CvjlT4YBAsCvUTHzZHWpb0J8rb4
	KM0daHzbMHF5FNpOVdBvwS402BtVNWcqCTkMDQbnWIgYaurYXvPQ3YJY55ealBKK+nPAEWMgaVs
	qo3XZI6n2ruU/M3oHtQQ5Wccx/7plw2ehXo+ctJE0YP3V10yjuu+8SmPyJzaJsJ/1kO8rbfCcfc
	WTAPTbUgISO52GnOApr1n5w+zGxMf3csl8K05xSTesW6
X-Received: by 2002:a17:90b:2745:b0:3ae:5572:c4e2 with SMTP id 98e67ed59e1d1-3ae58317899mr361987a91.57.1793141522593;
        Tue, 27 Oct 2026 15:52:02 -0700 (PDT)
Received: from localhost.localdomain (ip67.244-167-222.hkg.ten111.net. [222.167.244.67])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae5a944acasm192658a91.7.2026.10.27.15.51.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Oct 2026 15:52:02 -0700 (PDT)
From: Guoshuai Yang <yangguoshuai@gmail.com>
To: netdev-bot+sashiko@kernel.org
Cc: Guoshuai Yang <yangguoshuai@gmail.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net v3] xfrm: esp: reset outer TCP GSO metadata on espintcp input
Date: Wed, 28 Oct 2026 06:51:55 +0800
Message-ID: <20261027225155.49607-1-yangguoshuai@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <179308626642.3134.14988418944940808850@kernel.org>
References: <20261023065311.65031-1-yangguoshuai@gmail.com> <179308626642.3134.14988418944940808850@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, Oct 27, 2026 at 07:31:06AM +0000, netdev-bot+sashiko@kernel.org wrote:
> [Severity: Low]
> Is enabling rx-gro-list enough on its own to reach this case?
...
> Could the commit message describe that topology? Could it also say that
> this half of the fix depends on TCP fraglist GRO? That feature is much
> newer than e27cca96cd68 from the Fixes: tag, so on stable trees without it
> the pre-pass does nothing.
>
> [Severity: Medium]
> Is there still a BUG_ON() at this point? In the tree this patch targets,
> skb_segment() handles the condition like this:
...
> Could the commit message say which kernel the trace came from? Could it
> also describe the behavior on the kernels this patch targets?
>
> [Severity: Medium]
> Can fragp point at the ->next field of a member that is still shared when
> this store happens?
...
> This relink pattern looks like it comes from ___pskb_trim(). That function
> handles skb_shared() on every member before skipping any, so it never
> writes through a shared predecessor. Would it be safer to privatize every
> member walked so far, including the skipped ones, or to copy from the first
> shared member onward the way skb_cow_data() does?

Thank you for the detailed review. All three points are valid:

1. In esp_reset_espintcp_fraglist_gso(), skipping a shared predecessor
   before checking skb_shared(frag) means a subsequent *fragp = frag store
   would overwrite the shared predecessor's ->next pointer across both
   clones. Unsharing every walked frag_list member first (as ___pskb_trim()
   does) before checking SKB_GSO_FRAGLIST guarantees that fragp always
   points into an unshared predecessor.
2. In the commit message, I will clarify that the BUG_ON(!list_skb->head_frag)
   oops trace was captured on a 6.12 LTS kernel, whereas on current mainline
   kernels skb_segment() hits DEBUG_NET_WARN_ON_ONCE(1) and returns -EINVAL,
   causing validate_xmit_skb() to drop the packet.
3. I will also clarify the topology required for TCP fraglist GRO
   (SKB_GSO_FRAGLIST) to reach esp_input() (e.g., rx-gro-list on a device in
   an outer netns forwarded across veth into the netns hosting the espintcp
   socket) and note that this pre-pass applies to kernels with TCP fraglist
   GRO support.

I will send a v4 with these updates.

pw-bot: cr
