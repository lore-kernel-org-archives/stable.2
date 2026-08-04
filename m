Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7736520E334
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 04:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785819081; cv=none; b=jo4Dw7CyylIx7jQPTXDiI0FNSePLV0/UXiDSXcyolsuQmIRh9VAi55987g+WMgh++s32YKICCIH2h9CtC8dumHSGQnA9l1dkKxypSFVugMVDOKk6pXaKSL4FZecg/bdkJDMm8L0yrr0wcRQyiXNe2upEe79OSMVpwGX3m4Y9wws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785819081; c=relaxed/simple;
	bh=bTEnF0GSN3SBXW2xrn7XaencUwWpEBCFuVm/FLAWE4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mRaTunReSu+RtwAmZJEq+KIkHwjrgZZ6yud1+/pxL1LrR7TrnvSuAKrUedCR7ARIsR+0mNM+OYdNQ4VCvrO26sjld/PTg37dsBHzCrK9+6U7N3thFPJgT7JY6xVrW6h56HTSBV6QdmmLtjJI9gWemn/EA2u3V0JD1WUIBWB9ZoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G1XeVLEt; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1XeVLEt"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-382ef647e20so4362045a91.1
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 21:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785819080; x=1786423880; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mdfSBvQXwGzTtQw/QDJdQFO/fQB5csp00HtUR8um7Bk=;
        b=G1XeVLEtPdPT9+IQ3T+TlKetDbfOEdLmB6GR9t7e3Usj2K4QRtnyDOapJfNKU9KeY3
         KVkKBK1zrZSvoyS4ugeKf9uc4Fg4D7NVzYLC0sRMDZnD73mFqoouBdbXk2WR4PM9Kbpu
         VelIgZr/JFCKvdOwYAbLC6TtBT0orAjaWot9/5HPhUzHGyflfcwGeVQbxe/GfzNfJ+o5
         li2ajTNu0BEUwaBwv4Xo3IiDo5FcAJCvnzgeoGHDSvxP0MKeMt9wfsS02foOMqVDZ+iS
         PmZk2V7BIA2py2aDoquMD6gTE5/u1jZtwa1JSWM++ny6xDVoK7zummbg+hFs7qNEZqq4
         9+xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785819080; x=1786423880;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mdfSBvQXwGzTtQw/QDJdQFO/fQB5csp00HtUR8um7Bk=;
        b=r06RWTSBKu7pRPnRQ4OqVxUPzMOB4xcJzupecrMDNC/Jkv+GB3d/QbJA6wQ4Dk3G0F
         S1gHW48+ydHvrLURUEXreWFOHoBXmey5rNcw+BZUdBF60PD4mH1/dHL1zQyvlYjFc+ct
         draHtTYL6+fDBpsiGWG0upRArwi3SYK3zkGZ1++qy64AaYITP9rQcMOQ436U7R1+rgB3
         JnXwcky0JYThTdyvuMzOa8szLfPCtdhRMEzsf2vmTJu0a0uI/QUVvsxqeJxIFiS6p6HR
         FYk4kgPhgm/zpHjsoIuwZwrFlwxl3D3wYlOnZRkkCjszkVW4Sr9yRFWPfyO6i5s6M9gs
         tWRQ==
X-Forwarded-Encrypted: i=1; AHgh+RoipWqnRN4kjKjtVwOgha40i/VPd7PWHHnioQgmaR1qlE8lE3nwRmWWFywrJBFVt8b4fMQ+kU8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP9lR0UNfB0GpjKdp+4aCZv3Cuc22TeARnjor9OdSmYuGSVTyI
	YQ+KYHn/oRGf8WaWG0XYbp2tl30ssyJa35emy2F76fvx3uOlMfwHl1gf
