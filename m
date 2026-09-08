Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8412349B15
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 16:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788883294; cv=none; b=a3bUKOTBx9YD1bnurHdpnAzZc3qJ1eqd47RoeVO2TVg+gVDU/GNO1TIxJSy5uwkrDZ0Yd7QH6XzvYiPgD4J8+ts+Db2/wsjgO+8M+IdhMesAg8EjXe8EqHHOE7AolrR32MjIuxVTdr3J4GEl73CFN2mYu/bGVCV5rUMUiZK0Vu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788883294; c=relaxed/simple;
	bh=aPwTK+xim3Uq/NKoIEmG3/YLwPLPqOfNoBR9u1Pb0so=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fz/YTX+Xd65rpIiKpb8EOSKbMIUyQjFCAuu+Ahi9xdBwSefeMGgMIqfM+AcNOxfm2jXt9hUcobGU8h+O+ebrrQkAUlUY/u579cjfqTS7fa3+c2B7fUuHc6huhB/RG6E3+KdqJt0VVirKCiWz4diXocB4LLYcroKKm3rC4qXZqc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kbBxVDTP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kbBxVDTP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF35F1F00AC4;
	Tue,  8 Sep 2026 16:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788883292;
	bh=SFiV/paNxmoUqi4S9ZFZrnYPmeIRXIt4FDJVT1XSBYs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kbBxVDTPIxTZ3C19E1uXUgpCebf7SNmsgSxsaKIB/Lq3ooNf0GtkJAz6mKaVzSrjV
	 hc73oFo08cbM9b7FMGjnf3J+FnckenSTbp9K4DN8yPCAGukiMwmwCVRE9MU2sFESqm
	 tRzkZAyQhf6hpSLEQd4rP9k/fOG4hMWISPuWnQanvBQiHRkhA087wwjYj3/dV1a8j/
	 7rNi1t03G9PxdOebKy/8gebYTVApEcokgw1KwpCM6tOjX016O4lKSye8ey8vWyKDpE
	 Ie73lf8LaXg08IReyxEKojTnxng+7IOwncKi76EBOVIQfwzJTlZ+dSX6MI2TQdo3BM
	 ON3fmbUC2NiXQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Terry Bowman <terry.bowman@amd.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Richard Cheng <icheng@nvidia.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 4/4] cxl/ras: Fix cxl_rch_get_aer_severity() wrong severity register
Date: Tue,  8 Sep 2026 12:01:27 -0400
Message-ID: <20260908160127.2548313-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908160127.2548313-1-sashal@kernel.org>
References: <2026090317-roundish-company-df16@gregkh>
 <20260908160127.2548313-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Terry Bowman <terry.bowman@amd.com>

[ Upstream commit 9d399526128bae184b153deab42b49f5f3eea2ed ]

cxl_rch_get_aer_severity() classifies RCH Downstream Port uncorrectable
errors as fatal or non-fatal by ANDing uncorrectable status with
PCI_ERR_ROOT_FATAL_RCV. This is wrong because PCI_ERR_ROOT_FATAL_RCV is a
Root Error Status register bit (bit 6), not a severity bit. ANDing it
against uncorrectable status tests a reserved bit and produces incorrect
severity classification.

Fix by ANDing the unmasked uncor_status against uncor_severity. Per
PCIe Base Spec r6.0 Section 7.8.4.4, each bit in the Uncorrectable
Error Severity register indicates whether the corresponding error is
fatal (1) or non-fatal (0).

Fixes: 6ac07883dbb5 ("cxl/pci: Add RCH downstream port error logging")
Cc: stable@vger.kernel.org
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Richard Cheng <icheng@nvidia.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Link: https://patch.msgid.link/20260803221810.3685703-3-terry.bowman@amd.com
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cxl/core/ras_rch.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/ras_rch.c b/drivers/cxl/core/ras_rch.c
index ed58afd18ecc9..cc70373d97fc5 100644
--- a/drivers/cxl/core/ras_rch.c
+++ b/drivers/cxl/core/ras_rch.c
@@ -79,11 +79,11 @@ static bool cxl_rch_get_aer_info(void __iomem *aer_base,
 static bool cxl_rch_get_aer_severity(struct aer_capability_regs *aer_regs,
 				     int *severity)
 {
-	if (aer_regs->uncor_status & ~aer_regs->uncor_mask) {
-		if (aer_regs->uncor_status & PCI_ERR_ROOT_FATAL_RCV)
-			*severity = AER_FATAL;
-		else
-			*severity = AER_NONFATAL;
+	u32 uncor_status = aer_regs->uncor_status & ~aer_regs->uncor_mask;
+
+	if (uncor_status) {
+		*severity = (uncor_status & aer_regs->uncor_severity) ?
+			     AER_FATAL : AER_NONFATAL;
 		return true;
 	}
 
-- 
2.53.0

