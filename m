Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630F8363C6F
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 03:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791344843; cv=none; b=INM7mgg2OP4Fc08OWesvV4xjSjbg3kcnu7TSy/ZV80RYV9p5nKLq8VU+a/EsVOGtZOwmp/yfxHbppyJhjHul00vyZ1ljiY+kJ/QH/uSGgY77IOE3xDUrryzU/5UGMBB5yk8LFO2wEL6Ymv7+uN/y2fj7PrUjd4GcAUo20uLyE/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791344843; c=relaxed/simple;
	bh=P7R8JZjiBrTHiAAONEx9yZI6Ih9pbShIqDH/cZv1PHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hp2MnYhgUBzqcMjLo8nESPEAgeLqQAnwgQ4p9AUX412c83fWHehNcg19asbpJIUxLOxz+xmMN+yiRr8jB6zy5dEAxYfETJ0JeJjHKWCtRaxf/6JrpSCmtle3mmolXTze97pSTeTOHt6WK0ckSrldYOHA1qfuOitoEHI09+Dwu7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=dSSXB0I/; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="dSSXB0I/"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6de1fd5f572so596791eaf.3
        for <stable@vger.kernel.org>; Tue, 06 Oct 2026 20:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1791344841; x=1791949641; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Lt1iwnmKZ6euKsofomnQEm4d0oQu1LOx3t5oA2yJCYg=;
        b=dSSXB0I/kORu84IXeIDftaUPD1HSbMiBA4UnM9MSpFHJbxFBygr1DFXL3cDVmonAwo
         aKbLB3RwWhslvpbJf4SDZ4zDoQDPVdQ0CM4Z9zirL9yG+V+nPcj5GKS+WGUUCQA6Fp3Z
         m/tCNQJsEsGAA3syZ4w0RSS3V4sE2+5IZF0Y4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791344841; x=1791949641;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Lt1iwnmKZ6euKsofomnQEm4d0oQu1LOx3t5oA2yJCYg=;
        b=Zt3+0EiF9QmUVrc7V7O2ULKSl4gIcpk+SxD6oQxNEkoA0Irv8yvaINqboviVWfAslw
         pAui6NKghbSl3i7slRUNExTIBTexn6oMhwAwKnj9UcfH0s7ApeLe8Zk0YUrEWhmPFoFB
         fBgiGNbYWfd+lXMZq8gxH51Zg72G+MtjAKg9Sle3md6ovWkIVWRsePd6XNi/xxJkARLK
         9B7k63ur1RCexYAGfhtLM2wGH62s+YjYA977T9ayK5vj5zw+Qc5iNZoyvOnJ7sxSPknW
         maiJvURtA4U+N5Oqpmi4dDa+ZdywECh28FKBr4hHbsKbtBn0aItCMnC8cFoO87KkTbAO
         wbkw==
X-Forwarded-Encrypted: i=1; AKwUvByPVQJcfJ3WhGCtLRaXtAWTDXTI3kH+BwineVYjKEjijpVILGA/8kxY0Sq9TZBuJwSUKAAcv+w=@vger.kernel.org
X-Gm-Message-State: AFuF++mxA26O9HZZUqBkkhUBIaQ5tHUnVcZkEOOlu5/Y2qhkRcBBme2W
	02su6J3gCwtfiedybzaAzC7tsFDvwV+hpWvPieqvsl5iWcjfBftWPEk49+bPOg4CJ8M=
X-Gm-Gg: AYBFou1znoXA9hAxEBPlJg3hZ0cBMrb8XLKq/MTHfVdbOBHp+ChyejTA+6gKgrGXFI/
	jRBWunXjc6TzzrOq2RpEulsxXTb9n0GiTbaTzVBTPiiRhgyX+/wR2jDKm52NAFpiaq3gl3FjkBg
	tTRdibuIFb2jaoxKA6KTw+d0LqajWUouC5o4MTT7RgGxiZ9GF+1cE3pLGcnQovIvUaFYJ5WqYYq
	9DL+iX6G8W2kbvUpR25Y+RNxPe0uWlZf94bdmpS6IgCMX/vuXn8VtZ0gStMNWavSYjzttiQnDlr
	c6yJoiU4Ye5LI+Sp7Mc3Q1bg5Hse/3L3MFBWPPNFzgc5FEp4p6YSrjSE/9hu5HW05iXf3aebqGB
	9Sja0hNZMSkkbHc8etxVgvDzU0qdRrrvxqj4hkv9M5AHMZxV8dlBPEzeHUTfHS2MpMRNIw0had4
	8tcDvYeuuoX+Eqzoh83XV2obLpWoDI6iMwLWc3K176l4INUVENFB67XEDrOSvOhq1mpJ+ndr6Rs
	nU1igx0JC+5yNG5EK7zdbHRWn0YvPQ2x4WbGa4asjgGGfF7DoTztg==
X-Received: by 2002:a05:6820:80c5:b0:6d7:7979:bbb4 with SMTP id 006d021491bc7-6e7a58815abmr1344307eaf.7.1791344841160;
        Tue, 06 Oct 2026 20:47:21 -0700 (PDT)
Received: from com-75606 ([199.47.143.7])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6e79447d888sm1152148eaf.12.2026.10.06.20.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 20:47:20 -0700 (PDT)
Date: Tue, 6 Oct 2026 20:47:17 -0700
From: Kyle Zeng <kylebot@openai.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org, outbounddisclosures@openai.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] tracing/filters: Check perf permissions before resolving
 .function
Message-ID: <asXAxf0edslJI-Ge@com-75606>
References: <20261006225112.53503-1-kylebot@openai.com>
 <20261007034423.310311F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261007034423.310311F0089B@smtp.kernel.org>

On Wed, Oct 07, 2026 at 03:44:20AM +0000, Masami Hiramatsu wrote:
> On Tue, 06 Oct 2026 15:51:12 -0700, Kyle Zeng <kylebot@openai.com> wrote:
> > perf_trace_event_perm() allows tracepoint counters that do not request
> > PERF_SAMPLE_RAW without raw tracepoint permissions. A self-targeted,
> > disabled event with exclude_kernel=1 can therefore reach the filter
> > compiler even at perf_event_paranoid=2.
> >
> > The .function suffix accepts any field of sizeof(long) and resolves its
> > operand through kallsyms_lookup_name() and kallsyms_lookup_size_offset().
> > The success or failure of a numeric filter discloses whether an address
> > belongs to a known kernel symbol range. On x86-64 this can be used to
> > recover the randomized kernel image base. A named filter also exposes
> > the resolved symbol range through the counter when the tracepoint field
> > is controlled by the caller, as with a syscall argument.
> >
> > Pass the filter's perf origin to the predicate parser and require
> > perf_allow_tracepoint() before resolving a .function operand. This uses
> > the same sysctl, initial-namespace capability and LSM policy as raw
> > tracepoint access, and closes both the numeric and named-symbol oracles.
> > Do not change ordinary perf counting filters or filters created through
> > the separately controlled tracefs interfaces.
> 
> Good catch!
> 
> >
> > Fixes: e6745a4da964 ("tracing: Add a way to filter function addresses to function names")
> > Cc: stable@vger.kernel.org
> > Assisted-by: Codex:gpt-6-astra
> 
> nit: This should be 
> 
> Assisted-by: LLM

Didn't know there was a change of convention. Should I send in a v2 or
it will be picked up automatically?

Thanks,
Kyle

> 
> > Signed-off-by: Kyle Zeng <kylebot@openai.com>
> 
> Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Thanks!
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
