Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3CD494826
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 13:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791467312; cv=pass; b=jjpLVAmLev+8rZB+WOt3XhuDnL2ia235HY3vRJFq/40yaIUABlILXszb7a0NrkpNNPyvymSA7Mje/cOZlhnJEHDJWp+E95K0WU4hHMA7w8YoXlVHB39YxblC8GCw6teF/jbSqRi9a7YkxFuYG8CzO2RyWU8q8mf114ElYyB7nbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791467312; c=relaxed/simple;
	bh=GxYaZEmMSfj5cqopxpHkz12DEhpzIPayu+f2kBBrl7o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cxAq/qOAf+p8ahItXP+jWQyqNdGTyL5EYrDRlSZweah3W9vTsRxSDgmD6iBY7UnFVNQaMtcbZO2YFcmZ2/tLNLo2NFyJ1A2HAtHjhtTgdbxaDzuUUwHilDCwF17esB4yTt1zfaU0tSD0/WvDSzS9B39LMNCQYoo7o3fz0tz7Lvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sairon.cz; spf=pass smtp.mailfrom=sairon.cz; dkim=pass (2048-bit key) header.d=sairon.cz header.i=@sairon.cz header.b=LCs1mMyJ; arc=pass smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sairon.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sairon.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sairon.cz header.i=@sairon.cz header.b="LCs1mMyJ"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cc4aa0246b7so1621187a12.3
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 06:48:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791467310; cv=none;
        d=google.com; s=arc-20260327;
        b=Vi9BFIAY21czZKp1pIDeHKc7OQq4xuwd+KRWeVhDOxAWbwzSJHX/HlEzZG3UxZeBaC
         bgw/WB3HWNyYPUVAynDGlSbP+AhsOBhEN2HxBYpOCt7tByZ7k8OnwrsO2C+ZtgsEiFiQ
         f3H2M2E0gccT6PCAmJYrLyRn8Q4bDyh+ndMddtrNoFEFvNd5KTSKm6sN81JGqjpttjFn
         P8ga0LiRa5DwPG9cjIRdT+b5a/4gPZ4LalfN20igG0a0g5CY7sDLMgnw32hRoaonPvWe
         xLdhOQe/wdtE7ueZM5b7LVvXmiF4JpFZvaZolkzTLeC8x3xxAFOm2Ns6gXjHeNetaejp
         5CwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=GxYaZEmMSfj5cqopxpHkz12DEhpzIPayu+f2kBBrl7o=;
        fh=+qB0Kbzn7WpKEPofvxP/N2ETQow8rF7wEFLWGIAvr6s=;
        b=jDvn249tQaVjiXDodIYFeUabu8G/ILY258ktudG6pYI+mX0kapc4hNh7kUcZkv/tPn
         EBQ63kxTCFdue3MAwrHzsRpU8RIE18O5zv0jddHeKKAV+nA6SAD6Dwco+dEzsptMkHJW
         Dm7d6yzEePYwZzUaodm3k2vGkYgaMcq2YPy19sq55lmaeynQcyhcJin2YlSflr3KTW5d
         Git9WIkg+Abori0mqJyfg6nbkqnwLkMuhuzJ3TlRqQNStEIwkmXA4H0KuSdqdK+40tc4
         G4o3U64gd4MPsTjQotiJr2KmItFwsKdmUNJw8WgCiIkFImeKvvCVjBLYq3w+DFd6NDEB
         LVqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sairon.cz; s=google; t=1791467310; x=1792072110; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GxYaZEmMSfj5cqopxpHkz12DEhpzIPayu+f2kBBrl7o=;
        b=LCs1mMyJon1k5JnMiOnisxp3qDbZXdZaUpxF/wwWHaod9t5KBkrIUwt2aVeM4UAEVE
         xdPvv2qV3aZ8RmjdH8XBXCtHE9uhAVNjYyd8kDxaBTUy3ZEjs6yd9/o8k7sTr6JGm47H
         /CMqen+dwS/xESpLLV0R9RGyUkdtEyGxS5sg3odyX4h46ugT5sZ84KyE0XqydZguHSeT
         hfOef0IV3fZ5H2ANDt0rSNLzWd+0Lk3AQDKr3KJ4LrgApEhkUB4P+4odeEfV+8zDbvM6
         VZEnd6MiXtd+/uvggp+eLZGDqPhO1nMoBez9bM1G0czyhTiY0DFz3rtiZ41U/v0JKU22
         U/Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791467310; x=1792072110;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GxYaZEmMSfj5cqopxpHkz12DEhpzIPayu+f2kBBrl7o=;
        b=CuvqmkLiyBmeXo7JRrXwxAil76je/AR7rwz/ClWUGQBWhbdlGX08TtQO+zuZ9AD4RQ
         eiWekbCFmhfSr2AAlKLpPdN6YkVdPW9XkPVy29/sxYoWH5OLfrZRRorrmnLDR/2D7jc+
         6OO/Iy4+iLdyYjkp1U64HH3a1QFt/kshPwoGY/IewB8REzyTIV92wEZapGNL4R6ulhYf
         wbbVn0+KXDuulbomA+rVPm4dS61+kd1LbY8VsaaDpNcy7BSocY6qdv8lwMmVp74bbT5C
         AfqwF3N3WQFJOi9rD6oEW3S63B1JzUZUHKXCB+N0elEoV/BWBV4Rhrcy7N5BSrI2+tjH
         h6pA==
