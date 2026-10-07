Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62813EA66
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 05:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791352578; cv=none; b=RHHlm21IginMN1vP+pNrRkB+D2UhqVNY0ajMouARfh0wSR+zDEp5lu9Q+/G2KiOvYBgekE3q2fcKEFUF9C3zBH7mFIbC4nm/FVbwWx0pgXba0DDGozd7/8qS2Ij7fpLWnGpIf+zoFWyr7g838TZBr0yHeypq8/nZXgf2Bqb8bOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791352578; c=relaxed/simple;
	bh=tN36ci4IovZxa177e6ZIcYcj/xxHlJyHAOWZAih5w4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WzZ9OSFckLEer1oCRdM1DUELbkOoEmpkPhz43GhnMUTmBT+Edq8YK21NN8JB4TWnb9exBQSskX5jv90WG8JQLGPlkPRixRxY1PRnBYvMG8IacHWfhRWyP/nwE/RVuhEmlNc9lGAkDwS+smr+C/Roo7ch+Qs8JoZlaj70pVy5X74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=G8aed7PZ; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="G8aed7PZ"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-48e94879f02so568841fac.0
        for <stable@vger.kernel.org>; Tue, 06 Oct 2026 22:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1791352576; x=1791957376; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VXBQtCNU8FUq8Qg2PYU28JD3k9JJVaiWZX17kjJP17A=;
        b=G8aed7PZMlLTTD0ALVIFpoG5Hu8TLlFiy/czIU7jxg33jGDICKywZy5FVmAt5ON1hc
         TUC2cp+XnlRLR5WKuOkfjVQzscMLdGf5k3lvtYpT/Oedj3DbcWEg1T5vxcgeJvlNJS6B
         EgFoJBKeFOjETA4s//E2t/rqsOV+mdOn0b/7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791352576; x=1791957376;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VXBQtCNU8FUq8Qg2PYU28JD3k9JJVaiWZX17kjJP17A=;
        b=LcukEpnZbVjjlZIIC2L1lgSQHtf7mMANYewWvxbhD+cDXnqieEFs56Cy4LWKY1e5zc
         6HUnUfnZjBr2sGmVo0tAP9as9OaFBhvBLVyx4tGMFO2fOnIyr5/OolBgFIyUu1pe0c72
         MRCs6k7BrpnG6q/moSsWSu9ev3kbsJBs96L8U5w2bjXfS8fwz6hvx9OpDHn2VQ9UVJ98
         +aU3jyz8bhCuHZI0ZRfkRCY/tdQMV7lIe/1w2MGWZFGRpPFORhVXEHMhW0qnrYu1nl9g
         f8qr9shHF2e/3x3JvgyIxbsEOUqXBI0583aQoC2vnLCUmIEwbflIrMC0OaH7WD6r3IUk
         I8Ig==
X-Forwarded-Encrypted: i=1; AKwUvBwYqULbx4dS3m0nZ30cgqg6qXlAc165T5k4XxPG9WL1SOJSFxTF9dxaIRjnBID1BuxMxanVVSo=@vger.kernel.org
X-Gm-Message-State: AFuF++lPRuoce2W8XgZLYSmq39J/2LvBsXMCMKW7cBBlYKOTuCwwmtsU
	Qqn+8z+CJT9fVOkRh9Kg9gysjixDsY+wevCsoWNrVW+lb297vMpRbaviOnFNM4RBOKNOykvOX5T
	ln7nDXFt94g==
X-Gm-Gg: AYBFou2MwIM1y5MI0dUEf3mX4GLRICS2pab7I360HJ7MbaNMiurvyOvJCRi+Qsi8Yvg
	jlAgCPvqaceAeiCEWNs9r4a9BpgmvpXeiFvj5cH1OPIWS+jY9IuNqYRblLBhCL0h/w5cIojwAQX
	jtci8aX3o3pQfvk7HI3UCCbMY0GDKr9f3Xe+IxXhMm4L4IfG97jC9mnEX2B2sMcSqyIzdVAGVwf
	4I4DdNBuEDA68FS2DE1ooQ68da8CeENJeGTE5uqK+9ttOfpAX+ECgUV4g09S3Wp6Y+LO8fSiw3R
	U8BmLr3bsB3nog4QjVEtRB93P27aysF5ldhYZbW5aMXZscg3jEkF/Mh6xIpYPUrr4SgiHDqITJu
	UtvZw0swn3yOLw6aeOfjDppMyyU17ytqzKiHRXe2MR5Tdv+tM6qIIeFpEoqNx3hE83Z/oVgpQUv
	A/xwhBreiQ4YjX2zu8zxGIDoeSn3le5ViIvDWQcBiAxy30dUNFu9mraisyvA690fUegBbSRJ3IG
	diqSxm6R2kB4by5NNQ2qTKSNxAIlRn5LkY+YIO7dRrKve2OpsOe4bwQZh0JBIFO
