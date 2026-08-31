Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76843EB7F4
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 12:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788177622; cv=none; b=FEY5AdXJfXjPoxQtuXQY3ij3iEJWWC92o799fOEU5h60UYdPffrdLLMf9V8ktMd1NPDufNWu+RFkP7gNWCsCMVxy8/AACpxvOydckOgMnRzZPY8FfXpqTRbL7ToG3DIu8gJbecwSOiclFtAdRv9ktt8+gtbBwuWB0csD6X5aCPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788177622; c=relaxed/simple;
	bh=QAKFPQLcGmXLGCQ/v69Drq2LUdzVpE5xnlVi5LaZ894=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qsYDaXvZ7V5qsGsBVOqiaywJ6qHyI0rU5cBlItgmWp5nB+cefRAcHGv9xVYDLvU4ppPLolSMydGTG2n6Xr+9SUW7k6B0SL2QF+AzFEcoAQTbwBVOVarOO6P++OKuw2DFzYi3SMci6zAax1idEwB8SAuG+S4YQypNSaRmgmZY3JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=TzNsMd+/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y7tAMPKh; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="TzNsMd+/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y7tAMPKh"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A0FBC14000B4;
	Mon, 31 Aug 2026 08:00:19 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 31 Aug 2026 08:00:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788177619; x=1788264019; bh=inHOnlDXbk
	5vnV6CWpG1G5LN1mHsLfHsWslTyBZ6iO0=; b=TzNsMd+/IGDwEr0TIMCkgiK1V0
	Kc+95Ue+Tee9ocnQ5TUfpa6D7lUMAoW/XXEoGVLKoJ4sZVCzzSE9yVoXf01HZrs3
	/mcHTe8xh7aGGWX1Jdsm0IIHSZs6OSpzAx/AKjEzYdYNobMIICZb9bqS8phZrgRP
	qOgrZwhTFTT/5qvuFVBT4o/0rHe8LImmlTZUfe2air4wjT7HXHVsVPmQ/08FHTpk
	xHtwhh70ImhjnBxEkQYhEL6O0x4wjjam0WAO5aMH9VkgMWfrl8ClKPHCxpdEx8O/
	v4ArX+fqELkAfhig4hBX8Cog8p7ts4YenQeubFuxKXLWGDDqRgbXRVqBf5sQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1788177619; x=1788264019; bh=inHOnlDXbk5vnV6CWpG1G5LN1mHsLfHsWsl
	TyBZ6iO0=; b=Y7tAMPKhawNGl7ay7fWUC7eO3BP/YBvlk/8lICSdDtjSc6UH0vA
	wurucVCeVXlS76SvwR9FizVr77ytR6i0pE5EOU87dnCgh1O1ITXsu+jIFoe0Tabd
	8GVTB9Z7+okcixirGw3ty+ROpSRIdCKv++A9TxMzt3p/Nfagp48BkT8rQgwu1a91
	pTE/kvVy89KhCiecx7l/rtUJ07nPp0dcOuDTv/QCw5hZvX50p9nlelYremXMV8Gb
	xyaaw2AUqH+stGtTI4pPD/IDaURqItN0mzsa+4RZWbLZhPNwB5gsXgweILzk8X+M
	V9houZUKdAIM0z389iZTyaP5nJ/OhL/nPEQ==
X-ME-Sender: <xms:02yVakRslAE4olJ_5ayrvZ1dzBsePGdQ5I6OSAyXFLeQAigerC_UOQ>
    <xme:02yVarxOEEG5s-3Zhb3LPD05sB0gDxRfMxu5JGv5tYw2b0kPj0T5CxiO-iWv6FUEI
    nVDYo6GFIlPH7NTanNpGBqpmZC7C1KYc59io7JPdw0GWsGBvQ>
X-ME-Received: <xmr:02yVaof8PCC1_fL2i_WFYVnOty0LYR4LiLjdE6IIgPdWAdzK_l7vUmxjp_9rFHIE9YemiA7tm8v_UXAzVG7w3Y6qEeX2ZCqVFBcD2GH_dF4>
X-ME-Proxy-Cause: dmFkZTFhVfBTWuOQ6npjf1vVuuHmLT7FWBDRiF/8jJAmU/A0K4FEuLg/9wJ+n0Rf8M3fHY
    tNHD35zP2NIWctth/FG3wtouGKK+dSrUcHcva0256a/skKPRkTQLdEhhV70hMY9PtuNiaL
    bIJ67WtOA3/NRbRXHMgz7Ji7g5gcNBHCfQqZpnm0iLRvOS9LgZwCvHcJ2ZJ6nfxeCjsIlC
    OeWAoRPt03/UzV9u11ldI4mDrYl1Fs7+Vy9OsZ10sqeqaGclFdCy9tv+TUXia4Jcc03ww/
    XGdeE9BV6sSQflPXjLTkqU3EokERRsxVB8CvUfZcIxkoE5uRkDsURdnKpfvLyxKHYpiKaR
    FvMoUroBw5Z/dKC+hpE31GUjpearPTTlR986PpDNBJ29N9GNoNCckk+7XSy5KaFQQazrnF
    JkXlRn1Y7qQrvJ4QAGUYa5BeBtlcutoHlkd4T6zA07O3g3VOCgq2HHQhxz/068cxelaICA
    yc6PheqNizeL/evWSlNRb5Bv2yJAFym/bQ9UmWoT0wpql9ynxX/V/r24WyADcYbR0JX6MI
    8G2fxnW3W6r0S8qx+s2kNseAvKtwu0Ti6atpv5pak9C0AiREcVAg37HElyOiUa0VAs9fY1
    LkhZBuk4Jej8CpC1HrlXAHJvz82S4j9sNm2n5juTlfy3ylkir5ooP1mBMLSQ
