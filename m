Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961FE43B6C4;
	Tue,  1 Sep 2026 16:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788278867; cv=none; b=BT0mM0cUHOXCFMjr1zQi0npbkhgnKeb+tqZG/Ol+57Hr+1zw9/V0VF5JVmwI5UJINyVuTe0zJF21ODwqAOid159p+N5Jouv83SkPKkbbrSpPirx0slaI0Hx+IBBNeW2APuU1IHBVBASFsoA4ArlJpKRP7nTA1axtrRSMDXSjNmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788278867; c=relaxed/simple;
	bh=W1kafMqDjOCUPInaEDPdnz/T7i9UzWQpYMS3IeahQyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OOJ004QHdDYr/xFneJMb7RtcgaOTUU2Bw+eVmtYLHPc1bmO3TvE1AT1GMc1/MMF5TUV82HxKwCeWHowaV7tGKqD0cArh7G/Nd3JDTEf/0pxFCpY+MprmtvdpKLx/KusZLv9jQIup6nuVcv4ny3B1ZGKHJzuZuqrSUJ2Oqc87K3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCRpMMXG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCRpMMXG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 074371F000E9;
	Tue,  1 Sep 2026 16:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788278866;
	bh=T/2aUpJVcP4K5UuA+yMWg9r9rcG5CMYvek4Bzm6AV1A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=SCRpMMXGP6roaFqulAGZDp41ZFF8B6X70ykI+UWYhpOv7jGA35GbvrODY2qxdBycf
	 KcvWy4Grani8ffbVC/NhndwvqTKFUzBoB9E0VCPWMKqi9YGIDxDGn1tzjyKyhaR5R+
	 KLUdVjKYOST6KfGZooYp5ZLaMhqpnuawYP8tooSqBughx3Slue+ion3S7/8m/M1pqa
	 JzG0JHVnAN52KwAyDSTbfgOxHZl5xLg99OCK9B1kA+6bpP0B/W2PdB/esAnvvMQmV5
	 FtQec1e26wbAck1gkTMqNx++vxBrSmBBsTjY3lApJmrE0+rfAxwVX2xeVfScs26yiE
	 qG2qZeaKNIfhg==
Message-ID: <c9cf1a69-9136-4f64-b223-aa038520a0a9@kernel.org>
Date: Tue, 1 Sep 2026 18:07:42 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: supply: core: Honor supplied-from with CONFIG_OF=y
To: Maurizio Casciano <mauriziocasciano7@gmail.com>,
 Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Maurizio Casciano <maurizio.casciano@eng.it>, stable@vger.kernel.org
References: <20260901145156.3177187-1-mauriziocasciano7@gmail.com>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <20260901145156.3177187-1-mauriziocasciano7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

Thank you for your patch.

On 1-Sep-26 16:51, Maurizio Casciano wrote:
> From: Maurizio Casciano <maurizio.casciano@eng.it>
> 
> The supplied-from device property is the name-based counterpart to
> firmware-node power-supplies references. It was added for non-DT platforms,
> but its parser is compiled only when CONFIG_OF is disabled. CONFIG_OF is a
> global kernel option, so x86 systems commonly enable it even when
> individual power supplies are described by software nodes.
> 
> Consequently, these consumers never populate supplied_from and supplier
> notifications do not reach their external_power_changed() callbacks. On a
> Lenovo Yoga Book YB1-X91L, ftrace showed the Whiskey Cove supplier
> notification running without invoking the BQ25892 callback, leaving the
> input current limit at its boot-time value.
> 
> Move the generic supplied-from parser into an unconditional helper and try
> it before firmware-reference power-supplies lookup. Keep an explicitly
> supplied list at the highest priority and retain power-supplies as the
> fallback. With the fix, ftrace shows the BQ25892 callback on hotplug and a
> boot-offline test changes its input current limit from 500 mA to 2 A.
> 
> Fixes: 58a36bb06891 ("power: supply: core: Add support for supplied-from device-property")
> Cc: stable@vger.kernel.org
> Signed-off-by: Maurizio Casciano <maurizio.casciano@eng.it>

