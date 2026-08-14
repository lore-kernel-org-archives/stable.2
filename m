Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9239202C48;
	Fri, 14 Aug 2026 12:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786710271; cv=none; b=nmPon2AQesh76GFCaMJiDy4S76Wm31xd9QWrewgKOVtqWTVLkZA3QPtLpXrFszKk0ee3zBlDEFsLDsBuowAWDMaXS1hYCDItGICAUum/y8y/BtJ2Zm3yOR9VDkQSoPPKX8coJZpxi6/foxfV8gubVj3SqSLyvYPlFme423gH5ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786710271; c=relaxed/simple;
	bh=GmlDGSpTrMNkZjAr9KG6HERPUbx+pvkygZBW/WLmyXk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=bdpd5eJa5zKuHPIr5gI0EC3LDNu2eWzcASoipZNI4IgOVBt94trlNsS7zq3vq7Zz/1HW1JDPP49G8QSmlr5+UVZpAUo1LpnpXIWkJRTAuuutYyvOgg3a00D7N3Hiku+Fj84/8Bb+XgPvyjezsayKAkSEJt74Oiqg3chQHy6oiQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dAnBnQEM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dAnBnQEM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8FE61F000E9;
	Fri, 14 Aug 2026 12:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786710269;
	bh=96dYezBU3PumHTy+D61UncG+Mi1IzHUe48AfS/L4Ehs=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=dAnBnQEM3bSWZikUIIGDzltuSCeqh7Vyxtg5Av57teZCz7U8QGCfaRw47S6t0AiaF
	 8b1z823opZ5xG+RCZ9S7vOR2SCsHJH001W2Dx2GMySoE7fWx7liTx2VEE1Lu1hcBXZ
	 5PY5T9xWy9E7FH/q7ZVEDiRyamqecD4rFQZu1VKSBSEZcxAYH3HZFEnKdhpwtFjYYe
	 475MUioZ6b5FZOCefoyRWxbaWBC6sfQubTC1I8iXQnFbNHEz25XhrlF6TzLoqJnfrg
	 twzldmpmTeZKFrS2OR92O3gD/FepKei7y9kTLgVvrO+hgcvDTwgd0MwIcMrgDQwizJ
	 ppZULau1UajJg==
Date: Fri, 14 Aug 2026 14:24:26 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Ibrahim Hashimov <security@auditcode.ai>
cc: ping.cheng@wacom.com, jason.gerecke@wacom.com, bentiss@kernel.org, 
    dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] HID: wacom: validate report length in
 wacom_intuos_pro2_bt_irq
In-Reply-To: <20260713093414.94337-1-security@auditcode.ai>
Message-ID: <36s07n6o-3n6p-p438-6qq7-921r98171q40@xreary.bet>
References: <20260713075110.92469-1-security@auditcode.ai> <20260713093414.94337-1-security@auditcode.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Ping, Jason, could you please Ack this one? Looks good to me, but I always 
prefer to have an Ack from one of you on the Wacom HID driver.

Thanks,

-- 
Jiri Kosina
SUSE Labs

On Mon, 13 Jul 2026, Ibrahim Hashimov wrote:

