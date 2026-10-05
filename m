Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE4C31F989
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 13:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791208548; cv=none; b=dKyuz15wPN+Haf4vKM7IF57SXh7HCg8tzUhAznHLxlTv1kthqXH9hXKbIPGUfwzJJt/fviEbM1o4E1PjShnSOpD5xE8Hna2DOwkmlT5BoutuFq7y/MChSD1C3eSZz/aeCk+AGGYfEOB8ZLX53aGxPiQsm71fLW7clQcMx/EIzXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791208548; c=relaxed/simple;
	bh=12efwERGA3ZMLV2Z4ZdtvR4HzHHN9sGcUtOossAMAHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cAwFis54l+OXbKCcq8snDUxnFHWx6asjfus4QGBc0wQ/MayTANxE5gahUfCJUVYuBJ6QW9xRKpjDWQ/WZKk621PK+hRKJbFHIWANmwKO7d8CLvQP8uyyJ8/XIq3aAjUtQUVxxaNsHHCGitSHg4J3F1NPgez6VfvbOBaXOLijJxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zvh79R9s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zvh79R9s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2C861F000FF;
	Mon,  5 Oct 2026 13:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791208547;
	bh=MNMzhciw/HYcCDh8BxnUhOp+6/eRlqcmmsiBCVD785g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Zvh79R9s0CmRM6QH/yAYAHGRaM6LKPPakyWkWMGThdYsDbK/C0C2MkDQYrzLtYdlJ
	 TAPyMfKawIpS0am7tZ7TBVZqM7K79fFn9/OFpsWs3zBN7wg0R5jlwKg38XuQRlorbe
	 ETF7FMvowSTDsOZtdFtU/IxgMtRRczAo902AiqQAC6OVT4E4ykWw4O+simnyndUank
	 XAlQsY+Uo4cSHAjG0Etl4IHEJsTrTwN1OBLb6fRLRCdQXx9Y3AkEXzx1PBB4EJc5rG
	 xkqXPpKu9kIdPiMIhQMMkdafk7TULZbI18tFPHnyptFyJNngHt4gfTfPE8sJSuXbqb
	 38TYpQVG7BSww==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
	stable@kernel.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] soc: qcom: geni-se: Correct QUP Core ICC vote constants
Date: Mon,  5 Oct 2026 09:55:43 -0400
Message-ID: <20261005135529.2985876-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100549-calibrate-runaround-637c@gregkh>
References: <2026100549-calibrate-runaround-637c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>

[ Upstream commit 1cd9b1be5a9c56fd69e3f555b200a1844f9b873e ]

The GENI_TO_CORE ("qup-core") ICC vote selects the QUP Core 2X clock
rate. The CORE_2X_*_MHZ constants are expressed in Bps, but their
values are several orders of magnitude too small. For example, the
50 MHz threshold is represented by 2500 rather than 25000000 Bps.

As a result, clients using these constants can severely under-vote the
QUP Core clock.

Correct the constants to their intended Bps thresholds so that the ICC
provider selects the corresponding QUP Core 2X clock rate. Drop the unused
definitions.

Fixes: 58ffbba6a399 ("soc: qcom: geni: Support for ICC voting")
Cc: stable@kernel.org
Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Link: https://patch.msgid.link/20260915-correct-icc-bandwidth-vote-constants-v2-1-f78eb611204e@oss.qualcomm.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/qcom-geni-se.h | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/include/linux/qcom-geni-se.h b/include/linux/qcom-geni-se.h
index f5672785c0c4a..c54580c480768 100644
--- a/include/linux/qcom-geni-se.h
+++ b/include/linux/qcom-geni-se.h
@@ -265,17 +265,12 @@ struct geni_se {
 #define QUP_SE_VERSION_2_5                  0x20050000
 
 /*
- * Define bandwidth thresholds that cause the underlying Core 2X interconnect
- * clock to run at the named frequency. These baseline values are recommended
- * by the hardware team, and are not dynamically scaled with GENI bandwidth
- * beyond basic on/off.
+ * QUP Core 2X clock votes used by GENI clients through the "qup-core" ICC
+ * path. Values are in Bps and must be converted with Bps_to_icc() before
+ * setting avg_bw.
  */
-#define CORE_2X_19_2_MHZ		960
-#define CORE_2X_50_MHZ			2500
-#define CORE_2X_100_MHZ			5000
-#define CORE_2X_150_MHZ			7500
-#define CORE_2X_200_MHZ			10000
-#define CORE_2X_236_MHZ			16383
+#define CORE_2X_19_2_MHZ		9600000
+#define CORE_2X_50_MHZ			25000000
 
 #define GENI_DEFAULT_BW			Bps_to_icc(1000)
 
-- 
2.53.0