X-ME-Proxy: <xmx:02yVamPNBEQUPjqznkqhlzJEuOU1zmeNVCYrOro4-wVH11zYm-LnDQ>
    <xmx:02yVaru1mfoIhFr0zPvSA2ElojTExLrV58_xUWIB5B-eXB_gMeLd8A>
    <xmx:02yVavBC0LFOZCefoeEBNt5PWI43fq_2n7UYeBZdveZBpwkp_mHaQQ>
    <xmx:02yVaib1LS6bAjujq-pAxu2X2WKEQq0cHgOMjRuTolCoOakbIpYnIw>
    <xmx:02yVaimmT5kvkdezxdauY1no9h9XtpPTfjFtx6L6HS6VfCC25yDfaqCS>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 08:00:18 -0400 (EDT)
Date: Mon, 31 Aug 2026 14:00:16 +0200
From: Greg KH <greg@kroah.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jiri Kosina <jkosina@suse.com>
Subject: Re: [PATCH 6.12.y 1/3] HID: input: use __free(kfree) to clean up
 temporary buffers
Message-ID: <2026083112-fabric-dairy-c1f9@gregkh>
References: <2026082542-footpath-citation-4670@gregkh>
 <20260826171955.2266521-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826171955.2266521-1-sashal@kernel.org>

On Wed, Aug 26, 2026 at 01:19:52PM -0400, Sasha Levin wrote:
> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> [ Upstream commit 142068281f5138a9888d488e6911e8d9f7923c15 ]
> 
> The __free() cleanup automatically releases given resource when leaving
> the scope, so use it to make the code less cluttered with error
> handling.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Signed-off-by: Jiri Kosina <jkosina@suse.com>
> Stable-dep-of: d07644524b65 ("HID: input: read battery capacity from its actual report offset")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/hid/hid-input.c | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index c1708caa6b6cc..74d04e5c7f0b7 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -419,23 +419,18 @@ static int hidinput_scale_battery_capacity(struct hid_device *dev,
>  
>  static int hidinput_query_battery_capacity(struct hid_device *dev)
>  {
> -	u8 *buf;
>  	int ret;
>  
> -	buf = kmalloc(4, GFP_KERNEL);
> +	u8 *buf __free(kfree) = kmalloc(4, GFP_KERNEL);
>  	if (!buf)
>  		return -ENOMEM;
>  
>  	ret = hid_hw_raw_request(dev, dev->battery_report_id, buf, 4,
>  				 dev->battery_report_type, HID_REQ_GET_REPORT);
> -	if (ret < 2) {
> -		kfree(buf);
> +	if (ret < 2)
>  		return -ENODATA;
> -	}
>  
> -	ret = hidinput_scale_battery_capacity(dev, buf[1]);
> -	kfree(buf);
> -	return ret;
> +	return hidinput_scale_battery_capacity(dev, buf[1]);
>  }
>  
>  static int hidinput_get_battery_property(struct power_supply *psy,
> @@ -1818,7 +1813,6 @@ static void hidinput_led_worker(struct work_struct *work)
>  	struct hid_report *report;
>  	int ret;
>  	u32 len;
> -	__u8 *buf;
>  
>  	field = hidinput_get_led_field(hid);
>  	if (!field)
> @@ -1845,7 +1839,7 @@ static void hidinput_led_worker(struct work_struct *work)
>  
>  	/* fall back to generic raw-output-report */
>  	len = hid_report_len(report);
> -	buf = hid_alloc_report_buf(report, GFP_KERNEL);
> +	u8 *buf __free(kfree) = hid_alloc_report_buf(report, GFP_KERNEL);
>  	if (!buf)
>  		return;
>  
> @@ -1855,7 +1849,6 @@ static void hidinput_led_worker(struct work_struct *work)
>  	if (ret == -ENOSYS)
>  		hid_hw_raw_request(hid, report->id, buf, len, HID_OUTPUT_REPORT,
>  				HID_REQ_SET_REPORT);
> -	kfree(buf);
>  }
>  
>  static int hidinput_input_event(struct input_dev *dev, unsigned int type,
> -- 
> 2.53.0
> 
> 

Does not apply :(
