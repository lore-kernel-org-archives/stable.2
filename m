Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794089960;
	b=cbPOjiQ4nKNtRnaI3kvBNiAs2pQl6HXPS4K5Luf8zeIiDVaWYCumxF6AzlmFV6T9UjgM
	 4ThT8IxBkbV67zsxFB3iBvhvkZJYjkgJKT3ZUPgSkSOOzRrBfXHlTCH/zKEGwaxzlWQH7
	 DZcK97Z57SGLT5c9lsb3DJajJCVkPe0FMZAB/GIm7Ye9GwebAOgJVBTUVF3f577oCJ9sI
	 SorkzXieRKiqT615JRz476SNNDWiSog4DDIXxd+AtMY9RVYw/Jlt1ZagARXJPcnztjccI
	 xXXFnsk0d0gScXYgHTjwZUb2SOAMx7ofKShDu01bfZ7MGpuLwGup8DxsBYCWqK7peGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794089960;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=IrWyd/NUIg/cuTdnip5OZoVktjwrysAxByBJrTRw/Vs=;
	b=jMBXNYYa4Wtr/hlcA0QPapmxMei9C71xwDBh4IgsThT1SxUF1Y5NdM+CbqdLVEqgyki7
	 ynw7N+sIc7Fy64oYp2Ug6LEJ9zi+eCmowMqO644arBxC9FJia/dClk/pfYnr0130scubE
	 isAfcLiUGTGWUNJhn24/jL4831KxsTzRynDicPE31P23jQlZNAj2ks9vVtQBBtTOo1s4O
	 hjuwZNzYUs7kvTumlPhmm2HYK4LzZLJyoZl0IsGscd0ChKWgqFE2bgJEANnv+WVc8Zgx8
	 +voA3Yqk9wo5xH9r14paF8AHaKqmg4hdc3KCZQ7SHeSkS8FvJxD6sWYngoiYjBmTdVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=a2RvPuSq;
	arc=none smtp.remote-ip=216.40.44.13
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E69606A333;
	Sat,  7 Nov 2026 22:19:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0E69606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=a2RvPuSq
Received: from omf16.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id A253040455;
	Sat,  7 Nov 2026 22:19:15 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id 11DB62000F;
	Sat,  7 Nov 2026 22:18:55 +0000 (UTC)
Date: Sat, 7 Nov 2026 17:18:41 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>, tglx@kernel.org,
 mingo@redhat.com, linux-kernel@vger.kernel.org, will@kernel.org,
 boqun@kernel.org, longman@redhat.com, bigeasy@linutronix.de,
 clrkwllms@kernel.org, dvhart@infradead.org, dave@stgolabs.net,
 andrealmeid@igalia.com, shuah@kernel.org, juri.lelli@redhat.com,
 linux-rt-devel@lists.linux.dev, linux-kselftest@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH 1/5] locking/rtmutex: Stop spinning on the owner when
 the waiter is woken
Message-ID: <20261107171841.06d3ac92@fedora>
In-Reply-To: <2a786b46-e935-4269-9bdc-edac43521a80@efficios.com>
References: <20261106235931.1478800-1-mathieu.desnoyers@efficios.com>
	<20261106235931.1478800-2-mathieu.desnoyers@efficios.com>
	<20261107002927.3cbad7ff@fedora>
	<20261107104329.GA2668564@noisy.programming.kicks-ass.net>
	<c77635b1-9c24-459a-b75c-82cbfb67185f@efficios.com>
	<20261107123642.149677cf@fedora>
	<2a786b46-e935-4269-9bdc-edac43521a80@efficios.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 11DB62000F
X-Stat-Signature: f8dy9hjpsw4m8s5z1mbfync5f847dh4y
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18BEy50Y0R/CGiJv/72oFmfpd2bvmyyf0k=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=IrWyd/NUIg/cuTdnip5OZoVktjwrysAxByBJrTRw/Vs=; b=a2RvPuSqqUgHFxw/HeNHl/RXpo2HWnqn7eATNP1CpuCQEW5TvqcXQbBz5gtWuxZlSjQ2NAI9zuhc3zwxY6sUDHTXrxOpPLYduq83u+5Fr3SWRwJG5HexGVZgq26H/2jqB7z4r8uy+Y/wmtnRRwDJldogONAL/5jTnzAGjmBXmBg=
X-HE-Tag: 1794089934-72919
X-HE-Meta: U2FsdGVkX19zj3EcpEfWC0gfish/KiltpyP1399WG2W/6/JxmHM+cHe7dYWt2DCxNxJ0h1ksxTxANJxqJctYp5wxHzt8ftfMjwc7lcTMJY8xc2XOGR56D16ksSoxtoMbI04eB0ZGzKkPnHGfUoMdyx4a59DaM+YJ6+mSmVPQmP09KKdObZxxOQ69iCMovC1naJMFwPWQDIsHwA9hSuvXdGbbsbNZ4Xv5d/vSj9iErSlVHpUy4ez6Wbm1Uj8drO2cWq9YJ8zhUtCkKZGQ+eFALB89orzxDWzKBtyG2hLTldisQbGnytGWgDZoW1+GwCJ0Bjc0eIQ8+SGCw2536hTFFKAKj7jGZ1I8MlcoDMWfcXcL7iLWspj/aHoXW0KfMIrE

On Sat, 7 Nov 2026 14:34:12 -0500
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> > 
> > How about something like the above?  
> It drops important information, such as the user visible impact of the
> issue. How about this remix ?
> 
> locking/rtmutex: Stop spinning on the owner when the waiter is woken
> 
> The top waiter of an rt_mutex sets its sleep state. Then it spins in
> rtmutex_spin_on_owner() as long as the owner is running. A wakeup sets
> the waiter back to TASK_RUNNING. The spin loop does not check for this.
> So a timeout or a signal is only handled when the owner blocks, or when
> the waiter has to reschedule.
> 
> The spin is an optimization. A running owner will likely release the
> lock soon, so the waiter spins instead of going to sleep. It comes
> from the PREEMPT_RT adaptive spinning for rt_spin_locks. Only the
> lock handoff wakes an rt_spin_lock waiter, so the spin did not need to
> check for other wakeups there. The spin was then extended to all
> rtmutex based locks. Their waiters can also be woken by a timeout, a
> signal or a ww_mutex wound.
> 
> The owner of a PI futex is a user task. It can run for a long time.
> With an owner spinning in userspace, a 1ms pthread_mutex_timedlock()
> returned up to 1.4s late in testing. A signal to the waiter is delayed
> too.

The last sentence seems out of place. Perhaps be more specific?

 The timeout signal or any signal to the waiter will not stop it
 from spinning, and the signal will be delayed until it exits the spin.

> 
> With PREEMPT_RT, two contexts that take two ww_mutexes in opposite
> order spin on each other. Only something else that needs one of the two
> CPUs stops them. By default, the fair server does it after 950ms, to
> run SCHED_OTHER tasks.

Yeah, that is a big issue.

> 
> Fix this by also stopping the spin when the waiter is TASK_RUNNING. The
> slowpath then handles the wakeup, as it does after schedule().

The last sentence doesn't really make sense. I can figure it out
because I know what the slowpath does, but as you see in my version, I
go into a little more detail to why it's not an issue to break out of
that spin on TASK_RUNNING.


> PI mutex throughput is unchanged. The futex and ww_mutex selftests added
> later in this series test both cases.

I think you can drop the above. I don't see it adding anything for the
change log. That is more for cover letters.

Thanks,

-- Steve
