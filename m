Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792516300;
	b=Db0YHVSCHNhO5RlXHTPNI1uT7Qx6QOd362Ygm7jrJtk+NlNo00JrEAUbhr+nbIolBq6G
	 rNDR9jakxWCeu5aQHQHHeEL5OzmGDDRKPULmh7DER0gn0tKiTqaxEV7EgXv3pyApf9PfF
	 WHIaW1H7aRb6Amxw4kelb0Bs5Y4Du2tDpugy7tS1nQI8D7PNCcgxYHM3bXAt5s6Iw0V2B
	 zT2/u6ooLYeDZWkA3V19C/A9l60cHS4n4SeeA1C6F499EOEIYg2CvWKtXQUKh6EN0sQCy
	 GN7wjhM1jcmcdgjgWlIIh9O96qupNUhBGpzbejZM/hGW4dKFEbz2sjO6O55PbN0Cvng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792516300;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=XNNuCN/U6izbmBVvP629yRqSP6xtDUjEail1X7p38hc=;
	b=e0kfsRoRfCdPRRwS332gRRqihYmkVrqEWNcvhQhUVEAuNFfPtVtOnGa3+QqOl0Lgbvel
	 J111Ewbva2+gpbN5qYFt5ZljQJ7T5mtRkIkie+huZRm1zgRIRN78BkW2s6J2WJ81hl8TP
	 aNaRpX/iarotkQUBUI6wBSDYvthJdiJv+Ud8CzAsFIZsrucAXas22Zw1UvVqgjX8SW04W
	 05K78tpfCzcegriFCaSGlEQT25966dcqCifvKiwjzzz8bCUpfS7Dt5qqXoXL+C+K5nP2I
	 Ej2oEBBWF1JzOum/vEZWHW5nNfWB3qn1uWlDFQBIvgnLobRgh1ZBnzd/Aa/1ebNM+Fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AIa0nnUa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E16606A325;
	Tue, 20 Oct 2026 17:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AIa0nnUa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E298C1F000C9;
	Tue, 20 Oct 2026 17:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792516299;
	bh=XNNuCN/U6izbmBVvP629yRqSP6xtDUjEail1X7p38hc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=AIa0nnUaTNjCk4cIRx+AkEi4jLLZ57Qf0ViSOMKTRIMdooH1Vky3uiDTta6xfOW4x
	 BVkQRXeK3R1aeCrBTgKo2nQak80wa5W7ZHXUF09k62mYS5GyisQD48yYvJu+PkiFQ9
	 MNmFzX/F/6av1OECw9Iyp4kGoVMQxS8VmtQ6qcTrtN9A7jC53gaMrsjf+DXG4mcgSt
	 juuQ7y8yX4dDjvzi3i2hiUbFPl/TDIjvc8UYhzzGmG5ceB4oaqksMyULyYaYOOmQKP
	 pDprqmhdBXFPk0pIs8hrE2dgqQTpdLSi1ghLcqLy9sXk6xP/rlZFIJ+foQ0uX9eq6b
	 VSaOSPHWGoMsw==
Subject: Re: [PATCH net-next 10/11] can: replace ARPHRD_CAN type checks with
 can_get_ml_priv()
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, 1579567540@qq.com,
 stable@vger.kernel.org, mailhol@kernel.org
Date: Tue, 20 Oct 2026 17:11:19 +0000
Message-ID: <179251627911.3135.5362969890074772101@kernel.org>
In-Reply-To: <20261019170834.1727150-11-mkl@pengutronix.de>
References: <20261019170834.1727150-11-mkl@pengutronix.de>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message is inaccurate about where the crash happens.

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but isotp_bind()
  in net/can/isotp.c still ignores the return value of both…

--

can: replace ARPHRD_CAN type checks with can_get_ml_priv()

This patch replaces the remaining dev->type == ARPHRD_CAN checks in
af_can, bcm, gw, isotp and raw with can_get_ml_priv(). The TUNSETLINK
ioctl can switch a TUN/TAP device to ARPHRD_CAN while dev->ml_priv stays
NULL, and such a device passes the old type checks.

