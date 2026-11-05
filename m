Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793908324;
	b=Phuq3ejFgmJV0Blm1Rd7X2yQwC+iWWDh+4Tld4X6JUcxw10LaS1KyolwiJPILu9p2ZX8
	 +hHiNI+1yDQ5JoVMftFAdWn99Qu1iy7Dwx7ELn8QBB3kp08IJMEQsNqKBxcQfbcvwITia
	 EGrE3BbdfVWrILiAyGgtrN9E0aGnjIrxWNCsAPewCE+h3SFQT9EJiZUNMgBrywG/yQ6j/
	 WFI5HTZBzgpa4pQ9jk7vaEIeoIrLag9ny9wXsSGHL3TB4f1/N663/vOeDYgMDpKAxP3vV
	 kweh8zUMuQToql/45eHhQ6cM68NUnULA2WNCsE9dJRbhXYPlNIqUr1V3QgyV8uFSO8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793908324;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=E9t5hHnAag1EnA1IvHhWRwDHScTDeDJAqRJADEROHAM=;
	b=nMfiqzEry/FPmg0KsO6yl3usU3Z4P/d17/TZJehe+RMjC8r2ieg1AvAKx7MEe/SIjCy3
	 BsD2OwswlcDcdCPCjUDFZKjCQoY7A3zAGPsyQxOYi5EvNx2m+2SBGrpp36reL7EY7hudH
	 UhxicUixL5yDiCEXU8fki9XaNU+Kpa0cjbnn2Mbwdk9F5nlN0utZ4HQkNWjtXI7hivIr1
	 nFsnDHxiSCCyHR1ZJx6zeI1h5kJPSQzqZoxWX156nBqao8+3tcB1bD1CKcPd6ynfJcrAC
	 pyGgEBdTpliWEIhf64ZDS/9pQqXP4flLTd4qprF3sfy2S4em2ma0LgeWQNQvllyrDeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PvJMfIQH;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A07606A33D
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 19:52:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62A07606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PvJMfIQH
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a68f888a41so2766255e9.0
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 11:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793908322; x=1794513122; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=E9t5hHnAag1EnA1IvHhWRwDHScTDeDJAqRJADEROHAM=;
        b=PvJMfIQHklp/6lrIJDb4DxHqeo8UgGdpsAu9dqQBOFpKyjqnOfM/bLgV3jxURH5B6C
         peftRdY9+W+wmrPZ3XDgPPzndrl8XFrtQKEW2KmejcJyjMbVQytxJ4wYg+NEdbJ+kAMb
         YgbG8/TLr5IdJxT9UkKKgf0QtKgOPlH9VIMBTFgRway+YkJj8wMlFpeYvfN9mFDljH81
         vt3JkDpxF4pVmCMAJhLHG6iLtEDLCGbY1lXGeo7kO/Y4waQ5E6rMiaH6J0bxlSA1sBx7
         SFfRyAQSlHD9i6J8DHV2lrf6bpl0GeOeyt6r6SCkSKRHbjY58i3VmbMTDSjXjjNcp9Ik
         h2iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793908322; x=1794513122;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E9t5hHnAag1EnA1IvHhWRwDHScTDeDJAqRJADEROHAM=;
        b=vlGOif7FH3NfyQduzAk20TQ5tvi+QbtGzY/6b+qRZhucnSLxWuJgyfS3TLy/2BcA8O
         r4qayRrMYpBdEAvTq3kj0MkCmZw1QwZ/5chb3/KsC59iks8+0WKyjngAgWrWFFwAOfSq
         HtQJke/S34Rfr6RvlZ9MhWhU4nwTYqCoWfJSUAFFVlFz3fp2ZUrMdBNzehAWSY22j1eZ
         jG2Y49bHdVMKDi5SjBuCi2zJeVcRttwjWybwPU0Z7DSwdXRATR7FHhmRAvMI57EIJekK
         eFKkT4yNUvDa5MkF0pn82FWtN6WyiXAXvvknTinQnHlccTX6DshyNbce+XOF8tGyRLCX
         iEIA==
