Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55993D524C
	for <stable@vger.kernel.org>; Fri, 12 Jun 2026 07:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781250053; cv=none; b=a1P7i+Z8aQtiyMiqCi13Be2PsP5TjrAHtCRMcxsUwGUctiZwHtHUQ/mEGsGAFdEsd323ZXOIo7BA4PDmSV6mZaDSrUV7fchQM/pn+82dyExFzj4gjzYUENs+hnMclxcCzr/pLkYoyRQvqXg/SY9oGqssA4otx23YjaIv3LqVPvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781250053; c=relaxed/simple;
	bh=E458aChsyMD9nwqT7Rdg1FYbMYFrBbLT6R4RsmY6vFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MJvj2k0qHFstkpnkLct7hyOoSWXBRyx/cwwkDCJZoSRGnxBfniKI3H3GaDZdzAlJA6z/mr9f4LNSISWrISb4brXej5U2485nU5C9qcaN5/QX/yZp9qs5ZNNGKhCHtmFqPV8R59Sy7myAvyKfYqYMXzOdpUB5ShOUM+8n2THR2XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yxn3dhRB; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yxn3dhRB"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490d1e54b3bso7578205e9.1
        for <stable@vger.kernel.org>; Fri, 12 Jun 2026 00:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781250050; x=1781854850; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E458aChsyMD9nwqT7Rdg1FYbMYFrBbLT6R4RsmY6vFw=;
        b=Yxn3dhRBsnT1BDIFiDy4BUGPvMxnfPrr0LSUYit8ahwevgGGH9cFJFxy4NJVXpN1ul
         FpbfRDtBGTH67Vww8gB7L/sSzFEIUvshYH2WSi+XiNm4197yVX1I2z/frt+s2Xj79jlI
         pdJTjmnxb3AMd2uFngaYtW5iawSfTXzUZwKBAnjkeUtAK+RX4nWUc7+AkHnve9nqV2sZ
         8GX1mvap6BwKHFb81lcoaSQcAjwIUQUj2FE08A6SD15WRH3KzQAN2WVJGokYmOHpZibD
         iHEqKrLZpnX/fyLcfPvJxZ+f+YVyKy2rld9uPSWlVpyQw4oY8HBq/mVL8A4T1Z6Sttf/
         CgkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781250050; x=1781854850;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E458aChsyMD9nwqT7Rdg1FYbMYFrBbLT6R4RsmY6vFw=;
        b=cUhz6oYtQlNAGYIA+J3+6Q4pz2kFMh3sPGcWmnOEqsfU5871595ueeh+S7vcLPFUG3
         oyzEu04Lpe0SO5gKbn1KjHgaevne/40W8gE5zUw/s0QYbRdaABCDbBYGaX+5RIrxphcQ
         JM6tNB81Ykv2GCPM3V9bF1MYiS+l4bkbGACOVhJ97T9BYoPs67MrwwyU7SsKxKPCGmmz
         Bbj3AU9g33S+1xfoLo3Hmja4LpoMGwORXYUkbpMouJGd+2Qwlt5p3VPM7VIMNpeqFovd
         1qEkAWx8e1DdeO5edLXrkW83HokT7XV2K23ab3h/v6DnMj36kYRovD+7H89djjjFXlZX
         aosA==
X-Forwarded-Encrypted: i=1; AFNElJ9EQZxNMdsIs+xsPuRWn7v0/p/r524KLCqmhMLifEKNt3SO44sDd1lET4dgWgKwMZ8CzRxSNow=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrgKpnl0tYl7zlglqSopvzu4jnmTBifidFpPLTW0yDd1/vIhBw
	wkhQMzsdYFozwMaXc6mwhg+dlMb2A/oTA0eyzpV6/WrQfMU77hRF/OmY
