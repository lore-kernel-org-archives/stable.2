Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6884D3B8BCC;
	Mon, 31 Aug 2026 08:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788163954; cv=none; b=dZyD46XnPc+QO2CYsvBOPs2fVQd0iLmkFr0a9LGA7Uz5QKxvZ/a+URR0gxNNac+fJktj769y14y6anKOVZ9MajTmPqqaSkVJ9Cdd62MMKNmRVZQOSIoeOMg5FOSan93BIXKV/O1hjmEQ45n5DN8CtK/nzU0kLwGR+BOPcEmwIKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788163954; c=relaxed/simple;
	bh=iVvga9PCAwNzsRXGVVTeediyje6tcoGUVeU+6BWh8/g=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=BKnzAwpHCdmJFmWhQNyO+iHEd7OCQzE+j7uMBgMR0DSoVm1BliS3ucwuKv/iMiLM3hUkOacrw1qH3FnGN4h2AZBV0aQ4XO2MgZOK283/XLr0eSHlECYxKnWy2FwFvl6FnbAYfgg0jkgFnV3d/5vRhDM2G7FJs0UyC5/6NpdBSBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jrv0Bna/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jrv0Bna/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4122F1F000E9;
	Mon, 31 Aug 2026 08:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788163953;
	bh=dCW1uDpTCPb3PKxcuIP9dHEaxG/ORyGwzRGm/N4s7HY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Jrv0Bna/xyjZZBhuUxtTbI1EvY5Hir50ZAzftdhurTEoTwbfPd4Cq80m3Tdh42iEG
	 zpXbO3HPs8ZEoJq4rOk8Tb2zB4eRC+d+pnH9QdOBLVRV/vbmM/GuY6VsnW5x7PBrVn
	 GkJwO9CR4kPSxrd0EJrjad+994YFqjAnsil6fbE1OsenBayNd/pwJ5dEX5h0iPkXdq
	 mLPccO2oEsmJW9AMLpWwLaq1qXPAiN75pfesSe7lGFWCKJFqI3TF8/O1myt2XHQ8Pc
	 L8rhACd/YbVjutQ7m6vYcszxg8EKF1Y10TSROdOFQwf6HYYq3tRKspiQiM/BBMK3RP
	 kjNF2s+o06LXQ==
Content-Type: multipart/mixed; boundary="===============5021915201797315316=="
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <64781ad3c02ca742220618dd46b27654a7dc71a4fe998ef7c20f50efbf355583@mail.kernel.org>
In-Reply-To: <6034e8b7dc0c6954be35b6735a9b04b35903ed5f.1788154635.git.skb99@linux.ibm.com>
References: <6034e8b7dc0c6954be35b6735a9b04b35903ed5f.1788154635.git.skb99@linux.ibm.com>
Subject: Re: [PATCH v13 6/8] selftests/bpf: Fix powerpc JIT disassembly failure
From: bot+bpf-ci@kernel.org
To: skb99@linux.ibm.com,bpf@vger.kernel.org,linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com,maddy@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,shuah@kernel.org,linux-kselftest@vger.kernel.org,stable@vger.kernel.org,venkat88@linux.ibm.com,yeswanth@linux.ibm.com,skb99@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 31 Aug 2026 08:12:32 +0000 (UTC)

--===============5021915201797315316==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Fix powerpc JIT disassembly failure
>
> Ensure that the trampoline stubs JITed at the tail of the
> epilogue do not expose the dummy trampoline address stored
> in the last 8 bytes(64-bit) and last 4 bytes(32-bit)
> to the disassembly flow. Prevent the disassembler from
> ingesting this memory address, as it may occasionally decode
> into a seemingly valid but incorrect instruction. Fix this
> issue by truncating the last 8/4 bytes from JITed buffers
> before supplying them for disassembly.

Does the changelog accurately describe when this fix takes effect?

Looking at this commit, get_jited_program_text() is only called from
run_subtest() in tools/testing/selftests/bpf/test_loader.c when
subspec->jited.cnt != 0. The __jited expectations are only recorded
when the preceding __arch_* tag matches the running architecture:

    } else if ((val = str_has_pfx(s, "test_arch="))) {
            ...
            collect_jit = get_current_arch() == arch;

Since get_current_arch() in this tree has no powerpc case, it returns
ARCH_UNKNOWN, no __arch_* tag ever matches on powerpc, jited.cnt stays
0, and get_jited_program_text() is never invoked on powerpc.

The path only becomes reachable with the later patches in the same
series, 422d7386c6a2b (which adds ARCH_POWERPC64 / __arch_powerpc64) and
b787dda9a979d (which adds tailcall verifier selftest). Would it be more
accurate to describe this as a prerequisite for that enablement rather
than as a fix for a current failure?

Also, the changelog says the address "may occasionally decode into a
seemingly valid but incorrect instruction", whereas the comment added by
this same hunk says the bytes "can't disassemble to a valid
instruction", and the companion patch 0cd8bd7da278d quotes the concrete
symptom:

    Can't disasm instruction at offset 104: c0 34 1d 00 00 00 00 c0

A hard "Can't disasm" abort (what disasm_insn() reports via PRINT_FAIL)
is a different problem from a mis-decode into a plausible-looking
instruction. Could the commit message be more precise about which
failure mode actually occurs?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33368376983
--===============5021915201797315316==--
