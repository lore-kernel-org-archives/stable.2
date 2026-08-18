Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2840542E8FA;
	Tue, 18 Aug 2026 17:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787075046; cv=none; b=oimYqbh+IHUhuDR66iVS9b7qbqxbCHvjJSaZooy3WXvS/PFGc49C9xTYe13ajOp1Qcle1N8Dso5tA3rvVkdFMQd55fsQbZ5+8gjVkvfL0yS3E7uA9orVEcIQHkrXsicJNDj6zeRIsp8NOskM2AopBSPnv3+hVoWkoLcxr2BfVAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787075046; c=relaxed/simple;
	bh=98104+qlk82T/fZ20I7oOz2sxkvy0a2ES8hMfagpv6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tgN2jF827HdH+Oar9FQ/ENHUoRfZdGkgNhCuSHdkm5hck0HTTUkRJ9k7XgQ9ar7eUYGX9d+mTM7M/jWqQwFiS48W5lY7cvy2cO6q9AprrFsF7Z+p3vmxg9TzFVlcnMH3smU0OL/VgLBG4MVi8TA/seQA+cVOCtg50UazOrSuajU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=Py7B5Mc+; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="Py7B5Mc+"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CAC1211C3FF;
	Tue, 18 Aug 2026 19:43:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1787075038;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=EMhd+4IY5p7flR11T1qJvwQPGPiAzM3TNIUrDNpuxGo=;
	b=Py7B5Mc+YKnKOuzQhWPGzJjLgphjXgrXJNNmn/dZsLb1dC9+ANNBKcyAfCMlGMRf2BoSPS
	zsHGT10SPz2TpbW9mZsTuxaNn1bPSX/SyHv2p08554qwe6R2ToXhC2yPVzybr8a8L701Zl
	WcoPeM1WtGYcT6NJJLyZ8c/hAN8fQjC2puN74SmtuHCfwOSeVtV3BXhtHlk/GtX121qdKY
	XtY7vpkWMxz3ZAIE6O/Rt2nLhj4Mad6I0cMWTdiGfUq3UR/24Yqz5iLqBHON3j3wyaT+gH
	AM5wy5up3/iDu5UisCUPaWONfCdiaZYhHRM36G8AWZl+8cN1Eq8biEJtfQWsnw==
Message-ID: <71fca17d-9b6b-4c9d-b595-ebd1dc6605de@nabladev.com>
Date: Tue, 18 Aug 2026 19:43:54 +0200
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
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <1aeaa585-79f2-4f43-87b1-2ae3925b176c@oldschoolsolutions.biz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

On 8/18/26 7:05 PM, Jens Glathe wrote:
> Hi Marek,
> 
> On 8/18/26 18:56, Marek Vasut wrote:
>> Hello Sebastian,
> [...]
>> Could you revert f576c75f95a5 ("Revert "usb: typec: mux: avoid 
>> duplicated mux switches"") and apply the following patch (equivalent 
>> to this patch, applies to mux instead of switch) and see if that fixes 
>> the T14s for you too then ? If yes, than, I think this might be the 
>> proper fix rather than the revert:
>>
>> diff --git a/drivers/usb/typec/mux.c b/drivers/usb/typec/mux.c
>> index 4a4297f15aad3..afa6fc1813978 100644
>> --- a/drivers/usb/typec/mux.c
>> +++ b/drivers/usb/typec/mux.c
>> @@ -294,6 +294,8 @@ static void *typec_mux_match(const struct 
>> fwnode_handle *fwnode,
>>
>>         dev = class_find_device(&typec_mux_class, NULL, fwnode,
>>                                 mux_fwnode_match);
>> +       if (!dev)
>> +               return ERR_PTR(-EPROBE_DEFER);
>>
>>         /* Skip duplicates */
>>         for (i = 0; i < TYPEC_MUX_MAX_DEVS; i++)
>> @@ -303,7 +305,7 @@ static void *typec_mux_match(const struct 
>> fwnode_handle *fwnode,
>>                 }
>>
>>
>> -       return dev ? to_typec_mux_dev(dev) : ERR_PTR(-EPROBE_DEFER);
>> +       return to_typec_mux_dev(dev);
>>  }
>>
>>  /**
> 
> I will test that one with the f576c75f95a5 reverted on the x1p and 
> sc8280xp boxes I have here, let's see. T14s G6 shouldn't be affected 
> either way.
> 
> with best regards
Thank you
