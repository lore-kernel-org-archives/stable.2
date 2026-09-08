Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B6A554086
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 13:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788874239; cv=none; b=ibTl34vYuTogyzSBVjvOwV1Q+MNMRXMzb6yyyeYrt7p+c2EQh7inxRzNOzt1b4L76Fbj2uXhK93MXWtG82BN9j/qr3ARWIFEJ/XGrg/pbhYjKIfwd7X8yMl6OoTJomW7lVkXrR09jc3m+z4lI8bWXY3SQct1wzlkTs8XreEqV9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788874239; c=relaxed/simple;
	bh=JbFOZL9IR7VGz0JU3Xq5ghVs/2f89WVPKAIqWzpJkZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y3GCq7292Om0hIE29sLVIZef15Ba4b31uFzl6FtH8AeLRj3TnARVyTj1maBoKlAWqpPGBFCjjtkVsF+swNs9NTkY+2h8PhdnONe2hrBVrU7ssqniPfHStNrEU+UN2IOsZ2bF6IBYnwn3GpnyFEXeqhBxf+9H2Dl4Dd/LVI3RTzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46A2C1F00ACA;
	Tue,  8 Sep 2026 13:30:24 +0000 (UTC)
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH 5.10.y 5/5] ARM: 9477/1: Disable broken eBPF JIT on the Risc PC
Date: Tue,  8 Sep 2026 09:29:56 -0400
Message-ID: <20260908132958.2312212-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908132958.2312212-1-sashal@kernel.org>
References: <2026090326-curtsy-rocket-6c6d@gregkh>
 <20260908132958.2312212-1-sashal@kernel.org>
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
Signed-off-by: test <test@test>
---
 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5a37758349f0d..c5e4b3080a5cd 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -75,7 +75,7 @@ config ARM
 	select HAVE_ARCH_THREAD_STRUCT_WHITELIST
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ARM_SMCCC if CPU_V7
-	select HAVE_EBPF_JIT if !CPU_ENDIAN_BE32
+	select HAVE_EBPF_JIT if !CPU_ENDIAN_BE32 && !CPU_32v3
 	select HAVE_CONTEXT_TRACKING_USER
 	select HAVE_C_RECORDMCOUNT
 	select HAVE_DEBUG_KMEMLEAK if !XIP_KERNEL
-- 
2.53.0

