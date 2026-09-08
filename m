Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C44351A72A
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 12:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788870038; cv=none; b=m/OK9xppEyIdE5bqa2yXxLLdCTU1ANcFwd29DwcZV6+g98O2KnagR5ap3QWqlkfk83I2IQcl05QE8yuFtsDJUVQS8vmWhrJ4i1SjWXU5htdPn14m/AV6RHaU37UlLEr2w9vYHoMJ97s9+wvOYJHUYdcuGecHTuDqbzyqxC9ZqMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788870038; c=relaxed/simple;
	bh=gky5ROF1o7DXMWfpvad20USDf0dz6taxlRp2MLyt2Ns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WhPEntEXTsd1h5Z5aINiR4wcYOyGM0AGzUev0j67iN9cBNly+D5f2m470r22zC5YWmX1BBqXT8NqkDFQDFv9MoBzc+7j+D0xoEMZPNRfTnuZlmb2Eos6cMJxA22sn23nQKUHbexiPCgvW0LBzwNFpoCfBvv1/zFLFH6CbFf7y4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L8liyZVN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L8liyZVN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 813D31F00A3E;
	Tue,  8 Sep 2026 12:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788870034;
	bh=ay2pY9wPer7Xo6SQWA1goh4elhzE4DaB8T0RSTZ+2G0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L8liyZVNxGDx10sb3YhYGoutf8F09XtxpGavMryl8uI9BVOqLt0KGDDs/JRkQvtKI
	 7A7TpbN6HUYyku58Ik+2yWAjyAQwALvSL7nnAbWA8BwP1p7NSDR1G779Hb0owfRvIA
	 vADiwhVjivfn4UmOQ6Sgh5ODA1MGbtb/rVvDTKoJOd7bytBOy2zI1oZiHl66Vx6dXv
	 ccPHDFAwE+Ru8Jr9iinO/EMNADAv+iwtNGpTd3louk9VGGcxtSLy2/pkGV2lGnX8qM
	 0IZ0Glz7VoJNTFKJIlLWPZ6NE7D42WHls5PfuEQXlbo2lkJ35EYB+ZyP0oM+UPzkl3
	 QXhuR6bgLE8MQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 4/4] ARM: 9477/1: Disable broken eBPF JIT on the Risc PC
Date: Tue,  8 Sep 2026 08:20:26 -0400
Message-ID: <20260908122026.2052281-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908122026.2052281-1-sashal@kernel.org>
References: <2026090325-ardently-jaybird-f824@gregkh>
 <20260908122026.2052281-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ethan Nelson-Moore <enelsonmoore@gmail.com>

[ Upstream commit 7e8ee82e69fde9d589272ec5e6f702358903be1f ]

The eBPF JIT unconditionally generates ldrh/strh instructions, which do
not function correctly on the Risc PC because its bus is unable to
signal half-word accesses. Work around this issue by disabling the eBPF
JIT when building for ARMv3 (the Risc PC is the only currently
supported machine whose kernel is built for ARMv3).

Comments from Ethan Nelson-Moore:

 From LKML: https://lore.kernel.org/all/CAD++jL=0qYGoygUwGEXQL7C_ROnC7kfpRv8RA+H5tNWwYu+pQA@mail.gmail.com/

 The commit message has been updated slightly relative to the version on LKML to clarify that the Risc PC is not actually ARMv3.

Fixes: 39c13c204bb1 ("arm: eBPF JIT compiler")
Cc: stable@vger.kernel.org
Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a0d6aefa0fab0..d140322177189 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -80,7 +80,7 @@ config ARM
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE if ARM_LPAE
 	select HAVE_ARM_SMCCC if CPU_V7
-	select HAVE_EBPF_JIT if !CPU_ENDIAN_BE32
+	select HAVE_EBPF_JIT if !CPU_ENDIAN_BE32 && !CPU_32v3
 	select HAVE_CONTEXT_TRACKING_USER
 	select HAVE_C_RECORDMCOUNT
 	select HAVE_DEBUG_KMEMLEAK if !XIP_KERNEL
-- 
2.53.0

