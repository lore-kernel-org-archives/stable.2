Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE5935E1B8
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 14:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785941243; cv=none; b=rvetMntbMg/1U7Z8w4OnHoVCGYY5KarmOksbQ+vfNw+lwENM+ZMNUdFfY3zZVgw4nMB2+Nlvcg7aBtc5fMzKF7Pm/MrQZV4Z4UNWp+pBpP1KSybSgJr0JH7fNuD8R2upkPY7nQLlIJZEW3jPTKhsR9MS8s2F4xRC0gAqNVmEfAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785941243; c=relaxed/simple;
	bh=OsMtavjZJpRs7JOiOiguAbbN9fILxQjVhXldFpwRHic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bbqiMisoA9GrEUf+K3OZsn6eZAQJXjWzNEqrKiOeCL+smqvvio8WAXx5Y+klivB7cDMLCg5iZ0vnrm9tjqXGj4vn/uaDSNXDkC8DiOTbEtPbQ6b6vnWyylwJzAo71RDqH9DPjsSRsgOzvzy9Vb63mYzTNu/Iv2L+mSMkzoSA4EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UBeLHJnV; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UBeLHJnV"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4980fe6b3beso16338395e9.0
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 07:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1785941240; x=1786546040; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iH0FlQI8tkDOWcBfTJDeJ0UBlBqaU4FCfRj9gn3PRYA=;
        b=UBeLHJnV0YPt0zOojn2ByjEgDcZt07/DeT0qOCMEeF4b4o57r2SXwg4WKOGrn7XAje
         Fc1KBBKTHY/RkqLTOLvs3mRV3A2V91lJutqUVhLFpcaSoSisE3Nt6w8HyRyFENUngNvK
         Q07waOMTwFtdfb6lQ6DDMVx4CMfc+0h73geQPbE9wIfHoX0TrD3buUHgdk1O25AUL7/C
         l8b9IE7zOWStDUeScwdxGtYgWZIa/gRn0J0JZMVtH5CpqB+NAt8fQlglPakPlin7ZrIx
         ZMFnlKZccnyiRgDFnS/3Hw3ZaBOR8CeVoX867m8oA4fNAac78unne2AbytTlyT2Ox16Y
         464w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785941240; x=1786546040;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iH0FlQI8tkDOWcBfTJDeJ0UBlBqaU4FCfRj9gn3PRYA=;
        b=FbtQm1HYXOrAzbRwe9ulaSnNoIQ8xloGptB/IqPUtA8jdg7lq2cWYkxMlQzT2U31sv
         gw4I4zlaA156KaiOOMaySqa3H8XmzCpYDoe/N+mNROC5bY6UaEpaIEDQCDqtV30pfqsR
         GKaFQgeYG05voRe/s/H70gsf0356V5DWNosc9xRrAD4ehS60Z6lGEkf9bmESzmp5d/Oq
         E8GWB273e3iJf6tdrszizViIgxn0J4aqt391j0BJRCYvyXoc3lMTs03iErpWQmj7ioqa
         tCyGq+AGiR9grFDmKYDD6udeJw/2r0ZWSiVqyC6xm5b7RN85PgpIHndHaiux1j9cZw/j
         ZM9Q==
X-Forwarded-Encrypted: i=1; AHgh+RpnjMHMicbtL3vBHe1IPnnkSufARDfFZQ7RbccFWlKRC2yRdBd5bHUAC2F9cubHsJOuW0Bn4TY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy64vRoxc8vHmXeQG8j9KGaitf13AqW24U5bWACchw5P6YKIw8O
	nb0rpdr5Et2UFu07KdJrmqzpf4+ujpEB+6xeKJCSYwXfO4xY85F8K7PsvFN3ZsRSWjw=
