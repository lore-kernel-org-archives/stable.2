Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DF543D518
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 17:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784567746; cv=none; b=ccF1gjh0Uf35gQDanRYksJXkRFWIWmrOKcMx5s4ktdg4sVKcaBubXML0JmFV7nIh7oDGnBXISa942xfQXop5H6ejsqm8UfgErWR+wVnARRdmEy42WEJFG8Ra+wBP+l2jOQpiF8W6SdH+tl/5VtX0JsuwoqkUMEy6rcOPOKsUDuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784567746; c=relaxed/simple;
	bh=eCbzxpEeV0HHh/mMaxPxKBYRx+SVdvYt2l06wPwlxkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wz+ksfCbwjgoRB6/cxg+dUZ9BQ2zYFinid0bY4hZjokuqGYKDmRVNU+069SyHtsgGRCNrydCXw3hENc8e+WSQPvWnHNrcMjGvPYhcPBWCybI/5SZsRA2bU+OxzYr1Vse/eWQN1FXL1oEKeQ92eYOl1Wgp5GAAnopQ9/IPg2wnDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OEVUsadJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OEVUsadJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A08DE1F01579;
	Mon, 20 Jul 2026 17:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784567742;
	bh=/u3hSE/5Z4e/KWi/OdzYrtZkqzDsQDdoxL54XMhwxwo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OEVUsadJgDwNwJth2ie0Yu3kZXd4/MXv2voGg1wrUS2w+7RXYjfeodR4xcwRKjW1F
	 B/4P/aGLNy0Az3VPfDFe2pGhzmufC+5uvwHWKEQYV+hgL3gwZ3VNT51UHnIDrUu4fb
	 qni45fZvzh6emtxeI3J0qIxtfUMuIdzGG/FNRVEGTBeetumlTBpgX5t/7zryyd3ZQD
	 BmewoGaS7hzYSLY4EZklzmYHpHveK/us9pY/M+G1OsB5EwaZlZX6CP1y3Vg7MUQx0M
	 FPsTDnBNpN2w9RyyLBHc7tXpACkYSise5kCOl0vFudMk6T8VkAT6EyyuhaYPjGCAqL
	 XY/j4rYCA+8fg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Tycho Andersen (AMD)" <tycho@kernel.org>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 6/6] crypto: ccp - Do not initialize SNP for ioctl(SNP_CONFIG)
Date: Mon, 20 Jul 2026 13:15:35 -0400
Message-ID: <20260720171535.2695659-6-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260720171535.2695659-1-sashal@kernel.org>
References: <2026071538-unmapped-affiliate-9ff5@gregkh>
 <20260720171535.2695659-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Tycho Andersen (AMD)" <tycho@kernel.org>

[ Upstream commit 08f0e65e784c4b20e6e620dd4f68d8636073a3d2 ]

Sashiko notes:

> if SEV initialization fails and KVM is actively running normal VMs, could a
> userspace process trigger this code path via /dev/sev ioctls (e.g.,
> SEV_PDH_GEN) and zero out MSR_VM_HSAVE_PA globally? Would the next VMRUN
> execution for an active VM trigger a general protection fault and crash the
> host?

Refuse to re-try initialization if SNP is not already initialized for
SNP_CONFIG.

This is technically an ABI break: before if SNP initialization failed it
could be transparently retriggered by this ioctl, and if no VMs were
running, everything worked fine. Hopefully this is enough of a corner case
that nobody will notice, but someone does, there are a few options:

* do something like symbol_get() for kvm and refuse to initialize if KVM is
  loaded
* check each cpu's HSAVE_PA for non-zero data before re-initializing
* once initialization has failed, continue to refuse to initialize until
  the ccp module is unloaded

Fixes: ceac7fb89e8d ("crypto: ccp - Ensure implicit SEV/SNP init and shutdown in ioctls")
Reported-by: Sashiko
Assisted-by: Gemini:gemini-3.1-pro-preview
Link: https://sashiko.dev/#/patchset/20260324161301.1353976-1-tycho%40kernel.org
CC: <stable@vger.kernel.org>
Signed-off-by: Tycho Andersen (AMD) <tycho@kernel.org>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/ccp/sev-dev.c | 33 ++++-----------------------------
 1 file changed, 4 insertions(+), 29 deletions(-)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index c1e003cae057a2..6387baca7b553a 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -1433,21 +1433,6 @@ static int sev_move_to_init_state(struct sev_issue_cmd *argp, bool *shutdown_req
 	return 0;
 }
 
-static int snp_move_to_init_state(struct sev_issue_cmd *argp, bool *shutdown_required)
-{
-	int error, rc;
-
-	rc = __sev_snp_init_locked(&error);
-	if (rc) {
-		argp->error = SEV_RET_INVALID_PLATFORM_STATE;
-		return rc;
-	}
-
-	*shutdown_required = true;
-
-	return 0;
-}
-
 static int sev_ioctl_do_reset(struct sev_issue_cmd *argp, bool writable)
 {
 	int state, rc;
@@ -2141,8 +2126,6 @@ static int sev_ioctl_do_snp_set_config(struct sev_issue_cmd *argp, bool writable
 {
 	struct sev_device *sev = psp_master->sev_data;
 	struct sev_user_data_snp_config config;
-	bool shutdown_required = false;
-	int ret, error;
 
 	if (!argp->data)
 		return -EINVAL;
@@ -2150,21 +2133,13 @@ static int sev_ioctl_do_snp_set_config(struct sev_issue_cmd *argp, bool writable
 	if (!writable)
 		return -EPERM;
 
+	if (!sev->snp_initialized)
+		return -ENODEV;
+
 	if (copy_from_user(&config, (void __user *)argp->data, sizeof(config)))
 		return -EFAULT;
 
-	if (!sev->snp_initialized) {
-		ret = snp_move_to_init_state(argp, &shutdown_required);
-		if (ret)
-			return ret;
-	}
-
-	ret = __sev_do_cmd_locked(SEV_CMD_SNP_CONFIG, &config, &argp->error);
-
-	if (shutdown_required)
-		__sev_snp_shutdown_locked(&error, false);
-
-	return ret;
+	return __sev_do_cmd_locked(SEV_CMD_SNP_CONFIG, &config, &argp->error);
 }
 
 static int sev_ioctl_do_snp_vlek_load(struct sev_issue_cmd *argp, bool writable)
-- 
2.53.0

