Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516AA44604E
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 07:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791791169; cv=none; b=gEyaYBioQign7XdHQlKqI5VgP3MgU91yTMVBbSLMtHLRa90fsH4NOuILBWZ9ZHTZUKAJbHihCuOAtxne2yjo9GV3iYTjT/P5S51Kh9Hbky4K7F/6UxqcXBf5FBags+OuX5vXzSGv8qdoOlzyL/P/U2Rm9rmnY6pdhuZSJZ/Du2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791791169; c=relaxed/simple;
	bh=zWVsuj/ru3q95cCd/6cDOAqJPRoetdPZGWTKPAQPs/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HQwJEJsB0iNQM8quDFbsY99oQFXj7WO5agjvo8qn+rLYf5vlCEyOCFdvb18id78N+ueQAg1T6P4EBEWGsHZnsLI4nOFK3OtewkhKtCbXBvPQitXx4nCyPs6IthOWWfz5R1/ExWo6mfgjeyneV1yZqp9Otm/bnK+cZSeH46HcubE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=jTP7xg4x; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="jTP7xg4x"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
	MIME-Version:Date:Message-ID:From:Reply-To;
	bh=TmnLgP+y1H71vWYuXUmZTmFTkqquXDqtP7vLnEohO00=; b=jTP7xg4xqLq4sdswNhW7Oa1tec
	D0MuJ17lq+LwL3+AGb36fmIauiQ45RoQXnQmP7ZHpgkBAhZYhxWvwRawJjQCxipEjEaAO+FE01wck
	WY8iKt8sqCYIgwaJxrIpKYSsoBGIGNptYb086FJ1kfDLqtvX8s9G9WwRQBPol/SubBH/BlfcMO+9a
	RmcIUB8AvVinjFn+4Iw0QO0hit9apMZepk0zslCFAOd/cV7xjztdueWwplnUtHP8BZ0KnO8MuNbV5
	oCV1izqNolV/COOPRhwhgBlod6YJIw7lfIFiF53LuZVPScxVdb8GwaPOVtHLoQjnkBBDvQzQQOiJy
	tu3pnIyg==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1xGAj9-00GE47-9r; Mon, 12 Oct 2026 09:45:43 +0200
Message-ID: <770ded5a-e406-43d4-9909-1531de89fce1@igalia.com>
Date: Mon, 12 Oct 2026 08:45:42 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/sched: c
To: phasta@kernel.org, dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>, stable@vger.kernel.org
References: <20261002124622.74696-1-tvrtko.ursulin@igalia.com>
 <154fd1c6273812a804799cb82d11655c1726a83e.camel@mailbox.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <154fd1c6273812a804799cb82d11655c1726a83e.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 08/10/2026 11:18, Philipp Stanner wrote:
> On Fri, 2026-10-02 at 13:46 +0100, Tvrtko Ursulin wrote:
>> When the out of range priority at entity init time is clamped to the
>> number of run queues in the supplied scheduler the internal run-queue
>> priority needs to be adjusted as well.
>>
>> There is no impact since none of the drivers hit the clamping path, but
>> we still need to address it by moving the entity->rq_priority assignment
>> to after the clamping is done.
>>
>> Note that a lot of this will hopefully get removed once again when the
>> single run-queue simplification lands.
>>
>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>> Fixes: 2fa4d8e2c109 ("drm/sched: Add fair scheduling policy")
> 
> Help me out here; we recently landed this fix [1] that Luke reported.
> Is there a relation? I guess not, since you say there is "no impact".
> 
> This did not exist before CFS in drm_sched, did it? Did you discover it
> by review?

Bug did not exist neither before CFS, nor with full CFS. It surfaced 
after the reverts of FIFO and RR removals and the single run-queue 
simplification. So the bug was in the middle of the original CFS series.

And there is indeed no impact, it's only theoretical. There would only 
be impact if any of the in-tree drivers would passing an entity to 
drm_sched_entity_init, with a scheduler which has fewer priority levels 
(run-queues) than the entity. And I am pretty sure no driver does that 
otherwise this would be firing:

   dev_err(sched_list[0]->dev, "entity with out-of-bounds priority:%u 
num_user_rqs:%u\n",...)

Which was there for ages, added in
2bbe6ab2be53 ("drm/sched: Fix bounds limiting when given a malformed 
entity")
which says it should not happen. So it would have been noticed.

And yes, I spotted this while working on patches leading to the spsc 
removal.

Once we re-land the single run-queue simplification the check and error 
log get removed once again. But until then I think it makes sense to 
have the code fully theoretically correct.

Tvrtko

