Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [81.169.146.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A7F3BFE5B
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 09:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784883613; cv=pass; b=h4nKImk2tjWNvN0WHyQZ4Qw/lyTsFVSUVVWjNAA/jWhvM1z0pmYSxRcmYTc/Agbxlm0riw1o6t5ivwbxNbn9Bx/SWpx+vUlmaN4qtUKCHv40CtKG4JRuL8HhD8IPIG678IVM0POMMKS1n9RhJApLjE7OgR6yEEqR+uXPdnKkdYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784883613; c=relaxed/simple;
	bh=ARQRp7pH3u4DFYDItDTvnKhND5H4ZUTsFFTrNrRL1s4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mOFMUo/gvnxtZhWfabekQ1qwSGiywsUMu5udyYC3Ao6H5uYFZwbSvUczCYP5tFPr2/O6o0K+LQ9nhaETV8IwTaJ5sKriC7uA/yXpVXSUg9MxecqPUHx7uLtlKJWLglYibEEMiglPg4wJ6/WqDnCwpRKslfOKEPYy/MargFro7Fk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=k72VNKaT; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=MJztTUbN; arc=pass smtp.client-ip=81.169.146.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="k72VNKaT";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="MJztTUbN"
ARC-Seal: i=1; a=rsa-sha256; t=1784883607; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=dPsEOOulLn7Y9c4B/LcG0dYTsGZq98joFph31cGNhvj92iHyfb2Ctfvv4eFY2ayTjy
    HOtSeDwviJlLreXpE4gO7v2ge8TYPT5ZB4eGovfCuivLaofk35V3wP+9nQDiZbwgOJCt
    nAZu7r1bpLGhMjYFCdWEgDS+ljZQAFJg4XoBqaYGSfSJoTWn+hKo/CBKpW3t7BL3VJYd
    Kpw0ibUuTFdI8UO+2DoEJ1zqM2ilb8p0khg7o3cCOnltlY+HrND7Ul+RJQusJnkfQtHA
    dm0MX88f2cInKi6MVf7YQpWkr7akTkrN2mWcqOwmgWS23NimD/v85yY8N0kgJ3EHkO2D
    Kslg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784883607;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=AOACn52VQ1sXCTRPVgalbbbjZlghjYYDiSke2LDThas=;
    b=hHqhC3g2ZVjP4y28XnP0iikYALgy4V4cY4cMni9Sh2EPfn8lySAavQ3LnWt0VNBrFd
    yfR7jRY4lCi/uvbPzD8LOGWOIdpDmWr7irc02XIe1pKAKlVqoLsEfW+YmiDBsrdp5K9f
    Lu/FmLs6RT5YmSfE1sYlCtvX1laPV2WxhvEqntPLWUiopUd7R3c/wCW3PB2K150QcpLB
    MM2XG4gwVEzmge63tU1e2+vDlaL1usNEoC4PTYtbcIOAxWDea8LtBmA74m+VPkQ95Aoe
    LU1TqLM2/r91RwQ8OwlPYEJTZpFDqkra+3j12dDKI/f79pbEU3t5ZMSZMLG/2+qe66zE
    1dHg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784883607;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=AOACn52VQ1sXCTRPVgalbbbjZlghjYYDiSke2LDThas=;
    b=k72VNKaTL+VoRY3GyMh5w/pLa9zT4dGNcrQbMF4dWwQKOJ9GUDTVJMaOiC6546B7Dt
    fKyS5Xlxtb00sbsm8PLO4dH2OVGsw5iZmkdNaci6gm5wdjl/mTNVQcTYsbLgFM9tSjTg
    1fOljWEtuFlsx3g5PKo0Zz0JOne5rG80/7GMCh+zi2+ljJ01IT/3fH/pJNyb++4Ll4mm
    zBTMTHCLLPFmH9n7QaFOEvpNsIg+VhSRD2Szje2CHbhd7o13AEGPT66fR42DmEDqlJe3
    R+vwEa4naUd2DV6FjbrhqJHtTKZ2O3fOirItLoIZ49Gj6AVg+RluXGokIILSffSfiI7/
    TRfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784883607;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=AOACn52VQ1sXCTRPVgalbbbjZlghjYYDiSke2LDThas=;
    b=MJztTUbN6giW91YKH9nLa13hWW7SVO7iATufoApbxHiiSaCqRdZXXeesjswgq9YsTS
    9xadevH5KmMF/Q0QgXAQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from [192.168.20.219]
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926O907rtZ
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 24 Jul 2026 11:00:07 +0200 (CEST)
Message-ID: <82d7e31c-ecc7-4fd7-a710-32f39832e8f1@hartkopp.net>
Date: Fri, 24 Jul 2026 11:00:02 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15.y 0/9] can: bcm: backport of 9 patches that failed to
 apply to 5.15-stable
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
References: <20260724083756.12430-1-socketcan@hartkopp.net>
 <2026072409-schilling-scheming-5aa9@gregkh>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <2026072409-schilling-scheming-5aa9@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 24.07.26 10:52, Greg KH wrote:
