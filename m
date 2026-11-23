Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795435232;
	b=dJYX38xU5SRgnqvcqAdbjMejTSn+1Hju4s3j7vEfblhpMIl86fBoPZkSkwZ4Z1/7Dxb5
	 EEAFT7EvReCBBfA37AnSGPpqGidkc2nTdxAB3PbAnjMY9Ug6PVR76+AeOPsrSN23TLDtO
	 6yvIsmYhiHxG0rHjfha/uiHgGumiFRXpguAc8qv8ATzXGbVAYMGn4Y7DsDsyzcXDnCTyR
	 yKUjFe/bd7TfQtGGZ4ol3bckNsYsQoviRtV3pOXKGJjUD7jxr+Wl3N6Zwtm9v5Te3+agE
	 VXyLPDGdh5Xw2Qvp3mmxWvXcsB+j9fpUtcIq5Aj/+QEEmJ/JOwB5IVP9Cgmf3jEC5Lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795435232;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=0sBrDU8q/huhnVATclmc5+SZjK0jzcKit43eI2DzRGg=;
	b=CEa7Tp10yN0xElQxoF5JF/0pJ7ABkB2fCwQT+mrhBcLr8SdwDuVq4g5sQryUP/QTB2Sg
	 S8OpbKW0TZ6SwBxHoefhG5zFvjI8BatbMdemFLMvzMDAPpZyez/SWnVZIBx4oRD7UxF0J
	 ZTq9tcgQgnIjIzf4UtGPLZ625M9mcWkX8DBZKjRXhRCkJHsfo90PCJ3dH19GEtX5DHz3s
	 mZVQnECPL8QgfifTb92jW0WzxdGCEFnyg6ZY5c8U1BZ9tBt1ZN2fjkTrXUrCiFDVEvOFJ
	 mzcdEgRMNQtIjKaqq91WgfL4OI78RFQcK/yhd0+i/DJpOpQPgjN7uBQ8yl1kCSSS7FQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FO9F8mmi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F774606A31A;
	Mon, 23 Nov 2026 12:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FO9F8mmi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E44541F000C0;
	Mon, 23 Nov 2026 12:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795435231;
	bh=0sBrDU8q/huhnVATclmc5+SZjK0jzcKit43eI2DzRGg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FO9F8mmiSAuTt23l1NKTWIZNsS/WR/HctIlqfiYU6abprrh/JYpDgjgPfS7Jrzvuk
	 +qSv3C7hwIy3VkrZGV8iLD0pG0f+3NcDPxUlmc9TNvg28hokdWv8tXhPHL3zd7/0Lp
	 eigDRh4LXltHRpFlOftU8SGX26oE7yN4BDaHFvzYSfNcRXhth/lMQ3z1qpBLlW5lRZ
	 zZhvsz0yVCxJjM6Z8i70fQLDPGrZdPAqfg4/Ru9+7F7j0bPm85WT9EII4XFBop1P8y
	 XzSVMzSla/om7xSWzqSEhU4mSEFI97iG5WnXJAxAvtuX8NMGW7s/Y8Rn2+IBVWPxVc
	 6IcihyfDR92Kw==
Subject: Re: [PATCH can-next v9 11/13] can: gs_usb:
 gs_usb_get_rx_data_length(): introduce new function to consolidate validation
 of host frame
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: mailhol@kernel.org, pfink@christ-es.de, eric@evenchick.com,
 max@schneidersoft.net, wg@grandegger.com, kernel@pengutronix.de,
 linux-can@vger.kernel.org, shuangpeng.kernel@gmail.com,
 stable@vger.kernel.org, vadim.fedorenko@linux.dev, kuba@kernel.org
Date: Mon, 23 Nov 2026 12:00:30 +0000
Message-ID: <179543523052.3131.12523313805754975332@kernel.org>
In-Reply-To: <20261121-gs_usb-fixes-v9-11-db121d488945@pengutronix.de>
References: <20261121-gs_usb-fixes-v9-11-db121d488945@pengutronix.de>
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

