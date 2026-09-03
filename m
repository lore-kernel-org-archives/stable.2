Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306DC44B69C
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 16:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788452456; cv=none; b=IlFf3j6chzLvuH+m5fgU+UbS2B+GjHBJ+8+Y2mePtJ+/1EnacWPIAT2A8TBgxtGG1mxexqTKkXgAqnTAM/oVr7n8TmssD7wXZ5P9Rc2lkQum6zNq8FvoPlm8mykrRQNg3jud7JUcn7JYyONcU0HSPyX4DQbsEyWX7GT7GiVdVM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788452456; c=relaxed/simple;
	bh=pkOVY+rOFwhayuhQUynax0s+TTxHBzjKY1U+GdjwiM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JKovEPtZXOcoqupg1IZuUQo+2vWG9u8DYXY6wrAidU9TnnAQgnvo5QTLULDJonMHJ19QMVqvdwCyiFVE2hXvbrvkmTYYxUE+X8mm/yCmxOxcngzttEXOx+vQM0Kfj/4iFa6jfqwwTUFT+qwkeSfRf6uPI4gvlmFmkzxdHMZ2UUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bGvzLm7k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bGvzLm7k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46DDB1F000E9;
	Thu,  3 Sep 2026 16:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788452453;
	bh=9BsN+SFWewNj4VZMXGi8K9jcoKyqMbRmUQ3aar2GqPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bGvzLm7kCDtNqttOrLrsxS6J87jInLRhB45znJPCJvy/XQeug/jrlwB2x7SHN0u99
	 LuEDbQyBn+krvueBW+RIRMCM7hvxxFz0qlBjyMC1LAAQORy0+21Ts/18VVOOKtPDfp
	 AJSYEOl1/CgRc5W87Uf4dgVqxj+hhXwY8AmzlYMpWTPMLHdhpU50SuNCDUvVcd8Qbl
	 tAE+4g6bEMnvzuwbzoqj3ggyXDVtSh07jnbvgoM1CH8td5xdPd9Jzjgq+2IvWgiVs3
	 xhhGQWRR1owD/Ptj0nOAZMhV55iN8wBFPoKP8pVnkLHgYqZIuWsE+Bdgs1yWVjqd/O
	 DXGdX258KoNww==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.ams.internal (Postfix) with ESMTP id 7561F198006E;
	Thu,  3 Sep 2026 12:20:51 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 03 Sep 2026 12:20:51 -0400
X-ME-Sender: <xms:Yp6Zaibuaa6Sqyj1zSQGCksYF8y7LEY_OG99pHN5fQZk6v-QkOAHcQ>
    <xme:Yp6ZagWpSH1xjvN0SJ6Z7Nd7aFQzRIvzqy3FNaINTfwVvGVcd7xNeyYtocPVAlomP
    x0oea1FVkFAsZfCDNAZp4KRBiRXhmt_u2eudYTeYe8O-l7XBubFeFebXw>
X-ME-Received: <xmr:Yp6Zar_rbtRrJtgUERjBguKl9D1R82O5Hyr4ePcY7DKJ4794BXhQkypSA3g>
X-ME-Proxy-Cause: dmFkZTEmtPCeWfWCgcVgl36IQTvGnpiboPiJ+fe2aGcwIl9J54Mx6OVyJV/YDxrlB/1HDd
    X2M9+Oy8MbZWDXIenOlYCG/S1M1ROlh20Kc3QeSkzJxMufRyWBa+inirEi1GNCYuacfUCt
    m+B9A26YT6Q13YoZ1fhaq6lpcG01Nlj5M5J3Rk7stpXf3TsmEUSEyvpzRONPQlr6FpZu9k
    bwu+Cn6HP5Cvkyox+0ec4JMflJ4WuMrpaRfRxuzczSAqfPcO9NrnodeFUjo61C+W1dFDTl
    bK/6M/uV+YlYz/hDvwFiI6MHNozoiYhDFO1Z+i4+nmu90py9ji9OC85FyypSO5XnQFSphS
    IP5s8hI+SfXQeucBNPpoyVVc5+JNRFakHUqy7fWPMUq+U9AzgPGdehE77cTpUBW7EywoGr
    U3exSLqLry/lg+cm1NbS47f1zneI4emBJcd6KALXlGiFMU8cG78MZ/gjhjdZe7/OLyqpGZ
    9QL64YV4f1a8N9Bj+2HItItG1sVqiTtl/IHgpU07GqmCC6Fkhk1uWqrvyMsjjvrdJT6Jwb
    sNBaq8es09eql2FwguRRiSvjYxCuMjDl+/p6uYoy1+QDe3itU1/YVsR0s/4SUpR7dusPzM
    uY4pG1+tFC3zxnAUPzR2p/CvwPkTXP2LObO9jSBx9WZ3q49zAtvcxBalE/YQ
X-ME-Proxy: <xmx:Yp6Zap_-6Q_aoB67Pt2YNgguqnPjuJ7Mtw-YLvBKbJSlj65V87WkEA>
    <xmx:Yp6ZarQfPImCk_wNaDBG4gqBHy1Pqc0sgxU6cCslEP5-GjbskhSgdw>
    <xmx:Yp6ZateltFOUwvrPPLyJxHDeyGRE4zOP-6IVB6oV4A5Pi-Qc4j7zpA>
    <xmx:Yp6ZavCa0oymCxK4XgjmmXQAsxcGB4V02LD1kzR2FJYoUCGopXmaCQ>
    <xmx:Y56Zavn3bHQk4Lm6m21FOl0WAFB-uT7i9FUCY_HB7Tzkn1mKN7q9Zxss>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Sep 2026 12:20:50 -0400 (EDT)
From: Kiryl Shutsemau <kas@kernel.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Borys Tsyrulnikov <tsyrulnikov.borys@gmail.com>,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>
Subject: [PATCH 6.1.y] x86/tdx: Fix zero-extension for 32-bit port I/O
Date: Thu,  3 Sep 2026 17:20:49 +0100
Message-ID: <20260903162049.584007-1-kas@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <2026090347-doze-watch-fde3@gregkh>
References: <2026090347-doze-watch-fde3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>

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
(cherry picked from commit 941370fc93cc3474e26811f4d3b062903eefe2cf)
[ kas: adjust for the __tdx_hypercall(&args, TDX_HCALL_HAS_OUTPUT)
  calling convention in this tree; no other change ]
Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
---
 arch/x86/coco/tdx/tdx.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index a896d2d6f21f..2f42892b456e 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -462,8 +462,8 @@ static bool handle_in(struct pt_regs *regs, int size, int port)
 		.r13 = PORT_READ,
 		.r14 = port,
 	};
-	u64 mask = GENMASK(BITS_PER_BYTE * size - 1, 0);
 	bool success;
+	u64 val;
 
 	/*
 	 * Emulate the I/O read via hypercall. More info about ABI can be found
@@ -471,11 +471,9 @@ static bool handle_in(struct pt_regs *regs, int size, int port)
 	 * "TDG.VP.VMCALL<Instruction.IO>".
 	 */
 	success = !__tdx_hypercall(&args, TDX_HCALL_HAS_OUTPUT);
+	val = success ? args.r11 : 0;
 
-	/* Update part of the register affected by the emulated instruction */
-	regs->ax &= ~mask;
-	if (success)
-		regs->ax |= args.r11 & mask;
+	insn_assign_reg(&regs->ax, val, size);
 
 	return success;
 }
-- 
2.55.0

