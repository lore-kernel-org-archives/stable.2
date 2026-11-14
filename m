Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794678156;
	b=bmblkd7FbEJGmDzUU8A+ghOGMf0BwYVhC8vLmpi5qkI1C0zD31yhEefpmCwC5txOBcW+
	 3FpbpMO9L7Jrg+R20pYraD1N+l5p7RxMm++mSlUgdQk7zRfZOXWzdl+3Btby7fWSRLDzs
	 x8uG2agwJMrdvx/3RyxMQccDemMANqPkgYQO82PK/YqhOy4Zm6YkpXuWNmEZvKglofif5
	 SBfXoK1AsB22RK0WZ3WP+XBygLCI3HZJXlahvhAcq1eFebC8W+f720ClMOLYtcKWHya//
	 TjWHXZ9ElGc9rEJbEEX0AlgUbLIbPMHx23tptTH0CMq3kHsFWLCEp8QfBgEufjwKjCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794678156;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=HtJYtgROtdGCoMRM0DSu7ITj/G1KdynVsDgrtLNJ9w0=;
	b=xno/jTYH47G0SAXCjF7yH9m1HxK3YEuVDIvQwjXMs0xGJ2mBp/lR/NZlMm6hwntrwg4v
	 aHz9JSARd0uQ5xG7U80xyjC/2hsPkHeftk7skRxloJaVnXJNK+ei+zAYKtrV7IjbXvYJp
	 DGCOt+XqX49iTMZstx/M0KcEKMeXSjw8q9ouYHtgtykAmtSrlnhTSBtXMYsvPxT7tYKBM
	 i1+77JlUtXpOipZgc6drEi7s/8xeITsATinQioRi2zgktJYKnyMSaz99cJjm5pPj4C4SA
	 xKy0/0evAf4ZAeC9oDK9jVohocCqfhT4mgQCc7A71p9011pC1z4D/Gx0f8T76qeuoOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HeHAFnLj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B67606A332;
	Sat, 14 Nov 2026 17:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HeHAFnLj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47A161F000C9;
	Sat, 14 Nov 2026 17:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794678155;
	bh=HtJYtgROtdGCoMRM0DSu7ITj/G1KdynVsDgrtLNJ9w0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HeHAFnLjjgJ7xVGh6nHTYL18M3cImWBWBn8+POcOP8326sGeDaspl+g70rSiHmhJr
	 eR1CGHrn0CfFkcIQgxi/4pi0ryrpz6k0Ny5gd3xhdndvYM+nokidjFsAvfVLi4jtDS
	 ON+yH9VxTKNmhnfh5QneakEBEKg6odggqqGns3fIgc/U8n7XuOnRywChRecAch6WyN
	 5NgB+LsRhowvucBz0LQIzAqg3RFb/ttTg8GhgQcQp8u3aq6x7vUh3fz4hBdAonMm3w
	 FvWc87dk8WDJIp3WprSHXCExE6m5eNTM6CzYoQoXcMLPQNlfdD6RuEgk/XkXFyXAsk
	 aF5sBRAG1dXjA==
From: Sasha Levin <sashal@kernel.org>
To: Mike Rapoport <rppt@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>
Cc: Sasha Levin <sashal@kernel.org>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	regressions@lists.linux.dev,
	Salvatore Bonaccorso <carnil@debian.org>
Subject: Re: [REGRESSION 6.12.117] CPA detected W^X violation: 0000000000000121 -> 0000000000000123 range: 0xffffffffc0477000 - 0xffffffffc0477fff PFN 109c1f and WARNING at arch/x86/mm/pat/set_memory.c:665 __change_page_attr_set_clr+0xf62/0xfb0
Date: Sat, 14 Nov 2026 12:42:19 -0500
Message-ID: <draft-agent5-0008-re-pat-wx-regression-612@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <avdb9EPXBv2hRCzQ@eldamar.lan>
References: <avdb9EPXBv2hRCzQ@eldamar.lan>
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

On 2026-11-13, Salvatore Bonaccorso <carnil@debian.org> wrote:
> One followup to this. Reverting 
>
> Fixes: 091c44b2d3c3 ("x86/mm/pat: Use pr_warn() for early W^X warnings")
> Fixes: 11d1ba991c07 ("x86/mm/pat: Fix effective RW computation in lookup_address_in_pgd_attr()")

Thanks for testing. Queued reverts of both for 6.12.

The same two patches are also dropped from the 6.6 and 6.1 queues, where they
had not been released yet. 7.3 and 6.18 keep them, since there the check only
prints a pr_warn.

-- 
Thanks,
Sasha
