Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18EB481656
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 16:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785946080; cv=none; b=cQeSD8c1lwI/1JUWDQm9RivLfEaKqaV1wADbE73+K3Gr3Mus5e4OXuk2kXhY5ddYwRKuheM/oTcfqHDGnC2LzDhXF9w2keDtoEpISNbE79DnvbMXdDqhdd2+v7i9SSkXtvFLKKZ60j+7uNdh2+UBcFHmLZBj3M0O936jLBybnVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785946080; c=relaxed/simple;
	bh=vbJTxFmkUVmBVdcDjqblG5BaXhK0ANRfmxe9FwC+XoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hbxbZLVi0dZplhSS0lUtpvFLMfC/rWSjwwMFELw2XUoY08ycWSHnDaHgPK37nsXK82DEpTNFUEzFJ3481y8lRoqFAWRRmJ2O5G3f5GlYcl5PQd6HJLA6d2K5UUFVWyLa+7Llm3+LNffH2CXIemwFwnUW03dqZlVr5s+qZF6uyMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CGl1CaaA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CGl1CaaA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CA6B1F000E9;
	Wed,  5 Aug 2026 16:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785946076;
	bh=xfkP1VRMTP9C/Uvq4ozSgRwUcqPg0TUyBRkDeu7e0tU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CGl1CaaAA21iP/os4C6PTqdNGn1lQnPaPtaTg8bFOtrdPw0nWhN/BjlPoXw7R2KCt
	 3HNjSsKD2mfNC5zBlKlXPil97bLZSZFFsJoUcOlAIUDM02usNGjuN45YoMTMpF6t/V
	 NBkyJLJzAtHIrrCo9AYr/8ebpthYEA7rEW/DnMO0ngd8Q3m822c/5z22mJ7XRz7iNx
	 WcpOeDbjXs7iRg34WTgat5nZi58MQfgrxw7kDJ+U2kvC7y+Arz0AXhkFN+xx3PfCOI
	 5U3Pgv4I9zOM0/K4NBi1g6ltgISg/dEzGsVv0nVQuUGyUUOwGoWBjrKdIgaRQuWu4M
	 bykx98o6Iyj3A==
Date: Wed, 5 Aug 2026 12:07:55 -0400
From: Sasha Levin <sashal@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: stable@vger.kernel.org
Subject: Re: stable: queue/* branches no longer updated
Message-ID: <anNf2xwwXDfinNQs@laps>
References: <e6ea1805-3e82-476c-86a8-096b80bde74a@kernel.org>
 <aImjNPvGPMqFu3RD@lappy>
 <9989cd82-d126-4dd3-96e5-37dad7f733fb@kernel.org>
 <c9ca13cc-a7ce-48ac-a7b2-a8bdc823aed3@kernel.org>
 <08bac413-ad6c-4e3d-a879-554ab0f195db@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <08bac413-ad6c-4e3d-a879-554ab0f195db@kernel.org>

On Wed, Aug 05, 2026 at 05:16:10PM +0200, Matthieu Baerts wrote:
>Hi Sasha,
>
>On 11/02/2026 11:10, Matthieu Baerts wrote:
>> Hi Sasha,
>>
>> On 19/09/2025 23:30, Matthieu Baerts wrote:
>>> Hi Sasha,
>>>
>>> On 30/07/2025 06:44, Sasha Levin wrote:
>>>> On Mon, Jul 28, 2025 at 11:06:17AM +0200, Matthieu Baerts wrote:
>>>>> Hi Sasha,
>>>>>
>>>>> Thank you for maintaining the stable versions with Greg!
>>>>>
>>>>> If I remember well, you run some scripts on your side to maintain the
>>>>> queue/* branches in the linux-stable-rc Git tree [1], is that correct?
>>>>>
>>>>> These branches have not been updated for a bit more than 3 weeks. Is it
>>>>> normal?
>>>>>
>>>>> Personally, I find them useful. But if it is just me, I can work without
>>>>> them.
>>>>
>>>> Nope, it's a bug!
>>>>
>>>> Looks like git was throwing:
>>>>
>>>> fatal: Unable to create '/home/sasha/data/stable-queue-builder/linux-
>>>> stable/.git/index.lock': File exists.
>>>>
>>>> Another git process seems to be running in this repository, e.g.
>>>> an editor opened by 'git commit'. Please make sure all processes
>>>> are terminated then try again. If it still fails, a git process
>>>> may have crashed in this repository earlier:
>>>> remove the file manually to continue.
>>>>
>>>>
>>>> Which my script was promptly ignoring...
>>>>
>>>> Fixed now, thanks for the heads up!
>>>
>>> It looks like these branches are no longer updated. Do you mind checking
>>> on your side please? :)
>>
>> These stable queue/* branches have not been updated for more than two
>> weeks. Do you mind checking if there is something stuck on your side,
>> please? :)
>It looks like the last update was from 2 months ago. When you have a
>chance, do you mind fixing your script please? (no urgency on my side)
>Cheers,
>Matt

Sorry, should be fixed now

-- 
Thanks,
Sasha
