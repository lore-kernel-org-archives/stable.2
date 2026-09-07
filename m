Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFD6455173
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 10:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788776895; cv=none; b=g1TQHrxE3pySnI74pdcNlttQ124oKnrDfQh+ERQLXeXCnx9gM/zur7Ct14/8bS8bbb6Qh0lOqCkjW8/9Xql8WrYf4hFCi4PEbIXkdvTCtv2bGgVOEYc9eb1Aih+tTggywLUGrD351NxURaD65FLB7j4J/6Djw0t82+7WYO9jP94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788776895; c=relaxed/simple;
	bh=QNABwq8y/rpjyYrMChWDaMxtxVD9keFqxXBvr4Y6598=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pE90bSN+rfvmFxvXtQpROnRA9/bDSlimnsQDABNZimAOs/3fdbzC/UR/DrC7o7SQ3mLnOW8gWFXKkxGOMAm/ty+1kOMDoUFM5BOILeAwuc4UbZ/VZ4ZNsohfI7YtQ91qXB7DHXHp0maquVVRScy8eO8VxkTK7yf6ZmSy6g/mixc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=pass smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin.net header.i=@ursulin.net header.b=ttcy87EE; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ursulin.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin.net header.i=@ursulin.net header.b="ttcy87EE"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c255c58156bso649148966b.3
        for <stable@vger.kernel.org>; Mon, 07 Sep 2026 03:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin.net; s=google; t=1788776892; x=1789381692; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ABEcogDwsawzeRdmBozIgKVzjqJVU/2yTKqGiwVKefE=;
        b=ttcy87EEXirnGN1jx4Q9fXXfJ8QhZhKz5bfadKytn6R2nh5C7nCrLyWmK70EaitsO0
         5f2CcMGR4g3X2cDDljhiMSQJvHYkuOk7N2pr6TRQFEJ7JGn200hfPmP6jYXlHUZqZ13s
         t/BMw4Z0V00mwEDP7nqqgr13yi2HaidAkpq/eku9aTP20IGFjuLKBubpYMuGfjGY+48Z
         WXsNdIXCv4cA7MEt5s9VVruCEpTAEGAh51b/TmH0dZrJ2D4QktGo1menUPs6OEtr/MGy
         xLyY7L01DYL/MxAUiwhlEeVh4UTyrSTmNTmxDOKev+IiWWoksBaHB35PfcjE0bgnUuQR
         89PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788776892; x=1789381692;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ABEcogDwsawzeRdmBozIgKVzjqJVU/2yTKqGiwVKefE=;
        b=UYrX57+bq+RB81kstCj8+sKFeOU1Xrt/K1ydL8tZWGFXjE9BcwLZ8YDzwdxzt/eYoO
         kFvLyFNW6qXV2pq2F6Dnp3KOeae1ZvelWP9DZlDqoI9Ilcl+X97/V0PwZTvxAisorwEq
         ZI1txwdj9kUwGVujTJ7s5LoB9MgNTE3S0YhsGbdyDkopAPNQ8bKdoLqZhf66bxNGklJG
         P9NlvX/0M0ASB+BKjOmj7zfmhiXexvpHIwVr624YaZgu8gfK3JQPMC7D4pJRbbj7QqH5
         8Rp4FlnUMJX29iCya1oY55S2n4CMcyVcX8Jdkj6B2N40MuE40IqSpQiTpDZ72zrI8z17
         EWZg==
X-Forwarded-Encrypted: i=1; AKwUvBzCi+vdDsFXYJns1IsgRWClnEzg8uFcjYKeNiQEzbAdsvkXsmgMjou6R7VUn399r8uB45DAoG4=@vger.kernel.org
X-Gm-Message-State: AFuF++naZiT8NhCRq0vLSQBQuAnYNhbuK/AAoAXnf9y6KdtNJTaQxxgs
	01iYapAXFnAk4RK5I4i3oB1CZbRnN2yZ3OQNTvKgwl6PfGwkOFOwhhX6zt+Mh5P9l30=
X-Gm-Gg: AYBFou3vuI4zd+sPgpblZc/0EzO4Wha67hYDOycniyz7TAboX4knJUp9c5mOt6BDAy/
	LDPoDMcPG3s607xffEJOriwZPELN5Orv8Mxp/tbsEvvS8UqE1Fecsl1jWWeJVDA9LDhdZWeT3mP
	Saie/VKs3eSfJ7pWoeHWPh2ID215IC3eGJyRhIZTYYVXosKynlinzcdhZymkWmXA9u6MZnVoh9d
	LNP2oDemZP7bqLmvqnZE6mp/BDseq4Xzcbd1Kyq81a9xS0VTpGjqWCqdgQVgPWALfRAfUukSSIs
	oBzvEff3mumahhGole/Q9oXe0I/gcUhjPUAWNqqbQfC13J2an/rbCLFN7qLbOOD8nPbPAu0XJCI
	8Z5QwMUjpMObHZfF2RH5V9Pq0S4JSO6BLpZzbanInw8RtHEXu0JC53riJYlPFABdJW/pueTBDYa
	MTzB9W+dz5ibsAM9mUZ5Pj6cN7xSAx5N46UiGB5EjZhtkFDMVKQDzbFatWw8m8f7lVpklYzekJc
	QzDi+AaBaz6SlM=
