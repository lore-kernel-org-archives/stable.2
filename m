Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFA930DD2F;
	Mon, 20 Jul 2026 09:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784540040; cv=none; b=AIhA9g3p85I5m04T+zlASxdTpXzCR9XSQd0tWCGh8fpAWKgLdVgexKTXtNBb9IcbrS+KjPHQPw5J2YgEo3KmOZk+1shzPFCGKLzyQrOIayzfHJti3dF0mdLh13uCQs+XahUuugtr+THh0A2tR4c3TAIBPSeLjOcqYGQ3/3lKNu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784540040; c=relaxed/simple;
	bh=GUeN9dHieuYG+yyaxuSbwHPegRQEq5n2SNXT4eMbQKo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kQBASkHHRhxqDaBeVzwCCzAY3cfulfa7dahiRqpQvu3f3Hmvws9hdnXpwqZjlYCDIKkVPrDFD2ZTIHzgm+kIDXAOrk9hnYwvOlaSG2qGNCcwraeVpiJbmRcSArP3xdXmg1lEOCIjjuxcI8Q6uHPt9MyadvjinPMcTHV5ianmuHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PaPQZpT9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PaPQZpT9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D03B1F000E9;
	Mon, 20 Jul 2026 09:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784540038;
	bh=+9PXAdO2UaKVPzoZ3fyXMbuva8Rkou9JBquEiugdjeY=;
	h=From:Subject:Date:To:Cc;
	b=PaPQZpT9AypcLIyTPiymUQ9bR4BxLN5723OTJO2Hy94rYPFYShPcgTZTrEhUlwnZN
	 0rkzwmu/Jxve/MbklLs4iksRScglZr+9b8ldkM8hTk5O4C9dg9KG0uVqKCEsoYAn41
	 iiOj6L8+wZIxxrBWAzwky3/Ch7PxR1WOgdctVBRjfurPqwnjjDXjvDTGlJbabcvhtv
	 G9BwGGNOqBGC0l651Cx9gnBseDqOQFulTRO5UBZkIe+TsoJR5ugUXA12ntH+ybmZt0
	 Bd4KQEUDZx1lJZZ3tZyBy4KsShy9W9yZdBqlE7TtH8ZLJ2IOTmvEZr3bBaMqLV4o7Q
	 HEyO1/9X9FaUg==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 00/21] binfmt_misc: transparent interpreters and PT_INTERP
 loader substitution
Date: Mon, 20 Jul 2026 11:33:23 +0200
Message-Id: <20260720-work-bpf-binfmt_misc-ptinterp-v1-0-ddb76c9a508e@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGTrXWoC/yXMUQ6CMBBF0a2Q+XYIYFKsWzHGtHUqo6E0nYomh
 L1b5PO+vJwFhBKTwLlaINHMwlMo0R4qcIMJD0K+l4au6VTTtxo/U3qhjR4tBz/m28jiMGYOmVJ
 EUkRae6+sOUExYiLP379/ue4tb/sklzd0e1gjhDaZ4IZtmr1gXx/rXYd1/QGWS9xDogAAAA==
X-Change-ID: 20260719-work-bpf-binfmt_misc-ptinterp-e6ee99ff6ba8
To: Farid Zakaria <farid.m.zakaria@gmail.com>, 
 linux-fsdevel@vger.kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>, 
 Alexei Starovoitov <ast@kernel.org>, Kees Cook <kees@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org, bpf@vger.kernel.org, 
 jannh@google.com, mail@johnericson.me, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=5288; i=brauner@kernel.org;
 h=from:subject:message-id; bh=GUeN9dHieuYG+yyaxuSbwHPegRQEq5n2SNXT4eMbQKo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTFvm6MrXjC+ffp8wl93Xw+x3ZrLDeanLL4/d5/axzq7
 m/esrrvfUcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEOKYzMjQLLfzjOuPTxtWW
 LB9cqw3fusbILbf4u/D7mXPbN1kvVqli+CuZ9oxx0n+t2UcvnSqerLMlNr9j9ZeLR4t6jgv7trC
 eEmUEAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

binfmt_misc has exactly one execution model where the registered
interpreter becomes the executed program and the matched binary is
handed to it as an argument. For wine or qemu-user that is the point.
For a per-binary loader it is backwards. The interpreter is an
implementation detail of running the binary, yet it owns the entire
process identity:

- argv[0] and /proc/pid/cmdline show the interpreter invocation, not
  what the caller executed.

- /proc/self/exe names the interpreter. Relocatable programs commonly
  locate themselves through it and find the dynamic linker instead.

