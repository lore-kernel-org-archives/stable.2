Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F3A547063;
	Tue,  6 Oct 2026 00:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791246961; cv=none; b=ChqmJ6j7xF+TJoimNp26FNAVQS+Rn6KX7CLCUuwYDuHW3yafxiC7Tl3l1xin3ROTZmd4AToj+9+UCA9BemMEVM/LEMJI2kDuQX53NuZFWLzEQEE5pk0jLO+yCnXZaAVxr139Ga+FMciqgC+fFBtRd2VxFp5fCz3z8wnFK6yaf64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791246961; c=relaxed/simple;
	bh=odOrJVLMB+K9LM5eJR8gNB/e7b1kPC6NeF/imDGxdQU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=l8HqLzv4sFYN5+YWTWmliUivaSGbyh0Iv45q5Eie/r2VIFm8tvqEFxV8ptuHnxGTpJ5EV7NkfisiLg2B0p/HSj+zF+T0S0APInYTTsNtjeXX5H8VRQ2TPRCv3ZIg5GQrn84xHbrqMjfricKjB0rbqIxXZUmUN1M3X1asNXOJmqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V8UDxbfh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V8UDxbfh"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B35A7C2BCC7;
	Tue,  6 Oct 2026 00:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791246960;
	bh=odOrJVLMB+K9LM5eJR8gNB/e7b1kPC6NeF/imDGxdQU=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=V8UDxbfh0yXx1r++VHxDZ5jN6Uo5Ayc+BZjQE/xglhkM8uiNhnV7eUJExm6N9Y+4J
	 AYt32r8jvyawGu6zX3e2YW9s8t+EyRMIWY+1rDOfoLNVPujeSef85VwP5B0HT45NFd
	 Me2Jk9dBC9eUZb4R9PifLNE0zvt9QdWDBejWWb9a63hgA5ckRu942xVTAkCDtYGOTx
	 lT+CjDAu6vfDFkVls8K0PG8YYE7Cz/rFEa6MQ1XrGVZpt5D8JUQvkNS1lEV7N1wBEm
	 GFr+3wlt0nrhQlOI8AE+VCenpWnY42Xeu8AdYWcYK9hUBD60tMgoRAhkqn3lVx/Rma
	 VjXSnXdas/k4A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF60CA5FFE;
	Tue,  6 Oct 2026 00:36:00 +0000 (UTC)
From: Gleb Pesin via B4 Relay <devnull+dormancygrace.gmail.com@kernel.org>
Subject: [PATCH 0/3] riscv: Fix xtheadvector vector status handling
Date: Tue, 06 Oct 2026 03:35:53 +0300
Message-Id: <20261006-riscv-xtheadvector-vs-v1-0-b00e5abc9f7a@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMSw6DMAxF0a0gj2spSfl2K1UHIRgwA0A2jZAQe
 ye0wyO9dw9QEiaFV3aAUGTlZU6wjwzC6OeBkLtkcMaV1pgShTVE3LeRfBcpbItgVKz90zqb+6q
 gBtJ3Fep5/3Xfn7/1205pf8fgPC/GcBEweQAAAA==
X-Change-ID: 20261006-riscv-xtheadvector-vs-8a31214a75e9
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Andy Chiu <tchiu@tenstorrent.com>, 
 Charlie Jenkins <thecharlesjenkins@gmail.com>, stable@vger.kernel.org, 
 Gleb Pesin <dormancygrace@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791246959; l=4130;
 i=dormancygrace@gmail.com; s=20261006; h=from:subject:message-id;
 bh=odOrJVLMB+K9LM5eJR8gNB/e7b1kPC6NeF/imDGxdQU=;
 b=QPD6LNYGDBvtkxi9gghnWz2zddGNUbFHXXTvoS81ov+I/c0YVyV8n6sYM7LEIquecQZ4jEJ9m
 m7pfqTocJUmDVxPbBd3LSE4WPO+IqBgJalSpZkSnzn/Huvcuf7Hxmd3
X-Developer-Key: i=dormancygrace@gmail.com; a=ed25519;
 pk=Ha8pk6XE0bhPh/mNtu1MKWgYqiX+CxZdhLyDR1rgD/M=
X-Endpoint-Received: by B4 Relay for dormancygrace@gmail.com/20261006 with
 auth_id=1121
