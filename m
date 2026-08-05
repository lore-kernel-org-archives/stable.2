Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FD941F5EE;
	Wed,  5 Aug 2026 10:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785926100; cv=none; b=HFcoG1tYQaJM5fHy2aeSekWRQXvknWz+v5n9xkDmIVN89LZ71PPPifj5IeQy/UjjIK1kqXdzQBHjsZAPPsi+Yzbj2E5jAllTnL99pYBpvrqMMkL+kHh/dW1IvEERs0kuFKmxmx2sH0uMKddaOiVeloyKuRRKrt94MKlkXQn88BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785926100; c=relaxed/simple;
	bh=6yhnC/JB9zpHR98EjGt6/BBOLbeswDUkp+NkaIi6r5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gCvHhltcbpP+gHsMqebwyxWGx6VRZeDZju41JtC5mVP9wVYDuIdQyOW0X/ncQgaNnxjG5qe+Wl1KDr+l0sPENjhuFDUKNoiGw3fxX0y3JA6cD+l2vDgVFFAXqsEQ2+1YrU3F+lvDjgSVEAfzBXZgtjgUU10ubdiJiM9Zji3RZEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ab1fxJ66; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ab1fxJ66"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B8631F000E9;
	Wed,  5 Aug 2026 10:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785926091;
	bh=fJaUVTxoVSLFYtIDACf5QAyWVCuC9LHzgmitQoJw2UY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ab1fxJ66dgNjk8KUt7iazikxK9rs4TvkYuICwdUVa9V1VaMpVQWvxIwHvui4kW0sk
	 mvHX9hSeJFvi+3vuUsWEbREAVDuDEAGHm7U3anF8pxMNLuhP/5OAuuL+n03R0DRtGG
	 jayja7GKqvWX0/01+bYJCnls0h38hKkL5swvZocp33awSbQB7KmifLhDdgFeOx7Hpf
	 uUPmb+49CXZf4AttmQQfDsoXAPEnPy0qU8POfhN/fWr2efvE8EZe/gLMSPp79+dUwb
	 eKJbV0mPaQgVOn28odlif0G9VJBLZ2qBZHx42G/ad7s0PLt6AWyHV6qbbAzoNGz/L7
	 qGcJdxVy3wEXA==
Message-ID: <57e21541-ba97-42f7-9b93-29d443ff1fd3@kernel.org>
Date: Wed, 5 Aug 2026 12:34:43 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net] mptcp: hold msk reference when cloning request
 sockets
Content-Language: fr
To: Yuan Tan <yuantan098@gmail.com>, Kyle Zeng <kylebot@openai.com>,
 David Lee <david.lee@trailofbits.com>
Cc: Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
 geliang@kernel.org, horms@kernel.org, kuniyu@google.com,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Ren Wei <n05ec@lzu.edu.cn>, yifanwucs@gmail.com,
 tomapufckgml@gmail.com, bird@lzu.edu.cn, caoruide123@gmail.com,
 enjou1224z@gmail.com, Vega <vega@nebusec.ai>, martineau@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, ncardwell@google.com
References: <20260804095051.715355-1-david.lee@trailofbits.com>
 <ec043cd9-ffc5-4a16-a80e-b736ea50bf3f@kernel.org>
 <CAPuPA7KZhv39w=nCG71WBLOcPRrrpb=CvDdVcnCRbfu+z9ZELg@mail.gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <CAPuPA7KZhv39w=nCG71WBLOcPRrrpb=CvDdVcnCRbfu+z9ZELg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Yuan,

Thank you for your reply.

On 05/08/2026 10:52, Yuan Tan wrote:
> On Tue, Aug 4, 2026 at 11:00 AM Matthieu Baerts <matttbe@kernel.org> wrote:
>>
>> Hi David, Kyle,
>>
>> (+cc Vega's people)
>>
>> On 04/08/2026 11:50, David Lee wrote:
>>> From: Kyle Zeng <kylebot@openai.com>
>>>
>>> An MP_JOIN request owns the reference stored in subflow_req->msk.
>>> inet_reqsk_clone() byte-copies that pointer when migrating a request,
>>> but does not acquire a reference for the clone.  The original and cloned
>>> request destructors can consequently drop the same reference, leaving
>>> one request with a dangling msk pointer.
>>>
>>> Let cloned MPTCP requests take their own msk reference.  The source
>>> request still owns its reference while it is being cloned, so sock_hold()
>>> is safe.  The clone's normal destructor balances the new reference on
>>> both successful and failed migration paths.
>>>
>>> Fixes: c905dee62232 ("tcp: Migrate TCP_NEW_SYN_RECV requests at retransmitting SYN+ACKs.")
>>
>> Thank you for this patch. It looks like it is similar to this one sent a
>> few months ago, but where changes have been requested:
>>
>>   https://lore.kernel.org/40fd38e7a368e5b7bc9bc83364a32241f977d53f.1778404619.git.caoruide123@gmail.com
>>
>> Do you mind checking what they did, and explaining the different approach, please?
>>
>> It seems there are two issues the Vega's team tried to solve: one with
>> MP_JOIN requests (what you are trying to fix here) and with MP_CAPABLE.
>> For me, it is fine to split that in two patches. I also don't mind who
>> is writing the final patch(es), as long as credits are given. If you,
>> David/Kyle, are doing that, it might be OK to add a:
>>
>>   Reported-by: Vega <vega@nebusec.ai>
>>   Closes: https://lore.kernel.org/40fd38e7a368e5b7bc9bc83364a32241f977d53f.1778404619.git.caoruide123@gmail.com
>>
>> @Vega's team: OK with that? Or are you actively working on a v3?
> 
> We seem to have lost track of this patch, and we sincerely apologize.
> 
> Our patch addresses two issues: one involving MP_JOIN requests and the
> other involving MP_CAPABLE.
> 
> I reviewed Kyle and David’s fix for the MP_JOIN issue, and it looks
> reasonable to me.

Please note that Clashiko reported an issue. A new version *might* be
required:


https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260804095051.715355-1-david.lee%40trailofbits.com

Note that both Clashiko and Sashiko are mentioning the other existing
issue with MP_CAPABLE, that the Vega's team tried to fix in their v2:


https://sashiko.dev/#/patchset/20260804095051.715355-1-david.lee%40trailofbits.com

I think the fix can be done in two parts.

> Ruide and I also do not have a preference regarding whose patch is accepted.
> 
> If David/Kyle' patch is accepted, please add:
> 
> Reported-by: Vega <vega@nebusec.ai>
> Reported-by: Ruide Cao <caoruide123@gmail.com>
> Closes: https://lore.kernel.org/40fd38e7a368e5b7bc9bc83364a32241f977d53f.1778404619.git.caoruide123@gmail.com
If a new version is required, please sync on who is doing what. Let's
wait for Kyle and David's reply. (In case of "timeout" (after a few
days), feel free to work on the v3.)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