X-Forwarded-Encrypted: i=1; AKwUvBwG1lD15TTcNb0ZXIM8d0vwTZGOe2NU+OrOgcbmEFjWxvXvYbV+y4Xd6/7+klqHz+llnluNDtA=@vger.kernel.org
X-Gm-Message-State: AFuF++nuqG5hAVNPQbRlCAnckgmyawtocS4FYADvKSVHAJWQusEXXhHm
	RY50A6KdE7+59X6cRGVM0fIToRD/lYlioYEa3S2Fx6ZOIBOuFy98OfA8bbFAkluuOvFIc4M3r5X
	U6fPS3HvTRc1BPXwhh3fT8QuC/3Cqku3CB7Z2hhyt7A==
X-Gm-Gg: AYBFou1+L0IC6YhbziHC9uVNtm4pbX9D4BqCgOdpL21wY9/9G0fasWHBVG3KCkdtno8
	KbmPoBJatuimDQT3DaR1lMObXsl2pQM9IV97ZVqmuXSlgREoCb25NCalzDpuYHr5twQddGCkFpb
	QO/GQzbOtmNb5OK2o6VW76v/XlfRPHgpja59mvqX40Y134Uy5CDTDch2CHbWhxSVSLqv2ZrDeK+
	YTny1gIT2U3hFwhTLm8frdwzoqikEJSgs8b5hMGCLNELX6dcXLEJlimImiGRZINWrRppAemLUeX
	ftOQtzu1X89WiKu3cm0CgtY5XJtuXN50nJnonunlvYDLLuC4cNoV4EhTeDTMhGIcuc6hPJm5n6b
	ekPyiOgMa/5r/E5aHBhhRxKw/Kv8x4BjP70zmkgzhpr7/UuOaJPAv4svTi5tRM2xptJL5MBAtxf
	D1Ogjc3fXdYw==
X-Received: by 2002:a05:6a21:e58c:b0:3de:5a00:e248 with SMTP id
 adf61e73a8af0-3e134154c00mr4172366637.76.1791467310506; Thu, 08 Oct 2026
 06:48:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPa5EdCj3v17tB-SF2JNecq5Q8s1Pranr-XzAFWNpNTBPgPG7w@mail.gmail.com>
 <a6193df2-98f3-409f-b73f-5b91835a0107@kernel.org> <CAL4WiirwF6bZwocErCthJ+TUu7wipRfSibRBoKWjjkA2nVSrqQ@mail.gmail.com>
 <CAL4WiiqSmW093PDngLrUNiNA5GVKeM3+tAO7KMDJeyjYZ7GRzg@mail.gmail.com>
 <4c98eff5-c8c7-43ee-b59a-adb833978816@kernel.org> <CAPa5EdDk+HuVP0H1+iqOcHDHZnfdika5WOQcgSaMtfRFWzqZ+Q@mail.gmail.com>
 <CAL4WiipSpufpdo-AWoNEJta-puLQ5hMyPn2xcjwg4vg67PNoyA@mail.gmail.com>
In-Reply-To: <CAL4WiipSpufpdo-AWoNEJta-puLQ5hMyPn2xcjwg4vg67PNoyA@mail.gmail.com>
From: =?UTF-8?B?SmFuIMSMZXJtw6Fr?= <sairon@sairon.cz>
Date: Thu, 8 Oct 2026 15:48:03 +0200
X-Gm-Features: AclHuK_9cv-O-41xZVfpN6e8qZHktULAqfmGyDPNmDuHK5rePS-wDUMv3tjDuuI
Message-ID: <CAPa5EdC5+JiLCHdCt4m-sqM1pUs=fG8T7zsmVcheHCG8FFF8Fg@mail.gmail.com>
Subject: Re: [REGRESSION][BISECTED] r8169: TX stall with checksum offload on
 VLAN frames with inline tag (REORDER_HDR off) since 1517d1996b52
To: Eric Dumazet <edumazet@kernel.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org, 
	regressions@lists.linux.dev, stable@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, nic_swsd@realtek.com, 
	Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 8 Oct 2026 at 14:48, Eric Dumazet <edumazet@kernel.org> wrote:
> This is the current patch under review :
> https://lore.kernel.org/netdev/20261008123812.554729-1-edumazet@kernel.org/T/#u
>
> Thanks.

Oh, I missed that, as GitHub "protected my privacy" and I ended up in
CC with its noreply address (which really leads to /dev/null). I've
applied that patch to our tree and started the build, I'll ask in the
issue tracker for testing once the build finishes and reply in the
patch thread if I get any feedback.

I've disabled the "privacy protection" on GitHub so I hope next time
it shouldn't happen - but just in case you'll be updating the patch,
please use my real address I use here.

Thanks,
Jan
