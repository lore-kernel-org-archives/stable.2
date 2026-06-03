Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch [79.135.106.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944393DBD7E
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 05:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780466102; cv=none; b=cBQLtAq6yzI6g9W6MOv5GHUBjWpJ6me1W12P3KyVsqsbqFyLLAR/3iGVzAfNZuNlI011nC17uE3AX/QMzcRF0Z4VyuKQgqRqifoDrw6Bih5D2CQwraRyaOs66aRzTpM1JFamlsc2psp5kAPLgvc5tLu+TYt+poAaIsjUvjWo6JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780466102; c=relaxed/simple;
	bh=CWB80huWMPBvCAA6oS3ZrBWMY1RZz1ZR0+OGR4HyqI8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uhy5+oP0TqbTdZ7Xc+Xq8xXVnac/7YZYY/hjn6uDn41FdciP8nvimIpJ8oe0KuV9ZK6zbF4T951Ynwx+U7bHxsF0CQg2bhFN10mHVL3b3p1Wh0PLxs/lZKx0WomzQt3Owi/cp8MLAAj8qYRyCTdfAcmmZACj/Q0ML5GVYhqeU1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=QKj1fGz1; arc=none smtp.client-ip=79.135.106.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="QKj1fGz1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1780466092; x=1780725292;
	bh=42GDx+EcOLAVCCoS9tmCFsH8/PBiWa8gmqrFleBsEVw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=QKj1fGz1puRCyp/3DX5HtlQxnL1vaYAapigHAdWDeRkqSSh47vd3TdbUAZW5QAH1F
	 l49COOfXjsH1aLn58t2W8HawjPV1AhhIHsqEGLrt7tJc1u/Uyr10tahS2snhFF9i1m
	 mq5wzV2onq9v7Zc9t9P6MUCVa+X6jOxRZfX+9C+rdvFr3Bx/hVdYP0PqpVPL35Cdb6
	 ctSESCxyL9CtmC3ARnpk7uK8cU/TC1Ia1vLsO/wJTNum58pJCxpzK0GhWzlgpIGFBA
	 u+fGZJF92OsYhEmkaCnqie9GEPEIkub3n3ZoeB5ooKEPOlaSzxFGiSWxzXswmHGFCH
	 JD9jKn3kt50wQ==
Date: Wed, 03 Jun 2026 05:54:47 +0000
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>, regressions@lists.linux.dev
From: Gerhard Schwanzer <geschw@pm.me>
Cc: amd-gfx@lists.freedesktop.org, stable@vger.kernel.org, alexander.deucher@amd.com, Philip.Yang@amd.com
Subject: Re: [REGRESSION] drm/amdkfd: SVM split-tail remap regression causes SDMA0 permission fault on RX 7600 XT
Message-ID: <2145b14f-00e7-4565-b1da-9e08d2c89a49@pm.me>
In-Reply-To: <53c2ad43-091d-46e9-b825-9aaa1d7114e8@amd.com>
References: <2bfa2f1b-567a-429b-aee2-a8dcf7efd5aa@pm.me> <53c2ad43-091d-46e9-b825-9aaa1d7114e8@amd.com>
Feedback-ID: 110185885:user:proton
X-Pm-Message-ID: 0adb7ef1f3a71170ad3d50b79d44d548ca87f578
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Xiaogang,

Sorry, you are right. The source I uploaded was not self-contained, it stil=
l
referenced trace_history_replay.inc from an older local replay mode.

I uploaded a self-contained v2 source to the GitLab report:

https://gitlab.freedesktop.org/-/project/4522/uploads/7395b8985ecd7c54183a7=
615d479c02c/kfd_svm_split_hsa_copy-v2.c

The --upstream-ab path does not use that replay table, but the missing=20
include
obviously broke fresh builds. The v2 source embeds the table and otherwise
preserves the same source.

I re-tested this v2 source before uploading:

 =C2=A0 - clean build from only kfd_svm_split_hsa_copy-v2.c: OK
 =C2=A0 - ./kfd_svm_split_hsa_copy --help: OK
 =C2=A0 - good/workaround kernel: --upstream-ab completed 10/10 runs, no ne=
w
 =C2=A0 =C2=A0 GCVM/SDMA0/protection-fault messages in the test window
 =C2=A0 - broken kernel: --upstream-ab reproduced the SDMA0 permission faul=
t;
 =C2=A0 =C2=A0 the first kernel fault address matched the planned split-tai=
l page

Validation summaries:

https://gitlab.freedesktop.org/-/project/4522/uploads/e6d0f31c0fda0df2c9994=
39411f29dca/good-kernel-validation-summary.md
https://gitlab.freedesktop.org/-/project/4522/uploads/bdf8a3ac6786ddb88dd42=
6b59edb32a9/broken-kernel-validation-summary.md

The intended triage command remains:

 =C2=A0 ./kfd_svm_split_hsa_copy --upstream-ab

Generic build shape is:

 =C2=A0 cc -O2 -g -Wall -Wextra -pthread \
 =C2=A0 =C2=A0 -I/path/to/rocm/include -L/path/to/rocm/lib \
 =C2=A0 =C2=A0 -o kfd_svm_split_hsa_copy kfd_svm_split_hsa_copy-v2.c \
 =C2=A0 =C2=A0 -lhsa-runtime64

If you still prefer a binary, please tell me the target runtime/distro. A
binary built on my NixOS system is Nix-store linked and likely not=20
portable to
your test system.

One more thing that would help me test any replacement fix: do you know wha=
t
specific failure or workload 448ee453 was intended to fix? I would like to
avoid validating only the revert side while accidentally losing the origina=
l
fix.

Thanks for catching this, and thanks for taking a look.

Regards,
Gerhard


On 06/03/2026 Chen, Xiaogang wrote:

> I cannot compile kfd_svm_split_hsa_copy.c, there is no
> "trace_history_replay.inc".
>
> Or can you=C2=A0 send the test binary?=C2=A0 That should be enough to tri=
age the
> issue since it is a regression as you mentioned.
>
> Regards
>
> Xiaogang
>
> On 6/2/2026 5:04 AM, Gerhard Schwanzer wrote:
>> Hi,
>>
>> I would like to make sure this AMDKFD SVM regression is tracked by the
>> Linux regression process.
>>
>> GitLab report:
>>
>>  =C2=A0 https://gitlab.freedesktop.org/drm/amd/-/work_items/4914
>>
>> The regression was originally reported on 2026-01-27. It was bisected
>> to the
>> same functional change that Alex Deucher's revert patch later targeted:
>>
>>  =C2=A0 448ee45353ef9fb1a34f5f26eb3f48923c6f0898
>>  =C2=A0 drm/amdkfd: Use huge page size to check split svm range alignmen=
t
>>
>> The affected kernel line I tested identifies the same change as:
>>
>>  =C2=A0 bf2084a7b1d75d093b6a79df4c10142d49fbaa0e
>>
>> Alex's revert patch:
>>
>> https://lists.freedesktop.org/archives/amd-gfx/2026-February/138824.html
>>
>> A small C/HSA reproducer is now available in the GitLab report. It
>> does not
>> require PyTorch, ComfyUI, Docker, model files, or the original
>> workload. It
>> uses ROCr/HSA, an anonymous THP-advised host mapping, explicit KFD SVM
>> SET_ATTR ioctls, and an HSA SDMA D2H copy.
>>
>> Single reproducer command, same binary on both kernels:
>>
>>  =C2=A0 ./kfd_svm_split_hsa_copy --upstream-ab
>>
>> Same-machine A/B result on an RX 7600 XT:
>>
>>  =C2=A0 448ee453/bf2084a7 active:
>>  =C2=A0 =C2=A0 1/1 run faults with SDMA0 permission fault
>>  =C2=A0 =C2=A0 GCVM_L2_PROTECTION_FAULT_STATUS=3D0x00841A51
>>
>>  =C2=A0 448ee453/bf2084a7 locally reverted:
>>  =C2=A0 =C2=A0 10/10 runs complete
>>  =C2=A0 =C2=A0 no ROCr memory access fault
>>  =C2=A0 =C2=A0 no new GCVM/SDMA0 permission fault in dmesg
>>
>> The bad fault page is inside the split tail and inside the SDMA copy
>> range:
>>
>>  =C2=A0 critical tail: [0x722429d61..0x722429dff]
>>  =C2=A0 copy pages:=C2=A0 =C2=A0 [0x722429b30..0x722429d70]
>>  =C2=A0 fault page:=C2=A0 =C2=A0 0x722429d65
>>
>> A full ftrace/PTE run with the same C reproducer/SVM sequence also shows=
:
>>
>>  =C2=A0 split_tail ... current_remap=3D0 old_remap=3D1 missed=3D1
>>  =C2=A0 MISSED_REMAP_CANDIDATE split=3Dtail
>>  =C2=A0 no amdgpu_vm_update_ptes covering the fault page after the marke=
r
>> before
>>  =C2=A0 the fault-side GET_ATTR
>>
>> The suspected code issue is that the split-tail/head remap predicate
>> introduced
>> by 448ee453/bf2084a7 can miss tails inside the final 512-page block.
>> Since
>> prange->last is inclusive, ALIGN_DOWN(prange->last, 512) is the start
>> of the
>> final block, not an exclusive upper bound.
>>
>> I also sent a short follow-up to amd-gfx with the reproducer/A-B
>> summary and
>> asked what original failure or workload 448ee453/bf2084a7 was intended
>> to fix:
>>
>> https://lists.freedesktop.org/archives/amd-gfx/2026-June/145800.html
>>
>> I can resend the reproducer source and summaries directly on-list if
>> preferred.
>>
>> #regzbot introduced: 448ee45353ef9fb1a34f5f26eb3f48923c6f0898
>> #regzbot monitor:
>> https://gitlab.freedesktop.org/drm/amd/-/work_items/4914
>>
>> Thanks,
>> Gerhard Schwanzer

