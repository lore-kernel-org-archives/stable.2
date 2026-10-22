Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792686416;
	b=PwqlD+ZatT+ZJuzwWbcrvdOGIAOounCbdw47yqzIyHvgU5Nlxp0pahFe8tvPI+WIzd3d
	 hr/TYl94TbFneuddS/NrxRrU+kR1Ki1dN/bp/t8vf2MmAs7KFpFNviHlsULsDCRQfYny2
	 mpRkAPWLLwZc2cjE6isoFuqwzZ7OASrZ40qAy+x8Y7DHn61UqoLDT7QlJtTFhyUQAN2L1
	 nh6Yq9TZ97o6GslU1iq6ZAtsZ+bL/mflMWafwDpmvkwpjVbC2d3HychE3/8PCAtSmzGZS
	 NmI25BOV5SlpBgykeacaKf5Y6bz+4/+NeZ81gpobxmV9JZY6L7K+qpQbNfUl87TnJyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792686416;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=1nPd8DodVSjOZGjcRv2BZesmX1UDqVdzrdm0eIvTKmQ=;
	b=uQgNlLiP12iZ4ZXZyPenecYa4eMbbRIYK8rGUsYDl/0hV5dlcaUxBtBpOYM6BekyEWaR
	 +LVpsQoH09TnFgtw7kJ79N4LdNqNIwUqBfzvmS3sImB0DyjtUbdCSALEU3wOdHiPVvEmY
	 dku9XggYYIKJzDGSHqQGPzkql9oxpDhE6OXs0pWHYO6Cs9hHMnIMQWvPVcYG+W097+2ob
	 WGk9vCrBcl5tQJhQMJ+UuIFsePBWgDq4PTcEyao0qQ0EZUeLxE9LMA6n7DNJ67GYRsPCK
	 Q9/Hpy/1nKWWP/3oeihYr37ViAmbNqWoqSiPGZ7s+0AJ85RhbIiiixIL+EZHb5Dz/WA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kAGrfRGQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBE1606A319
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 16:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kAGrfRGQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B4A91F01825;
	Thu, 22 Oct 2026 16:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792686416;
	bh=1nPd8DodVSjOZGjcRv2BZesmX1UDqVdzrdm0eIvTKmQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kAGrfRGQXwH8xRLMC2/TulbBTm91KZ16PyfkgHF9yGwAFp7T+2UZpGOLV5q8SpWll
	 Nwx1GnPO+8z16RjxH7Fs5X7f6gs6q2TCrNwezHRApsV8RxcOhMtMYqpt85ukXPdwGZ
	 SmNGZAv9bzV83O22iMAtiztGhi4D4NQ21Da29xPVDfxJxZt/eyC4v/iZPE51Vm6A1G
	 v1sxAmrVNTbsQnn0oqmBBT2HDKNa0NjB6HQGgULrI7OI4ImUqS8B9aHu3vhgsBLJoE
	 B//5IR8KXaDEvVdvudg82SQ4ibxe4wf+9iEuN7adNaHitr9aqHM4ZC3EGWebtph2Gx
	 s1GcrJmYBy2pA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dibin Moolakadan Subrahmanian <dibin.moolakadan.subrahmanian@intel.com>,
	Mitul Golani <mitulkumar.ajitkumar.golani@intel.com>,
	Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] drm/i915/dmc: Harden DMC firmware payload parsing
Date: Thu, 22 Oct 2026 12:26:53 -0400
Message-ID: <20261022162605.1728647-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102112-observant-ungreased-d48c@gregkh>
References: <2026102112-observant-ungreased-d48c@gregkh>
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
[ sashal: adapted parse_dmc_fw_header() changes to the existing parse_csr_fw_dmc() implementation ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/display/intel_csr.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_csr.c b/drivers/gpu/drm/i915/display/intel_csr.c
index d5db16764619c..086ba8720558e 100644
--- a/drivers/gpu/drm/i915/display/intel_csr.c
+++ b/drivers/gpu/drm/i915/display/intel_csr.c
@@ -439,7 +439,7 @@ static u32 parse_csr_fw_dmc(struct intel_csr *csr,
 	}
 
 	/* Cache the dmc header info. */
-	if (mmio_count > mmio_count_max) {
+	if (!mmio_count || mmio_count > mmio_count_max) {
 		DRM_ERROR("DMC firmware has wrong mmio count %u\n", mmio_count);
 		return 0;
 	}
@@ -454,12 +454,21 @@ static u32 parse_csr_fw_dmc(struct intel_csr *csr,
 		csr->mmioaddr[i] = _MMIO(mmioaddr[i]);
 		csr->mmiodata[i] = mmiodata[i];
 	}
-	csr->mmio_count = mmio_count;
 
 	rem_size -= header_len_bytes;
 
 	/* fw_size is in dwords, so multiplied by 4 to convert into bytes. */
-	payload_size = dmc_header->fw_size * 4;
+	if (check_mul_overflow(dmc_header->fw_size, 4u, &payload_size)) {
+		DRM_ERROR("DMC fw_size too large (%u dwords)\n",
+			  dmc_header->fw_size);
+		return 0;
+	}
+
+	if (!payload_size) {
+		DRM_ERROR("DMC firmware has empty payload\n");
+		return 0;
+	}
+
 	if (rem_size < payload_size)
 		goto error_truncated;
 
@@ -467,7 +476,6 @@ static u32 parse_csr_fw_dmc(struct intel_csr *csr,
 		DRM_ERROR("DMC FW too big (%u bytes)\n", payload_size);
 		return 0;
 	}
-	csr->dmc_fw_size = dmc_header->fw_size;
 
 	csr->dmc_payload = kmalloc(payload_size, GFP_KERNEL);
 	if (!csr->dmc_payload) {
@@ -475,6 +483,9 @@ static u32 parse_csr_fw_dmc(struct intel_csr *csr,
 		return 0;
 	}
 
+	csr->mmio_count = mmio_count;
+	csr->dmc_fw_size = dmc_header->fw_size;
+
 	payload = (u8 *)(dmc_header) + header_len_bytes;
 	memcpy(csr->dmc_payload, payload, payload_size);
 
-- 
2.53.0

