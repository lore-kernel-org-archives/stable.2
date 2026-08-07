Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD41F37C110;
	Fri,  7 Aug 2026 13:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786110732; cv=none; b=AkDLsolNf1hJpC/GV7dAVH9PaNy0ekGW26N8a9/25Iwy/Jb24NaUqoBUMp+xZf87dAiifMbJ8Jm3X2aV+0IXRKSuMKn6E9uVsuzOcVrzAtiuoK0zTS7hMo75mzQ4+3ohXr5FStkBgNrwSRdLt0TIXtUiMQruPxDW7JLJg9vvyEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786110732; c=relaxed/simple;
	bh=SL2k8YxvomE33GBzz3FB/yPubW0bPUL9LFUE0dko+PU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lUlPV/2uX2k+56+wwqhmyuA/UptA8bJtuUOFARi9p4e0s7mdwF2fvrSZIzhcNabjqVyxtRIDmqko1XC7rFwFS5KKd7sYAleLtVS4uHbJWyAH7YiplID6c6fSlXvKkjOEBA+LlitKib5p/hGawI7pQqi1ilspklofS1hY9hHh4wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NKX0iT2w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NKX0iT2w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46BAD1F000E9;
	Fri,  7 Aug 2026 13:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786110725;
	bh=TU7qxTsLx64c82lDudoUVSZZgDy2qYm1Q8ZxRi20R5M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NKX0iT2wtBQ9qMxDUjCCN9GzO/fBqXmB4CnOT4/52Sw41uRkK7T0Su1ymk9cleiFp
	 FmRgwVtytfQZdB0ZdXdMyC8zI4pNXLiHfghteyq4q4lAvKLNBYqsi0UZw2nrRBpRwA
	 UfYxeEECPRNTlWQa2SmRmlv0Krx1KDNsY9rm/f8U=
Date: Fri, 7 Aug 2026 15:50:53 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ricardo =?iso-8859-1?B?Qi4gTWFybGnocmUgKFNVU0Up?= <ricardo@marliere.net>
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
	sashal@kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Mykyta Yatsenko <yatsenko@meta.com>
Subject: Re: [PATCH 7.1.y v2] selftests/bpf: Add tests for sleepable
 tracepoint programs
Message-ID: <2026080743-savage-qualify-1913@gregkh>
References: <20260807-selftests-bpf-sleepable-v2-1-f7e6566f36a1@marliere.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260807-selftests-bpf-sleepable-v2-1-f7e6566f36a1@marliere.net>

On Fri, Aug 07, 2026 at 09:32:43AM -0300, Ricardo B. Marlière (SUSE) wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
> 
> [ Upstream commit 8a20655749c625dcc4debdfdeeaa0cf8bb85c203 ]
> 
> Cover all three sleepable tracepoint types (tp_btf.s, raw_tp.s, tp.s)
> and sys_exit (via bpf_task_pt_regs) with functional tests using
> bpf_copy_from_user() on getcwd. Verify alias and bare SEC variants,
> bpf_prog_test_run_raw_tp() with BPF_F_TEST_RUN_ON_CPU rejection,
> attach-time rejection on non-faultable tracepoints, and load-time
> rejection for sleepable tp_btf on non-faultable tracepoints.
> 
> [ rbm: Removed hunks from (new) files:
>         tools/testing/selftests/bpf/prog_tests/sleepable_tracepoints.c
>         tools/testing/selftests/bpf/progs/test_sleepable_tracepoints.c
>         tools/testing/selftests/bpf/progs/test_sleepable_tracepoints_fail.c
>        These rely on libbpf's ".s" tracepoint section handlers
>        (0cd420a6f40c7) and on kernel-side sleepable tracepoint runtime
>        support (439ebd5b5708, 12628ffaf98b, 57918341dd19), none of which
>        are backported here; kept only the verifier/sleepable.c hunk, which
>        is correct and needed on its own. ]
> 
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Link: https://lore.kernel.org/bpf/20260422-sleepable_tracepoints-v13-6-99005dff21ef@meta.com
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

You did not sign off on this :(