> wacom_intuos_pro2_bt_irq() receives the wire report length in `len`
> but never consults it before parsing. After the report-id gate it
> unconditionally calls wacom_intuos_pro2_bt_pen() and then, selected by
> features.type, a fixed chain of sub-parsers, none of which receive
> `len`:
> 
> 	wacom_intuos_pro2_bt_pen(wacom);
> 	if (type == INTUOSP2_BT || type == INTUOSP2S_BT) {
> 		wacom_intuos_pro2_bt_touch(wacom);
> 		wacom_intuos_pro2_bt_pad(wacom);
> 		wacom_intuos_pro2_bt_battery(wacom);
> 	} else {
> 		wacom_intuos_gen3_bt_pad(wacom);
> 		wacom_intuos_gen3_bt_battery(wacom);
> 	}
> 
> Each sub-parser dereferences wacom->data at fixed offsets. The furthest
> byte touched on each branch is:
> 
>   INTUOSP2_BT / INTUOSP2S_BT: wacom_intuos_pro2_bt_pad() reads data[285]
> 	(the touchring byte), so the report must be at least 286 bytes;
>   INTUOSHT3_BT ("gen3"): wacom_intuos_gen3_bt_battery() reads data[45],
> 	so the report must be at least 46 bytes.
> 
> features.type is selected from the VID/PID id_table entry and
> wacom_setup_device_quirks() force-registers the pen/pad/touch inputs
> for that type independent of the report descriptor, so a malicious or
> malfunctioning paired/spoofed Bluetooth peripheral can advertise that
> VID/PID and send an undersized report that still satisfies the
> data[0] == 0x80/0x81 gate. The driver then reads past the received
> report and forwards the bytes to userspace via evdev (MSC_SERIAL /
> ABS_MISC / ABS_WHEEL on the pen and pad input nodes), an out-of-bounds
> read with a concrete userspace read-back channel, and a true
> out-of-bounds read on transports whose backing buffer is sized to the
> (small) report descriptor rather than a fixed-size staging buffer.
> 
> This is the same class of bug commit 2f1763f62909 ("HID: wacom: fix
> out-of-bounds read in wacom_intuos_bt_irq") already hardened in the
> sibling wacom_intuos_bt_irq(), which guards each report id against its
> minimum length before parsing.
> 
> Guard wacom_intuos_pro2_bt_irq() the same way: before parsing, reject
> reports shorter than the furthest offset the selected branch actually
> dereferences, warn, and bail out. Because the whole pen/touch/pad/
> battery chain runs unconditionally per branch, a single up-front check
> against the maximum offset (286 bytes for INTUOSP2_BT/INTUOSP2S_BT,
> 46 bytes for the gen3 branch) bounds every sub-parser. Returning 0 on
> a short report also skips those calls for the same malformed report,
> which is the safe, conservative behavior.
> 
> Fixes: 4922cd26f03c ("HID: wacom: Support 2nd-gen Intuos Pro's Bluetooth classic interface")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ibrahim Hashimov <security@auditcode.ai>
> Assisted-by: AuditCode-AI:2026.07
> ---
> v2: the v1 check (len < 109 / len < 43) only bounded
>     wacom_intuos_pro2_bt_pen(). As sashiko-bot pointed out, the
>     unconditional touch/pad/battery calls read much further --
>     wacom_intuos_pro2_bt_pad() up to data[285] and
>     wacom_intuos_gen3_bt_battery() up to data[45] -- so a report in the
>     gap (109..285 / 43..45) passed the guard yet still over-read. Raise
>     the minimums to the furthest offset each branch dereferences
>     (286 / 46) so the guard actually bounds the whole call chain.
> 
>  drivers/hid/wacom_wac.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index da1f0ea85625..89a191cf1924 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -1548,6 +1548,19 @@ static int wacom_intuos_pro2_bt_irq(struct wacom_wac *wacom, size_t len)
>  		return 0;
>  	}
>  
> +	if (wacom->features.type == INTUOSP2_BT ||
> +	    wacom->features.type == INTUOSP2S_BT) {
> +		if (len < 286) {
> +			dev_warn(wacom->pen_input->dev.parent,
> +				 "Pro2 BT report too short: %zu bytes\n", len);
> +			return 0;
> +		}
> +	} else if (len < 46) {
> +		dev_warn(wacom->pen_input->dev.parent,
> +			 "Pro2 BT report too short: %zu bytes\n", len);
> +		return 0;
> +	}
> +
>  	wacom_intuos_pro2_bt_pen(wacom);
>  	if (wacom->features.type == INTUOSP2_BT ||
>  	    wacom->features.type == INTUOSP2S_BT) {
> -- 
> 2.50.1 (Apple Git-155)
> 
