Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363C9284B2F
	for <stable@vger.kernel.org>; Sun,  2 Aug 2026 04:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785644297; cv=none; b=Z7ZsfFxUMikIN38GEfRXXX5bu8TjjZ3PoepxoVhqt4CBvJHa0qABA6eOl1pZy+QzYFKUtMyW/oHzQ/grmNIpLXC+E4349XC1T8LWM1N0TTjkE0VmM2neozjiJr2s+vNg2Vng+CgHEGbZ8bBXi+QhIAk3G0dsnAXuuXdgR6NQqRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785644297; c=relaxed/simple;
	bh=OPHht/QaC5LMLJuAaOtRtk4acf3QwYJqfe4smkjE5+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZxaJmi/mg3t6Ba+O3+qukw09pDbkTvER/GbF0Vhxw0ARQ6Ud9VPUeqJhd3QIr9k1czg1uhaFu54/K4jOB/ctbsOrlz5e7wtK42KMor6GCAQleLbTRKHQ8TkdFeEK4WVwmxr0o6ZmxRPy4QoY6Ue+d/gPSXqK1khDydYZPJZiGhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=UP/Zlqms; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="UP/Zlqms"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6a168dc590cso1364592eaf.0
        for <stable@vger.kernel.org>; Sat, 01 Aug 2026 21:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1785644294; x=1786249094; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o2Bc+YLzfqIQRe95o8gbpPVNB1RPuOCR1FFv4kyvHGI=;
        b=UP/ZlqmsODjKFUYGGabQPZXnXFLdlT/y1g/KV3svmdgU0pzE6s/8HnQyOCDsjZR6S8
         WOFV68alDSVtPSnHoGTsiiNPDNwOJ6sqqoXX2PrGJnsRqg0EcEs9LacQn1XKjBEulokV
         Lj93Xy6u1cgQVaDJvVDoL2tnCas7nxYLXWkaPejJDClZQHgrIAFjVq1WyfzsDXX87vfu
         daXQUWmrG3JXwyXwau2DqjSyOLbOmJGJX+tQg77S3KuESX4eVE4F4ulzXFLVURspd9v4
         QGYZhF6egksvlW8ReY1rSd+WvwrGkI52UFzxP7BkMqgbPR+OnA4sc2fIVefNI568/JIP
         wMDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785644294; x=1786249094;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o2Bc+YLzfqIQRe95o8gbpPVNB1RPuOCR1FFv4kyvHGI=;
        b=qom6aBiHjnPIYXfzJKaZDUs0Lnw+bPHIm+sdiiHfsvOb9k7Wd94XLTVsVinO92XW7t
         fevn3vNNqSCiIpPc/ifBNyN6679L344vkwGPrprR0+6T7ISSvDR1KjzE7/e1IfYu/OXm
         M/bDqkC2M7nt9g7yO0JVlPJgMbOR1MobUeCrM6eLCCeEV12nfhLKzMB+6XfOfR9ITp4G
         +F7cPZfaJz9y4Uaeexxdx6QEfsuwxqbyDT71A6LPYyMbgTyV6IH5CpUau2JwlBMe9NhS
         0PGJoGX/XfFd/z6u5lAM8pLzeSXZRgHPmrrkD5uWOLTisTBoCHKlH+MZ1ryhhpUQoMr2
         uOqg==
X-Gm-Message-State: AOJu0Ywt+C9ssAfJefOZqzCrfcF8CCC73DtGBjUfmOTZowjLIPwYIy7w
	DGpsiueYrFM/bh9VaKzXUFwetcAoXzD1mLQktfvDosd8OLjm4Smqn2RfFS8UEGW3OMQ=
X-Gm-Gg: AR+sD10b0BNEFEVzgwi5u1Rmh5nNKVI4PmIBg1wyscLlgJhqnDR9Cm2ZWVyryOS9v81
	+yn4QBByz41rqmf0KB12fQe8lhEUv6nuXr2UAWWnRtBzxXnP4RyMnOhfSh6ba0DfYCqbnzzvReT
	2MlEo0XQfNHukb0tSOlAuPeIoymJgyXyPovtDuEOcMP4JdLK2zd+wboqVFYObp8LVI9w+MRXf7G
	p26bU11GqfVdwVjPvIz9AtbzIQmfMCXFkPI0L+qdz12YJl2SUm/4Eisb6+8JoYSO9W6Yv65pR1q
	1Zate0J8QhZZU36J7Wgr1TH04GiB97EAde5ZQQdRwtrqImupppbC/5cdGamx/zm6Ix5Ger0i3Ao
	XneTitoSYVB5cp1jt1Kteus0xavTk9tLn+WddGRHHlurwq/CdVklceMpaU+dHXS+DcZK1+yLkTv
	CfODuFYzFGUE9vCMi3St1ddmKVLI7BAxH6EeCx1MRsJ0q+lbwhMvZCEUW7/cvYcpDgWophBZ00h
	kTaTaH3xq1A9spHChIuuLo+IB3V+eCRk9TNMqxw3ICfxcw=
X-Received: by 2002:a05:6820:4281:b0:6ac:b435:fb21 with SMTP id 006d021491bc7-6ae4334a4a6mr8028266eaf.24.1785644293751;
        Sat, 01 Aug 2026 21:18:13 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6ae39dcb23esm4070664eaf.6.2026.08.01.21.18.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Aug 2026 21:18:12 -0700 (PDT)
Message-ID: <8ebae381-f1cc-4cd2-8afd-8508cf9cb217@kernel.dk>
Date: Sat, 1 Aug 2026 22:18:11 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring/rw: fix missing ERESTARTSYS
 conversion in read paths" failed to apply to 6.12-stable tree
To: Sasha Levin <sashal@kernel.org>, gregkh@linuxfoundation.org,
 yi1tang.yang@gmail.com
Cc: stable@vger.kernel.org
References: <2026072912-manpower-thrift-f2fd@gregkh>
 <34c09190-027c-4b00-92f4-17b5da059af5@kernel.dk>
 <20260802030154.ab05caca123c@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260802030154.ab05caca123c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/1/26 9:15 PM, Sasha Levin wrote:
> On Wed, Jul 29, 2026 at 10:35:51AM -0600, Jens Axboe wrote:
>> Seems that's already in 6.12-stable?
> 
> Not quite - stable/linux-6.12.y has no io_fixup_restart_res() at all.
> 
> What 6.12 does already have is the older inline ERESTART* -> -EINTR
> switch inside io_rw_done(), which is the code ab05caca123c refactors
> rather than the fix itself. The actual bug is still there: io_read()
> ends with a bare "return ret;" after __io_read(), and io_read_mshot()'s
> "ret <= 0" branch only does req_set_fail(), so an -ERESTARTSYS coming
> out of __io_read() reaches userspace as -512 unconverted.

Right, this original email was superseded by the later ones. As long
as the sent out patches got queued up, we should be fine.

-- 
Jens Axboe
