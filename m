Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793381010;
	b=hsY69sSpL1uUp16tdVR8n4A2ETZFOr+irbRPJikKBZlZTTZdwP3U6o2RKVh0l+wdqi/u
	 LCM5ADMiy67wHlw3Xy9r/mCK7ZZZRfLd5e+oTvyHzd/AO/MTrvTzFDRGE4/jCnCuiiCMd
	 bkZEz9UTTfIguozFxgC0fyU4LA5uLUova+juS60oIZ5FkbdJ3kbKSZTsBYjjF9ONXK6a8
	 eXBiTJuiE0q3CfnJQinUJsb6Z6BBJWBoI0xXXkyNIRDgQoWQRGqA/KZFoucC9HxtoMyUa
	 ZQF4EnuKeWC99x5ep5V0gGDN2wvGVRrdSuKiDbPGwkqCDKa/AJA+X/Ud302gOQXiQFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793381010;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=xxbZQjtm9fOqIJixd8F3mRtkVPXrctgUHoISK45HDYU=;
	b=boo0L3MjB28nd6dlMiqHm6Yju0LslAUo1cTMi71LrN5IpB+jHxmmQTiFlKneG4vGR9EB
	 cJwjmt3XrYt2HbQrentzQTwwkG3eC0Ma85yS4tCgO4NLbZYkB3D8rxUgo9I+Mw3FYCeEG
	 2GHKBKLjtdsw/pIl14HRtFWX2hldmgKZdvtrDQ7v0GvQVik2DRz7JTN2Pym2jGrx2inh1
	 v9ZMZXW3+Cgx1fdKOFbCP+qGp1XCWd+/0jPo5/UGB4AeEbPHQg9Ss8gLeaGnTIN1S43A5
	 RniYz/3bqvhxCRXrKrT9KWGo5mIxsM4RO2kdOYnO86bEX8wDlGMVMnb2dplAJmHy1FA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=BGnwr7ol;
	arc=none smtp.remote-ip=209.85.215.228
Received: from mail-pg1-f228.google.com (mail-pg1-f228.google.com [209.85.215.228])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5418C606A31C
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 17:23:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5418C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=BGnwr7ol
Received: by mail-pg1-f228.google.com with SMTP id 41be03b00d2f7-cc4dbda1e5dso406161a12.2
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 10:23:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793381009; x=1793985809;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xxbZQjtm9fOqIJixd8F3mRtkVPXrctgUHoISK45HDYU=;
        b=zdL1yktJYKsQrnUKhA08ipVpqvNClJazOXJeU7PAxitSPEdhKNu+OD1cvbi/mFAhgD
         JnW7e+w0A5iSY90yH346Vt/Xm1V52tIlWVAocKQ8rHdyxU0Q5mRDqdy4uxNF/96ovW3I
         yLJseVshd1ht6PY1fXi+4wc3N2IA1ruxC6xa8JSwE6gCYHge/afOgSyiUp7IBamjIaPv
         qAcZSS7VN7DCouqXfElJ2fIcxAplxyiz5h7YqkIwA3iapvHEAmpAHyTEiu4YRzBsnkbr
         MO6Vq9qvfeFTXFGvhWiVBZzVEx+tg6JuYb12oN8xUhGGtMQMsY5lV3fcd5X/OF/wQfe/
         ZLAw==
X-Gm-Message-State: AFq9FYLkLmsfjZYCj7CgtXtem3+EMK66SyWjQw1+nJiUQmrN40v05pJI
	HUR3xKqWVPw4PNWNf0J80zr7K71z1tN4+PQZz9k29IOaUJlbnT+9B3LUn+SvN73mvkI3YakLXmr
	SnEFT3iGqCOM9PHuwIGFUgg+wYMLraiOXDxHZLyp8AbF8/gxv5lgkZtU7EeeZQkkVI5GYrJLmy9
	aPU4VMdGJrgtFLyNmOehwAd+mN31CWZAQ++ZZXd7xtFn5d9LA+zIPGpaSmBH3aYNzACg5jrYI6T
	mecVtbW6pfpNxTDSuQ=
