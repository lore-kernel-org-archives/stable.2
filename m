Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961BC484237
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 11:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791805495; cv=pass; b=njY9/iCA8DylE+8qqy9l9N27OzbSuGUjnciK+gYKwDa9+edWlhyy0rjgJCnxgKxAdyqXET3C5IdGItgcLD/mICVm0sqb2wSBZKu8p5nGVoYwvFwj7y0w/xQmQ0dNogU6pJSpPsb/hvmQmhKCvWn6DFhdrqRnNAAWAw3+NFtHvP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791805495; c=relaxed/simple;
	bh=K6a+uG2V+IR5Io6i+GqIRtQTxPtGAXil8uNEAa2cL8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mzWTlqh/9O5cGMtmwXXvquGI8e7uhz52ikMn0HfDoY8wJhjIUofdFCFJVWEusPZndPTniK1S5Xi5RFvVwK6kCdli8CQwhVQrejkk/ZGip1e9FcOE3Hpr0w0BPHEDrxeKSwL9lyDvlscSoVbdwLxzyb2RK+QGBEbHVecd+4Gyg0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sairon.cz; spf=pass smtp.mailfrom=sairon.cz; dkim=pass (2048-bit key) header.d=sairon.cz header.i=@sairon.cz header.b=IEFSVWtm; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sairon.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sairon.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sairon.cz header.i=@sairon.cz header.b="IEFSVWtm"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2e87c66e556so7393915ad.0
        for <stable@vger.kernel.org>; Mon, 12 Oct 2026 04:44:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791805485; cv=none;
        d=google.com; s=arc-20260327;
        b=r6uNH63cMPElAYyPuavwv9j4L8aUxAt8JNqaeDO7q5eOKFJne77A84puDVTRXBSQDY
         qxdwuBR/bNgLqKXOs5Po4XAwk0+vQz0cXkCJlL4OzhUeDAxUBfRy1fUbLlSxLkZjBclA
         iGn3laY/2pW5N9ah3nCsRrbfnlep3kOdfw4RRehl2MhcLyAhUAsI8+vf3uFj8lTqNQzC
         6nTwjchmMOqOd3AXoLy3GJmxxWt/G/Rj2PBT2YDf6Evs0Aj1moOkyYwHqNa1/pOyotxz
         XRshaEA13lYE21Xd51kIRY9UbP2Pto4x6GkRCojB3N0ofoBXedRjf499VQ2J2iBPksxB
         1OuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=K6a+uG2V+IR5Io6i+GqIRtQTxPtGAXil8uNEAa2cL8k=;
        fh=/HyVfQzgx6uWrqs86hNeQ3oOhNJf6qKkp6Y2knFfVgs=;
        b=QoWnIgCgi9zE5WY2jsehnOq3celJApxsBy/+oMe4n9a0Cf1Gt70JkgadISt3IBPohe
         /0+3NLPWpQR4L08rboE7ufRln0HCPSUxSHW70yjq5km/W3ZZzwIqB26hLEPQmm1X4XRY
         7Uj6F7HKEDFmBN4QwSexjkGAB9/dLQ8GejORE2aQh2apVPjGatsfNgZEMXsNCiyWJ6dn
         hgFtw1fdnAxB8cRIH23rofgOtG1WO4RjbTjDLUZ+jwRQr/6D+BpaeIgyqhSZpqxkSjCU
         Mb2u1sqIt0mcSyCxwDSuRfPufeWi+dxEMfeSaTYYYpeBnym4QYcnsd0y25piIhE/6xoX
         eX4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sairon.cz; s=google; t=1791805485; x=1792410285; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K6a+uG2V+IR5Io6i+GqIRtQTxPtGAXil8uNEAa2cL8k=;
        b=IEFSVWtmlNm2VN1Z/jBh3oV+qIqPPNXMWDBMjPPefkt5SKaFOjoLtiRE0oxh9hyfSA
         LUu7LIU4nNJsim9yIkhJWLH0GKg7l5X1+YFuYh5F4RjS/Xm67IsBBFMQqnZ7tbgjwuk5
         5CfNQq2Yvf5F575ke1gylG3lXSTqvsQboFW4x7vjLtzf1aa80u85zXVv5MOxNXWckjtO
         dailra+8edkDAbBTU6xe+9JsEGH7Odx5G7ApbxuUqx+1bYdIml8Szvv+4JrZ6gWKw2oa
         dWFkxeDSoVXzUanVj3Lo1FBwwRYhRMVx4xWyETxmELlLuSBXyaVhg9r1yVsM6gBJ0jzD
         9x1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791805485; x=1792410285;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=K6a+uG2V+IR5Io6i+GqIRtQTxPtGAXil8uNEAa2cL8k=;
        b=GQbDXvPr8b2l97D1fCyZxgnTrBG4DjrgehaX7igdaQmH8PXyPX3D2I6RXHzpEwaLtS
         LPLuAT+jGQ9KhfZDbdSiMRWPForvk8lKAm2OtfDy29PkaRi88fOTxZ4ft3bm1pLyWQih
         FQfTE5r0BAS6+aSu1JrMC1KsajCwV+sZRTTE+oroGwfTR+m2IkmjzTvKNZR0A5N1MGSI
         q1XfrmuMTbzqmERv0QNeqUT2BIXWt7wsTBV3N2RxCPU8Dp9HdyrQWh/N5gMTV9i/aD/c
         pNimBloIAIEe0W+NrHSsEXdzfPiJhdXooGBDi0St29JqmjH+uA2vWxtV9h5oUYAGcYsY
         2//w==
