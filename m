Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792633806;
	b=sv4uDtfZ6Ac031lkUu6bcV4LgpnAeaMHm99RTEobtajg/8JPrmrXBGZ7WBdTGgHykK5p
	 PMBFhYAHxyDFQbuZZxUjy8aLdM4swh0SjD+ULlm7ms0wjDtExSYXo6SUOfCIrFaa/3Bcc
	 lJCX2Hn9QhTUdEWBKa0/0qKdUwtGOjAG3IGY8Yx9xC7rwiT7IBQ4sxxU0FhPUsxTs1e/l
	 RbThkQ1Fbzago4kByTxZHdGXusm6ZqQ61QbczkbugxcJe3OjsS9W1eg20lYi0P+MADzil
	 hOE3KmexshtAGFHYHs412n6uwqNnjDAndGromIGh/9Aq6mEQ4E75stTTqSaZzcCfdEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792633806;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qr/Rm+ILrxVANLtARrqeGvnJWRvrGPZ1Z8mpGvPnjeA=;
	b=1C2Rm76cnBWX8SkJXLCjbq2qlBVFCVizsR1cNNmHqPA1c2TZWz6ipfVPwjVFjms4Kp+o
	 BhIpYQiTjCxfY7Ytvg1hX49O9ML/hSUGw0A7yBLBs/Po8PvsOE+WkmFAahMd0+t3rVbTH
	 YIFo9EnuB5dVnbKIIRkFxiKeAjcYQIrl69j0DSXRfhZrhYiRs8yo9tWGqmIgIhilwLnyq
	 zN98Rbr/6liYYkmi35dY+TeSwlG0RTb/J5/XA9RnpfaqT/S62Ou3Oxz8MySUgoLzEbzQb
	 yPB+KeeuRIwOYodCK27DHDzRHeWar41UBCzZY4loNRjTj993k3RYH61jzPJtwdC2eug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gzmzUXR3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5DF606A31A
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 01:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gzmzUXR3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 041BA1F000C1;
	Thu, 22 Oct 2026 01:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792633805;
	bh=qr/Rm+ILrxVANLtARrqeGvnJWRvrGPZ1Z8mpGvPnjeA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gzmzUXR3jh07sosfNQ1rVSPBMKsDFQpzCFwe36jfojs89MlZOQ8o5ip1eiyryJSoO
	 +chpsJ4LL7PNehy3+d76oEBfsXZEZg7SRpN8RqQv//YPa0Y7R6QXeMyMHY9ET5DY7t
	 hhY3FcbdwB+iCfHcLmvMbQDoRgxZ6qnNqA50uAbBTX6JwjErkui3MOtndF8xMYJ5CQ
	 LfxHmmAsRdcK5uN/qJrpjSEaWznpjuNuUpvo7Cq8wZV74nSl0TTkiI3fKNB5yi7q5t
	 /FBS9x2A2dWtQk3B7/YDDcwJ95oevWQjx1oavwNO5nw+GAoy9NMeQu6wk/+HJufTb7
	 9X31JOFhzj90Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dibin Moolakadan Subrahmanian <dibin.moolakadan.subrahmanian@intel.com>,
	Mitul Golani <mitulkumar.ajitkumar.golani@intel.com>,
	Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y] drm/i915/dmc: Harden DMC firmware payload parsing
Date: Wed, 21 Oct 2026 21:50:02 -0400
Message-ID: <20261022014926.920567-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102110-duct-scaling-e1b3@gregkh>
References: <2026102110-duct-scaling-e1b3@gregkh>
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
index 36a28da65fcf0..630a5cd68bbd7 100644
--- a/drivers/gpu/drm/i915/display/intel_dmc.c
+++ b/drivers/gpu/drm/i915/display/intel_dmc.c
@@ -1165,7 +1165,7 @@ static u32 parse_dmc_fw_header(struct intel_dmc *dmc,
 	}
 
 	/* Cache the dmc header info. */
-	if (mmio_count > mmio_count_max) {
+	if (!mmio_count || mmio_count > mmio_count_max) {
 		drm_err(display->drm, "DMC firmware has wrong mmio count %u\n", mmio_count);
 		return 0;
 	}
@@ -1211,13 +1211,21 @@ static u32 parse_dmc_fw_header(struct intel_dmc *dmc,
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
 
@@ -1225,7 +1233,6 @@ static u32 parse_dmc_fw_header(struct intel_dmc *dmc,
 		drm_err(display->drm, "DMC FW too big (%u bytes)\n", payload_size);
 		return 0;
 	}
-	dmc_info->dmc_fw_size = dmc_header->fw_size;
 
 	if (!dmc_load_addr_sanity_check(dmc, start_mmioaddr, payload_size,
 					dmc_header->header_ver, dmc_id)) {
@@ -1237,6 +1244,10 @@ static u32 parse_dmc_fw_header(struct intel_dmc *dmc,
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

