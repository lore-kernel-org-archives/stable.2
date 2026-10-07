Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F8B48A2BF
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 12:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791374797; cv=none; b=tdEKxeLuC/Z2tGTM6CMMApY1j1dFy6apuVxvPM1YQJkU2d/jD6/UbHSh/T5EgKsWFUXWQSXqm/KsvrYGHuySTJhI3YtRiwD8TWiAI4o6Me+EuMMUJdqIEamPYQ1COufEU1sAwLuLMM++To3b+rGeNNRaUsmRR+Z2ovs8G7GL6po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791374797; c=relaxed/simple;
	bh=+5lapkpdLk/KoISK51B1PULQVi7EbG6+BD8CNXleIQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bbn2PZA4iwG2mO5rc6lBrLZZizQt8BdhupLMPUNOLIkSGNvDb2e8q7jfXtC5pr+HYnoZEF6GRN9E6v0WC5/GLmwvI3fJDrUbUEzBXfuRItXst+/B+CecfGSdA6q3EgiMlAGN8+R75+hFeKirqMwLPT1N6cSvQbUJowLFJcrqnzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=efcUSzup; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="efcUSzup"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4956869750eso10738685e9.2
        for <stable@vger.kernel.org>; Wed, 07 Oct 2026 05:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791374788; x=1791979588; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fKrkff9S446nTnUhN520RaUv+s+Uyy7xEI8ZLZtr6JE=;
        b=efcUSzupBRXKtfPkTcwQ1U39a3cy6+OfynOLpsrJKsuMFsk16DimSY9wWSNIs6ms32
         XM5aPkCNU4qWtEhTj61iZLZ9cPuqCA13y995e/CtpwjLjeuWseq6x70X+3hwAP4PGHb3
         8wLrrlQvJu7oDOhv1QC6hBiEf2ecfCi9IEuLLLPSpHacRwVytNroR2cT7qsHsR0e2vVL
         txma40xvwHiDmjoAvaqXi4Hmp7rm+uPg+wKGFjWZXsewbJjTUt2B6ydSbozgLgMvYwRg
         XiGmEmIOZCnV4zH/hdEcPRgGehvX0xEfrQJI4R9ZkLPLXjHUqLwgWapCwc+3oOifJIfn
         s88A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791374788; x=1791979588;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fKrkff9S446nTnUhN520RaUv+s+Uyy7xEI8ZLZtr6JE=;
        b=1sIADSgy06mtVvCVMzDGQMw3Mkb+oSDbZSXL/aPqE/5Bbc5FjAAjuBFG6z5Y3dtDoC
         z8cL4/+6r6Sa9gQZcts8pAi/zvyYCnl3Cigr+NM7ePJR176OqzfczdDr50Xa6AeYP46E
         Y/oJNB5oMsJ+/YxA7gMz78ZLrmhvmY2cC5Nw3kc+ifoTdexLFn6ZUYXS43DybaXfhWNU
         dWyIuje4eVkhpZnZPPHZ/6OZysatWczBw98rzoK6pd/8QCAC+RSEVXaSBzLko0v0qiy/
         aW83V4maV/bw5fdQrOHRbA8GZG4SwlCJzEEGP5xh9m3dcwxIQdcFBGao+bYs9c4VxSfE
         2nzA==
X-Gm-Message-State: AFuF++muCKeG0AvUXXzF06PoPl6a9pWHpmTLk0ch/AllMF36Hn7pVur3
	L7WAvTyI0iljpJTqHlhyC6NaBLu8mMouwEep3gecy8z8Ie4AOm/ZqRjD
X-Gm-Gg: AYBFou3efXnElHYIsFoDUHP33vbWg6uE4F+2kCOT/uvKd4z61aTz8vaUXpTxuybTvGF
	ioJBJEYZ92OsVl3dNbvrFWKl0uFWxgzOHLlUOMb7PaavvYe3FOwpjAXVJkhEbExvc27zMrtyY7h
	t9XTp5m07buqCTClHHr0+yIIzKnkPPBQBwOlVOcqsk27YsLNooq903FJjy4opRumcqF0HWz3MXD
	MfsLMEkGB0HnzhVZpMlWWPmOgp3eSbStt7T02I6YsPCm5/fStM31cTt2I62NCW5IGgZ8lWyf+2i
	1ldvXZJC/0v4JvawuJzWtBtYOcKb/cUFaRwjdSojg/2LExuBf8s0EUxaWSWy/xY2Y0PfXupVal6
	idXEWFEBpsK17yoqXPiwNSsEEqMN+aVkNRZ2yQHdup8+OVNpZIzEXiZpBTFQWugs/CrUe1r1Hh1
	osn3XEXhv6oRQOY6/gu92+3OZuaUtGALzVbQadWWOFp2ygBb5LaVYiam/zji1n3SqFBes0Rqfjn
	THlu4bZIu5eV4OVZIQv05mWQNOlZP8=
X-Received: by 2002:a05:600c:c166:b0:49f:ce73:5e94 with SMTP id 5b1f17b1804b1-4a18065ab85mr34300025e9.34.1791374787538;
        Wed, 07 Oct 2026 05:06:27 -0700 (PDT)
Received: from [192.168.147.140] (90-182-211-1.rcp.o2.cz. [90.182.211.1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a17f558028sm74134195e9.10.2026.10.07.05.06.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Oct 2026 05:06:26 -0700 (PDT)
Message-ID: <6f9295f4-3feb-48d3-bf1a-4e9aa3c6a7f7@gmail.com>
Date: Wed, 7 Oct 2026 15:06:25 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] iio: light: rohm-bu27034: Fix infinite
 delay on error" failed to apply to 6.6-stable tree
To: gregkh@linuxfoundation.org, jic23@kernel.org,
 jonathan.cameron@oss.qualcomm.com
Cc: stable@vger.kernel.org
References: <2026100659-encircle-snout-9f76@gregkh>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <2026100659-encircle-snout-9f76@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi dee Ho,

On 06/10/2026 10:47, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.6-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

Ouch. I took a look at this, and I've screwed it up. I wrote and 
upstreamed the first version of this driver for a hardware that was 
later modified (in a non backwards compatible way). Because the original 
hardware was never mass-produced, I decided to just fix the driver to 
work with the new revision of the hardware - but I never added the 
fixes-tag.

I never realized is that the version of the driver that does not work 
with the new, mass produced hardware, went into stable (6.6). As a 
result of my bad decisions, the 6.6 still carries the driver for early 
hardware revision, and does not work with the sensor that is really 
produced.

I see two options to improve. First is to drop the whole driver from the 
6.6 stable. It shouldn't break users because the driver does not work 
with the released hardware.

Second option is to backport all the patches which bring the support for 
released revision of the hardware + the fixes.

I am not sure which makes more sense. The 6.6 EOL is approaching, and I 
kind of hope it is no longer picked as a base for new projects using the 
sensor.

I can proceed with either of the options (send a patch dropping the 
driver from 6.6 stable, or backport all fixes to make it to work with 
the 6.6 stable) - do you think one of the options is better than the other?

Yours,
   -- Matti


-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
