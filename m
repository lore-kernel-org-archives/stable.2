Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F342228CB8;
	Fri, 19 Jun 2026 23:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781912916; cv=none; b=Ya0IjbvTXykTa5SyALIzssrfiugnqZB7L6z8OuP7jGV5MSxseeQ1JdpizKudSOG5331SJMg0cLLfe5FGne6bnrzdad0l76UCfwYyhv4hiLZ0t+KJeXXT/gL3LIWNKnwMSnjXzd4CgjOVYaybvGo3fGhADF/Ydl+m55tOjewydac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781912916; c=relaxed/simple;
	bh=eqjqJ+7h1dJRVBsyBO+sVdsJZmi82KGRNCk5UaQJRAg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=HB5TKg27c4AknnMPvjM99jCCLb+bvrpna5pXsPtiPgitgNmQ6BPIT9L2H0fIzewkTZ6cFDYEUKRYDaR4JHbVZnioC5DKh7/oI2ejCHZbjMwo1lS/+wYCSRgf7vCbcAaSQfSWjcMh/LVrpCupVt76ItJAjDyvSk/oQMsls3eTL9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZPE66xHL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZPE66xHL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 593421F000E9;
	Fri, 19 Jun 2026 23:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781912914;
	bh=g4GIzilWlhtH+Qv/ZD/5kYORu50P/Wnuw4dHhWv8iuw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ZPE66xHLvytGOiz28iX+1N7cX4t1xx5btWlJllVIFPv0jXmo3MY/1QfLzVaOveGff
	 GjZo4kI0Ko9GUFeQ+4JB3Q5hLYViuKsSMaRwXWibEikx97jrwY52ZFlxIJoeEubXkk
	 O56r2rMMkLzeZpLJu00nyZtlCjqcZ9ib17TIJ4lb+ZL0xmGsmh6XD3GSNbIknkTqq0
	 kvAOZi8kIi7JnvoCS/0Q5bSbo2BqLs1jOIP5lbVZ+AU6NmgHDdMGsnZBoQmcqLVwXp
	 c2DbNfXP1w3XGBTuekumzPXrybNDig5J2baLcXn9AHqMDCwWyWUweoSrtHn6KC/dmw
	 S2a2IDJL4VlAA==
Content-Type: multipart/mixed; boundary="===============5738735854790552785=="
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <506d461e2bc29b76c549782e4eba5ddff2182853ed187f5a972998ab37ff94d9@mail.kernel.org>
In-Reply-To: <20260620-resolve-btfids-implicit-args-use-after-free-v2-1-4132e1f639f0@mainlining.org>
References: <20260620-resolve-btfids-implicit-args-use-after-free-v2-1-4132e1f639f0@mainlining.org>
Subject: Re: [PATCH v2] resolve_btfids: preserve tag and parameter names when processing implicit args
From: bot+bpf-ci@kernel.org
To: aelin@mainlining.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,stable@vger.kernel.org,aelin@mainlining.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 19 Jun 2026 23:48:34 +0000 (UTC)

--===============5738735854790552785==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> process_kfunc_with_implicit_args() obtains parameter names through
> btf__name_by_offset() and passes them to btf__add_func_param() while
> constructing a new function prototype. Tag names are processed in a
> similar fashion.
>
> The returned name pointer references memory owned by the BTF object.
> btf__add_func_param(), btf__add_decl_tag(), etc. modify the same BTF and
> may grow its internal storage, invalidating previously returned string
> pointers.
>
> This can result in btf__add_func_param(), btf__add_decl_tag(), etc.
> dereferencing a stale pointer when copying the string, leading to crashes
> in strset__add_str().

This isn't a bug, but could the crash path in strset__add_str() be spelled
out a little more?

btf__name_by_offset() returns a pointer into btf->strs_set->strs_data (while
the BTF is still modifiable and btf->strs_data is NULL), and
strset_str_append() in tools/lib/bpf/strset.c already reconstructs that
pointer if the buffer was reallocated before it copies:

tools/lib/bpf/strset.c:strset_str_append() {
	...
	old_data = set->strs_data;
	...
	if (old_data != set->strs_data)
		s = set->strs_data + (old_s - old_data);

	memcpy((void *)s, ...);
	...
}

Given that reconstruction, what crash in strset__add_str() remains, or is the
strdup intended as a defensive/robustness change rather than a fix for an
observed crash?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27852582382
--===============5738735854790552785==--
