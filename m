Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794960030;
	b=jIHAJUP9nEjoB4+aMrGHjj/b/xWs7I7PTiYgmUqSoxZsjPRb0/C6G3c7EPko8w/U54mZ
	 dVDZXPOzWsD159XH+E48l+IF1Ogr0KyLIG4eQjK/yJct6QYYdLotPDkqwOm/dK4IXEWYf
	 Si2PeLhoZjZ1ZLilxLXMDmkLL9zXPnEc7ggpm/oTvpVPQI+2P8hv37/hbDi+WQPJYUfJm
	 YKjvGsW20VexjVnFF+b0NsbQq5I8DGkMKWuIkSKaYKix0y3Kt4AgqfEunhxzSHqVdKF3s
	 wFp5jAziGzt+jw+Od60rFXWycdnqzPu4NeV3AULmSGTghWjQMi5guP41LyjlUFG57+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794960030;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=bclIWZ6FX0mX08OYKuqV5M5iFQvVjJ51ZeOco2b+exc=;
	b=ZzKt/HvMvWiBeM7+qAZ8poETgM9okuyZ1BJ7RdkOpcSBCrWRb2cH53hrJNUszs+EfK1z
	 mQcnHggQDubFUA+ftoIQFIf2katMtiNJPbukWH6hwLW0v29D3H6Up0BTAs7IQvAGmUwnI
	 oBWbX3ZpbyZ61agqfe6DFnZsC1t7e0Qq8pvMpjfzourmdcPjNsB1ClnD8+J21Qx2mCLqs
	 AWsAk+ucxIAYbKm2NQwT7c+TRXhUKQn/PcgeqHz0c5m906CMSACmpBIrRFJ0uMyTgebCw
	 kJ69q45Mv9KiUABijbAx2o9LpFPU4YZHUmCBxtd6f9JhY6qp9UD2NMGnWRGT7C3+UBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=EgFMIlW0;
	arc=none smtp.remote-ip=91.218.175.13
Received: from mta0.migadu.com (out-13.mta0.migadu.com [91.218.175.13])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489FD606A32A
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 00:00:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 489FD606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=EgFMIlW0
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=LfZWu2kDl00YJ8hzTGAr/QsVPZ0HXBKeCp53dE5Im/c=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794960027; v=1; x=1795564827;
 b=EgFMIlW0+L2mx5PyGa1GmzAl/u2b823c1/ZsrtdC3x4oc9L6U5K8CrvBET5ONW54Xh6W56U2
 aB01hs5TsEcJyQiT3fi9COx8ZJWdL8iRIh2H3GuqhH4JD8jN0oWnhCCjcq0Q4G0K0E+dDPXZ3Vn
 /i1Yku4tnhlcWrg6XY5oHAMk=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id f54fc8da450d0984;
	Wed, 18 Nov 2026 00:00:25 +0000
X-Mizu-Trace-ID: f54fc8da450d0984
X-Migadu-Flow: FLOW_OUT
Message-ID: <8130b695-c281-46e9-bfdd-e4873046c36d@linux.dev>
Date: Tue, 17 Nov 2026 16:00:21 -0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] tracing: fgraph: allocate shadow stacks inline
 with GFP_NOWAIT
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, mark.rutland@arm.com,
 mathieu.desnoyers@efficios.com, andrii@kernel.org, peterz@infradead.org,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, kernel-team@meta.com, stable@vger.kernel.org
References: <20261021174406.2891598-1-vineet.gupta@linux.dev>
 <20261021174406.2891598-2-vineet.gupta@linux.dev>
 <20261117185645.628de864@gandalf.local.home>
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <20261117185645.628de864@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/17/26 3:56 PM, Steven Rostedt wrote:
> On Wed, 21 Oct 2026 10:44:05 -0700
> Vineet Gupta <vineet.gupta@linux.dev> wrote:
>
>> smp_store_release() is a drop-in replacement for the smp_wmb() and
>> plain store it replaces.
> This should be added with that, but I can just add it as a separate patch.

Thx for that. Let me know if you need me to do anything.

-Vineet

>
> -- Steve
>
> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index bbf6e4e2da2d..d32160a6b835 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -568,7 +568,11 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
>   	if (unlikely(ftrace_graph_is_dead()))
>   		return -EBUSY;
>   
> -	if (!current->ret_stack)
> +	/*
> +	 * We must make sure the ret_stack is tested before we read
> +	 * anything else (See alloc_retstack_tasklist()).
> +	 */
> +	if (!smp_load_acquire(&current->ret_stack))
>   		return -EBUSY;
>   
>   	BUILD_BUG_ON(SHADOW_STACK_SIZE % sizeof(long));
> @@ -576,12 +580,6 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
>   	/* Set val to "reserved" with the delta to the new fgraph frame */
>   	val = (FGRAPH_TYPE_RESERVED << FGRAPH_TYPE_SHIFT) | FGRAPH_FRAME_OFFSET;
>   
> -	/*
> -	 * We must make sure the ret_stack is tested before we read
> -	 * anything else.
> -	 */
> -	smp_rmb();
> -
>   	/*
>   	 * Check if there's room on the shadow stack to fit a fraph frame
>   	 * and a bitmap word.

