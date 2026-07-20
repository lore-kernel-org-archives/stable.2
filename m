Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4C3425879
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 17:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784567745; cv=none; b=NEtEQpQWj0OBoo+PRuX+6/h3xk4G328oE7PRkmFK/5sK9b3+PXFzyaQ6SAtVhOVfp+JJYALjitQRiAXEAlf/mmNsJpFyfQ+wXvxXq+dKbw0QRmylmnnxlMojOweMFOOg/XRnQOYBoUcySVsY4dXXwRdAXGqZ1waSE/yBNyHXKgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784567745; c=relaxed/simple;
	bh=Dh8MOvzd/pziWWi5ZWIaapKGq33SK4fX1WRyUr3ODsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hJUuHUNH2yTE8MG9mCSjOYV0129Vx+Oap63yXHy1vYlZDRizTkVLr/R5c7bWmjSxoVplIa9bO6boX91XKX9sXIPCe38+t7fid72HWwNcvNHZGjBU2Ppl8nFNez838G/lmjeZ/ixpoh/r5WaBn4VLbfczXSGO6Z+x3AIy72rH0PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AC7wCQm1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AC7wCQm1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE1DB1F01573;
	Mon, 20 Jul 2026 17:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784567741;
	bh=oX/sXnxuprZlJk2ad5FNIh3axwQBsMf2sYWh4Ga3U9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AC7wCQm1KFzW3z6KpFTfxI7Xy3DAUmr9me+GD5dcH1ExisnCcPQOiJQzdyxl/17VA
	 86y+S919LIiCFHEFSKcUMXve/EiIyDfeu34a1Oc8mluD0yhkGJFI3fY3EHFFeFGdQJ
	 xMbh2iZ3EogT5GxsFWKH7iP3/adYU3w2iku8JlngB4Y/q0QayVS55Tj0QeEDcekISJ
	 A0nxhSMfs4S+cP++mQ3ziLwc9pfG3Om22vLZlOZqaLf7GXp0t45BMVU/KcRo0omjVW
	 i9PrkpzicCY/XwmQscshDl45TBXn/enfoYPLEjnwDu3MCA8SURHnsl4Md1JRAyTTTh
	 k8GkaMxuYHFUA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
	"Tycho Andersen (AMD)" <tycho@kernel.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 5/6] crypto: ccp - Fix a case where SNP_SHUTDOWN is missed
Date: Mon, 20 Jul 2026 13:15:34 -0400
Message-ID: <20260720171535.2695659-5-sashal@kernel.org>
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

From: Tom Lendacky <thomas.lendacky@amd.com>

[ Upstream commit 551120148b67e04527b405c5ec33a31593846ba4 ]

If page reclaim fails in sev_ioctl_do_snp_platform_status() and SNP was
moved from UNINIT to INIT for the function, SNP is not moved back to
UNINIT state. Additionally, SNP is not required to be initialized in order
to execute the SNP_PLATFORM_STATUS command, so don't attempt to move to
INIT state and let SNP_PLATFORM_STATUS report the status as is.

Fixes: ceac7fb89e8d ("crypto: ccp - Ensure implicit SEV/SNP init and shutdown in ioctls")
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Tycho Andersen (AMD) <tycho@kernel.org>
Reviewed-by: Alexey Kardashevskiy <aik@amd.com>
Signed-off-by: Tycho Andersen (AMD) <tycho@kernel.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Stable-dep-of: 08f0e65e784c ("crypto: ccp - Do not initialize SNP for ioctl(SNP_CONFIG)")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/ccp/sev-dev.c | 46 ++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 07e65672b2c7b9..c1e003cae057a2 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -2069,11 +2069,10 @@ static int sev_ioctl_do_pdh_export(struct sev_issue_cmd *argp, bool writable)
 static int sev_ioctl_do_snp_platform_status(struct sev_issue_cmd *argp)
 {
 	struct sev_device *sev = psp_master->sev_data;
-	bool shutdown_required = false;
 	struct sev_data_snp_addr buf;
 	struct page *status_page;
-	int ret, error;
 	void *data;
+	int ret;
 
 	if (!argp->data)
 		return -EINVAL;
@@ -2084,31 +2083,35 @@ static int sev_ioctl_do_snp_platform_status(struct sev_issue_cmd *argp)
 
 	data = page_address(status_page);
 
-	if (!sev->snp_initialized) {
-		ret = snp_move_to_init_state(argp, &shutdown_required);
-		if (ret)
-			goto cleanup;
-	}
-
 	/*
-	 * Firmware expects status page to be in firmware-owned state, otherwise
-	 * it will report firmware error code INVALID_PAGE_STATE (0x1A).
+	 * SNP_PLATFORM_STATUS can be executed in any SNP state. But if executed
+	 * when SNP has been initialized, the status page must be firmware-owned.
 	 */
-	if (rmp_mark_pages_firmware(__pa(data), 1, true)) {
-		ret = -EFAULT;
-		goto cleanup;
+	if (sev->snp_initialized) {
+		/*
+		 * Firmware expects the status page to be in Firmware state,
+		 * otherwise it will report an error INVALID_PAGE_STATE.
+		 */
+		if (rmp_mark_pages_firmware(__pa(data), 1, true)) {
+			ret = -EFAULT;
+			goto cleanup;
+		}
 	}
 
 	buf.address = __psp_pa(data);
 	ret = __sev_do_cmd_locked(SEV_CMD_SNP_PLATFORM_STATUS, &buf, &argp->error);
 
-	/*
-	 * Status page will be transitioned to Reclaim state upon success, or
-	 * left in Firmware state in failure. Use snp_reclaim_pages() to
-	 * transition either case back to Hypervisor-owned state.
-	 */
-	if (snp_reclaim_pages(__pa(data), 1, true))
-		return -EFAULT;
+	if (sev->snp_initialized) {
+		/*
+		 * The status page will be in Reclaim state on success, or left
+		 * in Firmware state on failure. Use snp_reclaim_pages() to
+		 * transition either case back to Hypervisor-owned state.
+		 */
+		if (snp_reclaim_pages(__pa(data), 1, true)) {
+			snp_leak_pages(__page_to_pfn(status_page), 1);
+			return -EFAULT;
+		}
+	}
 
 	if (ret)
 		goto cleanup;
@@ -2118,9 +2121,6 @@ static int sev_ioctl_do_snp_platform_status(struct sev_issue_cmd *argp)
 		ret = -EFAULT;
 
 cleanup:
-	if (shutdown_required)
-		__sev_snp_shutdown_locked(&error, false);
-
 	__free_pages(status_page, 0);
 	return ret;
 }
-- 
2.53.0

