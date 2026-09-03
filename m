Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBE94AD4AB
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 12:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788439653; cv=none; b=S19fCt23bXnawYtdATCaCy/lb5lq8pNEID4/vYVVdqDlvpmJ42nLuhwSic+XOXFMLJyjc12ABuzIRgfeYrYrHa/mC9UK/A6hIBWW+7Upl29KfkB/s/j6+zyxuLNcKOYlJKi0vbHdxATH2oQwCIGTQuxS07o5PLZye+6vpUXEhO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788439653; c=relaxed/simple;
	bh=0qYKJ0y1PJx1AQ4vesorjmSj073FLH58XEsqp/3OmdM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Qbw81EnEJLuN7FCZP60g4MvgA8/+lca7sF2e2KJZZuVlnnePdL5nFzn2zBEtHFZiBHQwjSl6c1LuWqQ1qXMXCwde0wfUoi4zhfAs02/UyRbdfaV5rVRkveq98W4cN9C16ubHrD9Np/LIYDTLCSyoK9PcYKy/u0vt7iWx+R5Qb0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=i6OztvEo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i6OztvEo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 541AA1F00A3A;
	Thu,  3 Sep 2026 12:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788439651;
	bh=+OLVKEYB9ZBsoH1n36cul4o7PZsR9NTz+HFMTDYgg60=;
	h=Subject:To:Cc:From:Date;
	b=i6OztvEoscGCkq95ywwhhZzwkbAqTWVVaYzh+KL6PBZDI8Rpm9V8RSIuPM4Xo+lh2
	 qs5F+N5s+0qNN3MU0smjA4gaVZW3yAAp7doIPheG/lnv5jH2/htCGioQYtiKUPOrlZ
	 qcjq5WtJj5kyA7eamRlrnMw2B7FCMNn0XhuB5Gu8=
Subject: FAILED: patch "[PATCH] x86/tdx: Fix zero-extension for 32-bit port I/O" failed to apply to 6.6-stable tree
To: kas@kernel.org,binbin.wu@linux.intel.com,dave.hansen@linux.intel.com,tsyrulnikov.borys@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 12:53:46 +0200
Message-ID: <2026090346-annoying-rocking-46d3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 941370fc93cc3474e26811f4d3b062903eefe2cf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090346-annoying-rocking-46d3@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 941370fc93cc3474e26811f4d3b062903eefe2cf Mon Sep 17 00:00:00 2001
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Date: Mon, 13 Jul 2026 14:37:53 +0100
Subject: [PATCH] x86/tdx: Fix zero-extension for 32-bit port I/O

According to x86 architecture rules, 32-bit operations zero-extend the
result to 64 bits. The current implementation of handle_in() only masks
the lower 32 bits, which preserves the upper 32 bits of RAX when a
32-bit port IN instruction is emulated.

Use insn_assign_reg() to write the result back into RAX with proper
partial-register-write semantics: 1- and 2-byte forms leave the upper
bits untouched, the 4-byte form zero-extends to the full register.

Fixes: 03149948832a ("x86/tdx: Port I/O: Add runtime hypercalls")
Reported-by: Borys Tsyrulnikov <tsyrulnikov.borys@gmail.com>
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Link: https://lore.kernel.org/all/CAKw_Dz96rfSQc6Rn+9QBcUFHhmkK+9zu+P=bxowfZwxrATCBRg@mail.gmail.com/
Cc:stable@vger.kernel.org
Link: https://patch.msgid.link/20260713133753.223947-4-kirill@shutemov.name

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index b8bbd715fb62..f904a636d449 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -694,8 +694,8 @@ static bool handle_in(struct pt_regs *regs, int size, int port)
 		.r13 = PORT_READ,
 		.r14 = port,
 	};
-	u64 mask = GENMASK(BITS_PER_BYTE * size - 1, 0);
 	bool success;
+	u64 val;
 
 	/*
 	 * Emulate the I/O read via hypercall. More info about ABI can be found
@@ -703,11 +703,9 @@ static bool handle_in(struct pt_regs *regs, int size, int port)
 	 * "TDG.VP.VMCALL<Instruction.IO>".
 	 */
 	success = !__tdx_hypercall(&args);
+	val = success ? args.r11 : 0;
 
-	/* Update part of the register affected by the emulated instruction */
-	regs->ax &= ~mask;
-	if (success)
-		regs->ax |= args.r11 & mask;
+	insn_assign_reg(&regs->ax, val, size);
 
 	return success;
 }

