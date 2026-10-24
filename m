Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792814332;
	b=NgKlZncJ9lsknhhVARbBBBON5a9LVWpXN82OdUbCPpXs4hawjgPKxazTS0eSAmdj+hyP
	 CICKvrqgDFp5ZoWTS6Q+ToucM7UOcHVkJ5PZ2XeO2zNtWg7fWMIBkdtEbYaArlq1Onokh
	 FUbs0jVEMGm5SRaDeQrPgmNUXHZtH+BGInbdGCyDWrqBYMhs4h7Ou+I+PHSpGavQDYpb3
	 yFV5zpoLhn0T3HhZnNWbiaB2I0hnLjD4yNpgoswJKvmNxmCunmaIWbOvrPcKv9z3aDsB+
	 yB7B8RHpuG+I9IlS7Eqlansxl2JIUGSlccJQIEsRv5zQNCAq5w1YglWjF2Xom8wDRjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792814332;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=/TAhzN/YLBIG6aPWEjTy99TQtInx/DdY7lqJKqusaWw=;
	b=2L8P5hMD4nPHlZlZITdxRLlYWOQ4Zyx4JleNb90GgN7M4CvtxN9qPMd1m9Z0z4TXfnAs
	 jLAwQ9MqV5RLE39vNGL2FQq2s9RV4BoGiEuaSGhg3P+BLJ0iCpnh3Tz3rS1fqB3yHUwiM
	 I4A5sXXkYnci5jURthhZw+TQWUffBo+sq1upq2fWabjAfGYEPz7hfusatxDsrwpxPq8qe
	 +6Yc25xKGu8i7oSfP+j5czmMh7tBtu+YL/OS/IYbvItCq/2YOnRUNDmiWu5BanRgrtyCG
	 Z6tpWMEsOk3x6XPQnVcvyoLTV6+SS+7+x7qH1Ryui5cVtnJRgF2gYnxL7xgwt0cS4aQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cWJG+GPV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78351606A31A;
	Sat, 24 Oct 2026 03:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cWJG+GPV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 907F01F01825;
	Sat, 24 Oct 2026 03:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792814332;
	bh=/TAhzN/YLBIG6aPWEjTy99TQtInx/DdY7lqJKqusaWw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=cWJG+GPVyGHbH0lXVME6Goec0UjUwPgdXlk6IH3p+sdb20WwRwtEJcLdVB57J3CBI
	 xarv7kmZ0/NHLBMVrwxjM8fq8MUtWSJZGQ+E2v46EjHmY7APFx3YTQ64HsGkr66/df
	 xQzUr5LiGhCT8Z/PyDs4/HaM/FwwPpi7mK+rcZiuwh8ZjQbnBPAuTlTvjT/mVa7pQA
	 Io7CjapFF4zw09eZFuigPCnJjGvMU/JcnDPjZUCtfLGqUbttaNj+9EZbDSSkvfYR/A
	 dC6OBZ+BbMWnDOxfuj2PrbQDNva7b5FXu0UUQcCdQNjy2itBDqRQsVx+G57qouwWoy
	 mb93q9RWVyL1w==
Subject: Re: [PATCH v6 03/13] can: peak_usb: sort ctrlmode_supported flags
From: netdev-bot+sashiko@kernel.org
To: s.grosjean@peak-system.fr
Cc: mkl@pengutronix.de, mailhol@kernel.org, wg@grandegger.com,
 error27@gmail.com, lukas.magel@posteo.net, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, kuba@kernel.org
Date: Sat, 24 Oct 2026 03:58:51 +0000
Message-ID: <179281433115.3130.15136732593858786026@kernel.org>
In-Reply-To:
 <20261022-canfd_check_channel_idx-v6-3-197704231551@peak-system.fr>
References:
 <20261022-canfd_check_channel_idx-v6-3-197704231551@peak-system.fr>
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

- [Low] The commit message says the patch orders the CAN_CTRLMODE_* flags
  in ctrlmode_supported by numerical value.

--

can: peak_usb: sort ctrlmode_supported flags

This commit reorders the CAN_CTRLMODE_* flags in the static
ctrlmode_supported initializers of the peak_usb adapters so that they
follow their numerical values. It is described as a cosmetic change with
no behavior change.

> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
> index 785224e00c4e9..169c00d93463c 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
> @@ -1016,7 +1016,8 @@ const struct peak_usb_adapter pcan_usb = {
>  	.name = "PCAN-USB",
>  	.device_id = PCAN_USB_PRODUCT_ID,
>  	.ctrl_count = 1,
> -	.ctrlmode_supported = CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_LISTENONLY |
> +	.ctrlmode_supported = CAN_CTRLMODE_LISTENONLY |
> +			      CAN_CTRLMODE_3_SAMPLES |
>  			      CAN_CTRLMODE_CC_LEN8_DLC,

[Severity: Low]
This isn't a bug, but the runtime ctrlmode_supported update in
pcan_usb_init() in the same file was not reordered:

drivers/net/can/usb/peak_usb/pcan_usb.c:pcan_usb_init() {
    ...
	if (dev->device_rev >= 41) {
		struct can_priv *priv = netdev_priv(dev->netdev);

		priv->ctrlmode_supported |= CAN_CTRLMODE_ONE_SHOT |
					    CAN_CTRLMODE_LOOPBACK;
    ...
}

CAN_CTRLMODE_LOOPBACK is 0x01 and CAN_CTRLMODE_ONE_SHOT is 0x08, so by
the ordering described in the commit message LOOPBACK would come first.

The commit message says:

  "Order the CAN_CTRLMODE_* flags in ctrlmode_supported according to
  their numerical values."

It doesn't limit this to the static initializers. Should this line be
reordered too, for consistency? No later patch in the series appears to
change it.

As the commit message says, the resulting bitmask is identical either
way.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261022-canfd_check_channel_idx-v6-0-197704231551%40peak-system.fr