Link: https://patch.msgid.link/20261012164802.94113-1-socketcan@hartkopp.net
Link: https://patch.msgid.link/20261019152741.54854-5-socketcan@hartkopp.net

> The TUNSETLINK ioctl allows a down TUN/TAP device to set its hardware
> type to ARPHRD_CAN while dev->ml_priv remains NULL. Such a repurposed
> netdevice passes the ARPHRD_CAN checks and triggers a NULL pointer
> dereference when CAN filters are created and when they are removed,
> e.g. by the CAN protocols' netdevice notifier handlers.

[Severity: Low]
Is the "when CAN filters are created" part accurate for this tree?

Commit 8aa59e3559494 ("can: af_can: fix NULL pointer dereference in
can_rx_register()") already made can_rx_register() reject devices
without ml_priv:

    if (dev && (dev->type != ARPHRD_CAN || !can_get_ml_priv(dev)))
        return -ENODEV;

raw, bcm, gw (through cgw_register_filter()) and isotp all create filters
through can_rx_register(). So creating a filter can't reach the NULL
ml_priv.

The only dereference left seems to be on removal. can_rx_unregister()
checked only dev->type, and then can_dev_rcv_lists_find() does:

    struct can_ml_priv *can_ml = can_get_ml_priv(dev);
    return &can_ml->dev_rcv_lists;

The spin_lock_bh() on dev_rcv_lists->lock then goes through a near-NULL
pointer.

The path that actually gets there looks like isotp. isotp_bind() ignores
the -ENODEV from both can_rx_register() calls and sets so->bound = 1
anyway. Later, unregistering the filters crashes:

isotp_bind()
    can_rx_register() -> -ENODEV, ignored
    so->bound = 1

isotp_release() or isotp_notify(NETDEV_UNREGISTER)
    can_rx_unregister()
        can_dev_rcv_lists_find()
        spin_lock_bh(&dev_rcv_lists->lock)

The code change itself looks correct. Could the commit message describe
the crash on removal and the isotp path instead? That would show stable
backporters which code is affected.

> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index 64ff203a37f4..5e1c3971ebfc 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c

[ ... ]

> @@ -1618,7 +1619,7 @@ static int isotp_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int l
>  		err = -ENODEV;
>  		goto out;
>  	}
> -	if (dev->type != ARPHRD_CAN) {
> +	if (!can_get_ml_priv(dev)) {
>  		err = -ENODEV;
>  		goto out_put_dev;
>  	}

[Severity: Medium]
This is a pre-existing issue and was not introduced by this patch.
Further down in isotp_bind(), the return values of both can_rx_register()
calls are still ignored:

	if (isotp_register_rxid(so))
		can_rx_register(net, dev, rx_id, SINGLE_MASK(rx_id),
				isotp_rcv, sk, sock_i_ino(sk), sk);
	...
	can_rx_register(net, dev, tx_id, SINGLE_MASK(tx_id),
			isotp_rcv_echo, sk, sock_i_ino(sk), sk);

	/* switch to new settings */
	...
	so->bound = 1;

The new can_get_ml_priv() check rules out the -ENODEV cases. However,
can_rx_register() can still return -ENOMEM:

	rcv = kmem_cache_alloc(rcv_cache, GFP_KERNEL);
	if (!rcv)
		return -ENOMEM;

In that case, does bind() report success even though the socket has no RX
receiver, no echo receiver, or neither? RX frames would be dropped without
any error, and isotp TX would wait for echo frames that never arrive.

A later isotp_release() or isotp_notify() for NETDEV_UNREGISTER would
only print "receive list entry not found" from can_rx_unregister(). It
would not crash.

Other CAN protocols handle this: raw_enable_filters() rolls back on error,
and bcm_rx_setup() checks err. Should isotp_bind() check these results and
unwind too? The last patch in this series ("can: protect the receive lists
with a per-device lock") still leaves both calls unchecked.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261019170834.1727150-2-mkl%40pengutronix.de
