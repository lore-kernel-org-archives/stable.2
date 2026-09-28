Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7DF499F0C;
	Mon, 28 Sep 2026 22:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790635159; cv=none; b=m2LqIiqeCqA5gF0u94rKbDwAWuO4XgY20uMJzCdCpC3/k550Kgp1AxOKC2NbqSNfaoj8/W7xRNKD5vJuTjQ7M6mNC0+HBoqjAqN9zpPPvZ1RhNCyY8i8S0g1MtdrTPsczigBP4AzWDDRlyYqOPTMu7inaf6BupyqVzaNx4YH0PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790635159; c=relaxed/simple;
	bh=P+s+U8O+yVO/12ZXol6bRvfjkFAxEXGnv3nDTRHGEss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nHwfZ3dwM7ooCYdx4CVhXucE4kOQGtpxNK9kaZIaKWIsFZxdRyMH7gdIGHCoK/B4+/OUpbls75OXkc4ihDqUvq4LElF8xncuFKGmMgADvpjM+GdkwlSGKafp2TzH0M6fQyJLWKFQv7EAfCp6c+UGZ7FKNX2VkM641JMUGiDVdBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dMf83G5b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dMf83G5b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F091F00893;
	Mon, 28 Sep 2026 22:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790635157;
	bh=xMdyLjftnH/OJ8gRUrodvRCRgcmw687ttfCXUGdrh1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dMf83G5bLsgk1PZ9VYjbqGvihVyC8tlO0yw8Vh2rYHhieN4jeBGarXZGAmUxxxLCU
	 XMPzzY+PayQPKDdGUeV+k2Bh3rJis4eVenUWW7SYKfJztLrMBorhqGFIeuajQjB7Rl
	 TcUJvRRRRx+e1c+t4wJKTj0xrbgtbW+2ZCqNQBiS6426kviPf98bcGptj4qwzfjCRs
	 FQRnWLLyjSaTwlVN8Cem2rWWfBD2HQQ6WTN6agPwn50FKdT4Yed9vzYsFwvcB1EXI1
	 PglIfQ1yOW3OEOB/l9rpgZ4K0xEeDZWehLHqloJBMh2HniJgoweTd6EDXpY/ugKkqw
	 x8yqlvv9RyLFg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	bpf@vger.kernel.org,
	Pablo Greco <psgreco@gmail.com>
Subject: Re: [BUILD BUG] tools/bpf broken in v5.15.221 stable due to backport [7140c9e5e460ee11172ea6c1a6e368b29923003d]
Date: Mon, 28 Sep 2026 18:39:07 -0400
Message-ID: <2026-09-28-2-daily-reply-0003-re-bpftool-5-15-build-break@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAK9Zeh8NgWCdXy6dUiakqy+L+fieU8NJxJNxPadbF0UPHWUqyQ@mail.gmail.com>
References: <CAK9Zeh8NgWCdXy6dUiakqy+L+fieU8NJxJNxPadbF0UPHWUqyQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> IIUC, both issues could be fixed by porting also
> 4178893465774f91dcd49465ae6f4e3cc036b7b2,
> 22dd7a58b2e9965c1a612b6a09c4a6146cbb5873 (along with their
> predecessors)
>
> or by reverting 7140c9e5e460ee11172ea6c1a6e368b29923003d and its successors.
>
> Please advise on how to proceed.

Please don't backport the libbpf API changes. 7140c9e5e460 ("bpftool:
Update btf_dump__new() and perf_buffer__new_raw() calls") only came in
as context for 66d7e39e49b0 ("tools/bpf/bpftool: Reset vmlinux BTF
after map commands"), and changing libbpf's API in 5.15 to carry it
isn't worth it.

Reverting only that commit builds cleanly here. It conflicts in btf.c
and gen.c with 44f58f0c5202 ("bpftool: Use libbpf_get_error() to check
error"): put the btf_dump__new() calls back to the 5.15 argument order
and keep the libbpf_get_error() checks. Those two files matter even
where they only warn, since with the new argument order printf_fn is
NULL on 5.15 and 'bpftool btf dump ... format c' crashes. The rest of
the chain, including the vmlinux BTF reset fix, can stay.

Nothing is queued for this yet.

-- 
Thanks,
Sasha
