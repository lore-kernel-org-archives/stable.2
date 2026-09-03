Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2144AD7E9
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 12:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788439656; cv=none; b=qP3bmHLG2i8jSr2OP4Tlz2ntRoTeCeBf5shEO2PyYB4Qy8PwDINcXd0ExykYq+lhytd3XHjR/N243yQpEu+MEpiroKju2GXnTwWyk3zw4o0LUsPr4wHD+kB4UBGJgxIIfiCmyU6+72tTdnN9UoyElipCtxwII1+K4Xz34CDoGQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788439656; c=relaxed/simple;
	bh=lnjC3eSeNWATndRJ9k1qpe4fGxG8mIRkk72rM0Ddv4g=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=t3UcdMZRy8F8Qnx/s56xujDfatDhbiN7lDyot5JCCXWRgvyGYzfKBAUgPmDR+aLRZ7/Shn4ivTvbfknQbnIE7PyxgNor5G29gDfuH9k7aLkrODyobkDqBHryvS7KYiU2bexgLEuQ6iuS8ReBZgVk9w9cJp4FQqN5ZjWEnL73uuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SPnjEEtV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SPnjEEtV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 357751F00A3A;
	Thu,  3 Sep 2026 12:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788439654;
	bh=966pchirYgA+MqtqGNVavvHMOE67xSS2rChB8WnIuBk=;
	h=Subject:To:Cc:From:Date;
	b=SPnjEEtVvL0LNfhaCzYvgg//MygWia7bGx8dIucFX7Rrd31Vpg84ZQygv9+KENZh0
	 NutEpIPyjQrpmo420vdG4YaaLuMkni9DDv2mWofmnOZMDTZTUryyDrCfdTRlVKCYn4
	 po+6w7U8pM3ltqjZAin1GIK7FJDzmLKW9QLbvvEI=
Subject: FAILED: patch "[PATCH] x86/tdx: Fix zero-extension for 32-bit port I/O" failed to apply to 6.1-stable tree
To: kas@kernel.org,binbin.wu@linux.intel.com,dave.hansen@linux.intel.com,tsyrulnikov.borys@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 12:53:47 +0200
Message-ID: <2026090347-doze-watch-fde3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 941370fc93cc3474e26811f4d3b062903eefe2cf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090347-doze-watch-fde3@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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

