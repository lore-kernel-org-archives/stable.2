Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793654324;
	b=r/RxUOvob64gDQd6axgk08IGBCOcAx0GwVorHCMNb9T+4rm0syzoMLFrAV+jxkhlvO2c
	 Jgs5nZphrhiyECSlHtqiSXpn2sw5wh27d+IXrB8OS3uex+ASOfir5+WO15g6aqpjpUfE1
	 K98xIDSeQcJ1ptuf+OSKdjRZSHMTbdzzMu+yLFuqSvBv9rOnQ5fnuzrlX9pa1/iO+kM4F
	 DE30RiH4hfo7qR7vvxOLw23vZtRSo1NW060YYyc/u9Jz+nN7FE0tGHmIa/toaNkC/i+EP
	 8o2snLSbgyQnK3akEFUmRyWyObp985ERb1xCJIjBTopybUu9hDsqpmxVVSTWnjIylXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793654324;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=bKrFv6QmMCaAXP3HoBxlj9RmsFmDkAblOjvzozsN0hE=;
	b=JfDmzCOber32RF3rbO5bqRJHgm8Z3UNhe8c4xlJBcmtJva/opdN8QZZLSb+WWL/8fy7B
	 oh7DCXeSHTvuAw6B2ALAQsZp0+pGWbPlHqX4UEAESTWAq5vTwc+XA8J4c27W9mnoYFM5N
	 BBBzt/px1KzZMB8R/cCxRyCl0AiRhFUa7YaRogVlfztIJp4JDUiX113RQov1XyFZnQHRZ
	 oK4oQdpruTvQj/A0NGydZpQpShO327/bHCnpyu8u3AyIhE+ZJ9XtbXpRTyEwcC7htuEW6
	 IMGvf6pgSzhe9yFTSU1JFDqFznisrK0t7uRywFubth1gckDCeZMgo93L9vAIOjNvgQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dPBKO07t;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EE1606A327;
	Mon,  2 Nov 2026 21:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dPBKO07t
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 757E71F00A17;
	Mon,  2 Nov 2026 21:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793654323;
	bh=bKrFv6QmMCaAXP3HoBxlj9RmsFmDkAblOjvzozsN0hE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=dPBKO07ttpw6PrCcQK8ueTpTescNw1jwBE8dCA5m3F4t5la6duu0BwGQhD4AvL6p1
	 A9iJIrZyu71xtkV9tUD0JwfCz3EQuRbz1Vdu2uHJ/vqgctEBgeAvX6SX4uX/xqkOqB
	 FeQbuET1/Wo6KEv5Q40qGiBkWdkjt5+fh9wJSn+iDlJQBCowb+tmZ95yNky+krBZHB
	 QPApVb5P6Ib4bXedF7c3sGTVsRuL3JT/8eNQejsSN9YkCLXZR/Wh29FSJijoUFuT9U
	 J5j8TB3RloT0KeI24uN59ennxpsY771wbGHsv001kB2x2DhYSU9WjgrIqcbcNxAzTV
	 l2lczJPEV8b3g==
Subject: Re: [PATCH net v4 3/4] gve: Block invalid ring sizes when device
 options are 0
From: netdev-bot+sashiko@kernel.org
To: hramamurthy@google.com
Cc: netdev@vger.kernel.org, joshwash@google.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 jordanrhee@google.com, willemb@google.com, przemyslaw.kitszel@intel.com,
 nktgrg@google.com, maolson@google.com, jacob.e.keller@intel.com,
 pkaligineedi@google.com, yangchun@google.com, patricion@google.com,
 awogbemila@google.com, stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 treapking@google.com
Date: Mon, 02 Nov 2026 21:18:41 +0000
Message-ID: <179365432199.3131.7124013466514019845@kernel.org>
In-Reply-To: <20261029211634.2232784-4-hramamurthy@google.com>
References: <20261029211634.2232784-4-hramamurthy@google.com>
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

- [Low] In gve_parse_device_option()
  (drivers/net/ethernet/google/gve/gve_adminq.c:194-197), the new…