X-Forwarded-Encrypted: i=1; AKwUvBzKyRE7uHPnyFvl5AjwaICcye44b3OAX2RSHH5FOjerS7hqqUXL5uBhvs7uhNC8+Eb3yGE7XqA=@vger.kernel.org
X-Gm-Message-State: AFq9FYICBnA2XcCgin0pd7UuERCYEByZG6omv/FDFIOAp2h/FxJ8110n
	x+QoESFv0CZJP2igdfCwkpln6EExH/IJb1e1aJcaUFY1DajsqG0Hc1ATo3fBzCC+jhDZtExQKuz
	FUVmQd+vnBf/YgqJ/mhgO1c98UY/ZVQCv4vf/St3eHg==
X-Gm-Gg: AYBFou1Yp1bITZ58S1/OBAKGEHyntJ/Spr6Fvnnyjhw1jRWY5nhtciRsLucRgVhdEC0
	mdLYAXdSISKfRpZguyQw939ZEsa1LnaB+3KUq7IE6WZv3yuEKGljPZnIUoIazW6lTqQOHFEhJy4
	B0hm9xlSH7Qd1v+VxKC8HqxS+XHYIgFGW8uOppVF1YqsooQoOjp9Yp7lyWF4Q2M80WBV5MgPZ8T
	zShPEvyBXOg4S7IIA5IzzDdYEURrRzLwS73cMOrRbdQ69kdaMBizGql5ENfycfl7T82DaQSptht
	NfD6mbpuXf/+YQo4sdILsITbWGzzKUBc/giJ8GC9tL/9eJ2x0BIforY+fMX9tVvHsxuYUSc80+H
	5WUkZpTgkkucGWJQJAomRk65nn2lD/u+ZVWuyCI84FUqhrrRrb2uFEKXWqjVrWMGImHFkOeGEJl
	o=
X-Received: by 2002:a17:903:3885:b0:2e7:ff36:c4d1 with SMTP id
 d9443c01a7336-2e840517a80mr65819775ad.31.1791805485551; Mon, 12 Oct 2026
 04:44:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPa5EdCj3v17tB-SF2JNecq5Q8s1Pranr-XzAFWNpNTBPgPG7w@mail.gmail.com>
In-Reply-To: <CAPa5EdCj3v17tB-SF2JNecq5Q8s1Pranr-XzAFWNpNTBPgPG7w@mail.gmail.com>
From: =?UTF-8?B?SmFuIMSMZXJtw6Fr?= <sairon@sairon.cz>
Date: Mon, 12 Oct 2026 13:44:19 +0200
X-Gm-Features: AclHuK9deDiVZ9f5xu6gGTRgmzdiz6FT9YboEHc7TBFHIaXDKq-IUEmQQbcQAvY
Message-ID: <CAPa5EdD7tFRyDztEanTwQXTzVEE8T0FLkbXAtWxUcGGaLYt_bA@mail.gmail.com>
Subject: Re: [REGRESSION][BISECTED] r8169: TX stall with checksum offload on
 VLAN frames with inline tag (REORDER_HDR off) since 1517d1996b52
To: Eric Dumazet <edumazet@google.com>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: netdev@vger.kernel.org, regressions@lists.linux.dev, 
	stable@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	nic_swsd@realtek.com, Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"

To keep the reports at a single place, the bug affects not only r8169,
but apparently some r8152 USB cards as well, as reported in [1].

I had this one (0bda:8153) lying around, so I will conduct the testing
of the patches with that.

[1] https://github.com/home-assistant/operating-system/issues/5019#issuecomment-6111103634

Regards,
Jan
