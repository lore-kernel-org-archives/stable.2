Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794919302;
	b=pM225Wz9o12zx0A28WbOHJxpKQj53zUo/D7Jhi0xoW2NX8NBGHKoe7Xjrd303h1ykH1O
	 SDaRQyN0Ik+0NqT2d+JsZLUrB3S37FNmE0yVBPh6cUHWq/9vnWzVXlnJ2aWL6E5sPN/Zu
	 0xKs+3fLk1KuoRyvAM4GPCi6o+GDGFcEDGi898KSdQ7lvmyMaR/QumnMY7ru5wnbkk9wJ
	 JMVaWiTVY78mtwMQmDKJ3/4agw+JiQHBfEWCLPuSICb13iccjaBbO4tqJgH9/kURw8wHq
	 FBrKmfmORcfJLQxmnl9q53rRU6HG6o9q3p3upvdbizC3EkO0WY4BP2Ed3Sk+/7a4DqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794919302;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=1IVyeO+1a+UEoUFAEeGyg3wRuHKRPD8XKIf5x8LdRDw=;
	b=Qjg5iAXhsvvCf7Fv2wkDjm4qvAZWZwyuvIpazX8TM8KC/pLsqTcLiRS+4c39p1USl0Cj
	 LEv30s+/9tHUcF8mGMlzIZeRQE415qdRER0r5nWGni3DM8B0/v3XR+QqqRGsVesZT21Gu
	 owTM1t55GQDrIbnTI5Ma95p+pldlSE354V58Yhrheh/2vaPYwmlAun0Fx7sCkcWo171sf
	 2azzxmEMRmEAZm0G9EeFKOQV4cPsl1gfBFloUcXuvAG/JPH8gTc45BBrjrwN2XczxcfZ+
	 xm/b2GzIUiC+Mzo24EiLpDYdfoW4rxpsJvWbAwobR6arwd6eLdLGPMamJkgj3cO7UkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=B1ZOLUMx;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E1C606A31C
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 12:41:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16E1C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=B1ZOLUMx
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1a8cc11ac42so4835364c88.0
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 04:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1794919300; x=1795524100; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1IVyeO+1a+UEoUFAEeGyg3wRuHKRPD8XKIf5x8LdRDw=;
        b=B1ZOLUMxRIQZ2omsvrNF32Ingzg0YF2gYszNc0e2KYCrqOj6iVmyJ6iIU1g388D4p/
         z0zy1b+Bj9J9P5i6YnErrDZw31LzTqD2vzzej0jW0OZMSpa/v0HGRUNFDlosjnFTQf01
         f7iot5v7pqmRJaOrfqYr1CAVVFhflVoUySmNjCoUvMGwvxU0za16ejM3/azCNgaSoiHK
         xTsG2j4+4jofok2FMF7EXnkpQQICizxEguByn+vbl2oLh3UDshu9+7yOQ/bGzSP6FtT7
         3TOqvKnxLq7cIP/Kw8l5V+rPKmsE/mi9ltds7bjkbyKXroy5nZ01mI+ZBatQd3tBIp3k
         ZR9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794919300; x=1795524100;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1IVyeO+1a+UEoUFAEeGyg3wRuHKRPD8XKIf5x8LdRDw=;
        b=mOEijCakDUkcDDUJys/Gzd4KPqQlkguI9DXJjD6POCcIRgdmE0Jk7s2CAUd6KC6Krf
         Ienjcaj8KnMh0rPsv4TgoJZNBOycmVR5orGYAYHKZu5sFJPbm/6EpvBALOdlelWa/urf
         OCqN+m6fiHSReyLFyiYw4mbg8an4um3GDLLSPIBKWwZIgFK3GyerDXKPIKm9u2UtFvIi
         u9/GdeEbXTlhJKck0mDlWlI0jCEpDCLmsqZ2C31oO4MTENlOsUh0844mXKi7NTSpuf1L
         0qk2hvKlURir36Hf6jsg32UkksBYjkQbD6uPi30ocqCFnQnjJ0sE3DwRTllT6l/MMNCE
         Ujog==
X-Forwarded-Encrypted: i=1; AL+hErE7659p7vUc+J9ezWIMgG2k1/92gELZSv6ogjTbJ5lpNN0JZU30GrV9KvHEeuZVg6PrcuYlXG8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/XgZj9IfLZo+x+dsT4Q2grVS3E7OQAFv9FQdfly88qpwQ0MWCm
	JE79/y2zKq8zt1mlfio5fka5fDHoViDXJwUvkr5gc4phBMZA1HKSxuvQw9e6/zpblqw=
