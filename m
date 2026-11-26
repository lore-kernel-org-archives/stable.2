Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795730361;
	b=hq/LFBoucl+bIOi3fjPbg+WV9xdtjIXRhIVE7Vj9wXmBqsnytk8WaIovUv5foJVXkKMd
	 PHi0PGRbntm/XRG0QHYS1oJSp36S5AZxycOe1BbAJZpKWXvl9Un+8xzp6P8015DdmN8Nq
	 KD86jxaOSERT+noLDZqP87AOUN/bAIUm5OGjijnC24XO5Pv2Vw7C9sBHOHXejvoWPYdMb
	 OtfepNeFaJ7PcOza09vxgW2/4xgfnyu73wBGQfCRDYr3BCAoaaaYaILg4DZ2Nj2SXywZz
	 6S8mFK9VV+KqVMgmfFHBuDAYbPp/K7BBBMxLB/za8RFG7y+iC4MsePO4S2dbeGi55/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795730361;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=nicg9fOaQYqkvebvo23Azvs2njPERMZDMTaNYJH5mJk=;
	b=RXb0cN4otYn2HpTB3Wj6dahtaZhngJDqF1f8Yf+c/yJ3t8jzwq7eiWqUtKUn/0DfUB7J
	 oUXiDk3gvwHHJbFeLdJlh95kRuobRe2qJuKj8QxpPOqjheHDYR5t6nLNzXgcv9aStluR4
	 4SpJW/SMZlzroRBFjrNFnKDP2TQ5/UvrWpmiVfZHo9CVGXGYt7g/8avlGiPOaywXzlclE
	 bm9Ot91MZLtiX8pN6gBhkj5HYCPakW02x1NWz71rr7vD0dgki2Ztt7IAhh1ztHINMBUjm
	 SRQxy85D5t9hokWJv8avW46/Qk70bs5jsCQAcLlTjQe1SrgPFrFUAOUev8hWHUmkT7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J2JPCKnd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A8E606A326;
	Thu, 26 Nov 2026 21:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J2JPCKnd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CAB21F00897;
	Thu, 26 Nov 2026 21:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795730361;
	bh=nicg9fOaQYqkvebvo23Azvs2njPERMZDMTaNYJH5mJk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=J2JPCKnd88FYuN7qFSSogD2kMw7b7qtSiCF+wnVJUeXtcbfgBwy5xv204ys/R5YR9
	 /sV4mkfoZd5zGxJlICv9yZHbMH543BYdzlycpe/Wn6CPl4QH1qSdDXsKd2jO1VpFEm
	 8IJq89vIdH7VEAqLomE3mMnmewqA7vhD4zqBMqP9AxQ7u1zISy3V5EbKj4SNu3R/2M
	 PxXjhpd38Ghbd6UUg3KTBFxtbGs199cmQNpW+OnSp/+OFu9tpKE4PCCl7IMh9DuIOb
	 L4s7kJVx6RlaUJVYmMf5AaGo0FjLQqcErQYlj5ePrKWKi8Zy75lbnKm9kH5E/WW2Ga
	 T2+Vzg+Pt/2pg==
Date: Thu, 26 Nov 2026 22:59:17 +0100
From: Christian Brauner <brauner@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] perf: look up address filter files without
 ctx->mutex held
Message-ID: <20261126-texten-bewusst-ruinieren-9aa88e75cec5@brauner>
References: <20261126-work-exec-update_lock-leftovers-v1-0-1024b26792bc@kernel.org>
 <20261126-work-exec-update_lock-leftovers-v1-1-1024b26792bc@kernel.org>
 <20261126152414.GH49833@noisy.programming.kicks-ass.net>
 <20261126-gedruckt-gastarbeiter-vorsorgen-5fea7cea1877@brauner>
 <20261126-erlogen-bedrucken-dementieren-5de5e5460481@brauner>
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
In-Reply-To: <20261126-erlogen-bedrucken-dementieren-5de5e5460481@brauner>

On Thu, Nov 26, 2026 at 10:26:02PM +0100, Christian Brauner wrote:
> On Thu, Nov 26, 2026 at 09:56:37PM +0100, Christian Brauner wrote:
> > On Thu, Nov 26, 2026 at 04:24:14PM +0100, Peter Zijlstra wrote:
> > > (Why can we add proc files to the filter?)
> >
> > I think we can. But it feels a bit annoying because this such lock
> > inversions involving exec_update_lock and perf isn't the first time.
> > So I tried to get this inversion out of the way.
> 
> So I looked at this. It doesn't work. The filter never contains a procfs
> file. It's just that kern_path() follows /proc/<pid>/exe to the binary
> and the parser wants a regular file. IOW, procfs is only walked through
> and exec_update_lock is then taken in the middle of that walk:
> 
> kern_path()
> -> ...
>    -> pick_link()
>       -> proc_pid_get_link()
>          -> call_proc_get_link()
>             -> down_read_killable(&exec_update_lock)
>          -> nd_jump_link()        // checks LOOKUP_NO_MAGICLINKS
> 
> Same for cwd, root, fd/<n> and map_files/, and proc_ns_get_link() does
> it for ns/. So by the time kern_path() returns the lock has been taken
> and dropped again. WE can't catch that.
> 
> procfs itself would have to look at the lookup flags before it takes
> exec_update_lock. IOW, path lookup would have to work around perf's
> lock ordering. And that only takes care of procfs. On FUSE the lookup
> still blocks for as long as the server wants with ctx->mutex held and
> exec waits for that.
> 
> So ok, if we can't drop ctx->mutex in the middle of the ioctl then how
> about we don't hold ctx->mutex during parsing to begin with?
> We let perf_ioctl() hand PERF_EVENT_IOC_SET_FILTER off before it takes
> the mutex:
> 
> ioctl(PERF_EVENT_IOC_SET_FILTER)
> -> perf_ioctl()
>    -> perf_event_set_filter()                // no ctx->mutex
>       -> perf_event_set_addr_filter()
>          -> perf_event_parse_addr_filter()   // kern_path(), own list
>          -> perf_event_ctx_lock()
>             // revoked? has_addr_filter()? ->addr_filters_validate()
>             -> perf_addr_filters_splice()
>             -> perf_event_addr_filters_apply() on each child
>          -> perf_event_ctx_unlock()
> 
> The parser fills its own list and counts the file filters in locals.
> Everything that needs ctx->mutex then happens in one go under
> perf_event_ctx_lock().
> 
> So ctx->mutex is never dropped in the middle of an ioctl, a migrated
> event is handled by perf_event_ctx_lock() like everywhere else and no
> ctx is carried across the lookup?

Just as a general final comment: holding any global lock over a whole
path lookup is a not a good idea. We've seen that over and over again.
So if we can get rid of that, we should.
