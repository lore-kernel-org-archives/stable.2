Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C292DCC1C
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 10:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784110666; cv=none; b=WRT/4tycq8GdbYYDBQfxCLZ3+ApV7x9/p1o+NWXxuEuqDG09jtNOMwkHPK8DvI/D5rk0kep3ug6JrVL+riNZ4UEWGZrc/4PwdpYdHgpYm4WHfjyVmOqgzdMex4PXR6TIblZCBqX5x1wB+nM6nMaMFngZogkeafFDKixsKsMadsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784110666; c=relaxed/simple;
	bh=Cy0R3v/bXvEsjjGsYMViA8AeuwPNoUdaSzgCpoQM5Bc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=grDOtoJKNx6xLWCt5PFk+W4NAWtobxgjNVMt5G7CzfXObG9SIkChQhEFq5Jmbo2MP5B+/zl3mmxPO6IwIVHKEk9WAcF9kKeL+4oPQ9gDEgPh9GfhyExhiv5UwUN4FP1kB6AczWgQ+DUyK42Isa9KpEPsJsWKa5R/+x6m/zVcPqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bT7ludQL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bT7ludQL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A01A31F000E9;
	Wed, 15 Jul 2026 10:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784110665;
	bh=uhJNCyk/OHbK5Tudyi7O1jz3xS/bTsXvhllltDSUS+k=;
	h=Subject:To:Cc:From:Date;
	b=bT7ludQLhlv/Vx0wjG6joQjkoKUyBHMuiCfnzqCV5GTp/PVpDrbgHAPew7CgMeCLm
	 awfXcy4vvVkcnxCqS3OL12MXg8n/TCtshzYY5/l/G/HUZieUA7ujtXrTE9E0IRRAyJ
	 QQ9/5NlJjbSdh7DQYolYL6U/zhqiol7sTv28rt7Y=
Subject: FAILED: patch "[PATCH] crypto: ccp - Do not initialize SNP for ioctl(SNP_CONFIG)" failed to apply to 6.12-stable tree
To: tycho@kernel.org,herbert@gondor.apana.org.au,stable@vger.kernel.org,thomas.lendacky@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 15 Jul 2026 12:17:38 +0200
Message-ID: <2026071538-unmapped-affiliate-9ff5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 08f0e65e784c4b20e6e620dd4f68d8636073a3d2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071538-unmapped-affiliate-9ff5@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 08f0e65e784c4b20e6e620dd4f68d8636073a3d2 Mon Sep 17 00:00:00 2001
From: "Tycho Andersen (AMD)" <tycho@kernel.org>
Date: Mon, 4 May 2026 10:51:47 -0600
Subject: [PATCH] crypto: ccp - Do not initialize SNP for ioctl(SNP_CONFIG)

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

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 9fb9267d7636..14df519ae7ee 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -1730,21 +1730,6 @@ static int sev_move_to_init_state(struct sev_issue_cmd *argp, bool *shutdown_req
 	return 0;
 }
 
-static int snp_move_to_init_state(struct sev_issue_cmd *argp, bool *shutdown_required)
-{
-	int error, rc;
-
-	rc = __sev_snp_init_locked(&error, 0);
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
@@ -2454,8 +2439,6 @@ static int sev_ioctl_do_snp_set_config(struct sev_issue_cmd *argp, bool writable
 {
 	struct sev_device *sev = psp_master->sev_data;
 	struct sev_user_data_snp_config config;
-	bool shutdown_required = false;
-	int ret, error;
 
 	if (!argp->data)
 		return -EINVAL;
@@ -2463,21 +2446,13 @@ static int sev_ioctl_do_snp_set_config(struct sev_issue_cmd *argp, bool writable
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