X-Forwarded-Encrypted: i=1; AKwUvBztpqQkNs+kifDJMmjjet1HV8HNibN3/t8MhmqXx4FEQr0SGIuZrSvT8BniX4/6c/A6vVkC22Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z9aRXStUl4KV/fmE2zP4iv03mJogwGUKkM5c6l7PBlNG2t1//HE
	yzntOrMeqsNcwJJc5EFPV3O43DXc/TZ7LPzxbsDku1uyLsF1HPvCB6Xb
X-Gm-Gg: AYBFou0zSkrGHooF67CL7a7ud5RKUCrQ9JV4G0N1+AgiYXBY9LieZ0YItjvD/EOWkJu
	z0yWLeS+tG2EgS/nhz1Ph8DDbQSNYNdaeA90+kTekjsVd406hf7t9Nt2YWqvrly7xdbH5G61d1R
	Bi/Gz8UWmPX67nDg3eu013Voztx4k3IKcuIEVeRkOsKDZsylGF9VvloaI0qBiDOlwhkA3vyHGuI
	2fnfoeggJEUqh98dV0BbnOCQyj0Bp8qKdvMc3GsOcbSiZUINyFIGYg1MLj22re5LpJvWN32sU0O
	LeVeiG1DmmoIIeAGtkSGpK9Q6GPam+9A2Bi93ICv4f2xMwgZT5grgPcxCHiECKfT28ALB/AZL1n
	B7YhI0jRWbULh9nSCMfVqaqwSilRJJItAk1zNKKCbgtGW/DrmdLFQBGNWpezGU33LYyWEUqASYI
	a6lKrAZBJfurTn8TwlFeQniIDEQIDiFT+Ris4Hswf1X4//g8r3ioCTLwfdz2Da2nsyDOACKEwgG
	Pf87LSoHcsBoNBhxnPSXulnuwOygfDp7dNiIYyUt300BWuDBNVbMVsg8R3hrlFcfvfWnp6vxtW7
	kHc7Pi93NssGj5JbNh1aYLIp02iWTfOw/ZMshq40hFyQVYitew==
X-Received: by 2002:a05:600c:6d8f:b0:4b6:2242:d0be with SMTP id 5b1f17b1804b1-4b6d82b2c85mr3060825e9.0.1793908321669;
        Thu, 05 Nov 2026 11:52:01 -0800 (PST)
Received: from scheduler.schedules ([85.100.66.184])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b6e1b5d676sm2497515e9.7.2026.11.05.11.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 11:52:01 -0800 (PST)
Date: Thu, 5 Nov 2026 22:51:57 +0300
From: Kayra Cizmeci <kayracizmeci@gmail.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: juri.lelli@redhat.com, peterz@infradead.org, mingo@redhat.com, 
	vincent.guittot@linaro.org, linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	kprateek.nayak@amd.com, luca.abeni@santannapisa.it, mathieu.poirier@linaro.org, 
	longman@redhat.com, ridong.chen@linux.dev, tj@kernel.org, hannes@cmpxchg.org, 
	mkoutny@suse.com, shuah@kernel.org, bigeasy@linutronix.de, clrkwllms@kernel.org, 
	parri.andrea@gmail.com, m.szyprowski@samsung.com, weihengqiuu@gmail.com, 
	cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v3 01/24] sched: Fix cpuset_mutex double unlock in
 __sched_setscheduler()
Message-ID: <auzdzi_ZIqmYFV-Z@scheduler.schedules>
References: <20261105193359.1450487-1-mathieu.desnoyers@efficios.com>
 <20261105193359.1450487-2-mathieu.desnoyers@efficios.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261105193359.1450487-2-mathieu.desnoyers@efficios.com>

On Thu, Nov 05, 2026 at 02:33:36PM -0500, Mathieu Desnoyers wrote:
> From: Andrea Parri <parri.andrea@gmail.com>

> Fixes: 111cd11bbc54 ("sched/cpuset: Bring back cpuset_mutex")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://sashiko.dev/#/patchset/20261016062629.2102883-1-sh_def%40163.com
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> Cc: stable@vger.kernel.org
> Reviewed-by: Waiman Long <longman@redhat.com>
> Reviewed-by: Kayra Cizmeci <kayracizmeci@gmail.com>
> Reviewed-by: Juri Lelli <juri.lelli@redhat.com>

You gotta add your own SoB, no?


Cheers,

Kayra
