Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792682072;
	b=tUN1rs3YIUn68S+LdR70y9hHyWBRtFKKru0H8EJEo0b/fHCf6w8KyVeHC4Xo4TDarRqs
	 GyaNWRWba0WsEHwu8UG+00saqOAtngZ1F27eNqSNz0FqfpDSnH3gZZNZYJjjE7ncaWX+M
	 tNN9dl8BH0JOAzxNfSJ5qSkTf1q37ULD5XQNqkWjWQbscQNajx8tRJgUJQJVrlpynmK8N
	 8lxgDKQW+dGCL398CxWepU4U8TsTUCtD8xDHZd2HZeaBl1GmPSOZI5sBBkOqtSGQHfSEe
	 fSiLkMapEVID2reWKUvfdCDgoFiExaBxjeqSaxW6qGvm9VLk+u8CsKdDPqam/ooMt0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792682072;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=+54fDur+D7mK8N1hyKo2kfkibhnJ75lsD6CQJTGplec=;
	b=dFeCbh6lOgjCE5eUNjFx9dVbAQBtbDrxs5cT86bmVEPXOmOZJBPgh1gin58uuBA8lE+p
	 CFgsHFmVpGpGjSmPxp1FxRJjtpgXGE/yjlDGGvgvYyqog7F8tHnlu9UygmVxhY79oLEeO
	 xALuonUxG3P0jBFQWnpDpv8sldDNqVU+Muh5wbKvqJuweSoOHpQf+plFibHdUQZWG1q3p
	 O48Ax825pVNbLZMC9MDYU7Kir6vr1JKQedKzCPwJMnoqgCkNFTMkCjLXCTBqPf9y9yD2B
	 o4s0IsyaM4F0KhiP6KUfWtLsqIefcRNFreiIzj0k+W9HCc/4TQA6PvGdB42dTac51JA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QYp8yi4L;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3269F606ACD9
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 15:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QYp8yi4L
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BA041F01825;
	Thu, 22 Oct 2026 15:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792682072;
	bh=+54fDur+D7mK8N1hyKo2kfkibhnJ75lsD6CQJTGplec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QYp8yi4LeOkwrGwAQoOMqnau5Tmv5PnWghwzkfWqC1bFJ4F4ZNKnDM8yyo49jWOgu
	 VuR2iFnL+7tzYc9Wi7Yf+rwVdQXU+NL2fRaTnrijbnxrgMj51eB8G6MJTFxENzobqO
	 VlFlktx7RXDAUT1wbv+r+OI2GIg5PMbpWHGqWhzmWJv9X6Qs05XO/DMV4PR5ojwcgn
	 FWOBf1Umw+cKqpv+a8DgLS6b+X8WnlLKyD/FheAIVOCMkzbWS06PRx4Rev4Z4ffrlW
	 PmN40hpfzzz3rb4zD92FGfgMNMJRM3a8qiHhX2e0k3+ecKwczpqT8l3+H1yvZKm7fK
	 wBnP8XP7z9beA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dibin Moolakadan Subrahmanian <dibin.moolakadan.subrahmanian@intel.com>,
	Mitul Golani <mitulkumar.ajitkumar.golani@intel.com>,
	Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] drm/i915/dmc: Harden DMC firmware payload parsing
Date: Thu, 22 Oct 2026 11:14:30 -0400
Message-ID: <20261022150729.1593802-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102111-chief-uneven-0c72@gregkh>
References: <2026102111-chief-uneven-0c72@gregkh>
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
[ sashal: changed drm_err() calls to use &i915->drm instead of display->drm ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/display/intel_dmc.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dmc.c b/drivers/gpu/drm/i915/display/intel_dmc.c
index 0e04d4dd1c132..a0d6eb90d55a3 100644
--- a/drivers/gpu/drm/i915/display/intel_dmc.c
+++ b/drivers/gpu/drm/i915/display/intel_dmc.c
@@ -477,7 +477,7 @@ static u32 parse_dmc_fw_header(struct intel_dmc *dmc,
 	}
 
 	/* Cache the dmc header info. */
-	if (mmio_count > mmio_count_max) {
+	if (!mmio_count || mmio_count > mmio_count_max) {
 		drm_err(&i915->drm, "DMC firmware has wrong mmio count %u\n", mmio_count);
 		return 0;
 	}
@@ -492,13 +492,21 @@ static u32 parse_dmc_fw_header(struct intel_dmc *dmc,
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
 
@@ -506,12 +514,15 @@ static u32 parse_dmc_fw_header(struct intel_dmc *dmc,
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

