Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B670A3859F3
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 19:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781552440; cv=none; b=NVsoiw/QIvPV1niAmo7IVTep5iqZmw5Zxh6LtgtUqUKFAt+G4PcFRytzqOEI3ndUJB6TKnYtJ+MQrhMZZRT1WDNW/amiRmqmBQBjgjwTOtoX05AiVfivJJ+N5S/iNFqQ0vEKjDtxyyY7gZPmg7uLuUDm/b4U5ijm1KGLznaFEpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781552440; c=relaxed/simple;
	bh=XbX98VF243K959kI6PqKJek+IfDNsD+hvt3VGbGUvug=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hfGA0dS/WvibgaL8v0WsJLvb6+Pm39R/mN0vXhC+06VDq44JqCCAUsECsZGx+lsvFx3JjC2IWfNsWNQJgwd34yoewAUv7AKAlrn8m35mwQb8S9N+QDWXXjcKsuWW6o2D5KtPF94BhrlISHpzDXkEF/2In6tvRxanaUEZezExLgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=aia2AVyp; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="aia2AVyp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1781552435; x=1781811635;
	bh=iKLpruD2vYR217WSTMGZepHjfmy50IW25hwqxjF1ZAA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=aia2AVypiaGJkC7QquhaOhvMWalzj8VIJ9WzW42kJZzLIkQ54gkpVVXLqHuiQiErn
	 TdxotGRumn1ychbF+Z/pzokQRxZuWiTxaQTvllaFUfEWFhuYFXB0jqHM3ck68OY8fv
	 eZNTyv3SUdEt6btNrdqM3yG4plaGwTNHCfR+So7Op8TZ80PKVr+YCb24jOpPGseX6o
	 B/aSBwKNK+nw9o7Wb+khxLjiMPznSkvglkT1qJih+vEYbQq+Qv1F1bye/3p+qVNyQn
	 NBO4qQCOZjPQFQ/Lt9U1QWIeyOE4lbR0d3tm9qRrQ6pKRwYQPVSTI/mdGMQWmjS6q7
	 f55J81DkxU18g==
Date: Mon, 15 Jun 2026 19:40:31 +0000
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>, "regressions@lists.linux.dev" <regressions@lists.linux.dev>
From: Gerhard Schwanzer <geschw@pm.me>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Yang, Philip" <Philip.Yang@amd.com>
Subject: Re: [REGRESSION] drm/amdkfd: SVM split-tail remap regression causes SDMA0 permission fault on RX 7600 XT
Message-ID: <d8ef0670-8ff1-41d9-ad99-6cc0a754c5b0@pm.me>
In-Reply-To: <c967565e-e68c-4881-8cc6-064b7a3c3397@amd.com>
References: <2bfa2f1b-567a-429b-aee2-a8dcf7efd5aa@pm.me> <53c2ad43-091d-46e9-b825-9aaa1d7114e8@amd.com> <2145b14f-00e7-4565-b1da-9e08d2c89a49@pm.me> <d39183d3-b961-4c74-997f-885eb7a887e4@amd.com> <IA1PR12MB85172F7FE9157C092EDA46A0E3112@IA1PR12MB8517.namprd12.prod.outlook.com> <d30aa220-802d-4575-8ab0-058698e4ffbb@pm.me> <c967565e-e68c-4881-8cc6-064b7a3c3397@amd.com>
Feedback-ID: 110185885:user:proton
X-Pm-Message-ID: c06aa69d8bc3aff53393e8e4350d5361b20f16be
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Xiaogang, Alex, gentle ping on the tested candidate fix for this=20
regression. The candidate change fixed the reproducer here (10/10=20
clean), and regzbot now tracks it as "fix incoming". Do you plan to send=20
the formal patch, or would it help if I send a patch based on the public=20
candidate fix? Thanks, Gerhard

On 05/06/26 at 20:46, Chen, Xiaogang wrote:

> Thank you for the testing/confirming.
>
> Xiaogang
>
> On 6/5/2026 1:41 PM, Gerhard Schwanzer wrote:
>> Hi Xiaogang, Thanks. I tested your attached patch on my RX 7600 XT
>> system. Test setup:
>> -
>> kernel 7.0.11 with 448ee453/bf2084a7 active
>> -
>> local revert not applied
>> -
>> your attached candidate fix applied
>> -
>> same self-contained v2 reproducer source as before, unchanged sha256:
>> 33347b5a1915f7452417f776c85527e55f825078c146163470bfe3eacabe3b27
>> Command: ./kfd_svm_split_hsa_copy --upstream-ab Result:
>> -
>> 10/10 runs completed successfully
>> -
>> all HSA/SDMA D2H copies completed
>> -
>> no ROCr memory access fault
>> -
>> no new GCVM_L2_PROTECTION_FAULT_STATUS
>> -
>> no SDMA0 permission fault
>> -
>> no GPU page fault in the kernel log So your patch fixes the reproducer
>> on my system with the original reproducer unchanged. Please feel free to
>> add: Tested-by: Gerhard Schwanzer
>> geschw@pm.me
>> Thanks, Gerhard
>>
>>
>> On 05/06/26 at 19:59, Chen, Xiaogang wrote:
>>> AMD General
>>>
>>>
>>> Hi Gerhard:
>>>
>>> I think the cause is checking the last byte address of svm range for
>>> 2MB alignment when decide possible huge page mapping. Your test case
>>> has vm range that ends just one byte before alignment.
>>>
>>> I tested your app with the attachment, no page fault during sdma
>>> operation. Please verify it.
>>>
>>> Thanks
>>>
>>> Xiaogang
>>>
>>> *From:*Chen, Xiaogang
>>> *Sent:* Wednesday, June 3, 2026 5:51 PM
>>> *To:* Gerhard Schwanzer <geschw@pm.me>; regressions@lists.linux.dev
>>> *Cc:* amd-gfx@lists.freedesktop.org; stable@vger.kernel.org; Deucher,
>>> Alexander <Alexander.Deucher@amd.com>; Yang, Philip <Philip.Yang@amd.co=
m>
>>> *Subject:* Re: [REGRESSION] drm/amdkfd: SVM split-tail remap
>>> regression causes SDMA0 permission fault on RX 7600 XT
>>>
>>> Hi=C2=A0Gerhard:
>>>
>>> Thanks. I can build the app now. And I saw the regression. I am
>>> triaging it.
>>>
>>> The purpose of this patch is to remap split svm ranges(head/tail) that
>>> were mapped with huge page mapping(pmd), but cannot be mapped in huge
>>> page mapping after split due to new svm ranges are not 2MB aligned. It
>>> seems the remap decision misses case that both head and tail ranges
>>> are from original range with huge page mappings were used. Will check..=
..
>>>
>>> Regards
>>>
>>> Xiaogang
>>>
>>> On 6/3/2026 12:54 AM, Gerhard Schwanzer wrote:
>>>
>>>       [Some people who received this message don't often get email from=
geschw@pm.me. Learn why this is important athttps://aka.ms/LearnAboutSender=
Identification ]
>>>
>>>       Hi Xiaogang,
>>>
>>>       Sorry, you are right. The source I uploaded was not self-containe=
d, it still
>>>
>>>       referenced trace_history_replay.inc from an older local replay mo=
de.
>>>
>>>       I uploaded a self-contained v2 source to the GitLab report:
>>>
>>>       https://gitlab.freedesktop.org/-/project/4522/uploads/7395b8985ec=
d7c54183a7615d479c02c/kfd_svm_split_hsa_copy-v2.c
>>>
>>>       The --upstream-ab path does not use that replay table, but the mi=
ssing
>>>
>>>       include
>>>
>>>       obviously broke fresh builds. The v2 source embeds the table and =
otherwise
>>>
>>>       preserves the same source.
>>>
>>>       I re-tested this v2 source before uploading:
>>>
>>>        =C2=A0=C2=A0 - clean build from only kfd_svm_split_hsa_copy-v2.c=
: OK
>>>
>>>        =C2=A0=C2=A0 - ./kfd_svm_split_hsa_copy --help: OK
>>>
>>>        =C2=A0=C2=A0 - good/workaround kernel: --upstream-ab completed 1=
0/10 runs, no new
>>>
>>>        =C2=A0=C2=A0=C2=A0=C2=A0 GCVM/SDMA0/protection-fault messages in=
 the test window
