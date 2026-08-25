Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47143D75A8;
	Tue, 25 Aug 2026 20:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787691529; cv=none; b=frESKLenG2r8y2Ve1dhh+9hxFOGscYx6F3A0OXPkMJPdfe4XIDe+xuXaXjIJ3uJqqjmMZcG/UGeZeXtKxR+kaU4gAyxLI6NqkSZZHbmHdxYhTli2VXTr8UYfI9HkYTFo2kRMjXAryD+C7ygVaCvWNNa5e/+TGzj9AnsB39oPT8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787691529; c=relaxed/simple;
	bh=ezbX/LRqC72QwZ54CJev6hPjTLIWfLTcd+nM1mnqj+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gf+4IV6NWkz10wIZF0xVCTp6AWBY+9uqpMZufrM0nvIbnzNXucTJX9zPtx+//y8fxh/bIC+qVAVQK6DivU19CELeVywHC7XUKVCdWA81H99LPt1moRXxUyPX7XKJn5y7chJJpgz0tr09nD4uwRw5EDNbcerszvddceSdONthEkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=MxPDrAYu; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=wZJ8sK4y; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="MxPDrAYu";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="wZJ8sK4y"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1787691520; bh=x5ptgH1+l+eHmiDjFhFIWK1
	AN+3vpULjdQe9ooy3wMI=; b=MxPDrAYuYMDGqzEx/3V8Rd+RVnUqiMnNK/ThqEgl6Fd7M5NJ2H
	wRk3id6CJ2IKZREVzyoccpxTJM/HKFriHIS+MRXAWbzel+S3McidVpg/yLixbpRUyPiWCMR3nLt
	i0ySW9tuwShZyX6BuORVL+Fbj0DIDFGHvrXc2AaCHS0wVu5lEp+/fXYiyEqUTS0Wc70sex635An
	mfkOzG81Vgl1vMApPmq4Iagd5PJEXGx90Auf8AJzJsCunmL2m4vGWA0ucsEYCjj/aFv0f/FYe39
	wfZH5i0PJuYXPmydb0Pctb0+tNZIwIxMFot0cI8D3Za2iWJBb7VN/X1jimGThGxWFkw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1787691520; bh=x5ptgH1+l+eHmiDjFhFIWK1
	AN+3vpULjdQe9ooy3wMI=; b=wZJ8sK4ypJ5yYbibF3C2Rlrwt5c6chdBFxa174mQYdxccwGlmR
	QnunZEAlwjplgEQt0Z1lG3NKALTfO9maCRCg==;
From: Bradley Morgan <brads@mainlining.org>
To: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	James Morse <james.morse@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	brads@mainlining.org,
	stable@vger.kernel.org
Subject: [PATCH 1/7] arm64: hibernate: pass HVC_SET_VECTORS args to the resume hvc
Date: Tue, 25 Aug 2026 20:58:33 +0000
Message-ID: <20260825205839.14571-2-brads@mainlining.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260825205839.14571-1-brads@mainlining.org>
References: <20260825205839.14571-1-brads@mainlining.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

swsusp_arch_suspend_exit() reinstalls the restored kernel's hyp stub
vectors with an hvc, but never passes the arguments. x0 is not set to
HVC_SET_VECTORS and x1 is not set to the vector address, so the stub
dispatch falls through and returns without writing vbar_el2. EL2 is
left pointing at the trans_pgd copy of the vectors, a page that
swsusp_free() releases right after resume.

Set the arguments up the same way __hyp_set_vectors() does.

Fixes: 788bfdd97434 ("arm64: trans_pgd: hibernate: Add trans_pgd_copy_el2_vectors")
Cc: stable@vger.kernel.org
Signed-off-by: Bradley Morgan <brads@mainlining.org>
---
 arch/arm64/kernel/hibernate-asm.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/hibernate-asm.S b/arch/arm64/kernel/hibernate-asm.S
index 0e1d9c3c6a93..2baefe7a82d3 100644
--- a/arch/arm64/kernel/hibernate-asm.S
+++ b/arch/arm64/kernel/hibernate-asm.S
@@ -89,6 +89,8 @@ alternative_insn "dc cvau, x4",  "dc civac, x4",  ARM64_WORKAROUND_CLEAN_CACHE
 	isb
 
 	cbz	x24, 3f		/* Do we need to re-initialise EL2? */
+	mov	x1, x24
+	mov	x0, #HVC_SET_VECTORS
 	hvc	#0
 3:	ret
 SYM_CODE_END(swsusp_arch_suspend_exit)
-- 
2.47.3

