Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795109699;
	b=Jhf8JzbOlNHkfut0im6cgzFuEzZoc3WzL+y0zsdnl2gERMzZ6P3N7Cp8IFtMPtzR26IS
	 tNj4Paspw4WooYZRtbqxu8ZBt9pFoTyOZ8eM6CQUWLfWkTB2t8ZrasbGJS6liAAwnmWIP
	 EYD3zbEzHIn61uyfhdDfVm7hBPPEem7EcpmHeW5r/0eVnrFFUFnHuS6uk7AkdjFJ9gFw+
	 +r7n0HI7KtouIdxmcZCAd8rEB/max/iCYxm7y4FVWX5W2R2Lsa5gkpRtYOa+Lxk9sicXy
	 2k9fWsrer5dRmL+CFRKRgkU3IL77D8gxgtsuTFjToBgJe9XltBfZwgyZ3Go2phsfBbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795109699;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=pUe7Cauio3kuSaX15adEICjgI/ZIpaDdez4Kq8ndzxs=;
	b=CPjYm+UdAHojQE64aLX0A8yctv4/nKIBDKBYLRsxDlE43FKCaBw4HFejezr2sN0CAb9J
	 8gl42ZtvBOncknK0qRLK2YM2IBqOw/oTAhVnWJ1zlw+FZJ8DYfI+OUlJAEukVGPKc2Wqh
	 8oD2RmQsHa8OD/DXK38B7uON5Ep9Y2upKL7L4UX4cFqheu4CXUYLE+Apc2+XwAzZJHZ3M
	 5HVffx0MpWZ7Gassre787om53pjJuyg6ATgq5L92ggXxflcZwT1vAYyUjw6U3TfKwHQVC
	 0g2TW7wUq/fbVDaaTFlGh3sRPhHlaRVpnDsRIY89UT4zJdA1wWqQEUaiDQu58Bqbh/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iytl1WhT;
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78853606A336;
	Thu, 19 Nov 2026 17:34:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78853606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iytl1WhT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795109699; x=1826645699;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wviInOxuPujIHqoMOsQsIqdeInILieeCfv7A24yWu8A=;
  b=iytl1WhTE+fAwDHQFQS8RugIb0iDAaNYZjYCiiYz0LpRpYqaPwX6d4t2
   6mYwqlT/vxYai+foTzVb4pca4FANxp9pzZsNK2wmJAAOcLcHomVe48zZz
   0Ka/xwLoC1hcq+ES1NMc8Rfmg12BXgSIyiwhqG1eujY1DCRZOXN5rcIc3
   klbxsfW8wx6l135P6VrclV28IQeQ27U7B5EQOvesLRN98/9XkXZCN4slX
   ll61bTKPXNQIuWToP1CBMIcE7GK3UyicKSDWdjmklmXo9ngJ7jaQfIzkp
   Xv+APmCDQh10RV0NIPA0BYbM9oRY2zKpHTZRe8TGGV/bNuBrChtJE9kUE
   g==;
X-CSE-ConnectionGUID: vLki4RpzS9+fvTbnKHDdCg==
X-CSE-MsgGUID: H1hSg0hvTaeQi/zUkOKHzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="4002674"
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="4002674"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 09:30:41 -0800
X-CSE-ConnectionGUID: mlLKdp9XTtO2Ff/lIx2eUA==
X-CSE-MsgGUID: /cSml+dtT9iZ3dDg5xcF6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="10850058"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.61])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 09:30:38 -0800
Date: Thu, 19 Nov 2026 19:30:35 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Lee Jones <lee@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
	linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 07/10] iio: adc: qcom-spmi-adc5-gen3: Free TM auxiliary
 device wrapper in release callback
Message-ID: <av8yO-0PUvvGsQgt@ashevche-desk.local>
References: <20261119153151.1397003-1-lee@kernel.org>
 <20261119153151.1397003-8-lee@kernel.org>
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
In-Reply-To: <20261119153151.1397003-8-lee@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 19, 2026 at 03:30:40PM +0000, Lee Jones wrote:
> struct tm5_aux_dev_wrapper embeds a reference-counted struct
> auxiliary_device, whose memory must be released from its dev.release
> callback once the final device reference is dropped.
> 
> Allocating the wrapper with devm_kzalloc_obj() on the parent ADC device
> and providing an empty adc5_gen3_aux_device_release() causes parent
> devres teardown to free the wrapper immediately after
> auxiliary_device_uninit(), even if external references to the embedded
> struct device are still held.
> 
> Allocate the wrapper with kzalloc_obj(), release it from
> adc5_gen3_aux_device_release(), and unwind cleanly on early error paths
> in adc5_gen3_add_aux_tm_device().

...

>  #include <linux/platform_device.h>
>  #include <linux/property.h>
>  #include <linux/regmap.h>
> +#include <linux/slab.h>
>  #include <linux/types.h>
>  #include <linux/unaligned.h>

> +static void adc5_gen3_aux_device_release(struct device *dev)
> +{
> +	struct tm5_aux_dev_wrapper *aux_device =
> +		container_of(dev, struct tm5_aux_dev_wrapper, aux_dev.dev);

container_of() is also in a separate header, id est container_of.h.

> +	kfree(aux_device);
> +}

...

>  	ret = auxiliary_device_add(&aux_device->aux_dev);
> -	if (ret)
> +	if (ret) {
> +		devm_release_action(adc->dev, adc5_gen3_uninit_aux,
> +				    &aux_device->aux_dev);

Oh, this is interesting... Usually the release devm_*() calls point
to a misdesign somewhere. But I haven't checked the twisted flow of
this code.

>  		return ret;
> +	}
> +
>  	ret = devm_add_action_or_reset(adc->dev, adc5_gen3_delete_aux,
>  				       &aux_device->aux_dev);
> -	if (ret)
> +	if (ret) {
> +		devm_release_action(adc->dev, adc5_gen3_uninit_aux,
> +				    &aux_device->aux_dev);
>  		return ret;
> +	}

-- 
With Best Regards,
Andy Shevchenko


