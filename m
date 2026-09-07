Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E48F5474E
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 12:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788784140; cv=none; b=tdwvharY7DAUoAPVu/bBA1YXwbZHVXJfdPXCZqZ6kLW1GGyb36Yx5c4kFuq8TDX6N2Cg6X7n7dFqHgEUQTQACtEOP4mOsMZ7wIW1ew3XevEc7vj4ilek2mW/Lf34VTLXk/xHcQ3qm4oDWn6lYGHp/ilFe2fiMiqhKnE9M6+pt2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788784140; c=relaxed/simple;
	bh=AAZwLzfr8jr8YZzC3uwVFUEWgXqesfwXs8POQkuBsbo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Wr0c7TldIHp2R/7hFs0TxVWDrM8yfR1q+YeD/E5BsOayLBJ4CY6MllXTC8KYnb4+ZHAwdfpsO2zO+fAirRwchZY4UDofxpBnwHxMKomBr/4DWGdvtf3VYXnKC0msJdhiZ2jtYTOPJrb9VPCq8KhZYPmlE7jP/notvon+Oq5ezqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=pass smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin.net header.i=@ursulin.net header.b=s55hlTWj; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ursulin.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin.net header.i=@ursulin.net header.b="s55hlTWj"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6a668ce86abso5159795a12.2
        for <stable@vger.kernel.org>; Mon, 07 Sep 2026 05:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin.net; s=google; t=1788784137; x=1789388937; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aJm8oYa2XMgACvK1LNx+Nj4anO8CYxc+Hsnqz6K6hAA=;
        b=s55hlTWjRIy/MDCaR0egHL9ltglEOE2im7UrWD3yTr/JrKyJwZTpX/Md+HSWYFWYML
         srPMcIGkRsd1K687NBA8/jXrnjCoZdYDMnPky+v37ZX2s73W2ojUt2f9Udpc51tteo5c
         XUK9GSM8fTcmU+OSn2hR+KkCXgX5QKpu+nzcnlwj1CBponDT7UyITLdofFY+F/cLGz+7
         QpqpGB4uMdCYV/pOvVOl4TWaeiEjJiy524aQrG2JYTn6wfwbYsB3MdYsq8zRb3yvxiTQ
         0JV1rBZlNwQZYbuJYudE7iIOxYlboaJ1ycrig6nmjKdSyt+5rM5cf1xyq5R2RaDXxvsH
         /gJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788784137; x=1789388937;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aJm8oYa2XMgACvK1LNx+Nj4anO8CYxc+Hsnqz6K6hAA=;
        b=WwnTIf5UduuC5ktjWGrzJ/tq5DopCO24UZe1cLYEf+UytyuFSqspjWJgM32K9XrLQP
         UK7sDLL4lh2CspIxJRWmX1ko/oWTZilIYY/S53AW9+UmJyW0J2wb/cRdGMITbYqEicK+
         TShRyndP7jwyIO/W/FH5e0UYsnL1c5cQ/l30lUux4gnjS1ZshI85dEOolLgf/Iraf4Nr
         mUv9Pts5c05d9SDXGdQHKFFog8m8XtRmz/yvxA0ODHb6HoyCUdeMK1mzVJDI1M21zRQJ
         bkBoaMsOvZy8PSUDGhbDXMczMqootcU7sU6g/per5zhibhWEYqIF5TfZytW/19UlHDdU
         vnCg==
X-Forwarded-Encrypted: i=1; AKwUvBzx+KuIZi2N5oe7U7Zzgg9khxPViytzrarvKTAgo0IqG9hPjCghSw3oH5rmGIK2r9Pu/z/sQMQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mAht6jMwIt3B0tYJAzoouUKQiQUeo6r4Ifo6vTN14z4xVrbLHC
	u2Ia837I4Gw8CBZanf94/T40KrMPpZJ7GlnI2apr3CdQ3RjzeQ9x3accz3WTgxj0x2o=
X-Gm-Gg: AYBFou1UjxWzF7MtqCKnjPsrEvO6i4KWFY/dXPIRCdW5jQlTi9AzO55Vl2yvnjE1b5M
	6JyuBllNa5WEUQTgGnTTRqmFgj+cf4dj/axXwJLobVGC0F0hHmSOQn9bIcd1kQt3zY7fPoUk17I
	F97vK9xcrOmlMhX4HN5AnySlqI6T9ck14lLWsG/XJKS3fzNYeb9MfSu3UQaj6kiRWD1QIhIK8Xi
	Wv93JHT/iHBojd+G29AU6KzEVg5SpEyGowSqDPBHo2dqPLp7gefd6w8azIRVp8UCOFXCIw2fAKF
	GigwkXckgan9+rpi1TEztAt/dozT1ydRaYYecjLgsA8yPiY+nT7fvA4Qce1fKQzx85x8RIiaks5
	AgP+9+1wB1u1lvlhGUvQA8nb1xt36utUTAI+pYuRlZ98esqkKfxpEyF4MncFhGWG3baFIyEDkqo
	YcIwgWpBvWq6N/qtrzZyKoO9SMBLMeUprsdE3QmSnqcD5pvw6YVxvpnkrHIt6d3SQCnPEJKiCnG
	Aks
X-Received: by 2002:a05:6402:270a:b0:6a6:32f5:90b4 with SMTP id 4fb4d7f45d1cf-6a7e90a5f76mr13059715a12.22.1788784136511;
        Mon, 07 Sep 2026 05:28:56 -0700 (PDT)
