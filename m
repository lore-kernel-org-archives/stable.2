Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3803733BBAF;
	Tue,  1 Sep 2026 12:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788266090; cv=none; b=ZSJE2SCJEQyABsLFGnfLa/3ElEoYPCjZ8QgAKGFJq/Moz2M60ZgvRiVW/AX3sXYXTl9FCZkPgr3BHbu3gpu1SlDPwxaUYT/+p4Wa3uxEjiUrkWdRjvaG13s4GGSdW6WAOHAfqUudlHo6+hwgIP1xs/ezBYwfZ+aGRtfcyNkUHVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788266090; c=relaxed/simple;
	bh=TLjBpIIDmyAiB/U0LJXLmHa4Vsbqp48Rg3zU/a3+yCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VDEnFEXkVCKcngw9vsHe192fwFF3earx51hvlk4IB6e9JbY8klRwLld8EJ01hOBCU8lwh2/La7Mzrv7EGp92vGtN6/8BCAsoIoQDQ50M2r1rLD8kfcakFz8PCUL2VQkrJg+6DINILUVdP2tBuREuEY3YtQFy2/x7TA7BY+eyvVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QNGtK84c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QNGtK84c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 173111F000E9;
	Tue,  1 Sep 2026 12:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788266088;
	bh=uBhbAuii/pHcrsbOMyL7F2+UOxndNSgnp6fdefuSEnM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QNGtK84cIy6m17zMdNMZpTa4t6DSyTkWauq6RwoxEQ7avS6AK1fljTNfRWc2cwvYf
	 A1ZaoLhCM2aiUo+Ewd10z9njE7YLbK9ELiSciIQH1BukLtE+PAv6om9KIVdq9KIZZy
	 zyF33whBLo5QYx/oc54GxZJ8n+6YEfeO7k6DtjJg6IsA9gjdeDSblXlvBHt/0awBtS
	 IiiSQ0lXT+vhxXkmlQXrJ4q3cDRVuogggFyTp6mPyZJCBrtIRXQ073RpNKi0XiArkw
	 ATFJz6OD0Gn/C5DOzH+tU6kOmt3R2LR11l4+krqseWAAu1jJeYDQPiUuAi4QujVq5R
	 bweWYAtKxIGow==
Date: Tue, 1 Sep 2026 13:34:44 +0100
From: Lee Jones <lee@kernel.org>
To: Vincent Donnefort <vdonnefort@google.com>, stable@vger.kernel.org
Cc: rostedt@goodmis.org, mhiramat@kernel.org,
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
	kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: STABLE REQ: [PATCH v5 06/10] tracing: Fix subbuf resize races with
 trace_pipe_raw readers
Message-ID: <20260901123444.GA1350131@google.com>
References: <20260813131152.3589632-1-vdonnefort@google.com>
 <20260813131152.3589632-7-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813131152.3589632-7-vdonnefort@google.com>

Dear Stable,

> Concurrent subbuffer resizes may crash trace_pipe_raw readers or leak
> uninitialized memory to userspace due to stale size values.
> 
> Modify ring_buffer_alloc_read_page() to let it handle the resizing of
> a previous buffer_data_read_page if necessary and add a new
> ring_buffer_read_page_size() which enable ring-buffer users to not use
> the racy ring_buffer_subbuf_size_get(). This makes the spare_size member
> of ftrace_buffer_info redundant.
> 
> Use those functions in trace_pipe_raw readers and handle in both the
> case where the subbuf order is modified in the middle of the read.
> 
> Fixes: bce761d75745 ("ring-buffer: Read and write to ring buffers with custom sub buffer size")
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

Not sure if this is the latest version or not?

I see review comments, but no v6.  Anyway, no matter, it'll do.

Could we have this applied to Stable please:

8a5f63637890 ("ring-buffer: Fix subbuf resize race with ring buffer readers")

-- 
Lee Jones