- [Low] The commit message understates what the patch does.
- [Low] In gs_usb_get_rx_data_length(), the patch declares minimum_length
  as int but prints it with %u in "short read (actual_length=%u,…

--

can: gs_usb: gs_usb_get_rx_data_length(): introduce new function to consolidate validation of host frame

This commit adds gs_usb_get_rx_data_length(), which consolidates the
validation of the struct gs_host_frame received in the bulk IN URB. It
returns the data length on success or a negative errno on error.
gs_usb_receive_bulk_callback() is converted to use it.

> Add a new function: gs_usb_get_rx_data_length() to consolidate the
> validation of the struct gs_host_frame from the received URB.

[Severity: Low]
Is this description complete? The patch seems to do more than move the
existing checks into one function.

It also adds a second helper, gs_usb_host_frame_header_valid().

An out of range TX echo_id (GS_MAX_TX_URBS <= echo_id <
GS_HOST_FRAME_ECHO_ID_RX) now increments netdev->stats.rx_errors. The old
check in the else branch of gs_usb_receive_bulk_callback() did not update
any counter.

The error print is now behind net_ratelimit(). Its text changes from
"Unexpected out of range echo id %u" to "out of range Echo ID
(echo_id=0x%08x, max_echo_id=0x%08x)".

The echo_id check now runs before the short read check. Before the patch,
a frame that was both short and had a bad echo_id bumped rx_errors and
rx_length_errors and logged "short read". Now it bumps only rx_errors and
logs the echo ID message.

Whether a frame is accepted or dropped does not change.

Could the commit message mention these behavior changes, so the patch is
not read as a pure code move?

> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index aca4f4fdc796a..e4e177aee48b0 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c

[ ... ]

> +static int
>  gs_usb_get_minimum_rx_length(const struct gs_can *dev, const struct gs_host_frame *hf,
> -			     unsigned int *data_length_p)
> +			     int *data_length_p)
>  {
>  	unsigned int minimum_length, data_length = 0;
>  
> @@ -651,6 +673,33 @@ gs_usb_get_minimum_rx_length(const struct gs_can *dev, const struct gs_host_fram
>  	return minimum_length;
>  }
>  
> +static int gs_usb_get_rx_data_length(const struct gs_can *dev,
> +				     const struct gs_host_frame *hf,
> +				     const u32 actual_length)
> +{
> +	struct net_device *netdev = dev->netdev;
> +	struct net_device_stats *stats = &netdev->stats;
> +	int minimum_length, data_length;
> +
> +	if (!gs_usb_host_frame_header_valid(dev, &hf->header))
> +		return -EINVAL;
> +
> +	minimum_length = gs_usb_get_minimum_rx_length(dev, hf, &data_length);
> +	if (actual_length < minimum_length) {
> +		stats->rx_errors++;
> +		stats->rx_length_errors++;
> +
> +		if (net_ratelimit())
> +			netdev_err(netdev,
> +				   "short read (actual_length=%u, minimum_length=%u)\n",
> +				   actual_length, minimum_length);

[Severity: Low]
minimum_length is now declared as int here, but it is still printed with
%u. The check actual_length < minimum_length also compares a u32 with an
int. The removed code in gs_usb_receive_bulk_callback() declared it as
unsigned int.

gs_usb_get_minimum_rx_length() now returns int, but its local
minimum_length is still unsigned int. The other "short read" print, in
gs_usb_get_gs_can(), uses a u32 with the same %u:

gs_usb_get_gs_can() {
	const u32 minimum_length = sizeof(*header);
	...
}

Today the values are small positive sizes, so the print and the
comparison both give correct results. If gs_usb_get_minimum_rx_length()
ever returned a negative errno, the value would print as a huge number.
The unsigned promotion in the comparison would then reject every frame.

This mismatch is still present at the end of the series. Should
minimum_length and the return type of gs_usb_get_minimum_rx_length()
stay unsigned?

> +
> +		return -EINVAL;
> +	}
> +
> +	return data_length;
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261121-gs_usb-fixes-v9-0-db121d488945%40pengutronix.de