X-Gm-Gg: AR+sD10JVbDn7qk/sxLBnv2uPG/+h0KbNnNQB/4y266Oi1K4SmmCGUSoQFm3ctpgs/X
	fv/TUVy7zxry1g9us/nyNZkfqEcWiUbSGVYx8QOw4Vb8lvIhBqkHWPFkclDkOyCFC8WVm/FCrER
	uAvIc+avSyXd4ZpNX7AvgAisOVbOiTuIXOiUs1WDSvZfzYHaFhpZdDMt6mF8ikRc78yDeywqzFC
	S095pSLwrIi6p/G8aqJ/7HiVw3sZbqwpxwwQlcc2p9O8Nv7qI+x7iXqdxIjPFBXKZAvRis7hzVP
	eoxArnDjezl1/mvdNABzsNZNjS0RT1ELTn8PPsvv9vKt0+9DDSPNIUj6XJrnW9WTJu69mLU/Vjk
	vfitAOCavnqtLFp3X9gnaOdbUudA/7oWbKGNELzvZzAld3fnhP9XcMJo9EqYgnrk8c1SOwgEAg0
	N1Gpwm8uznOMUKUNrULQq2XlC03Pmb+TQrwovMGMapnPlFmyv4xWkq8HMDClstpDB7e53+fJh/e
	LTzUaLJkbwNgc95WQeoTg4nEYnokg==
X-Received: by 2002:a17:90b:3851:b0:38e:dc4:3f64 with SMTP id 98e67ed59e1d1-38fbc52da42mr11200125a91.38.1785819079614;
        Mon, 03 Aug 2026 21:51:19 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:d109:cdba:8a20:74ad])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e06f8dbsm46423466eec.22.2026.08.03.21.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 21:51:18 -0700 (PDT)
Date: Mon, 3 Aug 2026 21:51:16 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jianing Li <m13940358460@163.com>
Cc: linux-input@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] Input: hynitron_cstxxx: validate touch count and
 finger IDs
Message-ID: <anFu87r00Dv6cP-u@google.com>
References: <20260804020314.2082-1-m13940358460@163.com>
 <20260804031339.2379-1-m13940358460@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804031339.2379-1-m13940358460@163.com>

Hi Jianing,

On Tue, Aug 04, 2026 at 11:13:39AM +0800, Jianing Li wrote:
> The driver allocates max_touch_num input slots, which are indexed from
> zero through max_touch_num - 1.  The current check allows a finger ID
> equal to max_touch_num to reach input_mt_report_slot_state(), resulting
> in an out-of-bounds slot access.

This is not quite correct. There is no OOB access because input core
validates reported slot ids and wil refuse switching to a slot that is
outside of limits.

Still, the driver should not be reporting such packets.

> 
> The touch count is read from the controller's report and is used to
> index the fixed-size report buffer without first checking its range.
> Reject counts larger than the supported number of touch slots before
> checking the trailing byte or parsing touch data.
> 
> Reject IDs at the upper bound before using them as slot indexes.
> 
> The V821 Avaota F1 board configures the vendor driver with one touch
> slot, so finger ID 1 is already invalid on that device.
> 
> Fixes: 66603243f528 ("Input: add driver for Hynitron cstxxx touchscreens")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jianing Li <m13940358460@163.com>
> ---
>  drivers/input/touchscreen/hynitron_cstxxx.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/hynitron_cstxxx.c b/drivers/input/touchscreen/hynitron_cstxxx.c
> index f6139b1a8681..05e877b0d877 100644
> --- a/drivers/input/touchscreen/hynitron_cstxxx.c
> +++ b/drivers/input/touchscreen/hynitron_cstxxx.c
> @@ -293,6 +293,11 @@ static void cst3xx_touch_report(struct i2c_client *client)
>  	touch_cnt = buf[5] & CST3XX_TOUCH_COUNT_MASK;
> +	if (touch_cnt > ts_data->chip->max_touch_num) {
> +		dev_err(&client->dev, "cst3xx touch read failure\n");

We need to have better error message.

> +		return;
> +	}
> +
>  	/*
>  	 * Check the check bit of the last touch slot. The check bit is
>  	 * always present after touch point 1 for valid data, and then
>  	 * appears as the last byte after all other touch data.
>  	 */
> @@ -333,7 +338,7 @@ static void cst3xx_touch_report(struct i2c_client *client)
>  		sw = (buf[idx] & 0x0f) >> 1;
>  		finger_id = (buf[idx] >> 4) & 0x0f;
>  
>  		/* Sanity check we don't have more fingers than we expect */
> -		if (ts_data->chip->max_touch_num < finger_id) {
> +		if (finger_id >= ts_data->chip->max_touch_num) {
>  			dev_err(&client->dev, "cst3xx touch read failure\n");

Same here.

>  			break;

Not your change but break here results in finalizing incomplete packet.
It is better to abort (return) and wait for proper packet without
invalid fingers.

>  	}

I made adjustments and applied, thank you.

-- 
Dmitry
