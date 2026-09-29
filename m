Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D344FD7B2
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 13:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790688682; cv=none; b=idgh3ZSd9wuobd0yjgGDTYiHkZHcV4NJsXsLbQlhdFV6ww0TB0NXUDPmRIGKT22OYMLGDN6rVtQnGcONRy/gj7Pyk8RBA1/cENoCrcqT3FUWv77F2J6sYorHJsl7NFlLp27ZvrH+x2T7A3GI3sSNR8MM15WA0Ai6RMdikAVYulU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790688682; c=relaxed/simple;
	bh=qQnC9bNhNe6y21OZfXtOgGTi66tzQmy4GrP+GfSVQDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uLBln4OkY8VA71OR7sTnOXXtng1Dt+o+4nx039iVEsJb72Ivy187CBiKaPaWWozhIjd7DlETAW8z02bET5s3L6IXLWI8smoTz8H15aqQ+ulFwsvo5/ghViRHUBROb9EhzudL2Josvf9T2WJZtMeia2bAFrD4xKQbI5aPQVIA0DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FRvi3gj7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FRvi3gj7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 430891F00899;
	Tue, 29 Sep 2026 13:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790688680;
	bh=vnVt8I9539c8BJl7ird22PPc1+V67MWC+NWx+5x5dtU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FRvi3gj7mm6N39UC2EwJSwTbZ+T4whqFklK7EhZdjKqeHNO/Isvd9aQUhF2zVoWR8
	 TP6o2kPiFGONPn3E81dMmSImu1gyI/sAfUN72SUh3d80T6grmZVHSNfy/Unldn5jB6
	 SAsBK2ZEkhiz2VNZcmQVSKkeXUbIDHbo8dfx2nsUKvDc+HVhP7S9m8pCDOQN9Jrd/a
	 CaoRKX9kdNsTf/XcgAOOC8v53oG17v603zHVmtqqU7h2DxuW9kRzn9rDYIYb5K89IV
	 BUgXRFxE06+zDpBDuyjMOc/qMq4fGtiC7EKHHCOiTMpP501v8XPbop/3OrnQ/FKIFx
	 x4kbA+1eOh86Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nikunj A Dadhania <nikunj@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 4/5] x86/sev: Remove redundant ghcbs_initialized checks around __sev_{get,put}_ghcb()
Date: Tue, 29 Sep 2026 09:31:07 -0400
Message-ID: <20260929133116.3502913-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929133116.3502913-1-sashal@kernel.org>
References: <2026092939-ecard-twirl-6094@gregkh>
 <20260929133116.3502913-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nikunj A Dadhania <nikunj@amd.com>

[ Upstream commit 9d8460a1c7a6b0f2dc6302e5d0f31d4e8c2a7913 ]

After

  3645eb7e3915 ("x86/fred: Fix early boot failures on SEV-ES/SNP guests"),

__sev_{get,put}_ghcb() handle the early-boot GHCB fallback internally, making
the ghcbs_initialized guards in __set_pages_state() and
svsm_perform_call_protocol() redundant.

Remove them.

Also initialize state->ghcb to NULL in the early-boot path of
__sev_get_ghcb() so that the ghcb_state is well-defined for all callers,
even though __sev_put_ghcb() currently returns early before reading it.

No functional change intended.

Suggested-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://patch.msgid.link/20260518102230.3394603-1-nikunj@amd.com
Stable-dep-of: 6c43c72748ff ("x86/sev: Make vTPM SVSM calls preemption-safe")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/coco/sev/core.c    |  8 ++------
 arch/x86/coco/sev/noinstr.c |  4 +++-
 arch/x86/coco/sev/svsm.c    | 10 ++--------
 3 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 2415410e898ec..fefd7031be020 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -367,17 +367,13 @@ static unsigned long __set_pages_state(struct snp_psc_desc *data, unsigned long
 
 	local_irq_save(flags);
 
-	if (sev_cfg.ghcbs_initialized)
-		ghcb = __sev_get_ghcb(&state);
-	else
-		ghcb = boot_ghcb;
+	ghcb = __sev_get_ghcb(&state);
 
 	/* Invoke the hypervisor to perform the page state changes */
 	if (!ghcb || vmgexit_psc(ghcb, data))
 		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PSC);
 
-	if (sev_cfg.ghcbs_initialized)
-		__sev_put_ghcb(&state);
+	__sev_put_ghcb(&state);
 
 	local_irq_restore(flags);
 
diff --git a/arch/x86/coco/sev/noinstr.c b/arch/x86/coco/sev/noinstr.c
index 5afd663a1c217..e1e03f12fc7bb 100644
--- a/arch/x86/coco/sev/noinstr.c
+++ b/arch/x86/coco/sev/noinstr.c
@@ -121,8 +121,10 @@ noinstr struct ghcb *__sev_get_ghcb(struct ghcb_state *state)
 
 	WARN_ON(!irqs_disabled());
 
-	if (!sev_cfg.ghcbs_initialized)
+	if (!sev_cfg.ghcbs_initialized) {
+		state->ghcb = NULL;
 		return boot_ghcb;
+	}
 
 	data = this_cpu_read(runtime_data);
 	ghcb = &data->ghcb_page;
diff --git a/arch/x86/coco/sev/svsm.c b/arch/x86/coco/sev/svsm.c
index 2acf4a76afe7a..916d62cd17dc7 100644
--- a/arch/x86/coco/sev/svsm.c
+++ b/arch/x86/coco/sev/svsm.c
@@ -74,20 +74,14 @@ int svsm_perform_call_protocol(struct svsm_call *call)
 
 	flags = native_local_irq_save();
 
-	if (sev_cfg.ghcbs_initialized)
-		ghcb = __sev_get_ghcb(&state);
-	else if (boot_ghcb)
-		ghcb = boot_ghcb;
-	else
-		ghcb = NULL;
+	ghcb = __sev_get_ghcb(&state);
 
 	do {
 		ret = ghcb ? svsm_perform_ghcb_protocol(ghcb, call)
 			   : __pi_svsm_perform_msr_protocol(call);
 	} while (ret == -EAGAIN);
 
-	if (sev_cfg.ghcbs_initialized)
-		__sev_put_ghcb(&state);
+	__sev_put_ghcb(&state);
 
 	native_local_irq_restore(flags);
 
-- 
2.53.0

