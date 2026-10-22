Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792676584;
	b=U9ub3y6RZeToBDTh5BDVRmUS5fXfy6IwchQ2KuP0YUz6knuR89mwBTZHnHPacYb+f9+R
	 QU6vX5iNVZGB3+eg/Pe+WQMe8JVYw0mnaUX6a+IGh+QBiK9IgcpfMtIC/j0CF3z5z/RdX
	 O9YtdsnYPigICZQp4tLbeEc2L8eE6FTDxuBMGTS0Kvoume8Kw8ymLBprbEtUeHfrgDBUD
	 vRJCfanca53PRJIHeEpfWGEw5eEMrxie6bgO/1Pctf55hmW80IKd86IIuDch9aP9cGQ1X
	 rCZwv6Psi3nJDndvS8HODGrZXe50Fu/XaG6rBEj9y8+SyyuvYBL6bYlJBu97qR81Rmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792676584;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=h7FrYet7YUHoYufoRqbLQxxsZwqV5R2ggGMt0y3sYOA=;
	b=KdiQFLIiWR01gZvkNX0gBNSBpZdr9MqPksEXvhA4PVW8G6gexf7I8UoSdPEFMSTTqVh2
	 rWHsU80EJQ8Bt/i2TqkXq1o61b1ypY90Hp20Oj/+Or6EEhkEHCvVlRbyxqAeU9owUjX1M
	 HMLFB0OMPfi6uH/p9H/2Acea4ogdwxCTANSHOT72bAslmXY78n069378rGS5d++DHz4x4
	 BZdMZL5OTvhVY5vkTsHMVZFDRc/yOLPpase8IKnyD5oIQOSR1LVnNOWLQHPTA2LnnuDHd
	 6qpRPl+qL4w3hRXWwlnFgvkbyp8u0LOfv6SvEBEITnJIlElVMzkn16eHocI23ywFW3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LK46ASij;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C64760A263E
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 13:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LK46ASij
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ECCD1F000C1;
	Thu, 22 Oct 2026 13:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792676582;
	bh=h7FrYet7YUHoYufoRqbLQxxsZwqV5R2ggGMt0y3sYOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LK46ASijjxziTW+Da06T6waNh6nzA7kqso/T8lpEm0PvIDiC8RFJNMsqjQAZs7dvJ
	 UBGcsgUCf0w00JR6MCWF2eVa+sutq900oH9EI9eJq7thLolYitvbCKCTCl1Vm9IqEu
	 +Wb1q8dirFXGtiLDLplK48g45+JFFMCE6fJwJV4Ii9d2zNxWOI29GKwAzP6lQwsi8T
	 904IIo518t+gLq0RGJsOkVLrRplbF1rT/F9VCi8TZTy48J/HdNWUZDSir48reUxJTn
	 Yd1nUD7xt5YR+gQAaC1IEMfXSmYkcMHCCUF2d+p3HG7BH+C2+LjeBwwc1Optw73To5
	 O9g1c5rpLYi6A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dibin Moolakadan Subrahmanian <dibin.moolakadan.subrahmanian@intel.com>,
	Mitul Golani <mitulkumar.ajitkumar.golani@intel.com>,
	Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] drm/i915/dmc: Harden DMC firmware payload parsing
Date: Thu, 22 Oct 2026 09:43:01 -0400
Message-ID: <20261022134232.1444500-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102111-doubling-vendetta-47d0@gregkh>
References: <2026102111-doubling-vendetta-47d0@gregkh>
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
[ sashal: Changed drm_err() calls to use &i915->drm instead of display->drm. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/display/intel_dmc.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dmc.c b/drivers/gpu/drm/i915/display/intel_dmc.c
index 8751973b5730f..8d42ae60d8625 100644
--- a/drivers/gpu/drm/i915/display/intel_dmc.c
+++ b/drivers/gpu/drm/i915/display/intel_dmc.c
@@ -770,7 +770,7 @@ static u32 parse_dmc_fw_header(struct intel_dmc *dmc,
 	}
 
 	/* Cache the dmc header info. */
-	if (mmio_count > mmio_count_max) {
+	if (!mmio_count || mmio_count > mmio_count_max) {
 		drm_err(&i915->drm, "DMC firmware has wrong mmio count %u\n", mmio_count);
 		return 0;
 	}
@@ -785,13 +785,21 @@ static u32 parse_dmc_fw_header(struct intel_dmc *dmc,
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
 
@@ -799,12 +807,15 @@ static u32 parse_dmc_fw_header(struct intel_dmc *dmc,
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

