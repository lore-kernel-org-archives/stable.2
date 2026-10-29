Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793281334;
	b=C0zxal6QjzbH3a7sWGacQvVcJjzqji1OHsUEYLZDMpJ3U41QOKiZA7HUUToxlzjU95Rb
	 4OnGU7ENT3ikSFrn+O30n5MTYUSecLUG32MFBoWPfr2FQ//JbfvxseY2/jqyjK12eFAKM
	 /itAtS63Xo6+Y0YQyKEdhvm+A+2GVSg8DsbU0M5j6KyBQV9bTcFhEVAuVw38L8mCyoVH7
	 inmfVoGv2xAWHarO6gvtmeBuSHqpASUSsOg+/ek2q8eApA4Jjw1xrHkPOPtXT2cT9Ic+M
	 qb08SR7vuKaHGsL5D4ehflwXEJI0zVqYcm+2CY/7kXR2eE0KnSP7Ub2sYVtpYnQtOQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793281334;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=O6CTOI7Goyf3DK/jXbQM9sZjnDLqWtwiiqPhDSY8VTs=;
	b=4XbZUYoWbZTwdOii05pXHPHBBMKLudUwmvl2wlXumy1SqEhR5h5DUDWTXKR/Jh9tq3WB
	 CJAofDe56QQTZBmCQCowIuFgfQP9TLCseuYxua3tE7zhOmTBwee0OAO4Ap5UNVfIoDH6N
	 bYXQx1eak9SNiwhMsFsyeI8VK3ZPI3h3EBmOI76FlL7E3Mai6+YInQCqf5a1RgSZzDcZu
	 yneSvXBmErIVtfsG6K8lfCpj749iH8aJFC7Oo+5feTqXpBLYjyRQfi83wLALwQh8NpmVO
	 KkwzGyFWWGH9ok8CNNnSeBf/CW+b6GEAOjTG+NijQR896Cj+cwZ22Ax2oX7OOJQmqTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=VQbL3zQr;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E4F606A324
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 13:42:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47E4F606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=VQbL3zQr
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-18cdcfc05ffso2896902c88.1
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 06:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793281332; x=1793886132; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O6CTOI7Goyf3DK/jXbQM9sZjnDLqWtwiiqPhDSY8VTs=;
        b=VQbL3zQrWIOVq4Z7tmllrXNp/F9Y/1vAbgkzY+NsMf49zm1WyIRTnXF5yUY+a6teZu
         1z7uiJ4jFHbGF+/iqGwEBEyDxle5Ef0QMEaTRWXO/ARS73wZmzQn4UGlARXyd81GTlG9
         ba+SuIPs7AOuuoWqYnJSqxcIzINoWvVsw+3K8pW2ZKfVCfUeuyZf1xJRQW/Mv7nXcFfv
         1QU18Cd2F1llrGeRNyDskRjAjvv3AZ46W2Sz+bPHUxPBuAA1ZRsCPw61qknLU7r0UorP
         uRcxoYRLeBXw4+xJeNoxM88JWSsdrg3NfI5Sa9trAT2uWC55hRcbeu5Su3xykZifEcwp
         7lvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793281332; x=1793886132;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O6CTOI7Goyf3DK/jXbQM9sZjnDLqWtwiiqPhDSY8VTs=;
        b=I86KReNdazPnsotGFXjaeJ9YCjFj58TvulBCvZOninVSS96pt69SbzSuqHOP85ylzQ
         KqT01cVCTPqtNX7h47jV4Dr3RnWmAAVgPeDugn0xzlEr+ie4ErTiavDPfyrDqzvdeCS6
         ckPq1fzyqTRnunBLzvziZZwDQ6jzZ1+7EAJfnPkLzY4rEAukMoZp34M6t1tzcSQCBbfi
         luExNvkdkbgFMRjiH0j7wMYgTcX7OKWneFulVJf4dw9pgfGkCKuDH6rYw3+3IV2gSev9
         8oE68G0ZwbfE5mn+Y5jHzhpfJExjJoWXR06QlLYjfSM92A25pEDTZeEnwZifztfdtdm5
         kkUw==
X-Forwarded-Encrypted: i=1; AKwUvBwYmvPd4ijvS+vdWV43KPBNostE1nhxr1BPOvKqZvAaxI1xU8MQqwB8IcSMudM7PcKkifeRgYY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLgc1+yzYzfJFEx6a1y/Et1kGaxhn/KjQJ6iOwghQJa3BnQxUTn
	axlKkeN4uppTbojsdoKh0xO0az03Onbcijs49IhjvCyqVjnMfe0OoP34stdjpRodb8Y=
