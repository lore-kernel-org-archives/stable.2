Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794559783;
	b=vXdKWiMbvHZC3RHZolOT6w4Nfe+znZUNxf1lKd0lEAiFPYK5BB+jfFpMN2IzpVZnBTRc
	 OZ0GjknizZE+Ne8Mkfvnvfnm77tqinY0IWtNHKqzV1xRYkVhf2FutpJa9UNFBgbApSJpG
	 ngCPsEqIQosZfy6cumFrjHbulhx2mBDxlFHW8p20b0i08eqs2z+d4b8we6qZG6vb+CjY+
	 76DwB90dWAH3GrO5B1ICnLNCbDQu+XEZ3NyUjij/7oQ006B0GtlSetrajq4+91hwzul2H
	 INYswzeCyE2U55ATa7mMgrDHMbsdDO9qOeR2h4nlw7oiagHEm2FB0Heor+F98EY21cQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794559783;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=Dzv09GA4BYrIrOu0wQJjxdfknfDDtVqx4Cn7SIfvVMk=;
	b=fA2beor9aYbOXeUnt4uLTAd1FDS/mkcjNUUnlTUMySXaY6Knzl4lFAhb0AZJkSF24GyJ
	 wwxl9nAkk/JwZ5vqHCqe8WrD1Eb02AWJRjh4oXHbCAOGslppBPg0W43vBiDS/BBp64WXL
	 RZ80cSaj5pValQjv7NFO5APbIxXB4lYFOLvO8UDI5Q7ah1Jl41XlFl76xMxkJr/70A4Rr
	 Ng8scvQDpARGds0bqFdglnHkSaC0X0E7osncl+vBEcmj6ZS70Ls+6fHgeGB/yml6XFb43
	 LelyJRnHoGWu88eZ6VgZWwOIIsmdY1bA5MsOuln3Me8iqw4yNYM4kFhmFDLoLSQgI9Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FkBwWW4x;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.172
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F302E606B364
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 08:49:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F302E606B364
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FkBwWW4x
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-4f488ba6e90so207807b6e.3
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 00:49:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794559782; cv=none;
        d=google.com; s=arc-20260327;
        b=NW+/4kc/caDxO0Pnag/vdyW2KSBB6LPJxYW6ORgE6mas5r6R+hlGYlIj52a1mezNaH
         Z2LP6kgSOFZvnS0Pha7pMDnu44dAGCp5LfPvKnjaqeNRDqUYWiH3n5joZDuYDSUnEpDM
         FYoqNO0zdKGJ7vSYhpK9HwKk9KUmYb97WuVs+taGeFyiQ/NoxN8PkaXo9g6st6aqisOY
         pAoLlzor6nizmTBdBFYzUHkQg4TvN9WD0QwgHQTyTCqgEDdWA8+M35FsrGr92gpPTfcW
         Tn+15zhWIEva7cEYeAZeBoMsOFbG2NR8cqn+fblDBcWxVVpTqBjVIoz48h4NhCCrWX/e
         g8jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Dzv09GA4BYrIrOu0wQJjxdfknfDDtVqx4Cn7SIfvVMk=;
        fh=l87L7nhs3iLbNHOrHTMo3F3b0w311eI4qSYeekYGRt0=;
        b=ktLcIbk/sfHpbEUq6ePIvdI9+9kMtkwgtVC20VZ5h6YDF3S/bPXUz3p5+RGVOq1Jnf
         X3XUU9YDla17iBy0ydnpVmvxJkoV0YXkJFDlJR3wswajp+6boFoosWbccyMHUL6Wae+C
         d/8ms0jr+0kxjqaiAdy3mynLcypzE+HMLhxVTqyj9dfh8MLJbMw4FTeBVVX+trnSlyX5
         yMg7HaNSn9J9eh45GYEopTTqdVSQeoWQRHk0CcrbYvXrXXTa3dtLMeO2k9eIPTzt38i3
         ZxwNfjvz5kgnVhp8i19pg3Aj+mkgld8p0MIvXa0PVhbifdIAuygvUeigIwbLCT/E0mIn
         NMdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794559782; x=1795164582; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dzv09GA4BYrIrOu0wQJjxdfknfDDtVqx4Cn7SIfvVMk=;
        b=FkBwWW4xeFx0Zjm08KpUKDWKUmU74+Cz4D+9cz7wCjoMyOeJd2LEkVvyzK2p0kp8UZ
         bYzImjOJNOK0ulA1Klcoy1bM6B+OI/LnADAyNPvPp8U2O8kBC+fnVWwr+TXrLJv4Ly25
         QhPIDhJfNy9aQwnn5s28Cp5VkkasCiH2EivnDklojTwjFYyXdCFT5l6SQecCPXVwhgON
         2VitVHTHqxFAC3CRO6/TflQ3PNUzuf9Nh2oooBWFtuUW2e58hmytW8IA+/QhRGmR+MbJ
         1OxLiz0Xrbs1cmeL3P9AjU2Gr35zWxScumhj7O7IG0w9sv3kcmcY41RCMjwwgOYORIrk
         6jxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794559782; x=1795164582;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Dzv09GA4BYrIrOu0wQJjxdfknfDDtVqx4Cn7SIfvVMk=;
        b=pmmr1Q4FeuhyHYbJwCzi+hp2KzaJ5+RY00oR7Z7yF27BZwkdeogvvpnNeOxrZerqtw
         WGgkSEeVSKtcxzY5ab7QlohIZgdwqpvhhRSJTqxXGa0uK/J0bmaKWwHYhTGha2jtorb5
         Zl3+d0AO1onjO6MbxUGDYlKy+SAqnCc/FYykMY3I1FH1yKN8C57wGkSiHwGzVDgjdtkY
         JG25tzQqGe/kuM5vxN0I/wDbL7zYmkV+tPttHS4wQVaI/UHFpj4Ji2pL7dE6KYUvEynW
         9bV+d1Zc46XyLFOqaSF+NsqsAV01fYlIjiKO/Gyj7v60N2tWAxejW+bhSInV3KwIV/hv
         lS5g==
