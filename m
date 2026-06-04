Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F05C30649C
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 14:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780584438; cv=none; b=fl1plLXxGbogXgY20ntLofpCdJrTGhNpIJ8dZr376HfjJDd/3QJ9rKU8R7tUa0Z41aoI1Iqi9DnL9nIHJZqs7NL4F2M6MHx8n1hwPUiyo4vBHEq0HyFcLWIG/s8eqldEVQhcKb4b+QMe488GTD1JPz456wPwWIbQFG2efj8e6ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780584438; c=relaxed/simple;
	bh=RL31Gfg1eTNY6OHuTS5TeU5WfcxL4Weqp9TpWAfAUpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r2CqnF+apLxPvSmoqNTos8hfo3+2JJjfXqhuv3JTWhZSbWewEsQqGhXWtVNnx77HroeQ+oAWrTEjX8gyDHCdtfgwLXWvcW1qY8SCTlDGc45hqFva2acQEn2JxmHKRLyEEwOVDfd1L6OCNiVCFCLTq9/cy/GUFUEGn/iRftlwtLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HsMA/eKo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HsMA/eKo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A660B1F0089B;
	Thu,  4 Jun 2026 14:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780584435;
	bh=BJNiAhUi1JSZBSURTg09310Ft25YHyhdAoc13ntBPJE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HsMA/eKoYs0mem0vIicbQeYx0RYO18o6beKHfNDIX6FWHit4NpunspjUPPukemiRy
	 0Q713MyDJIb2bOGDb+ca+obt+IoY6mVK43ljgd7aOavoGIqFenVTD/mZiK0A7o8IvR
	 aGzV0k7AFb17M/pLjMSmjnkGVn34vgtbRp6wWMGnan3/DVs9yOgun5N8ZZTM8JbGkq
	 IYFv1poJc9r0HW/BIkMILVALE8X0z9TYUXbUVnU75kkDmVf77RVuy8ul37QQ+LFNoP
	 BoAPfedcwwK5X7vc+QVBSpneVBk28vwxa2zN3OuV7I/6M/Z2Jvkc5c439jetqtrVI6
	 M4xRTOl1kg4PQ==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 033EFF40079;
	Thu,  4 Jun 2026 10:47:14 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 04 Jun 2026 10:47:14 -0400
X-ME-Sender: <xms:8Y8hakKVfbM92Usf1GsmtEk9Fw4fJ3AFPGntlAvHBDCYEWBBF7yTsA>
    <xme:8Y8hahUwoiskUVoZaMkyu-Iagz1VlrdcdfhJZrVnOoKwQIxz3NXRyMZFFdTiKU5Gp
    EbGzbGhwULiI12O0OvfSfCtbQxCu-toSbfpYoHb9sioYqmIV-zn>
X-ME-Received: <xmr:8Y8hapPPVMzqMsq6XCuGbHeZCQ4K8i8I4e58Dclr7YCE3NQ56zLJjjg0FA51cg>
X-ME-Proxy-Cause: dmFkZTEnbxOoIv6tM0dLsEuDtk1qDKvd9SBoRk315SFIs+8A8nvG6NPaTuTHtWxX09pQd2
    kmhZQJAFXIZRoG2uwqXsCvSQLHHFyqPBLRlgDZDOM1R+77uRHXsLwpqHqkuB/xQMEeL5H9
    Yh7j9EoCepX3S8oxsk0Q7b1XMMuXVtxHCUg4Aa5UHd0TkOkqN6exGRI2HWKvJ5gzF66+CH
    9fJySW0myPH7lfp6BMxlzjyNHqw9L6PwmZLSyt1okrlhfToPVERjX7lBHt/jPkXvBx/Qrl
    D5naZubOYqFywyiARe2ZjFKnu+RDowAinYmgXtLtTezD1qxkQqUbpHifL2f+9hFdA0KVND
    GXf7G3DsuFo4qYNje9KnNs2ve3hDdGpDonI7au6HfLD7L8B58SLnTRkAK3zMOZJb8zIVVR
    qrjGRYiQ7qv1RaaZnF8UokegdOD59s1RcKkd6SHBk2G27FWTTHpsH7ahhm708iwZeycsQ6
    baQpQOfcAa878UOJTpb8JYkopMIHV/85qKYNeW5iSsXfDdpDL99//ujKHD2rDXQwEt0PSN
    vzJMrGhjqDn8uaH0Tcy+xm8nvQp8B20Tj88TCgXezk+nE2asDc8kMTuMNPa1yhm4HCTw4u
    EG5nYPL137xe+9P4+/wNPgeZz/yg1Hsyf7rXOVyptwAsXc2OKFgPgXZ4IbWA
