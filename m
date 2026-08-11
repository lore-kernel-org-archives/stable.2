Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C156A46EC64
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 21:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786484431; cv=none; b=mFJwJHogdx4HtQ4p8wZGJ3J8P2fgPOwBrM4METNwrJu1fpXy4pg+Y65uzTHJ0jGMHNv9U05TEoF+GsQ7kxyetWh5//ryltCUAR3JmTA1RkRhNJ+iu6iJJpgdg80HRcDxy3/4dVlz1e+NK3tXsvcD/dSsr90OpKFKy6ahLoFpVys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786484431; c=relaxed/simple;
	bh=Ll78vpwObE588vHxzO5Tvc+xexqmBp/RM0FOMnlk7Jc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pnm6hYjXYdna1ABIpEQWfa/apiMCR1Wwp2YBdE0D9url3IS6kLACkvSYC/dQ7iCa4hNLQ37VaQlXl7aMgVAHVeemVK9CXoEmf76c+95/3tIzWOK+WdHT/YrSD1DcLmVyIvucH74Gg92lT1ZnOnZINIvySAqowkacdRqsOhqmDh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZEVcBM6t; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZEVcBM6t"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-ca7c1176317so209107a12.1
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 14:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1786484429; x=1787089229; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mwQhH4XS3un6SW0fojWkls2gU/V4w8kR3cIWs4sWaGQ=;
        b=ZEVcBM6tQa4IbaaOJm0lApxPykZSUZudauaV083i7eMGctvlXyuL35ilxe1br3Rxhl
         lwCOOgGWrYOAmcLrxYGI6PCGl9lv6XS3+b4BZnajF6mz2KIpHbw/6XByvyTR8CZIzsMy
         UBJvKY4vBc3V0LGYtZddEr/hM6dEwmtbFte5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786484429; x=1787089229;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mwQhH4XS3un6SW0fojWkls2gU/V4w8kR3cIWs4sWaGQ=;
        b=InI40rdFCzS/bRB+5CfFMNeBu8mehX/6R8pTsf7+eNXlJjeFdiQZLXnyKUOGmKlxHt
         277/87RhYDfkKSL6hREe09+2bQje4nT2Kw/LYUTL0uUBJ49WkQBdMxQWxavYQlavz8qS
         n+HkuB0Of0ctlpJrbVwMZS3y0GIwQNVbg/v2CZvo8WnAgaL4EwKhJ5njWbrOTzfBI18b
         ABkFm0H6rhpzmxc5xPMcuNSbhY0na1jbUpUUYFVGgApcltiFscur48HE85d84s1XCU3P
         m6nZjWLGbyXcc4K65AmGxvoejWOEFOEvtgbWMZbKNr0Bdcvz5HNbyXBNeK1/7DtIDm4E
         7xWQ==
X-Forwarded-Encrypted: i=1; AHgh+RoN6mzXZPQEYqhNzA2FI77fQ7M8QOYNhqrGoD/1eL1S5vjDVfl8D4NiBLzBigC577IJVQrbNdo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4zQkfojMqfA8bP4+jxONG6j8gO43coxfr/Gfi3CtQaY4O6laJ
	YcSiFP16N98FyOwtPcD6PCeiV2dXI/GPKz47K4Sbxn9LXgKMLvIsf0IQ+2B2Rmpi5xyIkXT0eTx
	jGZH5PA==
X-Gm-Gg: AR+sD11JvrWfGrKLNSZFuQ1KOItHL2DKULYh0216DQr7Z0NMDiWPiatyN/twWUL8VNy
	+FAqVw7SCyUxye1QHzjWeBn/dKQSthkZHBjiJLgeOvtShNLLJVxpoBzINC49Fi81L/ZmHgbkKDW
	EX43w1kMRXCTQdk17X2FEl34O6kimtI3O5NxfUqqcvAanDE0eU8d6mGmVgTeH9+RQagWXt1sqgd
	7wo5qx63k7IZK45fr4JhVHTDowDC2Fvxr97xpbdALB0xpFJ1Qkl916waJDH/IYPh4rEliJIPvVB
	ixUV/Z+nfknE8oPqOvJR6i8+3z6/754e3SGqcZbIsxTP9mRVaYY/cP7T/IKD2fWGi3ja5WK2ERn
	Ocb0a80xS8K5mtKZ4ms2c04ixJZ7Vcm5IXjFhEZGyakgIT1zMq4gfKxjw9MzyBxjvFKPp2PxKPZ
	mmV2yhMJM0nm2KCpqYAdbhYCbTrB90YqPjSyIpbdhLtOMB/syng8DEAtfLuvjASWdWhJSXCZ/AW
	O/j1rbZwSYi2Dc8eCvsMSyDuQU=
X-Received: by 2002:a05:6a21:a0b:b0:3c3:791e:5e0c with SMTP id adf61e73a8af0-3cc2ba5a436mr9230650637.19.1786484428882;
        Tue, 11 Aug 2026 14:40:28 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:79fa:d268:80cb:4947])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-31cf3d0517csm2929719eec.9.2026.08.11.14.40.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 14:40:28 -0700 (PDT)
