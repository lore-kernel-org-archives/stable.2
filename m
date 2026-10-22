Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792673707;
	b=MYp8/KZbPD5jAgwrId38qUVcqLVbX+pL8o4nYEBRBxv754h18EIeY/cUCdy7cwAZ7Zk9
	 z7gzjvwZojPnO20wTZhbArol4ZYes4rit+rkXFeRJSuSA67fpGJLisYCpP+kSsIGBkflw
	 80xGJl/Np2Cgp+dPadUAeK3QQMDeFjKSIU2iA6egVlzQ92p4s/EkkD4jl/kLSr1OTTAV3
	 h0X1WJXT269FiUm8wFX+E+w5uM7647yA0uZUTs1x5kjwHKz7cDOcJGxs/UOWyFq8PPFuR
	 /KGxzZh/XZ0hn+TCOmz7dSQtboJrQcFQ9OljfK8kVfIbYzb/yET1IOkBM2M2TgcN4/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792673707;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=H8DFoxt5zy8uCsvpWqodTyMFJID0sWP0UTMoV2TVPto=;
	b=C6GL6doxMXOecDWHnnIDKwb5xQVRn89JUR5eYdISjLU3qn2fRIKHyDybYDx7GteGRwKl
	 o5ZgkFLGAyuWLjNzZgz9ZNln2GrTJHp78UCaPjKH15U6AmUjFS9eSCB5mO1IjETL4N6aI
	 A4hFTHuLxqifCApA6w6C18IBk+4GtJN58y2ZwC8P81uJOdUhxXwQj2el+47+7C4a+M84V
	 gxiJPgdze30I0G2F7OZHcbMQTP0Ys0FsrgJVJ6mGvsjW+VlJNLE+aHlJkQgBd6lBa2GOi
	 qpKytIv7JBPVx/I+y1p7IqpROsWCVqNSLR8b4vTlzCHY2Isiw0xw2YAy47/D6VE0ZnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eXepuRjC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46695606A319
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 12:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eXepuRjC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F9631F000C1;
	Thu, 22 Oct 2026 12:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792673707;
	bh=H8DFoxt5zy8uCsvpWqodTyMFJID0sWP0UTMoV2TVPto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eXepuRjCPJvK97ahUuZYelFUD0PgBO2KGKj6wip4tcABzDQWZO4JlIjajQb8JdpmT
	 elMZqD0VUvJnEvwVhZ++P7RACZ4tEkQbBKkgTiGfgeZNFLBsGtikkXoGNL/E6zJfWM
	 kHCCRwHqGiJE4kgcF8yh+D1t7VsaBnLmZh0UO0ixOzc3xXpJykQXIcQG/6eIzbMxaj
	 mVKPUpvLSqDV9OAedaEQar9XooqUa5kPwcsADkp+dGFJQY4UqhY26LtQM/AC/Klybg
	 VTsT/vrH24q9myglDp1k21OuNcg4FfkG7G+m8OHpl0aehFWJ4+7d/DnmRvxbr4F1t7
	 La7U692wBgIkA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dibin Moolakadan Subrahmanian <dibin.moolakadan.subrahmanian@intel.com>,
	Mitul Golani <mitulkumar.ajitkumar.golani@intel.com>,
	Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] drm/i915/dmc: Harden DMC firmware payload parsing
Date: Thu, 22 Oct 2026 08:55:05 -0400
Message-ID: <20261022125422.1187451-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102110-spry-excursion-fbc9@gregkh>
References: <2026102110-spry-excursion-fbc9@gregkh>
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
[ sashal: Changed logging arguments from `display->drm` to `&i915->drm`. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/display/intel_dmc.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dmc.c b/drivers/gpu/drm/i915/display/intel_dmc.c
index 7c756d5ba2a22..641dabf275e73 100644
--- a/drivers/gpu/drm/i915/display/intel_dmc.c
+++ b/drivers/gpu/drm/i915/display/intel_dmc.c
@@ -796,7 +796,7 @@ static u32 parse_dmc_fw_header(struct intel_dmc *dmc,
 	}
 
 	/* Cache the dmc header info. */
-	if (mmio_count > mmio_count_max) {
+	if (!mmio_count || mmio_count > mmio_count_max) {
 		drm_err(&i915->drm, "DMC firmware has wrong mmio count %u\n", mmio_count);
 		return 0;
 	}
@@ -819,13 +819,21 @@ static u32 parse_dmc_fw_header(struct intel_dmc *dmc,
 			    disable_dmc_evt(i915, dmc_id, dmc_info->mmioaddr[i],
 					    dmc_info->mmiodata[i]) ? " (disabling)" : "");
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
 
@@ -833,12 +841,15 @@ static u32 parse_dmc_fw_header(struct intel_dmc *dmc,
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

