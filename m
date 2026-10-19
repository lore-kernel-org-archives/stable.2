Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792437186;
	b=oncrXh3gmlEjAqE7S9ASXXdz4TcLJq/wyqKO6+mOIDUbdlgTUzM5jMj6fSFau5FIWOII
	 lm3If3fwA1Hb42oTTDAXttO/Bhesvb0mClfWzQMp9Il0H0tDoqaLjs8373DFPFmprO7nP
	 gsr89i/V6ADgsZYXViokZxx7Y6vohCU4dJ6f2nuEFNjkM6IbB/YPtEVJ76MtBg6XacVw5
	 3V5DhxPvnqrQQiFFxpXXfE90oV0Y6+toIK35NlGjf1TsCPXTsAHNYHa18CW0XzK2H8DSR
	 HokaNJHwsP2dksA27+dos0BKvmNH6Y9PncO9LUdUxj2u6vk459WrDWBZ7lEHX2OsEzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792437186;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=JlYuJFL698MPXVE8UPk93QJm/Q3q10vd5sQJv1hUa+M=;
	b=eIy0ovRPVjYnmEgyXGEkj0fEIbfrpmJWa8Q/nobN7US8BIe0Ox0PcN7RrErYrtuF3S9J
	 F41ZOWU4bc5+fX/5B+biJgU1yUVwknwGFLNVyYYkUCyUJyIHrsvdb0U/dv29uFwE7l4eL
	 EEE2H5B1076AdiG89+kdNPG4FZ5KYEO0j0fLpAmeCq7cSPBgf5SbFWdJiy9w+BYu4Jemg
	 dkwW/rgqcgzFh1OWdj/A5gy5rG4bHTyBdod7qajPdZjtRjqJExa//qzGoSBKms4Hk17oZ
	 g6Ig46OAfDRUQWZY5EOK3ZRUgUozCez/KofUv3eSvr24+PO49xkLAGpku5n0K1zEzxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=ehcUHhqd;
	arc=none smtp.remote-ip=209.85.210.45
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFF7606A31B
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 19:13:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1EFF7606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=ehcUHhqd
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-844a8bf7e25so1525305a34.1
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 12:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1792437185; x=1793041985; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JlYuJFL698MPXVE8UPk93QJm/Q3q10vd5sQJv1hUa+M=;
        b=ehcUHhqdv7LAsfYWK9WpM7vkkCvXaZnvosnqo7AqRtmWKd2hRMSZOu3mtYiXX9DUB6
         P65CFuXOdhVpi0F/LS+ta328YpW80vsOPoSyTfqu6ncXmNMZV9tSS2gqfpV4arVmGhsL
         5WamlmOYi830m0yrB++Shi5d8uG0RhafYPdWNeEz5e4E4FavY+SjM3r8DgunhCWFwPSQ
         OiRP0GXzSIQ0LZnmya2uSeQoTWMib2scV+qCTPOkOasY4Lc7AeWiP1KizpST3UUCwTde
         /sNkvtmmgPkdlgido/6lO7l2j+Dx6Zp9u/58DRqnbvcQIPJB8bmgAD2MJSOROa3EJbol
         ASaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792437185; x=1793041985;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JlYuJFL698MPXVE8UPk93QJm/Q3q10vd5sQJv1hUa+M=;
        b=mstAekSCBvDJ/wMf8OSj0OWodBCSkV2gGZUwWXqqF/YdomdeJtw86FMsZzN52XDsUd
         rCIZQbRwb4tNiFGnNcI203we+9z0HsEeBa5GIr0BIbrdeVM3jBNB9QzsOTusXho9QhQx
         IkukB3TgQGUGfN316WQFJhq8/T2JNN4EfFsiX4dmgIIb4WMV9/2isPCuZ2wZCWuezmJC
         ZXuEIWzgDNicOapaKNYks9fs0eGJYM/ZTb6Zdoh694Cn6cQwCyZdxVcH5W5e8+BFqoeZ
         1YqUUUV26fcB0pDyXVUGc5fvpjF1FmHKh6IxnVkZ8KfHF9YiX9n0yO+yzORds1QGO2CY
         kZig==
