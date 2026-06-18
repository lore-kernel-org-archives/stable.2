Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8798272E56
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 16:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781801182; cv=none; b=VImaG5s5A7LVbuPmYZMkhMgGd40P3K32oszjVLgLryXfM4GVdppnoo5GZFtctno2BzjRnne/9omc8kO8Y2TKm7uqV5sMAFNxtSH7Qu1Lg8lWcPcLk0yb1ErXwrCzyKcTsxlk3HibMJ6Y6QIVJ7EeLN0jcJ88I8nFIiW1p5gK+mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781801182; c=relaxed/simple;
	bh=Z330g45vf/4UJwYqyvJIHBMlEzUVnP7JCko2AND0LF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bsrOKckd1UYbrF5Eh6ZM7m6okybjoyoKk7vzFO6G2vPQsIFC+NRdOchGLuheqTueeX/F45PEpPPabcieAKW5KZnEn8Z9hZ0JL+xgULTpfQXKx2gn35QHG0h9HVmH7G0ZvimswIBkGyiCP5FcPrCXmMRKRFKHfcintgdh8CZNyAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FHGc5OT8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FHGc5OT8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42F9C1F000E9;
	Thu, 18 Jun 2026 16:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781801176;
	bh=8nuexPY81zES03YYq9n3YJgvbwIe2sHVd8n1yobHI/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FHGc5OT80K84tHa6dL7X9TherCTcYUQccBqruV0rVelC7YHL/3dv0gEZ3xqoCp3I/
	 IJ4zZ96mQuGGPGhh5cFhX1m5YM9RYqJR56RDOaUuCQMhgWPvB/3Z9/V7PaxlKt3FCu
	 hVZsJszOwrlpYexzZDthGPg7o2uIiM3NMEPwaqSs=
Date: Thu, 18 Jun 2026 18:45:10 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Cc: stable@vger.kernel.org, sashal@kernel.org,
	Steven Rostedt <rostedt@goodmis.org>, vmalik@redhat.com,
	jmarchan@redhat.com, Martin Kelly <martin.kelly@crowdstrike.com>,
	Justin Deschamp <justin.deschamp@crowdstrike.com>,
	DL Linux Open Source Team <linux-open-source@crowdstrike.com>
Subject: Re: [stable request ] backpot Fix ftrace symbol table corruption on
 kernels with CONFIG_X86_KERNEL_IBT=y to 6.6.y and 6.12.y
Message-ID: <2026061837-enroll-fracture-d6f9@gregkh>
References: <CAOu3gNibeo3ov09CYpmzuqewB0EOsajB3hPU9pQmb_zoAUraHg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOu3gNibeo3ov09CYpmzuqewB0EOsajB3hPU9pQmb_zoAUraHg@mail.gmail.com>