X-Gm-Gg: AYBFou1WEilXdTfV+68AM9kzv1/kNAxNfI56ztJPklUjB5Je32LwDPz78BGimBD/TIi
	K+tw6qEMoO0+08jju860dUGw7o3mD/5xWfUCZEOTevFsfZApmVp2vfQxfoT1wYIKxG8kG0zOjdd
	UfHupybjDbfNB/EW0g8le04y4o7/v/oiUI5Ste3VkPv6FEfLXCoaeI1snIqSoI9FREujk2gjXeN
	WjSy2GREzfGq5/MQRf97HAMTPBiOOWuBmJkcUxs6OJjcCIozLbyLp9IEDLdenrDrsP4H5sdP4X9
	vU17W7QAVoMXdF1JBOVUqoStLhwaWcKHGGbQuw0ZDRHfOrWLkpttjrPfQZaSXSgnMYk+UvkN8++
	Um7CRo+2UQbEVDcgCaP/oDfvADtYxzg4FP/hQiI4nXYCPnmOuht8kMXNsd/TUpG6NvlsvVfxwa3
	jX0jqTc0yTGgnf5U/uZIJNLBX8UWwhGreJqRhhP18D
X-Received: by 2002:a05:6a21:6088:b0:3e1:1d49:ab54 with SMTP id adf61e73a8af0-3e928d73a61mr2866969637.42.1793381009508;
        Fri, 30 Oct 2026 10:23:29 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-cdb09a4a980sm47766a12.22.2026.10.30.10.23.28
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Oct 2026 10:23:29 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-36a3451ea93so1495289eec.1
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 10:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793381007; x=1793985807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xxbZQjtm9fOqIJixd8F3mRtkVPXrctgUHoISK45HDYU=;
        b=BGnwr7ol881wvq2Np8ROomQ+LNBQH9JeJzHtXJmxRoZ3qivbuYQDsHlOwUpNGseWce
         AuGMlNrj26YUn/s0Y7krirJ9HvztDE6w6e72OgMXjaNt4AD46Ix90vU79euTFF+l9Pf5
         iZsCCLjJNrYw38QiLRFjsTxWUDsrsZW612cvk=
X-Received: by 2002:a05:701b:420c:20b0:194:f017:5a01 with SMTP id a92af1059eb24-1ac5fc0d363mr3906659c88.42.1793381006581;
        Fri, 30 Oct 2026 10:23:26 -0700 (PDT)
X-Received: by 2002:a05:701b:420c:20b0:194:f017:5a01 with SMTP id a92af1059eb24-1ac5fc0d363mr3906598c88.42.1793381005631;
        Fri, 30 Oct 2026 10:23:25 -0700 (PDT)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1abcf67csm8463406c88.21.2026.10.30.10.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 10:23:25 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: stable@vger.kernel.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH stable 6.1, 5.15, 5.10 0/3] mm: backport mmap_min_addr handling fix to vm_unmapped_area()
Date: Fri, 30 Oct 2026 10:22:13 -0700
Message-Id: <20261030172216.368052-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

To: stable@vger.kernel.org
Cc: Liam R. Howlett <Liam.Howlett@oracle.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org

This series backports

  6b008640db73 ("mm: move 'mmap_min_addr' logic from callers into vm_unmapped_area()")

to the 6.1, 5.15 and 5.10 stable trees. It is already part of v6.4-rc1
and therefore present in 6.6.y and later. The three patches are
independent of each other, one per tree, and are meant to be applied to
the respective stable branch only.

Problem
=======

