Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794151466;
	b=3gdiUVr92Cek9iG8EECOLRrVjCfqNYYAMYL6dWqVvyCcYWfHWBA6Y/gExmv2G0TuaJt4
	 J7NSS2Z716FE9YnbmI38UL0aoYo6qJNRFi/GrY6r0BoeWiVZJK/1h5khFfhr8nCI1nfHk
	 DqrVlcZdGOYMOZtiS5+3+ZlY4lOKz7h8FBJXrdYEWV9dkGaMq8xzFu7Ah7zkahUI1x36D
	 h17Eh32fsF3TU4DywVtHpx6Qs+cFnvzBvoFnD/mCOJ66v3Xw34BkSFyPOU8LLURzMZuAa
	 1y02KNkrSUGQrKs02VjtBN5cbLrmZwBm9RnSqyMy+B748TNDKjCBx4PlwN7BB80gYoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794151466;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=cL5DYST1xkR3PBaZVQ0xwzE8LOx731rdskN0G11WmzQ=;
	b=ezrbh4JsvBh34G7g9eroYr3uCxB/IFNSrYUTi89uhWeyOMz93Kx28A7sisIvb3tAJqjn
	 DmtU8HV2/hNtp0eP9JlEMlEa4u91o/CYEjeEvonEB3thIejH5PoQjdRZMsWOD6g9Yy8u/
	 Ob2J5pagcQ4pKGZ9tRvK/HXkfNBFo4Ki4Q7CMNfToWjTcEYBMVYxDLyEHitrNlv6IHtVd
	 ldmkA0WTvHqrZwRUdLjNYOTyxr+qxMoAlk/11KeIxF2OZJa478fuLh8iiSCVlbsR/C3qN
	 XmFHyKACgNNnbfUQYFsl5CT9w74fFDGeYmzXVyap7UDQyRCa4FlGCG/fgK0+Rh2DyXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nEdq+0fh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338C8606A33E;
	Sun,  8 Nov 2026 15:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nEdq+0fh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BA0F1F008A4;
	Sun,  8 Nov 2026 15:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794151465;
	bh=cL5DYST1xkR3PBaZVQ0xwzE8LOx731rdskN0G11WmzQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nEdq+0fhmZGTJuVlLBCVuyaNRGqfIwGRrFBvxr39YuRhqd/ifnt0xIwyC3mN+aWkT
	 YQ3whL++WbjKMpa3X5WKwPfGBicn6UOCMOPpuzKqSj1OvKJ5tmetLVWJiPtATrxhhq
	 cDMatYpKpjvcXgfQ58lHWcCq6q9NRG69X1nwftwGBLauRd6dR0saym6Ie5/cw4lZNR
	 ad/xoRa9xohiFpG04LrFFYSrJf8+FRziusot+DDKHrvEMbdh5iSBHmJVCCnUba5yYC
	 PopTxWlNLqPqBEZ29TCga/Q5BBhJYMFPtPDzSSpElI3kH8JzgCRj/w5PPHH8Cexks3
	 YLl8/0u+fyFlQ==
Date: Sun, 8 Nov 2026 15:24:21 +0000
From: Simon Horman <horms@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: vulab@iscas.ac.cn, bharat@chelsio.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] net: cxgb4: do not leak a PTP skb when the Tx queue is
 busy
Message-ID: <20261108152421.GD18859@horms.kernel.org>
References: <20261103100530.1309928-1-vulab@iscas.ac.cn>
 <179404940199.994134.17549120390579622204@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179404940199.994134.17549120390579622204@kernel.org>

On Sat, Nov 07, 2026 at 11:03:21AM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 (1) · Medium: 1 · Low: 1 (1)
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] The patch splits the claim on adap->ptp_tx_skb into a NULL
>   check at the top of cxgb4_eth_xmit() (sge.c:1526) and a store about…

The central issue here is the one above.

It seems to me that either this is a pre-existing problem, in which case
the patch description should be updated, or it is a new problem that needs
to be resolved in the context of this patch-set. And either way I think
that a v2 is required.

> - [Low] The commit message lists "an unsupported FCoE offload" as one of
>   the out_free paths that leaks the PTP reference.
> 
> Pre-existing issues:
> - [High] This problem wasn't introduced by this patch, but the consumer
>   side of adapter->ptp_tx_skb has no synchronization.
> - [Low] This problem wasn't introduced by this patch, but
>   cxgb4_eth_xmit() still sets SKBTX_IN_PROGRESS (sge.c:1528) before the…

...

-- 
pw-bot: changes-requested
