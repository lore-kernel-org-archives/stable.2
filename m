Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274CC23395E
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 16:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.148.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781799368; cv=pass; b=IijZVwaoUvNVvwsjjYRrGnrTf5JgteULFLaO4pOOOUkHS86XYTn9Kh8tns/GB8Eoqf6D7ZCRmsjbyUtFZI/fwli+6R7K5l0PAoFREsITX1s7dZ6g8scmqZ646QRKVbRA24ERrpMcrDoiqe705fd2hgcLmn1a9pttxLLhm027JLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781799368; c=relaxed/simple;
	bh=z3NAyBldUjct7IuOmCr5uMrTiVzloiCtrV0uREANA3Q=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=seiJ4J6tX3ES9AR5RyvJx/bmYn6td660QYYV8ELAuIo9IvUQlTfUGzMa/l+Qy2KSQomF5Ej7pKGLpIniJMZGPtE/00icQrnfwB9O3ayXm0dj+OZi20ZNzzxueBexCaafco9dNa0zPAADbcBBB9wk/cT3wEPWGps7CJSMItdzCdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=UeN0rNXa; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=XUiGO3CK; arc=pass smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="UeN0rNXa";
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="XUiGO3CK"
Received: from pps.filterd (m0354652.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65IEk1TF2363438
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 16:03:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=default; bh=1Bsbqlkyxwr//
	SOq2ZYji2zspNcLflZqJFFaFAZGGbw=; b=UeN0rNXa6rw1Yu//Az7RmGifDOuFD
	riAD6ygbnQgPlLG7IdKzQcYeYzu0WTRLoK5B3/7W6zAciaSMCGDbzwRdrA8a9ZG7
	PvD4JzjUEm8q3d4B+6cn6aSEt3V9TmmKSwi1B8cdkrkCGZoi5ABzcvAVx8hHFrhE
	3G2cafR+czs10YcimCqVdp5U932Ez0no+RadqqFYedvgAWsPkhGGlRhobRHn76ky
	/DIT9pn4XHB2Ctrxg3bjbpemWoeg3tYaRkQupo05z9HsgTT2YqJXY1m6svwxXB1R
	mkEz0GR4zUPxubGzcl23+cwPcuTYlepdic1DXlWe3G8BcRiE2+khtC++g==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4ev4w5k6a0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 16:03:27 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-138404c4b85so513186c88.0
        for <stable@vger.kernel.org>; Thu, 18 Jun 2026 09:03:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781798607; cv=none;
        d=google.com; s=arc-20240605;
        b=G6ne3d4A4LUb+TvGSFvysXNXV9h12V7c+hTvI/pSH2Tmn3x+9MFd1q21Q/9H7jxTPL
         hynsea52BwolkH0KbOlCemT4+fl9mfIfpAPVOPsse2bqtL2faX7HoHZWORw8sSYU1vM4
         GDRvr9ZRN6hlYSAddnz70k02j4392SPzrSTzbj4/AnjUQylKUsu+jfmzrbv1jqCxKuMt
         C9iEqD6KbypnbvT2oEVO+KOAMTWUnvYvVkso/n+NRdqFlCaA2DUztxGXeIJDr8pk17F6
         SqOhdDmLw3FxLTrsPhoFsqxS49Kg65i7UrbeNaYowiBgBv8KhbiKVGzb7Tt1omHIlCnP
         bNEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=1Bsbqlkyxwr//SOq2ZYji2zspNcLflZqJFFaFAZGGbw=;
        fh=0xay+P+Kto63kNRqXayKGi+QHEFBGr/uftknv+5dsL4=;
        b=deirlRiBhqbOPNDxsvPt2uIa59+SmDH2Wal7RsWLHmENElalent2Tw3D99cye60nfh
         Sna8VW+cCpOQLNmoC+9LvjvACgcSCYZaLMCk3ZHvsBCYAlzwIk7NWxIWXDqlAZ38eo/G
         Zi5WJvzHEnPtadl5JoOElUIDbvtsSPDHMP1xHT31AREacr3Zi34ClF/JnzAVk58C0xPj
         JhknVUCOj/wE9wmKIKd7gSpCYi0wVLRZ0G8v1TYOa9BdFYNib8m4hcduZRkSK6qb3Aq0
         Y38h9WWc7rfT211rwG8aRRvxUxDTJTsRGzY2rBxgmJpmK7Yy4ATDanCDqZYoBmbsVXMY
         EyVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1781798607; x=1782403407; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1Bsbqlkyxwr//SOq2ZYji2zspNcLflZqJFFaFAZGGbw=;
        b=XUiGO3CKYXb0aYJhTm+USqQ08CBHCzKXbJQmCxbnEpdY5syaFgc70r8meOmUW99lm7
         wS9LEfhcREYi+s33IhQFUsSoMadlhNCy7iOBT1ZkTQ4gYMq3AaIUtQw8ksx8MvK+ZXKq
         8Uwc70Zu7mvBRu1Na8ud0rP/O8zYKc3wFbBZNI/nfAIuq1S85ifAChsWoEZt9pVvwcUi
         PdemkmAwe+L9Jjaljo7MjKAPh/rkcqUU9tYx7XBMbImA4x5omd4OUgi1e/e2Y+zxGdfD
         Y8uOmzkdKG82/udWDZfD9/qSIMxvYKWNOEKHqhxN9UcCijY22mxy5AjaR35g0W8fKDrN
         rQpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781798607; x=1782403407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Bsbqlkyxwr//SOq2ZYji2zspNcLflZqJFFaFAZGGbw=;
        b=DPV1lY3dfRef2n8iXTD3pyfCzeGvu5NUpBSJALlSeutClartXTm1Kgcy/Vov5Ngge8
         pF9OZBaTDZpkqXOOcFRkGKte5HIAgSzX83u0W2Dp9Se5ix3E8H2fAt5n7C+TZ554N9WC
         u64cDlcvPiLQpSJdQKKg3bXkd0HU/jeoi3IlSHl59XIlSFeYZx75jOYQwLtg5hZ7I9sO
         JzZ+Zh0uG74dk18kg2r5WMKbGZkkpFkhNE1WMqwogOfSwEogYmqwyffUuRdMCLM4n514
         XrJVGjqJXYSXq05fzY/Ultk+94vnrCxUUkhMlbMbXTOgri+mpDUZvvLIJ3LMqCWjfaTj
         vjmQ==
X-Gm-Message-State: AOJu0YzqC9ZQxeoblPkisRf5SK0Qa2dov9R2STlaqBURcyTacVDKH3N/
	xnD8qfU7ulygHvV4xgW1bJ15/E7Ba5cjf1GlTUqAqEAo/gKuE48F1lyYH2xihrbMYSOfg8wFBrD
	6bMj8NjRgddkThkZv3zFyjO601v14F8cSnXwWtcyrUave7l8K211jy7XZaEIZRYzHn8nEQc9N3B
	umJYzSTeK0hjFC0uTQtKuKdPzlO0FwI+Zj8xE5mCprEJjJ0g==
X-Gm-Gg: AfdE7cnfJ/p3DlFrroiHraJtsAyr6zsV1/ZwFaCc/TAWf9DUanMcmHSHNE3Zs1JntxP
	DLhw32jwZzPf2YxQxBmuHsmgw7FD6NGeyszRmSH4tRrgKWiiZWHk+C/Ll4YoU3IQl905bNmiY9b
	MlnnIt0ojcfKX+QKAtDEBACKzEUy1IkW9cVNOVqebMX7KLRsL2Vqq8aj1PrE50O5tVZg==
X-Received: by 2002:a05:7022:220:b0:138:12fa:3794 with SMTP id a92af1059eb24-139a212d8a6mr177660c88.26.1781798606326;
        Thu, 18 Jun 2026 09:03:26 -0700 (PDT)
X-Received: by 2002:a05:7022:220:b0:138:12fa:3794 with SMTP id
 a92af1059eb24-139a212d8a6mr177531c88.26.1781798605193; Thu, 18 Jun 2026
 09:03:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Thu, 18 Jun 2026 12:03:13 -0400
X-Gm-Features: AVVi8CddnXjnaOWPPQgp7933-deo56vykJLzjBUfJRWiro7216eGPxrIN_sSXwA
Message-ID: <CAOu3gNibeo3ov09CYpmzuqewB0EOsajB3hPU9pQmb_zoAUraHg@mail.gmail.com>
Subject: [stable request ] backpot Fix ftrace symbol table corruption on
 kernels with CONFIG_X86_KERNEL_IBT=y to 6.6.y and 6.12.y
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, sashal@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>, vmalik@redhat.com,
        jmarchan@redhat.com, Martin Kelly <martin.kelly@crowdstrike.com>,
        Justin Deschamp <justin.deschamp@crowdstrike.com>,
        DL Linux Open Source Team <linux-open-source@crowdstrike.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: c-r2nhe4QJnPkfMt7HrgmVVrfbs4qZpY
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDE0OSBTYWx0ZWRfX+fNLhWv3I2Wm
 W56EQbwq/+50gR/C88h2Mq3/dToKb64qcJHYv0Tih0WM2HNitbXd4KP3t1l3UaVLuWW6D4t2RJi
 4Ual08oWKHvYiIGiEXg9Wfn+eqD7QDEZvu/RXMMxscWkiPeNenIm
X-Authority-Analysis: v=2.4 cv=UclhjqSN c=1 sm=1 tr=0 ts=6a3416cf cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=KZhmPCYDdY0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22
 a=2KvRFfd_T_-xjmS8C1aD:22 a=VwQbUJbxAAAA:8 a=pl6vuDidAAAA:8 a=meVymXHHAAAA:8
 a=20KFwNOVAAAA:8 a=p0WdMEafAAAA:8 a=Kcs2FKKwnwZYh8OWfnkA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-GUID: c-r2nhe4QJnPkfMt7HrgmVVrfbs4qZpY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDE0OSBTYWx0ZWRfX3cVwbHt3fi3e
 HK93IxiNSf7bx8Ab8R5w0YD48vLdLmMsh2muI/HI/QQnXNFYEH20LwSil3/eYQwuL0QM+4DvSpn
 6G/jK4YpWIYt3fWfzqimkquBQb876Q9AWnOhF5+YNYePMvEf04pod8A9D7Kc3RjFuNallHYoE6c
 o5f6gW667ec0bkrpLf5/15kUN6nq4u6wEiVyv2sU4ZhU7+6F6w0TzS3RV6prJodJQCvt5siEJkg
 4MvupqMmNN/B7+klXyz0cEPVnjv01bsMXF7wyRxg2qcv2XjXGyW38Q/abRYza3M0gcVx1yOGeeY
 MVy5S9g8W13YqPXbXU+cwMg0mqvpKWJTPIb6uvBcLIy18hX9Z6Pfj5aaNkmj9B8XufY3yVIStSw
 elniBA15zKhSGtpqbkds4rFusJQ4waaoQl4yWmnHiUPig2SqC6d+sqHy7somd6WwrDWr318yaBP
 aIr5sJMxDcsePsCNSmg==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11821
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 clxscore=1011 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180149

Hello stable team,

We are requesting backport of a 27-patch series that fixes a critical
bug where ftrace hooks silently fail on kernels with
CONFIG_X86_KERNEL_IBT=3Dy. While the bug is most visible with
fentry/trampoline-based hooks, it affects ftrace more broadly as it
corrupts the symbol lookup table ftrace uses to determine function
addresses.

The Bug
=3D=3D=3D=3D=3D=3D=3D

On kernels with Intel IBT enabled, certain fentry hooks silently fail
to fire with no error. When IBT is enabled, ENDBR64 becomes the first
instruction of every function, pushing __fentry__ to offset +4. Weak
overridden functions (e.g. acct_process / paddr_vmcoreinfo_note) retain
entries in __mcount_loc at this offset. When the kernel binary-searches
the ftrace table during hook attachment, the presence of these duplicate
weak entries causes non-deterministic results =E2=80=94 depending on which =
entry
the search lands on, the trampoline hook either fires or silently
doesn't.

This was originally reported to the BPF mailing list in October 2024:
https://lore.kernel.org/bpf/7136605d24de9b1fc62d02a355ef11c950a94153.camel@=
crowdstrike.com/T/#u

CONFIG_X86_KERNEL_IBT was introduced in kernel 5.18, making all kernels
from 5.18 through 6.14 potentially affected. This includes production
systems on RHEL 10 (kernel 6.12), Fedora 40+, Debian 13, and Ubuntu
22.04/24.04 LTS variants. On affected kernels, trampoline hooks
silently don't fire, and ftrace function tracing may produce incorrect
results due to corrupted symbol resolution.

The Fix
=3D=3D=3D=3D=3D=3D=3D

Steven Rostedt's patch series (v5, merged to mainline in Linux 6.15
via 'Merge tag trace-sorttable-v6.15'):
https://lore.kernel.org/all/20250218195918.255228630@goodmis.org/

