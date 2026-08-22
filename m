Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6179E242D67;
	Sat, 22 Aug 2026 07:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787383657; cv=none; b=B6ntIbk62O0WbpMfBPOkQfeLBx1sXc2eGW9vLFUkTwIS+ddjdTJEPS6QXP65EyJu0zKIkVfM8TGBOwxU/2YgW3FnZ5aHDbMnWHb9izMh1N8e3R7aGn7uMtaFVjyxq3ru97YEhA8hUG0OqbETMjhSHFmCXtR1ibht90p+FsyWYGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787383657; c=relaxed/simple;
	bh=bZ+8K8moF/xhkQZUa9W7qKgwkPBkm6VkpbP9ct4r2zA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mus8U3y2B6f1znqLz8/7thIJopS5A73v+cHjFbSUhgA/ndVZhhVLwQVTjxezl47QnjQiNJFUPxl9Ht4qQVZUy589JNniTX0+wSsFVIHSszIddxl+i7mG14rOwvu4BpddqXrCHtWADuUGkuqYW13XiGuVm+CIQq5eg2tPw14oTME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=kRhkf5A9; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="kRhkf5A9"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EF14B11BFED;
	Sat, 22 Aug 2026 09:27:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1787383650;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=VI7q7G8yrGn302joTFqpsFX5cLv1APrnDTVCO6Dyevc=;
	b=kRhkf5A9Q83jInKZJ4Cix9tqR3Axh0+2WtZ8dtJSNTUxb7kSUUqy/YQbKDa8i6pYgnqL02
	r3VflU7/b5DysF7CgFfgMCNcoKwnRmXwVMh/NKYUKdmVjhJjqJLBXOyHbxsEj6PKtRu8MV
	yKpRKGTxQGIp1A2dmxlq8XyY2Zxg2Xx/8kU4vlNWnhMuSQydeoVDUofhFHodDksDOi9Jwe
	Ceu8Z2iZ2CbsFkXUQdxf2HrWAZS1NQ33m4S8UX9saa31zS5VHgOsFRKkaL8r3gQOudt+eB
	m4Hob3h8qP+yLnuhbPFOCyaCcFqbCaJYsEmfZjoQNJ/D4eYBLpIK0nRvRzc4Bg==
Message-ID: <cb989d6a-19e6-47f9-b656-9790c19ad875@nabladev.com>
Date: Sat, 22 Aug 2026 09:27:28 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: typec: mux: Fix typec_switch_match()
To: Jens Glathe <jens.glathe@oldschoolsolutions.biz>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: linux-usb@vger.kernel.org, stable@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 kernel@dh-electronics.com, linux-kernel@vger.kernel.org
References: <20260817182302.146546-1-marex@nabladev.com>
 <aoSFjbydIiu4KyW0@venus> <dfac3134-920e-498e-a59b-720a6c51b82a@nabladev.com>
 <1aeaa585-79f2-4f43-87b1-2ae3925b176c@oldschoolsolutions.biz>
 <71fca17d-9b6b-4c9d-b595-ebd1dc6605de@nabladev.com>
 <8bdf6062-8ec2-4c30-8463-0368d3a0f1ce@oldschoolsolutions.biz>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <8bdf6062-8ec2-4c30-8463-0368d3a0f1ce@oldschoolsolutions.biz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

On 8/21/26 9:20 PM, Jens Glathe wrote:

Hello Jens,

>>> I will test that one with the f576c75f95a5 reverted on the x1p and 
>>> sc8280xp boxes I have here, let's see. T14s G6 shouldn't be affected 
>>> either way.
>>>
>>> with best regards
>> Thank you
> 
> I did the test: switch patch, revert f576c75f95a5, mux patch. Afterwards 
> let it run on the zoo here... ps883x devices are unaffected and work 
> well, and your proposed mux patch appears to fix the problem with the 
> gpio-sbu-mux, too. So it would be a good idea to do this instead of 
> f576c75f95a5.
> 
> Tested on:
> 
> Lenovo IdeaCeentre mini 01q8x10 (ps8833)
> 
> Lenovo Thinkpad T14s G6 21N1 (ps8830)
> 
> Lenovo Ideapad Slim5 14q8x9 (gpio mux)
> 
> Lenovo Ideapad 5 2in1 14q8x9 (gpio mux)
> 
> Microsoft Windows Dev Kit 2023 (sc8280xp, gpio mux)
> 
> Tested-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
Thank you for testing , I have submitted:

https://lore.kernel.org/linux-usb/20260822072556.490594-1-marex@nabladev.com/
