Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456AC3AAF4A;
	Fri, 18 Sep 2026 09:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789725424; cv=none; b=TG/URBgYlvBH+kEAmpvsdbUiY+aC6j4uOTYyT12IcNoAfOR/FEU8jzIndZadtp3V3Ye8/IHUY2AvcXR1BcM/Ud0sDnMQGpbRIvkZGXUFAjl0SVW/PzFKG51OpdaZvdJ3tLzqrylRJKTWIwo8QVIID07CNRCaiKKMDPNNHivHhkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789725424; c=relaxed/simple;
	bh=hZ1x00CmvH/v3SfkzJvQTSbvvIy+fDJWOOfZXXMnCSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nu/LaLnH9tkPNDr11OhHhKX0gRYLQuOqyqUeo/gowNNGyDv6rB9NZOFDCE6ZhlaJ/M4e92BgowPeHFPlIxZeGR0vmlx1SVLh6rIwkvTtSoMJxb/R1YNYM2buM3WOxs8j34xJ9l5tKzn/RCtxy/bmpmspP2Oqq1tWODrEDEDdrkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nM/Joy5T; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nM/Joy5T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789725420; x=1821261420;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hZ1x00CmvH/v3SfkzJvQTSbvvIy+fDJWOOfZXXMnCSc=;
  b=nM/Joy5Tx9d7T7IguFOUYEnEUsGtEz2HFbuuA5Fmd7xHiT2N2Scl0BMz
   nYUwTPIQZR7OoSxnvqQvh2eIZOvINoxdebHQg7oDphsOMKZpXpUrfu/Fd
   hpCvrT2GWqBOWfAZ0U5Owo5jeYOIo+seIfLPtDqcnfdrZBzooOrbxrQzO
   Ldwpaftnt6nI1QJHgyBSpjN77ix0FdURhw5hkKsDblSJA6dAavy2raYqa
   7VFrjKH+qP2sZpowjRjnCdrETalpEmTE6b2T1zI+WUY07CG5pduUkHqUa
   muUv3uYJw5rlCkG2VIVSCSigCEjf+ww+mEHvkOTsRvDhNUPp1BSKUymi/
   Q==;
X-CSE-ConnectionGUID: 77026hMORE2kGrzHrfs4FA==
X-CSE-MsgGUID: dLlbpJE+RAa+Obnl1UvnkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="100882634"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="100882634"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 02:56:54 -0700
X-CSE-ConnectionGUID: TCzrHF1/RhWzhNMUEHoKGw==
X-CSE-MsgGUID: 37tYMD3SSuClkfINO9FYoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="299431634"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa001.fm.intel.com with ESMTP; 18 Sep 2026 02:56:51 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id F08B999; Fri, 18 Sep 2026 11:56:50 +0200 (CEST)
Date: Fri, 18 Sep 2026 11:56:50 +0200
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
Subject: Re: [PATCH v3 3/3] usb: typec: mux: ps883x: disable USB4 on
 incomplete USB4 platforms
Message-ID: <aq0K4ryxva5sdbjr@black.igk.intel.com>
References: <20260916-ps883x-disable-usb4-v3-0-8f19386456d0@oldschoolsolutions.biz>
 <20260916-ps883x-disable-usb4-v3-3-8f19386456d0@oldschoolsolutions.biz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916-ps883x-disable-usb4-v3-3-8f19386456d0@oldschoolsolutions.biz>

On Wed, Sep 16, 2026 at 09:36:34PM +0200, Jens Glathe via B4 Relay wrote:
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
> Tested-by: Dr. David Alan Gilbert <dave@treblig.org>
> Signed-off-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/mux/ps883x.c | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/drivers/usb/typec/mux/ps883x.c b/drivers/usb/typec/mux/ps883x.c
> index 15aee1d613b1a..2ec57cfe748a9 100644
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
> @@ -260,6 +290,9 @@ static int ps883x_set(struct ps883x_retimer *retimer, struct typec_retimer_state
>  			cfg0 |= CONN_STATUS_0_USB_3_1_CONNECTED;
>  			break;
>  		case TYPEC_MODE_USB4:
> +			if (retimer->disable_usb4)
> +				return -EOPNOTSUPP;
> +
>  			eudo_data = state->data;
>  
>  			cfg2 |= CONN_STATUS_2_USB4_CONNECTED;
> @@ -389,6 +422,10 @@ static int ps883x_retimer_probe(struct i2c_client *client)
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
