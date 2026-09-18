Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5000D38DC56;
	Fri, 18 Sep 2026 09:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789723713; cv=none; b=i3BBzhmA5IQDwVgWEcbSXPqgqUynixmg+8pZ7FnLs+3qawbsy7Xnkd5FYLyX6cW8YeeFb0GBftz0lKGQHV2zQFcESAp36Ss6NTE43RtQA1d903+MTOgrr43IHxhHor4NkSL+7FKFceAKZGU7uY90xPQelDFXP9TTBQzYKr11nlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789723713; c=relaxed/simple;
	bh=gjrOcfyPvbhzTja4ost2cV7yMLpVNkA8gzidI4sJOIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S3/uts0Xy/d6gNQSW6zx5msttlOvlFOk3OKmuof69bhXjUU86qLdzxjRxLhpfUI0HlAmJE6jj7fB4aPPk0wcdet0ckmdOXfaumlkLW5vJ1OChcDjhFVLXL3zsmoFTxMio7Wn6tsioPWi1UNqn88G3XKyTEH9X6dKycyhmTwg1kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KdER57Gl; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KdER57Gl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789723710; x=1821259710;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gjrOcfyPvbhzTja4ost2cV7yMLpVNkA8gzidI4sJOIs=;
  b=KdER57GlITv5nGjSMoBmV88Hdvkv3Palp1v3eDFDLYm4WsEQmzhv93vd
   +2yRA5jiIrLXiTYZTEjBIgHW9hbya5ruW5yaU00w05ViaMqsDt+2DU0ei
   lkLEHU/hEMqWx0a1f59Sa1KatHqMJZ7qhcNLwv/DRdG2FaXUQHN0p82JJ
   67GkyLOsgX8eA//tNfsvNHGRAe8RXHqRoan7hzKIz8aY10n8QsebKK3pM
   oahmdqnQi/sRqiThwKfNIBKGfxAvo71chjLBjBH16PFz3w5AZOHFvAZcM
   KoDyjfXWrOtdmU4yJWwSR9U0STyrRVlS9GpjaNAtU0f4LFiNEnGkfaEZi
   g==;
X-CSE-ConnectionGUID: hvf1kDFoTwyZZHPUX9Bj8g==
X-CSE-MsgGUID: F+68RKbHTIK2xvpw9+luhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="107720959"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="107720959"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 02:28:29 -0700
X-CSE-ConnectionGUID: 2EAxVTEwTU61T+5O1uZ/xA==
X-CSE-MsgGUID: Lsg+i0M2T4illK0NtgEfMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="279544287"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa005.fm.intel.com with ESMTP; 18 Sep 2026 02:28:26 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id C713399; Fri, 18 Sep 2026 11:28:21 +0200 (CEST)
Date: Fri, 18 Sep 2026 11:28:21 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: jens.glathe@oldschoolsolutions.biz
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Abel Vesa <abelvesa@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Sebastian Reichel <sre@kernel.org>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	stable@vger.kernel.org, "Dr. David Alan Gilbert" <dave@treblig.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH v2 3/3] usb: typec: mux: ps883x: disable USB4 on
 incomplete USB4 platforms
Message-ID: <aq0ENUZzJYKZ6V9f@black.igk.intel.com>
References: <20260914-ps883x-disable-usb4-v2-0-523c32b4e4d7@oldschoolsolutions.biz>
 <20260914-ps883x-disable-usb4-v2-3-523c32b4e4d7@oldschoolsolutions.biz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914-ps883x-disable-usb4-v2-3-523c32b4e4d7@oldschoolsolutions.biz>

On Mon, Sep 14, 2026 at 08:05:03AM +0200, Jens Glathe via B4 Relay wrote:
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

What's the purpose of that link?

I think you want to make a reference to the commit 0c8ee850572b ("usb:
typec: ucsi: Add UCSI_USB4_IMPLIES_USB quirk for X1E80100"), right?

Is this meant to fix that commit? If so, then please use a proper
"Fixes: 0c8ee850572b ("usb: typec: ucsi: Add UCSI_USB4_IMPLIES_USB
quirk for X1E80100")" tag.

Thanks,

> Assisted-by: Grok(xAI):4.6
> Signed-off-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
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

-- 
heikki
