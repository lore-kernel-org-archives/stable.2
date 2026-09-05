Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412BA3783CC;
	Sat,  5 Sep 2026 22:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788647827; cv=none; b=Fwdt43EjRzerCohItsjDSUiR3ZVuu918tnKB/ZhL8BkZsL1+KQty+u2nJ7QAOL0TgH+qa2f6lXA5FYeoToTXaDndWp/ib8QUyt5Y7sJUcj3Gc7g6dbgMYYGmi/6LmwGc/cBPevwtcCyGCkHRMtv9naWV9eF1mI1joIX9YZWfqyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788647827; c=relaxed/simple;
	bh=XtR0HkB2AntV2d8Pe+580CbDN2RYhqasWOfPY6+JOyc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=MrqYho0B7FQGhexHzFbTg/b8YUiQtpp+i/IfCpWoI3qQGwCyRhe7M961wGR69FtUTNSZwF/zp4+Bo9dj5TtTT/6rtW0IQPQHSlv3lb2lE9VVhQylg7wXL3H8F8yHpZkb1WSoieCSqBHESOuNTxBEoAkK0My9+XRCZIAlhWQuoVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ONQUSt83; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ONQUSt83"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 063021F00A3A;
	Sat,  5 Sep 2026 22:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1788647825;
	bh=MtjQ1ODtoXbhHRqrZLCBQGlLhKxmPKi8roy0XKYbjzA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ONQUSt83ZZf7rEbmIESSsiSQY3xMN39a3j6xObv5wd/XdtB/jXcxKdMubi9fe5Yu1
	 h8udRMs5vsU70vf9oSVc5EGY3fc750jeT7FoRPmc/08YkG1aXEj4IL9INAk2HtbgVc
	 EQmH5KBU7pLDLRkQMyv5MGprvN0nAH+jY7ZC8M3k=
Date: Sat, 5 Sep 2026 15:37:04 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: linux-mm@kvack.org, Baoquan He <bhe@redhat.com>, LKML
 <linux-kernel@vger.kernel.org>, stable@vger.kernel.org, Dev Jain
 <dev.jain@arm.com>, Ye Liu <ye.liu@linux.dev>, lirongqing
 <lirongqing@baidu.com>
Subject: Re: [PATCH RESEND] mm/vmalloc: Use dedicated unbound workqueues for
 vmap drain
Message-Id: <20260905153704.e7fe650d0226c3e20c1c8449@linux-foundation.org>
In-Reply-To: <20260905152717.11711-1-urezki@gmail.com>
References: <20260905152717.11711-1-urezki@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  5 Sep 2026 17:27:17 +0200 "Uladzislau Rezki (Sony)" <urezki@gmail.com> wrote:

> drain_vmap_area_work() function can take >10ms to complete
> when there are many accumulated vmap areas in a system with
> high CPU count, causing workqueue watchdog warnings when run
> via schedule_work():
> 
>   workqueue: drain_vmap_area_work hogged CPU for >10000us
> 
> Move the top-level drain work to a dedicated WQ_UNBOUND
> workqueue so the scheduler can run this background work
> on any available CPU, improving responsiveness. Use the
> WQ_MEM_RECLAIM to ensure forward progress under memory
> pressure.
> 
> Move purge helpers to separate WQ_UNBOUND | WQ_MEM_RECLAIM
> workqueue. This allows drain_vmap_work to wait for helpers
> completion without creating dependency on the same rescuer
> thread and avoid a potential parent/child deadlock.
> 
> Simplify purge helper scheduling by removing cpumask-based
> iteration to iterating directly over vmap nodes checking
> work_queued state.

Thanks.

> Cc: stable@vger.kernel.org
> Cc: Dev Jain <dev.jain@arm.com>
> Cc: Ye Liu <ye.liu@linux.dev>
> Cc: lirongqing <lirongqing@baidu.com>
> Fixes: 72210662c5a2 ("mm: vmalloc: offload free_vmap_area_lock lock")
> Link: https://lore.kernel.org/all/20260319074307.2325-1-lirongqing@baidu.com/
> Reviewed-by: Baoquan He <bhe@redhat.com>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

I think what we wanted here was

Reported-by: Li RongQing <lirongqing@baidu.com>
Closes: https://lore.kernel.org/all/20260319074307.2325-1-lirongqing@baidu.com/

so I made that change.


