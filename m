Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE09D4B202E
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788444378; cv=none; b=K7PRwmxbf5D2FbBm0E4nNN132DtFab0GEmGZRs183w3OAUtXSBfhwFULZuUuPr/fYeOSqYW8VKl0hhJ49WAlD04ZwZBWJcwyhKUmqV+pSCXz7Pk0L07XNO0ZZ/ra9lJl+CJXNgtNQ2zldzzFVwU0ET6W2dnl0TXKPau6cJdSU5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788444378; c=relaxed/simple;
	bh=Sd5TfrNcBwTrcUt6iKF2gx8ILuMWxRQZhHo6rD8jrMk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=t88Rvqhn3KKwcqF6YtRhgp3TNIJp7GZBev24FjyZdinkLmJSlJi5qmucom/IDkxhCfmlgeQozao2LDvJJdOmC1eYNxzJ1rPlw0mp7dwHhGbOgfAxzWMVaO8EIh380iLiE9gotW1tXOIfrKInYaFjxcRy6F36TI2xEFf8Q5uCEGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a+Pnckbk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a+Pnckbk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F9241F00A3D;
	Thu,  3 Sep 2026 14:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788444371;
	bh=vuiP3oOCjBckaamRq4KWh6KiYwLr6SSD0W0ckkoUd4k=;
	h=Subject:To:Cc:From:Date;
	b=a+Pnckbk2LYiQQuHEvxS9m3a0KqsOak/loEAknJ4sEPYgv16fKXYhMraRnbJvx3pV
	 /Q0w/hqpUIF7HWRISM5Ub2m9znPkPcK/ALjO3sjTQF2d9/wDob7HaLDB1T7avkdwPW
	 7uKcUohEx/MGgwUhBcTyD0BUhSEy+mzNWUo8GzSo=
Subject: FAILED: patch "[PATCH] ARM: 9477/1: Disable broken eBPF JIT on the Risc PC" failed to apply to 5.15-stable tree
To: enelsonmoore@gmail.com,linusw@kernel.org,rmk+kernel@armlinux.org.uk
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:45:25 +0200
Message-ID: <2026090325-ardently-jaybird-f824@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 7e8ee82e69fde9d589272ec5e6f702358903be1f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090325-ardently-jaybird-f824@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