Interesting. This seems to be a new problem / development in 7.3-rc1
where it seems CONFIG_OF now seems to get enabled on x86 configs.

This change has also lead to other problems, e.g. :

https://bugzilla.redhat.com/show_bug.cgi?id=2523734#c7

Still I agree that this code should do the right thing when CONFIG_OF
is enabled on x86 which it currently clearly is not doing.

But I don't taking that making the new power_supply_check_supplies_by_name()
function higher priority then proper OF/devicetree node links is a good
idea.

IMHO this should be the fallback (in the CONFIG_OF enabled case)
when no suppliers are found through looking at DT node links first.

Sebastian, what do you think ?

Regards,

Hans




> ---
>  drivers/power/supply/power_supply_core.c | 61 ++++++++++++++----------
>  1 file changed, 36 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
> index 00d8bc98d588..5101decebb7a 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -190,6 +190,35 @@ static void power_supply_deferred_register_work(struct work_struct *work)
>  		device_unlock(psy->dev.parent);
>  }
>  
> +static int power_supply_check_supplies_by_name(struct power_supply *psy)
> +{
> +	struct device *parent = psy->dev.parent;
> +	int nval, ret;
> +
> +	if (!parent)
> +		return 0;
> +
> +	nval = device_property_string_array_count(parent, "supplied-from");
> +	if (nval <= 0)
> +		return 0;
> +
> +	psy->supplied_from = devm_kmalloc_array(&psy->dev, nval,
> +						sizeof(*psy->supplied_from),
> +						GFP_KERNEL);
> +	if (!psy->supplied_from)
> +		return -ENOMEM;
> +
> +	ret = device_property_read_string_array(parent, "supplied-from",
> +						(const char **)psy->supplied_from,
> +						nval);
> +	if (ret < 0)
> +		return ret;
> +
> +	psy->num_supplies = nval;
> +
> +	return 0;
> +}
> +
>  #ifdef CONFIG_OF
>  static int __power_supply_populate_supplied_from(struct power_supply *epsy,
>  						 void *data)
> @@ -262,19 +291,22 @@ static int power_supply_find_supply_from_fwnode(struct fwnode_handle *supply_nod
>  static int power_supply_check_supplies(struct power_supply *psy)
>  {
>  	struct fwnode_handle *np;
> -	int cnt = 0;
> +	int cnt = 0, ret;
>  
>  	/* If there is already a list honor it */
>  	if (psy->supplied_from && psy->num_supplies > 0)
>  		return 0;
>  
> +	/* Check for the name-based "supplied-from" device property first. */
> +	ret = power_supply_check_supplies_by_name(psy);
> +	if (ret || psy->num_supplies)
> +		return ret;
> +
>  	/* No device node found, nothing to do */
>  	if (!psy->dev.fwnode)
>  		return 0;
>  
>  	do {
> -		int ret;
> -
>  		np = fwnode_find_reference(psy->dev.fwnode, "power-supplies", cnt++);
>  		if (IS_ERR(np))
>  			break;
> @@ -304,28 +336,7 @@ static int power_supply_check_supplies(struct power_supply *psy)
>  #else
>  static int power_supply_check_supplies(struct power_supply *psy)
>  {
> -	int nval, ret;
> -
> -	if (!psy->dev.parent)
> -		return 0;
> -
> -	nval = device_property_string_array_count(psy->dev.parent, "supplied-from");
> -	if (nval <= 0)
> -		return 0;
> -
> -	psy->supplied_from = devm_kmalloc_array(&psy->dev, nval,
> -						sizeof(char *), GFP_KERNEL);
> -	if (!psy->supplied_from)
> -		return -ENOMEM;
> -
> -	ret = device_property_read_string_array(psy->dev.parent,
> -		"supplied-from", (const char **)psy->supplied_from, nval);
> -	if (ret < 0)
> -		return ret;
> -
> -	psy->num_supplies = nval;
> -
> -	return 0;
> +	return power_supply_check_supplies_by_name(psy);
>  }
>  #endif
>  