An unprivileged process can get EPERM from mmap(MAP_ANONYMOUS) although
plenty of address space is still available. This happens when
vm.mmap_min_addr is larger than PAGE_SIZE (the usual case, distributions
and embedded systems set 32 KiB or 64 KiB):

  - with the top-down layout, the search starts at mm->mmap_base and
    walks down towards low_limit;
  - several architectures pass a low_limit below mmap_min_addr to
    vm_unmapped_area() (PAGE_SIZE, FIRST_USER_ADDRESS, ...), so the
    search can return an address in [low_limit, mmap_min_addr);
  - get_unmapped_area() gets that address back from the architecture
    code, but security_mmap_addr() then refuses it, and the caller sees
    -EPERM.

The right outcome is to treat the range below mmap_min_addr as not
available, so that the top-down search fails with -ENOMEM and the caller
falls back to the bottom-up search above mmap_base, as the generic code
already does.

Commit 2afc745f3e30 ("mm: ensure get_unmapped_area() returns higher
address than mmap_min_addr") fixed this only for the generic
arch_get_unmapped_area_topdown(). Architectures with their own
implementation were left alone. 6b008640db73 moves the clamp into
vm_unmapped_area() itself, which fixes all callers at once.

Affected code, determined by reading the 6.1, 5.15 and 5.10 trees and
confirmed by running the kernels below:

  - x86-64 (arch/x86/kernel/sys_x86_64.c), including 32-bit processes
    on a 64-bit kernel, and the x86 hugetlb search
    (arch/x86/mm/hugetlbpage.c)
  - arm (arch/arm/mm/mmap.c)
  - mips (arch/mips/mm/mmap.c)
  - sparc64 (arch/sparc/kernel/sys_sparc_64.c and
    arch/sparc/mm/hugetlbpage.c); only 32-bit tasks use the top-down
    layout there
  - by code inspection only, not run: parisc, sh and, in 6.1, loongarch

arm64, s390 and powerpc already clamp to mmap_min_addr in their own or in
the generic code, so their behaviour does not change; they were run as
regression checks (see below). 32-bit x86 kernels use the generic code,
which already clamps; that was checked by reading the code only.

Backport notes
==============

  6.1.y   The patch applies cleanly.

  5.15.y  Same as 5.10.y, see below.
  5.10.y  These trees predate the maple tree, so the mm/mmap.c hunks do
          not apply. unmapped_area() and unmapped_area_topdown() are the
          rbtree based versions; the lower search bound is clamped
          there with a local min_addr = max(info->low_limit,
          mmap_min_addr), which is then used in place of
          info->low_limit (including the early "low_limit > high_limit"
          check, the final clipping of the gap and the VM_BUG_ON()). The
          arch/s390 and fs/hugetlbfs hunks apply as in the original
          commit. This is noted in the commit message of each patch.

Reproducer
==========

Run it as an unprivileged user, with vm.mmap_min_addr set to something
larger than PAGE_SIZE (for example 65536). It exits with status 1 and
prints "Operation not permitted" on an affected kernel, and exits with
status 0 and prints "Cannot allocate memory" on a fixed one.

  - 32-bit process:                      ./repro
  - 64-bit process:                      ./repro 1099511627776
    (starting with 1 TiB chunks makes the 47/48 bit address space run out
    after a few hundred mappings instead of billions)

--- mmap-minaddr-repro.c ---
// SPDX-License-Identifier: GPL-2.0
/*
 * Map anonymous memory until mmap() fails and report why.
 *
 * Run as an unprivileged user (root has CAP_SYS_RAWIO, which bypasses
 * vm.mmap_min_addr) with vm.mmap_min_addr larger than PAGE_SIZE.
 *
 *   32-bit process:  ./repro                 (64 KiB first, halved on ENOMEM)
 *   64-bit process:  ./repro 1099511627776   (start with 1 TiB so that the
 *                                             address space is used up quickly)
 *
 * A kernel that handles vm.mmap_min_addr correctly ends with ENOMEM once the
 * address space is exhausted.  An affected kernel ends with EPERM while there
 * is still free address space above mmap_base.
 */
#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>

int main(int argc, char **argv)
{
	size_t size = argc > 1 ? strtoull(argv[1], NULL, 0) : 65536;
	unsigned long count = 0;

	for (;;) {
		void *p = mmap(NULL, size, PROT_READ | PROT_WRITE,
			       MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);

		if (p != MAP_FAILED) {
			count++;
			continue;
		}
		if (errno == ENOMEM && size > 4096) {
			size /= 2;
			continue;
		}
		printf("mmap(%zu) failed after %lu mappings: %s (errno %d)\n",
		       size, count, strerror(errno), errno);
		return errno == EPERM;	/* exit status 1: bug present */
	}
}
--- end ---

Example output with vm.mmap_min_addr=65536, 6.1.y, x86-64 kernel:

  without the patch, 32-bit process:
    mmap(65536) failed after 63458 mappings: Operation not permitted (errno 1)
  without the patch, 64-bit process (./repro 1099511627776):
    mmap(32768) failed after 172 mappings: Operation not permitted (errno 1)
  with the patch, 32-bit process:
    mmap(4096) failed after 65513 mappings: Cannot allocate memory (errno 12)
  with the patch, 64-bit process:
    mmap(4096) failed after 184 mappings: Cannot allocate memory (errno 12)

The hugetlb paths can be exercised with a variant of the same loop: use
MAP_HUGETLB | MAP_NORESERVE (no huge pages need to be reserved), keep the
size a multiple of the huge page size and stop halving at the huge page
size, and set vm.mmap_min_addr (as root, before dropping privileges)
above the huge page size, for example to 256 MiB. Huge pages are
aligned, so with a smaller mmap_min_addr the search can never land below
it and the problem is not reachable.

Testing
=======

Every tree was built twice per architecture, without and with its patch,
and booted under QEMU (TCG) with a minimal initramfs. A process running
as uid 1000 was run three times per configuration (once on s390, where
a run takes about 17 million mmap() calls) with vm.mmap_min_addr=65536,
with 1 MiB on powerpc64 (64 KiB pages) and with 256 MiB for the hugetlb
runs. The results were identical for 6.1.y, 5.15.y and 5.10.y.

  kernel / process                           without patch   with patch
  ------------------------------------------------------------------------
  x86_64, 32-bit and 64-bit process          EPERM           ENOMEM
  x86_64, hugetlb, 64-bit process            EPERM           ENOMEM
  arm (multi_v7), 32-bit process             EPERM           ENOMEM
  mips (malta, big endian), 32-bit process   EPERM           ENOMEM
  sparc64, 32-bit process                    EPERM           ENOMEM
  sparc64, hugetlb, 32-bit process           EPERM           ENOMEM

  arm64, 64-bit and 32-bit (compat) process  ENOMEM          ENOMEM
  arm64, hugetlb (generic hugetlbfs path)    ENOMEM          ENOMEM
  s390                                       ENOMEM          ENOMEM
  powerpc64 hash (POWER8) and radix (POWER9) ENOMEM          ENOMEM
  powerpc64 radix, hugetlb                   ENOMEM          ENOMEM
  powerpc32                                  ENOMEM          ENOMEM

The arch/s390 files touched by the patch were compiled and linked on all
three trees.

Not covered: parisc, sh and loongarch were not run at all. hugetlb on
s390 and on powerpc64 with the hash MMU could not be run, because QEMU
does not provide a usable default huge page size for them. The
generic hugetlbfs hunk was exercised through arm64 only (where the
behaviour is unchanged, as that path already clamped locally).

 6.1.y:   4 files changed, 16 insertions(+), 9 deletions(-)
 5.15.y:  4 files changed, 13 insertions(+), 11 deletions(-)
 5.10.y:  4 files changed, 13 insertions(+), 11 deletions(-)
