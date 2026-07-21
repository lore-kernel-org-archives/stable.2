Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA80449B18
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 09:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784624846; cv=none; b=fmCFIeG1m1C9HLzHGorUegoBBXTKwek1sMtaPH6PEPHnNd9AlhrCVP8S377XGU5lbGHcZXuseSorPX9GIDnEOPCfGA4NQ3KHPufVoz4DjKGvHuDGrnNQxOzIf6UB+M7C7yovHbSfYvxGh7fecFsJyrzOztlrU3PNdbEROtGPN0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784624846; c=relaxed/simple;
	bh=ifO4L4MabZhWu1uSUKLnG+NNs1q6K9VNkEMHnBNk73I=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XFl/riPUmZRfq7Rb6n3U+yDfmFMVzSknqmeBk6NvcDKkgL+FwcBcyAW3iOaBJekhw9VxupHEberhTkxjiJzUXHHplQRdMznq4EpB/F4fnKVAzqba2EksVlgqxdEQJXK9HvylDZgZvvZqJmTnOFz2Pw6LVYgY11vWGshMP3uaiIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Da9Jqnbh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Da9Jqnbh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 507F51F000E9;
	Tue, 21 Jul 2026 09:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784624844;
	bh=PuMljIv6n/AI1KwWfUhUfwqgWwpVBMF3SFDfgySGf5w=;
	h=Subject:To:Cc:From:Date;
	b=Da9Jqnbh9TjGl92rMQxcG9v4InP+r6PTG8Z+UsXrKp0YmOyTPa+Q+lrVV0H/Y8kEP
	 0WP8eVKzmf36hbNDftk/a4BBpkBzfF1XbSTOvo4oL+Hv0WlJCVzHQgITeeJnpBkJcL
	 2e/kKxejg+IZNXbpg5h8pPL7ZoEQ4P9kKWE4PMBI=
Subject: FAILED: patch "[PATCH] riscv: probes: save original sp in rethook trampoline" failed to apply to 5.15-stable tree
To: martin@kaiser.cx,mhiramat@kernel.org,pjw@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 21 Jul 2026 11:07:07 +0200
Message-ID: <2026072107-deferral-sandblast-f37c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x bc7b086a45521a986a49045907f017e3e46c763e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072107-deferral-sandblast-f37c@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From bc7b086a45521a986a49045907f017e3e46c763e Mon Sep 17 00:00:00 2001
From: Martin Kaiser <martin@kaiser.cx>
Date: Tue, 30 Jun 2026 21:40:03 +0200
Subject: [PATCH] riscv: probes: save original sp in rethook trampoline

Reading a word from the stack in a kretprobe crashes a risc-v kernel.

$ cd /sys/kernel/tracing/
$ echo 'r n_tty_write $stack0' > dynamic_events
$ echo 1 > events/kprobes/enable
Unable to handle kernel paging request at virtual address 0000000200000128
...
[<ffffffff80016d16>] regs_get_kernel_stack_nth+0x26/0x38
[<ffffffff80177196>] process_fetch_insn+0x3ee/0x760
[<ffffffff80177836>] kretprobe_trace_func+0x116/0x1f0
[<ffffffff8017795a>] kretprobe_dispatcher+0x4a/0x58
[<ffffffff8013572e>] kretprobe_rethook_handler+0x5e/0x90
[<ffffffff80180838>] rethook_trampoline_handler+0x70/0x108
[<ffffffff8001ba32>] arch_rethook_trampoline_callback+0x12/0x1c
[<ffffffff8001ba84>] arch_rethook_trampoline+0x48/0x94
[<ffffffff8067872a>] tty_write+0x1a/0x30

In regs_get_kernel_stack_nth, regs->sp contains an arbitrary value.

arch_rethook_trampoline saves the registers from the probed function in a
struct pt_regs. sp is not saved. Instead, sp is decremented for
arch_rethook_trampoline's local stack.

Fix this crash and save the original sp along with the other registers.
Use a0 as a temporary register, it is overwritten anyway.

Cc: stable@vger.kernel.org
Fixes: c22b0bcb1dd02 ("riscv: Add kprobes supported")
Signed-off-by: Martin Kaiser <martin@kaiser.cx>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Link: https://patch.msgid.link/20260630194010.1824039-1-martin@kaiser.cx
[pjw@kernel.org: added Fixes tag; cc'ed stable]
Signed-off-by: Paul Walmsley <pjw@kernel.org>

diff --git a/arch/riscv/kernel/probes/rethook_trampoline.S b/arch/riscv/kernel/probes/rethook_trampoline.S
index f2cd83d9b0f0..c3aa8d8cf5af 100644
--- a/arch/riscv/kernel/probes/rethook_trampoline.S
+++ b/arch/riscv/kernel/probes/rethook_trampoline.S
@@ -41,6 +41,9 @@
 	REG_S x29, PT_T4(sp)
 	REG_S x30, PT_T5(sp)
 	REG_S x31, PT_T6(sp)
+	/* save original sp */
+	addi a0, sp, PT_SIZE_ON_STACK
+	REG_S a0, PT_SP(sp)
 	.endm
 
 	.macro restore_all_base_regs

