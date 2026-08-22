Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2EF38AC78;
	Sat, 22 Aug 2026 08:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787386003; cv=none; b=YBJpTFdtobCY8FpXmh0Q+1FmiW6vBh7uD2xMCvlM+TIOJZq6736c0IA9pOBiQkNGxykBrYt65evKlfWRLcwHhZ1dHPNBH7aLTbmKq1/tc5zqoEXc5i5kQ+pe/cYqh0Z8dV2mnAxgTGJ83CJvmgiYLamedS3k8OqCA4T3nFMFIHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787386003; c=relaxed/simple;
	bh=6ClyeeOBoL6+kFHFMqy1AFNbQvMMepYkuXuRBkyJL54=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fU2A3eCqxPCjTTXuBaCL7y+m8rVnekI/CjmR3jUKgD6uVq4oUf22QzMCRoCufzZW3KPjjJ3cvg3l3iUKFVW3SieKLQatJVGsAUfgfS1u3pWsy1SU3M3QAsOH+2NE7mekCvi+x1jc9+Q2cHnAA2KG5OQ/yShW14Yi5gbjNSnaGNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=g+MhuVhV; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="g+MhuVhV"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 69245118FDF;
	Sat, 22 Aug 2026 10:06:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1787385995;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=jCwh8xNxdzRiIF4fIfO5lO+8y8fSkbAZsHzuhzc4330=;
	b=g+MhuVhVf1YfhIjLCZgDsWM9rFrQH8ihTRGK5615Z/lCio+JL1tXMdBOL2qjaexVa1r60P
	q4Jo66Tvp9/lg5W6sMgD8VkkyN9JO7srePls/Bkp2kxedo2Q2Q+jUaE9iWhQNmGmZ4Z4vB
	rNwW7d7SzqupE2niUTOVeKqDaz8DHRx4KhY4MeZhoEtNUJTpYVeaFy3qObSe7LQXc0SMeX
	KYqLfKQlfutP4pJlTlWwK+kwXOXnqouiKa97HDD/dWksFxhGl+Ojnd13F5dImxvNWTdAhN
	4Eb1AZd7RlcSo86FxhpRvSYXpF01oLkaS1U9pfLBMxoT833mhJzgkCuD8FwfkA==
Message-ID: <472aba70-5216-46d0-8b9a-0a322d1d968e@nabladev.com>
Date: Sat, 22 Aug 2026 10:06:31 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: typec: mux: avoid duplicated mux switches
To: Jens Glathe <jens.glathe@oldschoolsolutions.biz>,
 linux-usb@vger.kernel.org
Cc: stable@vger.kernel.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 kernel@dh-electronics.com, linux-kernel@vger.kernel.org
References: <20260822072556.490594-1-marex@nabladev.com>
 <ef89a8ba-af41-425a-90e5-77061fec3f9f@oldschoolsolutions.biz>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <ef89a8ba-af41-425a-90e5-77061fec3f9f@oldschoolsolutions.biz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 8/22/26 9:47 AM, Jens Glathe wrote:

Hello Jens,

> On 8/22/26 09:24, Marek Vasut wrote:
>> This is a re-application of b145c3f29d62 ("usb: typec: mux: avoid
>> duplicated mux switches"), with fix derived from usb: typec: mux:
>> Fix typec_switch_match() .
>>
>> Fixes: f576c75f95a5 ("Revert "usb: typec: mux: avoid duplicated mux 
>> switches"")
>> - Extensive test by Jens https://lore.kernel.org/ 
>> all/8bdf6062-8ec2-4c30-8463-0368d3a0f1ce@oldschoolsolutions.biz/
>>
> I applied both patches and compared to my tip of tree, same except for a 
> newline. Also did a test on the Lenovo X13s (sc8280xp, gpio mux). 
> Therefore justified:
> 
> Tested-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
> 
> with best regards

Thank you !

-- 
Best regards,
Marek Vasut
