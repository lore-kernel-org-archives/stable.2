Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794826575;
	b=vnBPczxtpveiuUhDg4Egft1jdP77aiPFnIYhFKPGPPC0NwQaHS5Z/Pb6/pLxd/Y67ubM
	 JCYaocTqBRjxigBAmkHc47hc0sSl5HWwcgSlBbFoOgxQVQbpgRWvYmTWqVazLBVgMxDuM
	 vzJ4eKIMSFGd77T/t9UH/0/XLNT74LAJ2EPoEGQKTh06Apg9bEXNzKt66n9wj4ZubC2u6
	 z+BCSKBo4P3cZ8BFc8xjZaRyVzpkNKC7kDNw6vWc9SOIV7HnHSbZFFNyLi6nKtPJz9Rg1
	 ldZ40CjczwPSX1bQ5hpcbbG+RfUFgvS0MkosDeIhy6lM9+yWHL7hOfoBXqBiLr1tHBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794826575;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=zzC9mBd2vZ7VW00+ztDx5uBwxIv15/snwEy/NF1H0SY=;
	b=WVxUP4oV00gm7Z3yjycWtbVr9kXXALc+xNYjpu4VQTS1z7uVrlwVemvRDQUQ74OEg3Zw
	 Lyw5ZkA4whv2aQJnY4mqHv2kfaTA9IMjSUKYvszUKvTCkVrQ1EJUq7M3p1LrnWKOUAaCJ
	 YaX2OPs/WO0CJ70VwdpzIOp9qzmvHlc9nFsc646J8GoCnqlrI5I9sWlcdlKae6e77wyzm
	 vS4MNwQ/lLC6JPcq/SqEutKjp4NKGlvtjSU18OI8Xfyx1i+wuLycp9Tl7Cs3elC6WVPMP
	 9oFkYhHzv5Q98d68CTzSnsjfEo+FUymKsm4BrYEcLCjlG55f88oRwfpFK6NSam+KPnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ko+hJvMw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23221606A32A;
	Mon, 16 Nov 2026 10:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ko+hJvMw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 675B41F000C4;
	Mon, 16 Nov 2026 10:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794826574;
	bh=zzC9mBd2vZ7VW00+ztDx5uBwxIv15/snwEy/NF1H0SY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ko+hJvMwamhUSFrHRHQdyoFWI1pQGPuilHDbv87uoPkKbCdWXDYkn7nuRy02cMzys
	 /1L63aZjXQWx7qlINzyYbT+BmPVJmsbR6u0YIT2nsZDgxQ6PB2TH4cF4+WWklE7R5+
	 iQ3fYqxguzI77F0yEIVZ8LYZNNslqeS6w6P7RDSzlAAnmBkdEbDYzfeBxCXmA9lG+7
	 Jnr+cigZupCLFRllacTG03FN30tY8cTefVkjmSh4glFfqc7BFgZSdjHK/yeHvNRzXd
	 0Gtq11wP1PBArDxmy1imqR671YWgXOGsBqRTAadiqvu6QKDSJDuHO8cYK/3lqj5GV2
	 5OqQ6x05GPH7A==
Date: Mon, 16 Nov 2026 12:56:06 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Sasha Levin <sashal@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, regressions@lists.linux.dev,
	Salvatore Bonaccorso <carnil@debian.org>
Subject: Re: [REGRESSION 6.12.117] CPA detected W^X violation:
 0000000000000121 -> 0000000000000123 range: 0xffffffffc0477000 -
 0xffffffffc0477fff PFN 109c1f and WARNING at
 arch/x86/mm/pat/set_memory.c:665 __change_page_attr_set_clr+0xf62/0xfb0
Message-ID: <avrhRp9Je2ip6bKM@kernel.org>
References: <avdb9EPXBv2hRCzQ@eldamar.lan>
 <draft-agent5-0008-re-pat-wx-regression-612@kernel.org>
 <e258c325-4b4c-4738-8de7-733da90b532b@oracle.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e258c325-4b4c-4738-8de7-733da90b532b@oracle.com>

Hi,

On Mon, Nov 16, 2026 at 03:01:26PM +0530, Harshit Mogalapalli wrote:
> Hi Sasha,
> 
> On 14/11/26 11:12 pm, Sasha Levin wrote:
> > On 2026-11-13, Salvatore Bonaccorso <carnil@debian.org> wrote:
> > > One followup to this. Reverting
> > > 
> > > Fixes: 091c44b2d3c3 ("x86/mm/pat: Use pr_warn() for early W^X warnings")
> > > Fixes: 11d1ba991c07 ("x86/mm/pat: Fix effective RW computation in lookup_address_in_pgd_attr()")
> > 
> > Thanks for testing. Queued reverts of both for 6.12.
> > 
> 
> Thanks!
> 
> Quick Note: We are just reverting the fixes just removed the fixes to the
> checker and the actual broken commit is: commit: 88a817e60dbb ("x86/its: Use
> dynamic thunks for indirect branches") that introduced this problem.

It didn't introduce a real problem, the permission are correct in the end.
It's just the intermediate state that causes warnings.
 
> thanks,
> Harshit
> 
> > The same two patches are also dropped from the 6.6 and 6.1 queues, where they
> > had not been released yet. 7.3 and 6.18 keep them, since there the check only
> > prints a pr_warn.
> > 
> 

-- 
Sincerely yours,
Mike.