Received: from [192.168.0.116] ([81.79.79.1])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a7e66eb84dsm4416331a12.2.2026.09.07.05.28.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2026 05:28:56 -0700 (PDT)
Message-ID: <96eb6288-5c85-47c0-8f72-57d6f138851e@ursulin.net>
Date: Mon, 7 Sep 2026 13:28:55 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] drm/sched: cache the timeline name to fix a
 use-after-free
From: Tvrtko Ursulin <tursulin@ursulin.net>
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
 <2aa58eb8-a33f-45b9-8ee0-518d72160f41@ursulin.net>
Content-Language: en-GB
In-Reply-To: <2aa58eb8-a33f-45b9-8ee0-518d72160f41@ursulin.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 07/09/2026 12:06, Tvrtko Ursulin wrote:
> 
> On 07/09/2026 11:47, Philipp Stanner wrote:
>> On Mon, 2026-09-07 at 11:28 +0100, Tvrtko Ursulin wrote:
>>>>
>>
>> […]
>>
>>>> How did the others fix that?
>>>
>>> Combination of kfree_rcu, synchronize_rcu and storing the name in an
>>> object protected by those:
>>
>> […]
>>
>>> For the scheduler (nouveau_sched_destroy()) the same, kfree_rcu.
>>>
>>> That makes scheduler timeline name vfunc safe:
>>>
>>> static const char *drm_sched_fence_get_timeline_name(struct dma_fence 
>>> *f)
>>> {
>>>     struct drm_sched_fence *fence = to_drm_sched_fence(f);
>>>     return (const char *)fence->sched->name;
>>>
>>> sched is then RCU protected. sched->name is already static so not a 
>>> concern.
>>>
>>> As you say nouveau_sched_fini() only tears down the scheduler after
>>> fences have been signaled it seems adding two new kfree_rcu make is 
>>> safe.
>>
>>
>> I don't see how any RCU mechanism would make anything here safe.
>>
>> As long as ops->release is implemented, ops will never be set to NULL,
>> (with or without RCU) – so everyone who holds a reference to finished-
>> fence can still run into drm_sched_fence_get_timeline_name() and cause
>> UAF on the sched pointer *and* the name pointer.
>>
>> Moreover, all of this falls apart should the driver unload.
>>
>> So I maintain the position that we only get it right by having the
>> signaled-bit be the decoupling point.
>>
>> Or am I missing something?
> 
> The driver fixes you asked about and I listed work(ed) in the context of 
> 506aa8b02a8d ("dma-fence: Add safe access helpers and document the 
> rules"). In that "world" it would have been safe. Did 035219a760ed 
> ("dma-buf: dma-fence: Fix potential NULL pointer dereference") break 
> those fixes a bit?
> 
> I can try my IGT and see..

With RCU frees in xe it is harder to hit it reliably for KASAN to 
notice. Guess I would need to have a way to flush the RCU callbacks from 
IGT but I did not bother with that, it seemed easier to check the 
returned name. Since it is not returning "detached-driver" / 
"detached-timeline" post signalling that proves things are indeed broken:

$ sudo tests/xe_sync_file
IGT-Version: 2.5-ge37a85b91 (x86_64) (Linux: 7.3.0-rc1+ x86_64)
Using IGT_SRANDOM=1788784104 for randomisation
Opened device: /dev/dri/card0
Starting subtest: sync_file_race
[2178.517756] (xe_sync_file:10970) CRITICAL: Test assertion failure 
function test_race, file ../tests/intel/xe_sync_file.c:130:
[2178.517790] (xe_sync_file:10970) CRITICAL: Failed assertion: 
!strcmp(driver_name, "detached-driver")
Stack trace:
   #0 ../lib/igt_core.c:2089 __igt_fail_assert()
   #1 ../tests/intel/xe_sync_file.c:155 __igt_unique____real_main136()
   #2 ../tests/intel/xe_sync_file.c:136 main()
   #3 ../sysdeps/nptl/libc_start_call_main.h:83 __libc_start_call_main()
   #4 ../csu/libc-start.c:128 __libc_start_main@@GLIBC_2.34()
   #5 [_start+0x25]
Subtest sync_file_race failed.
**** DEBUG ****
[2177.516393] (xe_sync_file:10970) DEBUG: 'drm_sched'/'rcs16' = 1
[2178.517745] (xe_sync_file:10970) DEBUG: 'drm_sched'/'rcs16' = 1
[2178.517756] (xe_sync_file:10970) CRITICAL: Test assertion failure 
function test_race, file ../tests/intel/xe_sync_file.c:130:
[2178.517790] (xe_sync_file:10970) CRITICAL: Failed assertion: 
!strcmp(driver_name, "detached-driver")
[2178.518762] (xe_sync_file:10970) igt_core-INFO: Stack trace:
[2178.523313] (xe_sync_file:10970) igt_core-INFO:   #0 
../lib/igt_core.c:2089 __igt_fail_assert()
[2178.523428] (xe_sync_file:10970) igt_core-INFO:   #1 
../tests/intel/xe_sync_file.c:155 __igt_unique____real_main136()
[2178.523436] (xe_sync_file:10970) igt_core-INFO:   #2 
../tests/intel/xe_sync_file.c:136 main()
[2178.564635] (xe_sync_file:10970) igt_core-INFO:   #3 
../sysdeps/nptl/libc_start_call_main.h:83 __libc_start_call_main()
[2178.564690] (xe_sync_file:10970) igt_core-INFO:   #4 
../csu/libc-start.c:128 __libc_start_main@@GLIBC_2.34()
[2178.564892] (xe_sync_file:10970) igt_core-INFO:   #5 [_start+0x25]
****  END  ****
Subtest sync_file_race: FAIL (1.054s)

I'll copy you on the updated IGT for reference.

Regards,

Tvrtko

