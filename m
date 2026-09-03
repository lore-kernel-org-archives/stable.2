Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4326B311968
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 16:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788452458; cv=none; b=VCWgyIvT1hZyaKpMvDfXOcOAoDRjIcAIFRZ/YHmz3yyVf+W0EVIXina5NAF1DuQek7BkRuFvocyVpuMhAOURmssSkIGrv6p1gHdfRWAFdQdXOIrQ757ARGQTnPxyR7BFhIFxbu7Nolblh27DuTHj+p1bF8gGzaiwJQs/L5xD02Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788452458; c=relaxed/simple;
	bh=T7Wm8vHwOlDqz8DgcuAS2mfupyuXLgFnAPKUzbxfHMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XeJlex3zNWeSO3/4KID6c+mWIzWmnjqwrHJPvYVfXKkXzZg44qKyM+cr2Vcpxma+T56p6s+1XVByhq11QQ/GH3DskVB5YiYOSMU1Q4sZynjYxkSRfKBD62zYkZmapTtdENEViUZWxq3gLbMgAuYc3n16KBn8zPNGGNiK1NgAVFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBn+oJUP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBn+oJUP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22C491F00A3E;
	Thu,  3 Sep 2026 16:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788452456;
	bh=CXgbnf68zV/8DJXLulOlsO2tYJWIy1c6CCULwHp3UDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eBn+oJUPT+lZAltoc/YOxjVrIRSQM35IQn8XCQdj6ae+bC4//NQ1VX+HrAvqLHIdP
	 j50f61cFB399wkn8q48qh69xysW3CYA3Fw5HWv+rdWGokoBnlJcUDsfy1tQINGRNFA
	 eu9rscXz8K8v//wSxcI8+RuFTYc7bOpI9yysCq137MSuEbqnIxbJs7/BEw3MjO1q3Y
	 9NpV/K6XS8vAnTPXoeVRBQemI/JAPIpReH5maqf4iSbSqqWiLMbqCf47JkKUMXfQLz
	 eN4aLXZ8ah5w9cjgFGEBAmxeoxekeguaFAFQmHuog3kx0gsy35LnizMwcbfB0ILdFT
	 zusV8pstZ4ztw==
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfauth.ams.internal (Postfix) with ESMTP id 65541198006E;
	Thu,  3 Sep 2026 12:20:54 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Thu, 03 Sep 2026 12:20:54 -0400
X-ME-Sender: <xms:ZZ6ZagIboJRcXbVT5ogccP5gCOa_Vk31VzKbvLRywqNCuKEcNove8w>
    <xme:ZZ6ZarFqd1G3HCxDwkfTKlbPSZ3EBqwfXtFBRtJTfoIbe0AhjwRDGywLndoISh0dh
    6WoCdbaxctRPJfBf7haMVrj6xeZcAb9NlasgtQPZJYAofRVSis3dEOp>
X-ME-Received: <xmr:ZZ6Zavvp5-CgQHjezO7yYrGz7uvxlWkAuJzGnlHE3emoKsdBaq0FJjtWx_4>
X-ME-Proxy-Cause: dmFkZTEmtPCeWfWCgcVgl36IQTvGnpiboPiJ+fe2aGcwIl9J54Mx6OVyJV/YDxrlB/1HDd
    X2M9+Oy8MbZWDXIenOlYCG/S1M1ROlh20Kc3QeSkzJxMufRyWBa+inirEi1GNCYuacfUCt
    m+B9A26YT6Q13YoZ1fhaq6lpcG01Nlj5M5J3Rk7stpXf3TsmEUSEyvpzRONPQlr6FpZu9k
    bwu+Cn6HP5Cvkyox+0ec4JMflJ4WuMrpaRfRxuzczSAqfPcO9NrnodeFUjo61C+W1dFDTl
    bK/6M/uV+YlYz/hDvwFiI6MHNozoiYhDFO1Z+i4+nmu90py9ji9OC85FyypSO5XnQFSpW9
    7A6Pmz6V+YUMbRC42NJdGcgyl42awpUxpak2ZMje/0y8m7PC2ceTZMLBWjTDDSQaVw2Bzd
    qZ1OP/b31NBWUsaVN/qlvJjZ2y7VG8pD/3qdRNjR1gqRXJDOB4foasNBw72RmAo1YAIiJm
    7H3CSjxNwx+vjq3M9Ru5bPe7RVmEX1PqWuxfn0V86IkAwtsh9Kf7WACWMhTHLZ3UU0SiU7
    Ma4VxWv+jhqSPoMiSM/rLCfQR2pqIGavBdp7U+0paZbOGQjfH2JV2XP6+a+55vB1HIiPib
    IyGrbKSNWnDMX8kuFe6TG7z3SGC9+2BsadU+7UGEiVO70VABKGzNAAFn+Guw
X-ME-Proxy: <xmx:ZZ6ZaismKHudQk9i1sXUnYSJvRQbJzHNkHGmFk62jaMVCX82pd2Yyw>
    <xmx:ZZ6ZalC-SufO0jz5z42By6Zohc3TYheNEBQ6o1e_Vy2qafU9e5huOA>
    <xmx:ZZ6ZakNWPgJnCluR_r-JuyvKj0dLz5VjJzx7eDkzaFIo6owWCv7puA>
    <xmx:ZZ6ZauzAg914k5PYHEPzFXzshLnhLGSqUteO6OrZAUJwAdOBhDV11g>
    <xmx:ZZ6ZakWMSoSacqI2DaiYv4B-uA4R61Puqls21Nqs8CvysJ0akfYecv4l>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Sep 2026 12:20:53 -0400 (EDT)
From: Kiryl Shutsemau <kas@kernel.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Borys Tsyrulnikov <tsyrulnikov.borys@gmail.com>,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>
Subject: [PATCH 6.6.y] x86/tdx: Fix zero-extension for 32-bit port I/O
Date: Thu,  3 Sep 2026 17:20:52 +0100
Message-ID: <20260903162052.584017-1-kas@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <2026090346-annoying-rocking-46d3@gregkh>
References: <2026090346-annoying-rocking-46d3@gregkh>
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
[ kas: adjust for the __tdx_hypercall_ret() spelling of the
  output-returning hypercall in this tree; no other change ]
Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
---
 arch/x86/coco/tdx/tdx.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index de56b69a0c27..504923e2f012 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -580,8 +580,8 @@ static bool handle_in(struct pt_regs *regs, int size, int port)
 		.r13 = PORT_READ,
 		.r14 = port,
 	};
-	u64 mask = GENMASK(BITS_PER_BYTE * size - 1, 0);
 	bool success;
+	u64 val;
 
 	/*
 	 * Emulate the I/O read via hypercall. More info about ABI can be found
@@ -589,11 +589,9 @@ static bool handle_in(struct pt_regs *regs, int size, int port)
 	 * "TDG.VP.VMCALL<Instruction.IO>".
 	 */
 	success = !__tdx_hypercall_ret(&args);
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

