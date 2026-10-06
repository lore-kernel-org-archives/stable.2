Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0155381E95
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 09:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791277867; cv=none; b=ZzcMdQzwbxB5lrDixexIKghjxjRce/WDrTK3kBJA5VYoehMj73ObYcVAhgsjwAqkbkoi1dyRcha3wEUjMMd9JkzfhOxnaml/xClAfH5R/fNyJta/Y3xkZt25CExGujyyRgp9vlbIXT6Wd/T0cMjEGvYmYIR1SgF1E9PMD8Weyf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791277867; c=relaxed/simple;
	bh=fwI8ax7WBOiBr6eHBaZkPJWztTiSL5fwvD0lI2ge35k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TWOBeRP31RKWEGXYP4sdjP7RSbmnILeMJ9gOYXOD9ThWae/QcLORBxnOOip7CUA3HtoarwUKI/dDjTDQ5T8CLfnfTX/S9q7ACRQSOWEazF1QFumLAeRwi9Lw+n6A8jDrXNv1aXiPDuTnyHDufH6Kx7/33o7eAMHPaLHnj5cqF8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kN6AOoBu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kN6AOoBu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DD661F000FF;
	Tue,  6 Oct 2026 09:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791277866;
	bh=WwQ5kCe5EbBW66BKtSZrPIAp9L9+BnVQt6GmKfiH6Vw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kN6AOoBuvEQWf4Y8Vq0rAQ4NRdxjKrYhITb/TukE2tM4hzByOC04tsyU35WCXP6tR
	 zIHOqDHTJGGl+pmq1Am0RFZPJtiGD/bcJVwA0yXrToNxzVymcncoxdLqx/LzmjJx7I
	 E6O3AZvnbm5/DmvNG6PicjdL4gcjcVWbviV4+595FY+ytWawIvVoxfysj1RbKQzfL9
	 IyjpYI/sTBDNTobFLhU1REAVnP4W0/cKQeS9zNso18qfgl78LNLdAosy7MAHZyOw+y
	 7kV9CnWuWSmY7TK0J4egxXsBpZJ4FrdLlklE5NkFRcKPIAf5rAyolpQl65nQrr/Kc4
	 z/lLEr2zyZHHA==
Date: Tue, 6 Oct 2026 05:11:04 -0400
From: Sasha Levin <sashal@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: stable@vger.kernel.org
Subject: Re: stable: queue/* branches no longer updated
Message-ID: <asS7KK444n7U01u0@laps>
References: <e6ea1805-3e82-476c-86a8-096b80bde74a@kernel.org>
 <aImjNPvGPMqFu3RD@lappy>
 <9989cd82-d126-4dd3-96e5-37dad7f733fb@kernel.org>
 <c9ca13cc-a7ce-48ac-a7b2-a8bdc823aed3@kernel.org>
 <08bac413-ad6c-4e3d-a879-554ab0f195db@kernel.org>
 <anNf2xwwXDfinNQs@laps>
 <9b7ad8ef-a10a-4a94-9244-0ff983ad480b@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <9b7ad8ef-a10a-4a94-9244-0ff983ad480b@kernel.org>

On Mon, Oct 05, 2026 at 07:40:33PM +0200, Matthieu Baerts wrote:
>Hi Sasha,
>
>On 05/08/2026 18:07, Sasha Levin wrote:
>> On Wed, Aug 05, 2026 at 05:16:10PM +0200, Matthieu Baerts wrote:
>>> Hi Sasha,
>>>
>>> On 11/02/2026 11:10, Matthieu Baerts wrote:
>>>> Hi Sasha,
>>>>
>>>> On 19/09/2025 23:30, Matthieu Baerts wrote:
>>>>> Hi Sasha,
>>>>>
>>>>> On 30/07/2025 06:44, Sasha Levin wrote:
>>>>>> On Mon, Jul 28, 2025 at 11:06:17AM +0200, Matthieu Baerts wrote:
>>>>>>> Hi Sasha,
>>>>>>>
>>>>>>> Thank you for maintaining the stable versions with Greg!
>>>>>>>
>>>>>>> If I remember well, you run some scripts on your side to maintain the
>>>>>>> queue/* branches in the linux-stable-rc Git tree [1], is that
>>>>>>> correct?
>>>>>>>
>>>>>>> These branches have not been updated for a bit more than 3 weeks.
>>>>>>> Is it
>>>>>>> normal?
>>>>>>>
>>>>>>> Personally, I find them useful. But if it is just me, I can work
>>>>>>> without
>>>>>>> them.
>>>>>>
>>>>>> Nope, it's a bug!
>>>>>>
>>>>>> Looks like git was throwing:
>>>>>>
>>>>>> fatal: Unable to create '/home/sasha/data/stable-queue-builder/linux-
>>>>>> stable/.git/index.lock': File exists.
>>>>>>
>>>>>> Another git process seems to be running in this repository, e.g.
>>>>>> an editor opened by 'git commit'. Please make sure all processes
>>>>>> are terminated then try again. If it still fails, a git process
>>>>>> may have crashed in this repository earlier:
>>>>>> remove the file manually to continue.
>>>>>>
>>>>>>
>>>>>> Which my script was promptly ignoring...
>>>>>>
>>>>>> Fixed now, thanks for the heads up!
>>>>>
>>>>> It looks like these branches are no longer updated. Do you mind
>>>>> checking
>>>>> on your side please? :)
>>>>
>>>> These stable queue/* branches have not been updated for more than two
>>>> weeks. Do you mind checking if there is something stuck on your side,
>>>> please? :)
>>> It looks like the last update was from 2 months ago. When you have a
>>> chance, do you mind fixing your script please? (no urgency on my side)
>>> Cheers,
>>> Matt
>>
>> Sorry, should be fixed now
>Sorry, do you mind checking again, please? :)
>
>(Maybe I shouldn't rely on them to send patches depending on others from
>the queue.)

One day I'll figure this out :) It should be back up.

-- 
Thanks,
Sasha
