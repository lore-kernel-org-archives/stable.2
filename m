Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82D523E33D
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 08:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786003594; cv=none; b=cMAiQJcaEJ7QU6345/QIONAdBI7q9M6E0RWAF3MvdWF5HUBNZgBW+nq9HsSnC18Lpt7uvcAhmVODBKxS7MXNWhvYgvPjsUy54QIr8EXpx7JXmJSHk04EgCIVrsgSXjXGfTSH6V20VuWPbAo7BBZUfaQwl6mVbRgKp2KwzzGjRu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786003594; c=relaxed/simple;
	bh=74zUSXIOku8e7Nz/XuVtzzTRb6HSIQ9smWHZiwEhVoQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hSX7R5lxzaDWMxpo7NKvMeFTuzfza+nBEBPljPlnaYn3/zofftwzgNI1sYprKIx52PaHICClrx+Z+5JQA6W3nzVktIwOEgnTd+gITHDqrbbKljcPUaw03NcUvVqXWIpwdsyqQ1Awql0OiuzFFgxvS4otQUYtP3db/Bu84MrNzM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=Jci44kHp; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="Jci44kHp"
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9C4273FBF5
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 08:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1786003588;
	bh=NG2Eh4pZXn9QqZgh2gMs+/otPaFgkRYCIXrVumNaCtk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=Jci44kHpSx69i0yXjQ2p3zKP7QH3f4mFJaetPQ7CHd7XVLDsY5EYlJLBelr/aLM+t
	 sx/hzSo1fmUCbcotRsCCBojTP/UgffR1SXK1jq19RWkHk717i6uQSXos2pRaFLNRCV
	 NvQQchLenxpmrx4ONx0OW+1Q5gUnPh9m502JcbO/hiLdCad0aNFU8RfhAkQUFHiju4
	 Hr2ix9sWhbX0YoZi825+vxxPYAWZAecMKKxADULi1PzL7dhDCguY78cqkrfc+sfAC7
	 Blr5tAciAVpG9v+pLhgEGphjEDeHu+m5PWN+IlAQRcDqaabxPS1AxtoYe9rmINiJGa
	 szGvbaBbHN8zajSGZuKoWtkaMnaBRqqgmn00zjfJRV8MLhApJyq9aGsG4sSW7X7eRV
	 a9BVkFVeQ88X81SVvT09Znddl34P94LdLC0vS1xbwAF9IancxuXQedYTMucUgWGkCs
	 HVNjBTnG4Xn3Rr8B9o2V6TmpD26+jk4JOr6oqT7ScFNYpuMM707vqhlos1mU+sf+pr
	 xUexuBgFeCoZK/IChEM8gSlE4Zt5dz2WU1Sw++8cmMkIIIDeeLl+kO3Z/7HtwlfKA6
	 DWPkS+4HNNhfe2YQEf9hPWkqIWv5lTBOpIrDgpU8rY14myW6R/hOlCes0n/eze0zit
	 jnJYeJf+zuEU70nnzhQEe4s4=
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84865f326efso2371700b3a.0
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 01:06:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786003587; x=1786608387;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NG2Eh4pZXn9QqZgh2gMs+/otPaFgkRYCIXrVumNaCtk=;
        b=M9uIyKD+UqqHbbL8q/Ye1PA5zJLvEqvwSJHTRdz1O86ma2EzHU+28fMQjl6QiJJAsz
         E2pnaOu5mjw5axDAHoLKgkAokH8/8Ducxd3a31Uy7M0AdTtUlSS084Ho0IZM8aR98cY5
         5qtNzA2KVVWf4pPXdWcytuqk244eG1EAkz1Y7c42n4NJ/NOGnGC6HhuxF1/fLiZCYdxu
         3yjcWCVr66ga/H6QQ7a9cXywlCL+NqjSfY01MjmethZvuVfkHopNeHPSniGOjpRWXOoF
         T+cBls/FhWc1Z/y/YfrOcHCsd1JYVcuSUyGOyfu8wXY2hssHeqqZT1MLOxgECvKjNl8J
         QBwg==
X-Forwarded-Encrypted: i=1; AHgh+RrY1WJS6KQJYtzx1TfpkulhfKIcwQN4yFeyecdIwjiLAGWdNDSg71+XFEPBlUNOIjg0TvcAHxo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFFLV2u3ZIrWZwQpxQVPTKjM8bo0AkiSc1N3buckirjT/t/OcN
	pY6giev1C6O0Vn5lK34oythT1fsVw/+UUGNgwMb00bkkaJBpL3/XPUWNpSoevS0tapFYxeyUpzL
	qt6DxhAMt3580f5p5Vk9fdRBZ9mlinfFNJEVScl7DHOfbm+UeWzTBQOmMN1tFHG/z+fEsfkylqD
	Qdgp8PtQ==
