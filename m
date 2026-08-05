Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64845261B91
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 00:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785888516; cv=none; b=dDOkgH2dlpDDGo4Fr/B3RBTPnq9Cv4qkLckZMRWovjM99sKTungEDR4TVwfpnuUG2wE7ZGon0r40GH7Vumr65cYdYgVq+zB4d/hvBIhYQUASZ4Aau7PDOrL7OFhfjKtLOZpf0BO3xhxcvLng+F7mVptTpMmxWxmlVtKgbSxEdus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785888516; c=relaxed/simple;
	bh=4AUI5wZi/4cqTS1F4+vgkQLD0weQ7bBfpY3n51hBdXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VRdBw3Avhsil3sI3zmNRPGa74A2Gh5mZfUr2Ks4qFV8agE+2nw5RrLbKmIoHfL4AqsAAaoPqkLUi0kxSoFyZkxLDV8Tu6VwB6Nd8kUVHsUlXH57n7r7l37OrcCyoXIyFl+PJ7iHa6HkQrm3pe/NrSiIPio4J9iVM0DC6dNpFA4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BMB5n6YT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BMB5n6YT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B4351F00A3A;
	Wed,  5 Aug 2026 00:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785888515;
	bh=zVy6qRiuTuquc3t4j4o2l+eQWAUfAeiGwpz5H6pgXcs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BMB5n6YT5FjAxYN3qLsLdnVIep74pd4PkmkiZjdVUnxs5wFpRcqMXFcA21RXROfr3
	 SulaZydMKNtCkWO3rqCKvTXNK1lbvPXjB14a74B6eSH+zeMcYChtA2TbkndGVzfh3n
	 njvBCI6IrIpwqNj+EDtLIBOfyzv4vzc47Eu3iRVtiam4piL19ZwEbSOUR1gAoYDwOa
	 lIl/bR5H3/zP/iKGiNuJbMLa9RfRXVrsZPDOnFiGBcHkexPrJ+pzG9DebSmlzuURlz
	 zKsV/aFY0c/Hk6joEKRgLyNigx7vBXgwc/7rXlpNCu9E7K+dWO28+2zdWINN9nRfUl
	 poZt6SV586bYA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
	Bryan O'Donoghue <bod@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] media: qcom: camss: csid-340: Fix unused variables
Date: Tue,  4 Aug 2026 20:08:32 -0400
Message-ID: <20260805000833.3902619-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072933-pungent-everyday-da96@gregkh>
References: <2026072933-pungent-everyday-da96@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Loic Poulain <loic.poulain@oss.qualcomm.com>

[ Upstream commit 0b61ce8dc4a71ea7baa19275c655677c612dde6d ]

The CSID driver has some unused variables and function parameters
that are no longer needed (due to refactoring). Clean up those
unused elements:

- Remove the `vc` parameter from `__csid_configure_rx()`.
- Drop the unused `lane_cnt` variable.
- Adjust call to `__csid_configure_rx()` accordingly.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Signed-off-by: Bryan O'Donoghue <bod@kernel.org>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Stable-dep-of: cc1c35619c98 ("media: qcom: camss: Fix RDI streaming for CSID 340")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/qcom/camss/camss-csid-340.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-csid-340.c b/drivers/media/platform/qcom/camss/camss-csid-340.c
index 22a30510fb792..2b50f9b96a34e 100644
--- a/drivers/media/platform/qcom/camss/camss-csid-340.c
+++ b/drivers/media/platform/qcom/camss/camss-csid-340.c
@@ -55,8 +55,7 @@
 #define CSID_RDI_CTRL_HALT_AT_FRAME_BOUNDARY		0
 #define CSID_RDI_CTRL_RESUME_AT_FRAME_BOUNDARY		1
 
-static void __csid_configure_rx(struct csid_device *csid,
-				struct csid_phy_config *phy, int vc)
+static void __csid_configure_rx(struct csid_device *csid, struct csid_phy_config *phy)
 {
 	u32 val;
 
@@ -81,13 +80,9 @@ static void __csid_configure_rdi_stream(struct csid_device *csid, u8 enable, u8
 	const struct csid_format_info *format = csid_get_fmt_entry(csid->res->formats->formats,
 								   csid->res->formats->nformats,
 								   input_format->code);
-	u8 lane_cnt = csid->phy.lane_cnt;
 	u8 dt_id;
 	u32 val;
 
-	if (!lane_cnt)
-		lane_cnt = 4;
-
 	/*
 	 * DT_ID is a two bit bitfield that is concatenated with
 	 * the four least significant bits of the five bit VC
@@ -120,10 +115,11 @@ static void csid_configure_stream(struct csid_device *csid, u8 enable)
 {
 	int i;
 
+	__csid_configure_rx(csid, &csid->phy);
+
 	for (i = 0; i < MSM_CSID_MAX_SRC_STREAMS; i++) {
 		if (csid->phy.en_vc & BIT(i)) {
 			__csid_configure_rdi_stream(csid, enable, i);
-			__csid_configure_rx(csid, &csid->phy, i);
 			__csid_ctrl_rdi(csid, enable, i);
 		}
 	}
-- 
2.53.0

