Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795452501;
	b=qsSUr3Kbr5PyJwc7PvXh5nxuqqkfqk9BC81iI8dSMOH33zlOGDn/STR0j+DYABxm2vMD
	 2XHtNECztfHM3pJ8Pzd7ZE7sJb7vAsqDys0E41NHd6XCmeOrsVOUMo1Ha65dbkXTtsofn
	 yDsBPiYuo77JppILbi7yUMwKsYXkpgcym/HW2y1lHCSNI04t3yLE8uEOMUO3/NPTzPE+B
	 54/1MYWe0hlLuCRI0fXeVqa3XKrWhpllAsS7wDcGUMBozb70Rnz09/xnoa7cXEem8jq1H
	 Duc/nQajx7cuBbydBcjXjjK6b837EGgYJt6B2TC7zXE9OkwR37gc07yzH2o9r0pM6lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795452501;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=pCYboGv9stOVE3+lbJeSKa31s5n4S6clOgc0Cw8ID4Q=;
	b=W13PD4KOI6Rtg4rkfDVunXi1uPu+i1hpYCHYUBuYQGMSq0cHysRD8P6iELUzjzCLiJBo
	 0Z556sS6fIF7jvQB4ryOFDDhClNTt1NNttmNUeuI/n0vUHRGQgqhwnsNmyNHpnp34BjVP
	 sFlDCMT/kJk/5eZrpP6SzQeRBjPVT6R5rxUIa9t6Jj1KYCy0edfX3LzBGPrX9jWjsRTfr
	 u/alEMxZPWUZHCYge8vln6YMqqM0k5aCPF+upVlc/3aMh+HyY2v4FeJL3YolVx2VgTe7R
	 svJN3AEGv/lJMH8yN8MzvzwNBEhOgr2esQ9R8Vf+gm92YjM40HtTQl+BwD64JNbDb5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Cli0A10U;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4AA606A33F;
	Mon, 23 Nov 2026 16:48:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A4AA606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Cli0A10U
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81767143D;
	Mon, 23 Nov 2026 08:48:15 -0800 (PST)
Received: from [10.57.91.245] (unknown [10.57.91.245])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A4433F632;
	Mon, 23 Nov 2026 08:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795452498; bh=SktO3foME/slcuizGcNzpJUNhSlVgGucNlMrZ+GAfqA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Cli0A10UXCHGn9oip1xle9GsZggWjVZ/7xp4pPLV3dKaWjcpw5tD3sKkM0RfimPvo
	 DoQ9GuYAQErIcn+xAhT070EYL4vay/KXjubGseA00PagBz2irMCcJMPibpypCvl73R
	 gtX691WDQmMHSD1Xk2u7YsDZAzwNSgpXxvoyz3CE=
Message-ID: <0fad3d48-54cc-4919-bff9-254347c933c4@arm.com>
Date: Mon, 23 Nov 2026 16:48:14 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm64: Mitigate Spectre v1 in the BPF interpreter
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, stable@vger.kernel.org
References: <20261117172341.3152407-1-ryan.roberts@arm.com>
 <DMYSI3BOQWOC.2P2FZB0H872DR@gmail.com> <awAay4FFj1_wQtaL@arm.com>
 <DN07ZMOAD4GP.37PG3XUPBG4CM@gmail.com>
 <a6cda8a2-992f-41f9-a814-ee78363c3a69@arm.com>
 <DN2ALO12MI1Z.3HI553HDMO2FL@gmail.com>
 <85385aae-af06-4742-a39b-5a95e3e73a7e@arm.com> <awRd1mHcQDVNi9U9@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
Content-Language: en-GB
In-Reply-To: <awRd1mHcQDVNi9U9@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/11/2026 15:37, Catalin Marinas wrote:
> On Mon, Nov 23, 2026 at 10:49:58AM +0000, Ryan Roberts wrote:
>> On 23/11/2026 04:07, Alexei Starovoitov wrote:
>>> On Sun, Nov 22, 2026 at 12:58 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>> I view this patch as a fix to arm64, not as a fix to BPF. I haven't changed any
>>>> BPF code - I've only removed an out of date comment in BPF code, which assumed
>>>> the code path was for Spectre v4 only. But that's not true since Commit
>>>> dff883d9e93a ("bpf, arm64, powerpc: Change nospec to include v1 barrier").
>>>
>>> Fair enough, but the arm64 part of that comment is stale.
>>> The verifier relies on nospec for v1 since
>>> commit d6f1c85f2253 ("bpf: Fall back to nospec for Spectre v1").
>>>
>>>> arm64 was previously nop'ing barrier_nospec() despite seemingly needing it in
>>>> the same situation as x86. I think this is orthogonal to whether or not the BPF
>>>> interpreter permits speculation attacks in other places?
>>>
>>> Not quite. In the interpreter the barrier sits behind an indirect branch:
>>>
>>>   goto *jumptable[insn->code];
>>>
>>> arm64 has no retpoline, and the prog can train this branch.
>>> With a wrong target the CPU skips ST_NOSPEC and runs the next insn.
>>> So the interpreter is still not safe.
>>> Yet you're arguing that you're making bpf interpreter a viable option
>>> on arm64. That's just not fair to users.
> 
> [...]
> 
>>> Say it in the commit log that you're fixing one tiny issue and leaving
>>> giant security hole in place.
>>> With that I'm no longer nacking it.
>>
>> Happy to fix up the commit log as you suggest.
> 
> This patch closes the Spectre v1 hole in the interpreter but, as per
> Alexei's point, we are still left open to Spectre v2, even with CSV2.
> CSV2 only isolates branch prediction between contexts and here the
> predictor could be trained from within the BPF program itself (in
> theory, not sure if this has been demonstrated on arm64 though).
> Training it this way is harder but I wonder whether it's worth patching
> the kernel for v1 or just recommend that people disable unprivileged,
> interpreted BPF (that's Arm's official recommendation anyway). Would we
> give the wrong impression that such configuration is safe?
> 
> If Alexei makes the Kconfig change to force JIT always on, I'd be
> inclined to drop this patch.

Works for me.
