Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795435225;
	b=EBWhmqU7ZBBv5N2ZvccjIK/tRhWMNe07QH6oLQ+8E3PyBDcN8uGIONBmYxcmvvNx1VRr
	 YMXebO7MxhQKHHGAF0UTIUOHj0cbosSEEIO2cMKt+vJCaS8I/bFGRuvlqlMs3qDbMEtdz
	 EbIhIZb/hln2Nplia0uWLyHnx7dpWhLGgeR3qbwtdTONiovvKAkOZKnOE+yrZBmZ+LhGV
	 +0yCNQBVbVhwAWmEbgg27E2J5aVbI9bwK1vI9yPC/sYQ/mUi0NrSfqehgmhhvFXTmkFs3
	 cdbg+j6MkohLPmcpu8i80/rSC1u13Edke2G6U1EZfXlJ7RyCOM/xklIIopeVJRriOpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795435225;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=qA23ySODgaVKJP93vEWQQ4jUPumUD8GxBNdqXQT5etw=;
	b=Tp57f+wcyJGxbEiNgv2c3vYntodMViS57drPufcwqdwFUoftxByuJvqraJDMsI50Yml7
	 7NKLdnRGc447y9N0d5HFL7vnq91Fy7pv0Fat5tv5iROpESaRmV/oVLt2g7QxGBdvWO3Ro
	 VZzYfmXl6skTbYl6fpIE72O9Cn40pl94p7QAX5imEoPlh6OI2v2UsGzGMKqrxShFqPQHG
	 sb4zd8lfLxZAdSFZaIuib8MbNTn4VSvM8/tNWNKI0Yz+Z2cFivN8Euv8YucPNIOCWUNQY
	 jLvO+onQNcNxud27Tui8IszA+xtz+cqFAkRaruS2U8/IxRWJkm4oBPSLuHmK36s8j8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Nuk//swz";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71D4606A31E;
	Mon, 23 Nov 2026 12:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nuk//swz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E1D1F000C4;
	Mon, 23 Nov 2026 12:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795435225;
	bh=qA23ySODgaVKJP93vEWQQ4jUPumUD8GxBNdqXQT5etw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Nuk//swzo54/MfjPeoezLcoaIp16sYUfs/ZbhktCfcQc7UIEMOPde0oPfAsL3XXb8
	 I9qscnc25VBu5hFkC21nQ+Rq/+bH0O4oQGiB+OkOP3T5AnQrYBxzmK4/IbknsjIOEx
	 2rg+dm2Rn+jotihpwo1czPw898CnGCX5RLrKV1Zz86PltzX4LBRoE5mO1ZPb0Yxq2H
	 Ft7L56E8ajPvfUTD7ipNXwLrMOxF1p8/bH6exTgZEulLI29wUAs3E+ke2IXr2t/qBI
	 +g3sO8Rr2Zx/vmulATyF8JpOnrg68tikMHseXDmhiq2BZsC6/uyY3GyR1LOZKjdRK6
	 EElT+lKDwzutg==
Subject:
 Re: [PATCH can-next v9 06/13] can: gs_usb: add support for context analysis
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: mailhol@kernel.org, pfink@christ-es.de, eric@evenchick.com,
 max@schneidersoft.net, wg@grandegger.com, kernel@pengutronix.de,
 linux-can@vger.kernel.org, shuangpeng.kernel@gmail.com,
 stable@vger.kernel.org, vadim.fedorenko@linux.dev, kuba@kernel.org
Date: Mon, 23 Nov 2026 12:00:24 +0000
Message-ID: <179543522421.3131.1020401306783191994@kernel.org>
In-Reply-To: <20261121-gs_usb-fixes-v9-6-db121d488945@pengutronix.de>
References: <20261121-gs_usb-fixes-v9-6-db121d488945@pengutronix.de>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message does not mention one of the changes.

--

can: gs_usb: add support for context analysis

This commit turns on context analysis for gs_usb.o. It marks the
cyclecounter, timecounter and timestamp_initial fields in struct gs_usb
as guarded by tc_lock. It also adds or fixes the __must_hold and
__must_not_hold annotations on the low level timestamp read helpers.

> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index 30bcb734c5df8..ab82dc07f3f50 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c

[ ... ]

> @@ -1037,7 +1040,7 @@ static int gs_can_open(struct net_device *netdev)
>  		if (parent->flags & GS_USB_PARENT_FLAGS_HW_TIMESTAMP) {
>  			rc = gs_usb_timestamp_start(parent);
>  			if (rc) {
> -				if (rc == -ENODEV) {
> +				if (rc == -ENODEV)
>  					netif_device_detach(netdev);
>  
>  				goto out_can_rx_offload_disable;

[Severity: Medium]
This hunk in gs_can_open() is a build fix, but the commit message
doesn't mention it. Should it be part of the previous patch instead?

The message only describes annotation changes:

  Tag the hardware timestamp counter infrastructure in struct gs_usb as
  guarded by the tc_lock. Fix the existing annotation for
  gs_usb_timestamp_read(), add context analysis annotation regarding the
  tc_lock to the low level timestamp reading functions.

At the parent commit, "can: gs_usb: fix hardware timestamp state for
mixed channels", gs_can_open() has an opening brace that is never
closed:

	if (!parent->active_channels) {
		if (parent->flags & GS_USB_PARENT_FLAGS_HW_TIMESTAMP) {
			rc = gs_usb_timestamp_start(parent);
			if (rc) {
				if (rc == -ENODEV) {
					netif_device_detach(netdev);

				goto out_can_rx_offload_disable;
			}
		}

Because of that brace, gs_usb.c doesn't compile at that commit. A
bisect that lands there will hit the build error.

That parent commit has Fixes: 5886e4d5ecec and Cc: stable. Its message
also says:

  To simplify backporting, support for context analysis is added in a later
  patch.

This patch has no Fixes: or stable tag. If the parent is backported on
its own, as its message suggests, would the stable gs_usb build break?

Could the brace fix go into "can: gs_usb: fix hardware timestamp state
for mixed channels"? If it stays here, could the commit message at least
say that it fixes a build error from the previous patch?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261121-gs_usb-fixes-v9-0-db121d488945%40pengutronix.de
