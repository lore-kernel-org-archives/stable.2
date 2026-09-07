Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A8D364E88
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 11:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788779219; cv=none; b=GopokyopfWtc7kOJiKa6Xf4s+tq003eSNkV2LYCHZXUOJ70VaZBTgop7of5r0eMCkoN8/Nw2fI8YbFAyZ+NRSkKr5gexAXVX4FL2lNPsKVPbTUDK8gdNlEeVEl2QUJoLr52hEbSFYVyUnQz7h2ebRQA0651BuLQ52wTO063i8XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788779219; c=relaxed/simple;
	bh=SkJijX5PGytK0Frv0r3Z5amD3TzfjeVjS1vVD8M1Ods=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DaBphRuFcMDk+d+5fG4qvhaeM6mSrNZU8M0lqu+wgwIkYNY3caC2cka4OiuxOE3FbincCYrBuOsb8FwZImxoypP36FK7DFHj09DoOn86WEPKrI6RMtHlpc2klL98HE4+GACOaEmiLIjRx7keSnt9aQMNZL6xmGHIAowt3lAfLCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=pass smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin.net header.i=@ursulin.net header.b=Z6QKIE0p; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ursulin.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin.net header.i=@ursulin.net header.b="Z6QKIE0p"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c250a2bc3b3so377355366b.2
        for <stable@vger.kernel.org>; Mon, 07 Sep 2026 04:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin.net; s=google; t=1788779216; x=1789384016; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dhAjW+vdg6oBYt2ixKDAKgKvkSQhUYU9D5adc0m7hns=;
        b=Z6QKIE0pJf6vSKxy08UVsdNwuKJUY1ywu1+wgRknPqcfPVwQOXsB61AgvWh4PoJ1/y
         +gIGeb6e/ZVb9RcWneoMzrvp8DhzRH6ugxDiEWAo5Sa+lc0BTOyJBaluq6Mu7xiDp3Hl
         PX4nPW/Ehki7O4PxvRSkwjqmCx/DbWh32TqpLJbOQ+4+Ad7cpfjGZVV9i2yqq/md9kx5
         /8DjiPZOfRXwpG4b3BBk+6xXdFlUYMk3XIn84eSy86R0UdDx4x296EitK9Eay0lGrM/v
         z11/dVkBLRKzihAFrn49raropmw2CwHJR+O8kF5bzp1FZIlaqYKYNi+xG9aJAdh8CsHf
         eygw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788779216; x=1789384016;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dhAjW+vdg6oBYt2ixKDAKgKvkSQhUYU9D5adc0m7hns=;
        b=kBHzI9RyPFD8lsRtyrFvr0y+whQn/mqXag3Uis+TTML+08PAbcg9T2y2Q07dYX0wbT
         6NIz7Ny5Vjq4MFpwxMYRaZo26kLKgb52gVHkeb5geIKBJ7+udC566ymc6LRh9HvoTBpi
         pLs7pZTQk9/hJ3w3Lp3QBVvsspbw0iBGXK0rMsvN9evSdEqYRzZEVM4c0fTP5VaKwCty
         6R8c6bZehv7eIoVIV5nr+TR5h/mBQnALqW8RCo7Q6poJCC2zRRJnGyNuMAZWzOskyw7E
         kr1Fma5151oL7Zxq2GOJSx+kcptGcliqxJ42KfqYWiPwra/owbu9tDlTSW6t/MjFHjAK
         Sk0g==
X-Forwarded-Encrypted: i=1; AKwUvBzU8OfUVcM/OYSY7zKwu0Yza7GWxjSTRVDNWBftMLwrmEelvAfyInTMAsbdZCtWBwrT+JDnqvk=@vger.kernel.org
X-Gm-Message-State: AFuF++ksXBvky+cpdalRv6odHLRkxh57da1CyuZiH8kqrCUu36xJgK3O
	gVi56q5O24e6yISFJS1ZeJlRHSzwwTCg4l31UQCgjKuzD5mx65Z4XTlKeav5yS510Ho=
