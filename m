Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D85A47254E
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 12:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789389141; cv=none; b=Tlh3/B5iXqk48Gy71bxUpC2EjM7+ZE0fsQ1taLQ+9qjwgTkSJPPy1+81qdk5RNgSKVycNbW2li5h7cZU77d2Xv+F2k6rDSEjZ1lhvMtAIXx89aHoXohGRtyZrM0YJao4TOs1TblRCGRgXVsapdw82k4DaPpv4delebB0+Hye0Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789389141; c=relaxed/simple;
	bh=+fOiQTnkTmpJbLYRZ9/Q5E7hEq6RfLKVncPsyE+rr7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OQJNBH7a0EgA47hNG/Ixf04srzTdeG5YOWzvFtpPi6MBq6bkPLcrcigZJSxPdM0b2nlGXrqzeZCpcfpOPRcNjlwEmZqAavHCs5fFrgsxYSk0bqKWhVR9LSBF8eFe2HcWsqs+jeFRIpgUYfxQCFy81OWl0jHUyQRx+voGo82fPrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=foT6zmTt; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="foT6zmTt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
	MIME-Version:Date:Message-ID:From:Reply-To;
	bh=9VwukusgPm9e0Lht5ZLJvSK52XJAEYkHUFW/zmkg238=; b=foT6zmTtsLD4UTca2ch97HA54F
	pms5Hx+PmG4Fs7Dy+XboBB3oxxq3MqMi0mnBsn7MedWbUGyDnVFL6EcaG6qUjS4mdc8MQ4EcoCTBe
	vpdrnIOtW62gEM+xHwLc9jnaabtHfTkVohaOZ833piJzmDh1u2zH50DIOGgMIKzCS5Rr/mm2m0Hex
	fWEMofl2Kv8iJO17smT1/MCXxkVzoiPJ0navg4akvH0BPxDGXRPsx0jZ/TGGv03f0sMiC7brPq/AL
	F0M/0ZPZgtVjQFShIpZLuGEHtWImj9SXTavQ1DzjHN61MuQTc/XWy1J5NtGHOmPkRafGusYR3aHGz
	ijD8KWTw==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1x65ql-001su9-DF; Mon, 14 Sep 2026 14:31:55 +0200
Message-ID: <0766f89f-380f-49ef-a55b-dda1d3bedeac@igalia.com>
Date: Mon, 14 Sep 2026 13:31:54 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/sched: Do not restore unsaved virtual runtime
To: phasta@kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Luke.Wildhardt@proton.me,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>, stable@vger.kernel.org,
 Michel Daenzer <mdaenzer@redhat.com>
References: <20260907130527.52530-1-tvrtko.ursulin@igalia.com>
 <ad1382b98d5c6cb258658e8e85156a0ccd8dd7cf.camel@mailbox.org>
 <35456574-5fc6-4270-85f9-940201998116@igalia.com>
 <2958b5de0ab4ee1c46e2068eeb7448d6e2072ee6.camel@mailbox.org>
 <acfea48c-dd63-4352-917e-a97a10a8b810@igalia.com>
 <28a236dcae3e2cac75b4f5afc091136db04134e7.camel@mailbox.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <28a236dcae3e2cac75b4f5afc091136db04134e7.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 14/09/2026 10:37, Philipp Stanner wrote:
> +Cc Michel (for the sched policy removal plan)
> 
> On Mon, 2026-09-14 at 09:59 +0100, Tvrtko Ursulin wrote:
>> On 11/09/2026 10:36, Philipp Stanner wrote:
>>> Someone from RH might or might not work on that, and perhaps that would
>>> take until 2027. I'm keeping an eye open for people to pick it up, but
>>> everyone's always busy.
>>
>> Again, I am happy to work on that as long as it is clear there is no
>> duplication of effort.
> 
> I asked and made sure no one is working on it, so from our POV you have
> green light.
> 
>>
>>> Regarding the bugfix, this was reported as a performance issue on high
>>> load, that only seems to be reachable for CFS users, a brand-new policy
>>> that is marked as experimental and is not used by anyone in production
>>> yet. So IMO we can move on on drm-misc-next with spsc-queue, which will
>>> also make CFS usable then.
>>
>> I think more logical order is to first fix it with a small backportable
>> fix even if experimental. That way people using 7.2 can actually test it
>> and contribute valuable feedback.
> 
> I took another look and I think my only issue is basically just that
> the patch addresses something which we should have done regardless of
> the bug at hands. So I'd be already happy if the commit just had a
> different title and slightly extended commit message, like:
> 
> "drm/sched: Fix vruntime race by extending locking"
> 
> plus sth like
> 
> "this simultaneously serves as a preparational step to replace the
> spsc_queue as a whole".

As I think it is fine as is I would prefer not to spend time on a respin 
unless you insist.

>>> Is there a plan btw as to how you would like to proceed with CFS?
>>
>> So for me the most typical and useful plan, and in the context of the
>> desired spsc removal, is:
>>
>>    - Merge this fix so it gets into 7.2
>>    - Spsc removal RFC for some upcoming release N.
>>    - Remove experimental status from fair policy for kernel release >= N.
>>    - Switch fair to default at >= N+1.
> 
> Couldn't it be enabled first for dedicated users? AFAIK it was
> developed with Steam's gaming platforms in mind. Can their OS devs be
> asked to switch it on or test it downstream?

It wasn't quite developed for single game use cases, but with the wider 
goal of improving the code base and DRM landscape in general.

Also, I think it could give us false confidence since the matrix of 
hardware + kernel setups is quite small. Even this bug wasn't caught on 
an official platform, neither could I repro it on a Steam Deck. So I 
would say a release or two after it is set as default is quite safe 
since it can be easily reverted with a one line change.

Regards,

Tvrtko

> 
>>    - Remove FIFO and RR and simplify to single embedded run queue at >= N+2.
> 

