Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944B22C027C;
	Tue, 16 Jun 2026 13:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781618133; cv=none; b=M+9ugoDzAvSd4GCY/DsrzfccD5Q/mOke3BK4BQTZ+uxdduRiLa0vo5Wrr2SBSlNFlOZPV653a7iOglhqKGeDcgSTUp1W7WQXTRcznAuAcKz2b4PpHbA2vVzzwpc+9eA42Ijctp1WUQ5wUznZr0FYXED5+b949BmP5WuIsKklhCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781618133; c=relaxed/simple;
	bh=fWTalgpgoASiLbU9RoomE3EWp3JbfMW9YsH2bLga1Yk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=eHOdvFLEwdAPSl/GGdGS3amH/SAvp0/7vjch4FcCTcQLyjBa4nv4e+kl2nU5v+7JYczt4zgsF1tpoBuo9+qsJcv5TBrzVZKsVWuPaCO8imkCn+n4h9+gn9PeODJ2EcmPuIdOfZR58go1WmCzQqM5GmczV8psUfSVKg6j4Tr5nbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n0N/mgrc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0N/mgrc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C6941F000E9;
	Tue, 16 Jun 2026 13:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781618132;
	bh=9FZF+OBjyzpGj+hdKvuHfcoi32RqLii3MBniBKQPKKA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=n0N/mgrc1nl08aCs0wGBfW/iYLg6F85xZY1u3eykhGHPr+KaJulr0Cdosq2jQ10uE
	 36BJpjIc/vzwTTEdPSEpl4fjpnN/0qXcWT6F9N2KZKqQ7dbolhyvCja+SZYaQQfLZ0
	 9FvtsLk4H16AyzAg4HB/tYnN1kUt1I+4A2xdSnfj6LTuJLF0MCthM00GkBkp2uRwsm
	 dSzfgFFdNs8Vqw8FLlk0dmhCAmCW+RdbBikcMUGqgpKighT8f7UqzB2TeuxISaI1bt
	 lHtgulvNwmukuQ8iVzXn8gd6z0+HQfvyscDnZ3UT7YUmVm66Z9Ie9JSzCSJCMXtNnD
	 pUKgZ7T9QJj9w==
Content-Type: multipart/mixed; boundary="===============8096130991037514973=="
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <dddff13192a99e8ccc1a3453daf7c5a28e656622d5a013dc51769471c430b2fe@mail.kernel.org>
In-Reply-To: <20260616164741.32252-4-adubey@linux.ibm.com>
References: <20260616164741.32252-4-adubey@linux.ibm.com>
Subject: Re: [bpf v8 3/7] selftest/bpf: Fixing powerpc JIT disassembly failure
From: bot+bpf-ci@kernel.org
To: adubey@linux.ibm.com,bpf@vger.kernel.org
Cc: hbathini@linux.ibm.com,linuxppc-dev@lists.ozlabs.org,maddy@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,shuah@kernel.org,linux-kselftest@vger.kernel.org,stable@vger.kernel.org,adubey@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 16 Jun 2026 13:55:31 +0000 (UTC)

--===============8096130991037514973==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>     selftest/bpf: Fixing powerpc JIT disassembly failure
>
>     Ensure that the trampoline stubs JITed at the tail of the
>     epilogue do not expose the dummy trampoline address stored
>     in the last 8 bytes(64-bit) and last 4 bytes(32-bit)
>     to the disassembly flow. Prevent the disassembler from
>     ingesting this memory address, as it may occasionally decode
>     into a seemingly valid but incorrect instruction. Fix this
>     issue by truncating the last 8/4 bytes from JITed buffers
>     before supplying them for disassembly.
>
>     Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>

This looks like a bug fix, but there's no Fixes: tag.  The code being
corrected is the disasm_one_func(text_out, image + pc, func_lens[i]) call
in get_jited_program_text(), which feeds the full JITed function length
(including the trampoline tail holding the dummy trampoline address) to
the disassembler.  That helper and call site were added by commit
b991fc520700.

Should this include:

  Fixes: b991fc520700 ("selftests/bpf: utility function to get program disassembly after jit")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27620315552
--===============8096130991037514973==--