>>>
>>>        =C2=A0=C2=A0 - broken kernel: --upstream-ab reproduced the SDMA0=
 permission fault;
>>>
>>>        =C2=A0=C2=A0=C2=A0=C2=A0 the first kernel fault address matched =
the planned split-tail page
>>>
>>>       Validation summaries:
>>>
>>>       https://gitlab.freedesktop.org/-/project/4522/uploads/e6d0f31c0fd=
a0df2c999439411f29dca/good-kernel-validation-summary.md
>>>
>>>       https://gitlab.freedesktop.org/-/project/4522/uploads/bdf8a3ac678=
6ddb88dd426b59edb32a9/broken-kernel-validation-summary.md
>>>
>>>       The intended triage command remains:
>>>
>>>        =C2=A0=C2=A0 ./kfd_svm_split_hsa_copy --upstream-ab
>>>
>>>       Generic build shape is:
>>>
>>>        =C2=A0=C2=A0 cc -O2 -g -Wall -Wextra -pthread \
>>>
>>>        =C2=A0=C2=A0=C2=A0=C2=A0 -I/path/to/rocm/include -L/path/to/rocm=
/lib \
>>>
>>>        =C2=A0=C2=A0=C2=A0=C2=A0 -o kfd_svm_split_hsa_copy kfd_svm_split=
_hsa_copy-v2.c \
>>>
>>>        =C2=A0=C2=A0=C2=A0=C2=A0 -lhsa-runtime64
>>>
>>>       If you still prefer a binary, please tell me the target runtime/d=
istro. A
>>>
>>>       binary built on my NixOS system is Nix-store linked and likely no=
t
>>>
>>>       portable to
>>>
>>>       your test system.
>>>
>>>       One more thing that would help me test any replacement fix: do yo=
u know what
>>>
>>>       specific failure or workload 448ee453 was intended to fix? I woul=
d like to
>>>
>>>       avoid validating only the revert side while accidentally losing t=
he original
>>>
>>>       fix.
>>>
>>>       Thanks for catching this, and thanks for taking a look.
>>>
>>>       Regards,
>>>
>>>       Gerhard
>>>
>>>       On 06/03/2026 Chen, Xiaogang wrote:
>>>
>>>           I cannot compile kfd_svm_split_hsa_copy.c, there is no
>>>
>>>           "trace_history_replay.inc".
>>>
>>>           Or can you=C2=A0 send the test binary?=C2=A0 That should be e=
nough to triage the
>>>
>>>           issue since it is a regression as you mentioned.
>>>
>>>           Regards
>>>
>>>           Xiaogang
>>>
>>>           On 6/2/2026 5:04 AM, Gerhard Schwanzer wrote:
>>>
>>>               Hi,
>>>
>>>               I would like to make sure this AMDKFD SVM regression is t=
racked by the
>>>
>>>               Linux regression process.
>>>
>>>               GitLab report:
>>>
>>>                   https://gitlab.freedesktop.org/drm/amd/-/work_items/4=
914
>>>
>>>               The regression was originally reported on 2026-01-27. It =
was bisected
>>>
>>>               to the
>>>
>>>               same functional change that Alex Deucher's revert patch l=
ater targeted:
>>>
>>>                =C2=A0=C2=A0 448ee45353ef9fb1a34f5f26eb3f48923c6f0898
>>>
>>>                =C2=A0=C2=A0 drm/amdkfd: Use huge page size to check spl=
it svm range alignment
>>>
>>>               The affected kernel line I tested identifies the same cha=
nge as:
>>>
>>>                =C2=A0=C2=A0 bf2084a7b1d75d093b6a79df4c10142d49fbaa0e
>>>
>>>               Alex's revert patch:
>>>
>>>               https://lists.freedesktop.org/archives/amd-gfx/2026-Febru=
ary/138824.html
>>>
>>>               A small C/HSA reproducer is now available in the GitLab r=
eport. It
>>>
>>>               does not
>>>
>>>               require PyTorch, ComfyUI, Docker, model files, or the ori=
ginal
>>>
>>>               workload. It
>>>
>>>               uses ROCr/HSA, an anonymous THP-advised host mapping, exp=
licit KFD SVM
>>>
>>>               SET_ATTR ioctls, and an HSA SDMA D2H copy.
>>>
>>>               Single reproducer command, same binary on both kernels:
>>>
>>>                =C2=A0=C2=A0 ./kfd_svm_split_hsa_copy --upstream-ab
>>>
>>>               Same-machine A/B result on an RX 7600 XT:
>>>
>>>                =C2=A0=C2=A0 448ee453/bf2084a7 active:
>>>
>>>                =C2=A0=C2=A0=C2=A0=C2=A0 1/1 run faults with SDMA0 permi=
ssion fault
>>>
>>>                =C2=A0=C2=A0=C2=A0=C2=A0 GCVM_L2_PROTECTION_FAULT_STATUS=
=3D0x00841A51
>>>
>>>                =C2=A0=C2=A0 448ee453/bf2084a7 locally reverted:
>>>
>>>                =C2=A0=C2=A0=C2=A0=C2=A0 10/10 runs complete
>>>
>>>                =C2=A0=C2=A0=C2=A0=C2=A0 no ROCr memory access fault
>>>
>>>                =C2=A0=C2=A0=C2=A0=C2=A0 no new GCVM/SDMA0 permission fa=
ult in dmesg
>>>
>>>               The bad fault page is inside the split tail and inside th=
e SDMA copy
>>>
>>>               range:
>>>
>>>                =C2=A0=C2=A0 critical tail: [0x722429d61..0x722429dff]
>>>
>>>                =C2=A0=C2=A0 copy pages:=C2=A0=C2=A0=C2=A0 [0x722429b30.=
.0x722429d70]
>>>
>>>                =C2=A0=C2=A0 fault page:=C2=A0=C2=A0=C2=A0 0x722429d65
>>>
>>>               A full ftrace/PTE run with the same C reproducer/SVM sequ=
ence also shows:
>>>
>>>                =C2=A0=C2=A0 split_tail ... current_remap=3D0 old_remap=
=3D1 missed=3D1
>>>
>>>                =C2=A0=C2=A0 MISSED_REMAP_CANDIDATE split=3Dtail
>>>
>>>                =C2=A0=C2=A0 no amdgpu_vm_update_ptes covering the fault=
 page after the marker