On Thu, Jun 18, 2026 at 12:03:13PM -0400, Andrey Grodzovsky wrote:
> Hello stable team,
> 
> We are requesting backport of a 27-patch series that fixes a critical
> bug where ftrace hooks silently fail on kernels with
> CONFIG_X86_KERNEL_IBT=y. While the bug is most visible with
> fentry/trampoline-based hooks, it affects ftrace more broadly as it
> corrupts the symbol lookup table ftrace uses to determine function
> addresses.
> 
> The Bug
> =======
> 
> On kernels with Intel IBT enabled, certain fentry hooks silently fail
> to fire with no error. When IBT is enabled, ENDBR64 becomes the first
> instruction of every function, pushing __fentry__ to offset +4. Weak
> overridden functions (e.g. acct_process / paddr_vmcoreinfo_note) retain
> entries in __mcount_loc at this offset. When the kernel binary-searches
> the ftrace table during hook attachment, the presence of these duplicate
> weak entries causes non-deterministic results — depending on which entry
> the search lands on, the trampoline hook either fires or silently
> doesn't.
> 
> This was originally reported to the BPF mailing list in October 2024:
> https://lore.kernel.org/bpf/7136605d24de9b1fc62d02a355ef11c950a94153.camel@crowdstrike.com/T/#u
> 
> CONFIG_X86_KERNEL_IBT was introduced in kernel 5.18, making all kernels
> from 5.18 through 6.14 potentially affected. This includes production
> systems on RHEL 10 (kernel 6.12), Fedora 40+, Debian 13, and Ubuntu
> 22.04/24.04 LTS variants. On affected kernels, trampoline hooks
> silently don't fire, and ftrace function tracing may produce incorrect
> results due to corrupted symbol resolution.
> 
> The Fix
> =======
> 
> Steven Rostedt's patch series (v5, merged to mainline in Linux 6.15
> via 'Merge tag trace-sorttable-v6.15'):
> https://lore.kernel.org/all/20250218195918.255228630@goodmis.org/
> 
> The fix zeroes out weak function entries in __mcount_loc at build time
> via scripts/sorttable.c, so they are never added to the ftrace table
> and can never corrupt binary searches.
> 
> Prior Art - Red Hat Backport
> =============================
> Red Hat has published a KB article acknowledging the issue:
> https://access.redhat.com/solutions/7143835
> 
> Red Hat independently identified and backported the fix patchset
> plus other patches that were required for correct merge and operation
> - details below.
> They merged it into the RHEL 10 kernel (kernel 6.12).
> 
> Their work is publicly available at:
> https://gitlab.com/redhat/centos-stream/src/kernel/centos-stream-10/-/merge_requests/2689
> 
> All patches are from upstream, no RHEL-specific modifications
> were made. Viktor Malik (vmalik@redhat.com) and Jerome Marchand
> (jmarchan@redhat.com) from Red Hat's kernel team are CC'd.
> 
> These are the patches we are asking to backport.
> 
> Patches Requested
> =================
> 
> Group 1 - sorttable.c rewrite (14 patches, merged Linux 6.14):
> 
> 28b24394c6e9 scripts/sorttable: Remove unused macro defines
> 4f48a28b37d5 scripts/sorttable: Remove unused write functions
> 6f2c2f93a190 scripts/sorttable: Remove unneeded Elf_Rel
> 66990c003306 scripts/sorttable: Have the ORC code use the _r() functions to read
> 7ffc0d0819f4 scripts/sorttable: Make compare_extable() into two functions
> 157fb5b3cfd2 scripts/sorttable: Convert Elf_Ehdr to union
> 545f6cf8f4c9 scripts/sorttable: Replace Elf_Shdr Macro with a union
> 200d015e73b4 scripts/sorttable: Convert Elf_Sym MACRO over to a union
> 1dfb59a228dd scripts/sorttable: Add helper functions for Elf_Ehdr
> 67afb7f50440 scripts/sorttable: Add helper functions for Elf_Shdr
> 17bed33ac12f scripts/sorttable: Add helper functions for Elf_Sym
> 1b649e6ab8dc scripts/sorttable: Use uint64_t for mcount sorting
> 58d87678a0f4 scripts/sorttable: Move code from sorttable.h into sorttable.c
> 4acda8edefa1 scripts/sorttable: Get start/stop_mcount_loc from ELF file directly
> 
> Replaces the old macro-heavy sorttable.h architecture with a clean
> union-based design and proper ELF symbol lookup. Required prerequisite
> for the core fix — the fix patches cannot apply without it.
> 
> 
> Group 2 - Additional prerequisite (1 patch, merged Linux 6.14):
> 
> 1e5f6771c247 scripts/sorttable: Use a structure of function pointers
> for elf helpers
> 
> Groups all ELF helper function pointers into a single struct (requested
> by Linus Torvalds after the rewrite landed). Required by the core fix.
> 
> 
> Group 3 - The core IBT fix (6 patches, merged Linux 6.15):
> 
> b3d09d06e052 arm64: scripts/sorttable: Implement sorting mcount_loc at
> boot for arm64
> a02656593225 scripts/sorttable: Have mcount rela sort use direct values
> 5fb964f5ba53 scripts/sorttable: Always use an array for the mcount_loc sorting
> ef378c3b8233 scripts/sorttable: Zero out weak functions in mcount_loc table
> 4a3efc6baff9 ftrace: Update the mcount_loc check of skipped entries
> 264143c4e544 ftrace: Have ftrace pages output reflect freed pages
> 
> The core fix. Zeroes out weak function entries in __mcount_loc at build
> time; boot-time code skips zeroed/KASLR-shifted entries when building
> the ftrace table.
> 
> 
> Group 4 - Post-merge correctness fixes (6 patches, merged Linux 6.15):
> 
> be55257fab18 ftrace: Do not over-allocate ftrace memory
> 6eeca746fa5f ftrace: Test mcount_loc addr before calling ftrace_call_addr()
> da0f622b344b ftrace: Check against is_kernel_text() instead of kaslr_offset()
> 46514b3c2c17 scripts/sorttable: Use normal sort if theres no relocs in
> the mcount section
> dc208c69c033 scripts/sorttable: Allow matches to functions before function entry
> 023f124a6417 scripts/sorttable: Fix endianness handling in build-time
> mcount sort
> 
> Fixes breakage found immediately after the core fix merged: arm64 crash
> on invalid addresses, kaslr_offset() not portable across non-x86
> architectures, arm64+clang using direct mcount_loc instead of Elf_Rela,
> arm64 -fpatchable-function-entry offset causing valid functions to be
> incorrectly zeroed, and cross-compile endianness double-conversion
> zeroing all mcount entries on s390/big-endian targets. Without these
> the fix is broken on arm64 and big-endian targets.
> 
> 
> All 27 patches touch only scripts/sorttable.c, scripts/sorttable.h,
> scripts/link-vmlinux.sh, kernel/trace/ftrace.c, and
> arch/arm64/Kconfig. They are build-time and boot-time changes only
> with no impact on the runtime kernel ABI.
> 
> Requested Stable Branches
> ==========================
> 
> - 6.12.y (LTS)
> - 6.6.y (LTS)
> 
> 
> Testing
> =======
> 
> We built and tested the 27-patch series against both linux-6.6.y (at
> 6.6.142) and linux-6.12.y (at 6.12.93) on an x86_64 machine with
> CONFIG_X86_KERNEL_IBT=y. Both series applied cleanly with zero
> conflicts.
> 
> Indirect test:
> grep __ftrace_invalid_address___ \
>   /sys/kernel/tracing/available_filter_functions | wc -l
> 
> 6.6.142 unpatched: 562  patched: 0
> 6.12.93 unpatched: 589  patched: 0
> 
> Direct test (bpftrace kprobe vs fentry on put_task_struct_rcu_user):
> 6.6.142 unpatched: fentry=0,  kprobe=46  (silent failure confirmed)
> 6.6.142 patched:   fentry=46, kprobe=46  (fixed)
> 
> 6.12.93 unpatched: Can't reproduce because of the non-deterministic
> nature of the bug expression per a kernel build.
> 
> ftrace kernel selftests (tools/testing/selftests/ftrace):
> 
> Kernel                      PASS  FAIL
> 6.6.142 unpatched   119     2
> 6.6.142 patched       119     2
> 6.12.93 unpatched   135     0
> 6.12.93 patched       135     0
> 
> The 2 pre-existing failures on 6.6 (kprobe_args_char,
> kprobe_args_string) are present on both patched and unpatched kernels
> and are unrelated to this series.
> 
> We are happy to assist with testing on additional architectures or
> stable branches.

Great, can you send the full backported, and tested, series of patches
to us with your signed-off-by so we can take them that way and we know
that they work properly?

thanks,

greg k-h