X-Received: by 2002:a05:6871:2b16:b0:49e:3edb:987f with SMTP id 586e51a60fabf-4a2594c418dmr1203497fac.11.1791352575733;
        Tue, 06 Oct 2026 22:56:15 -0700 (PDT)
Received: from com-75606 ([199.47.143.7])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a2571cab91sm1335158fac.11.2026.10.06.22.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 22:56:15 -0700 (PDT)
Date: Tue, 6 Oct 2026 22:56:12 -0700
From: Kyle Zeng <kylebot@openai.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org, outbounddisclosures@openai.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] tracing/filters: Check perf permissions before resolving
 .function
Message-ID: <asXe_NWiBtGDXZVN@com-75606>
References: <asXAxf0edslJI-Ge@com-75606>
 <20261007055225.32DDA1F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261007055225.32DDA1F0089B@smtp.kernel.org>

On Wed, Oct 07, 2026 at 05:52:22AM +0000, Masami Hiramatsu wrote:
> On Tue, 06 Oct 2026 20:47:17 -0700, Kyle Zeng <kylebot@openai.com> wrote:
> > On Wed, Oct 07, 2026 at 03:44:20AM +0000, Masami Hiramatsu wrote:
> > > On Tue, 06 Oct 2026 15:51:12 -0700, Kyle Zeng <kylebot@openai.com> wrote:
> > > > perf_trace_event_perm() allows tracepoint counters that do not request
> > > > PERF_SAMPLE_RAW without raw tracepoint permissions. A self-targeted,
> > > > disabled event with exclude_kernel=1 can therefore reach the filter
> > > > compiler even at perf_event_paranoid=2.
> > > >
> > > > The .function suffix accepts any field of sizeof(long) and resolves its
> > > > operand through kallsyms_lookup_name() and kallsyms_lookup_size_offset().
> > > > The success or failure of a numeric filter discloses whether an address
> > > > belongs to a known kernel symbol range. On x86-64 this can be used to
> > > > recover the randomized kernel image base. A named filter also exposes
> > > > the resolved symbol range through the counter when the tracepoint field
> > > > is controlled by the caller, as with a syscall argument.
> > > >
> > > > Pass the filter's perf origin to the predicate parser and require
> > > > perf_allow_tracepoint() before resolving a .function operand. This uses
> > > > the same sysctl, initial-namespace capability and LSM policy as raw
> > > > tracepoint access, and closes both the numeric and named-symbol oracles.
> > > > Do not change ordinary perf counting filters or filters created through
> > > > the separately controlled tracefs interfaces.
> > > 
> > > Good catch!
> > > 
> > > >
> > > > Fixes: e6745a4da964 ("tracing: Add a way to filter function addresses to function names")
> > > > Cc: stable@vger.kernel.org
> > > > Assisted-by: Codex:gpt-6-astra
> > > 
> > > nit: This should be 
> > > 
> > > Assisted-by: LLM
> >
> > Didn't know there was a change of convention. Should I send in a v2 or
> > it will be picked up automatically?
> 
> We can change the tag when picking up, so you don't need to resend it only
> for tag update. But for this patch, please update according to Sashiko's
> comment.

Thanks for the explanation.
I just sent a v2: https://sashiko.dev/#/message/20261007050315.65139-1-kylebot%40openai.com

Best,
Kyle

> 
>  https://lore.kernel.org/all/sashiko-outbox-162502@kernel.org/
> 
> Thanks,
> 
> >
> > Thanks,
> > Kyle
> >
> > > 
> > > > Signed-off-by: Kyle Zeng <kylebot@openai.com>
> > > 
> > > Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > 
> > > Thanks!
> > > 
> > > 
> > > -- 
> > > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
