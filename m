Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795512663;
	b=QyuNWI8M4wglvYv88f1ceMJlfGYdQ7NVLoh3QrP8jWOPkOqWvifUnVkcZZ+xrOi0jd7B
	 BKDkr42gSGhqoKIccVd1yO7tCTp5a4IE5g8wG0PmJgUV10I8c2APzeZFVpdK+sMjqnZ6F
	 zCLmZCI034iHhvX4USgjkAVnFxrWelXHJcZLuQ+o3k3kq0jJ8bfznmdARFeYRAr601gF0
	 2e66xMj4sLA8xiVGbTpC8f3nfJBuhyHn98qrWiHK05bRTh40HVQSc6/Fdk4HIDDh3BL+Z
	 6M5SQuUjza29dI8PbszcPA/lEcKCEmjp2NVf3hCyzRdf5KW5KfVf/od33s1DrSOZa3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795512663;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=wxs9sFPe8ncOvSyteUdGMIPB6LVRyBPAvxC8TMhY7s4=;
	b=Z4nV4GhiiOBaEXl/BLKWBb8YVYnna+zZ8VCmsAi3wBO6fuv5iTbjkGjWq7JRG3rjfZMJ
	 Xbx4vyTsnORaeT+u15lhKw9YTttZZb4bVTBYd+u/bqEgfUvsoUKz0B79gQrV57/3a4TLF
	 hwyizGhlIU5iDQ9P4iXnZr315MIsYsa5E5NOMnyOqhBNYHin3/IDL430jc4SN1T7+eg1c
	 JT+j8C66T4CdrDotB1PVLGUvpC0jFXOx3q5aFCqMD9ZvNFQ3NK3AkA/sPQ1vb7wxlS4ap
	 o4IU5Wmtp1cGiSPzSTDIp4t5PlCIn1nLeyOizatQwWdFaW7GMbYDTmzKQKsxGpNeQ9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jhaokije;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E93606A334;
	Tue, 24 Nov 2026 09:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jhaokije
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EEDD1F000EE;
	Tue, 24 Nov 2026 09:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795512662;
	bh=wxs9sFPe8ncOvSyteUdGMIPB6LVRyBPAvxC8TMhY7s4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jhaokijeq1xNdVgxYVnXDgQfYGo4o+EIxtcclOzeR9ss82tSh9BCDVDugRYlSsI4S
	 s+EqARG2hpDLprV/XdM6n+6weXjZhzgyuidWkrZATyHLVyZl2+Tf3FvRbL5GXXFtLg
	 WAkCgVowS4OL9Lx13mJV8aQTW7XQtaRITdtjs9dxhKJEyIuj6u+mA0dQSJs7VJIYwS
	 nxZdRFTYWW2/OSic04FwcbadEU9+XXH1BK5WmsCbzUy0Bpqyqso46rGa/hunaoNhRh
	 Qikr5qruKCKnxZ9MK1Elhoi9XYHbKLzDwYq222SCH6OcDupoTF+W7yeX/AYimsEj2I
	 0S3w+KrVWpYJA==
Subject: Re: [PATCH can-next v10 11/14] can: gs_usb:
 gs_usb_get_rx_data_length(): new function to consolidate validation of host
 frame
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: mailhol@kernel.org, pfink@christ-es.de, eric@evenchick.com,
 max@schneidersoft.net, wg@grandegger.com, kernel@pengutronix.de,
 linux-can@vger.kernel.org, stable@vger.kernel.org, kuba@kernel.org
Date: Tue, 24 Nov 2026 09:31:01 +0000
Message-ID: <179551266159.3131.6265981861655766301@kernel.org>
In-Reply-To: <20261122-gs_usb-fixes-v10-11-7c165c35d04a@pengutronix.de>
References: <20261122-gs_usb-fixes-v10-11-7c165c35d04a@pengutronix.de>
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

- [Low] The commit message says the patch only adds
  gs_usb_get_rx_data_length() to consolidate host-frame validation, but…
- [Low] After this patch, the driver's two paths for rejecting a bad TX-
  completion echo ID handle stats and logging differently.
- [Low] The patch makes gs_usb_get_minimum_rx_length() return `int` and
  take an `int *data_length_p`, and gs_usb_get_rx_data_length() declares…

--

can: gs_usb: gs_usb_get_rx_data_length(): new function to consolidate validation of host frame

This patch adds gs_usb_get_rx_data_length() and
gs_usb_host_frame_header_valid(). They take the minimum length check and
the out of range echo ID check out of gs_usb_receive_bulk_callback(). The
new helper returns the data length of the host frame, or a negative errno.

> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index df5ea6cb0cf2a..4aa674c743f67 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c
> @@ -620,9 +620,31 @@ gs_usb_get_echo_skb(struct gs_can *dev, struct sk_buff *skb,
>  	return len;
>  }
>  
> -static unsigned int
> +static bool gs_usb_host_frame_header_valid(const struct gs_can *dev,
> +					   const struct gs_host_frame_header *header)
> +{
> +	struct net_device *netdev = dev->netdev;
> +	struct net_device_stats *stats = &netdev->stats;
> +	bool valid = true;
> +
> +	if (header->echo_id >= GS_MAX_TX_URBS &&
> +	    header->echo_id < GS_HOST_FRAME_ECHO_ID_RX) {
> +		stats->rx_errors++;
> +
> +		if (net_ratelimit())
> +			netdev_err(netdev,
> +				   "out of range Echo ID (echo_id=0x%08x, max_echo_id=0x%08x)\n",
> +				   header->echo_id, GS_MAX_TX_URBS - 1);
> +
> +		valid = false;
> +	}

[Severity: Low]
The commit message only talks about adding gs_usb_get_rx_data_length() to
consolidate validation. This hunk also brings in some visible changes that
the message doesn't mention:

  - a second helper, gs_usb_host_frame_header_valid(), is added
  - an out of range TX echo ID now increments netdev->stats.rx_errors;
    before, no counter changed
  - the message is now rate limited with net_ratelimit(); before, it was
    an unconditional netdev_err()
  - the message text changes from "Unexpected out of range echo id %u"
    (decimal) to "out of range Echo ID (echo_id=0x%08x,
    max_echo_id=0x%08x)" (hex)
  - in gs_usb_get_rx_data_length(), the echo ID range check now runs
    before the minimum length check; before, it ran after it, in the else
    branch of gs_usb_receive_bulk_callback()

None of these look harmful. Still, rx_errors in ip -s link and the log
text both change for the same device input.

Could the commit message describe these changes, so it doesn't read as a
purely mechanical consolidation?

> +
> +	return valid;
> +}
> +
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
minimum_length is now a signed int. It is still compared against the u32
actual_length and printed with %u.

gs_usb_get_minimum_rx_length() above now returns int and fills an int
pointer. Internally it still computes unsigned int minimum_length and
data_length from sizeof() and struct_size().

The value is always a small positive number today, so nothing misbehaves.
But what happens if this helper ever returns a negative errno, as the int
return type suggests it could? The comparison actual_length <
minimum_length would turn it into a huge unsigned value, the check would
fail, and the error path would be taken for every frame.

Would it be cleaner to keep minimum_length as unsigned int or u32 here, or
to print it with %d?

> +
> +		return -EINVAL;
> +	}

[ ... ]

> @@ -780,13 +820,6 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
>  
>  		gs_usb_rx_offload(dev, skb, hf);
>  	} else { /* echo_id == hf->echo_id */
> -		if (hf->echo_id >= GS_MAX_TX_URBS) {
> -			netdev_err(netdev,
> -				   "Unexpected out of range echo id %u\n",
> -				   hf->echo_id);
> -			goto resubmit_urb;
> -		}
> -
>  		txc = gs_get_tx_context(dev, hf->echo_id);
>  
>  		/* bad devices send bad echo_ids. */

[Severity: Low]
With the out of range check moved into gs_usb_host_frame_header_valid(),
the two ways of rejecting a bad TX echo ID now behave differently.

An out of range echo ID increments rx_errors, is rate limited and is
printed in hex. An echo ID that is in range but unused still ends up here
in gs_usb_receive_bulk_callback():

		if (!txc) {
			netdev_err(netdev,
				   "Unexpected unused echo id %u\n",
				   hf->echo_id);
			goto resubmit_urb;
		}

This path changes no counter and isn't rate limited.

Before this patch the two paths behaved the same. Should the unused echo
ID case also bump rx_errors and use net_ratelimit()? Otherwise the
rx_errors value depends on which kind of bad echo ID the device sent.

Also, gs_get_tx_context() keeps its own range check:

	if (id < GS_MAX_TX_URBS) {

This duplicates the check in gs_usb_host_frame_header_valid(). Is it meant
to stay, given that the goal is to keep host frame validation in one
place?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261122-gs_usb-fixes-v10-0-7c165c35d04a%40pengutronix.de
