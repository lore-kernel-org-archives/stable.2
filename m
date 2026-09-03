Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3746403E9D
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 09:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788428590; cv=none; b=LR+ySwRrGyl7qH4NkRftSlRPLK5vO6cblye2CRx9HRoJ08t3tdqNcnVSF9OIzncGMmdX27JLkeogqvljd8VdftqO0xbyqBrCmPQF7lAMtitlcH3xYfN8QGVVt1RKjrzLwdOLb9PalqtpjdmBG9C16S0imTNzFl6rselTHgm0ltE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788428590; c=relaxed/simple;
	bh=eeQmjVkVna13xNvuP7KXsaAPQ0j3npYARLOdxRgDqJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fjCe/ocW8kzi/8H+7AiNeCwYPPg74m/Zk68J4e9gnf6RdPFsfNZJlEe07ofbZfO22PE/gIw1yE6+pmbzh5EgYQplRKZ6PKUyjOdw04Af0yLrZ94IWqQ+x5mzRAAzExVkEA8RzmScw18FhsfuTb4znMF6hjTk8HB4f5LKdn09hO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+NLkCR3; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+NLkCR3"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-398e9698a70so2057216a91.0
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 02:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788428588; x=1789033388; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=eeQmjVkVna13xNvuP7KXsaAPQ0j3npYARLOdxRgDqJ0=;
        b=Y+NLkCR3SusfEsWA5r9PkRW2cCVpV/j97tQTuHHPjPX+rGw/QXrhOpsqquofCMfPyV
         NA/8RJAIC6YriHHi/LpshJarti95LBiHpcE8pTCKdmW11Ujv9HLxAOTrPdWdAeX2DDgt
         gT6ZxMhkRcrNpiuYhZuZxOHu8fVuFD/RCHm2ulNtgjhPVlUoOU8fd0IOH2LP5rdSLo8y
         RDIsfJBNDL0MjWn+VPDjhl2HwlA8rqSs9Y7F0fZ66sKMq2P2LAAn81VZNO87N1+blNns
         ZR1eEv5jnJ5q9H0ddaupr2okPKFr7WXVUIxr1FBR2V1i4io9eY66YgSI1J0844xYcRlF
         LV5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788428588; x=1789033388;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eeQmjVkVna13xNvuP7KXsaAPQ0j3npYARLOdxRgDqJ0=;
        b=aMAp6RMfMvk+9uRg/9gcIJJxnmpSy6jNmtgB8niYpD3eWwRyL2arVVmrfRJ/mhyiSe
         BRyzlJ2ncOZp01T4X4ir++Ap5JZw26wVj8yMmq8laqO7jCA7U9JrSUGqQV75V6itbVIw
         jOjWofNjHYqpBM0OBIf7/Xyn5JA1OPcOktqlK2FrjkPZzI6VvqDtGSl1P6bwcgdGjPEI
         VOdIeXrGkGbYCBTifzeXM6ayrGj6ND5KR4Xp/gY77VRf6DlXxuJSPbElOm0eo+Ed4NOA
         fypxaTTDpmBUOdiSCATv9zzPqeuCrSo0+4wBNEd+vku0fxrP+pV7C9j6PZbDUOarTJqu
         hUng==
X-Forwarded-Encrypted: i=1; AKwUvBzC1Txokh69Y032tnFx1E4RwilLNDRlOmeBmyaVoGmm2Sk3pcAfILRSw16muJA7Puganh96ljg=@vger.kernel.org
X-Gm-Message-State: AFuF++ld4qG5tD5ruhLQkuRjuLYASmlzh0qs9PsXCe7+IK1Or/Shbese
	7a9FBoyRFD3b+ZI/+XeXHtOl2Pvv0tFVlK6U7a4OD4I3nnx0xRyEGFnL+HGI0cWJKbLS6Q==
