Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793895513;
	b=HV1eLzevwkAGVuyrRMCTvr4t/QmDz/8PH/Tu+ZP2CIgIgYzfXj4fvRdfAe7RnfxcPMjp
	 DHbvxLwo6R78FaEQC9m0xO5BntBP0SwPaVNCbWAN5A+Nav4dmjABlCfItorpJ9DoaU/GE
	 sn402xr6JIgna2948vnbh/BeSgwu1U8ydDTd+LO9GT0rGsVWXC5EB7smz3fT2WBs1+JuI
	 PYqyeXdtM+Kdi2zM30OYduMMSQwuijfJQklVw47JnUNYK4JHhRJlD4eKzsEJE9B8KBzjE
	 67jwGdqBQ5m/o0lax48YAK0Hcax54Ar15R1J8wcze+uU5FzOZoCCAIWvFipDdoNyAMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793895513;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=dJwwgZepT61iJuK80D0VOZi9hRO7XI3X6avR3AOgfjw=;
	b=cnd/jzYLMXxg8T28BluGLVFzd+j1Llli+WDQZH/F9ukPtsaoW4ejBxDnrt5vB7BAY0TU
	 vGII/QmAfx3jlQX8pnhBD24jCEI1ELlzdHnaY3iKy2T/72ZOdL0AIlPruGWB1k/zzDQXh
	 KgFdrmfd9nx5eBtNEtv4WoxRAoKFFBoMQq0QkBnwWq4pPtGy1oLBlaHciSFuOSEwmQzxJ
	 983dkesSwSKq41M2rQ6lDfS2mAut1LlzxqSuFObk9cxm8C+xKn5fVjv2L2nhVTipIoVEh
	 yyvY/2Se2xqgeLjUREKi5eQxmAK5++4cjFw29FM69cgiluViuSTpjnQaEwXeRldiTuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mvOP+GRe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E03B606A32E;
	Thu,  5 Nov 2026 16:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mvOP+GRe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAFB61F00A15;
	Thu,  5 Nov 2026 16:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793895512;
	bh=dJwwgZepT61iJuK80D0VOZi9hRO7XI3X6avR3AOgfjw=;
	h=From:Subject:Date:To:Cc;
	b=mvOP+GReeU+1v52XCaFnBL9ClC5t7oxsgdBFVjXryZPJ6rgs1+BtF+FKhhVUCeT2f
	 iRXVNzqWSEtUYLXRqSzPEwLZrqRLh6BhBOsX62Qu35qqzDEUiGNsCNwlggjSWAIn2n
	 2plXyz4obcHsnI6k5zSbiAGJPgbiLI/cYaz31OwekCC2YCVge8HBE1IXTxVBHcTWoC
	 gW10UhJspfXgSv3F8g9VyEfBKFtw5A1eoQEowy3CYNtTe9tiEU5tCl2km9p9jxyE3Y
	 r+iK+d90aBv1xTG/CQsYMhJGbh5+eyw5qzbASkF0JOcRDvGCNUCtO8+vlF371pnqhR
	 Hy4QUV1yRnLKw==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/2] arm64/suspend: Save more registers over suspend
Date: Thu, 05 Nov 2026 16:05:03 +0000
Message-Id: <20261105-arm64-fix-sysreg-suspend-v1-0-f4d9a99fec46@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADGp7GoC/yXMQQrCQAyF4auUrA00Q5xFryIuxmlaU3AsSStK6
 d0d6/KD9/4NXEzFoWs2MHmp67NU0KmBfE9lFNS+GkIbIlHLmOwRGQd9o3/cZERffZbS4znGwAM
 nJspQ77NJXR3py/VvX2+T5OXXg33/Agm9pvZ8AAAA
X-Change-ID: 20261104-arm64-fix-sysreg-suspend-56624f4a411c
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Anshuman Khandual <anshuman.khandual@arm.com>, 
 Joey Gouly <joey.gouly@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=763; i=broonie@kernel.org;
 h=from:subject:message-id; bh=2ATZawLqBLUtwnOq5tqUFhonr+3ShvJg+pHfQAcax70=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLLerAkt297FrWehZFT1a9vu8paPZxMYzvzf8DFNd8XMh
 8Vb5l/O7yhlYRDjYpAVU2SJy+J+WV/yeg3fwYVtMHNYmUCGMHBxCsBE5rIx/NPwfyIvsr3U0s/C
 pPDTlRjjcw51E9/8P7dO6nNC/JELqx4y/FO/xnq9jUF2fulvXwHTk1IXjUpmuOt+mWxZpmNqdLG
 6hBUA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

While reviewing beeec0404622 (arm64: suspend: Save and restore
TPIDR2_EL0 across CPU suspend) I noticed some more registers that we
need to save over suspend, fix this.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Mark Brown (2):
      arm64: suspend: Save POR_EL0 over suspend
      arm64: suspend: Save GCS state over suspend

 arch/arm64/include/asm/suspend.h |  2 +-
 arch/arm64/mm/proc.S             | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)
---
base-commit: b0958b1397fb5ffdb995c0ccc74349841929c08d
base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
change-id: 20261104-arm64-fix-sysreg-suspend-56624f4a411c

Best regards,
--  
Mark Brown <broonie@kernel.org>

