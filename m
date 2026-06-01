Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95212F6918
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 22:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780351300; cv=none; b=R2X065+7Gmeo2XJvTvPbnunywDOkeRxXLVgdyMUTExy/jJRnBvvQAWZWJSpjoCKPKKrwVyWkucyyGgNyQk/F3F2OvbX8lGSAjZOoM+NlX2EcATzTPJq9jrt6T2X9Q6MILCTZmozZ5LRpKJzhbA8KEtZJxbpNSp+XHxZ0gNSl8II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780351300; c=relaxed/simple;
	bh=9EWVW/fMGsD0Vc4JuQyifWM+3sdYROeL6G7Y4FwA6Ps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U3xgTkak3ybSUywBY8SgnrCPBBhLk/U8TEQAt1dQnlO/6tVHeiyVrLlUzmzb/Y/uocN26kx6YqTgZaOHKNIJKi0hU/bk5coM22GrEGlUZYeNOuPMTowcBFon5Bl2Ng1QVq5GOAL/lvpt+Ej8ro5sNasFdGP68cm1fBXMoJ9XniU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aKuDtBJu; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aKuDtBJu"
Message-ID: <5c033c93-34c5-4c96-943d-9e188781862f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780351287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i5UXeEpVRWk/7pp5peY2hPYH88DbZjlJJmxE7GKZAmQ=;
	b=aKuDtBJu88GLWgQ1oatZkZdGubqwXBqAyCVf/+ygsoDfnfFKdbLwI9iorb8n7/1iTGBBV3
	Bs2CX25I7RyqFOh0F+qcuED4R7/3IegFHdEx2tjqLchh+lwg8/IsZjONRggg/72RfK/UGT
	QdbvsHkWwOke+D7kCJKx36F4GbGiroo=
Date: Mon, 1 Jun 2026 15:01:19 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 3/3] bpf: cgroup: restore sysctl new-value replacement
Content-Language: en-GB
To: Dawei Feng <dawei.feng@seu.edu.cn>, martin.lau@linux.dev
Cc: emil@etsalapatis.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
 jolsa@kernel.org, kees@kernel.org, joel.granados@kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, jianhao.xu@seu.edu.cn,
 stable@vger.kernel.org, Zilin Guan <zilin@seu.edu.cn>
References: <20260529031026.2716641-1-dawei.feng@seu.edu.cn>
 <20260529031026.2716641-4-dawei.feng@seu.edu.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260529031026.2716641-4-dawei.feng@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 5/28/26 8:10 PM, Dawei Feng wrote:
> Commit 4e63acdff864 ("bpf: Introduce bpf_sysctl_{get,set}_new_value
> helpers") changed the success return value to 0, but failed to update the
> corresponding check in __cgroup_bpf_run_filter_sysctl(). Since
> bpf_prog_run_array_cg() now returns 0 on success, the legacy ret == 1
> condition is never satisfied. As a result, the modified value is ignored,
> and bpf_sysctl_set_new_value() fails to replace the write buffer.
>
> Fix this by checking for a return value of 0 instead, so cgroup/sysctl
> programs can correctly replace the pending sysctl buffer.
>
> This bug was discovered during a manual code review. Tested via a
> cgroup/sysctl BPF reproducer overriding writes to a target sysctl.
> Pre-fix, bpf_sysctl_set_new_value("foo") was silently ignored: the write
> returned 8192 and the value remained "600". Post-fix, the BPF replacement
> buffer properly propagates: the write returns 3 and the value updates to
> "foo".
>
> Fixes: 4e63acdff864 ("bpf: Introduce bpf_sysctl_{get,set}_new_value helpers")

Maybe to have the following commit as the fix tag:
   f10d05966196 ("bpf: Make BPF_PROG_RUN_ARRAY return -err instead of allow boolean")

Also, for subject, please remove ': cgroup' (including the patch 1 and 2).
The 'Restore sysctl new-value replacement' is not really clear.
Maybe 'bpf: Restore sysctl new-value from 1 to 0'?
Other than the above,

Acked-by: Yonghong Song <yonghong.song@linux.dev>

