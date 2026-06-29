Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E464221CC5C;
	Mon, 29 Jun 2026 13:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782740524; cv=none; b=hYAjZ9SxD5dI2nNinqYIkiPajga1HciBVaocoi1DiGAO5msrSBHxmxr5p+cEmgICbLkDra+zpvprXYkZlORf63OfX+/dnsq6J0ESeX6wOcay45d+1lEg2qAKDTx8lK1HmTvxcqKZSkUX3BvquTGwcAesfkDQq5H7LbTAbVMZS6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782740524; c=relaxed/simple;
	bh=+kc1qrMrge86KJ2GHrh9yccTm3nB0SSTHbShyzjlAmQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Iyl/JoPQe4FgcwnkDaYnioqSAQd2If2Az01roKxa6HCxvs0WYmmdHpxuqu5pnujvjEhxKaa1JdmRrTOD2ShRRRC2UFo9UFNphfrJOsNQ2z3kLj6ne8eLloZrDEooqRvgqj5jYLGyP82JjUPykrUI33hC7rM0oYyH1gzr1mijGz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EfX6H47Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EfX6H47Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 399EE1F00A3A;
	Mon, 29 Jun 2026 13:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782740523;
	bh=Q1s01vKCdffKvBPVSuCqRXO14x2GGOdqipqOEWxN/mc=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=EfX6H47QFnVPd8Zh8wUukT8qtO2KXShlwYr651j5mGQ9QTTCIWBBEDp0FtQTDzUy3
	 EdccdlxvB10OQPmCvLtn4+Z1l17Jp9cdCeVtOFvXYOw9B2VaQh57kV4vcTXaOh+SOj
	 O//eTGOF67eAeMbNQFdMlMaB0LhmpKocKrX1c10RuzvGkd71OkbuNtSRjMZJAN/f6Z
	 bIETt8rkt+Au4YDPXgHDAp6GQRZvO7GtOpnWNV3+3MzEtJYs7JiBcqtAQX3QVqiQ4x
	 0g4cbhls7nulz3OkqHXiSVpTkRS63UpftyJQgiySx0140IM6x7u9ewQsQZazVGxMNg
	 uHXLnJy3vC6SQ==
Message-ID: <b62fd998-b1ee-4c40-b524-0486016f0ec2@kernel.org>
Date: Mon, 29 Jun 2026 15:42:00 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: Re: [PATCH 07/10] Input: synaptics-rmi4 - check V4L2 buffer size in
 F54 queue
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Bryam Vargas <hexlabsecurity@proton.me>, Hans Verkuil <hverkuil@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260626051802.4033172-1-dmitry.torokhov@gmail.com>
 <20260626051802.4033172-7-dmitry.torokhov@gmail.com>
Content-Language: en-US, nl
In-Reply-To: <20260626051802.4033172-7-dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/06/2026 07:17, Dmitry Torokhov wrote:
> Add a safety check in rmi_f54_buffer_queue() to ensure that the
> requested report size (f54->report_size) does not exceed the actual
> allocated size of the V4L2 buffer (vb2_plane_size()).
> 
> This provides a defense-in-depth measure against any potential size
> mismatches between the V4L2 queue and the driver's internal state.
> 
> Fixes: 3a762dbd5347 ("[media] Input: synaptics-rmi4 - add support for F54 diagnostics")
> Cc: stable@vger.kernel.org
> Assisted-by: Antigravity:gemini-3.5-flash
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/rmi4/rmi_f54.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/input/rmi4/rmi_f54.c b/drivers/input/rmi4/rmi_f54.c
> index c86bc81845bb..93526feea563 100644
> --- a/drivers/input/rmi4/rmi_f54.c
> +++ b/drivers/input/rmi4/rmi_f54.c
> @@ -354,6 +354,13 @@ static void rmi_f54_buffer_queue(struct vb2_buffer *vb)
>  		goto data_done;
>  	}
>  
> +	if (f54->report_size > vb2_plane_size(vb, 0)) {
> +		dev_err(&f54->fn->dev, "Buffer too small (%lu < %d)\n",
> +			vb2_plane_size(vb, 0), f54->report_size);
> +		state = VB2_BUF_STATE_ERROR;
> +		goto data_done;
> +	}
> +

That's the wrong place, it's too late for that check.

This should be checked in the buf_prepare callback. See e.g.
drivers/media/test-drivers/vivid/vivid-touch-cap.c.

Regards,

	Hans

>  	memcpy(ptr, f54->report_data, f54->report_size);
>  	vb2_set_plane_payload(vb, 0, rmi_f54_get_report_size(f54));
>  	state = VB2_BUF_STATE_DONE;