The fix zeroes out weak function entries in __mcount_loc at build time
via scripts/sorttable.c, so they are never added to the ftrace table
and can never corrupt binary searches.

Prior Art - Red Hat Backport
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
Red Hat has published a KB article acknowledging the issue:
https://access.redhat.com/solutions/7143835

Red Hat independently identified and backported the fix patchset
plus other patches that were required for correct merge and operation
- details below.
They merged it into the RHEL 10 kernel (kernel 6.12).

Their work is publicly available at:
https://gitlab.com/redhat/centos-stream/src/kernel/centos-stream-10/-/merge=
_requests/2689

All patches are from upstream, no RHEL-specific modifications
were made. Viktor Malik (vmalik@redhat.com) and Jerome Marchand
(jmarchan@redhat.com) from Red Hat's kernel team are CC'd.

These are the patches we are asking to backport.

Patches Requested
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Group 1 - sorttable.c rewrite (14 patches, merged Linux 6.14):

28b24394c6e9 scripts/sorttable: Remove unused macro defines
4f48a28b37d5 scripts/sorttable: Remove unused write functions
6f2c2f93a190 scripts/sorttable: Remove unneeded Elf_Rel
66990c003306 scripts/sorttable: Have the ORC code use the _r() functions to=
 read
7ffc0d0819f4 scripts/sorttable: Make compare_extable() into two functions
157fb5b3cfd2 scripts/sorttable: Convert Elf_Ehdr to union
545f6cf8f4c9 scripts/sorttable: Replace Elf_Shdr Macro with a union
200d015e73b4 scripts/sorttable: Convert Elf_Sym MACRO over to a union
1dfb59a228dd scripts/sorttable: Add helper functions for Elf_Ehdr
67afb7f50440 scripts/sorttable: Add helper functions for Elf_Shdr
17bed33ac12f scripts/sorttable: Add helper functions for Elf_Sym
1b649e6ab8dc scripts/sorttable: Use uint64_t for mcount sorting
58d87678a0f4 scripts/sorttable: Move code from sorttable.h into sorttable.c
4acda8edefa1 scripts/sorttable: Get start/stop_mcount_loc from ELF file dir=
ectly

