Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C34C4CDA3C
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 16:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791218135; cv=none; b=KSqn5TpCBGFvKh3FGisgEIbu8unWKpkyONeBg9/QGJ8AF9nGBvrInQM/kyLjWQ0K7LflTbR0KszZtoiXgN2nELQNCd5QIRChn6efUsp49PIBn1yvDlhOjl1z6b2ocz4sLUssRKsYK23UX+QZC1P8rlknmxkmUKg5k2+IfxTUNPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791218135; c=relaxed/simple;
	bh=TWLfNiXPDPKmCfrw5m0MxceJ08WtbyK0nEtydasz60w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WLaUWV71hBS0odHhUDuf2DcdEu0s/sC6a+6/u1qhQ6AdY9k57+nwtbA6utA2QpMcb6v9SNaGxfTtSj/VjwoOBEA/4I6I4im7JxfhbSaX/xgJaZKFAt9AG83nfX21h3OIdiCwFoRczy/36Q3dYVZR/23YD+b1ZWXx25vlCTgi6ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iz2KyDiv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iz2KyDiv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 207751F000FF;
	Mon,  5 Oct 2026 16:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791218132;
	bh=eR+jRk0GdQ3dm6roiX3We+PUG31+cSGPVrvkxDy9zZw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Iz2KyDivq5qS6tFPDaM5u7WsODCIv8OqSIdxfU7cOG4QBRZb3yrHxbYNqiVZPsY38
	 V8lfOezWR9tzn8D+xJehcZpheqnOdgbjZ+X8KsCvvXop4NeLjP3Km7xRWlsU9zYqle
	 jKBA2zyeQvxAMnRWTi0nG8bbHMRXRXDFbXzaLZ8xSFd0gdvDWiJxQiTFarrKq42msK
	 6TgWwaErJSanNeFkGtM/DgVyIkHTqT6WSHMxIglRshhOAGzdZZ7/7sQR4Nml25OjAU
	 jZ+cQVuyYxsJtsjBHfoikxF1FPEJKwssOJ8x6cad8B1S7pDdKAZ4xINIQ1O67ODrq6
	 MRru3uGqBamRQ==
Message-ID: <d2282814-3b75-45b5-a110-f2debb8e2635@kernel.org>
Date: Mon, 5 Oct 2026 18:35:29 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 6.6.y 2/2] mptcp: prevent race between disconnect() and
 rtx
Content-Language: fr
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>
References: <2026091621-borough-happiness-9e59@gregkh>
 <20260917124903.223926-1-sashal@kernel.org>
 <20260917124903.223926-2-sashal@kernel.org>
 <83ad680c-9f5e-4328-b87f-ad0f14de9ed6@kernel.org> <asPQM7yBMxN3K6Jg@laps>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <asPQM7yBMxN3K6Jg@laps>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 05/10/2026 18:28, Sasha Levin wrote:
> On Mon, Oct 05, 2026 at 06:23:00PM +0200, Matthieu Baerts wrote:
>> On 17/09/2026 14:49, Sasha Levin wrote:
>>> +    msk->timer_ival = icsk->icsk_rto_min;
>>
>> Because commit ea4eb2adb0d3 ("mptcp: honour configured min/max RTO in
>> retransmit paths") is not in this version, this line should be adapted
>> to:
>>
>>  msk->timer_ival = TCP_RTO_MIN;
>>
>> (Before commit ea4eb2adb0d3, icsk->icsk_rto_min is not initialised)
>>
>> Just to avoid a deadlock, do you plan to send a v2 for that, or do you
>> prefer someone else doing so?
> 
> I can fix it up and queue it.

Thank you!

>> I can send a patch to fix v6.18 and v7.2. The patch has been dropped
>> from the v6.12 queue. I can send a fixed version for that one too.
>>
>> Also, a more general question, when you resolve these conflicts, do you
>> expect an explicit Acked-by? I tend not to send them on backports, I
>> only react when I think something is wrong, but maybe that's not what
>> the stable team is expecting?
> 
> An explicit ack helps, but not necessary (since most people don't
> bother :) ).
> I am letting these backports sit on the mailing list for at least a day,
> and
> then pull them in if no one complained.
Understood, I will ACK them when I can.

Also, this might not be possible with your automated scripts, but do you
think you could easily Cc the MPTCP ML on these series modifying MPTCP
files?
It just to have our CI picking them up, but that's OK if not.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

