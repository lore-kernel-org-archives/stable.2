Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795122348;
	b=IjLtiTlvnkosbpLOPvyZkM5qDBjk850CIMFirRxZHFkSZJsZbrJu23e51+MaQR3db7up
	 /j3wuOW0KfcVlteFz0Ffkckv06U9TzW4RBSlfsyz47hpakKmZ5tWLpuRtwyFnCjflQTjc
	 x7tt2HJHy1OyGbTj8v2UvL8WnbWenWJydFkwx4qAw/EhkhvJTaAkDZFrtJJQ+hmn5uqY+
	 QTVUNn9dSPYtvNDwEbBNWax0V9AYw1/c/qe8kqOQ8KmDbVV4sI04ysGk/7BwOsDBD48nZ
	 ZBGJ6rtvKhs3Mre2Y0/v98RkkbUDBzsVPdZov1UOI3iTomAa7u2XOMweQC6nnq7vcZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795122348;
	h=Received:DKIM-Signature:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type;
	bh=OhWyU3BkGr909/YS4Q2MfoYxTh5M1N5wxPiL+H8hvdM=;
	b=omDN5sCbu4KQf0DVTRkpoxE/1OUwRMgm73Lqoq1J1bs52iYLYTOWsJFYQ/2wIPjLRhJh
	 Dbc8qNTE0m9LknbPwWtAtYNkk8U9wu0ZtIxSV2vtCVx7+qq7oavhvkbDP0b3vhVsfnsLy
	 YoY4Wf2ntUOmiIvYQMgOwftgIx79GYSTj/WjTl+5Pko2oxxodehjE7nx7Jqz+gaJ42D2F
	 6zp0apU/6FaNGYyHUqUX3NbOM+t9LYPW7NVumy9qhVyElXuQypmhQxDnuH6SqflP5e53F
	 fPyx9k7ozQj0U9toGNuk+O2nGXXCwrYYdBdx0aFSoYmjkl+lO/kewhZa4ZDiw9E3eOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="JAZG/Rek";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B2B60A2602;
	Thu, 19 Nov 2026 21:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JAZG/Rek
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55EC91F000C0;
	Thu, 19 Nov 2026 21:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795122347;
	bh=OhWyU3BkGr909/YS4Q2MfoYxTh5M1N5wxPiL+H8hvdM=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=JAZG/RekvG7C70DbS0Cnnav8vW4t7Ag456qqy7djHjrDOmlFf2H9m0Yt06TNvsjFj
	 hY/pTsDoHkG52j7lJpz+zUa3KJEOwaeE6XTjmqA9wY4JOjjVMVNKvhSIysL3Oj5ty/
	 /3cP/9MLqY4fd0cZuSLF+q2TvjNQwTLY3CPPfzjOXauJ/xDSt/ZqX+BNzlPR3Hxzqk
	 IorSx91Mg7gGIerM7R8Ny2HW3Hbb9OB2W7J1NxILIKcpPsJx8QzDsxLyI7lajdidwl
	 BRXW3d4nHjzv0nOaIwGI34jGesXQ78J5chkOheVpiYz2wyvfz+uXjkl6XNiD4Qe0QV
	 +t6zH29m+59UA==
Date: Thu, 19 Nov 2026 22:05:45 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Sanjay Govind <sanjay.govind9@gmail.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, Rosalie Wanders <rosalie@mailbox.org>, 
    Brenton Simpson <appsforartists@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH] HID: sony: fix sleeping in atomic context in RB3 Pro
 raw event handler
In-Reply-To: <20261108001057.29776-2-sanjay.govind9@gmail.com>
Message-ID: <79qso2ns-138o-45r7-4spo-8r0nr941o518@xreary.bet>
References: <20261108001057.29776-2-sanjay.govind9@gmail.com>
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

On Sun, 8 Nov 2026, Sanjay Govind wrote:

> Rock Band 3 Pro instruments only send navigation reports until they
> receive a magic SET_REPORT feature request. When such a report is seen,
> rb3_pro_instrument_raw_event() sends that request directly through
> rb3_pro_instrument_enable_full_report(), which does a GFP_KERNEL
> allocation and a synchronous hid_hw_raw_request().
> 
> The raw event handler is called from the URB completion handler in
> softirq context, and on USB hid_hw_raw_request() ends up in
> usb_control_msg(), which sleeps. Plugging in an RB3 Pro instrument
> therefore triggers:
> 
>   BUG: scheduling while atomic
>   ...
>   softirq: huh, entered softirq 0 HI ... preempt_count 101, exited with 0
> 
> This was reported on a Mustang guitar (12ba:2430).
> 
> Move the request to process context by registering
> rb3_pro_instrument_enable_full_report() as the send_output_report
> callback of the existing state worker. The raw event handler now only
> schedules the work, keeping the 8 second rate limit. The state worker
> is already cancelled by sony_cleanup() on remove and on probe failure,
> and sony_schedule_work() is a no-op once cancellation has started, so
> no new teardown is needed.
> 
> Fixes: 7245b0017d12 ("HID: sony: add support for more instruments")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sanjay Govind <sanjay.govind9@gmail.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

