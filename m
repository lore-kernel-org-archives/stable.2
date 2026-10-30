Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793389954;
	b=FQYujbfLh6RQL5VYdf14yE1Ru6h2Jwkagryrydv0SGneX7B1FBs9VYNVS84T+LcQL37o
	 ewmMnQiGbUbtLd0X7tzRgweOh1KoAEFb4VFakadJ9QGVX0Fx+uB1ZtarzEGLka1cMXDuJ
	 aTgJf/mBIQVafcrnjoXY7HtfIyA9UPhaxAxFjG4lgXt2mVCzoe7UnH13KLydNuNGog931
	 7fG8oMD3W79uueh3atqAKehDko4Sv3JgoiqaJGpcLgnfhYqR2Nit2cuiao6VN8T1Ua11P
	 Qe5RwwZYq/pkCv+3u/lRJVfvTTsbJowXj/f0rbwo9/OeoMj1LzBpxIH8w4Imp9X+YYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793389954;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=J2FNx9D7Jgf8hIvN2HsGFMpO76oeiBS4WlAa4ihS6JU=;
	b=5dgPUZlP44nOCnZapJuU3nc3PwONhGO+bJntfei4sk9MbdlVP7be8WDNgk3Ic/oaF1C8
	 t6qMynUYrZegHo9TlS7w7OmdTnVkxJ9/uHAcpluLUP+Z7P3eFg6pA2ooexoblFnWaaEb7
	 SBJCkbn9QK44q54X+Hltkywmat9P8Bs+q3wyTe7ro3jN2G6EsfQUG8xV3HPgsihOKIW6m
	 ay9fN8kFL2M22MfpPwFeffzeff4wmzexB5fogy64IH+Icx1X9aR/ymb6XeUmz5tiqM/dA
	 JTlCX9lVeJEmqikjDuKc17NHGA3dUFzKw12Igdjqf0tQddwraRF51X5XUYQvwkeof3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=seQZx+ZI;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82A0606A31A
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 19:52:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C82A0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=seQZx+ZI
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a35ac4475dso8040765e9.2
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 12:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793389952; x=1793994752; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=J2FNx9D7Jgf8hIvN2HsGFMpO76oeiBS4WlAa4ihS6JU=;
        b=seQZx+ZIbtq0KWnnRxo4qAuwbIfTV5M5Tt0hFEfcSZpVC/4qfxmXWAlgHkvqs7Fonf
         JP9ViFl0pEjC3CgF2HUO/WCVpmZY+4xvkwXY9cPeunqWxhvuyDIEWExuK2UJ9XZHsB7X
         PDv7KIS+vlLZU1gFWI219gYmvfDLiyVupNSrvHopLA/QfLBv7T0XmQvLIAVp+djwD5TH
         ftdz9KJ7ZJzUPr6GsdJniA5JJ+WDGjkb4enwdnu9d0Dn7D26fpf94Xjl+44GXJcWIRJX
         HeXegDYhhwLj9FqGAtu+EzOKHIf70/D95SuRDpU/wFukrpVI4VUn5VkLvVTKg65k0l+M
         /aYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793389952; x=1793994752;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J2FNx9D7Jgf8hIvN2HsGFMpO76oeiBS4WlAa4ihS6JU=;
        b=aVTy7ZJbiiXfPtvVXF2+VTKXE9Ao35VJEpPDovb7++AoJQ4e4OO8PUdc0HOv331mR5
         r6pcHj94Sr49oA4q+TnXltEmOnT7NypxFUAOjt3Ir+B9CaEZcbKz24SWnV20WmBUHhl0
         b+sFyR1bTVqzF0VdTpwLABPY8XdF6Vt4VD4o2owh0I+BgL5MpS+1G1MxWY9GWqRiIOBE
         Lkp4qsa1eNEri9O7II/nBNA8rFQTuU1mSJfNwqoFcm4agFubM23UNuRUn540OlM83VJ+
         9MVygSMcZqeg2hWZI95C9+7ive2GS569Wvg5BOhkpkjc9tSbVKKW/qowkRjROnvyXGmj
         pLgg==
X-Forwarded-Encrypted: i=1; AKwUvBxY3Z1Osdx7JCTMn8cKN76/lSsT++t9dlMyz1Ukwd1p36Hr8//gvZYUj8J9yEksI3LtrD1Eamc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJPI3VYxn9GNcBB5Qcuk9f7u2PjNQL/muaexbXkP4q8h6IN1/m4
	vN/wLVpnSRR/ME1w25Si6ZsRnmPfT3nuMN9VBx7MwGvrrmmcV5mfIiV0
