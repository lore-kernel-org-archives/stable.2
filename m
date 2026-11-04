Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793781239;
	b=t1CsEolTvYfqMdQkq4jbD3n1BvKdi23LkYF1mmU4eBGouh56tvnDBLZQlE+j3xGhmtUq
	 1IwaOMZNx+G/lnw2PDX2No9bSMurV5z83MEhIWIlMjT7bHI4HdL8lQkVyD6YLETBDQaal
	 HZaQixheVmmod7eBxuLKcqLVZ8udkraRbFyX30HC6oYorRa47UOmqSsTGlabaub0oFfng
	 IRPmYlNkPn8WR6xAjAhEgFEi1NjBmoXAODJhJ1y59MIbyjWvcUyjQMvPHTcDKJUMsSST5
	 LJs3oZiJMuBV3ys9SKxTFLAeJGuNqY+i5pNdrLAfMV80AhiK9rbxMhcM9IRcd1Z3gVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793781239;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=OjgfVkz7I6aaeDs/niXGQ9dYXWbLr1dkB1rbziP/69o=;
	b=lKqaycPDsUPUvg9YM+0uU6p7Inr5+4MzbpWTCJQ/oLDJReUA7OqFYSZBZzBMfGvDZeCI
	 Yh9a4HY2m6L47cG45wvLxyJI3gGG2gB2CWTYDoV8GqoaB+yt56EROvbj9oOoNvgnzWF92
	 vwbiRz294WGn1k1qSRomXFxNaUNb7mAuT2Do1KSfKY4l3nvDVnXLtFtONLsBkHMwlxFtH
	 4icnehHV/f67145eFaza/UX3cNg1ZCwQNVMT8EDeAZFpS6uyGg27WIRZjxsQmOpHMK2ci
	 Q71789XeodJ8EOHm+sfExGcBjj0nv9qFmktulqYLy340G5u9s+Zv3KdNqOpYAlCpypA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=JySAjbcG;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B6C606A326
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 08:33:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9B6C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=JySAjbcG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
	MIME-Version:Date:Message-ID:From:Reply-To;
	bh=OjgfVkz7I6aaeDs/niXGQ9dYXWbLr1dkB1rbziP/69o=; t=1793781237; x=2109141237; 
	b=JySAjbcGi4pZ+yE+c1cVnaXo5899SFiC5cd9rPuFLPMfxBzi6NC5i+EVJtz30nH9OVXl6CHE2YN
	cFFRggX6NKswo/xFbTYtqYgArO8Mf3X1aw41Owc/EXExskWtUZbVANozlloShRKmB8tz11L8EWz0J
	QzNXRPMTdIyzn0JaHjoly6uX2G8dKoPQHoEGRWMQ5bpE/rzGlVZ+SJJEpfY+wySu+r0bOWR+uqSe4
	AOTw5JqK1OiDGPEEf4tpoghQaG1UTzrzneS1GDocclbwrImNBuc0ErWTzQ9fqXZauRIz/iVYp7RWz
	meZKBku5SUiV+zGdMt+qtki3DHzDG7CeaUZw==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1xOWRF-0024QM-Ow; Wed, 04 Nov 2026 09:33:45 +0100
Message-ID: <64e2b65e-afe3-4fc0-8201-03cb72ae5d32@igalia.com>
Date: Wed, 4 Nov 2026 08:33:44 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/sched: Adjust run-queue when changing priority
 at runtime
To: phasta@kernel.org, dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Danilo Krummrich <dakr@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 stable@vger.kernel.org
References: <20261021094227.48034-1-tvrtko.ursulin@igalia.com>
 <20261021094227.48034-3-tvrtko.ursulin@igalia.com>
 <84b5777a04dc75c013eb9ac0a44d972cf88db12e.camel@mailbox.org>
 <6e113935-f303-4f49-bc27-e1d85abffa70@igalia.com>
 <72cba5d23a977185696db12ac547174708652bcc.camel@mailbox.org>
 <dd6e0f86-67e8-40c0-bf8a-1948623d0646@igalia.com>
 <6e9a32c633eec28b9d5e539b9e35c00a26ea5bd4.camel@mailbox.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <6e9a32c633eec28b9d5e539b9e35c00a26ea5bd4.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 04/11/2026 08:18, Philipp Stanner wrote:
> On Tue, 2026-11-03 at 16:03 +0000, Tvrtko Ursulin wrote:
>> I'd like to get the fixes in so I can mentally focus on the continuation
>> of the bigger story. Not least that not fixing it causes sashiko to flag
>> the bugs, either when touching the neighbouring code, or possibly even
>> just the logical functionality.
> 
> 
> Fine by me, no major objections :)
> 
> The only thing that makes me a bit uneasy is
> drm_sched_entity_set_priority()'s semantic. I know it's only used by
> amdgpu, but nevertheless the reader might be tempted to think it should
> only change the priority of an entity within a runqueue.
> Could you add some sort of code or doc comment hinting at there being a
> TODO for the future rework? Good to have that in case any of us is
> assigned to work on different projects in 2 months.

I lost you here - what should the comment say?

Regards,

Tvrtko
