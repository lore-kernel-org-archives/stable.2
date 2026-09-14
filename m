Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63ADA40EB91
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 08:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789376397; cv=none; b=DMALC4kJNWZLovgKgW7rAEuPGdyu5WpbfVP5axz9oTdmO+W2wf+syigsLipSO35f6PfXn7H4qE11O8MiNsWdJlkYuJ8PB9Y7KPYfdbnc1D4cc+lqksKmXEeqZYqPKTNCRSwesiCc9FImftAhoZG1XlNwxKVs9acwpeJQpm3er8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789376397; c=relaxed/simple;
	bh=D81fl/gThvx32uUw+g79WTFm3U19XnKDVOSUs/IWIB4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dsl8KKoLpbvou0rkR/bof2JBGcvu5N/yRpsfWoyuwSAFFuoWRuPqUP7Ho/DNxbZYJIsVFy2BiHFE2/65vRQAWbTeSRvbihhAu4RQg6IGUf1R7ph0XHsdE5yOhAbddan9dkkRcXJ5jNDUUCVKbeEvy0EHvQy3TXMphNfBHh60oTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=IliinIxN; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="IliinIxN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
	MIME-Version:Date:Message-ID:From:Reply-To;
	bh=G/R/PR/P/DBGbWwkv2jccROu48zsvnbO2g4uLXKUk6Q=; b=IliinIxNaIvZUQtrxHBUwoleF8
	YnpzrJSJXkp3ZS7X4p4l6KEWyEbngu8YcZFTM4WWj7VbR/+afxU9uN2ekQA6lf0e0+Ibp9ehojHQA
	iE7YFMfmzuHrC2e7kEY7pHPCoS+xAuUNcN07IBCND/OhFJ8WzI0k0b/emf8ujo6EL37GZqMjczpnW
	Qjo12HKJujQi2V+dtiyAcybT3TafUaPmVv1jPzliCYuD9+m4nixAZsGu+E4HU61m9LzZehvrm2e6U
	/mEkeKtyIbyhC8Bh0LhJPvVgb9A3CjCKHjFORYCe9bXllDfuSiRgS6aYaMAj0/L9SlmREy3YE6MeR
	l7DVP9hw==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1x62XG-001n84-IE; Mon, 14 Sep 2026 10:59:34 +0200
Message-ID: <acfea48c-dd63-4352-917e-a97a10a8b810@igalia.com>
Date: Mon, 14 Sep 2026 09:59:33 +0100
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
 Vitaly Prosyak <vitaly.prosyak@amd.com>, stable@vger.kernel.org
References: <20260907130527.52530-1-tvrtko.ursulin@igalia.com>
 <ad1382b98d5c6cb258658e8e85156a0ccd8dd7cf.camel@mailbox.org>
 <35456574-5fc6-4270-85f9-940201998116@igalia.com>
 <2958b5de0ab4ee1c46e2068eeb7448d6e2072ee6.camel@mailbox.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <2958b5de0ab4ee1c46e2068eeb7448d6e2072ee6.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 11/09/2026 10:36, Philipp Stanner wrote:
> On Fri, 2026-09-11 at 10:18 +0100, Tvrtko Ursulin wrote:
>>> So basically you move for locking the spsc-queue, the lockless queue
>>> which is usually used with the locks next to it anyways. That's cool
>>> stuff. I've suggested this for a while already
>>>
>>> https://docs.kernel.org/gpu/todo.html#replace-the-lockless-queue-with-a-locked-list
>>>
>>> So from a maintainability perspective, it would be far cooler if you go
>>> down this road one step further and kill the spsc_queue for good,
>>> replacing it with a fully locked list. AFAIR Christian and Danilo also
>>> have agreed to this.
>>
>> I am happy to work on that just that a) I thought some time back you
>> said someone from RedHat will tackle it, and b) lets please not gate
>> this bugfix on that.
> 
> Someone from RH might or might not work on that, and perhaps that would
> take until 2027. I'm keeping an eye open for people to pick it up, but
> everyone's always busy.

Again, I am happy to work on that as long as it is clear there is no 
duplication of effort.

> Regarding the bugfix, this was reported as a performance issue on high
> load, that only seems to be reachable for CFS users, a brand-new policy
> that is marked as experimental and is not used by anyone in production
> yet. So IMO we can move on on drm-misc-next with spsc-queue, which will
> also make CFS usable then.

I think more logical order is to first fix it with a small backportable 
fix even if experimental. That way people using 7.2 can actually test it 
and contribute valuable feedback.

> Is there a plan btw as to how you would like to proceed with CFS?

So for me the most typical and useful plan, and in the context of the 
desired spsc removal, is:

  - Merge this fix so it gets into 7.2
  - Spsc removal RFC for some upcoming release N.
  - Remove experimental status from fair policy for kernel release >= N.
  - Switch fair to default at >= N+1.
  - Remove FIFO and RR and simplify to single embedded run queue at >= N+2.

Regards,

Tvrtko

