Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795077593;
	b=2z0wg4BMsnii01SZb5ki0/tvscGWRefvShem1blK87q87WlnT5I5xytTatZlWjin7Utt
	 tQYFqZF1YNHLEmGFR9rL5au+Yl34nM6/e9pHxIGhC9PPwYmqChcTi/xrW7Dg+lgNVTdde
	 qFYBUjiWC+ZjNRywFfPOU0EEATVGuuviWrr3J1vIZu+g+08A8HZ20XzXGW9gIG+eodvgr
	 1mamcfZ8iN1MdbxUf/uoG/+pnWrmpuY6PEX5wDSicuzxLv86N6CTxPEvqZ/FI82H/dM/N
	 6E7j//ayOFMvCdYQ5vY2tCRV76RBfN6dtlr483e+yTS3sr7bn4XEaNELsBJ9YtBC1rQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795077593;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=QD+sr8aUmRfY6oLhN7xLP6zroJAErZxqzb7M7kEzdCI=;
	b=LhVxWocLK5vKFiNWFKBiVv/DXq+LQdhZyRV+V0LA4drOaHX/Rg03RHUFQOJbqVcgg8zA
	 7SothIRmEUxydNOvdBXzh9lLHI8XjSRIxkr2sDittq62Onvgb8CzTry9fcQX2y6+j9thp
	 zgd14Mzz2IDRUZ9YhfNPNYPTWzxag/WNMd6ypyyY2DvdFAfzA+L4p5nYca2y6jpW/n1Vg
	 NpUlKXJDpL5/nFhWS0e0kvkzR7gX9jszp1K1f/29eXJK8QYtVt1OJJtczt5nohM5gm88B
	 48kc5n7t3YNEJAZGhywTVPG2zKmlt/e7ixeT2PMyeUxa4WFAKJNSH8hUWV5YpzsMdXQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O98P9cla;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AF560A5BCA;
	Thu, 19 Nov 2026 08:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O98P9cla
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795077593;
	b=ATwnajx9zlUWvrBfxtOY5dwEdCrdHs5YhDkNAyfXK1Dh60BNMUJHlcPpSVw3n1tKkG4b
	 E+f/Gp3oN1RU5uWRAeQq5NjGbWgCZox6uysvXUgszAxljwtldzM92rqdD5zTd3AUbK4/p
	 tf16ZGUmF+YPqr4YHiqgepx/7uTeJsB389z+nEqlgWYNXVRLjXCoGH4XaVEaDyBNbV99r
	 fbhyZVTEp6uQwSUK9S768OgU0FC4p3IfvOyieOFbEKMjVtgBoa7IEgZvvssjqibRPTSPa
	 50VyF1D60cpkBtrIebmErIEesn6B51taGOF9Vd5o/1CtEH36g/bUoy5d1fITdyq0qBw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795077593;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=QD+sr8aUmRfY6oLhN7xLP6zroJAErZxqzb7M7kEzdCI=;
	b=kPMng5qzapdcfNPNgE2TMTh8xRw3Zca1lRXVNiqxywGpBXp2o5nnjbmlrsKkjRlshtgd
	 WiA2+UugiN3ORedYJFjikZDvtFimFs+hGQIS3O/KAclUBFRrAAzutpw6tW88/JKbK4yLG
	 SJn2S7Chg7n9O4jFm49TUVGe6/uQ6QfDnwLL2kp8KhYFK/Qfz8WclyajJbVe5cU8W0uL/
	 rICiFl698r7IT+KwWxnHAQpEOHgcfM1V1NCU6kTNnsO/2CDfXVnta4dIQAM99nMDzd6im
	 lPe7+CMz+3QIu9XhN0avRfQ4+QzWok54fK35HNCbduQvZCT8ysI+ftcty6Zk3PeRkOw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 6FBCB1F000C7;
	Thu, 19 Nov 2026 08:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795077593;
	bh=QD+sr8aUmRfY6oLhN7xLP6zroJAErZxqzb7M7kEzdCI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=O98P9claXatysJjwj5SP3SmknWU0f9FxGP/13RYwdY3T0A3jYm0sf2K5FDdEWMR6o
	 B4k9oRI5dLBptQmQuPwszpp1hyU+nNyIvcds1zQF5NhZjt09oqisC/VQskpyrcuazS
	 2V7EvJVfgb7U6hitoxg4fB63RoLUbaVkRwRHSM0LQPcBm3aOwBUXH1NPk0WBNgp7Js
	 osWFayvDrWt3hz6JLp5JqbIRyePGrUikv1XclYMUoudVNLMq8DlBzty0X997KGGY/D
	 F5yZMUtxO5bartbb1yBiK+MLf+SsLrCAvF8yFWmX3eh1lLLKz86RLwDm5p/6XzsFGi
	 ZuStasYlgoTPA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id BE75F4B1B6;
	Thu, 19 Nov 2026 08:39:49 +0000 (UTC)
