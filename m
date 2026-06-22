Received: from devianza.investici.org (devianza.investici.org [198.167.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F8F2C21FF;
	Mon, 22 Jun 2026 20:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.167.222.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782158756; cv=none; b=M7muNXED/XK7x0lW57/T5DNyl/fcZxQ0g8/sklo4mdg8s7blo9EQ67feLAxcmLdtsPPYMRmaX/rLYX4D9bv28XvrGBvOFxAphliKUxh5Cfwzyc6xpdWFwJ4wHq7AOSIn3gvjLZpnRJukxb1Dm74RXkd6ILq+CTRKanRcv56k8zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782158756; c=relaxed/simple;
	bh=ekb7irfG3v0KJG330BbVaYKyJ+lOjmtWZbx/uoMxyxI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=FhnpgTl8AX+UswU8hER9RT8sdbY36AdoIHxj5vl4MqsXewTGapm2RwsFkDj3qiRC3RxYKcT+czgl2qyc6vltoLvDVuvmyT6HTgwbLQReDi2RkeMEaJ3uz8MqU0MZDf9Rf2J7U5qmjKQ+eJlXKIsKoJpnS8s24z/5yCSEl87kzz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=JmSAlrvy; arc=none smtp.client-ip=198.167.222.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="JmSAlrvy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1782158750;
	bh=0QY9WmsSEegkR8/znuKKw2NESLcnUTCfnX6JO57mUy0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=JmSAlrvyQtN4rS9FSRTeCTjvVHmGP5R0Vf14j5aA1PfeAToaI0S0GDA9ddN2XvfRo
	 3FLRV2GlKGW8JCzo8BkjmYmgGehxmpumFnMqp7wHrTexaHlqQ3U8dzYZIB1JWQnzHr
	 nvSPKWjC9qEt0J6tFzUHmWHYI+rOSfSPyBbKA7mE=
Received: from mx2.investici.org (unknown [127.0.0.1])
	by devianza.investici.org (Postfix) with ESMTP id 4gkfMf5tS0z6vNp;
	Mon, 22 Jun 2026 20:05:50 +0000 (UTC)
Received: by mx2.investici.org (Postfix) id 4gkfMf27knz4y2q;
	Mon, 22 Jun 2026 20:05:50 +0000 (UTC)
Date: Mon, 22 Jun 2026 21:05:51 +0100
From: Bradley Morgan <include@grrlz.net>
To: Oleg Nesterov <oleg@redhat.com>
CC: Christian Brauner <brauner@kernel.org>, ebiederm@xmission.com,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Adrian Huang <adrianhuang0701@gmail.com>, Marco Elver <elver@google.com>,
 Kexin Sun <kexinsun@smail.nju.edu.cn>, Thomas Gleixner <tglx@kernel.org>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] signal: avoid shared siginfo namespace rewrites
In-Reply-To: <ajl0_fTFXHpL8P9T@redhat.com>
References: <20260622164029.11474-1-include@grrlz.net> <ajl0_fTFXHpL8P9T@redhat.com>
Message-ID: <0873AC4A-3CB2-4F7B-BFE6-75D855AD22DC@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On June 22, 2026 6:46:37 PM GMT+01:00, Oleg Nesterov <oleg@redhat.com>
wrote:
>On 06/22, Bradley Morgan wrote:
>>
>> send_signal_locked() rewrites sender ids for the target namespace.
>> Group sends reuse the same siginfo, so one recipient can affect the
>> next.
>
>Hmm... I'll re-read this change tomorrow after sleep, but I am almost sure
>you are you are right anyway...

Sure! Feel free to take ur time!

>I am wondering if we can conditionalize the "swap(rewritten, info)" logic
>with your patch, most probably this makes no sense...
>
>May I suggest another change on top of your fix? Make the "kernel_siginfo
>*info"
>arg of send_signal_locked() "const". To make it more clear. Yes, the
>signature
>of has_si_pid_and_uid() should be changed too. Up to you.

I'll do it. I don't mind.

>Thanks,
>
>Oleg.
>
>> Copy the siginfo before changing it.
>>
>> Fixes: 7a0cf094944e ("signal: Correct namespace fixups of si_pid and
>si_uid")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Bradley Morgan <include@grrlz.net>
>> ---
>>  kernel/signal.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/kernel/signal.c b/kernel/signal.c
>> index b9fc7be1a169..d72d9be3a992 100644
>> --- a/kernel/signal.c
>> +++ b/kernel/signal.c
>> @@ -1181,6 +1181,7 @@ static inline bool has_si_pid_and_uid(struct
>kernel_siginfo *info)
>>  int send_signal_locked(int sig, struct kernel_siginfo *info,
>>  		       struct task_struct *t, enum pid_type type)
>>  {
>> +	struct kernel_siginfo rewritten;
>>  	/* Should SIGKILL or SIGSTOP be received by a pid namespace init? */
>>  	bool force = false;
>> 
>> @@ -1194,6 +1195,9 @@ int send_signal_locked(int sig, struct
>kernel_siginfo *info,
>>  		/* SIGKILL and SIGSTOP is special or has ids */
>>  		struct user_namespace *t_user_ns;
>> 
>> +		rewritten = *info;
>> +		info = &rewritten;
>> +
>>  		rcu_read_lock();
>>  		t_user_ns = task_cred_xxx(t, user_ns);
>>  		if (current_user_ns() != t_user_ns) {
>> --
>> 2.53.0
>>
>
>

Thanks!