X-Gm-Gg: AYBFou1xptF7qNQMSra6bdpa7AOgYnW28RlldU8tGQa/tOhT8EXB1iQVYUev/ybqstr
	DrRTUavN64stB/qWMczrXxemZPiKrEsgO7UmnjNoedxc+gbLY2oE6wSjSS4Rax/fJSzrL/2k9JK
	hWgko1+dxCFy4w0DnIv/wKn9lNpcYpw23sOJVumVTkXflugxbzmVK3r4BP7FTUNT7qKezkhAth3
	/nUM/LluYCi4SwOqz0jWfuTM5gzwYnDQr6PaW83uFBsqF++NaIG/CDLvKNcbAmUXJlKWEcZNSff
	j1d2xtOUYz8MImzRyMH3AaWCg+Nb2Gyip2u9IY8W8q0xNinI8CHzWCRE53lGSGPkYlxkUEg2QPT
	/m8zERnAgvXW5X1HxT+7v553dhsIHFBu+9DLbz2Q2+UhK2NqObTUTEt2SceS6Bsuk7uqXPz2wdp
	4zdy6WAZE1s0p/klNMtGmtiqsrbMatCh+FMn+y5RWJmurNpaEUMd9kuUfqKBRGd1NROsqTP58P3
	Bj9KBwbB4P56SubOoW+EDkZcbGXL3o9jJX2vx9Ig+bqQd2EXv+qqNYrMrgbDHK6utqJBBAjXqsm
	W0XAT29l6qFJ4v8SIX/oKdiDxkFtJGccveCj4RSCKt5+xJDHjAUzMzcHeZXdiyIT2GZoB5p0zQA
	Cdw3+PiPdGsY=
X-Received: by 2002:a05:600c:630d:b0:4a1:fae2:a8ab with SMTP id 5b1f17b1804b1-4ac150b38abmr73624505e9.3.1793389951966;
        Fri, 30 Oct 2026 12:52:31 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa80f04723sm179193345e9.5.2026.10.30.12.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 12:52:31 -0700 (PDT)
Date: Fri, 30 Oct 2026 19:52:29 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Zhou Qiuyue <n0ps1edzz@gmail.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, Ido Schimmel
 <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Hangbin Liu
 <hangbin.liu@linux.dev>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net v2] ipv6: raw: fix use-after-free in
 rawv6_send_hdrinc()
Message-ID: <20261030195229.50841726@pumpkin>
In-Reply-To: <179338190237.9376.13820542101227461550@gmail.com>
References: <20261026044808.613-1-n0ps1edzz@gmail.com>
	<20261030160532.4832d994@pumpkin>
	<179338190237.9376.13820542101227461550@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 31 Oct 2026 01:38:22 +0800
Zhou Qiuyue <n0ps1edzz@gmail.com> wrote:

> Thanks, David.
> 
> Yes, in the redirect case it passes the old rt->dst.dev, while skb->dst
> has already been replaced. That changes the NF_HOOK outdev, so it
> probably belongs in a separate fix.

Does that actually mean that it doesn't matter?
Or has no one every actually used that path.

What holds the reference on rt->dst.dev?
Something needs to stop the interface (I think that is what it is)
being deleted mid request.

> A bare rt6i_idev or dst.dev pointer looks unsafe, since dropping the old
> route drops the refs they rely on. An explicit hold/put could replace the
> RCU lock, but adds per-packet refs, and doesn't avoid the deferred route
> free. As far as I can tell, that uses the embedded dst rcu_head; the
> temporary rt6 in this path comes from the existing HDRINCL lookup, and v2
> doesn't add a new alloc/free there.
> 
> I'll test moving the RCU read lock before l3mdev_ip6_out().

IIRC the rcu free happens for every packet and uses kmalloc() to add
the item to the list of things to be freed. So an extra reference count
may be better - especially since it should let you do a not-rcu free
of the temporary rt.

In the non-redirect case the temporary rt_info would have a reference
count of 2, one owned by the skb, the other be the sending function.
That would mean it could safely be freed at the end of transmit.

I've not looked today, but I remember this code always allocating
an rt_info for our application that was sending udp using raw sockets.
The app uses a different raw socket for each thread that sends udp
in order to guarantee the sendmsg() doesn't block anywhere.
(There are associated udp sockets, they have to be unconnected and are
only used for receive - monitoring 10k of those is 'interesting'.)

David
