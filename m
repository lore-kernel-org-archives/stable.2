Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795728367;
	b=Tf1nnTPZzHXN6odzHk4T+Q6jUKuZ65Zvr5cc43Jirjn2BdHeHnJ1JDetU0qQCyoMughL
	 pJKx4juNG/+7W4tvBt0wJRSv9z0wtoy6cbJVRJNDKhTFA7+YkCU6O4sDlgTTnjpyd1TFz
	 TKxYhKVbe9jvs2UoWbAIZywG96wbSINXAApG8uIamqzixg1Yv7Rr7yHeUKe4yp5bcq3r+
	 JnOegBn7TeFJdCTCx8zdcMNvuh82I97X0HS+CJ+jzE0xw56VKgPEQIutKEiVprr02N1ya
	 gpN3lC3J8zoziYiBCl4OQ30zXY8m8UKg2MZ9/TAus2WAqX3DLEKOoJUGiOTOokI6Y4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795728367;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=sYkHvG1XK7pHWdLcW4SLWaX5Hq1pyKiTV7VEU0uWFzE=;
	b=yx02iKzhy+X9UyH2voeYFySBnh7Wgz9GOCkkq3lSZl0lUYqMJiXdkQ4T2D4mdr2evEdG
	 pyIDg/BNpDnKAb7YV3JXwU0ZXEYglQ8rweaZBQ2Q4LMgOOgLbu4/Qh8egooszwdMh0RvP
	 yEQhBQOxTcbkkzYRhi3GBCNPWft9h2bVwnUH2wOwX6aGXm4xvv9KvuIBxgsa5dvADNeTj
	 rnDXmpVjKzSpBAdl53maFdncdmD5OgQsURIA47bllt8AJvuE1Z7UZSdhC76vs0QTxbB68
	 POttt1Pls3aQxCw7dcleiBPLslFib3ngE9E7Mvk4Mi8moJctOamxZvFOwwS5Sm+tbtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EuiXYEfS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0F2606A31E;
	Thu, 26 Nov 2026 21:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EuiXYEfS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F3611F00893;
	Thu, 26 Nov 2026 21:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795728367;
	bh=sYkHvG1XK7pHWdLcW4SLWaX5Hq1pyKiTV7VEU0uWFzE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EuiXYEfSE7wYpMsY7ddx0KUdJJNL2+1K2hmfOnMbTwX0PjOLpUGQwtH/x/1dHkv7w
	 NFuQHzNmcK6NFlmayd7vQcy1A37gye5KQi6ZgUYdyP+EMErS/dXTjPiIm0so/iAmh2
	 V6CzlCRPcq3MHl+nV05ZzepJfRenz/3UUiMhchXfuStmkFG/b9/3dfMRDTPloU/W9Q
	 8Em7hEhD8grnkLcj51KlWhWB/08suw3bhqg0CuOyw/FY4cj3a59NLfjeyqZMlMH5lm
	 ABHufVldE0hkL6//EvecXa08GHioW5tU1ySMtmnejJUNsXz4/LZX32Hayn0Wj3RtF8
	 80SGZHRjlBspA==
Date: Thu, 26 Nov 2026 22:26:02 +0100
From: Christian Brauner <brauner@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] perf: look up address filter files without
 ctx->mutex held
Message-ID: <20261126-erlogen-bedrucken-dementieren-5de5e5460481@brauner>
References: <20261126-work-exec-update_lock-leftovers-v1-0-1024b26792bc@kernel.org>
 <20261126-work-exec-update_lock-leftovers-v1-1-1024b26792bc@kernel.org>
 <20261126152414.GH49833@noisy.programming.kicks-ass.net>
 <20261126-gedruckt-gastarbeiter-vorsorgen-5fea7cea1877@brauner>
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
In-Reply-To: <20261126-gedruckt-gastarbeiter-vorsorgen-5fea7cea1877@brauner>

On Thu, Nov 26, 2026 at 09:56:37PM +0100, Christian Brauner wrote:
> On Thu, Nov 26, 2026 at 04:24:14PM +0100, Peter Zijlstra wrote:
> > (Why can we add proc files to the filter?)
>
> I think we can. But it feels a bit annoying because this such lock
> inversions involving exec_update_lock and perf isn't the first time.
> So I tried to get this inversion out of the way.

So I looked at this. It doesn't work. The filter never contains a procfs
file. It's just that kern_path() follows /proc/<pid>/exe to the binary
and the parser wants a regular file. IOW, procfs is only walked through
and exec_update_lock is then taken in the middle of that walk:

kern_path()
-> ...
   -> pick_link()
      -> proc_pid_get_link()
         -> call_proc_get_link()
            -> down_read_killable(&exec_update_lock)
         -> nd_jump_link()        // checks LOOKUP_NO_MAGICLINKS

Same for cwd, root, fd/<n> and map_files/, and proc_ns_get_link() does
it for ns/. So by the time kern_path() returns the lock has been taken
and dropped again. WE can't catch that.

procfs itself would have to look at the lookup flags before it takes
exec_update_lock. IOW, path lookup would have to work around perf's
lock ordering. And that only takes care of procfs. On FUSE the lookup
still blocks for as long as the server wants with ctx->mutex held and
exec waits for that.

So ok, if we can't drop ctx->mutex in the middle of the ioctl then how
about we don't hold ctx->mutex during parsing to begin with?
We let perf_ioctl() hand PERF_EVENT_IOC_SET_FILTER off before it takes
the mutex:

ioctl(PERF_EVENT_IOC_SET_FILTER)
-> perf_ioctl()
   -> perf_event_set_filter()                // no ctx->mutex
      -> perf_event_set_addr_filter()
         -> perf_event_parse_addr_filter()   // kern_path(), own list
         -> perf_event_ctx_lock()
            // revoked? has_addr_filter()? ->addr_filters_validate()
            -> perf_addr_filters_splice()
            -> perf_event_addr_filters_apply() on each child
         -> perf_event_ctx_unlock()

The parser fills its own list and counts the file filters in locals.
Everything that needs ctx->mutex then happens in one go under
perf_event_ctx_lock().

So ctx->mutex is never dropped in the middle of an ioctl, a migrated
event is handled by perf_event_ctx_lock() like everywhere else and no
ctx is carried across the lookup?