X-ME-Proxy: <xmx:8Y8hatl65x2uV6jl8hwy6dcEtDz-lgHUKpXF6qhE2nU9QPk_6Q_RSw>
    <xmx:8Y8hasUpvIhCP_W-JrUEL_aO15KrXaEFN2Q8uK_8YHH0ggUF2GzDRw>
    <xmx:8Y8hasJtUmMw5Zyodsy0s9wrTwdbqWr-KIkxrcW70gxA22Hrifkobw>
    <xmx:8Y8hagakh5Gbt4AFfjPDdryPhdBWL4lqf8s4NCCs1dFOBce0TuJUnw>
    <xmx:8o8hagQu9z933pQbL-OhLP90sR6duVAQTZE1lftqwj7QDdTmzcKwIp2G>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jun 2026 10:47:13 -0400 (EDT)
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
To: tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com
Cc: seanjc@google.com,
	pbonzini@redhat.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	kai.huang@intel.com,
	xiaoyao.li@intel.com,
	binbin.wu@linux.intel.com,
	rick.p.edgecombe@intel.com,
	david.laight.linux@gmail.com,
	ak@linux.intel.com,
	djbw@kernel.org,
	tsyrulnikov.borys@gmail.com,
	x86@kernel.org,
	kvm@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v4 3/3] x86/tdx: Fix zero-extension for 32-bit port I/O
Date: Thu,  4 Jun 2026 15:47:01 +0100
Message-ID: <ca503ae3de72d90956fcaf5dbc0760ec20f5a5e0.1780584300.git.kas@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1780584300.git.kas@kernel.org>
References: <cover.1780584300.git.kas@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to x86 architecture rules, 32-bit operations zero-extend the
result to 64 bits. The current implementation of handle_in() only masks
the lower 32 bits, which preserves the upper 32 bits of RAX when a
32-bit port IN instruction is emulated.

Use insn_assign_reg() to write the result back into RAX with proper
partial-register-write semantics: 1- and 2-byte forms leave the upper
bits untouched, the 4-byte form zero-extends to the full register.

Fixes: 03149948832a ("x86/tdx: Port I/O: Add runtime hypercalls")
Reported-by: Borys Tsyrulnikov <tsyrulnikov.borys@gmail.com>
Link: https://lore.kernel.org/all/CAKw_Dz96rfSQc6Rn+9QBcUFHhmkK+9zu+P=bxowfZwxrATCBRg@mail.gmail.com/
Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
Cc: stable@vger.kernel.org
---
 arch/x86/coco/tdx/tdx.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 65119362f9a2..41cc23cc63dd 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -693,8 +693,8 @@ static bool handle_in(struct pt_regs *regs, int size, int port)
 		.r13 = PORT_READ,
 		.r14 = port,
 	};
-	u64 mask = GENMASK(BITS_PER_BYTE * size - 1, 0);
 	bool success;
+	u64 val;
 
 	/*
 	 * Emulate the I/O read via hypercall. More info about ABI can be found
@@ -702,11 +702,9 @@ static bool handle_in(struct pt_regs *regs, int size, int port)
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
-- 
2.54.0

