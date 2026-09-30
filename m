Received: from mail-yx2-f10.google.com (mail-yx2-f10.google.com [74.125.224.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA87236B92C
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 06:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790749864; cv=none; b=bbJmnsp9Q6LDmywL8a8aZBrfahVnH2i1CcBPVnKGn26lzfxHq7ibLbZqzLZoTsKxEBxmaY4yu5mO7ne6ILW3SiI2tBJccgSa+Uoy/wwfkFrMFMnPiJzLk3cBrApf/h94pLc1j9P5FNp4TQ1KuFD/axPWctWIDAaHe7WPg9c5QrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790749864; c=relaxed/simple;
	bh=FHGkLzhPre9IpdvrMB+5TjQJ977mAu9d/fKjQwwxUyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UxRZY8OGDl3IOwRtVia/6rCIoBa89cJqbCZtuNqHK0KCLCa5uO2ncGkd2RL4K2gh87Pl6waI3YA1pPP7drO2BVkuXDIiSU0C01+oSVM9g3ppYjc5MDHAZPKP9xIxzEYfL4F+ocNvgkjh2IOKSyLnSo7FaWHNPETW9USamt54XHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=k1zxuboS; arc=none smtp.client-ip=74.125.224.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="k1zxuboS"
Received: by mail-yx2-f10.google.com with SMTP id 956f58d0204a3-66c711552cbso1959280d50.1
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 23:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1790749849; x=1791354649; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FHGkLzhPre9IpdvrMB+5TjQJ977mAu9d/fKjQwwxUyE=;
        b=k1zxuboSonT9Gw+GNFRAUm4Axs6Xl6c5soEWCfRHHLeZ8ZoQ0c4TOouY5z1AkZrPzv
         hWGl4bKMsozmHq/A0134Xms+gHVwJcATFj5RD8rTP2d/mqvs9R6eotYE8VRG3CC2D85I
         gS8OiLLlC5ka2gxSNg3dceb7DLifyrdio8dk7Wwsm8LOdik+2x0xVGAzXfYr0ukTfR2/
         2lqnRwHyEkvVQY65R1T9paSOQhfGqaQ3h6QQoF4iaiOkcEJM//a26yVQLgiuJaJr9QS5
         blKe829IjZHenWGBS/umnDLhjrHSCCQeJ6kU/w9dDPe9ezIc6V1cwme/04NYdqjNyxdj
         c2zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790749849; x=1791354649;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FHGkLzhPre9IpdvrMB+5TjQJ977mAu9d/fKjQwwxUyE=;
        b=y/Sl8A98rxaliFDg/Dgw4qAXGq/eVQJCD5nyMTrTL+a1qfOtZXkfCcxKSOfsc51wgo
         zSoXzgacKG8ujB0a9VY80knsHD/jreXpkDiAD+aYcaMEmbof8qsdbXrQpWnIfTfhszPH
         RTNZN0uGf5q97s028FOGIS8m9GTTvvfwLoju+xt/ZOV9qLkd5ZA/C4yblYhzCTwyzdza
         d6KPNRWmJcNyd0NNNc/IOf0bIjdiq1Gu9Jf/xxHX8rsK9x5jmyuA7nu2e97dHe38X/g9
         8RZzKSqCF1TgjQ3kXHw+9Hdj8tnK2jMGBc24q34/oSyVCm93FQwnF3zP4XN/c5Hy4RuO
         6OVw==
X-Forwarded-Encrypted: i=1; AKwUvByf5PC/N5KZN4eoq9VsnncM94lW3/+eYcQdgurY49tCuQO4gIgArj/INt9siFxKjd4fAsn46q0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKsxsFJMtC/EM5sRdt8ni+nXf5UlBFZ9jcMGKzRcKVr8LK6/T1/
	v49EFgdHzCkp/SwuvWC2zNtG4UcxYxmvWYzswHMvJfsNr8Wo30RryEV9VD+67RJi6d+I
X-Gm-Gg: AYBFou0uB+Xw83r5gcAWhiy4MbOJ7ivb0QusRJP04IXcDbaN9R0lzNDtSmx7lug0Wr0
	czbKaYXUyLVdxDQ4GCEomAD93R28Zb+HG254/fNi93oy3deVWBV17yCUb/FxW82zS3fhCQm7A5w
	IYL3TeY86+NOtk053owIN4f1+AJOhC7X8JLD6NIuqlxw8S4zqdvUZpw7vCD4sN97WEORcQgmSP/
	SxI2f3GcO8JjOWSU/eX1scw7zdAFwWnbtV8vO3gM7pJmW8O0RVfnL37OqDn3Mn/3WDuHmN7J9WN
	6FRKEk8s14/B/7dd61cQZgr37a7ziHzJrTbdfS43e6xqSjVnuL6Yekqn1eQY9ApfhBH+6BzsDou
	M6Smx9uG0pFTFY6A1VljMW1v9Dml0tfBavkvieUs+uQibT5vZnMR6wmbqi52rNNqVx8LK3MMzA7
	ydWoT1Mdz1Yha76zq1pM8HpSJTgiPyPLAXiqn92v7cE7/sEAf1NbwsIVNChheY6AxhlXVF+Ce62
	kOVpc0fBepg7Jd7/N9uVjWKKN4gMv1oN3GojeMvT5270qrH/D0cwSN33V50BleTQw==
X-Received: by 2002:a05:690e:12c3:b0:675:3606:4890 with SMTP id 956f58d0204a3-6768357a1f9mr260728d50.95.1790749849309;
        Tue, 29 Sep 2026 23:30:49 -0700 (PDT)
Received: from ?IPV6:2600:1700:9d70:10e0:9122:9e60:20a6:c888? ([2600:1700:9d70:10e0:9122:9e60:20a6:c888])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8ac539a916esm2624187b3.29.2026.09.29.23.30.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2026 23:30:48 -0700 (PDT)
Message-ID: <215416db-8e5d-43ba-8569-51c8f221390a@nebusec.ai>
Date: Tue, 29 Sep 2026 23:30:46 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] tpm: reject duplicate PCR banks in
 tpm2_get_pcr_allocation
To: linux-integrity@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
 Jerry Snitselaar <jsnitsel@redhat.com>,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 stable@vger.kernel.org, Ren Wei <weir@nebusec.ai>, xuyq21@lenovo.com,
 Yuqi Xu <xuyuqiabc@gmail.com>, vega@nebusec.ai
References: <cover.1790568982.git.xuyuqiabc@gmail.com>
 <9d27c4513a3c6fc32f9574ba192cd3bfcb2bac98.1790568982.git.xuyuqiabc@gmail.com>
 <arwssp0czGg9XKv7@kernel.org> <arw9CHc4mIOm5C6Q@kernel.org>
 <20260930033300.30295-1-xuyuqiabc@gmail.com>
Content-Language: en-US
From: Yuan Tan <yuant@nebusec.ai>
In-Reply-To: <20260930033300.30295-1-xuyuqiabc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 9/29/26 20:33, Yuqi Xu wrote:

> On Wed, Sep 30, 2026 at 01:34:48AM +0300, Jarkko Sakkinen wrote:
>> No need to resend a new version but I'd need a link to the *report* to
>> retain reported-by tag here.
> https://bugtracker.nebusec.ai/f/675
>
> This is the report. The page requires a sign-in or registration
> before it opens.
>
> Thanks,
> Yuqi Xu

Hi Jarkko,


This bug report comes from our bug tracker[1]. The tracker automatically
collects bug reports from different sources, such as Sashiko and bugs
found by our own tools, and then attempts to generate reproducers to
verify that the reported issues are real rather than LLM hallucinations.

Some maintainers were concerned that some of these bugs could have
security implications, so we currently restrict registration to email
addresses listed in the MAINTAINERS file.

At the moment, we have implemented automatic fix tracking and Sashiko
report collection for the networking subsystem. These features are not
yet available for other subsystems, so if you log in, you may notice
that some bugs in the system have already been fixed upstream.

We'd be happy to provide support if you're interested in using the tracker.

Best,
Yuan

Background about this tracker:
[1] https://lore.kernel.org/all/20260830115546.3942129-1-yuantan098@gmail.com/

<https://lore.kernel.org/all/20260830115546.3942129-1-yuantan098@gmail.com/>

