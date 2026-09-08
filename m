Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9169F5592F5
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 13:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788874006; cv=none; b=GzLKE5kRBmvgMlDgGoZ0jE6NKnty3hGaguU/5D1AU9B1wlxukC44fL9BS5UDusL3Hqaww3I3zObB1MylCLnixgM/qD1MH/rhSQP+aXH9fnXbBiUNOZxc0JB9lITEU8nyIHskI8VmPFejD2gO0i7nsv7/J9LUFHZavIeSOu7uALs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788874006; c=relaxed/simple;
	bh=aPwTK+xim3Uq/NKoIEmG3/YLwPLPqOfNoBR9u1Pb0so=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V02HObRo2riDA0t6/pJvjW8NhrZ5enwZj4rmCMmNH4oOXlLxN6QBpjQqnTUr4qGgM7N7yodh+sfGnrU7RIQtTYpV0VMNNiZJO66EwtWNNT265Tp4DUpZxgdpiwJMvfva2aKiR1n/L6rN7B92saT/vFaSVXtZ8CdQtBMjzIhhBGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yu2BlKeD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yu2BlKeD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B519F1F00AC4;
	Tue,  8 Sep 2026 13:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788873994;
	bh=SFiV/paNxmoUqi4S9ZFZrnYPmeIRXIt4FDJVT1XSBYs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Yu2BlKeDwThb8UFAvffa7y4d6Fb3Y9FvUKepZ8eJlYBryzCHVjm/yi0fP0f8c71GQ
	 w8veHbz/KuEFWBevylZzfYWUfw09q2z3MZlTV3n7pKlGPRmBhzyUk47P1Z1jzjZjVm
	 T8hCk8q1bVEApz3HVoILOI8eZ5H3Xr/fxmnBNZ/IFNhXK0MZ0b8yU8ASdmW+FQXIse
	 qi8b90Mz7LSTIMyJzFjk1uLqxxBDoENYW4R+eQW/2DemO5VzXVhsiHl/fu7FjZBQRB
	 V9Ge+NlIb5LCb9vZSNKoKnO9hVKAz0B0rLf5BgMI2Jd0XfPj1K8XkAIdd6C6/j10qD
	 ggcBewMcor0Vg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Terry Bowman <terry.bowman@amd.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Richard Cheng <icheng@nvidia.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] cxl/ras: Fix cxl_rch_get_aer_severity() wrong severity register
Date: Tue,  8 Sep 2026 09:26:31 -0400
Message-ID: <20260908132631.2302890-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908132631.2302890-1-sashal@kernel.org>
References: <2026090317-uncooked-enduring-e40a@gregkh>
 <20260908132631.2302890-1-sashal@kernel.org>
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

