Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E681957ED9B
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 14:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788963068; cv=none; b=DRnSkclsNRjzXcAO63vxsYN+tPJ22olwKJ9JWb94GhZs89kPWo0u9kYFeeEGYA9pHot2ZVYlBE30PLGtXkmbrL5wk/TmINarawr2C0tLLaLe68HJ6X+Ld81Q6P8psAUigt1Td9OMatm/W8uLVHv6YxRcr3ZFzMNPk+fCfc07oPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788963068; c=relaxed/simple;
	bh=3U891SNNHra6g4WNjtcV/9r6hySpVtHgJYV+aiAHS1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kO0HQwDTs6TbTKfUXJ4lPGiUsEWkbYeXlydnA5YmBT6D18KY9G0j+2X/nmnEY1rlUiVicJ6Q85LG8UbE9cKID7p0bPi4coShxmQ0kPBsabhu7KTc7ACgNmuyLeVKdUlQguasTFZZ0qI6kFh39dKGButKJJ+ujxLnC4hu2zn8aMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q5l4hZvN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q5l4hZvN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41E231F00A3F;
	Wed,  9 Sep 2026 14:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788963066;
	bh=1WSONkyaZ9K2VdUN7e4chN6NGMd2MCsFlbL/JmfcSv8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q5l4hZvNpom3vZ3tm7D8cXqnFA/yKZsoXfrlW2ZIAiyJXqt0qlR3zrhVyI0Y1tSoi
	 /JFRRnw1x8sH6VXif+cg/OivLlVruoo9uHCbk/F5MDihvrr22yNZBk6YYGMS/1Jo0I
	 l0552vmhQDSF41ROEo0B+PV0wi29EcL7smm1UV9nTJA+hSKA+k+aNIkY0TxtGKgmKF
	 qD3eZmuVpFaoheaq3SusipB1U8KCgBFP4xb9M69LZsUOQSJI70agDPSrgwUFcOgSYd
	 nBB2ACeNEqGjYOiXHQHTTK4cE/tPTL2dV2ofnQvIJlhP/9n8D16+s/gVFftBa1kuNr
	 +Q53bSQ4aQ7Zg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/7] platform/x86/intel/tpmi: Check major version change for TPMI Information
Date: Wed,  9 Sep 2026 10:10:58 -0400
Message-ID: <20260909141102.2383363-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909141102.2383363-1-sashal@kernel.org>
References: <2026090334-lumber-underfoot-3bf9@gregkh>
 <20260909141102.2383363-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

[ Upstream commit 59eb0814d6a3541f55b1d6e3d52df1226de41f3e ]

Check the major version from TPMI information header and fail to load
driver if the version is not supported.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/r/20240423204619.3946901-3-srinivas.pandruvada@linux.intel.com
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Stable-dep-of: 3de2776e9d70 ("platform/x86: ISST: Add a NULL check for sst_inst[]")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/intel/tpmi.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/intel/tpmi.c b/drivers/platform/x86/intel/tpmi.c
index 021e56f52ac12..9c38e44177df6 100644
--- a/drivers/platform/x86/intel/tpmi.c
+++ b/drivers/platform/x86/intel/tpmi.c
@@ -623,28 +623,37 @@ static int tpmi_create_devices(struct intel_tpmi_info *tpmi_info)
 }
 
 #define TPMI_INFO_BUS_INFO_OFFSET	0x08
+#define TPMI_INFO_MAJOR_VERSION		0x00
 
 static int tpmi_process_info(struct intel_tpmi_info *tpmi_info,
 			     struct intel_tpmi_pm_feature *pfs)
 {
 	struct tpmi_info_header header;
 	void __iomem *info_mem;
+	u64 feature_header;
+	int ret = 0;
 
-	info_mem = ioremap(pfs->vsec_offset + TPMI_INFO_BUS_INFO_OFFSET,
-			   pfs->pfs_header.entry_size * sizeof(u32) - TPMI_INFO_BUS_INFO_OFFSET);
+	info_mem = ioremap(pfs->vsec_offset, pfs->pfs_header.entry_size * sizeof(u32));
 	if (!info_mem)
 		return -ENOMEM;
 
-	memcpy_fromio(&header, info_mem, sizeof(header));
+	feature_header = readq(info_mem);
+	if (TPMI_MAJOR_VERSION(feature_header) != TPMI_INFO_MAJOR_VERSION) {
+		ret = -ENODEV;
+		goto error_info_header;
+	}
+
+	memcpy_fromio(&header, info_mem + TPMI_INFO_BUS_INFO_OFFSET, sizeof(header));
 
 	tpmi_info->plat_info.package_id = header.pkg;
 	tpmi_info->plat_info.bus_number = header.bus;
 	tpmi_info->plat_info.device_number = header.dev;
 	tpmi_info->plat_info.function_number = header.fn;
 
+error_info_header:
 	iounmap(info_mem);
 
-	return 0;
+	return ret;
 }
 
 static int tpmi_fetch_pfs_header(struct intel_tpmi_pm_feature *pfs, u64 start, int size)
-- 
2.53.0

