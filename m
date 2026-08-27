Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D543480974;
	Thu, 27 Aug 2026 15:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787844167; cv=none; b=my+YO6pB8sqkKpELTNTv6MF8yHi3sj6lRJZSoTaS4p8pTR65TneS+2ZyqlxNtqxcG8vG/4ilyfW9vgCx7YbTsm5sQ7fSzhBdZ9BWrZTSxwHfz4pQ4ImqLECZU6iIjl19ZDecg2KBdCDEwbrhoIwn48tby8ayMkwoLyn7hBEjNeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787844167; c=relaxed/simple;
	bh=WTZKGOFkT6kTCaEc0qXSGzIzqscq/mNTg7GBihFghbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nqa+qDV2lzz4lnBCUX2U29hf6TfCFGz4gbhso3Nt6BgsSNhj7UidbTGOkDVQ7vmuzlQC4YzJLBCpIZrZxGhQeamnDzIZ9C2PdI/CStF346E3FohbWM8eV/tPaWIClZNG3hij7l8pTgVu24wo+PuwlTLA/Wm86ou/iL5MC1q7DxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B0LsRI2v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B0LsRI2v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 302CD1F00A3A;
	Thu, 27 Aug 2026 15:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787844166;
	bh=mUzJ1oicaQKOuYkLTR0Ojyn98UVxpazRVOZwD/AFTqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B0LsRI2vsCGCKmvyDxhmaS5dtRSqf2tH1uJUsfkJptmci/Vw63a0C9J/dvYGn+zKD
	 1UkReGIzSk1p16vMggyiBeqhMprtrqiAX+8lgMrqTqYZHwshqSjjy4zau05zeO6w0V
	 guEGDuImyf55SQeq7bX2tfNvJhFDKSUlGZh2HXYbMgpL9xJHw/ic+p0ysbOL6c7daA
	 nnvOtpZbf+IWFGYFNJCR5NKVglDHIaI+pJml07XlqBgZy+BxvJ8QP6sqXBb5Ua0R1y
	 MPZ3hRak/YZhuqYfZu8boyxkhCkBSaXmxuI3MwlgP68WMNovUUg43xcC7Qdimky7pC
	 T7b+ZnGxxVReQ==
From: Will Deacon <will@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Karl Mehltretter <kmehltretter@gmail.com>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] arm64: compat: Fix decrementing LDM/STM alignment emulation
Date: Thu, 27 Aug 2026 16:22:37 +0100
Message-ID: <178784016455.65228.15282615597317035882.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260819222712.81855-1-kmehltretter@gmail.com>
References: <20260819222712.81855-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 20 Aug 2026 00:27:12 +0200, Karl Mehltretter wrote:
> The compat alignment emulator inherited unsigned long data addresses from
> the 32-bit ARM implementation.
> 
> In do_alignment_ldmstm(), nr_regs is an unsigned int holding the transfer
> size. The function uses the same address addition for both transfer
> directions, negating nr_regs first for a decrementing LDM or STM. The
> 32-bit negation wraps before the addition, so the handler adds nearly
> 4 GiB instead of subtracting the transfer size.
> The resulting address lies outside the compat task's address space, so
> decrementing LDM/STM emulation fails, while incrementing forms work.
> 
> [...]

Applied to arm64 (for-next/core), thanks!

[1/1] arm64: compat: Fix decrementing LDM/STM alignment emulation
      https://git.kernel.org/arm64/c/f5b8b9037df3

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
