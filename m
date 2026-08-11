Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94BA41D655
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 22:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786488809; cv=none; b=u9FL50G8eapJiunO5NqAGo1k7A/5giSoHDRuzlNh3BkcX0Xvv8LYDzuU71FXW7nDxTVbBPNFU5R5WJ9L1SdeHQrcq2O/ezlKjkck6aV70v18c9G1wndulw739HRo8LjAUHhXEpeWPMy5FRImjc+7uHLHIL3wChRuRGafcK2dEts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786488809; c=relaxed/simple;
	bh=YQ4HAHTxj7qU6tYzGeoF602jIIrwnSrAyak9jpfBM0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uJnknzxwd445sGtivFFXdSBM8PhCXIzaQYCyroU7QBk2uJp2j8SgUTSemHRSJuqgxFtxlum0RXvQupHT+mKTgmBPI0h5YTz6yE4saZrvLTpTBXT6aOjYEXNV1z0j1c+LiRU/YGUuENXmdiPf7UfRfFqxxfVR20DQGSNXIQORWpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GFB4z8s8; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GFB4z8s8"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-4a483a552efso185503b6e.1
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 15:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1786488806; x=1787093606; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QLL9rTiC5SLvih2di+U6KnSJGxV2qGIcYMvCuEbtdHg=;
        b=GFB4z8s8NqXqYjmAJ6ORpacQteJA2ym8BFTZTn8BRm3RLtVRUKBijbN5H+XCrt9XKw
         DkodzQc276FLJamuFjAbYH1UqyfoflCCEWPslIx86vCqPxqwVKnj0y3DPzNTF66vNDQ4
         IJZMBUhqoqwlUKSZ0rs0GeJVKFia7Cdg2VIOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786488806; x=1787093606;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QLL9rTiC5SLvih2di+U6KnSJGxV2qGIcYMvCuEbtdHg=;
        b=Bophy6DcbyOpZo6CwxNHA0JipGQvLPFE94keuXOvebqGSkAz3V3DgpA68IxV/ZskWc
         v/LhXM790wWtMTAmJE7vIEqmkEIiz57ygOCPblE5KDn8eoUAu6+gYP4XXZTWHF2XVp9s
         FMZkBg9lT94Vxzkwk3QaiEKHK7Vw3RjlanCFcUsieuUWBTVO+bLWLbntBwSDrk2Nx2Bi
         UQEL4WiJLig2ZF/wSR8A/AQ0+8uUV/cQMxl+kEiYK7mPOUMp59yVRF/i7cQ17YXN3cIf
         kzbNtoJGQTjPT+a8/Loai5xtUTHgZgUAwb6KP54yL1a0NuKcZ1SNNwQy6uejE0eDWbw5
         8eiA==
X-Forwarded-Encrypted: i=1; AHgh+RrIGAeCfUwz9Xj+8EITjojYVBPyYsDctkbUkPJtuXEQ/aQlo7q8Lf0p0mYu1dUiBpuUq7lH2XA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKLreN5JCIx6+A+yGqPcHCR+bjtTvnrotFkm3GsjSgyU7GYRII
	X8BjC6aoSrNPb/jtU/TE5AhSgAtoTtOYv5Zb+zXNWHUZjdJ2H5hoFTstp6mMEpb3eaLVM5UW+GX
	vlw71E2s=
X-Gm-Gg: AR+sD13wXILG/b48OFc0A4oVOe7nkkn2e7YxMQmNfVP6ejTQ2kX400hLxB2KYBu7SLL
	sEjkfcIkTYHtLEbYLalofgpreG6nZON1HapF9hgkZOaqPw+oOGXtUCXfWiwn1VdRltvRobH1lIZ
	/UWuOktDh1WdWPTP1b94EREMOeMElwMeofBwkywVAHXK9+T1SEsQ6OFQFH4S3/Q2O6qLjqtgAWj
	7+docNhnEE343+/pImurfZqLZfuzifUiiaxPVyVODUQl0JjbXp0lpNH/Pg5RgHG6GfcJPJ3HFcx
	ZBJPcyN2Y3H+XN6R9LK6aGBeaxOzv3l47Ag9gM4lX+1L6N1u2tBZvcyZsu+fEx32EC8kdvORlc6
	Z7OGdcRAgiinQ9YS2wGak7CrtHq/61ixGRSucgwML7jYjG3Bp6LIRQpsg72UuOY2abAUYSlLq5N
	lDRqMzqOKDkIexPuCjgEuCX10Ip2vAwxBHpUii898SrqJBSheda9ip1l8KIqJcfDNf3beocSqPe
	Nb1sOKy
X-Received: by 2002:a05:6808:1385:b0:492:5684:7ab3 with SMTP id 5614622812f47-4b210c6fe4bmr646183b6e.21.1786488806722;
        Tue, 11 Aug 2026 15:53:26 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b20019e83csm1829535b6e.16.2026.08.11.15.53.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 15:53:26 -0700 (PDT)
Message-ID: <e3473010-e995-40b6-9040-e38f51d1a6c9@linuxfoundation.org>
Date: Tue, 11 Aug 2026 16:53:23 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] usbip: usbip_host: remove legacy rebind_store in
 favor of drivers_probe
To: Jeffin Philip <jeffinphilip14@gmail.com>, valentina.manea.m@gmail.com,
 shuah@kernel.org, gregkh@linuxfoundation.org
Cc: i@zenithal.me, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org,
 syzbot+af76b01c9a0f0ab60fb0@syzkaller.appspotmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260811160541.29461-1-jeffinphilip14@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260811160541.29461-1-jeffinphilip14@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/11/26 10:05, Jeffin Philip wrote:
> do_rebind, which sleeps normally gets a mutex lock. However, it does not
> or should I say, cannot check for null udev between spin lock dropped in
> rebind_store and entering do_rebind. This is a potential race window
> already. So, even if we check for null udev under spinlock, we cannot do
> it outside. Regarding do_rebind, it is called during stub_device_rebind,
> but that function is called during module exit when all files are removed.
> So, do_rebind is not designed to work in a concurrent environment in the
> first place.
> 
> We have a safer function that can already do what do_rebind does,
> drivers_probe. So, we use drivers_probe to rebind the device rather than
> use rebind_store.
> 
> usbip tool references this function immediately after the device is unbound,
> which is safe for the tool itself but since we opted for drivers_probe, fix
> it by using drivers_probe rather than rebind_store after unbinding device
> which is more safer.
> 
> Tested and working in both userspace via the tool and manually echoing
> the busid in the related nodes. rebind node is still left active with a
> warning to use drivers_probe upon encountering rebind_store.
> 
> Thanks,
> Jeffin.
> 
> Signed-off-by: Jeffin Philip <jeffinphilip14@gmail.com>
> ---
> Changes in v3:
>   - Removed rebind_store in favor of drivers_probe to eliminate race
>     condition

How did you find this problem? Is this generated code or did you
write it?

Also, the first patch removes code in rebind_store(), replacing it
with a pr_warn()? The second patch points it driver_probe() - what
happens with just the first patch?

Did you run tests to see if you can bind and unbind devices - does the
driver work correctly?

thanks,
-- Shuah