X-Gm-Gg: Acq92OGDCL1y0A9pQbLdpq7R4PG0NcyIEx2YYIOZVjUqlW1r7CtwNlvENnGXg2VmAKY
	wQavrN/S17gpiTAhATUiU6XlWP764nBAfREB1BJxLOTtpDz5bmqAQOmN08ph0lnldvcN/NLrH51
	ZWB3Yytdz6zMwq0v8oyRvwB8QdV+FIA+qQs5F895jZ1QVJmJ98X+bOu4mZkUHz9r8VTF0Ld6trl
	wWpXVmEnlf1MJFOzUrrfZOCgNnUXYCNeI/KSVuHHwxSB7l2ibg2aqrjC+lMnRgTJDnpHhPFAEDw
	BPywLpseuKG6JpM1eC5HC88ZY0MX07FA4nHi2wCL9akxgULad8QuyYy1iaMQehK0hYaLs5uCRGu
	+aXGp563J7E8HB+Bym1wUdKFkWBMGPRgUkofV4HDqZqIBMuGsk4isxSYi4O5G+BQPeSkXluO8e6
	ROlghKMQdfhMiKw+BEsXdBha9ZLvsF6DLmo2fgpJpiR+wXiDDYbosuynk1XhxJFuJ20qlElDP4H
	4smzVQsG3V9R9dFAEqu/mw=
X-Received: by 2002:a05:600c:820c:b0:490:958c:46dc with SMTP id 5b1f17b1804b1-490ec4e75d9mr19312995e9.17.1781250050011;
        Fri, 12 Jun 2026 00:40:50 -0700 (PDT)
Received: from ?IPV6:2001:9e8:f11c:fd01:7c4e:1a8f:d89e:b92? ([2001:9e8:f11c:fd01:7c4e:1a8f:d89e:b92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f263950sm3314405f8f.7.2026.06.12.00.40.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2026 00:40:49 -0700 (PDT)
Message-ID: <3b0e7664-aa66-4f1a-b374-7e581f3c6d85@gmail.com>
Date: Fri, 12 Jun 2026 09:40:48 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 1/3] net: sfp: initialize i2c_block_size at
 adapter configure time
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>,
 Simon Horman <horms@kernel.org>, stable@vger.kernel.org
References: <20260528205242.971410-1-jelonek.jonas@gmail.com>
 <20260528205242.971410-2-jelonek.jonas@gmail.com>
 <20260603180607.353551af@kernel.org>
From: Jonas Jelonek <jelonek.jonas@gmail.com>
In-Reply-To: <20260603180607.353551af@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jakub,

On 04.06.26 03:06, Jakub Kicinski wrote:
> On Thu, 28 May 2026 20:52:40 +0000 Jonas Jelonek wrote:
>> sfp->i2c_block_size is only assigned in sfp_sm_mod_probe(), which runs
>> from the state machine timer after SFP_F_PRESENT has been set. Between
>> those two points, sfp_module_eeprom() (the ethtool -m callback) gates
>> only on SFP_F_PRESENT and can be entered with i2c_block_size still at
>> its kzalloc'd value of 0.
>>
>> On a pure-I2C adapter, sfp_i2c_read() then issues an i2c_transfer()
>> with msgs[1].len = 0 inside a loop that subtracts this_len from len
>> each iteration; on adapters that succeed a zero-length read the loop
>> never advances, spinning while holding rtnl_lock.
>>
>> This was previously addressed by initializing i2c_block_size in
>> sfp_alloc() (commit 813c2dd78618), but the initialization was dropped
>> when i2c_block_size was split from i2c_max_block_size.
>>
>> Initialize sfp->i2c_block_size from sfp->i2c_max_block_size in
>> sfp_i2c_configure(), so the field is valid as soon as the adapter is
>> known. sfp_sm_mod_probe() still reassigns it on each module insertion
>> to recover from a per-module clamp to 1 (sfp_id_needs_byte_io).
>>
>> Fixes: 7662abf4db94 ("net: phy: sfp: Add support for SMBus module access")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>
> Thanks for splitting this out.
> This is a fix it needs to take the net/Linus route rather than the
> net-next route. I'll apply just patch 1 and you'll have to repost
> patches 2 and 3 on Friday.

Sorry, missed that and was wondering why they stay deferred ^^.
Will send another version soon.

> In the meantime - AI seems to also be saying something the cap being
> potentially off by 1 in patch 2? We add 1 to the len? Maybe I'm
> misunderstanding..
>
> https://sashiko.dev/#/patchset/20260528205242.971410-2-jelonek.jonas@gmail.com

Yes it probably is. This should only affect the I2C path because it adds
another byte there, SMBus doesn't. In my opinion, this needs a fix in the
I2C write path, alongside properly honoring the cap there.

Should I include that here or leave for another series?

Best,
Jonas