> On Fri, Jul 24, 2026 at 10:37:47AM +0200, Oliver Hartkopp wrote:
>> This resubmits "can: bcm: add locking when updating filter and timer
>> values" (commit 749179c2e25b95d22499ed29096b3e02d6dfd2b4 upstream),
>> which failed to apply to the 5.15-stable tree, together with 8
>> further bcm.c patches from the same upstream series that build on it
>> and would otherwise fail for the same reason. This is the full set
>> of 11 upstream bcm.c patches from 7.2-rc3 minus the 2 already queued
>> by the normal stable process for 5.15 ("can: bcm: fix lockless
>> bound/ifindex race and silent RX_SETUP failure", "can: bcm: add
>> missing rcu list annotations and operations").
>>
>> This assumes the 2 already-queued bcm.c patches for 5.15-stable have
>> landed by the time this is applied. If not, please let me know and I
>> will rebase.
> 
> This is a mess, it showed up like this in our inboxes, with no threading
> or information about which patch was for what tree at all:
> 
>     1 N   Jul 24 Oliver Hartkopp (2.5K) [PATCH 8/9] can: bcm: fix data race on rx_stamp/rx_ifindex in bcm_rx_handler()
>     2 N   Jul 24 Oliver Hartkopp (5.9K) [PATCH 7/9] can: bcm: fix stale rx/tx ops after device removal
>     3 N   Jul 24 Oliver Hartkopp (1.4K) [PATCH 6.12.y 0/8] can: bcm: backport of 8 patches that failed to apply to 6.12-stable
>     4 N   Jul 24 Oliver Hartkopp (1.5K) [PATCH 5.15.y 0/9] can: bcm: backport of 9 patches that failed to apply to 5.15-stable
>     8 N   Jul 24 Oliver Hartkopp ( 13K) [PATCH 1/8] can: bcm: add locking when updating filter and timer values
>     9     Jul 24 Oliver Hartkopp (2.5K) [PATCH 7/8] can: bcm: fix data race on rx_stamp/rx_ifindex in bcm_rx_handler()
>    10 N   Jul 24 Oliver Hartkopp (3.5K) [PATCH 4/8] can: bcm: validate frame length in bcm_rx_setup() for RTR replies
>    11 N   Jul 24 Oliver Hartkopp (1.4K) [PATCH 6.1.y 0/8] can: bcm: backport of 8 patches that failed to apply to 6.1-stable
>    12 N   Jul 24 Oliver Hartkopp (6.7K) [PATCH 3/8] can: bcm: extend bcm_tx_lock usage for data and timer updates
>    13 N   Jul 24 Oliver Hartkopp ( 13K) [PATCH 1/8] can: bcm: add locking when updating filter and timer values
>    14 N   Jul 24 Oliver Hartkopp (5.2K) [PATCH 8/8] can: bcm: track a single source interface for ANYDEV timeout/throttle ops
>    15 N   Jul 24 Oliver Hartkopp (4.0K) [PATCH 5/8] can: bcm: add missing device refcount for CAN filter removal
>    16 N   Jul 24 Oliver Hartkopp (1.5K) [PATCH 5.10.y 0/9] can: bcm: backport of 9 patches that failed to apply to 5.10-stable
>    18 N   Jul 24 Oliver Hartkopp (5.9K) [PATCH 6/8] can: bcm: fix stale rx/tx ops after device removal
>    19 N   Jul 24 Oliver Hartkopp (5.2K) [PATCH 9/9] can: bcm: track a single source interface for ANYDEV timeout/throttle ops
>    20 N   Jul 24 Oliver Hartkopp (2.5K) [PATCH 7/8] can: bcm: fix data race on rx_stamp/rx_ifindex in bcm_rx_handler()
>    21 N   Jul 24 Oliver Hartkopp (6.5K) [PATCH 2/8] can: bcm: fix CAN frame rx/tx statistics
>    22 N   Jul 24 Oliver Hartkopp (3.5K) [PATCH 4/8] can: bcm: validate frame length in bcm_rx_setup() for RTR replies
>    23 N   Jul 24 Oliver Hartkopp ( 13K) [PATCH 2/9] can: bcm: add locking when updating filter and timer values
>    24 N   Jul 24 Oliver Hartkopp (5.9K) [PATCH 1/9] can: bcm: defer rx_op deallocation to workqueue to fix thrtimer UAF
>    25 N   Jul 24 Oliver Hartkopp (5.9K) [PATCH 7/9] can: bcm: fix stale rx/tx ops after device removal
>    26 N   Jul 24 Oliver Hartkopp (2.5K) [PATCH 8/9] can: bcm: fix data race on rx_stamp/rx_ifindex in bcm_rx_handler()
>    27 N   Jul 24 Oliver Hartkopp (5.9K) [PATCH 1/9] can: bcm: defer rx_op deallocation to workqueue to fix thrtimer UAF
>    28 N   Jul 24 Oliver Hartkopp (4.0K) [PATCH 6/9] can: bcm: add missing device refcount for CAN filter removal
>    29 N   Jul 24 Oliver Hartkopp (6.5K) [PATCH 3/9] can: bcm: fix CAN frame rx/tx statistics
> 
> 
> I'll delete all of these now, and can you use 'git send-email' or some
> such tool that properly links emails together so that we have a chance
> to be able to apply them?

The mails all contain the in-reply-to tag, so that they can be assigned.

What would help you best?

E.g. having the stable trees inside the msg description, like

 >    16 N   Jul 24 Oliver Hartkopp (1.5K) [PATCH 5.10.y 0/9] can: bcm: 
backport of 9 patches that failed to apply to 5.10-stable
 >    18 N   Jul 24 Oliver Hartkopp (5.9K) [PATCH 5.10.y 6/8] can: bcm: 
fix stale rx/tx ops after device removal

?

Best regards,
Oliver

