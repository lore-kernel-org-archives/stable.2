Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795508485;
	b=gwQHrXb2IPIrj2NjMvklLLduTBiAVRTPnxpV4e/ZFIOH9/go8uYIbNW8TaoIfZncwUTm
	 YqI8vuJlJcUYxFtYiq/chNSxzxxR3B1UX1QFhVImnkEUj4+rbRI8Kw+oVC2DH64WfHnHB
	 V/ch6M7ZueOCwW4VTiVAcksj5MLcYe8o+uNEKHA/9vx3iJ4lYTos/YKBZySC/0C2U7ctt
	 ymKt1elJhquXYlUYps/NOGrTi9ZMHMhdmzrC1xjZqBzm2zgixlMZzaoiEQfEW9EulL7yy
	 hbvkHE+RNT1Yq0SjHIji9Krafv4r3EJY/9CIGvhDWUaegNEOwwIwAwCotL2qVCbOwqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795508485;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=wwj0QXSNreWEUy/rLPR1l2BY0WuGMY1+8NqMgEz9Gj4=;
	b=oVwYacZDKLkxroVlzTiqwCjiJ8bUpCe/CWaK0eqK3H6lnBfzM7nI+mkj4hl9yJqGNM7g
	 +e/1B9qZ/UiNbf8pwSH+dd23ciSsBpRHjAlzFmIrsBaDbiorWKF8UZ1Hr3pYvL0b+meFk
	 Ct4ycazizgOwIJERKM8j7OwK6e1IHlMIUWmosDplAP926sYAzuoIi7nA+96UCdUybCB8Z
	 GblEIU43fflc2+4eLDLzjYyuz0oPgmM7+tZiTOh01ZK7vpwwHjekY8FhFG0uwvETYp7RI
	 C/7TS90Fjs08gA5N4vBXUudN71nmcnxFUetinzgEPOgx/S8VBlyMWT/JKWCdePy/dPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Ao01OcX3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF050606A322;
	Tue, 24 Nov 2026 08:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Ao01OcX3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A7591F000CA;
	Tue, 24 Nov 2026 08:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795508484;
	bh=wwj0QXSNreWEUy/rLPR1l2BY0WuGMY1+8NqMgEz9Gj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ao01OcX3G8/+JxAjCMpZCGjRN5lHadBQIdZmEtpffolZbq1Nf+ZtbyaMaCOrCXYKW
	 w/rHzS39nSdkP2maH+oqTatNzFuUS+2/MG5FIEDHSSq2A3jxzZ5eXbQ5DTvwPKhRKE
	 b+Sw6hH7z3sHevDQ18gET8jZIHeBN4D/P5xXh3C8=
Date: Tue, 24 Nov 2026 09:21:20 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Luo Gengkun <luogengkun@huaweicloud.com>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Alexei Starovoitov <ast@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, alexander.shishkin@linux.intel.com
Subject: Re: [PATCH stable/linux-6.6.y] perf, bpf: Fix NULL
 event->orig_overflow_handler dereference
Message-ID: <2026112402-dictation-juror-2e5d@gregkh>
References: <20261124084837.2327711-1-luogengkun@huaweicloud.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261124084837.2327711-1-luogengkun@huaweicloud.com>

On Tue, Nov 24, 2026 at 08:48:37AM +0000, Luo Gengkun wrote:
> We hit the following problem on x86:
> 
> 	BUG: kernel NULL pointer dereference, address: 0000000000000000
> 	#PF: supervisor instruction fetch in kernel mode
> 	#PF: error_code(0x0010) - not-present page
> 	RIP: 0010:0x0
> 	Call Trace:
> 	 <IRQ>
> 	 bpf_overflow_handler+0xa4/0x120
> 	 __perf_event_overflow+0x11d/0x2f0
> 	 perf_swevent_hrtimer+0x127/0x140
> 	 __hrtimer_run_queues+0x108/0x250
> 	 hrtimer_interrupt+0xfb/0x230
> 	 sysvec_apic_timer_interrupt+0x69/0x90
> 	 </IRQ>
> 	 <TASK>
> 	 asm_sysvec_apic_timer_interrupt+0x1a/0x20
> 	 __perf_event_set_bpf_prog+0xb7/0x180
> 	 _perf_ioctl+0x1f9/0xb40
> 	 perf_ioctl+0x41/0x70
> 	 __se_sys_ioctl+0x82/0xc0
> 	 do_syscall_64+0x44/0xb0
> 	 entry_SYSCALL_64_after_hwframe+0x78/0xe2
> 	 </TASK>
> 
> RIP is 0 with error_code(0x0010) (instruction fetch, not-present), i.e.
> an indirect call through a NULL function pointer.
> 
> perf_event_set_bpf_handler() records the handler currently installed on
> the event and replaces it with bpf_overflow_handler():
> 
> 	event->prog = prog;
> 	event->bpf_cookie = bpf_cookie;
> 	event->orig_overflow_handler = READ_ONCE(event->overflow_handler);
> 	WRITE_ONCE(event->overflow_handler, bpf_overflow_handler);
> 
> WRITE_ONCE() is a single-copy atomic access, not a compiler barrier, and
> the store to orig_overflow_handler is a plain assignment, so the compiler
> may reorder the two stores. GCC 11.4.0 does; disassembly of
> __perf_event_set_bpf_prog():
> 
> 	mov    0x3d0(%rbp),%rax                  ; prev = overflow_handler
> 	mov    %rsi,0x3e8(%rbp)                  ; event->prog = prog
> 	mov    %r13,0x3f0(%rbp)                  ; event->bpf_cookie = cookie
> 	movq   $bpf_overflow_handler,0x3d0(%rbp) ; publish overflow_handler
> 	mov    %rax,0x3e0(%rbp)                  ; orig_overflow_handler = prev
> 
> Use smp_store_release()/smp_load_acquire() to guarantee both the compiler
> and the memory ordering.
> 
> Upstream status:
> Not affected. commit f11f10bfa1ca ("perf/bpf: Call BPF handler directly,
> not through overflow machinery") removed orig_overflow_handler and
> calls bpf_overflow_handler() directly from __perf_event_overflow(), so
> the reordering window no longer exists. That rework was not backported
> to any stable tree.

Please backport that rework instead of doing a one-off patch.

thanks,

greg k-h