X-Gm-Gg: AYBFou1dfuL4ZuG0CLEEt0bwgn6TSKymj4/VGV9bnXR6hK5hEgdPBYzw2+0QvfD8V4h
	HBOiz125Oh3PIe56t0Rq1o5er2l5kypQAkpnAUgYt/ArVwFFyifuA/tRAjF9CwOu6JD6y0D/+j3
	eRC4v2+ETbNM2rkiBxXJnTGTGlWOvUAO/RlaLkpwmNNMznm0L/bInuv5ruMw02EAFZgld+RYgMw
	lELWsImpXpuGncRXPG7Wtp7pWNj4vDJRHxUp0VvYmzWr03r4gw0R6yj0FMUzQ+f1qV4foQ+xmaY
	jCB2oKv3sqk50ZUdBAbJ8EHaPdxL2rwzk6NWwxZmxy552si4CV9FQxMETv+swWIcJritxf1DY6g
	iFKMD4i8bjCNPjz505opX3PtC6qIkcbd+XREFw55NGZ0Z+oM8KT+ZtjeDN9XFmVjZn4wv1T5dpB
	qnKcdAMubRtjIVJckh8UdGt827B0KtulJ5XhwdeoR7sCLuIfcEYlZ/p5zUUqfvtPfpuL7VzwhiV
	F8WIpzxvrY8VVPDJjHuKC+UVnwinD0MRP8RNa1dkul0WQ0L97WlOVWFgethDKEAQw5SqR5G6pfU
	tyVzWNNycev1AsOZQknz8OIEqK8DC7BaS+JEMszICOjXmmV7m6BuMO0nAGtTYmi71yGDfqDV4qG
	MV70vY5BnkFqn
X-Received: by 2002:a05:701b:4201:10b0:1a3:8d5f:6f93 with SMTP id a92af1059eb24-1a6cced6334mr7561828c88.17.1793281332099;
        Thu, 29 Oct 2026 06:42:12 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a75e1f2de2sm14760120c88.13.2026.10.29.06.42.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 06:42:10 -0700 (PDT)
Message-ID: <502f31ed-dd70-469c-b433-577ccee36c3f@kernel.dk>
Date: Thu, 29 Oct 2026 07:42:09 -0600
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
Subject: Re: [PATCH] io_uring/napi: fix list use-after-free on PREEMPT_RT
To: Anvik Loitongbam <permissiontogallop@gmail.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>,
 Olivier Langlois <olivier@trillion01.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 stable@vger.kernel.org
References: <20261029102244.141621-1-permissiontogallop@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20261029102244.141621-1-permissiontogallop@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/29/26 4:22 AM, Anvik Loitongbam wrote:
> Commit 45b3941d09d1 ("io_uring/napi: fix io_napi_entry RCU accesses")
> converted the NAPI list teardown to list_for_each_entry() and
> kfree_rcu(), with a comment claiming that list_for_each_entry_safe()
> is not necessary because kfree_rcu() defers the free to the next
> quiescent state.
> 
> This assumption only holds while the surrounding spinlock section is
> non-preemptible. On PREEMPT_RT, spinlock_t is an rtmutex and the task
> can be preempted while holding ctx->napi_lock. The raw lock inside
> kfree_rcu() only defers the preemption until it is released, and the
> release still happens before the iterator advances. Once the task is
> switched out, the context switch is an RCU quiescent state, if the
> preemption lasts long enough for the batch to be flushed and a grace
> period to complete, the callback frees the entry, and the iterator
> then reads e->list.next from freed memory. The same pattern exists
> in io_napi_free(). I did try to produce a uaf on an rt kernel
> build, but it did not work.
> 
> All list mutators are serialized by ctx->napi_lock, so the entry after
> the current one cannot be freed before its own iteration. Caching it
> first with list_for_each_entry_safe() in both loops might be a more
> safer and correct approach.

I don't think your analysis is fully correct. On PREEMPT_RT, spin_lock()
should still be an RCU read side critical section. __rt_spin_lock()
calls rcu_read_lock() after taking the rtmutex, and then
rt_spin_unlock() drops it at the end. There's even a comment on
kfree_rcu() callbacks in there too, it should not be able to run until
napi_lock is released, which is post the loop.

IOW, I think this patch is unnecessary - there's no bug there. The list
safe change could be done as a cleanup, but it's not a fix.

-- 
Jens Axboe
