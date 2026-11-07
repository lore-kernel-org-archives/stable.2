Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046899;
	b=C+nN3SL6KqMM2EsDUr6P8jRFBJnr0S8vJy0nuy7ChhmbBbtIkcn0oEYVoFG8x+VppLTq
	 3WHqLUZZhja2PlH/WNqVgWd5CJ/GtJB61kKqR3Kp3XlBMcFtJeTiKGmhJ9DBY3zflbHoc
	 UFty8KGOauNf5mRcUFHewoRQBXI2VHsGnk7z/r25KEa/g2Gg5idzu9Nc6Mun7vjUaxuf4
	 Pk1SkiUfvx83OYp1sAn8DTGa3t0H63VBGXJJTmt9VGLu5vE9cYSsJ4w40XxxugNTUlQBB
	 EqZnZSsiXiEDk5/sVeyzD3Hv8nxiILRb4toJbAGn0RJtAseaoZzZC1oHFIj8MsJlVmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046899;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=HDCbZrSdPX6hFatwqYTckDk+eUOVDtT0PNGRnTpWyWI=;
	b=DpyqLEs7DkhVg+8aW1CP9qFm2gKgYrxOV16pfSMmUmrEWRveXYTcE9fkhqpBStFjUonN
	 t2VUpz2sfx58S9SYE6n1KijHGPLd9ii9BjTMgYV3QgN5dGA6Kp+ZfBwTAa3L01GUai8ZW
	 +8GaE9KNN2HL2I/OUc63IALLl42a4anOjDo2iI3utLYAsTrf8qTe30/cZC8vGLCfFgU0B
	 FnFPwX/I2ShfiKGTVEte7LvyYBwFoy6MMLd8cKL57KYFTv1jGoqXCiGA9JQzAJ3tuxoB2
	 JtMlNc2SxQSirkcJSkNmopmlM5dH0317upLgTadKKndHxjeQVSsYwrfkSqruYTQ34LQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dQ0ancDu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDA8606EE89
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dQ0ancDu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C163C1F0089F;
	Sat,  7 Nov 2026 10:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046899;
	bh=HDCbZrSdPX6hFatwqYTckDk+eUOVDtT0PNGRnTpWyWI=;
	h=From:To:Cc:Subject:Date;
	b=dQ0ancDuvjuQH+S1iXdd0p/4i5cXc6qdn0hPO4bA+KUb3duPRYCFNVdWUxtjh3MCb
	 908znSM4q41P76Os+PLOSfqOn9g3TtlHKjB9t05FTsQbhctVrGA+aqLg0Y31VPxzSc
	 dv0qnBUM5oD0LqV881rJCmKqOaIv1fwoJmb9WqpNjcgPx1fhuWh84lXI90fQ2swBPP
	 ouo61RykEN2BYuMSNUmPJe+CuVxK12+BoaNV9o147OH6M2BwEnLJLMDDL75l+wGagL
	 Elw9nDM8eG4AL6Eunk86nA5i9rJu0fTslRJ1x4veQnAD1iDNHkjUD4MwqMzhE7ft0x
	 9d1CxfB4CKSVw==
From: Sasha Levin <sashal@kernel.org>
To: mario.limonciello@amd.com,
	ilpo.jarvinen@linux.intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] platform/x86/amd/pmf: Add AMDI0112 ACPI ID" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:21:37 -0500
Message-ID: <20261107052137-failed-6.12-325bcc126cf7@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 325bcc126cf7a512a0e2da0efddad665f69badac
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052137-failed-6.12-325bcc126cf7@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 325bcc126cf7a512a0e2da0efddad665f69badac Mon Sep 17 00:00:00 2001
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Wed, 26 Aug 2026 11:36:11 -0500
Subject: [PATCH] platform/x86/amd/pmf: Add AMDI0112 ACPI ID
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The AMDI0112 ID is used to bind the PMF driver to some platforms.
It doesn't have any Linux side code changes relative to the most
similar AMDI0105.

Cc: stable@vger.kernel.org
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Link: https://patch.msgid.link/20260826163611.2268377-1-mario.limonciello@amd.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/platform/x86/amd/pmf/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/amd/pmf/core.c b/drivers/platform/x86/amd/pmf/core.c
index b4eae65e675b8..5966190d1496b 100644
--- a/drivers/platform/x86/amd/pmf/core.c
+++ b/drivers/platform/x86/amd/pmf/core.c
@@ -454,6 +454,7 @@ static const struct acpi_device_id amd_pmf_acpi_ids[] = {
 	{"AMDI0107", 0},
 	{"AMDI0108", 0},
 	{"AMDI0109", 0},
+	{"AMDI0112", 0},
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, amd_pmf_acpi_ids);
-- 
2.53.0




