Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795435228;
	b=EuhDKsIzYc8wExqzNzuV+OVVi/2ZtDlhyCGoZoaYYvtp+oe4FHVY0unSXOEGqega8Brj
	 cQUcPd7QryynEcavH8o7Cp8M+Sraq3AsfjOJXCNVVQISbx2au7NPjj55tLqyA2Qw8tYdR
	 G8eQLxSug1w8aw3wDJWu26EC6ogvpqnAwKlF1+U0BPWjqH5bmjP5v+pj/GPAa9u9Q6xI4
	 r0vO1uIqHScFaHvrXW5WNjriPiBJojQVHEz2z3rlcSL9k9kGsb8+zGQ2j2Y5uTK5OZhL7
	 azpHvVdqylCN5OaIohC8hJ2XuLpe+HzyzKUrc2f9hRCmUdMEIKKweSz2KOh3wp5kHIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795435228;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=lve/LsU61OLZYEoEy459aqh2XEJegA1ZT4bZw9869gE=;
	b=EwNQT6XDXW6Krra6XKLB/RSaE/Y0CkKQiTyk92y7kIRBwlaaaAe+RIGoj5HL71Gdr/jB
	 nal+y5bq4/a8KaaB5pJau4ZiV1I31ZA2FodN+ejxIJXVHOtvoPNONPskx/8YzqxQMYUj5
	 VKaWzK62gtwFpeC9OgBW/ZYWFMMs1ExfyII7fizOeYZYQ71gmRmCqnbwNT55p1EezZN0t
	 nYirpSrEWdjDcnoPRBWbvb2oy0HfF0V+gDAYCwVpl/i6t6/65uXTsMjo2umw80NbVn8Lh
	 Twr4KlUF9li8HdQ7kk569yYhFZDE9nS/4W1ShaigkOvzepwzYS8WrzETBvvRHwu3dpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LzkrFolF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BE2606A31A;
	Mon, 23 Nov 2026 12:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LzkrFolF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF071F000CF;
	Mon, 23 Nov 2026 12:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795435228;
	bh=lve/LsU61OLZYEoEy459aqh2XEJegA1ZT4bZw9869gE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=LzkrFolFmGj6UpKsFXm+iHVURLxMvpHT3aEFx6QkzBNiEQQNZC2yXfo7vYGusXBrX
	 OFFnaMh7VSAMpzsc2GDYxq+FQCMETvHoWS91q9gydIAjSi2JQDC34XiIhnbPw50k8+
	 ZYs8C/xhDeF6pr/PMaQ1CVXk5jOQ7QDvgx5I4K8qYZUHfdt2Dxr4oShvUAgDOlq5G4
	 0ozx0vQ8UaXXLBsS8oynwCHU8NgFepLuCnsc5af1wVTGrUGPaVaCncDcKe356Z7mwE
	 6A2mkiSFAsICMKHwTNU5/Z/KDnrwq4to0ssuFPZIHlUBmU1p4k4RVvuhUtllXAJ1Lm
	 7VgkO+hYfKcmw==
Subject: Re: [PATCH can-next v9 09/13] can: gs_usb: gs_usb_get_gs_can():
 introduce new function to consolidate validation of struct gs_can
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: mailhol@kernel.org, pfink@christ-es.de, eric@evenchick.com,
 max@schneidersoft.net, wg@grandegger.com, kernel@pengutronix.de,
 linux-can@vger.kernel.org, shuangpeng.kernel@gmail.com,
 stable@vger.kernel.org, vadim.fedorenko@linux.dev, kuba@kernel.org
Date: Mon, 23 Nov 2026 12:00:27 +0000
Message-ID: <179543522703.3131.14984060742934777672@kernel.org>
In-Reply-To: <20261121-gs_usb-fixes-v9-9-db121d488945@pengutronix.de>
References: <20261121-gs_usb-fixes-v9-9-db121d488945@pengutronix.de>
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

- [Low] The commit message presents this patch as a pure refactor ("To
  improve code readability and structure consolidate the decoding and…

--

can: gs_usb: gs_usb_get_gs_can(): introduce new function to consolidate validation of struct gs_can

This patch adds a new helper, gs_usb_get_gs_can(). It takes over three
checks from gs_usb_receive_bulk_callback(): the short read check on the
RX header, the channel id range check, and the netdev present/running
checks.

The helper returns the struct gs_can pointer or NULL. It also sets a
fatal flag, which the caller uses to decide whether to detach the device
or resubmit the URB.

> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index f49179cbd7876..c392cf65d8a6d 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c

[ ... ]

> @@ -651,6 +651,43 @@ gs_usb_get_minimum_rx_length(const struct gs_can *dev, const struct gs_host_fram
>  	return minimum_length;
>  }
>  
> +static struct gs_can *
> +gs_usb_get_gs_can(const struct gs_usb *parent,
> +		  const struct gs_host_frame_header *header, u32 actual_length,
> +		  bool *fatal)
> +{

[ ... ]

> +	struct gs_can *dev = parent->canch[header->channel];
> +	const struct net_device *netdev = dev->netdev;
> +
> +	if (!netif_device_present(netdev)) {
> +		*fatal = true;
> +
> +		return NULL;
> +	}

[Severity: Low]
Is this change in behavior intended? The commit message presents the
patch as a refactor:

  To improve code readability and structure consolidate the decoding and
  validation of the struct gs_can from the host frame into a the new
  function gs_usb_get_gs_can().

However, the not-present case now behaves differently. Before the patch,
gs_usb_receive_bulk_callback() returned without resubmitting the URB and
did not touch the other channels:

	if (!netif_device_present(netdev))
		return;

Now that *fatal is set here, the caller jumps to device_detach, which
detaches every channel of the parent:

device_detach:
		for (rc = 0; rc < parent->channel_cnt; rc++) {
			if (parent->canch[rc])
				netif_device_detach(parent->canch[rc]->netdev);
		}

One channel can be detached by itself. For example, gs_can_start_xmit()
and gs_can_open() call netif_device_detach() on only their own netdev
when they get -ENODEV. Before this patch the sibling channels stayed
attached in that case. With this patch, the next RX frame carrying the
detached channel's index also detaches all the siblings.

This is probably harmless in practice. -ENODEV means the shared USB
device is gone, so the siblings would fail anyway, and in both versions
the URB is not resubmitted.

The commit message does say "If fatal is true, detach the device", but
it doesn't mention that the not-present case used to be handled
differently. This behavior is still the same later in the series:
gs_usb_get_gs_can() still sets *fatal for !netif_device_present() in
"can: gs_usb: gs_usb_host_frame_header_valid(): drop CAN frames with
invalid DLC".

Could the commit message mention and justify this change? Otherwise,
should the old behavior (neither resubmit nor detach) be kept for this
case?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261121-gs_usb-fixes-v9-0-db121d488945%40pengutronix.de