Replaces the old macro-heavy sorttable.h architecture with a clean
union-based design and proper ELF symbol lookup. Required prerequisite
for the core fix =E2=80=94 the fix patches cannot apply without it.


Group 2 - Additional prerequisite (1 patch, merged Linux 6.14):

1e5f6771c247 scripts/sorttable: Use a structure of function pointers
for elf helpers

Groups all ELF helper function pointers into a single struct (requested
by Linus Torvalds after the rewrite landed). Required by the core fix.


Group 3 - The core IBT fix (6 patches, merged Linux 6.15):

b3d09d06e052 arm64: scripts/sorttable: Implement sorting mcount_loc at
boot for arm64
a02656593225 scripts/sorttable: Have mcount rela sort use direct values
5fb964f5ba53 scripts/sorttable: Always use an array for the mcount_loc sort=
ing
ef378c3b8233 scripts/sorttable: Zero out weak functions in mcount_loc table
4a3efc6baff9 ftrace: Update the mcount_loc check of skipped entries
264143c4e544 ftrace: Have ftrace pages output reflect freed pages

The core fix. Zeroes out weak function entries in __mcount_loc at build
time; boot-time code skips zeroed/KASLR-shifted entries when building
the ftrace table.


Group 4 - Post-merge correctness fixes (6 patches, merged Linux 6.15):