X-Gm-Gg: AR+sD1232xL3Kq55xnDG3W5SGtR1anZDU8zyCB39ot9HEDIrm5ATTc/sEvpylHjG055
	2C2uIlyJKNKui62BghGUZPz1r0zLAMaediJBaST9akoi4zcDqEg84pUrwrnMjtXmFEsAp2AmiaH
	tLMp7erP9IOK58rtVeHgOekv9nOjsleds/duKDzep+up7G4UFnbUtLoFGt06qy5JAoonqo2B+pv
	VoOY3t1CnRx7HE0q2BrZOJTkjkeW6P0JniPg1NTDA6fd2EwyZCGyvxHrx37S8ZQFvABcgh5HzSg
	KsC35J2NWIKKh1+CKEbBHzdMqEss7DjAsSmQUqxu6gWvotJGUfARSwG1foTyVxHIY9o1J3vyZlU
	2+J/ZW1TuIPdgv8A=
X-Received: by 2002:a05:6a00:3012:b0:848:3dae:66e2 with SMTP id d2e1a72fcca58-84f2e05d01emr15540387b3a.26.1786003586777;
        Thu, 06 Aug 2026 01:06:26 -0700 (PDT)
X-Received: by 2002:a05:6a00:3012:b0:848:3dae:66e2 with SMTP id d2e1a72fcca58-84f2e05d01emr15540337b3a.26.1786003586352;
        Thu, 06 Aug 2026 01:06:26 -0700 (PDT)
Received: from [192.168.192.71] ([50.47.147.90])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-84f45ab011bsm872023b3a.41.2026.08.06.01.06.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 01:06:25 -0700 (PDT)
Message-ID: <00168bff-3d44-4701-9931-1e02105410ed@canonical.com>
Date: Thu, 6 Aug 2026 01:06:24 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] apparmor: fix cred UAF caused by
 begin_current_label_crit_section()
To: Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>
Cc: John Johansen <john@apparmor.net>,
 Georgia Garcia <georgia.garcia@canonical.com>, apparmor@lists.ubuntu.com,
 Paul Moore <paul@paul-moore.com>, "Serge E. Hallyn" <serge@hallyn.com>,
 James Morris <jmorris@namei.org>, Christian Brauner <brauner@kernel.org>,
 Al Viro <viro@zeniv.linux.org.uk>,
 linux-security-module <linux-security-module@vger.kernel.org>,
 kernel list <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
References: <20260714-fix-apparmor-cred-uaf-v1-1-be40e8c83b90@google.com>
 <20260806073244.GM49951@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20260806073244.GM49951@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/6/26 00:32, Peter Zijlstra wrote:
> On Tue, Jul 14, 2026 at 05:38:07PM +0200, Jann Horn wrote:
> 
>> diff --git a/include/linux/task_work.h b/include/linux/task_work.h
>> index 0646804860ff..ce19fc14060c 100644
>> --- a/include/linux/task_work.h
>> +++ b/include/linux/task_work.h
>> @@ -33,6 +33,7 @@ struct callback_head *task_work_cancel_match(struct task_struct *task,
>>   	bool (*match)(struct callback_head *, void *data), void *data);
>>   struct callback_head *task_work_cancel_func(struct task_struct *, task_work_func_t);
>>   bool task_work_cancel(struct task_struct *task, struct callback_head *cb);
>> +bool task_work_has_func(struct task_struct *task, task_work_func_t func);
>>   void task_work_run(void);
>>   
>>   static inline void exit_task_work(struct task_struct *task)
>> diff --git a/kernel/task_work.c b/kernel/task_work.c
>> index 0f7519f8e7c9..f83d1528e0bc 100644
>> --- a/kernel/task_work.c
>> +++ b/kernel/task_work.c
>> @@ -189,6 +189,20 @@ bool task_work_cancel(struct task_struct *task, struct callback_head *cb)
>>   	return ret == cb;
>>   }
>>   
>> +bool task_work_has_func(struct task_struct *task, task_work_func_t func)
>> +{
>> +	struct callback_head *work;
>> +
>> +	if (!task_work_pending(task))
>> +		return false;
>> +	guard(raw_spinlock_irqsave)(&task->pi_lock);
>> +	for (work = READ_ONCE(task->task_works); work; work = READ_ONCE(work->next)) {
>> +		if (work->func == func)
>> +			return true;
>> +	}
>> +	return false;
>> +}
>> +
>>   /**
>>    * task_work_run - execute the works added by task_work_add()
>>    *
> 
> This thing is quite terrible. And AFAICT the only purpose is to
> determine if said task already has said function enqueued. Why not add a
> single bit to struct task_struct for this? I'm sure we have a spare bit
> somewhere.
> 

single bit wouldn't work generically to represent the different functions
that could be enqueued but we could stick a flag in the apparmor task
security blob, so we could just check if apparmor has enqueued its
function.

The trade-off is you don't get an admittedly ugly generic fn that someone
else could use.

>> +/* replace the current task's stale label on syscall return */
>> +void aa_schedule_stale_label_replacement(void)
>> +{
>> +	struct callback_head *tw;
>> +
>> +	if (task_work_has_func(current, aa_replace_stale_label_tw_func))
>> +		return;
>> +	tw = kmalloc_obj(struct callback_head);
>> +	if (!tw)
>> +		return;
>> +	init_task_work(tw, aa_replace_stale_label_tw_func);
>> +	if (task_work_add(current, tw, TWA_RESUME))
>> +		kfree(tw);
>> +}
> 

