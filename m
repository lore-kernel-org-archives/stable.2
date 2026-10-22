Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792678440;
	b=GHb5lFyRKEtlx/rUN9j1KPY16aO7GgtTWSsK/tBsZU49LlzlWOfD2B9N+ssejycm5B6z
	 pvmaTeuumtjpl2bP0rYWrdXSGBD2lWTuAjaMZrLI5/d4ZbbhjNFUKFQxlkoSb14ZVZa4S
	 /a4pJq9l2E8kcl9o5EIUR7xep1CQvRTAZX002ZiEYS8Xi2fs/oXbW3A1WBlPHE4ED5GOa
	 82yEPyvlhPGarZiOeNTsaiR4xRU74I1Cecmfk4dPmE7taL8sCDVih1arAEHyW4f/lZMz1
	 sgb8je8TgT+E3WVmlgNiA1geuJxcWlv75N/FNO3GoKgFIj2TODqqFDt+eZqFZheeIIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792678440;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=clU2j4pqxdEjQb9dH3FUI5e5sN2lER/XbaJydlIq1xU=;
	b=skbmCl1663YLrgX0weK+G7PhvHTWAO+FQZHFG8w6CRMzt86PIOFFdyo0XXZ+D/spkxB2
	 cbe2yjpVKbTckJp17BxtjsLyWHubsSVGF6lT9q+ULObwCwY27I3iM4tAym7JQrxza2Vet
	 ggYDg/SQJKcPNUNA/msQVg329NDJgBze0Oc4AYSLg9mDk9dNL1QGScoAss0qd4T7Mcm0w
	 inir6vN2m1y7Qiw4Cn5p5pltXTxHulhfO+BLczpX6jz2adbIeXsXNk0Pwf2qYRmihoSg/
	 ukpzm1PYyq++28BEeKibUxeeIWQc6Ki9l5ha6gZhL1FSa5WdtIFCZMUmb6fPqPb7jsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W09zTr40;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFEF606A319
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 14:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W09zTr40
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08DA01F000C1;
	Thu, 22 Oct 2026 14:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792678439;
	bh=clU2j4pqxdEjQb9dH3FUI5e5sN2lER/XbaJydlIq1xU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W09zTr40wG+duwF4aj0HBY6OXNMIm+blEkqkGeFYNDxL01v8WxRCEdhTRI0CCn/PJ
	 bOXs4eitPzU5Mq3imMoy25NjpPpRhcHzGSXe2c7HJUhW4IQaIrxyRkibZU7uA/zVt0
	 jfrTX56YigYruOWfVQMgznwp/fmb+UCUwES09hUbgtYBBw0A6b+A1FUlLBfjdCQZBZ
	 XLLwi44DtDbg0A0hlLV7GTPwPYa/t7o7J4QmycszwfRSJVQiWVwTOepKryBtfNhxko
	 fzfaFE8KiOns7BTgYxezDOFZltwLnBn52IwHJ24lXXEzzgCvNUETLZKjpRSIHU/bKR
	 cpBNo8eAH+l5A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dibin Moolakadan Subrahmanian <dibin.moolakadan.subrahmanian@intel.com>,
	Mitul Golani <mitulkumar.ajitkumar.golani@intel.com>,
	Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] drm/i915/dmc: Harden DMC firmware payload parsing
Date: Thu, 22 Oct 2026 10:13:57 -0400
Message-ID: <20261022141334.1514530-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102111-speller-abacus-9b11@gregkh>
References: <2026102111-speller-abacus-9b11@gregkh>
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
[ sashal: Adapted drm_err() calls to use &i915->drm instead of display->drm. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/display/intel_dmc.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dmc.c b/drivers/gpu/drm/i915/display/intel_dmc.c
index e52ecc0738a60..722fdffb09f93 100644
--- a/drivers/gpu/drm/i915/display/intel_dmc.c
+++ b/drivers/gpu/drm/i915/display/intel_dmc.c
@@ -645,7 +645,7 @@ static u32 parse_dmc_fw_header(struct intel_dmc *dmc,
 	}
 
 	/* Cache the dmc header info. */
-	if (mmio_count > mmio_count_max) {
+	if (!mmio_count || mmio_count > mmio_count_max) {
 		drm_err(&i915->drm, "DMC firmware has wrong mmio count %u\n", mmio_count);
 		return 0;
 	}
@@ -660,13 +660,21 @@ static u32 parse_dmc_fw_header(struct intel_dmc *dmc,
 		dmc_info->mmioaddr[i] = _MMIO(mmioaddr[i]);
 		dmc_info->mmiodata[i] = mmiodata[i];
 	}
-	dmc_info->mmio_count = mmio_count;
-	dmc_info->start_mmioaddr = start_mmioaddr;
 
 	rem_size -= header_len_bytes;
 
 	/* fw_size is in dwords, so multiplied by 4 to convert into bytes. */
-	payload_size = dmc_header->fw_size * 4;
+	if (check_mul_overflow(dmc_header->fw_size, 4u, &payload_size)) {
+		drm_err(&i915->drm, "DMC fw_size too large (%u dwords)\n",
+			dmc_header->fw_size);
+		return 0;
+	}
+
+	if (!payload_size) {
+		drm_err(&i915->drm, "DMC firmware has empty payload\n");
+		return 0;
+	}
+
 	if (rem_size < payload_size)
 		goto error_truncated;
 
@@ -674,12 +682,15 @@ static u32 parse_dmc_fw_header(struct intel_dmc *dmc,
 		drm_err(&i915->drm, "DMC FW too big (%u bytes)\n", payload_size);
 		return 0;
 	}
-	dmc_info->dmc_fw_size = dmc_header->fw_size;
 
 	dmc_info->payload = kmalloc(payload_size, GFP_KERNEL);
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