Date: Tue, 11 Aug 2026 14:40:26 -0700
From: Brian Norris <briannorris@chromium.org>
To: Zhao Li <enderaoelyther@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	johannes@sipsolutions.net, francesco@dolcini.it,
	linville@tuxdriver.com, patila@marvell.com, cluo@marvell.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] wifi: mwifiex: validate action frame fixed fields
Message-ID: <anuWyiPQja6_5vly@google.com>
References: <20260723011013.76968-1-enderaoelyther@gmail.com>
 <20260723202257.688-1-enderaoelyther@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723202257.688-1-enderaoelyther@gmail.com>

Hi,

On Fri, Jul 24, 2026 at 04:22:57AM +0800, Zhao Li wrote:
> mwifiex_process_mgmt_packet() accepts an rx_pkt_length as small as a
> four-address struct ieee80211_hdr plus the two-byte firmware length prefix.
> After stripping the prefix, mwifiex_parse_mgmt_packet() can receive a
> buffer equal to sizeof(struct ieee80211_hdr).
> 
> For action frames, the parser reads the category byte immediately after
> that header and, for a public action frame, reads the following action
> code byte without verifying that either field is present. A minimal frame
> therefore reads one or two bytes beyond the RX buffer.
> 
> Require the category and public action-code fields before reading them.
> mwifiex parses the firmware four-address layout before removing addr4,
> so add ETH_ALEN to the standard IEEE80211_MIN_ACTION_SIZE() offsets.
> 
> Suggested-by: Johannes Berg <johannes@sipsolutions.net>
> Fixes: 72e5aa8d2a6d ("mwifiex: support for parsing TDLS discovery frames")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/all/66f148d83eb9f0970b9abbccc85d1b61244e54ad.camel@sipsolutions.net/
> Link: https://lore.kernel.org/all/20260708195911.84365-8-enderaoelyther@gmail.com/
> Link: https://lore.kernel.org/all/20260723011013.76968-1-enderaoelyther@gmail.com/
> Assisted-by: Codex:gpt-5
> Assisted-by: Claude:opus-4.8
> Signed-off-by: Zhao Li <enderaoelyther@gmail.com>

I think this is another one of those cases where we're working hard to
validate against the firmware-reported packet length, but we're not
actually checking that the reported length fits within the real skb
size (skb->len).

If you want to follow up on that, that could be worth doing in
mwifiex_process_mgmt_packet().

> ---
> Changes in v3:
> - Drop the redundant parser-local header check; the caller already
>   guarantees the complete four-address header after removing the two-byte
>   firmware prefix.
> 
> Changes in v2:
> - Express the action-field sizes with IEEE80211_MIN_ACTION_SIZE(),
>   accounting for the firmware four-address layout.
> ---
>  drivers/net/wireless/marvell/mwifiex/util.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/wireless/marvell/mwifiex/util.c b/drivers/net/wireless/marvell/mwifiex/util.c
> index 7d3631d21223..e54a86ecaa33 100644
> --- a/drivers/net/wireless/marvell/mwifiex/util.c
> +++ b/drivers/net/wireless/marvell/mwifiex/util.c
> @@ -317,9 +317,15 @@ mwifiex_parse_mgmt_packet(struct mwifiex_private *priv, u8 *payload, u16 len,
>  
>  	switch (stype) {
>  	case IEEE80211_STYPE_ACTION:
> +		if (len < IEEE80211_MIN_ACTION_SIZE(category) + ETH_ALEN)

IEEE80211_MIN_ACTION_SIZE() sorta implies we're using 'struct
ieee80211_mgmt' in here. But we're using 'struct ieee80211_hdr' and the
4-address format, in fact.

That disconnect then means you have to awkwardly account for the extra
address by adding ETH_ALEN.

All in all, I kinda prefer the style of v1, where you directly reference
the size of the actual things we're using (sizeof(*ieee_hdr)). It has
the downside of the open-coded "+ 1" and "+ 2", but that's how the
existing parsing works, so IMO it's still better to match that.

(I do see Johannes suggested this in v1, but I'm not sure I agree, now
that I see the result.)

> +			return -1;
> +
>  		category = *(payload + sizeof(struct ieee80211_hdr));
>  		switch (category) {
>  		case WLAN_CATEGORY_PUBLIC:
> +			if (len < IEEE80211_MIN_ACTION_SIZE(action_code) + ETH_ALEN)
> +				return -1;
> +
>  			action_code = *(payload + sizeof(struct ieee80211_hdr)

If we end up going back to 'sizeof(*ieee_hdr)' approach, I'd suggest
changing this too, for consistency.

Brian

>  					+ 1);
>  			if (action_code == WLAN_PUB_ACTION_TDLS_DISCOVER_RES) {
> -- 
> 2.50.1 (Apple Git-155)
> 
