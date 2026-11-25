Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795641918;
	b=2Ikn4ZJxAzZYqHKLZDD7l9UGQBIyePtf54lypuAvdlye/Bts8tjl91fFNypbKPLUE1eA
	 ihrmpF+EL43c+dmCxjPg/MTIPyNrpe0VbM9LRmHgaMGi2oXSjp2a991cW2ufRBPWmawoB
	 eIxECVw/+k9bnAeBdU1mNpNol7wkRy3XwD3jlOirrWcXgEHPt53JvPtmwzCN/nKukTlLH
	 dcVnEkwmAU9FuVmmGjr1WbZXeBWO8E5OtgLb9OKFl3PMrmFYvxjJfnimlEgZG/5JXR+iP
	 WCxcHh8pPPk9nJrrs6XE5NYWCX1GXURaQ8tnoPWqAHLnuYs4M79GaVGE/jdTkqajKgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795641918;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=nrCWVRLjyyop0c1uePgg3TaFXcH8ltMa7BihsfqT1TE=;
	b=eeWGowFhUaDsIn5Al8v+lz12GbErBbwxr8++CsBj1a3mXoQiV92RRUYSw5jXDTtAhgGl
	 YtUZudb6MepPrtqnba6vvD5Ap36SVDFxhALSkrnzxht8g09L/FJ38kWSC6OQAl3EHFIIa
	 gv9f8V+ZH6ZwE4ZdTqqOSUdaUo4R1okIEyeZ58xpxDCq6+c2PuGyJ3TKR96QotfpQO9nm
	 s/60fpCN3coc4O6wsz7VATzBNvDOdnxA/qnzN4oEnt4MYdSPYNT+zIV4axykdVz+NvdQr
	 8lyUq96nQMcLkhh+0TKLpQ7E/wKRAibknCfA1EFQLDzO5t6f/ZbavabUyR9/x7Fop+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=hgCe4r2B;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40456606A683;
	Wed, 25 Nov 2026 21:25:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40456606A683
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=hgCe4r2B
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id 1B47620B7170; Wed, 25 Nov 2026 13:25:07 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1B47620B7170
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1795641907;
	bh=nrCWVRLjyyop0c1uePgg3TaFXcH8ltMa7BihsfqT1TE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hgCe4r2B0HNVbeoD1MgrzFkhCAhHF7AwSM+7RoMW9yopoWJvFazYIJdVl8g/7fbYW
	 1Er6kTSclnY6WZiis2fxryVIV7i9rvOUpQGUKJqM/HFODCio5OjeoA4eXtKD9J6Le6
	 cuSh6uVdUBd3+FRX3rlwg5nmtR7wLI4WqKEKetwc=
Date: Wed, 25 Nov 2026 16:25:07 -0500
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: Lee Jones <lee@kernel.org>
Cc: Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>, Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Michael Bommarito <michael.bommarito@gmail.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 06/10] HID: hyperv: Validate VMBus packet and payload
 bounds on receive
Message-ID: <awdSMw88Be4RKJA9@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20261123155138.2907049-1-lee@kernel.org>
 <20261123155138.2907049-7-lee@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261123155138.2907049-7-lee@kernel.org>

On Mon, Nov 23, 2026 at 03:50:50PM +0000, Lee Jones wrote:
> mousevsc_on_receive() dereferences pipe_msg and hid_msg_hdr without
> verifying hv_pkt_datalen(packet), passes the untrusted pipe_msg->size
> to mousevsc_on_receive_device_info() without checking that the VMBus
> packet actually contains pipe_msg->size bytes, and copies up to
> sizeof(input_dev->input_buf) (16 KiB) from input_report->buffer in
> SYNTH_HID_INPUT_REPORT without checking input_report->header.size
> against the received packet buffer.
> 
> Validate that hv_pkt_datalen(packet) covers the pipe and SynthHID
> headers, that pipe_msg->size fits within the received VMBus packet, and
> that input_report->header.size fits within pipe_msg->size.
> 
> Fixes: b95f5bcb811e ("HID: Move the hid-hyperv driver out of staging")
> Fixes: 934b7778aa7b ("HID: hyperv: validate initial device info bounds")
> Closes: https://sashiko.dev/#/bug/linux-03d64dd2-820e-44e2-ba9e-b4a70f1e55ec
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>

Reviewed-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>

> ---
>  drivers/hid/hid-hyperv.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
> index cfc061dbdd24..1de03e38f363 100644
> --- a/drivers/hid/hid-hyperv.c
> +++ b/drivers/hid/hid-hyperv.c
> @@ -272,14 +272,22 @@ static void mousevsc_on_receive(struct hv_device *device,
>  	struct synthhid_msg_hdr *hid_msg_hdr;
>  	struct mousevsc_dev *input_dev = hv_get_drvdata(device);
>  	struct synthhid_input_report *input_report;
> +	u32 pkt_len = hv_pkt_datalen(packet);
>  	size_t len;
>  
> +	if (pkt_len < sizeof(struct pipe_prt_msg) + sizeof(struct synthhid_msg_hdr))
> +		return;
> +
>  	pipe_msg = (struct pipe_prt_msg *)((unsigned long)packet +
>  						(packet->offset8 << 3));
>  
>  	if (pipe_msg->type != PIPE_MESSAGE_DATA)
>  		return;
>  
> +	if (pipe_msg->size < sizeof(struct synthhid_msg_hdr) ||
> +	    pipe_msg->size > pkt_len - sizeof(struct pipe_prt_msg))
> +		return;
> +
>  	hid_msg_hdr = (struct synthhid_msg_hdr *)pipe_msg->data;
>  
>  	switch (hid_msg_hdr->type) {
> @@ -317,6 +325,10 @@ static void mousevsc_on_receive(struct hv_device *device,
>  		if (!input_dev->init_complete)
>  			break;
>  
> +		if (input_report->header.size >
> +		    pipe_msg->size - sizeof(*input_report))
> +			break;
> +
>  		len = min(input_report->header.size,
>  			  (u32)sizeof(input_dev->input_buf));
>  		memcpy(input_dev->input_buf, input_report->buffer, len);
> -- 
> 2.56.1.750.gf70dc682cf-goog
> 
