Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D1F4B1B49
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788444390; cv=none; b=oBoBdq+mYLPGft9Uije1GZneXHpd7Px+OfpGlvz4B6mivRpTIIzAT/vRjaS4sYvUSrYvWyiPdiI56J1QSU+UEJYa6N+qe1wNt9aRFfhYsX8if3V/VLNWvRTU2l6BSQsQVVT3+zwqV3KRwQgstdb6PfpE8UghuklZY446b0sLz9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788444390; c=relaxed/simple;
	bh=WA2F+GhGlHKQkGqpaD+yacEyF7BEEbpJSDEM9zeX3ss=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=rpB7rKh0ZBj4r4IVX4r9a638Ix6eVJgaMYoIpIvBqlM5lPlKE6Sq1rGZWp7gyL8Inpbbe5IZCleFm9+U6fd7blBp2v6zsKQ5JTbzqEa1oPlEUfr+krorGRxh+86devqatooJjWFyqfnkpgXWbeMgOs/KMWHjt1fX3mFeDlbPDbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=epzN07aT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="epzN07aT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0163C1F000E9;
	Thu,  3 Sep 2026 14:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788444374;
	bh=kb7kysutEtk/g6e6trGOazOR09in27pUjby0GXYzbXg=;
	h=Subject:To:Cc:From:Date;
	b=epzN07aTN/RALPq4Oa7toh+6SD9b6zHvqhOc+qLGPNsh+tRKrvzcN/4PG/uP6FEse
	 qzjLD2FAVqLhz83rRQiJgCHOw91/lq+q7B/iE2E0ntw+CBK7ZrupB8SeSRzdUKHL3X
	 d/U9UjUJu/Q8kLyVeYdHn2axMCL4vOR2ZMkITD5M=
Subject: FAILED: patch "[PATCH] ARM: 9477/1: Disable broken eBPF JIT on the Risc PC" failed to apply to 5.10-stable tree
To: enelsonmoore@gmail.com,linusw@kernel.org,rmk+kernel@armlinux.org.uk
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:45:26 +0200
Message-ID: <2026090326-curtsy-rocket-6c6d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 7e8ee82e69fde9d589272ec5e6f702358903be1f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090326-curtsy-rocket-6c6d@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7e8ee82e69fde9d589272ec5e6f702358903be1f Mon Sep 17 00:00:00 2001
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Sun, 14 Jun 2026 02:45:38 +0100
Subject: [PATCH] ARM: 9477/1: Disable broken eBPF JIT on the Risc PC

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

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9187240a02db..b8aa3fcce107 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -98,7 +98,7 @@ config ARM
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE if ARM_LPAE
 	select HAVE_ARM_SMCCC if CPU_V7
-	select HAVE_EBPF_JIT if !CPU_ENDIAN_BE32
+	select HAVE_EBPF_JIT if !CPU_ENDIAN_BE32 && !CPU_32v3
 	select HAVE_CONTEXT_TRACKING_USER
 	select HAVE_C_RECORDMCOUNT
 	select HAVE_BUILDTIME_MCOUNT_SORT

