Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795337923;
	b=nIaGtUwB1iDA8htT8LEGxonkfzIN5CJdsFspVYoTRIwMudn5qkNDcYNUIUpf7MdnN0+b
	 xVRMdOGVJoe39kqWc6x2LhSu8vldV1iRiJNkQm7nioSaT18TN36TVx85eaHEM+8hpfwjG
	 371uLGJwe0bQkm0WTMWQIX2Resq2SC6WKyjFxwLf9+wytCiIbdWcRk82NDbxtMPzar3tD
	 ELVhI7WOjOemLrqCUxUJ8KcMYRH+skI1La8STx3FFY19jTLSYGqZadyYUoeBoXbM3M+Mc
	 zSbt+8qme8R5E8ZQv94XEyOyn+hit5hZGMbJzkL9Vi9Edqj52UdIn7GwOhq2PnupQPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795337923;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=gKa/gdamMUlaWDKNkrOUJ1SInjLPj8wlXGgQUUSMb74=;
	b=MVF6SuPGfoZKSoSDrFDpeFzZGn8H/ZjbWT5gju/M/IXjtCIBpaiSeKiqlynklu1m8och
	 f/YpZNVv/s8fiS/iD3YDMFyITyzVKiM+FPF/lxUaK1CNSIJpDnCQPobpMIFXoqka6pjJU
	 bbhe/JYP8VGc5VY2y7BrdvNmRCA9aN/k9JcrK0pnn6Zkee9A0K5sZdWP6v94IIX0V5OZS
	 31VH9dcTmqvhvRqd5MRYa66zkhMaMfIzG213bnGn668qA7tCxYlC2ibNEqmk+SiCvNwW2
	 rZzlBRXTTYf3EUHFrJRh7bwj+jEgDox741QFpUk8u/GV+hKbQ1iJh3znpDwZH+/sa0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=r65Rlnhf;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2867C606A320;
	Sun, 22 Nov 2026 08:58:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2867C606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=r65Rlnhf
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 627501575;
	Sun, 22 Nov 2026 00:58:38 -0800 (PST)
Received: from [10.57.93.187] (unknown [10.57.93.187])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1F0E63F882;
	Sun, 22 Nov 2026 00:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795337921; bh=bCKwLVxRq7BP98z/sJOreaPLixuU4Iox1OmuawUOOQI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=r65RlnhftwPn2uAKmfrTFqTgXtr7b9iN2qr1OKnyriE/PPtviiFEhdREmC8i4dQEo
	 UYLAxo66d4ZWduKiTokPXsHpW+LSygjPY8BvyL2aTCvnHz5sdH5TLfn2HNOeAt+7E8
	 rMdmMC8J3RQWw7PAzC0ZTevjIBGcgP6l8MilWQyU=
Message-ID: <a6cda8a2-992f-41f9-a814-ee78363c3a69@arm.com>
Date: Sun, 22 Nov 2026 08:58:37 +0000
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
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, stable@vger.kernel.org
References: <20261117172341.3152407-1-ryan.roberts@arm.com>
 <DMYSI3BOQWOC.2P2FZB0H872DR@gmail.com> <awAay4FFj1_wQtaL@arm.com>
 <DN07ZMOAD4GP.37PG3XUPBG4CM@gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
Content-Language: en-GB
In-Reply-To: <DN07ZMOAD4GP.37PG3XUPBG4CM@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/11/2026 17:38, Alexei Starovoitov wrote:
> On Fri Nov 20, 2026 at 10:02 AM UTC, Catalin Marinas wrote:
>> On Thu, Nov 19, 2026 at 01:18:03AM +0000, Alexei Starovoitov wrote:
>>> On Tue, Nov 17, 2026 at 09:23 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>> The arm64 JIT implements BPF_NOSPEC with a speculation barrier, but the
>>>> interpreter calls barrier_nospec(), which falls back to a no-op on
>>>> arm64. Programs executed by the interpreter therefore lack the
>>>> Spectre-v1 barriers assumed by the verifier. Contrary to the code
>>>> comment, kernel-wide SSBD does not provide this protection, since it
>>>> mitigates Spectre v4 rather than Spectre v1.
>>>
>>> Nack.
>>> In bpf-next arm64 has no interpreter when the JIT is built.
>>
>> And what about current mainline/stable or when one disables BPF_JIT
>> explicitly? Should we force BPF_JIT=y as well when ALWAYS_ON=y?
> 
> Anyone who didn't have BPF_JIT_ALWAYS_ON=y were exposed to speculation
> attacks forever. The security hole was wide open. We've been saying it
> forever. At the next merge window we will say
> "you cannot make wrong choice anymore".

I view this patch as a fix to arm64, not as a fix to BPF. I haven't changed any
BPF code - I've only removed an out of date comment in BPF code, which assumed
the code path was for Spectre v4 only. But that's not true since Commit
dff883d9e93a ("bpf, arm64, powerpc: Change nospec to include v1 barrier").

arm64 was previously nop'ing barrier_nospec() despite seemingly needing it in
the same situation as x86. I think this is orthogonal to whether or not the BPF
interpreter permits speculation attacks in other places?

Looking at bpf-next, it is still possible to deselect BPF_JIT when building. If
this is such a security issue, shouldn't we disallow that on arm64, or at the
every least make it an EXPERT option?

Thanks,
Ryan