X-Forwarded-Encrypted: i=1; AL+hErHUUlV7w1zTz5CeBIQLkSRtkzkSeFjB8LPSnlOXrH2CFjp1kkbBPSP38YZzJQ2oglqldcXJrtU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/L74rPvMT3NYewZO/8N9tJYri6NGczH3nOhdc076YnD/IMUNdT
	8hOdzpJYSmr+XsE7dscMM2MNi7TC7DrA3KdKC2US76kVul1AAOa3Jn2agC+SdY9CMdoKRF1pKgU
	ioFjqzt4XHyV/AHWBnKWvMhyXhUlwybs=
X-Gm-Gg: AYBFou0VQvJflSJ5FMxtVeCFkYC8hnRAtKpXviWyz9T4IpFxsVQhC56dl8xtndRy67J
	yqd2C+xyHS2530EY8kAkwF34avxVlPTLVR6G1GWrd4gk0suXG6JAI5zZiCASW7yNWUNAKWPwwzY
	/4+WbzaQEzIj34tDSRFFp0MASdPSgAcE55nW8MGdvLiUSGwjSUqHa9vXlDVw1B3rZR2QdQBSWa9
	zaP7MDeDlmCa0ex/2+ekz1eanTIDjl/EKqeZAL+173vp2juLL4owCFyGVgOfUK/NFfODlHZCYw9
	k4n+84zgFEDmwh5g9zT9IAVoLk8qUzHFYWAiZivs9Rr9w7H2GhQk73u4HcAo6lYE0zX2LUGTh7X
	eZVYtf/4kq6WcKhiI7rCXCW47hrxWa0B1IciH1k6y4ufvmnzIddCOpkcXpkgOXmmVlaeRxgA=
X-Received: by 2002:a05:6808:10ce:b0:539:dfe8:9960 with SMTP id
 5614622812f47-56e6625e4d1mr1193940b6e.56.1794559781895; Fri, 13 Nov 2026
 00:49:41 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261107174215.15818-1-swizzguy76@gmail.com> <20261110085003.3527014-1-karol.wachowski@linux.intel.com>
In-Reply-To: <20261110085003.3527014-1-karol.wachowski@linux.intel.com>
From: Toast <swizzguy76@gmail.com>
Date: Fri, 13 Nov 2026 14:19:31 +0530
X-Gm-Features: AclHuK-auqnjQ6e6wO-djNHMxE9adJKmvPX4oU29Wat1ijwytmzWBqiZsfPGJSY
Message-ID: <CAHBKUQYqAEuDHBDX-z6hvTY-GMOwqR9Skmtpn=UhaTK-JRx+1Q@mail.gmail.com>
Subject: Re: [PATCH v2] accel/ivpu: Defer recovery until probe completes
To: Karol Wachowski <karol.wachowski@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, 
	Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>, Oded Gabbay <ogabbay@kernel.org>, 
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>, dawid.osuchowski@linux.intel.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Tested on Meteor Lake (Core Ultra 5 125H, vpu_37xx firmware 20260219)
on top of v7.4-rc1:

- kexec from a 7.0 kernel and from 7.4 with the NPU runtime-suspended:
  both runs hit ATS_ERR during probe, recovery_work was not queued,
  probe failed once with -ETIMEDOUT, and there was no oops
- FLR plus rebind brings the NPU back
- debugfs force_recovery after a successful probe recovers the NPU

I couldn't hit an error IRQ after ivpu_boot() succeeds, so the deferred
recovery in ivpu_pm_enable() isn't covered by this.

Tested-by: Daksh Sahni <swizzguy76@gmail.com>
