Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795301160;
	b=vkr9yvvV/+silsSoWNY7u/srd4uhouSGPLs+jBwrZt0d7mol+NRZ3Yq0s2p2OxLL17th
	 4Eqo1vJgsTezWDCjq09sGCt206/e/SMbBv29VjceFxWmGpClAMCmtWCdbg+WBCnX7M8Rb
	 9OnCfgxcUbXBlMn62HsQSxkrYXqsbEL05PYBDUkahIaas8HawbB1r2hpy6fWY913mV+/Y
	 AWKyjBYbZd+uifGUu5K9bcJBIZRqJlo3q+zIWKf+xqUjj2czBD+PXpzloeVs9IC0S1IO1
	 CEspxzly9nnWHZxASlq+3XhjDFzpsS+GQ4xrEkkHzdjdKJHq/qzLxkySzzZuXsBbtig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795301160;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Iet5KsxqR7lo4w20sxi2lRvcSW5Zv0fZrgqupc31uDI=;
	b=cSUjefwq8hr6/h3RYmK1V7Tocu9Qv3z17Yy43sx/5+UUzR3dIMfLs97CLmDJEX3InZOF
	 p5s77vVmMIYMnWXvP1Oj9ZE5rBbj+ByDiiZ4kzNwgMMkzJIyYoSbFjblqK9IjkqHG5yp5
	 DSOgdRasxKDrPVaqlYDAbtbSuPimM7vc1KTMrL6KIrg4dyFg6eioLln1NuB5zpxZVXCaB
	 j/C/S7rA+jjTuK05lIbHq/5EygyD70KK9SVHeq0DQtdiCsO1ZiIK1OWCc5T12kSZ0d+uj
	 gRNU8M0U2YAQ3v3mqSD438AqlSsElHM3t9nfBqitMTL8Y3QnfjJ60+x4LUAxUQr16Qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nFkd+fcH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93963606A320;
	Sat, 21 Nov 2026 22:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nFkd+fcH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3684F1F000C0;
	Sat, 21 Nov 2026 22:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795301160;
	bh=Iet5KsxqR7lo4w20sxi2lRvcSW5Zv0fZrgqupc31uDI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nFkd+fcHoiPs/vTj9LZZk/HKIlT89NRbTDF2vB43ynoerQHzfelsXEC6TTN0PjVP9
	 NDbexOsEK7IBXI3MnXRTVpgWPcd6popjEVzetrLl+7lOETlBQvbslDAdjoR0NsN+b2
	 CeQ5Bu8jr/ua2g/cF/qEJXB/lf7t8HgnHaSkRoarRgV/g+1Pdgurd8zIrGV8FV1c0m
	 4qvw9nYdQOVAHplDYPUcPhNmwcKrVIB5y6IMFEbCAw744aBH2H9EOJxXCH3foq8RPp
	 ssDjm9gObumxd8LGkJVeZlgjrX21KEHXADNN1dU4S/Md8v+qIm7keqqzq06Z7wZwbz
	 IqqOcnQfHwu3w==
Date: Sat, 21 Nov 2026 22:45:55 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Lee Jones
 <lee@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Olivier Moysan
 <olivier.moysan@foss.st.com>, <linux-iio@vger.kernel.org>,
 <linux-stm32@st-md-mailman.stormreply.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH 04/10] iio: adc: stm32-adc: Validate channel index
 before writing chan_name
Message-ID: <20261121224555.55cc8bba@jic23-hlaptop>
In-Reply-To: <11aa41f5-da69-40b0-9b8b-6c5abfbec5f9@foss.st.com>
References: <20261119153151.1397003-1-lee@kernel.org>
	<20261119153151.1397003-5-lee@kernel.org>
	<av8wzmfrU7zLzGmU@ashevche-desk.local>
	<11aa41f5-da69-40b0-9b8b-6c5abfbec5f9@foss.st.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Nov 2026 18:22:26 +0100
Fabrice Gasnier <fabrice.gasnier@foss.st.com> wrote:

> On 11/19/26 18:24, Andy Shevchenko wrote:
> > On Thu, Nov 19, 2026 at 03:30:37PM +0000, Lee Jones wrote:  
> >> stm32_adc_generic_chan_init() reads the child node's reg property into a
> >> signed int and, when the optional label property is present, writes into
> >> adc->chan_name[val] and calls stm32_adc_populate_int_ch() before
> >> checking whether val exceeds adc_info->max_channels.  Because val is
> >> signed, values with the top bit set also become negative and bypass the
> >> upper-bound check altogether.
> >>
> >> Store val as a u32, matching fwnode_property_read_u32(), and move the
> >> max_channels bounds check immediately after reading reg.  
> > 
> > ...
> >   
> >> +		if (val >= adc_info->max_channels)
> >> +			return dev_err_probe(dev, -EINVAL,  
> > 
> > -ECHRNG
> > 
> > However it seems in the original code like this.  
> 
> Hi Lee, Andy
> 
> I've no strong opinion on this remark, whether to change the error code here, and if it belongs to
> this fix ?
> 
> In all case,
> 
> Acked-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Let us not over think it.

Applied.  Given it's hardening against a bad DT, not rushing this one in.
It can wait for the next merge window.


Thanks,

Jonathan

> 
> Best Regards,
> Thanks,
> Fabrice
> >   
> >> +					     "Invalid channel %u\n", val);
> >> +
> >>  		ret = fwnode_property_read_string(child, "label", &name);  
> >   
> 
> 

