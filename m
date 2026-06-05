Received: from mail-43101.protonmail.ch (mail-43101.protonmail.ch [185.70.43.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6768230EF9B
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 18:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780684888; cv=none; b=Lz+8F2Hg9K/hojovENTQietWKBNwATmUXDdojzyK/3URZkThKt52ikOIBa2GzaTDnYUcC5/H2YgiAeixDEhUNVWAj8EvX6aZtvEYL/WB8UorMnDG2O9+9v8SszRXsphsxpuKa9N3uy9qRuDBOx48KmYAfiRjnElxjjLL3jV/7AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780684888; c=relaxed/simple;
	bh=B4/+h0RYM3rnu+siDFiUHr8KDNf1DM/W4pvh+IWmaKc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kgR6GjN6m93XCYnC11BsfY3i1qjumJlV120VBIq741tr+Tq5gdcbELFbz3tAPnpGasbBNfE+wCyU4va5fwcW+0lLLy6XL1c0nr6bQQmHcpCARFdiEnLDJZZo1anEnEKcOAo4OEto/EC7VQUmvPZHSAfPplsod5q5GPJv+H56X44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=EgyKjAM4; arc=none smtp.client-ip=185.70.43.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="EgyKjAM4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1780684879; x=1780944079;
	bh=ULsQGivnYjlrEHvWGTExhk3oogWnRMwN7zkQhjbL9xQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=EgyKjAM4yV9ASOCijoTkaOjaGPoEAMxE1JcnLR/mT2KLr13GGdBltANXsStTZMmJE
	 Jt/uRpB8T03wGKX1CJ2zo/ZNFSwRap3VgQFBeVRDh0n/pYbaCtP0c6tcz++wvERsIq
	 N0b9/keQD06DFInmjN65IeAxXSv3n2DrsqiUYijo+fKjhVBnxM4Gl0iAsMVywmvwqF
	 7Q1wXiXpEBgu7GdZCt4K/sHOo/wmE4ECCkBpdDekZLhYwBLcIZU9flx1/9ZIDOSGff
	 beUpCW+iXKeo1m+efm7VAlXqj//XscNXA0FbydS6wlHIRs2Brq+v3vmniIenG3zu6m
	 lfT5Ahe/sGeig==
Date: Fri, 05 Jun 2026 18:41:16 +0000
To: "Chen, Xiaogang" <Xiaogang.Chen@amd.com>, "regressions@lists.linux.dev" <regressions@lists.linux.dev>
From: Gerhard Schwanzer <geschw@pm.me>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Yang, Philip" <Philip.Yang@amd.com>
Subject: Re: [REGRESSION] drm/amdkfd: SVM split-tail remap regression causes SDMA0 permission fault on RX 7600 XT
Message-ID: <d30aa220-802d-4575-8ab0-058698e4ffbb@pm.me>
In-Reply-To: <IA1PR12MB85172F7FE9157C092EDA46A0E3112@IA1PR12MB8517.namprd12.prod.outlook.com>
References: <2bfa2f1b-567a-429b-aee2-a8dcf7efd5aa@pm.me> <53c2ad43-091d-46e9-b825-9aaa1d7114e8@amd.com> <2145b14f-00e7-4565-b1da-9e08d2c89a49@pm.me> <d39183d3-b961-4c74-997f-885eb7a887e4@amd.com> <IA1PR12MB85172F7FE9157C092EDA46A0E3112@IA1PR12MB8517.namprd12.prod.outlook.com>
Feedback-ID: 110185885:user:proton
X-Pm-Message-ID: 86c139f74aae1853942fd3d6244241363100637c
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Xiaogang, Thanks. I tested your attached patch on my RX 7600 XT=20
system. Test setup:
-
kernel 7.0.11 with 448ee453/bf2084a7 active
-
local revert not applied
-
your attached candidate fix applied
-
same self-contained v2 reproducer source as before, unchanged sha256:=20
33347b5a1915f7452417f776c85527e55f825078c146163470bfe3eacabe3b27=20
Command: ./kfd_svm_split_hsa_copy --upstream-ab Result:
-
10/10 runs completed successfully
-
all HSA/SDMA D2H copies completed
-
no ROCr memory access fault
-
no new GCVM_L2_PROTECTION_FAULT_STATUS
-
no SDMA0 permission fault
-
no GPU page fault in the kernel log So your patch fixes the reproducer=20
on my system with the original reproducer unchanged. Please feel free to=20
add: Tested-by: Gerhard Schwanzer
geschw@pm.me
Thanks, Gerhard


On 05/06/26 at 19:59, Chen, Xiaogang wrote:
>
> AMD General
>
>
> Hi Gerhard:
>
> I think the cause is checking the last byte address of svm range for=20
> 2MB alignment when decide possible huge page mapping. Your test case=20
> has vm range that ends just one byte before alignment.
>
> I tested your app with the attachment, no page fault during sdma=20
> operation. Please verify it.
>
> Thanks
>
> Xiaogang
>
> *From:*Chen, Xiaogang
> *Sent:* Wednesday, June 3, 2026 5:51 PM
> *To:* Gerhard Schwanzer <geschw@pm.me>; regressions@lists.linux.dev
> *Cc:* amd-gfx@lists.freedesktop.org; stable@vger.kernel.org; Deucher,=20
> Alexander <Alexander.Deucher@amd.com>; Yang, Philip <Philip.Yang@amd.com>
> *Subject:* Re: [REGRESSION] drm/amdkfd: SVM split-tail remap=20
> regression causes SDMA0 permission fault on RX 7600 XT
>
> Hi=C2=A0Gerhard:
>
> Thanks. I can build the app now. And I saw the regression. I am=20
> triaging it.
>
> The purpose of this patch is to remap split svm ranges(head/tail) that=20
> were mapped with huge page mapping(pmd), but cannot be mapped in huge=20
> page mapping after split due to new svm ranges are not 2MB aligned. It=20
> seems the remap decision misses case that both head and tail ranges=20
> are from original range with huge page mappings were used. Will check....
>
> Regards
>
> Xiaogang
>
> On 6/3/2026 12:54 AM, Gerhard Schwanzer wrote:
>
>     [Some people who received this message don't often get email fromgesc=
hw@pm.me. Learn why this is important athttps://aka.ms/LearnAboutSenderIden=
tification ]
>
>     Hi Xiaogang,
>
>     Sorry, you are right. The source I uploaded was not self-contained, i=
t still
>
>     referenced trace_history_replay.inc from an older local replay mode.
>
>     I uploaded a self-contained v2 source to the GitLab report:
>
>     https://gitlab.freedesktop.org/-/project/4522/uploads/7395b8985ecd7c5=
4183a7615d479c02c/kfd_svm_split_hsa_copy-v2.c
>
>     The --upstream-ab path does not use that replay table, but the missin=
g
>
>     include
>
>     obviously broke fresh builds. The v2 source embeds the table and othe=
rwise
>
>     preserves the same source.
>
>     I re-tested this v2 source before uploading:
>
>      =C2=A0=C2=A0 - clean build from only kfd_svm_split_hsa_copy-v2.c: OK
>
>      =C2=A0=C2=A0 - ./kfd_svm_split_hsa_copy --help: OK
>
>      =C2=A0=C2=A0 - good/workaround kernel: --upstream-ab completed 10/10=
 runs, no new
>
>      =C2=A0=C2=A0=C2=A0=C2=A0 GCVM/SDMA0/protection-fault messages in the=
 test window
>
>      =C2=A0=C2=A0 - broken kernel: --upstream-ab reproduced the SDMA0 per=
mission fault;
>
>      =C2=A0=C2=A0=C2=A0=C2=A0 the first kernel fault address matched the =
planned split-tail page
>
>     Validation summaries:
>
>     https://gitlab.freedesktop.org/-/project/4522/uploads/e6d0f31c0fda0df=
2c999439411f29dca/good-kernel-validation-summary.md
>
>     https://gitlab.freedesktop.org/-/project/4522/uploads/bdf8a3ac6786ddb=
88dd426b59edb32a9/broken-kernel-validation-summary.md
>
>     The intended triage command remains:
>
>      =C2=A0=C2=A0 ./kfd_svm_split_hsa_copy --upstream-ab
>
>     Generic build shape is:
>
>      =C2=A0=C2=A0 cc -O2 -g -Wall -Wextra -pthread \
>
>      =C2=A0=C2=A0=C2=A0=C2=A0 -I/path/to/rocm/include -L/path/to/rocm/lib=
 \
>
>      =C2=A0=C2=A0=C2=A0=C2=A0 -o kfd_svm_split_hsa_copy kfd_svm_split_hsa=
_copy-v2.c \
>
>      =C2=A0=C2=A0=C2=A0=C2=A0 -lhsa-runtime64
>
>     If you still prefer a binary, please tell me the target runtime/distr=
o. A
>
>     binary built on my NixOS system is Nix-store linked and likely not
>
>     portable to
>
>     your test system.
>
>     One more thing that would help me test any replacement fix: do you kn=
ow what
>
>     specific failure or workload 448ee453 was intended to fix? I would li=
ke to
>
>     avoid validating only the revert side while accidentally losing the o=
riginal
>
>     fix.
>
>     Thanks for catching this, and thanks for taking a look.
>
>     Regards,
>
>     Gerhard
>
>     On 06/03/2026 Chen, Xiaogang wrote:
>
>         I cannot compile kfd_svm_split_hsa_copy.c, there is no
>
>         "trace_history_replay.inc".
>
>         Or can you=C2=A0 send the test binary?=C2=A0 That should be enoug=
h to triage the
>
>         issue since it is a regression as you mentioned.
>
>         Regards
>
>         Xiaogang
>
>         On 6/2/2026 5:04 AM, Gerhard Schwanzer wrote:
>
>             Hi,
>
>             I would like to make sure this AMDKFD SVM regression is track=
ed by the
>
>             Linux regression process.
>
>             GitLab report:
>
>                 https://gitlab.freedesktop.org/drm/amd/-/work_items/4914
>
>             The regression was originally reported on 2026-01-27. It was =
bisected
>
>             to the
>
>             same functional change that Alex Deucher's revert patch later=
 targeted:
>
>              =C2=A0=C2=A0 448ee45353ef9fb1a34f5f26eb3f48923c6f0898
>
>              =C2=A0=C2=A0 drm/amdkfd: Use huge page size to check split s=
vm range alignment
>
>             The affected kernel line I tested identifies the same change =
as:
>
>              =C2=A0=C2=A0 bf2084a7b1d75d093b6a79df4c10142d49fbaa0e
>
>             Alex's revert patch:
>
>             https://lists.freedesktop.org/archives/amd-gfx/2026-February/=
138824.html
>
>             A small C/HSA reproducer is now available in the GitLab repor=
t. It
>
>             does not
>
>             require PyTorch, ComfyUI, Docker, model files, or the origina=
l
>
>             workload. It
>
>             uses ROCr/HSA, an anonymous THP-advised host mapping, explici=
t KFD SVM
>
>             SET_ATTR ioctls, and an HSA SDMA D2H copy.
>
>             Single reproducer command, same binary on both kernels:
>
>              =C2=A0=C2=A0 ./kfd_svm_split_hsa_copy --upstream-ab
>
>             Same-machine A/B result on an RX 7600 XT:
>
>              =C2=A0=C2=A0 448ee453/bf2084a7 active:
>
>              =C2=A0=C2=A0=C2=A0=C2=A0 1/1 run faults with SDMA0 permissio=
n fault
>
>              =C2=A0=C2=A0=C2=A0=C2=A0 GCVM_L2_PROTECTION_FAULT_STATUS=3D0=
x00841A51
>
>              =C2=A0=C2=A0 448ee453/bf2084a7 locally reverted:
>
>              =C2=A0=C2=A0=C2=A0=C2=A0 10/10 runs complete
>
>              =C2=A0=C2=A0=C2=A0=C2=A0 no ROCr memory access fault
>
>              =C2=A0=C2=A0=C2=A0=C2=A0 no new GCVM/SDMA0 permission fault =
in dmesg
>
>             The bad fault page is inside the split tail and inside the SD=
MA copy
>
>             range:
>
>              =C2=A0=C2=A0 critical tail: [0x722429d61..0x722429dff]
>
>              =C2=A0=C2=A0 copy pages:=C2=A0=C2=A0=C2=A0 [0x722429b30..0x7=
22429d70]
>
>              =C2=A0=C2=A0 fault page:=C2=A0=C2=A0=C2=A0 0x722429d65
>
>             A full ftrace/PTE run with the same C reproducer/SVM sequence=
 also shows:
>
>              =C2=A0=C2=A0 split_tail ... current_remap=3D0 old_remap=3D1 =
missed=3D1
>
>              =C2=A0=C2=A0 MISSED_REMAP_CANDIDATE split=3Dtail
>
>              =C2=A0=C2=A0 no amdgpu_vm_update_ptes covering the fault pag=
e after the marker
>
>             before
>
>              =C2=A0=C2=A0 the fault-side GET_ATTR
>
>             The suspected code issue is that the split-tail/head remap pr=
edicate
>
>             introduced
>
>             by 448ee453/bf2084a7 can miss tails inside the final 512-page=
 block.
>
>             Since
>
>             prange->last is inclusive, ALIGN_DOWN(prange->last, 512) is t=
he start
>
>             of the
>
>             final block, not an exclusive upper bound.
>
>             I also sent a short follow-up to amd-gfx with the reproducer/=
A-B
>
>             summary and
>
>             asked what original failure or workload 448ee453/bf2084a7 was=
 intended
>
>             to fix:
>
>             https://lists.freedesktop.org/archives/amd-gfx/2026-June/1458=
00.html
>
>             I can resend the reproducer source and summaries directly on-=
list if
>
>             preferred.
>
>             #regzbot introduced: 448ee45353ef9fb1a34f5f26eb3f48923c6f0898
>
>             #regzbot monitor:
>
>             https://gitlab.freedesktop.org/drm/amd/-/work_items/4914
>
>             Thanks,
>
>             Gerhard Schwanzer
>