X-Forwarded-Encrypted: i=1; AKwUvBxNXUHBGvCABO3G5wzR8F9zNkT2tQwgSp5XJbV7qhlhPmkEHUbcgFqrJZr4H0IGZJLydlaZPNM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLdSIw3zZJaLGLKOtpswWf/7tiA1tNyjjeloGdEwENvBVOsov1x
	0wSuUEDSSv/8uhah2m5KvQWF5ujR+g/U12W3oM8Kzqg657CMaeuPqWcrdryUANmOYcU=
X-Gm-Gg: AYBFou0311EHdzYu5fDuy85hSpax19LhOfbtXzoKEzMynOBFTuhYeWtdYRqqR2ip97M
	AxurCWvzidTLyu0x05U92We1GWSLi9FljBqdyGYCCS9lw7Hsrrii4P92QT57XeHoMta2iKSMdp8
	XL7NZjBbeMgAFDR0ZwlzkIbaGyXX21bPHetNHSX70Kh+d1o0gUtHTF15Xjr3ChviDliePDLOpWX
	aFn4rlrk974DiOUFj8fKOEZ7o1UmLnZ3ML30RrFV71Jr7HeDyHTs4p0no/fV17BKKxRzs1TEeEP
	ozXjUgCpRhRc3U40RUM/ajTvx8867lydJrWXdJQuECtDHPd9QGo5iXYCO7O5bWG+eu/zeajLMpn
	mo9N7VE3+PGpk+Z1WtEuJHMzLu6DRxIKd5cePjO+t1tHOQAKD76VmjoscYEL3stWHhDFcG8rlti
	iZNNt1f+Oui1BpJwHfGVznScmImytRmIbLduDVE/Js3Xqc2Ri99bEULenYR5XGNcO1TyA+93Mwo
	4Py84Qw2M00VUOHldXZOAoFKi9kzsCssQXwWJJnXyjOdlzgQnZxKghuyuho89kX1g==
X-Received: by 2002:a05:6830:6738:b0:80c:d34f:5f5a with SMTP id 46e09a7af769-844fffc14b7mr6946604a34.19.1792437184957;
        Mon, 19 Oct 2026 12:13:04 -0700 (PDT)
Received: from [192.168.2.38] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8462659e3f0sm6669149a34.17.2026.10.19.12.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 12:13:02 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org, Junyeong Lee <jylee5498@gmail.com>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261019152100.63565-1-jylee5498@gmail.com>
References: <20261019152100.63565-1-jylee5498@gmail.com>
Subject: Re: [PATCH] io_uring/waitid: prevent cancel reference wrap
Message-Id: <179243718143.3127071.15080151622998954631.b4-ty@b4>
Date: Mon, 19 Oct 2026 13:13:01 -0600
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Tue, 20 Oct 2026 00:21:00 +0900, Junyeong Lee wrote:
> io_waitid packs the cancellation state into bit 31 of ->refs and
> uses bits 30:0 as a 31-bit reference counter:
> 
>   #define IO_WAITID_CANCEL_FLAG BIT(31)
>   #define IO_WAITID_REF_MASK    GENMASK(30, 0)
> 
> __io_waitid_cancel() marks a request canceled, then increments the low
> bits of ->refs to claim completion ownership. When another path owns the
> request, the increment remains even though cancellation returns false.
> The request remains discoverable by cancellation, so repeated failed
> attempts can wrap the 31-bit reference field to zero. A later cancellation
> can claim ownership and complete the request a second time.
> 
> [...]

Applied, thanks!

[1/1] io_uring/waitid: prevent cancel reference wrap
      commit: 98787d3fa4e99564d2b2bc21255b21f670c450d0

Best regards,
-- 
Jens Axboe