be55257fab18 ftrace: Do not over-allocate ftrace memory
6eeca746fa5f ftrace: Test mcount_loc addr before calling ftrace_call_addr()
da0f622b344b ftrace: Check against is_kernel_text() instead of kaslr_offset=
()
46514b3c2c17 scripts/sorttable: Use normal sort if theres no relocs in
the mcount section
dc208c69c033 scripts/sorttable: Allow matches to functions before function =
entry
023f124a6417 scripts/sorttable: Fix endianness handling in build-time
mcount sort

Fixes breakage found immediately after the core fix merged: arm64 crash
on invalid addresses, kaslr_offset() not portable across non-x86
architectures, arm64+clang using direct mcount_loc instead of Elf_Rela,
arm64 -fpatchable-function-entry offset causing valid functions to be
incorrectly zeroed, and cross-compile endianness double-conversion
zeroing all mcount entries on s390/big-endian targets. Without these
the fix is broken on arm64 and big-endian targets.


All 27 patches touch only scripts/sorttable.c, scripts/sorttable.h,
scripts/link-vmlinux.sh, kernel/trace/ftrace.c, and
arch/arm64/Kconfig. They are build-time and boot-time changes only
with no impact on the runtime kernel ABI.

Requested Stable Branches
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D

- 6.12.y (LTS)
- 6.6.y (LTS)


