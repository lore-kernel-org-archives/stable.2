Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877C31E531;
	Sun, 19 Jul 2026 01:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784423940; cv=none; b=swoCdgwO6xcZgd6DsXevEq3/XZtzMYKyR8678Tl723AzO6jGqv8N+/gxfl6ybifXVRP47ZZck7QT2ty2MbFw0l6DSOotIaizpDkVTbYRpQop3Py1lIrZjmUeoAjGlAsnTfnUx3q+jmrpcsgHgHh2bO0vhTAH0X2syw0e+0iv0Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784423940; c=relaxed/simple;
	bh=HpKzQwdWnZXfUFVyjvn4Y1ma8GYpPUZe84X7AWEHGWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bjXovKwGXSvXbGAIwexfySd8egpdQBRkj+8Q/ri51V66+FQp5fhbrmPPZeOeXTg09S+TKIt/G21gZVWOttOcih2YWsbfhBki/X3A/9u+SBLJMyDB71yejr/48WGDrVP3F1nV2zioh+f/PFSEw8R0CSREUr/14EwmPTUqFXGAkWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=ZNVybkf5; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="ZNVybkf5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=+hR30FyCx6dJ/Rb8n97v+rar2Y0DFtw7gllu3+XUFXE=; b=ZNVybkf58ijbRjJV
	8ur2h6gkcxxaXGwLxsGBpIRMMHmgqx8cTFfHxjox0oQ8T4Wcqfk1wQb5773dsKNstVeMUf8gfsiNp
	C+8kJ38MdwTPam9MSBC0+Ok6EYY1f5yKbuD20RRZo9Wmm3L5Q3hRgXleWRXgiVcyEc3tcq8tIb+wS
	jKQ4lWtuhc/zCM8uRVIcsZJEzMDuk/2vGYQjRqVWd1CO5gu8jcAn9M/CbkJBMTWiQ9wgh5VXIMCi/
	f+NHiPH7/j1bX/ETI3uwoENzTfsC/dUcnnSYK1nkdE3Bw92AF2bsG6YJvvnnUHDoaRT57vWd0MPBh
	nR/snDsliRQec5dOlw==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
	(envelope-from <dg@treblig.org>)
	id 1wlG78-00000003ZUc-0bBQ;
	Sun, 19 Jul 2026 01:14:42 +0000
Date: Sun, 19 Jul 2026 01:14:42 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: jens.glathe@oldschoolsolutions.biz
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/5] usb: typec: ps883x: Return -EOPNOTSUPP for USB4 when
 parade,disable-usb4 is set
Message-ID: <alwlAgUQnzfg75hp@gallifrey>
References: <20260718-ps883x-disable-usb4-v1-0-cec86d0b909e@oldschoolsolutions.biz>
 <20260718-ps883x-disable-usb4-v1-2-cec86d0b909e@oldschoolsolutions.biz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20260718-ps883x-disable-usb4-v1-2-cec86d0b909e@oldschoolsolutions.biz>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.95+deb13-amd64 (x86_64)
X-Uptime: 01:13:18 up 13 days, 54 min,  3 users,  load average: 0.00, 0.00,
 0.00
User-Agent: Mutt/2.2.13 (2024-03-09)

* Jens Glathe via B4 Relay (devnull+jens.glathe.oldschoolsolutions.biz@kernel.org) wrote:
> From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
> 
> On Qualcomm X1E80100 platforms using the Parade PS883x retimer (like
> Lenovo ThinkPad T14s Gen6), hotplugging USB4-capable docks such as the
> Lenovo 40B0 results in working USB but no DisplayPort output on the
> dock's HDMI/DP ports.
> 
> When the dock negotiates USB4, the retimer receives TYPEC_MODE_USB4
> and forwards it via typec_mux_set(). The qmp_combo PHY then selects
> QMPPHY_MODE_USB3_ONLY because no classic DP altmode SVID is present in
> the state, leaving the DP transmitter and AUX channel disabled.
> 
> Add a DT property "parade,disable-usb4" that, when present, makes the
> PS883x driver reject USB4 modes as not supported. DP altmode
> configuration is still applied if negotiated, so both USB and
> DisplayPort continue to work.
> 
> This is a temporary workaround until proper USB4 DP tunneling support
> is available in the X1E USB4 controller and qmp_combo PHY stack.
> 
> Link: https://patch.msgid.link/20260312101431.2375709-1-krishna.kurapati@oss.qualcomm.com
> Assisted-by: Grok(xAI):4.3
> Signed-off-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>

Tested-by: Dr. David Alan Gilbert <dave@treblig.org>
  On zenbook a14 with the following patches and a TB cable

> ---
>  drivers/usb/typec/mux/ps883x.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/usb/typec/mux/ps883x.c b/drivers/usb/typec/mux/ps883x.c
> index 64e0a61b776a1..3fa26ce01a9c9 100644
> --- a/drivers/usb/typec/mux/ps883x.c
> +++ b/drivers/usb/typec/mux/ps883x.c
> @@ -62,6 +62,7 @@ struct ps883x_retimer {
>  
>  	enum typec_orientation orientation;
>  	bool in_reset;
> +	bool disable_usb4;
>  };
>  
>  static int ps883x_enable_vregs(struct ps883x_retimer *retimer)
> @@ -249,6 +250,13 @@ static int ps883x_set(struct ps883x_retimer *retimer, struct typec_retimer_state
>  			cfg0 |= CONN_STATUS_0_USB_3_1_CONNECTED;
>  			break;
>  		case TYPEC_MODE_USB4:
> +			if (retimer->disable_usb4) {
> +				dev_info(&retimer->client->dev,
> +					 "USB4 disabled via DT property, rejecting USB4 mode\n");
> +				return -EOPNOTSUPP;
> +			}
> +
> +			/* Normal USB4 handling */
>  			eudo_data = state->data;
>  
>  			cfg2 |= CONN_STATUS_2_USB4_CONNECTED;
> @@ -378,6 +386,8 @@ static int ps883x_retimer_probe(struct i2c_client *client)
>  
>  	retimer->client = client;
>  
> +	retimer->disable_usb4 = device_property_read_bool(dev, "parade,disable-usb4");
> +
>  	mutex_init(&retimer->lock);
>  
>  	retimer->regmap = devm_regmap_init_i2c(client, &ps883x_retimer_regmap);
> 
> -- 
> 2.53.0
> 
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
