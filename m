Received: from mail-yx2-f41.google.com (mail-yx2-f41.google.com [74.125.224.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E282652F26B
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 14:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790693897; cv=none; b=mbwwdOe6qBIs9SKK0LYidUd069jzZ8xrY+OhR3GaeTEg4X0gyfopmKkef6RobN6XHr5jPTReUA9gnxo/fEEMLRajcjUUU7S5VcSfHUu3kTszQsLvDE1K12e9hz4nH1T3eHVQSDSTQqVVeS4AmG9cgRgtxP0dQ19alXd+Oc854EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790693897; c=relaxed/simple;
	bh=+Nae+VQCeZSmSPqR0LLrqa4yrCW4mwWubd2DoSBMmm4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=SzrOunEpmMFDH6rVmDt4wxul+UV3aiDLGbtroSA7p/g6yiMG6sxHwZkcBNiJPOAEBX1/ChISUKdos6QSNQw2iIzEye96XIhjFyerL+cjG1Eygo0lO3bfKpEB33kCavk522MnqJbZGcILdLHqZ1OEw8eDe6L5XUX7D3dqm+GVAc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rSeO5Rtb; arc=none smtp.client-ip=74.125.224.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rSeO5Rtb"
Received: by mail-yx2-f41.google.com with SMTP id 00721157ae682-8a8288165fbso40258807b3.0
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 07:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790693886; x=1791298686; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iS0vI6VPFheNRyG7TeQ5h4c/DL9d1CbeqeEtao3CvUY=;
        b=rSeO5Rtb4rpBcgalBZME4CzwkFx/cHcUp0pnWTFuvBvuATOZxAqH3QH6niCkqsXk9g
         /AtGQvGgh3s+nmfVrAamu3+jqmi6YpxtAz646NJhpYkNHfB4liSfKwKXLMO2P+h5eINh
         3dz3ZBMG8JkrkquaV8rcCUYqOZkpvizKG1TjhtGhunoZIAfhEbrZi4HYW1CkWL5sBW2G
         wFdLRvymoreXAJtxof1T8M3O0PzjmWiU+eHUH8uiejRVePAAVWm1a/4C5VOWqpt2kU7r
         jfCoYvyO+A801Zntyd/0oV5ZP4AFedPwB0HNilBmjvZ0VskCut8Lm/Ja5FYe/Fm2uVMN
         6tMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790693886; x=1791298686;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iS0vI6VPFheNRyG7TeQ5h4c/DL9d1CbeqeEtao3CvUY=;
        b=ERcTRNgDsnxiddDSzSje0+1bNe6DIu/q8H5888bNwZZigdJC7auTR3Pxg6Wo1wDHpE
         2ubK8HqzDKHOU4j3SFAcu88i64fk4/VzGj9gJjtzzJ9XywuNUD4yZ+MJCy5LWxBx69l0
         0Ps+ECQ0kRZeAQ2jA8dEH5CtjBWPp+vxm0o/VixgsQMIVHfp03G3TQwmRSihZYw6BMEc
         VEhmKnD9UJB1Cjcv1VHXcDepIBcbHmfim27OH6hZk2MlJSxgojTEvCudGTiVwY4thQmv
         3B1Ns0k0XCzNWhYOipW6nEorpcPuaBY+Qg4uvFp6RE1QPkTOufQ/6r6BnxQlAIrNcNzR
         B7rg==
X-Forwarded-Encrypted: i=1; AKwUvBxVVz0PbR98/gFf/m3pP/565Rmaq4jw98W3q95NF22gIHeYozpv5imCXaFLiGsfkqie08W0Wck=@vger.kernel.org
X-Gm-Message-State: AFq9FYK27ikLjUzmeF3DKc1e8fPp7vYgG46ysWif9CiFsh4nvj4/pe7i
	4Dl7ci/nHSqCDjhG54rxviofJsRmBRo+gpFkGgEs/+gpeMO+iVp7Fa2L
X-Gm-Gg: AYBFou3kHhg8fcDUO4A3Rs25a5o6svPO70XYUL+1bWug94jEMp4PGUz6Iv+81qb8H5b
	Zr2MQ3dwKOXkQ9M7HOXtPViwN4rG4v9u+ifaw7R8syIdGzuHrHe7du0ZvIX0E28uzz8B/vdTjxc
	NjL0mQBhI0IXwEjsrWeetTb4d/Lezh34eF60yFmMR83wMENzyHryfjMB2c3gimMzI6yLcMmUMMZ
	2bLoz3WHbScbhTY8E4xVcMKwIqFqnoKqK+A9S1OQDpTPi17Glf0B9R78IG+tSVVvEV95kRWFmFw
	ubBMPBqaBj9vgqPT+pHIqZkeu5T+2aXEeX8OCUaFIy65LS8XLFh7EsCQGoCh+m+x762LsWl/T5m
	4Rt+TFTsDVj+gPCoeuzu9XjAjYEwAnad2mFUYqJbeKV5poD4OkRW9LMu5Vq89OABS/Mk/0XVFNw
	YqBF4ai1Ze+cdR9t84tgL+FnI0DMb2W37So4P2582puq4+VB2pYxY3Kr7ytRC9y6Kf9iHY1xIXc
	2L7YPGmoVZHjzakqn414e7QUkbckS6Zu11Pi2mcisS908tN/QMi
X-Received: by 2002:a05:690c:e68d:20b0:8ab:318f:1b61 with SMTP id 00721157ae682-8ab9588cbf2mr959057b3.41.1790693885914;
        Tue, 29 Sep 2026 07:58:05 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8ab46e3d02bsm6381477b3.29.2026.09.29.07.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 07:58:05 -0700 (PDT)
Date: Tue, 29 Sep 2026 10:58:04 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Quchaosheng <quchaosheng000406@163.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Quchaosheng <quchaosheng000406@163.com>, 
 Simon Horman <horms@kernel.org>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>, 
 stable@vger.kernel.org
Message-ID: <willemdebruijn.kernel.24f9b153d245a@gmail.com>
In-Reply-To: <20260928113108.2127215-1-quchaosheng000406@163.com>
References: <20260928113108.2127215-1-quchaosheng000406@163.com>
Subject: Re: [PATCH v3 net] net/packet: guard the ll header push in
 packet_rcv_spkt()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Quchaosheng wrote:
> packet_rcv_spkt() restores the link layer header with
> 
> 	skb_push(skb, skb->data - skb_mac_header(skb));
> 
> That subtraction is only meaningful when the device actually has a link
> layer header.  packet_rcv() and tpacket_rcv() both wrap it in
> dev_has_header(), which is also the predicate the block comment at the
> top of the file states the restore in terms of; packet_rcv_spkt() does
> not.  commit d549699048b4 ("net/packet: fix packet receive on L3
> devices without visible hard header") introduced the helper and changed
> the two call sites, and this one stayed behind.
> 
> A device without a visible ll header can leave skb->mac_header at the
> 0xFFFF sentinel that __alloc_skb() initialises it to.  A CAN skb does:
> init_can_skb() sets pkt_type and ip_summed but does not reset the
> headers, and commit 9f10374bb024 ("can: remove private CAN skb
> headroom infrastructure") dropped the skb_reset_*_header() calls that
> used to be there.  skb_mac_header() is then 0xFFFF, the length becomes
> a large negative number and skb_push() reports it through
> skb_under_panic() -- from softirq context, so it is a full system panic
> even with panic_on_oops=0:
> 
>   skbuff: skb_under_panic: text:ffffffff8bd21bc1 len:-65455 put:-65471 head:... data:... tail:0x50 end:0x180 dev:can0
>   kernel BUG at net/core/skbuff.c:214!
>   RIP: 0010:skb_panic+0x50/0x60
>   Call Trace:
>    <IRQ>
>    skb_push+0x38/0x40
>    packet_rcv_spkt+0xe1/0x170
>    __netif_receive_skb_core.constprop.0+0x7e8/0xd30
>    ...
>   Kernel panic - not syncing: Fatal exception in interrupt
> 
> The socket type is reachable: packet_create() accepts SOCK_PACKET
> alongside SOCK_RAW and SOCK_DGRAM behind the same CAP_NET_RAW check,
> and neither the socket length nor a capability check keeps it away
> from a CAN interface.
> 
> The missing skb_reset_*_header() calls in init_can_skb() are a
> regression in their own right and are being fixed separately, but a
> packet socket should not turn a link layer that did not initialise its
> mac header into a kernel panic.  Guard the push the way the other two
> receive paths do.
> 
> Tested on v7.3-rc5 under QEMU with a slcan device on a pty, which is
> the driver RX path: vcan does not reproduce it, because can_send()
> resets the headers on the way out.  One SOCK_PACKET socket bound to
> can0 and one frame written into the line discipline panics an
> unpatched kernel with the trace above; the same image with this patch
> prints no panic and powers off normally.  Both kernels are this tree,
> defconfig plus CONFIG_CAN_SLCAN=y, differing only in this hunk.
> 
> Fixes: d549699048b4 ("net/packet: fix packet receive on L3 devices without visible hard header")
> Assisted-by: LLM
> Cc: stable@vger.kernel.org
> Signed-off-by: Quchaosheng <quchaosheng000406@163.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
