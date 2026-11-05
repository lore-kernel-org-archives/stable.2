Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793863923;
	b=Ivo7UPFsuDWxIlbATx+rN/tKrByy37WiZ8FxOrs0wHa/X3qG/gJRWDQvOR75ytFTv5J3
	 KrIJWQ6Na3i5xtm1ZmX8nHeFGTS9y3AYmMFut8KqaFhf5QuXIurF1MGahYAWrhZtkYII7
	 R/5hz6uGmN0/sYaSFz8MAi0Uwqk4GvEIa1mbTd2Jqr4p1qUupqZQ4lxaWUFGGPbzfnJwV
	 prjvQxuznywCz3ycLbm9jJOXmo2jvFHM+NcqI1dtwiqLTzKXY6cj3yrnfDAyd7hr658k1
	 cNYoZW3IQIZnAMsN+nzrX7VPaCsorw3C3gfRwXrQ0rcIPGbYxxLjtJbD5ZNKkxyUovg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793863923;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=qut+o9RNOWx+p3+EgaaMdyh0hql3gy62QI/KJOsjcS8=;
	b=OMKL++4Sv7wYfD/VGADHttz8t9Al3zQXynBZLd/5ilsOz9zKpI+wpQdMwbSZqau0ahOH
	 R5ijclSgzKRZ6z4vyDVjoP/7s9h7+u8YIyArhg2PxlILF9Orp1BNOGar4A2VJoabnspsJ
	 U6E609Ys5otSM/YCprdNJoLX7HiUeZYfz4LkPddnAJro8bHFJyqPVA94iHFrQBXkN/cZl
	 MohFiZdG3d976IdUpwijJXIYW0rdUV0K6V68H9kK2fPWk6w7Z3hmra6AiTeFtnRGBtRyA
	 0wc/i4Jg88CSNj6m2zPYDjb4EICbtrVChB0nXG/vb79XryL5qo0N2GqfgEaANGMFjSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TsSmcafP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C43606A329;
	Thu,  5 Nov 2026 07:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TsSmcafP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECDA51F000C1;
	Thu,  5 Nov 2026 07:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793863923;
	bh=qut+o9RNOWx+p3+EgaaMdyh0hql3gy62QI/KJOsjcS8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TsSmcafPn1jxndKLyIKWP2CLnVnLD4GebBHAZtrVu8vpuRXipU7PXQqTF8ATPb6Io
	 KWCCG44JAWH5DaUjjAoQ1kgnW//OoQa6pk6Wt4nSJcWnyDsoFnQzT1HNdEI+HS+ERc
	 o58tJEa+Htxa6VqxrnzoPCrtS4Rg/X387DgTAh93oNCUhA0CrUrZZxe6LoNWn8XwG1
	 qgSfzzIJP3eXGQ9EwxHF4HmiYJKQPtQB/P2aDVYI267xttlUzV2LgjYwrIvUTaNi9o
	 7Jjv1T9DDWZkvqEcMNtXotzCVgnR2akBwo7YWAO78qn9KXGt6TBm5rXmMTey0++zSe
	 lxEQkhSu/eB7Q==
From: Nicolas Schier <nsc@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>,
	Dmitry Kandybka <d.kandybka@gmail.com>
Cc: Nicolas Schier <nsc@kernel.org>,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] kbuild: Makefile.lib: fix offsets generation with debug info
Date: Thu,  5 Nov 2026 08:31:38 +0100
Message-ID: <179386358248.407677.9715146183925543248.b4-ty@b4>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026074733.11777-1-d.kandybka@gmail.com>
References: <20261026074733.11777-1-d.kandybka@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 26 Oct 2026 10:47:33 +0300, Dmitry Kandybka wrote:
> When debug information is enabled (e.g. -ggdb3), the assembler
> output file (e.g. kernel/sched/rq-offsets.s) contains additional
> directives such as .ascii with offset info and debug metadata.
> 
> For example:
> 
>    .ascii "->RQ_nr_pinned $3048 offsetof(struct rq, nr_pinned)"  #
>    ...
>    .ascii "->func); __data = (it_func_ptr)->data; ((void(*)(void *, pro"
> 
> [...]

Applied to kbuild/linux.git (kbuild-next-unstable), with patch history snipped.
Thanks!

[1/1] kbuild: Makefile.lib: fix offsets generation with debug info
      https://git.kernel.org/kbuild/c/131d86d0

Please look out for regression or issue reports or other follow up
comments, as they may result in the patch/series getting dropped,
reverted or modified (e.g. trailers).

Patches applied to the kbuild-next-unstable branch are accepted pending
wider testing in linux-next and any post-commit review; they will
generally be moved to the kbuild-next branch in about a week if no
issues are found.

Best regards,
-- 
Nicolas