X-Received: by 2002:a17:907:d11:b0:c24:e1e9:69c with SMTP id a640c23a62f3a-c260c3f93a7mr886509866b.0.1788776891620;
        Mon, 07 Sep 2026 03:28:11 -0700 (PDT)
Received: from [192.168.0.116] ([81.79.79.1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d53c37csm439345766b.32.2026.09.07.03.28.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2026 03:28:11 -0700 (PDT)
Message-ID: <47464619-890d-484f-986b-9a6c06cd89b0@ursulin.net>
Date: Mon, 7 Sep 2026 11:28:10 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] drm/sched: cache the timeline name to fix a
 use-after-free
To: phasta@kernel.org, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, "Jonghyuk Kim(MalHyuk)" <malhyuk97@gmail.com>,
 matthew.brost@intel.com, dakr@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 mdaenzer@redhat.com, alessio.belle@imgtec.com, luigi.santivetti@imgtec.com,
 stable@vger.kernel.org
References: <20260904080618.2098450-1-malhyuk97@gmail.com>
 <20260904080618.2098450-2-malhyuk97@gmail.com>
 <f25f2a91-b72e-4392-ab53-c11ef60e0fe0@amd.com>
 <ee27d37269f609192cdfd7a217d9731d7dca04c8.camel@mailbox.org>
 <a41a35b8-c78b-4c18-af11-26374918f222@amd.com>
 <7e4497506bb051fd1c25ed54f88a8036084e779c.camel@mailbox.org>
 <81e51d72-d608-46d0-a986-390ecd6f468a@ursulin.net>
 <d3d2ae0ae55fb07780f643de9517f3668484575a.camel@mailbox.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <d3d2ae0ae55fb07780f643de9517f3668484575a.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 07/09/2026 10:42, Philipp Stanner wrote:
> On Mon, 2026-09-07 at 10:15 +0100, Tvrtko Ursulin wrote:
>>
>>
>> On 04/09/2026 20:06, Philipp Stanner wrote:
>>
>> 8><
>>
>>> If you can think of a stupid and simple solution, shoot. The only thing
>>> I can think of is moving the string into the dma_fence, as a hard copy
>>> :)
>>>
>>>
>>> In the mean time, my proposal is to keep aiming for removing
>>> sched_fence->ops->release and fixing pvr and amdgpu.
>>
>> Fixing the drivers sounds like an obvious thing to try indeed. Along the
>> same lines as it was done for xe and panthor. It is an already
>> established and well understood approach so shouldn't be controversial.
>> After that we can discuss in leisurely pace if something better is
>> possible in the scheduler core.
>>
>> I understand its amdxdna, nouveau, and msm. Was it attempted so far? Is
>> it significantly more complicated than it was for panthor and xe?
> 
> How did the others fix that?

Combination of kfree_rcu, synchronize_rcu and storing the name in an 
object protected by those:

6bd90e700b42 ("drm/xe: Make dma-fences compliant with the safe access 
rules")
299bc6d50b1b ("drm/xe/guc: Keep scheduler timeline name alive")
efe24898485c ("drm/panthor: fix for dma-fence safe access rules")

Not too complicated on the overall. Simply ensure RCU grace period 
between signaling the hw fence and freeing the ops, scheduler, name, all 
that it is in the externally accessible dereference chain.

> If we look at nouveau:
> 
> static void
> nouveau_sched_fini(struct nouveau_sched *sched)
> {
>   struct drm_gpu_scheduler *drm_sched = &sched->base;
>   struct drm_sched_entity *entity = &sched->entity;
> 
>   wait_event(sched->job.wq, nouveau_sched_job_list_empty(sched));
> 
>   drm_sched_entity_fini(entity);
>   drm_sched_fini(drm_sched);
> 
>   /* Destroy workqueue after scheduler tear down, otherwise it might still
>   * be in use.
>   */
>   if (sched->wq)
>   destroy_workqueue(sched->wq);
> }
> 
> 
> We see that it
>     1. stops accepting jobs from userspace (not visible here)
>     2. waits until all hardware fences in this ring are signaled
>     3. only then tears down drm_sched

I cannot do a very deep dive into nouveau at the moment. I see fence 
itself is already freed with kfree_rcu so that's good. What is reachable 
via the timeline name callback:

	struct nouveau_fence *fence = to_nouveau_fence(f);
	struct nouveau_fence_chan *fctx = nouveau_fctx(fence);

	return !fctx->dead ? fctx->name : "dead channel";

Fence is presumably the fence so channel. Chagning to kfree_rcu in 
nouveau_fence_context_put() there might be enough for that one.

For the scheduler (nouveau_sched_destroy()) the same, kfree_rcu.

That makes scheduler timeline name vfunc safe:

static const char *drm_sched_fence_get_timeline_name(struct dma_fence *f)
{
	struct drm_sched_fence *fence = to_drm_sched_fence(f);
	return (const char *)fence->sched->name;

sched is then RCU protected. sched->name is already static so not a concern.

As you say nouveau_sched_fini() only tears down the scheduler after 
fences have been signaled it seems adding two new kfree_rcu make is safe.

Regards,

Tvrtko

