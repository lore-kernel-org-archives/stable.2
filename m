Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794387442;
	b=weNzVBMYiLmXYysGWxpcsr7gE+ULshqjiMl58izCb7su3cQAvq41xtXOthtwPj0YDtWa
	 zDXqQNFLoZ3yGm6YSZFu4Eif0BCKOKmmoKEMGP45wEd91v9Kp+ZopCwaxyry5T0y7uxom
	 SybOKyeo77LBGG8Pl8bCKUJjPRFdguc1FK05dynNka50bSWF4Ksz8iLJyKumZNre1/p74
	 z2V3veh/GEOnEVGr12gHEnLOJ2iiEon26KUa5xEG8cQZgKVSGaaKsZzzcJ5gBcRlpMbT0
	 WcEId7ySsE4mdru696TEApFm4IDtKILBbeOXKceY0JFvtmmZhEKDlOzwoEfO6mJfZCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794387442;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=TmyvoYQN8Xr0ogKf42Npt/1uUvAg4Sn8MVVxHY9pi3g=;
	b=w0H1FpkcyEyi1rvCSbFJo/vtyj7kPxA+xh/Rr95GZQP/GlS6vaIhSMsGrwLbGC6HxHrp
	 xQcFWw4SCLpCddgmtgDozwuwp1Qnb4+oWjtasNPIEwP+EvIwiSt12ZjoDuj9E8C/e54KB
	 sLB1BkfhpcQb5+D9OQ/fDDwpq38+r6gmwTL5eqUtTy3PpijsiNIB3Cv38VTHUzk0K9HOx
	 Hp+d1vWazIBGv9DotCgwc2YFhOuvZco+Gm9BsSCXjn/Ym4M86G1/rIqkEYzAn+1Escl39
	 WnCXSl5ZVucThe35w8WkF5gNFWFeTpWsxAfHb0ATqCqg4xaF5LF28TW8esxZJsCgUHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JZ7G9fcW;
	arc=none smtp.remote-ip=209.85.218.41
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0E860A2621
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 08:57:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA0E860A2621
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JZ7G9fcW
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c506a231b88so47239066b.3
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 00:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794387440; x=1794992240; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TmyvoYQN8Xr0ogKf42Npt/1uUvAg4Sn8MVVxHY9pi3g=;
        b=JZ7G9fcWbH/o78OOgwAKmpN1iTKlwz+zWvPt5iYUHy8qkl0bh5aOPPN1Unyt+3/Ix4
         IuhmMzBATvD4lh2k1kmkWoxwn8M22fVKCGDRCP6tkk1lkH4o0IDkNuLYD1yuofXCEnEl
         eFD8NCORGQZmL2jeqEYhBy2uyOtbuSbD3eh885X5BAQeuw76BhH9r6oIPa+bP8Pjs8JA
         67Lu8SdpXSktP+2d7fZLeCc4fWjQn27wt6ymOvFrmZCjSbNkB9+1AawDKFV99R9tnJwM
         LbmXBLDNBG7DN80BBEAtHZhGu0i30uio9SIRxI2Tf+b05e1zXfjhX8fBdF4hzyEWbLbk
         vIKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794387440; x=1794992240;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TmyvoYQN8Xr0ogKf42Npt/1uUvAg4Sn8MVVxHY9pi3g=;
        b=nuaCOczHtIvOZbvyffqG1VtbA+mmjfqnE+rG2F99+wlQ0NYPoCE+BxCcsTltzLJhUR
         kkJ7uaY34i5DjYGvtFIOSbedAS9q9jfzl6x77IvFNuxPRXduev2iIT8d9N72bZYKq1jh
         O9PfmA1yqtDq0GV2796meFLFcXBRr/8l/5XzBI7ZKVB47kJe81SAaWRqsU8+a30+WlLE
         YW+avIcOeDUzNbaiHkKCBrtfTHV7to3iRMa6ZHpkcbNuCLuXOVAQCMu3xZPrur9K3TsZ
         2Msw6xxfwhkSdox83+9O8rGTKt1lT8qnDwdp4m2iUSHmtnj0FGVJNWgjuClcaMVCTPTm
         ciGg==
X-Forwarded-Encrypted: i=1; AL+hErEL/vnfLdRe7ikF7KGHWRAGsz+5C5CxrjwGTt+ho0+Q9FU1gAKFy6Rd+iri3d0LSMF/73fYzZM=@vger.kernel.org
X-Gm-Message-State: APuU4Z92uDpm2pNdVtWGhmcCG10US2wtFvuCZcN9vittG4gwBeQ3pUWi
	Sw8QWtJwdObFxtcgt1Z3EQpGAsN6bpyL2jdgA2GU9ub5A6SVCJcOgPKW7YYPD0pB1w==