- A binary passed to execveat() as an inaccessible O_CLOEXEC fd
  cannot run at all as the interpreter has no path to open it by.

- gdb cross-validates AT_ENTRY/AT_PHDR against the exe file and
  discards the load displacement on mismatch leaving PIE symbols
  unrelocated.

This series adds two dispatch modes that close the gap from opposite
ends:

(1) transparent dispatch

   Registered with the 'T' flag or chosen per exec with
   BPF_BINPRM_TRANSPARENT. The binary travels through AT_EXECFD, the
   argument vector stays exactly as the caller built it, and the kernel
   labels mm->exe_file and comm with the binary. A new aux vector bit,
   AT_FLAGS_TRANSPARENT_INTERP, is raised indicating that nothing
   was spliced, argv belongs to the program, and to load it from the
   descriptor.

   The interpreter keeps control of mapping the binary, so the mode
   covers foreign architectures and non-ELF payloads.

   The exe label is not a new privilege. It names precisely the file the
   caller passed to execve(), not a file of the process's choosing. That
   file is permission-checked, write-denied while the process runs and
   recorded by audit. Credential derivation does not change exactly as
   today.

(2) The second is loader substitution. The kernel executes the matched
    binary natively as the main image and substitutes the registered
    interpreter for the loader named in the binary's PT_INTERP.
    binfmt_misc stops meaning becomes a PT_INTERP override. There is no
    contract and no identity to reconstruct, so a stock dynamic loader
    works unchanged. So 'L' is for native-arch ELF with PT_INTERP. The
    modes compose. A bpf handler reads the ELF header from bprm->buf and
    grades per binary, picking 'L' where it applies and 'T' or classic
    dispatch for the rest.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
Christian Brauner (21):
      exec: do not act on a stale execfd request without an executable
      docs, binfmt_misc: keep general usage out of the handler sections
      binfmt_misc: table-drive the register string flags
      binfmt_misc: normalize the per-exec invocation flags
      binfmt_misc: split out entry_open_interpreter()
      binfmt_misc: split out build_interp_argv()
      exec: release the replaced file with do_close_execat()
      exec: add AT_FLAGS_TRANSPARENT_INTERP
      exec: label mm->exe_file with the binary for a transparent dispatch
      binfmt_misc: add transparent interpreter dispatch
      binfmt_misc: add a static transparent flag 'T'
      binfmt_misc: let a bpf handler run the interpreter transparently
      selftests/exec: convert the binfmt_misc bpf test to the kselftest harness
      selftests/exec: test the transparent binfmt_misc mode
      binfmt_misc: document the transparent identity contract
      exec: carry a PT_INTERP substitute in struct linux_binprm
      binfmt_elf: consume a stashed PT_INTERP substitute
      binfmt_misc: add the 'L' loader substitution flag
      binfmt_misc: let a bpf handler request loader substitution
      selftests/exec: test binfmt_misc loader substitution
      binfmt_misc: document loader substitution

 Documentation/admin-guide/binfmt-misc.rst          | 159 +++++++--
 fs/binfmt_elf.c                                    |  20 +-
 fs/binfmt_elf_fdpic.c                              |   5 +-
 fs/binfmt_misc.c                                   | 311 ++++++++++++------
 fs/binfmt_misc_bpf.c                               |  18 +-
 fs/exec.c                                          |  54 ++-
 include/linux/binfmt_misc.h                        |   8 +
 include/linux/binfmts.h                            |   9 +-
 include/uapi/linux/binfmts.h                       |   7 +
 tools/testing/selftests/exec/.gitignore            |   5 +
 tools/testing/selftests/exec/Makefile              |  30 +-
 .../testing/selftests/exec/binfmt_loader_payload.c | 196 +++++++++++
 tools/testing/selftests/exec/binfmt_misc_bpf.c     | 362 +++++++++++---------
 tools/testing/selftests/exec/binfmt_misc_common.h  | 146 +++++++++
 tools/testing/selftests/exec/binfmt_misc_loader.c  | 363 +++++++++++++++++++++
 .../selftests/exec/binfmt_misc_transparent.c       | 108 ++++++
 .../selftests/exec/binfmt_transparent_interp.c     | 130 ++++++++
 tools/testing/selftests/exec/loader.bpf.c          |  56 ++++
 tools/testing/selftests/exec/transparent.bpf.c     |  57 ++++
 19 files changed, 1748 insertions(+), 296 deletions(-)
---
base-commit: 34296289b1a63a5394271b4e35918d3c9ad530dc
change-id: 20260719-work-bpf-binfmt_misc-ptinterp-e6ee99ff6ba8