>>>
>>>               before
>>>
>>>                =C2=A0=C2=A0 the fault-side GET_ATTR
>>>
>>>               The suspected code issue is that the split-tail/head rema=
p predicate
>>>
>>>               introduced
>>>
>>>               by 448ee453/bf2084a7 can miss tails inside the final 512-=
page block.
>>>
>>>               Since
>>>
>>>               prange->last is inclusive, ALIGN_DOWN(prange->last, 512) =
is the start
>>>
>>>               of the
>>>
>>>               final block, not an exclusive upper bound.
>>>
>>>               I also sent a short follow-up to amd-gfx with the reprodu=
cer/A-B
>>>
>>>               summary and
>>>
>>>               asked what original failure or workload 448ee453/bf2084a7=
 was intended
>>>
>>>               to fix:
>>>
>>>               https://lists.freedesktop.org/archives/amd-gfx/2026-June/=
145800.html
>>>
>>>               I can resend the reproducer source and summaries directly=
 on-list if
>>>
>>>               preferred.
>>>
>>>               #regzbot introduced: 448ee45353ef9fb1a34f5f26eb3f48923c6f=
0898
>>>
>>>               #regzbot monitor:
>>>
>>>               https://gitlab.freedesktop.org/drm/amd/-/work_items/4914
>>>
>>>               Thanks,
>>>
>>>               Gerhard Schwanzer
>>>

