Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795448284;
	b=jLdWZqsN/eLQD1DckdWNHBdn/7BQNaMioQREJgi/QX3RaS49Cw7LuKGzcNEVDSor+TsP
	 2IeMJA1qTwc5ZIaKUCb/r2+/HCGE+oulZ4DdSmJInU/pKqjq/VRBVeuypxWm1fuEhyRPi
	 aZYmqufX/FT2hD2x1ul/d47OJ7a7ChtoeT7nCFyZ6A+++b34uhsaOrMulbC69c9mBGyEr
	 rRJb1Xpdm3D4aiI9Esa9E+ALU8AfAz8ue/9VyWeb5Bqg9xHtRc7mNbHSIQOMGUWswiTbA
	 IBUy2xBzBVwDBWVvEVIoWYu3m/bjUdZgbYW5Z2CNVyaPKWwwQor/NLxE/rot2oT2Mig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795448284;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=+Dr3Yxe6IMfqQTqamQRvWaq+1EPQPGHIOcF25gOzcos=;
	b=QYz+MuI2XhUsb60QvmeQomV7oWeAgg3v+MGvLFdls9I3L0Cxg/2D+h8SME2Isd40q0Ja
	 siG/FOa2j0JHrF5JKoBFg2gc+QHuejBnQKuWRht57Y/wyYus8UDnp76uAFTo2TyidmKr9
	 1mqRmHjTN8ikYioHsq/hvx8fBXcwypenpwRHcXUU0gPnhi38v9PQ47//K6BDiSs+szFIC
	 pqUk3HrgnPajmfn9QcUrrr0VV2d9gJH/8Er4IlDgho2y/EUBN62vL61dIuE+o2rPvEWT8
	 yLdW+U7dlsbn/OONvOp4E+FHt9c8w2HpInocxfkrF/LyFlxi5/tAEkMfidQcwdwqNMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=NR0yTnO8;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21E5606A31E;
	Mon, 23 Nov 2026 15:38:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B21E5606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=NR0yTnO8
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5017C176B;
	Mon, 23 Nov 2026 07:38:00 -0800 (PST)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C4F43F763;
	Mon, 23 Nov 2026 07:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795448283; bh=ZtZSCFfSS7AH1eoflbymwNl2l/6JZjRWRRcFOneOrtQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NR0yTnO8eL//qf8rHTLt5m/S5J1hkJUzo1muilLaNZrwO0c1pSt7D9cwwm9bCG3Zw
	 dxeucstnM+0H/F4tzbbBlYMXzGETjbM+Dd8y/v+KiUzCy6GO1YfI6fTbJhyUhaP/gx
	 PjEgbnLXZA2jNZiRzkOHlyEm203Of8VqEoZYwClw=
Date: Mon, 23 Nov 2026 15:37:58 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v1] arm64: Mitigate Spectre v1 in the BPF interpreter
Message-ID: <awRd1mHcQDVNi9U9@arm.com>
References: <20261117172341.3152407-1-ryan.roberts@arm.com>
 <DMYSI3BOQWOC.2P2FZB0H872DR@gmail.com>
 <awAay4FFj1_wQtaL@arm.com>
 <DN07ZMOAD4GP.37PG3XUPBG4CM@gmail.com>
 <a6cda8a2-992f-41f9-a814-ee78363c3a69@arm.com>
 <DN2ALO12MI1Z.3HI553HDMO2FL@gmail.com>
 <85385aae-af06-4742-a39b-5a95e3e73a7e@arm.com>
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
In-Reply-To: <85385aae-af06-4742-a39b-5a95e3e73a7e@arm.com>

On Mon, Nov 23, 2026 at 10:49:58AM +0000, Ryan Roberts wrote:
> On 23/11/2026 04:07, Alexei Starovoitov wrote:
> > On Sun, Nov 22, 2026 at 12:58 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
> >> I view this patch as a fix to arm64, not as a fix to BPF. I haven't changed any
> >> BPF code - I've only removed an out of date comment in BPF code, which assumed
> >> the code path was for Spectre v4 only. But that's not true since Commit
> >> dff883d9e93a ("bpf, arm64, powerpc: Change nospec to include v1 barrier").
> > 
> > Fair enough, but the arm64 part of that comment is stale.
> > The verifier relies on nospec for v1 since
> > commit d6f1c85f2253 ("bpf: Fall back to nospec for Spectre v1").
> > 
> >> arm64 was previously nop'ing barrier_nospec() despite seemingly needing it in
> >> the same situation as x86. I think this is orthogonal to whether or not the BPF
> >> interpreter permits speculation attacks in other places?
> > 
> > Not quite. In the interpreter the barrier sits behind an indirect branch:
> > 
> >   goto *jumptable[insn->code];
> > 
> > arm64 has no retpoline, and the prog can train this branch.
> > With a wrong target the CPU skips ST_NOSPEC and runs the next insn.
> > So the interpreter is still not safe.
> > Yet you're arguing that you're making bpf interpreter a viable option
> > on arm64. That's just not fair to users.

[...]

> > Say it in the commit log that you're fixing one tiny issue and leaving
> > giant security hole in place.
> > With that I'm no longer nacking it.
> 
> Happy to fix up the commit log as you suggest.

This patch closes the Spectre v1 hole in the interpreter but, as per
Alexei's point, we are still left open to Spectre v2, even with CSV2.
CSV2 only isolates branch prediction between contexts and here the
predictor could be trained from within the BPF program itself (in
theory, not sure if this has been demonstrated on arm64 though).
Training it this way is harder but I wonder whether it's worth patching
the kernel for v1 or just recommend that people disable unprivileged,
interpreted BPF (that's Arm's official recommendation anyway). Would we
give the wrong impression that such configuration is safe?

If Alexei makes the Kconfig change to force JIT always on, I'd be
inclined to drop this patch.

-- 
Catalin
