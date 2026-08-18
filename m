Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406E1126C02;
	Tue, 18 Aug 2026 05:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787031145; cv=none; b=SutE5MPLD0GxkeQzBuIbYZP79Gg/snJazbz8f5wpV2yO7q2spjnjF9AyexIFhCJ17pxX9YUH7lbCLDl1yPFaMvJ9EPPhY6rR13hM41pof2leI/CiQNo6z/rXpu/lUh2KcSK0g2C+VCswVk5f3ryqySxTrz3fPG0vfQZ5QytkH8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787031145; c=relaxed/simple;
	bh=Myv9545VXh1UbNtD7SIEKhWUlne5iTFbG59TgHycbI0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=q8DtGQB227UmiUTQkIj6r4SexX20js4KgqF9eO5t5GvTkAvxB+f5CqcUno8w11TNFYR1MHRs4qDJBGLz0xiM61DsOropBfUt3Q1OrkC9DjUvAxeFITW+B5PiKGQ5//F1c85V6tIdYRMJSGbmbbotmxYdN5zflPGp6IOlBntfQNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X17YOm3X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X17YOm3X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C471F00A3A;
	Tue, 18 Aug 2026 05:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787031143;
	bh=xqEOC9o82H8i32IOhPuRcujpGfAhiDk5sbY8kZHNVEQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=X17YOm3X4GeYsL9scES2J/xoQ709g+sMgwM+Rs/Lt0u7YmBgn0hMUS+A07eLxFpKF
	 5ZnEliZllubPHeJb7eK7HjwE4j6n8GZ9X3xAa2K2doqANan3oidPLjyU3js1medE81
	 O7OzDqoZvJhKh9EqRWPhHKpLkxRqWIpXoCiMqdSS5aHLHENmNDH5lVc3UWKA5omHB2
	 eAlhChtMBdJMkG5iY3AkURDuZ8NVsuxo0ZzMkmrXZ7DK6gO1uPHum/rC9uElhwt4wn
	 efDy4LiGf5CnDQ/wIbBK8b38tQqfY6GOJrSfYegllhnbYlYcgDeoH/9QTG3hJoL6cy
	 jt+ykvy7qoK1w==
Content-Type: multipart/mixed; boundary="===============4478420559103731716=="
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <887e651f0de24f2955f533b85551294f9aabd54934cd398ef70c3decf43b2a48@mail.kernel.org>
In-Reply-To: <cbbffb007454434ad67a7a09cfe26bd68e1edb5c.1787027080.git.skb99@linux.ibm.com>
References: <cbbffb007454434ad67a7a09cfe26bd68e1edb5c.1787027080.git.skb99@linux.ibm.com>
Subject: Re: [PATCH v12 3/8] powerpc/bpf: Move out dummy_tramp_addr after Long branch stub
From: bot+bpf-ci@kernel.org
To: skb99@linux.ibm.com,bpf@vger.kernel.org,linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com,maddy@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,shuah@kernel.org,linux-kselftest@vger.kernel.org,stable@vger.kernel.org,venkat88@linux.ibm.com,yeswanth@linux.ibm.com,skb99@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 18 Aug 2026 05:32:22 +0000 (UTC)

--===============4478420559103731716==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Fixes: d243b62b7bd3 ("powerpc64/bpf: Add support for bpf trampolines")

Does this patch fix a bug in d243b62b7bd3?

The commit message describes the change as moving the dummy_tramp_addr
literal from the top of the long branch stub to the bottom so a
disassembler can walk through the stub instructions without hitting
embedded data. The message states "the actual program layout is never
altered. Hence no effect on overall program size."

The 8-byte alignment invariant the changelog mentions was already
established by the immediately preceding commit in the series, 206e0a244d70
("powerpc/bpf: fix alignment of long branch trampoline address"), which
carries the same Fixes: tag plus Cc: stable. Before this patch the check
already ensured alignment:

    ool_stub_sz = IS_ENABLED(CONFIG_PPC_FTRACE_OUT_OF_LINE) ? 16 : 12;
    if (!image || !IS_ALIGNED((unsigned long)fimage + ctx->idx*4 + ool_stub_sz, SZL))
            EMIT(PPC_RAW_NOP());

where 16 is 4 OOL-stub instructions and 12 is 3, with the .long
immediately following them. This patch re-derives the same constant for the
new position (44/40) but does not repair a misalignment.

Keeping the Fixes: tag will feed this patch to AUTOSEL and stable even
though it appears to be a readability improvement that textually depends on
206e0a244d70 (the reworked comment and constant hunks will not apply
cleanly without it). The absence of Cc: stable here - present on both
predecessor commits in the series - suggests this patch was not intended
for backport either.

Should the Fixes: tag be dropped, or does it repair a specific observable
failure beyond the disassembler presentation described in the changelog?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32100929603
--===============4478420559103731716==--