Testing
=3D=3D=3D=3D=3D=3D=3D

We built and tested the 27-patch series against both linux-6.6.y (at
6.6.142) and linux-6.12.y (at 6.12.93) on an x86_64 machine with
CONFIG_X86_KERNEL_IBT=3Dy. Both series applied cleanly with zero
conflicts.

Indirect test:
grep __ftrace_invalid_address___ \
  /sys/kernel/tracing/available_filter_functions | wc -l

6.6.142 unpatched: 562  patched: 0
6.12.93 unpatched: 589  patched: 0

Direct test (bpftrace kprobe vs fentry on put_task_struct_rcu_user):
6.6.142 unpatched: fentry=3D0,  kprobe=3D46  (silent failure confirmed)
6.6.142 patched:   fentry=3D46, kprobe=3D46  (fixed)

6.12.93 unpatched: Can't reproduce because of the non-deterministic
nature of the bug expression per a kernel build.

ftrace kernel selftests (tools/testing/selftests/ftrace):

Kernel                      PASS  FAIL
6.6.142 unpatched   119     2
6.6.142 patched       119     2
6.12.93 unpatched   135     0
6.12.93 patched       135     0

The 2 pre-existing failures on 6.6 (kprobe_args_char,
kprobe_args_string) are present on both patched and unpatched kernels
and are unrelated to this series.

We are happy to assist with testing on additional architectures or
stable branches.

Thank you,
Andrey Grodzovsky (Linux Open Source Team)
CrowdStrike