X-Gm-Gg: AR+sD12etJJgIH0URnjXSDTFGOFYYvv1dWg8NTMvTUXZbQQ/ff1bP2pzuRLojWHWycb
	MPQ4Gjq91XsNNQKtyeLBRSzLnS494mV6VpGRVdoA6AMThPFYJOWtyeKr7GA1NnOPgWCPXwibnKr
	RdquXm1RIML1ZHT72ZEvEKkXcufUnHLLJ7lJIRU9bN16vj46QtE4Fr2gJhlAKNRwd9LQnhr25M4
	uyeLK0iLoeqN9EEaWsDS7sLOHW5uQWNmIhb9v9mNXNfceALP2QKAXmUyxhBIMTh17jXUBOn+CVQ
	IGfRTFsyvGD+5F7t0yO+WIzEGneyTLEiCj7UaZcgdlNVDnCNvW9La8oT6L1Ood/hWgl/s5awprL
	iyE17Q6SIYVjZTreL88FzPV4+7apY+lapV2lED+mesd7+AdlsBvApzwGu8ahpJI9lQmSR52ep1q
	n98gjLKCZhyHOfJvssh/WJRkPMZ9nre76cCIZsXOCdytFshws99g+BFpzciiUlbqWvrZcF4FSyR
	wVfEwYMQcvzYJ/02Z43kiJAFBIjAvLm5Xp9
X-Received: by 2002:a05:600d:8483:b0:494:1f7:8057 with SMTP id 5b1f17b1804b1-4994e339bb8mr64982655e9.1.1785941239789;
        Wed, 05 Aug 2026 07:47:19 -0700 (PDT)
Received: from ?IPV6:2a07:de40:8100:0:fc6c:f9a2:4a0a:6354? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994f124135sm24468095e9.2.2026.08.05.07.47.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2026 07:47:19 -0700 (PDT)
Message-ID: <1951733c-0d8f-4d1d-9da1-fd71d23781de@suse.com>
Date: Wed, 5 Aug 2026 16:47:18 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] module: fix UAF and GPF in idempotent_init_module via
 heap allocation
To: Mingyu Wang <25181214217@stu.xidian.edu.cn>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 Johan Hovold <johan@kernel.org>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260717082601.81704-1-25181214217@stu.xidian.edu.cn>
 <8d507b50-b5a2-48a8-a4bb-f196ac28b5e4@suse.com>
 <f79bc014-a606-4ab5-adfd-1b56dbdc30ba@stu.xidian.edu.cn>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <f79bc014-a606-4ab5-adfd-1b56dbdc30ba@stu.xidian.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/4/26 12:41 PM, Mingyu Wang wrote:
> Hi Petr,
> 
>> I'm confused by this description and I'm not sure what problem the patch
>> is trying to solve. A task is not normally terminated in the middle of
>> a syscall. This could happen only if it hits an oops. However, that
>> means there is an earlier bug and the module loader isn't expected to be
>> resilient to a post-oops state.
>>
>> Could you clarify the scenario that you ran into?
> 
> Thank you for the review. You are entirely correct; the task did not
> terminate during a normal syscall, but was indeed killed by a prior
> oops.
> 
> Here is the exact scenario discovered during driver fuzzing by our
> automated virtual device modeling tool, DevGen:
> 
> 1. A `modprobe` task (PID 433) concurrently loaded a faulty driver
>    (the `atlantic` net driver in our trace).
> 2. It passed the idempotent() check and added its stack-allocated
>    `struct idempotent` node to the global `idem_hash` list.
> 3. During init_module_from_file(), the `atlantic` driver hit a fatal
>    oops in its hardware init path (aq_hw_write_reg+0x39/0x50).
> 4. The kernel initiated oops recovery, terminating the `modprobe` task
>    (exited with preempt_count 1) and freeing its kernel stack.
> 5. The oops recovery path does not clean up the `idem_hash` list,
>    leaving a dangling pointer to the freed stack in the global list.
> 6. A subsequent module loading attempt traversed `idem_hash`,
>    dereferenced the stale stack pointer, and triggered a secondary
>    KASAN use-after-free and GPF.

Thanks for explaining the scenario.

> 
> While the root cause of the initial crash lies within the specific
> buggy driver, the current stack allocation allows an isolated driver
> oops to corrupt a global synchronization primitive, preventing any
> further module loading across the entire system.

An oopsed task can leave behind various kernel structures in an
inconsistent state, such as unreleased locks, incorrect reference counts
and leaked objects. It is expected that the kernel may behave strangely
afterward and this can result in subsequent problems, such as deadlocks
or crashes.

Loading a module is a heavyweight operation that injects new code and
data into the kernel. If it ends in an oops, I think it is fair that no
additional modules can be inserted. I don't see that the module loader
is doing anything wrong or behaving differently from other kernel
components in this regard.

-- 
Cheers,
Petr
