Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792668884;
	b=zxhEmZnWs+Dgqx59ZgK1PlFzgp0MzGP25XAAfVFp6z1ofB0GTecbPi5EYI+UEHT7hmLF
	 lqrNqsib+/+tLdpgSgts/36sL/pTIB5hxIQXImmeRQIQyOBMRjwRwi7gZ/VS7w8rIDy3U
	 3VCUOOCG1k86wN5iOf9msy588RAN6W/PcYx0Z7cElMROkgquOwIBk5cMvf0u6AeCHdmE3
	 baQuoAuxwxwH690YNbHWheZEmtJFbtQHrHadf+Rhvm6dHtIGrghhNlTsJ2K3UGuS5Wpib
	 Tq+JHxbv5dxu84SaWVraPDGeAy6ECtWXBLRBV7zwWkhd9jPUbrkfN/WIbzcsSOOyvDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792668884;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=4IHEN2ko/deTTa/rtm+X13D/Emc5jjFaC4VISB0zfsU=;
	b=2ABg5830BULeVHqgxesQ4xtN3G8Jimc3lueBxGyRx89Ni+CLSEjihfChrYW/O+0YhXDz
	 fj0IHvY2JB6ubv3uCD/z8psaJ93AsNNYmpOQVahZuh8rwj4TW5MEHhnYE/IhTvF0Q3EoD
	 K/+RJ2uU69PIq7YNmHA1Cz5UZ/w9VQANC6A43SiSjzmKGRHZK/ewiU/2lB14/LAQv1AEe
	 IQDqiFwgnUIW2zA+7XdINF52wziVJ6Mmv9wX433b/46JiOCL5vsx+IabPvElZNxzVskMW
	 bHFTgELHrRQ9D2ZqrqzsYxy15uQiKHgSKrF6Cuf1jVnaw9/+7bA3XFQsToKAmHWHhUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bwXxncB9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700CD606A319
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 11:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bwXxncB9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 732CA1F000C1;
	Thu, 22 Oct 2026 11:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792668884;
	bh=4IHEN2ko/deTTa/rtm+X13D/Emc5jjFaC4VISB0zfsU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bwXxncB9wrXAlttNTGaZXJuEywWRT6L7fP5gkGwWEuWe4+FdBlhE3+J4ia6nJ2KJ7
	 wOBgWZLpCriXf2rXSQ/AR+lrGDlxvKLgpLOQqvXmtfaY3gSMmn7nVuj4MEepNLWOlm
	 fwlIw4OkgpnWArb5J8OwyHzGyIHTJIqxWwGcbmCIg3/UkOcptyKGNMgsnskeBDF9nR
	 nAh+x5UzY7YzCAIPkCsf+PYwZZQkRpLOUloJUIUO3rk2d53UVUwDgV/g46M6WkBowI
	 Bo0lmgE/ofGMAw/mElsUnjBfEyPBYUS3YrybVCu+oGFRhIl1hULkysnQ8+BOEmesBQ
	 QIethte5LrLNQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dibin Moolakadan Subrahmanian <dibin.moolakadan.subrahmanian@intel.com>,
	Mitul Golani <mitulkumar.ajitkumar.golani@intel.com>,
	Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] drm/i915/dmc: Harden DMC firmware payload parsing
Date: Thu, 22 Oct 2026 07:34:42 -0400
Message-ID: <20261022113412.962028-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102110-striking-gloss-4959@gregkh>
References: <2026102110-striking-gloss-4959@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dibin Moolakadan Subrahmanian <dibin.moolakadan.subrahmanian@intel.com>

[ Upstream commit 8bb1858db453cd4250e3b633f5d2d09206024ca6 ]

Validate the conversion of the DMC firmware size from dwords to bytes
using check_mul_overflow() before calculating the firmware payload size.

Reject zero-length payloads and zero MMIO counts in the DMC firmware
header so malformed firmware is caught early. Also set dmc_fw_size only
after the payload allocation succeeds.

Fixes: eb805623d8b1 ("drm/i915/skl: Add support to load SKL CSR firmware.")
Cc: stable@vger.kernel.org
Assisted-by: Claude-Code:Sonnet-5
Signed-off-by: Dibin Moolakadan Subrahmanian <dibin.moolakadan.subrahmanian@intel.com>
Reviewed-by: Mitul Golani<mitulkumar.ajitkumar.golani@intel.com>
Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Link: https://patch.msgid.link/20260922133535.3180973-5-dibin.moolakadan.subrahmanian@intel.com
(cherry picked from commit efde6601a1f1daedfe3dcc2816c934ddb44e3eef)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/display/intel_dmc.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dmc.c b/drivers/gpu/drm/i915/display/intel_dmc.c
index 0f32f71faa3c2..a341a3fb1e475 100644
--- a/drivers/gpu/drm/i915/display/intel_dmc.c
+++ b/drivers/gpu/drm/i915/display/intel_dmc.c
@@ -1132,7 +1132,7 @@ static u32 parse_dmc_fw_header(struct intel_dmc *dmc,
 	}
 
 	/* Cache the dmc header info. */
-	if (mmio_count > mmio_count_max) {
+	if (!mmio_count || mmio_count > mmio_count_max) {
 		drm_err(display->drm, "DMC firmware has wrong mmio count %u\n", mmio_count);
 		return 0;
 	}
@@ -1178,13 +1178,21 @@ static u32 parse_dmc_fw_header(struct intel_dmc *dmc,
 			    disable_dmc_evt(display, dmc_id, dmc_info->mmioaddr[i],
 					    dmc_info->mmiodata[i]) ? " (disabling)" : "");
 	}
-	dmc_info->mmio_count = mmio_count;
-	dmc_info->start_mmioaddr = start_mmioaddr;
 
 	rem_size -= header_len_bytes;
 
 	/* fw_size is in dwords, so multiplied by 4 to convert into bytes. */
-	payload_size = dmc_header->fw_size * 4;
+	if (check_mul_overflow(dmc_header->fw_size, 4u, &payload_size)) {
+		drm_err(display->drm, "DMC fw_size too large (%u dwords)\n",
+			dmc_header->fw_size);
+		return 0;
+	}
+
+	if (!payload_size) {
+		drm_err(display->drm, "DMC firmware has empty payload\n");
+		return 0;
+	}
+
 	if (rem_size < payload_size)
 		goto error_truncated;
 
@@ -1192,7 +1200,6 @@ static u32 parse_dmc_fw_header(struct intel_dmc *dmc,
 		drm_err(display->drm, "DMC FW too big (%u bytes)\n", payload_size);
 		return 0;
 	}
-	dmc_info->dmc_fw_size = dmc_header->fw_size;
 
 	if (!dmc_load_addr_sanity_check(dmc, start_mmioaddr, payload_size,
 					dmc_header->header_ver, dmc_id)) {
@@ -1204,6 +1211,10 @@ static u32 parse_dmc_fw_header(struct intel_dmc *dmc,
 	if (!dmc_info->payload)
 		return 0;
 
+	dmc_info->mmio_count = mmio_count;
+	dmc_info->start_mmioaddr = start_mmioaddr;
+	dmc_info->dmc_fw_size = dmc_header->fw_size;
+
 	payload = (u8 *)(dmc_header) + header_len_bytes;
 	memcpy(dmc_info->payload, payload, payload_size);
 
-- 
2.53.0