X-Gm-Gg: AYBFou1S3ZjDNgCVP8ScwEqaYSKenFU+DIXVac9bkrQp61M3rFsiee8+8qPDLAriiph
	gpmHdUl7ggALE0g739HD6+qVVavNiKjx7iLVNpfX3hugiue+jiNhDdVVywWxzbHI09beQbtwLCe
	1liorHCt8hmzorOauQCjPWtC9FAne7LV4Wjob3E5PZ8dXHe911w0HOFndop076PMCVcO1gYPqpG
	W2ZVeKpt1VLwWzqy59rK9RRIgXHg7fguKi8nvRBv88iIjmtGtem6lvaFuAYOXf8OZxaCWCut1Jd
	HvDTFNMm8tHEovHU78hzS4M3kQRZfgAIW+GjFYXmfyIS0L0ChM1wKUpvZxRjK6DKZ2hl+2OE6W0
	GooruezzNX6IdpnL8nQpr5q3X7PQz4nEb3gQ2kZBxypGLecSTe2dD32JxhD2WZrCHbY1pZkkegR
	+1LmB+bI7uLi7exwN3H+YVXsoUGm2MYkdYSIkyhm13ccpzaBWVRKU6IeuQMDi4FZ8MceSOoWDLx
	PCnJRMJadYiJ8E=
X-Received: by 2002:a17:907:3f98:b0:c26:19e3:e986 with SMTP id a640c23a62f3a-c2619e3eef0mr722713366b.38.1788779216293;
        Mon, 07 Sep 2026 04:06:56 -0700 (PDT)
Received: from [192.168.0.116] ([81.79.79.1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c262ccca88fsm290331366b.17.2026.09.07.04.06.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2026 04:06:55 -0700 (PDT)
Message-ID: <2aa58eb8-a33f-45b9-8ee0-518d72160f41@ursulin.net>
Date: Mon, 7 Sep 2026 12:06:55 +0100
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
 <47464619-890d-484f-986b-9a6c06cd89b0@ursulin.net>
 <c3434f0a80318390d183a3a2f8f8fb3ae71c9906.camel@mailbox.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <c3434f0a80318390d183a3a2f8f8fb3ae71c9906.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 07/09/2026 11:47, Philipp Stanner wrote:
> On Mon, 2026-09-07 at 11:28 +0100, Tvrtko Ursulin wrote:
>>>
> 
> […]
> 
>>> How did the others fix that?
>>
>> Combination of kfree_rcu, synchronize_rcu and storing the name in an
>> object protected by those:
> 
> […]
> 
>> For the scheduler (nouveau_sched_destroy()) the same, kfree_rcu.
>>
>> That makes scheduler timeline name vfunc safe:
>>
>> static const char *drm_sched_fence_get_timeline_name(struct dma_fence *f)
>> {
>> 	struct drm_sched_fence *fence = to_drm_sched_fence(f);
>> 	return (const char *)fence->sched->name;
>>
>> sched is then RCU protected. sched->name is already static so not a concern.
>>
>> As you say nouveau_sched_fini() only tears down the scheduler after
>> fences have been signaled it seems adding two new kfree_rcu make is safe.
> 
> 
> I don't see how any RCU mechanism would make anything here safe.
> 
> As long as ops->release is implemented, ops will never be set to NULL,
> (with or without RCU) – so everyone who holds a reference to finished-
> fence can still run into drm_sched_fence_get_timeline_name() and cause
> UAF on the sched pointer *and* the name pointer.
> 
> Moreover, all of this falls apart should the driver unload.
> 
> So I maintain the position that we only get it right by having the
> signaled-bit be the decoupling point.
> 
> Or am I missing something?

The driver fixes you asked about and I listed work(ed) in the context of 
506aa8b02a8d ("dma-fence: Add safe access helpers and document the 
rules"). In that "world" it would have been safe. Did 035219a760ed 
("dma-buf: dma-fence: Fix potential NULL pointer dereference") break 
those fixes a bit?

I can try my IGT and see..

Regards,

Tvrtko