Pre-existing issues:
- [Low] The MODIFY_RING option is accepted whenever option_length >= 8.

--

gve: Block invalid ring sizes when device options are 0

Older devices report the minimum ring sizes in the MODIFY_RING device
option as 0. This let userspace shrink the rings far enough to hit a NULL
pointer dereference in gve_tx_alloc_rings_dqo(). With this patch,
gve_parse_device_option() sets default_min_ring_size when either reported
minimum is 0, so the driver's default minimums are used instead.

> diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
> index 8b215fca9c1b6..2c848f0c23dc2 100644
> --- a/drivers/net/ethernet/google/gve/gve_adminq.c
> +++ b/drivers/net/ethernet/google/gve/gve_adminq.c
> @@ -191,7 +191,9 @@ void gve_parse_device_option(struct gve_priv *priv,
>  		*dev_op_modify_ring = (void *)(option + 1);
>  
>  		/* device has not provided min ring size */
> -		if (option_length == GVE_DEVICE_OPTION_NO_MIN_RING_SIZE)
> +		if (option_length == GVE_DEVICE_OPTION_NO_MIN_RING_SIZE ||
> +		    be16_to_cpu((*dev_op_modify_ring)->min_rx_ring_size) == 0 ||
> +		    be16_to_cpu((*dev_op_modify_ring)->min_tx_ring_size) == 0)
>  			priv->device_info.default_min_ring_size = true;

[Severity: Low]
Should the fallback be done per direction here? One shared flag is set
when either min_rx_ring_size or min_tx_ring_size is 0. After that,
gve_enable_supported_features() overwrites both minimums:

drivers/net/ethernet/google/gve/gve_adminq.c:gve_enable_supported_features() {
    ...
		if (info->default_min_ring_size) {
			/* If device hasn't provided minimums, use default minimums */
			info->min_tx_ring_size = GVE_DEFAULT_MIN_TX_RING_SIZE;
			info->min_rx_ring_size = GVE_DEFAULT_MIN_RX_RING_SIZE;
		} else {
    ...
}

Say a device reports min_tx=1024 and min_rx=0. gve_set_desc_cnt() then
sets the TX minimum to 256, and gve_validate_req_ring_size() would accept
a TX ring size below the device's advertised minimum.

Now say the non-zero minimum is below the default, for example min_tx=64.
In that case, sizes the device supports are now rejected. Before this
patch, the else branch kept the non-zero value.

struct gve_device_option_modify_ring has a separate field for each
minimum. Would a per-field fallback be closer to the intent? For example:

	info->min_tx_ring_size =
		be16_to_cpu(dev_op_modify_ring->min_tx_ring_size) ?:
		GVE_DEFAULT_MIN_TX_RING_SIZE;

Both values would then only be overridden for the legacy 8-byte option,
which has neither field.

It's not clear that any firmware reports only one minimum as 0. The
commit message says older devices report both minimums as 0.

[Severity: Low]
This is a pre-existing issue, but can these reads go past the end of the
option payload? The length check at the top of this case only requires
the legacy 8-byte size:

	case GVE_DEV_OPT_ID_MODIFY_RING:
		if (option_length < GVE_DEVICE_OPTION_NO_MIN_RING_SIZE ||

min_rx_ring_size sits at payload offset 8 and min_tx_ring_size at offset
10. An option_length of 9, 10 or 11 passes this check. The new condition
then reads one or both fields partly or wholly beyond the declared option
length. That is either the next option's header, or memory past the
descriptor's total_length if this is the last option.
gve_get_next_option() only checks the option's declared length.

The else branch of gve_enable_supported_features() already over-reads in
the same way. The new check adds another read at parse time, and that
read runs even when GVE_SUP_MODIFY_RING_MASK isn't set.

Would it help to require option_length >= sizeof(**dev_op_modify_ring)
before reading either minimum? Triggering this needs a malformed device
response.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261029211634.2232784-1-hramamurthy%40google.com
