Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51D72CCC5;
	Fri, 12 Jun 2026 13:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781272632; cv=none; b=YlBpSEjdDfCCQi5zvsvhX1DODiWQE22m8okw1wCgorRE9uBj+p8N2kKXLQ9KPqEWk1Xwgpw9f7byvJqGTYIRILma6847EC1pWmBc7g0SLnlkCWoGk08XBcbyl7m4rvSWjVSH7UsbeiqK8OrK1z5oXYLrM8VDvkLW7CdJctxt3uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781272632; c=relaxed/simple;
	bh=aAEGomf7fCgMtXxusNJUXzl2v7qaXrMxpBgHmFxftuE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=C7F1AlpS5iy6iQCMnQydL9OAZqk9O6mLQ8x4gvom3dNb3rfcwx6cibbYBVOGPL0c0l8cfpRIHfjhXgyY9N4+1oKf5zATnbB9tmmSH7meaY2xnDotqxwhZS2GQv0DCjck8IGF34QyTjvJH4crmPlb9seEvHLL1A9yGrQsf1hFaGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DUY+W1Z2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DUY+W1Z2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2B961F000E9;
	Fri, 12 Jun 2026 13:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781272631;
	bh=/lNiQ+egB50H4alLMWj6od03wquW6amLjzzkohRA0d4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=DUY+W1Z27/fC+4LPI0X2jfJqGuKqlJeoS/uhj4/K+P1cr53u29Kmma93piFm5BlHV
	 oGCBD9jRI8Z7OpTiTrVRQO3l0XFDGa2+SG9vw0e6K5Z6iHshBf3hKa8M/X6a4dIcG/
	 t7WbDvKam1Goi6VI/cpuH88y8S+F8PJvkCLF+mhsZF/Rs+M4C2MT1D8YZv3U9wTNsY
	 l5sFE4Djs0GF21+ReBYB+miaZOFK4cKi5rET8vGr3up/4clG0O5p20JjvfjSCDg8ax
	 BwAnqLfulfxsDLVCjkoQEkt5Fp92TggFpEQY6My0IxbyTpfaNsXeQE0z/Q3PVOLMsl
	 pr7yFpvf7iqEQ==
Content-Type: multipart/mixed; boundary="===============2909177856742632511=="
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6f5a32184a62bf2ef732ef44788fe82ec726bc12d59534ff0e23c3f0f103bfd0@mail.kernel.org>
In-Reply-To: <20260612130919.299124-5-jiayuan.chen@linux.dev>
References: <20260612130919.299124-5-jiayuan.chen@linux.dev>
Subject: Re: [PATCH bpf-next v3 4/7] bpf, sockmap: keep sk_msg copy state in sync
From: bot+bpf-ci@kernel.org
To: jiayuan.chen@linux.dev,bpf@vger.kernel.org
Cc: rollkingzzc@gmail.com,stable@vger.kernel.org,2045gemini@gmail.com,john.fastabend@gmail.com,emil@etsalapatis.com,jiayuan.chen@linux.dev,daniel@iogearbox.net,sdf@fomichev.me,martin.lau@linux.dev,ast@kernel.org,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,davem@davemloft.net,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,jakub@cloudflare.com,shuah@kernel.org,hawk@kernel.org,rhkrqnwk98@gmail.com,ihor.solodrai@linux.dev,cong.wang@bytedance.com,linux-kernel@vger.kernel.org,netdev@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 12 Jun 2026 13:57:09 +0000 (UTC)

--===============2909177856742632511==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 6e345ca65ca1..643411e292ce 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c

[ ... ]

> @@ -2792,8 +2833,10 @@ static const struct bpf_func_proto bpf_msg_pull_data_proto = {
>  BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
>  	   u32, len, u64, flags)
>  {
> +	bool sge_copy = false, nsge_copy = false, nnsge_copy = false;
>  	struct scatterlist sge, nsge, nnsge, rsge = {0}, *psge;
>  	u32 new, i = 0, l = 0, space, copy = 0, offset = 0;
> +	bool rsge_copy = false;
>  	u8 *raw, *to, *from;
>  	struct page *page;

The netdev reverse xmas tree convention orders declarations longest to
shortest (Documentation/process/maintainer-netdev.rst).  Here the new
"bool rsge_copy = false;" sits below the shorter "u32 new, ..." line.
Should rsge_copy move up with the other bool declarations?

[ ... ]

> @@ -3027,8 +3098,10 @@ BPF_CALL_4(bpf_msg_pop_data, struct sk_msg *, msg, u32, start,
>  	 */
>  	if (start != offset) {
>  		struct scatterlist *nsge, *sge = sk_msg_elem(msg, i);
> +		bool sge_copy = sk_msg_elem_is_copy(msg, i);
>  		int a = start - offset;
>  		int b = sge->length - pop - a;
> +		u32 sge_idx = i;

The same ordering question applies here.  The new "bool sge_copy" and
"u32 sge_idx" are interleaved with the shorter "int a" / "int b"
declarations rather than sorted longest to shortest.  Should these be
reordered to follow the reverse xmas tree style?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27418314509
--===============2909177856742632511==--