X-Gm-Gg: AYBFou3Ja+DWLby39uSwOur4xgV98Lakfqe10pxlAQpdaRZE7J5Rx0ALkch3ixAb31h
	hluzO9XW2ysEMQ0L6raO8ThjM30fJjEF09bjGRC9F41ZIEixp46FuOE+OO+0kCAa7XS7AX6nSgw
	YXjJKWZFfRcUzPMSifnzARIJta8sK/tGleUCSJMp5mFaT3jyq8zC1JIUe8L3qyE46VNaMP8evHR
	PNgJ5fv7a4xEu07duAN7rZCQ06DAN13A2gOQ9xwWguiUvk3+CeXsE4gR+z0jPS6XsFI2pc3cT2J
	TkRplk5j4qh7yi0vgCiYelKUpzgd7uGpmCCKlTe86x8x0R2yk+hY00374DBpnenLa6I3c9AnTpy
	FcB7j6rAhBXmE4vFuyj2VdnInwpIVf51O14SUXiUVUTG5HhOH0QQS3CGF/gpSEpeH67HmTR0986
	rfguzThbfzq9KDa0UxRkOA4YRGAEz/aK2yXg7NkdnBMDH2UoaxGAL485KRiOJdoySobKU1U1pyx
	iHJOVLhXXU21/BiB/fYh9jQcnNRx9M0VEK+EW25ez1tWrNugv3lNnK9PU3Z1usdue1oZK2rl5Nc
	7Y5V2QS6hIl74DoNS5A0c1Te91Mi+8VbttZgvchYB0syykV7VqDj0uLkTFvQ4o2euvhN4exTOjy
	7M0bYStyyfOT2vNucgQ4F2ON/oviGKACrN3ZF68zQBgutcqQCxsklIBYH55Ww4X0wvHIP6w==
X-Received: by 2002:a05:7022:3f0b:b0:1b5:58e:b544 with SMTP id a92af1059eb24-1b5058eb8a5mr12673146c88.18.1794919300160;
        Tue, 17 Nov 2026 04:41:40 -0800 (PST)
Received: from [192.168.1.142] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50319d40asm41932955c88.11.2026.11.17.04.41.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2026 04:41:39 -0800 (PST)
Message-ID: <1baa1686-1dc7-4df6-b61e-e43cd5de110b@kernel.dk>
Date: Tue, 17 Nov 2026 05:41:39 -0700
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: io_uring/eventfd: registered eventfd signals only once after the
 cd305ee3633a backport (6.18.y, 6.12.y, Ubuntu 26.04)
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
 Yufan Chen <yufan.chen@linux.dev>, dev@rebasedinc.com
References: <oMhla8VwCWoihfrmgn8znIy60W1QXI8g_v2OyB9i6sWESIDlVJlwoGGOLylJgIHRARNoieXUVRGqzeB__KvHMdXgnCfPPovs8vLMOzaMPEw=@rebasedinc.com>
 <draft-agent5-0001-re-eventfd-signal@kernel.org>
 <5d92861f-9a4d-4810-8700-b9e457ed9c86@kernel.dk>
 <2026111605-deskbound-clobber-a4a1@gregkh>
 <07947062-2974-4630-90db-1556e25b50bb@kernel.dk>
 <2026111722-unfocused-ride-065c@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2026111722-unfocused-ride-065c@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/17/26 12:42 AM, Greg Kroah-Hartman wrote:
> On Mon, Nov 16, 2026 at 07:21:38PM -0700, Jens Axboe wrote:
>> On 11/16/26 2:52 AM, Greg Kroah-Hartman wrote:
>>> On Sat, Nov 14, 2026 at 11:12:40AM -0700, Jens Axboe wrote:
>>>> On 11/14/26 10:42 AM, Sasha Levin wrote:
>>>>> On 2026-11-13, dev@rebasedinc.com wrote:
>>>>>> If this is correct, a backport of 04fe9aeb4f3c to 6.18.y and 6.12.y looks like the right fix; it keeps the CVE-2026-80920 fix in place.
>>>>>
>>>>> Queued for 6.18 and 6.12, thanks.
>>>>
>>>> Yet another bs CVE - Greg, please invalidate this one too, it's NOT CVE material.
>>>> Getting a little tired of chasing these.
>>>
>>> Now rejected, sorry about that.
>>
>> Not sure how we improve on that, it's really annoying to catch these bogus
>> ones after the fact?
> 
> How about we make the "rule" that we don't assign any kernel CVEs to
> io_uring things unless you ask for us to?  We do this already with the
> xen portions of the kernel, but it requires you to remember to ask us
> for an id "manually" if you want one.
> 
> Or any other ideas?

That'd probably work. I do the stable patch series anyway, could note it
in there if a CVE should be assigned. It's a better idea than the one I
had, which was to note it as a tag or avoid CC'ing stable on patches as
the latter seems to be a key criteria for you guys.

-- 
Jens Axboe
