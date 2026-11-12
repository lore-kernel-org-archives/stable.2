Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794522729;
	b=NgSFiSRZJnRxo40BTdGP+kqaz8iQZdGSDAqWiXC8AJibD3tzD4QegvyK89jN9nN9cuh5
	 HV8fyKH688QSc2UST3yOfqnejpwyU404cBsUrBLEPdsYON6EnBF/APoeFGj+DcPZj0S1Z
	 XZ+BwVqYgyNHMpqSNf9PnmqjeXuArwR3ymtLErl4VTbBTICxDgmLddc3mRrW8hi9ikefN
	 bcdzeMjAWEb6+I9pJITCAOnkMgoYNnKefjSZzUpzeG17WF0lzL4UlwLFqlYpaCK/K4jkg
	 zcSAkaaJwB7NsvLZ7V9BIoX/tEZ7wRlFoA3aOLL5tFrFq0vHJ1FJ2Y2v9vMg0tTQVnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794522729;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=8bqvMnyVEvBroB2d7Xzxe6U8AVpllM+eYYP2hE1nUBE=;
	b=rsCXFkftXXhepsOLeEflKKnoVL6MkGSv4sPGeSsxSOJK6Eaf5qXR9VhhNfzR0CV5D/K5
	 ci40mBBL2Z/dIW+kdz/rHSaPDcAL3Ab+BIdpS8DP3Y690D+nP0zzqUy43jWqzWfRTkaE+
	 BAl3rIyVqfUjElndPMThQgT7kJVQDn4T6Df66kmTZIYRPJSPkDGzB9pWX4ZK85+YqdRB+
	 hpgVE3pc0nUn3275lzSWW9RIzrMlF5BoN1GG+n3vikIb21bjOlYvmqdZPDElT7VMzVYJ9
	 vryefH0YgUCUdTBHxDR93eFqbKABa8Y7xLdRmZAfunYUjTffo79navTn7ENTM/y5xDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rb8Wmlwk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB4D606A8A7;
	Thu, 12 Nov 2026 22:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rb8Wmlwk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 433AA1F000CA;
	Thu, 12 Nov 2026 22:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794522729;
	bh=8bqvMnyVEvBroB2d7Xzxe6U8AVpllM+eYYP2hE1nUBE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Rb8WmlwkkN8eW1QyRTBK5Hqqvke4TxCEcBmr5FFJJU454l6AstuqjtdgKNnkxjejO
	 4nX0qSnlV1/zzh201Zx1C4uAPlNKKRwS48dbE0xaFgI3EKeXHItBtlvh68cgjBenDA
	 uoW8RlDcgWPJ+r+HGfIdRnmcwp5hN5zTBGx9vYO9ulo/GLgnPvaqUng4VnaPPU7RyH
	 03ZEomcjO97MSDvl9qy3GvxSwZsmRo37rD70/SAYOdZea6L3/IILtTymTZCHmpuI+i
	 hN76EfRIobqjBTVaM7YbG+CJE+jXJ+mi4raeNdwjmpmZ10FRzzPscicsh3hPf+D884
	 ud1skVr3vjEcQ==
Subject:
 Re: [PATCH net v9 03/10] can: rockchip_canfd: retry the outstanding TX buffer
From: netdev-bot+sashiko@kernel.org
To: 1579567540@qq.com
Cc: mkl@pengutronix.de, kernel@pengutronix.de, mailhol@kernel.org,
 heiko@sntech.de, socketcan@hartkopp.net, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org,
 wg@grandegger.com, linux-can@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 stable@vger.kernel.org
Date: Thu, 12 Nov 2026 22:32:07 +0000
Message-ID: <179452272781.488853.6815349480401824438@kernel.org>
In-Reply-To: <20261111-rockchip-canfd-restart-close-v9-3-6643f3825ba3@qq.com>
References: <20261111-rockchip-canfd-restart-close-v9-3-6643f3825ba3@qq.com>
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

- [Low] The commit message for "can: rockchip_canfd: retry the
  outstanding TX buffer" leaves out a likely bus-visible effect of the…

--

can: rockchip_canfd: retry the outstanding TX buffer

This patch changes rkcanfd_xmit_retry() to pick the TX buffer for the
erratum 6 retransmission with tx_tail instead of tx_head. With a TX FIFO
depth of two and one frame outstanding, tx_head points at the free buffer
and not at the pending one.

> Use tx_tail to retry the outstanding buffer. Otherwise, the pending echo
> entry can remain incomplete and leave the TX queue stopped.

[Severity: Low]
The tx_head to tx_tail change looks correct for the one-pending case. Does
this paragraph describe the full impact of the old code, though?

The erratum 6 retry can only run when exactly one frame is pending and
that frame is EFF. In that state rkcanfd_get_effective_tx_free() returns 0:

	if (priv->devtype_data.quirks & RKCANFD_QUIRK_RK3568_ERRATUM_6 &&
	    rkcanfd_tx_tail_is_eff(priv))
		return 0;

So before this patch, the masked tx_head in rkcanfd_xmit_retry() always
pointed at the other hardware buffer.

The fix assumes that RKCANFD_REG_CMD_TX_REQ(i) sends whatever is already
stored in buffer i. If so, did every erratum 6 retry with the old code
re-send the stale contents of the non-pending buffer instead of the
mangled EFF frame? That would usually be an earlier SFF frame that had
already completed.

If that happened, other nodes on the bus would see a duplicate frame.
Locally, the self-received copy would not match echo_skb[tx_tail] in
rkcanfd_rxstx_filter(). It would then go to local sockets as a normal
received frame through rkcanfd_handle_rx_int_one().

If instead TX_REQ(i) latches the shared FD_TXFRAMEINFO, FD_TXID and
FD_TXDATA registers written in rkcanfd_start_xmit(), the old and new code
would both send the EFF frame. In that case the stall described above
would not happen.

The driver code alone doesn't show which of these is the real hardware
behavior. Could the commit message say which TX_REQ semantics the fix
depends on? If they apply, could it also mention the duplicate
transmission and the phantom local RX frame?

Was this reproduced or tested on RK3568 hardware? If so, a note on that
or a Tested-by tag would help.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261111-rockchip-canfd-restart-close-v9-0-6643f3825ba3%40qq.com