X-Gm-Gg: AYBFou0LN1JG+mPBQkTApE/KRmy8G/BcKXE0M6XY+udKlKvSdSeb4seqQnZAqFq4cKp
	osXCh8PYjMFCw8TpKpQU8GkmlBdsgDl3Z6NlU1mtRaCknUQHWJyNSM1KJVlPDlwS7me4vwnBvDX
	Z4gt2rZgHp0gUyIgN8UXMtqCLDXhY/ZlDa/X8xMiNRDWxGro+qbvoAfZsE+buABGUXmuYTRrXSS
	ywMRzG9mA3GXNOQjt/2RtKjQiD19Nh9c4kSjImurjlivOLn1PrngXb1/Tw/QTDCi2xh73H3q16t
	pDq/XMKepiPOSMlZAQ8terGJXNzOWyRQ5pWKHiTDfeF0/b+EMfSIGelbl6qj+GuJ1Qi8Z3Jutb1
	SyGIp2yBHFqLEpu7thtzA7NN76Iw5KzWkniXEm7HsDq7sgVJJC5CkFi0C33ptK7skH2cBK2Zc2D
	ixcdd2I9QvPT5G0nRxZsPBEtpprYJdHxgt1cgfZjPeRosBbEGJByG4t95I99mSzzeK1l5uHqaT6
	ZCaE9Hbas9+LbD7rImfafbeDLQvDNjofKcDzPzSn05LuVUqk51fq5kGUfgWI0TKyAugc8U/aClX
	J04P3MNV9/yqq7o63SzW+PTAfYgJ3lzIfGZbTuicyzjzQdXGyhLtJ2hIU9GTs1CKLg==
X-Received: by 2002:a17:907:6ea7:b0:c44:9a32:b27 with SMTP id a640c23a62f3a-c5066b4a859mr135081366b.25.1794387439434;
        Wed, 11 Nov 2026 00:57:19 -0800 (PST)
Received: from google.com (202.70.147.34.bc.googleusercontent.com. [34.147.70.202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a663f3bsm213970866b.72.2026.11.11.00.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 00:57:19 -0800 (PST)
Date: Wed, 11 Nov 2026 09:57:15 +0100
From: =?utf-8?Q?Pierre-Cl=C3=A9ment?= Tosi <ptosi@google.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Peter Collingbourne <peter@pcc.me.uk>, stable@vger.kernel.org
Subject: Re: [PATCH 01/24] arm64: Fix lazy TCO clear when enabling user MTE
Message-ID: <avQqdBEGwje1iVlz@google.com>
References: <20261107-mte-kasan-split-v1-0-d84ea5f30f94@google.com>
 <20261107-mte-kasan-split-v1-1-d84ea5f30f94@google.com>
 <avNjcKtuQkZW0_Sr@arm.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <avNjcKtuQkZW0_Sr@arm.com>

Hi Catalin,

On Tue, Nov 10, 2026 at 06:33:20PM +0000, Catalin Marinas wrote:
> On Sat, Nov 07, 2026 at 04:36:07PM +0100, Pierre-Clément Tosi wrote:
> > On kernel entry from EL0 with HW KASAN inactive and user MTE disabled or
> > in async mode, mte_disable_tco_entry() leaves PSTATE.TCO set to avoid an
> > expensive write, as it assumes that EL1 tag checks are not needed.
> > 
> > However, if the thread is in the process of enabling sync or asymm MTE,
> > set_mte_ctrl() updates SCTLR_EL1.TCF0 without clearing PSTATE.TCO! As a
> > result, kernel uaccesses miss tag faults until the next context switch.
> 
> Nit: next context switch or another syscall. I think this makes it
> clearer that the only potential missed tag accesses after the prctl() is
> a signal frame write as we don't have other uaccesses.
> 
> > Clear TCO in set_mte_ctrl() immediately after setting the task's SCTLR.
> > 
> > Cc: Peter Collingbourne <peter@pcc.me.uk>
> > Cc: stable@vger.kernel.org
> > Fixes: 38ddf7dafaea ("arm64: mte: avoid clearing PSTATE.TCO on entry unless necessary")
> > Signed-off-by: Pierre-Clément Tosi <ptosi@google.com>
> 
> The patch is correct but I wonder whether we need a cc stable.
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks for your review.

I'm happy to drop the cc in the next version. The rationale was that this fixed
an unexpected userspace-visible kernel behavior and closed a window during which
tag checks were not performed, which _could_ be a concern when userspace enables
MTE for security. I can see how this doesn't make a strong case for backporting.

-- 
Pierre