X-Gm-Gg: AYBFou0B3qGU4b2RIPkHpk3eYowWnwaZFI12e1mkc3gFUvxTtHiZgvbcWb5K5r8haLc
	B4+P2lKPRQngtdK0N4oDORWRnS2elL1XK6omD+hejPsIpv/A7dqJn6OIOXL3Q2uMuTNmLv8+SlQ
	iuTIAbFUysecXVFOapYEjpPTh4mPcZ8KMyGWyqi74/surY7sP3c+7croQbb9KtsVGs2ffYmRMXT
	EcuaHmnSZxGsn3HrtWOnvo7Ok5zb4MqQHWC55w5S0b765q9G1ioDT6NCb/kRqhHdAqgafSYHN87
	LbCQwgf+/AxCm3qGWJuiMQ1wyR9VSG6peVQT4KXBZ+CbD4oIvLq14Uov4sIshoN+70DjbGmKU9Y
	X2dEAUVy47B9aBSCvtSeVGkRxE6CS+CIRMbDCGJ5makBXJYVyDzXvEot4FlgRyCD8f9LFh2O+WD
	3sayik6X6pu4LIYdyueUZqg6YED/05WiOFanfgaXZra2535WDH5BYnZXH70vPNqSU/o0wjnTj3c
	dG5KdyA7YvQstsaeQd4OOOgm69QBJxxNg==
X-Received: by 2002:a17:90b:2552:b0:38e:c232:9d3f with SMTP id 98e67ed59e1d1-39aedec7bbbmr17515317a91.5.1788428588043;
        Thu, 03 Sep 2026 02:43:08 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b0832c14fsm4421347a91.3.2026.09.03.02.43.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 02:43:07 -0700 (PDT)
Message-ID: <906239c1-e78c-435c-954f-1198595d62b2@gmail.com>
Date: Thu, 3 Sep 2026 17:43:04 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: inftl: validate MediaHeader partition geometry
 before allocating tables
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: linux-mtd@lists.infradead.org, richard@nod.at, vigneshr@ti.com,
 linux-kernel@vger.kernel.org, Aohan Mei <henrymei@tencent.com>,
 TencentOS Corvus AI <corvus@tencent.com>, stable@vger.kernel.org
References: <20260902124044.3942821-1-henrymei@tencent.com>
 <87h5k67ocd.fsf@bootlin.com>
From: =?UTF-8?B?5p6X5L2z6bmP?= <ljp1205831794@gmail.com>
In-Reply-To: <87h5k67ocd.fsf@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Miquèl,

On 02/09/2026, Miquel Raynal wrote:
> > is evaluated in unsigned 32-bit arithmetic.  With lastUnit < firstUnit
> 
> lastUnit < firstUnit? Did you even read that sentence?

I should have made the arithmetic explicit in the first place.
All three fields are __u32 (struct INFTLPartition), so with the
crafted header used in testing (firstUnit=7000, lastUnit=3,
virtualUnits=100):

    (3 - 7000 + 1) == 4294960300    /* u32 wrap */
    4294960300 < 100 == false    /* sanity check passes */

Execution then continues with nb_boot_blocks=7000 as the loop
bound against a kmalloc_array(lastUnit + 1 = 4, 2) = 8-byte
PUtable, and the boot-block marking loop writes ~14 KB past
the object.  Reproduced on v7.2-rc4 with a RAM-backed fake
DiskOnChip MTD device carrying that header:

    BUG: KASAN: slab-out-of-bounds in find_boot_record
    Write of size 2 ... 0 bytes to the right of allocated 8-byte region

That said, the reachability is admittedly narrow: this is a
mount-time path, so triggering requires root (device
registration) or physical control of the flash contents;
unprivileged users cannot reach it.  The intent is only
hardening of the MediaHeader parser, in the same spirit as
the sanity checks already in find_boot_record().

One fair point about v1: the new check runs on every partition
entry during the scan, while only the selected BDTL entry's
fields are actually used for the allocations.  If entries with
lastUnit < firstUnit can legitimately appear in other slots
on real media, I can respin to validate only the selected
partition (and drop the boot-record-unit check if preferred).

Happy to send a v2 along those lines if you think the
hardening is worthwhile; otherwise I will drop it.  Either
way, thanks for the time.

Thanks,
Aohan

