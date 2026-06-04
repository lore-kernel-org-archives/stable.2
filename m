Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C1D2253A1
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 06:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780553426; cv=none; b=kxJyBQ5dEUCZA//AqnYPBSmzakb1BrRkmWTT4d6NJsDiqZxOWxDXvmI3Ma2aJ9eUYqbc3uRSYo+3KtV0CAeUupLmLqV9WwremUtAJJ1uV30PcsBpRVx5I1ppGBTzVatNIu2HIKotwTCgxIe/sMArLaUOyayVPZnFJ+PuWqLzCVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780553426; c=relaxed/simple;
	bh=xsJA82lo7Kh1sXZjreIFYhktMqk2GwZ80XBr3G663zc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CSIfvnM9e/7Kln74I9XgF3dm8K9qAJaXWdDeiucQX6Cv5RgpmQGSUIjyUdWrkZSsoP0AxKVipcddSLmv10XDf/q80l4BM5HW4I+5POt2+941NGE9I46mtaK+AOdbMoUxN4rMYktWqz7GJPbIH1JLTGs+gmX9KpoNNXwq+GGU9FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gUfYU9wy; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUfYU9wy"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3965bc493caso2373551fa.2
        for <stable@vger.kernel.org>; Wed, 03 Jun 2026 23:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780553422; x=1781158222; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sBdghs0FuR/LLI8yQxdDDygJHMGNxCssfA8blY7OS7I=;
        b=gUfYU9wyqFXb1H35ncnrP4+rwPQCsIRmvgRazNUTaHyVp8I1GVbbM6YNdN8f3nTVYg
         RctDPmLikr2+yGWYjPbfkKeo0R5t+K6ypSfHz7FuMOaH1s+7KJ4EV8Lp1CRW6+MdOc4x
         gcHN9gtmlUQhe37SXoMWf6u2R3Hyct24/vWXvzkpslc+K2jM6gpH0CTbb+zfKt0v9g1T
         FqMAZaIZL3Q7hx6fZESd6G5Jvpk3RdJCPvERW/6lc9u8ihEdA0cpskulnJbrJidrrvKn
         EVL1vZBIijlcsYsMWScN7qAJILAtQoNvH07g/Mo8f8ytY0gxlKNkOjF0ECp/Jb4Ss8ap
         r9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780553422; x=1781158222;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sBdghs0FuR/LLI8yQxdDDygJHMGNxCssfA8blY7OS7I=;
        b=CXR9fjzPsVTKq1SR/dDc+rYPUNu780upeoM1VO61CpIHW07hheNjgsqe2kzbA5jZ0F
         RJdtcLw+YjImarwTfkBdx/XFgvlokm4zjGl4amIki92BOGe3pz5+bwdUcBtaBC4rpCKo
         kJg9jWQAycs4KdXmcMOtUhC+wCZd0IVM/vLhZMnT/l66lLXz3RHR9Xyn3pdpLjYR7H/h
         i1+vFfl5ZXyaFXtwXcQXw2mMQ0Sj49djzlDsQtLgLCY5GOHGypb6kFTg9OC5d5OWuYmH
         4wMoMbzAxQ9GfQ9B6KfvPKWOElyF7vhMrD55dLjWWlnFtld3fNupjnkDfnJML4N/7/P9
         mGvA==
X-Forwarded-Encrypted: i=1; AFNElJ+By02xKbbR2fQ2AfpL0m/HzU5Y8kMMPEyqkki5zapFMcmNIOoYnwG41yHNrjp3ABchW3vTpoU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOr+atvbFBFUQN0o+YusBtC4o8vSrArheqXLnRF2E5CGPN3l1f
	f+k/m8RCvsQ7ToAKc5mqgkAfOYOi5n6SbMwgGfpweCL8Pjl4JEQb49S+
X-Gm-Gg: Acq92OHRgxh0v8xFQcucwqzxOVevi1PYa1uXomd5OGXaAnMETBh0HaCpEW2VMzZVrGI
	BVUmAzqN4d1TPq9KKPAj8i/LXo0qg368G7lWqioAlYWb1KnXZjSvBR5MvCW4FQroN7r7UikWX0M
	logX8130Js9/8J8+cIMmqtXmekbGmA5zM9FZdOYAqIWYbrlclowarPezXvVRGxBErToBvRPj/Cb
	1eh+lJGLK75ToJ+nZ1+0xjXXNDhbXPSVvxUnC1BeJ/PVDmYoc9Foflsej5i8x3p3EAsadXot78H
	jw2sFhKjGCk5XEBJBMNs3Xw6Lw9b/k6pHFynMyUcoKHGa1cDMfjFmAlbEC5UXDIpnvzHVKKpjfj
	C0cbEBQye56+EBMZzH9omlWzkKDRZFJdordd0Q8heHJ/0V1nj4JkQJmkXTbibSpabhfkobFKDQf
	ooiIAVbW5PEinlXQ5BzsDaDnBbKrVz9D9LJXCZP7wZpWCBcg3CIoSJhLjb8DnlMO52amxa2kzKd
	jt1Jadi3Ss3WuK6+hk=
X-Received: by 2002:a2e:bcc3:0:b0:396:6ef9:ff50 with SMTP id 38308e7fff4ca-396af1b5e68mr22592201fa.5.1780553422137;
        Wed, 03 Jun 2026 23:10:22 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-396ac2ee74asm14260191fa.41.2026.06.03.23.10.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 23:10:21 -0700 (PDT)
Message-ID: <13c0720b-b96c-4bba-a673-0bc4a93ae767@gmail.com>
Date: Thu, 4 Jun 2026 09:10:20 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: pressure: rohm-bm1390: notify trigger on all
 error paths
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Stepan Ionichev
 <sozdayvek@gmail.com>, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260517160801.269-1-sozdayvek@gmail.com>
 <20260518094238.1986-1-sozdayvek@gmail.com>
 <20260518161516.53f21777@jic23-huawei>
 <61d9cec3-6aed-416f-9604-94fe94cb2e3b@gmail.com>
 <20260520120822.351aa58f@jic23-huawei>
 <0d58842a-aa5c-4d12-9435-3264070038cc@gmail.com>
 <aa2c2f98-454d-489c-a652-b8023b0773bf@gmail.com>
 <ah3REJeg8KMB694A@ashevche-desk.local>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <ah3REJeg8KMB694A@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/06/2026 21:36, Andy Shevchenko wrote:
> On Fri, May 29, 2026 at 11:21:40AM +0300, Matti Vaittinen wrote:
>> On 22/05/2026 15:38, Matti Vaittinen wrote:
>>> On 20/05/2026 14:08, Jonathan Cameron wrote:
>>>> On Tue, 19 May 2026 08:48:13 +0300
>>>> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
> ...
> 
>> +#ifdef TEST_FORCE_IRQ_NONE
>> +       /* HACK, return IRQ_NONE and see if IRQ gets disabled */
>> +       if (!(first2 % 1000))
>> +               pr_info("Hack, return IRQ_NONE (%lu th)\n", first2);
> 
> Hint: pr_info_ratelimited() seems better?

Thanks Andy. Yes, I suppose so. It's just that I _really_ rarely need 
ratelimit prints. Hence I don't remember exact form of these print APIs 
without checking for them. And it's easier to add a static counter (as a 
unsafe debug hack) than search for the function signatures ;)

>> +       first2++;
>> +
>> +       return IRQ_NONE;
>> +#else
>>          return IRQ_HANDLED;
>> +#endif
> 


Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
