Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C4D3546FF
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 16:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785946726; cv=none; b=bZ0Vy0o0z4h71EnwU4vXopmEpS9RH/gJnkz6mdvHDtbP0jA0EmqmxrJh9AoYFJfPrwdCN+HWZ2Yuin2anfnRb2B7ZDKQPmR3B1zqEu2hvuDj5P2qlunfAOrx0jKLe8GUbJx43NU8TF48o7uuysQmkOw+X4BgsuTREvahMTlZJZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785946726; c=relaxed/simple;
	bh=OyhTYXB3Pt0XBT+/KxH4Z7LarJgjIEBGlZvaL6J3ABY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mnMx42b2te4qzgNRA0MnbAJ2SfG3+pbS6tpdowtAwWJMW/9PACJ7DarURz8hL2a1DIFvXMDMfKiHEM6ZtxUj4662DupbL0B3TRCCiVuzJKWXwFwfjQf8FkeTsI2g0/U9IdJgm1EzjxrN10pHji5WttcS4A3mbaymSxtzoOMv640=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k9r9izeM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9r9izeM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 102AF1F00A3A;
	Wed,  5 Aug 2026 16:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785946724;
	bh=jRF+4JlTH4Hoq4Mh6RaHtmB3nHaVO/6HT5DVGginAhI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=k9r9izeMMVgmY9t6Vwm1BR+yR/Pp+k7G9Giw1TDOq7xcUXcmy7lchxLFD36CSF52z
	 6RZUh56NGdPxRHvq/5N2pA5nhJ3879ciSvqaDMIc2p7Yl5MAt8s91Y1AGVh2kezzJq
	 k4jdfbHVDxodXOoWaDZb6v8WpCKb04YzVpAJHlgksYTzm50z1CNUDEf9tX580TsLMP
	 qAsssn6GXFLY8zoGn3rPsTH+raEV01qDi+6Sw0LpllxybpcYXStnz9r+rF6sYbylcF
	 0Ar42NskYJ0JYob9H4zus655hJDpxm884ID0dq99FzrNLCcn79vECHvqG67sR2c4gr
	 SC7+1Jw01hDLA==
Message-ID: <edaad88d-a384-4d7b-97ae-85a9b6cefae2@kernel.org>
Date: Wed, 5 Aug 2026 18:18:41 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: stable: queue/* branches no longer updated
Content-Language: fr
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org
References: <e6ea1805-3e82-476c-86a8-096b80bde74a@kernel.org>
 <aImjNPvGPMqFu3RD@lappy> <9989cd82-d126-4dd3-96e5-37dad7f733fb@kernel.org>
 <c9ca13cc-a7ce-48ac-a7b2-a8bdc823aed3@kernel.org>
 <08bac413-ad6c-4e3d-a879-554ab0f195db@kernel.org> <anNf2xwwXDfinNQs@laps>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <anNf2xwwXDfinNQs@laps>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/08/2026 18:07, Sasha Levin wrote:
> On Wed, Aug 05, 2026 at 05:16:10PM +0200, Matthieu Baerts wrote:
>> Hi Sasha,
>>
>> On 11/02/2026 11:10, Matthieu Baerts wrote:
>>> Hi Sasha,
>>>
>>> On 19/09/2025 23:30, Matthieu Baerts wrote:
>>>> Hi Sasha,
>>>>
>>>> On 30/07/2025 06:44, Sasha Levin wrote:
>>>>> On Mon, Jul 28, 2025 at 11:06:17AM +0200, Matthieu Baerts wrote:
>>>>>> Hi Sasha,
>>>>>>
>>>>>> Thank you for maintaining the stable versions with Greg!
>>>>>>
>>>>>> If I remember well, you run some scripts on your side to maintain the
>>>>>> queue/* branches in the linux-stable-rc Git tree [1], is that
>>>>>> correct?
>>>>>>
>>>>>> These branches have not been updated for a bit more than 3 weeks.
>>>>>> Is it
>>>>>> normal?
>>>>>>
>>>>>> Personally, I find them useful. But if it is just me, I can work
>>>>>> without
>>>>>> them.
>>>>>
>>>>> Nope, it's a bug!
>>>>>
>>>>> Looks like git was throwing:
>>>>>
>>>>> fatal: Unable to create '/home/sasha/data/stable-queue-builder/linux-
>>>>> stable/.git/index.lock': File exists.
>>>>>
>>>>> Another git process seems to be running in this repository, e.g.
>>>>> an editor opened by 'git commit'. Please make sure all processes
>>>>> are terminated then try again. If it still fails, a git process
>>>>> may have crashed in this repository earlier:
>>>>> remove the file manually to continue.
>>>>>
>>>>>
>>>>> Which my script was promptly ignoring...
>>>>>
>>>>> Fixed now, thanks for the heads up!
>>>>
>>>> It looks like these branches are no longer updated. Do you mind
>>>> checking
>>>> on your side please? :)
>>>
>>> These stable queue/* branches have not been updated for more than two
>>> weeks. Do you mind checking if there is something stuck on your side,
>>> please? :)
>> It looks like the last update was from 2 months ago. When you have a
>> chance, do you mind fixing your script please? (no urgency on my side)
>> Cheers,
>> Matt
> 
> Sorry, should be fixed now
Thank you! :)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

