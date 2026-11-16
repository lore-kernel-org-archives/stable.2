Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794790550;
	b=XEjvNJJ6YhyXkd1d/fMZhktKoqWdGI4lMDsDf5zOQNQN0mZUsiJbgJQzcxU5IwUcEAz6
	 2U8mY7HZ4F8bEC+ueKutHpBmjcBWKQCBWB14xzLsaTVordx6jP9O+qjsHZTWR+zpGeGSz
	 H2W79r3k10Z4ARznJcsuTFdPLtBNs/yZ04p/rEQoY/1NFun1CyHKVhjLKSd4e6N/wOrrN
	 KWyhsSwfgwpsF4nVoHUHD6XXmcf07v95hTOQZDrMFe9VghbvtrfOGSCXawXw47L1qo4VR
	 uYCIPSEC1puRzqO/5m7naVqPTYVIzrHYeLdWIgNKjL1NWGvdtLerkkA479KwEIZfpAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794790550;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=M1UYvbFN4s2JD4iHUEzkq+8KWPKlmb1MzMCBDckev2I=;
	b=U2wbXo6lAKSBcxKoU/hH5TTnIE/+pNavS8Oxpgu+JCJY0tu/60J5CQQE5Uf3ZlX/F3vV
	 500OxPeNsWv1ujAWlyWG6/6vdlZTKGN9p7wxlEKrEsQ/Sx6j4j2196cIomkR1/cNjdn29
	 cXDSlwq2k1P9c8pwJlNKVORjuRhOGuvn9gheT4GZxapfArdVZwXV5+sgegpdvXN7rwjdl
	 1vANrKEthRMso3KiH1/d/LuEpSmRyiDA9ioK+5lTJueWxv8rwrwMUu0PN4yo5NBasWdgF
	 Ic+2liKjTiQi4eNUk3rwdr08PFUZElydICnbksd1AVYpJHWiCg9FsEST83GWdm3BshA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="b9HKMq/z";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514BA606A31F;
	Mon, 16 Nov 2026 00:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b9HKMq/z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 931D61F000C4;
	Mon, 16 Nov 2026 00:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794790549;
	bh=M1UYvbFN4s2JD4iHUEzkq+8KWPKlmb1MzMCBDckev2I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=b9HKMq/z4ZO31+Hr8UzNLqa0VjRqn9nHuadGPRBb6xOE97NmBlbPcpLln67f4j/Pa
	 dsFjRkN49SpaOi67zUU1b01Fjc+1TL2cDHKE+GOwqtc6rG8FBtjBdwL8iuwG0fR8pC
	 iYS3I2j6bv/zi6AMbLq0NaPbfin5O9uKLvXahTrcE8xRLyQMYEZ/6qzq7l/UG2ocfD
	 CTPFrMZ/yeZpFYv2gVKRujrwxSdRQ15iPKl1ODS5ESIquWKAmKUu52m9cb1KOlcfQE
	 fQHZ2Sn3FFkFErX5qkOcaFjLTG5Qc1p5ef568SS5NWdT6tdAqU2ZI2AMJGYhkGONqr
	 R3wNqbli/DBiQ==
Date: Sun, 15 Nov 2026 19:55:48 -0500
From: Sasha Levin <sashal@kernel.org>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: Mike Rapoport <rppt@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
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
Message-ID: <avpUlHHaimEE_Rib@laps>
References: <avdb9EPXBv2hRCzQ@eldamar.lan>
 <draft-agent5-0008-re-pat-wx-regression-612@kernel.org>
 <2e149d01-c932-42d3-9698-c1555e542cb1@pobox.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2e149d01-c932-42d3-9698-c1555e542cb1@pobox.com>

On Sun, Nov 15, 2026 at 03:16:20PM -0800, Barry K. Nathan wrote:
>On 11/14/26 9:42 AM, Sasha Levin wrote:
>>On 2026-11-13, Salvatore Bonaccorso<carnil@debian.org> wrote:
>>>One followup to this. Reverting
>>>
>>>Fixes: 091c44b2d3c3 ("x86/mm/pat: Use pr_warn() for early W^X warnings")
>>>Fixes: 11d1ba991c07 ("x86/mm/pat: Fix effective RW computation in lookup_address_in_pgd_attr()")
>>Thanks for testing. Queued reverts of both for 6.12.
>
>I see that in the current stable-queue (commit
>3b8ff7f280433e6fb085dbc4f44ac6a138f352a0, "Fixes for all trees"),
>these two reverts are queued in staging-6.12, not queue-6.12, so
>queued up for 6.12.119 not 6.12.118 as far as I can tell.
>
>I don't know if this was some kind of oversight or if it's
>intentional, so I just wanted to bring it to your attention.

It's intentional. I don't want to play with the queue right before the release,
and we've already shipped this regression so there's no reason to rush.

-- 
Thanks,
Sasha
