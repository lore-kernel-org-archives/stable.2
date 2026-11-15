Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794754062;
	b=K3iKyNlY71y+/UYtZrsUXI+HZnvwh4kQADZIMwi6jlAMYvS9A1rTy5xEwp4dhvmbyegf
	 ZLP3JbF3STQJi0XehbUmXl6ccDf7iEG1YokZTQ7XsPf1/x10N4erESi9+a71okx6fwoEX
	 7cLEUqLJeKdgP+8KHLpkIN2P6XX1fSqdzrxLc5zMP+FqdgFG+BzivZARf7hmZAtHZSUcL
	 yu6TZDvgniVIEaXFCDEAuiuRdi5zSYJgC2DADnNH1nhh+m/P9ho2ynpGjoJClTXOA7hZB
	 fF3ta4Ow7SxgmjOQLJmVPjbEcmpH2SK5cAEXbZpCRik6eE0xkc5ICUzioGTWmCP7M3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794754062;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=QGQ6tUHDWALojlytnuZIeG6ZDEf/2IYAOd18Cqb3OV4=;
	b=s4icWVuCIQ7ZafvFaJOALpQLDWk9Fig7weZU1IhIJaJ57vY2xTxzARkpNEdymTQ66Tp5
	 DdOoncKDj6KbwvNfEkwLLAo6M2kOge0nI0uJhi2juLuhdYOkXHVxvRtXbYFTX9Kl8gbgv
	 dY97rGyWhPziXXKPcCvKR8OtQqaLWl799GtrIQNVALkp2y2myBKx6i5mJx+GTcL2EcMOR
	 7HfxsSP87Gwcawfotc5XNQq70u72C9tHXA9QzxRhfxiyv/qkbyg9Ri7NdRMS3Kfvs8JL6
	 QizfYtWc7d4UCZLNDEdbkyYrjJgkMJLfqB7Q4ojDmpTOu5MmWShA6QNkUr1cvaMcCUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="dVfk/QsP";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B26606A31D;
	Sun, 15 Nov 2026 14:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dVfk/QsP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94E7E1F000C4;
	Sun, 15 Nov 2026 14:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794754062;
	bh=QGQ6tUHDWALojlytnuZIeG6ZDEf/2IYAOd18Cqb3OV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dVfk/QsPK0pu5cMzQQoGE2wjCh+bLZzpSt4QwnCfQFVEszWEAsMsjDR4H8THMh/kl
	 fqDl4PelCejzfDBjv9YbIOBQwkqU+0OPCkLQiJaCoL6vV7xesIqNOzDBUL/LwJvu7u
	 6IpcJ6HvMzK7ii2vsr2wOyTmdoQvd1WVl7+lGieZTKHF1c2XhBQpB3IdOJ/0HJQIX3
	 RFJImSIVWiZp2wqVk+eVOo60b073TXgcj8AVRReOkKJqOQYnWBYvsJ04sveZK+bNrZ
	 BQA1IelYg0RjcsLmF7xAUkUVEMlUQYx8OPIjrysyhKcGB9Mt7vw4vDejO2jKs//M9X
	 FqW3fJO9FteiA==
From: Sasha Levin <sashal@kernel.org>
To: Mike Rapoport <rppt@kernel.org>,
	Salvatore Bonaccorso <carnil@debian.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: [REGRESSION 6.12.117] CPA detected W^X violation: 0000000000000121 -> 0000000000000123 range: 0xffffffffc0477000 - 0xffffffffc0477fff PFN 109c1f and WARNING at arch/x86/mm/pat/set_memory.c:665 __change_page_attr_set_clr+0xf62/0xfb0
Date: Sun, 15 Nov 2026 09:47:37 -0500
Message-ID: <20261115144738.1273873-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <avlPaC_oxGeFBeAa@kernel.org>
References: <avcG_ggetL8ArwAx@eldamar.lan> <avdb9EPXBv2hRCzQ@eldamar.lan> <avlPaC_oxGeFBeAa@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, Nov 15, 2026 at 08:21:28AM +0200, Mike Rapoport wrote:
> Apparently, this commit exposes issues in the management of permissions in
> ITS mitigation that was fixed here:
>
> https://lore.kernel.org/all/20250603111446.2609381-1-rppt@kernel.org/

Thanks. That series (a82b26451de1 "x86/its: explicitly manage permissions for
ITS pages" and the rest of it) is already in 7.3 and 6.18, which is why both
keep the two pat patches.

Sadly 6.12, 6.6 and 6.1 have none of it, and their ITS backport is
stable-specific :(

> > On the other hand though testing 7.3.5-rc1 which is currently under
> > review only logs:
> >
> > [    0.096682] CPA detected W^X violation: 8000000000000123 -> 0000000000000123 range: 0xffffffffc0200000 - 0xffffffffc0200fff PFN 100800

That early-boot message on 7.3 is the one ea6fd393cb9e ("x86/mm/pat: Use
pr_warn() for early W^X warnings") describes as expected from its_alloc()
during early retpoline setup, so it is a pr_warn and not a WARNING.

-- 
Thanks,
Sasha