X-Original-From: Gleb Pesin <dormancygrace@gmail.com>
Reply-To: dormancygrace@gmail.com

Since commit d863910eabaf ("riscv: vector: Support xtheadvector
save/restore"), cores with xtheadvector keep the vector unit state in
sstatus bits 24:23 (SR_VS_THEAD) instead of the standard VS field.
riscv_v_enable() and riscv_v_disable() handle that, but two other users
of the vector status still look only at the standard field:

 1. riscv_v_is_on() (patch 1), which __switch_to_vector() uses to
    recognise a task switched out inside a preemptible kernel-mode
    vector section.
 2. The trap entry mask, which is meant to disable FP and vector in the
    kernel (patch 3; patch 2 makes the vendor extension headers usable
    from entry.S).

Mainline has no in-tree kernel-mode vector user that runs on
xtheadvector, so patch 1 only matters for such users (out-of-tree code
today), while patch 3 changes behaviour on every trap from a context
with the vector unit enabled.

Testing was done on a Sipeed NanoKVM (SG2002, T-Head C906, VLEN 128).
Mainline does not boot on that board without platform patches, so I
used a downstream 7.2.9 kernel (PREEMPT_LAZY, RISCV_ISA_V_PREEMPTIVE=y,
RISCV_ISA_XTHEADVECTOR=y, no other in-kernel vector users) built twice
from the same tree and config, with and without these changes; the
touched code is the same as in v7.3-rc6. A small test module and a user
program that executes xtheadvector instructions were used:

                                                   without     with
 T1 riscv_v_is_on() inside kernel_vector_begin()     false     true
    (sstatus VS_THEAD = DIRTY in both cases)
 T4 timer interrupts taken from a user task that   12420 of   0 of
    keeps the vector unit busy, where SR_VS_THEAD    12433    12370
    is still set in the interrupt handler

Syscall entry was not affected in either kernel, because the syscall
path already turns the vector unit off when it discards the user
vector state.

A test that sleeps inside a kernel-mode vector section hung the kernel
without patch 1; with it the kernel survives, but the vector registers
are not preserved across the sleep. I do not think sleeping there is
supported, so I only mention this as an observation.

The series builds without new warnings (riscv defconfig plus
RISCV_ISA_XTHEADVECTOR and RISCV_ISA_V_PREEMPTIVE, each patch
separately, W=1 for the touched files) and passes checkpatch --strict.

The patches are against v7.3-rc6. None of them is in riscv for-next. Andy
Chiu's "riscv: optimize mode switch latency for Vector" v6 touches the
same lines:
 - its patch 1/8 removes the only riscv_v_is_on() caller in
   __switch_to_vector(); if that series lands first, patch 1 here can be
   dropped from mainline, but stable kernels still need it;
 - its patch 8/8 rewrites the entry mask under an alternative keyed on
   the standard vector extension and still leaves SR_VS_THEAD set, so
   patches 2 and 3 are needed either way. I am happy to rebase them on
   top of that series if preferred.

The issue was found and the fixes were first written with an AI coding
assistant (OpenAI Codex) while working on a downstream SG2002 kernel.
The mainline port, the reproducer and these changelogs were prepared
with another assistant (Anthropic Claude); the reproducer ran on my
SG2002 board. I have reviewed the patches and take responsibility for
them, per Documentation/process/generated-content.rst.

---
Gleb Pesin (3):
      riscv: vector: Check the xtheadvector status field in riscv_v_is_on()
      riscv: Make the vendor extension headers usable from assembly
      riscv: Disable the xtheadvector unit on kernel entry

 arch/riscv/include/asm/vector.h                  |  4 +++-
 arch/riscv/include/asm/vendor_extensions.h       | 28 ++++++++++++++----------
 arch/riscv/include/asm/vendor_extensions/thead.h |  8 +++++--
 arch/riscv/kernel/entry.S                        | 11 ++++++++--
 4 files changed, 34 insertions(+), 17 deletions(-)
---
base-commit: 67f0943b394d920b6c142aad8c6af94340342ae7
change-id: 20261006-riscv-xtheadvector-vs-8a31214a75e9

Best regards,
--  
Gleb Pesin <dormancygrace@gmail.com>


