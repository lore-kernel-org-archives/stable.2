Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7A018B0A;
	Tue, 15 Sep 2026 01:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789434901; cv=none; b=P6+ufAp5XUvTDGWrzQnfXhbTm/G0MiQ+U23pryz5ZUCiVOfbxfE/w4/d72O6hYNsW30xvYCdZBJ6iHN9vfPYoghd74BSIpYJkKgwmewTi/SIT8j7+L6f+8ysG7cO17vT3ftnwF9ZRREntSa2R/FC7sJwVFZT+tEFKGs57pReY/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789434901; c=relaxed/simple;
	bh=DwJjwn5HIEHKhtU52jSO9IR5QQMvOoresNqNN3wGl5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XN6xnCDgqmkC2gWEnMyHSLn5ML59OMLoWHtr5EFRkH6IVxervcBkykv44MZlJ/bQ4w44qXBeYy16UePRUnJSxLQY7ILVXIM49JJlXZSOqkcWfaDzLXBxuSuZD6njN00xfAHpatqTSIvFQlTDsFAeKIHeaCvllcWwxWUg06sB7dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=fTWCjfLh; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="fTWCjfLh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=Aq7S2rs88ABpoxMUNzWr6791EmdCrGhcJbnJNOT1LaY=; b=fTWCjfLh+xAA/d3S
	+hLFdzyMouCmLyX9WpIXLQfgIoLUr0Zw+7zVYUtWDjR38X7lTMuAu9sVwXVnP1nQm8k8jQoK4GlEr
	Hi1zPTbYoKSbBxgxkJWPBf9LEw+WBBBwTwqloVcyA3eHtGCsdj9/d5bYivdlwg8Ehba77ACvnmaLa
	vFZo/Zqr/TkuxGNFgFIywB86wE3jWqgxqypOpIBsGTxcN5p6VA2/6n6zQF7OgIRHhNvyJ7WYF6ULJ
	phrpvA+xWfS7uqr4aWDGThsjWr6rvSsgCM5uKlq2scUL44eOBcJJMJVl49EhG4j8zsQOmPR7psTWs
	YyY+IRkLo+OsV0SPYw==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
	(envelope-from <dg@treblig.org>)
	id 1x6HTA-00000000b9C-2ZS7;
	Tue, 15 Sep 2026 00:56:20 +0000
Date: Tue, 15 Sep 2026 00:56:20 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: jens.glathe@oldschoolsolutions.biz
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Abel Vesa <abelvesa@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Sebastian Reichel <sre@kernel.org>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	stable@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH v2 3/3] usb: typec: mux: ps883x: disable USB4 on
 incomplete USB4 platforms
Message-ID: <aqiXtO3WrwSFHE3e@gallifrey>
References: <20260914-ps883x-disable-usb4-v2-0-523c32b4e4d7@oldschoolsolutions.biz>
 <20260914-ps883x-disable-usb4-v2-3-523c32b4e4d7@oldschoolsolutions.biz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20260914-ps883x-disable-usb4-v2-3-523c32b4e4d7@oldschoolsolutions.biz>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.107+deb13-amd64 (x86_64)
X-Uptime: 00:55:31 up 2 days, 12:40,  3 users,  load average: 0.00, 0.00, 0.00
User-Agent: Mutt/2.2.13 (2024-03-09)

* Jens Glathe via B4 Relay (devnull+jens.glathe.oldschoolsolutions.biz@kernel.org) wrote:
> From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
> 
> On Qualcomm X1E80100 / X1P42100 platforms using the Parade PS883x
> retimer, hotplugging USB4-capable docks such as the Lenovo 40B0 can
> result in working USB but no DisplayPort output.
> 
> When the dock negotiates USB4, the retimer receives TYPEC_MODE_USB4
> and forwards it via typec_mux_set(). The qmp-combo PHY then selects
> USB3-only because no classic DP altmode SVID is present in the state,
> leaving the DP transmitter and AUX channel disabled.
> 
> Reject USB4 with -EOPNOTSUPP on platforms whose USB4 / DP-tunneling
> stack is not ready yet. The Type-C stack then falls back to USB3 + DP
> Alt Mode. DP altmode configuration continues to use the existing
> ps883x_set() path.
> 
> Use a machine-compatible table rather than a DT property so the quirk
> stays inside the kernel and can be removed later without creating ABI.
> 
> Link: https://patch.msgid.link/20260312101431.2375709-1-krishna.kurapati@oss.qualcomm.com
> Assisted-by: Grok(xAI):4.6
> Signed-off-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>

Seems to work here (pair of Asus zenbook a14's doing usb networking), so:

Tested-by: Dr. David Alan Gilbert <dave@treblig.org>

> ---
>  drivers/usb/typec/mux/ps883x.c | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/drivers/usb/typec/mux/ps883x.c b/drivers/usb/typec/mux/ps883x.c
> index e93e958065f6f..02d6c04d45ae3 100644
> --- a/drivers/usb/typec/mux/ps883x.c
> +++ b/drivers/usb/typec/mux/ps883x.c
> @@ -13,6 +13,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> +#include <linux/of.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/usb/pd.h>
> @@ -42,6 +43,22 @@
>  #define CONN_STATUS_2_TBT_UNIDIR_LSRX_ACT_LT	BIT(4)
>  #define CONN_STATUS_2_USB4_CONNECTED		BIT(7)
>  
> +/*
> + * Platforms where the USB4 / DP-tunneling stack is not ready yet. Rejecting
> + * USB4 here lets the Type-C stack fall back to USB3 + DP Alt Mode instead of
> + * negotiating USB4 and then failing to drive DisplayPort.
> + *
> + * This is a temporary, kernel-contained quirk (not DT ABI). Drop the entries
> + * once the corresponding USB4 support is complete.
> + */
> +static const char * const ps883x_disable_usb4_compats[] = {
> +	"qcom,x1e80100",
> +	"qcom,x1p42100",
> +	"qcom,hamoa",
> +	"qcom,purwa",
> +	NULL,
> +};
> +
>  struct ps883x_retimer {
>  	struct i2c_client *client;
>  	struct gpio_desc *reset_gpio;
> @@ -63,8 +80,21 @@ struct ps883x_retimer {
>  
>  	enum typec_orientation orientation;
>  	bool in_reset;
> +	bool disable_usb4;
>  };
>  
> +static bool ps883x_should_disable_usb4(void)
> +{
> +	const char * const *compat;
> +
> +	for (compat = ps883x_disable_usb4_compats; *compat; compat++) {
> +		if (of_machine_is_compatible(*compat))
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>  static int ps883x_enable_vregs(struct ps883x_retimer *retimer)
>  {
>  	struct device *dev = &retimer->client->dev;
> @@ -262,6 +292,9 @@ static int ps883x_set(struct ps883x_retimer *retimer, struct typec_retimer_state
>  			cfg0 |= CONN_STATUS_0_USB_3_1_CONNECTED;
>  			break;
>  		case TYPEC_MODE_USB4:
> +			if (retimer->disable_usb4)
> +				return -EOPNOTSUPP;
> +
>  			eudo_data = state->data;
>  
>  			cfg2 |= CONN_STATUS_2_USB4_CONNECTED;
> @@ -391,6 +424,10 @@ static int ps883x_retimer_probe(struct i2c_client *client)
>  
>  	retimer->client = client;
>  
> +	retimer->disable_usb4 = ps883x_should_disable_usb4();
> +	if (retimer->disable_usb4)
> +		dev_info(dev, "USB4 disabled until platform USB4 support is complete\n");
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
