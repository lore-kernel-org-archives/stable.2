Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2413923BD17;
	Mon,  8 Jun 2026 08:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780909184; cv=none; b=IYgDaFPfgskHcdcHAz5enNo5hH+Gj7JYiJ3YMQ5KHvnoGpwAw6UaEOe1KXTCaaJOsNTrqj8ZEIQ9oD5Q0uCpnR1yrcaunzIDaX2GgAfLagP7A00uTK5Z3z0grBUiOJ4G254IneyZvp16OQsxF+wrwxDOiXF/mIl8nsjLc9G/MBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780909184; c=relaxed/simple;
	bh=UDnNOgELOg+d8YJcd8U2TlhiVcqvlK/B5E7kR0OSrso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i4c1PXejM+3Cjt9SH7zoUMpI6yLxjoK04Kj3GtIZi+auknHjMrLOztVsAioN/pFJjbnKuct/Usk/UN6KvwOUJ7FkNFpuezh6j9wCglg8Io751qlZmeE2SoBYQwz5HJPVXJgONDoX/0WNd5kWj1Rh8XXAFM3r2ZOI4NG+whutMiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+bk9HSk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+bk9HSk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA59A1F00893;
	Mon,  8 Jun 2026 08:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780909182;
	bh=Ympagf+YvhYAdU58KVoJVvihm7UEe/AhvGWgbs0wsCc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=B+bk9HSkNUYZ4qOq33wDzWO0GqZ6/y7kD3VyRq3Sx9kpcvXGktAbGY+ahW3mWWIy3
	 kRCDyqCel9dx0SnCMpGjnKQi1eebFZVMGzYYZ3M490s3ZPulRpTlVNWcYKHoz+7e1D
	 o4fJKk8BBlVfLJt3vx60+55TVKB05/oOpSpd4Avo+wcdWnTdkLO2er7/omr8RGDyvg
	 69SXgJ6wXXi+pkLZmL1ynEFRN7mlrHh3tcqw2rLUr31gst6BF2JF+xzWt5fyk08rT3
	 e3SVmqeaOXXc72WMzG5QsvAeAvvb/caZZD5QbBJM9wb+ogQyj/cosUxXfnlwqkHk+V
	 anhgBPIG3onfw==
Date: Mon, 8 Jun 2026 09:59:38 +0100
From: Lee Jones <lee@kernel.org>
To: Carlos Llamas <cmllamas@google.com>
Cc: David Rheinsberg <david@readahead.eu>, Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>, kernel-team@android.com,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	"open list:UHID USERSPACE HID IO DRIVER" <linux-input@vger.kernel.org>
Subject: Re: [PATCH] HID: uhid: convert to hid_safe_input_report()
Message-ID: <20260608085938.GH4151951@google.com>
References: <20260606181552.3095967-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260606181552.3095967-1-cmllamas@google.com>

On Sat, 06 Jun 2026, Carlos Llamas wrote:

> Commit 0a3fe972a7cb ("HID: core: Mitigate potential OOB by removing
> bogus memset()"), added a check in hid_report_raw_event() to reject
> reports if the received data size is smaller than expected. This was
> intended to prevent OOB errors by no longer allowing zeroing-out of
> shorter reports due to the lack of buffer size information.
> 
> However, this leads to regressions in hid_report_raw_event(), where
> shorter than expected reports are rejected, even though their buffers
> are sufficiently large to be zero-padded.
> 
> To solve this issue, Benjamin introduced a safer alternative in commit
> 206342541fc8 ("HID: core: introduce hid_safe_input_report()"), which
> forwards the buffer size and allows hid_report_raw_event() to safely
> zero-pad the data.
> 
> Convert uhid to use hid_safe_input_report() and pass UHID_DATA_MAX as
> the buffer size. This prevents the reported regressions [1], allowing
> hid core to zero-pad the shorter reports safely as expected.
> 
> Cc: stable@vger.kernel.org
> Fixes: 0a3fe972a7cb ("HID: core: Mitigate potential OOB by removing bogus memset()")
> Closes: https://lore.kernel.org/all/ahsh0UtTX6e0ZeHa@google.com/ [1]
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Reviewed-by: Lee Jones <lee@kernel.org>

> ---
>  drivers/hid/uhid.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
> index 524b53a3c87b..37b60c3aaf66 100644
> --- a/drivers/hid/uhid.c
> +++ b/drivers/hid/uhid.c
> @@ -595,8 +595,8 @@ static int uhid_dev_input(struct uhid_device *uhid, struct uhid_event *ev)
>  	if (!READ_ONCE(uhid->running))
>  		return -EINVAL;
>  
> -	hid_input_report(uhid->hid, HID_INPUT_REPORT, ev->u.input.data,
> -			 min_t(size_t, ev->u.input.size, UHID_DATA_MAX), 0);
> +	hid_safe_input_report(uhid->hid, HID_INPUT_REPORT, ev->u.input.data, UHID_DATA_MAX,
> +			      min_t(size_t, ev->u.input.size, UHID_DATA_MAX), 0);
>  
>  	return 0;
>  }
> @@ -606,8 +606,8 @@ static int uhid_dev_input2(struct uhid_device *uhid, struct uhid_event *ev)
>  	if (!READ_ONCE(uhid->running))
>  		return -EINVAL;
>  
> -	hid_input_report(uhid->hid, HID_INPUT_REPORT, ev->u.input2.data,
> -			 min_t(size_t, ev->u.input2.size, UHID_DATA_MAX), 0);
> +	hid_safe_input_report(uhid->hid, HID_INPUT_REPORT, ev->u.input2.data, UHID_DATA_MAX,
> +			      min_t(size_t, ev->u.input2.size, UHID_DATA_MAX), 0);
>  
>  	return 0;
>  }
> -- 
> 2.54.0.1032.g2f8565e1d1-goog
> 

-- 
Lee Jones