From: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Date: Thu, 19 Nov 2026 16:39:46 +0800
Subject: [PATCH net v10 05/10] can: rockchip_canfd: cancel bus-off restart
 before closing the device
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261119-rockchip-canfd-restart-close-v10-5-df23913aa33a@qq.com>
References: <20261119-rockchip-canfd-restart-close-v10-0-df23913aa33a@qq.com>
In-Reply-To: <20261119-rockchip-canfd-restart-close-v10-0-df23913aa33a@qq.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Vincent Mailhol <mailhol@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Cunhao Lu <1579567540@qq.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795077587; l=1589;
 i=1579567540@qq.com; s=20261015; h=from:subject:message-id;
 bh=I72HUC2ujKjaadGUhXTkD9nz9XMWR5jwCKsKJZRMdaE=;
 b=6dA4bo0IuR1E3f3nKoAs80AapPZiMp/AOzmkvdFO+DewwPOosyPtDhU36qD/uLoipyS/UIxcS
 /ddTnXYTLeyCmWhQuQ7oacLb7ScRtXfPpQaGu7hcNWbb7nsiluPNTOC
X-Developer-Key: i=1579567540@qq.com; a=ed25519;
 pk=sUTWrzlIwT4C7ctjNfVZAzzg0G7QUn2XxRGpYsw4RtM=
X-Endpoint-Received: by B4 Relay for 1579567540@qq.com/20261015 with
 auth_id=1177
X-Original-From: Cunhao Lu <1579567540@qq.com>
Reply-To: 1579567540@qq.com
Content-Transfer-Encoding: 7bit

From: Cunhao Lu <1579567540@qq.com>

The close path cancels restart_work in close_candev() only after freeing
the IRQ, disabling RX offload and stopping the controller. A concurrent
restart can re-enable the controller and interrupts after IRQ teardown,
or requeue timestamp work that accesses registers after runtime suspend
has disabled the controller clocks.

Call close_candev_cancel_restart_sync() at the start of ndo_stop(), while
the resources needed by a running restart are still available. Leave
echo cleanup in close_candev().

A bus-off IRQ can pass the scheduling check before close, then queue
restart work after the early cancellation. The final cancellation after
free_irq() drains that late work so it cannot survive close.

Fixes: ff60bfbaf67f ("can: rockchip_canfd: add driver for Rockchip CAN-FD controller")
Cc: stable@vger.kernel.org
Signed-off-by: Cunhao Lu <1579567540@qq.com>

---
Changes in v7:
- Keep close cancellation separate from restart and open error handling.
---
 drivers/net/can/rockchip/rockchip_canfd-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net/can/rockchip/rockchip_canfd-core.c
index 1cae86973da5..59a79fe057e6 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-core.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-core.c
@@ -758,6 +758,7 @@ static int rkcanfd_stop(struct net_device *ndev)
 {
 	struct rkcanfd_priv *priv = netdev_priv(ndev);
 
+	close_candev_cancel_restart_sync(ndev);
 	netif_stop_queue(ndev);
 
 	rkcanfd_chip_interrupts_disable(priv);

-- 
2.34.1


