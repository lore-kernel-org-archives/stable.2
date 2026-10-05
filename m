Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2884D483BEB
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 14:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791209434; cv=none; b=d6RKK1FN18JLzqzPXsJhu7UREpUrxhT/8/IuuDQ3N+UCY9htbkBDVW0v+QjpidYYfRW/cYOl0wAXxDFEOQ8DX2gMaf6+OlnM5wPO5RIPtTBGO2Jwh/wvhdmEae7kBJi+C+MN4yY9ly7EY/3w4Lixc3oDva07K/tNCPkcIaUGPJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791209434; c=relaxed/simple;
	bh=N9453Ce0TAJlTTBkmJf+nzTOXuCwU+UwuG5gG6nUvS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K9b05PISOIZor24eEIJmxo0fMcftB2pqW01Zop3a0W3hsbP5RLBObQ+DBVchIRhnJIlNQPzIMgoRTB8GShgrwUVcZLOx3dVEXX6T9s68H2D5gFj8yJqjgoAtacp9QZP2j07pDPJiRLoWtcYqHzs090bclmYOKQ/123zoVSdQQnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K3W1bhxi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K3W1bhxi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2269D1F000FF;
	Mon,  5 Oct 2026 14:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791209432;
	bh=BhaK+WrU/knvGH5VsQPJ445dGoqSf6EtPB5daImptvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K3W1bhxizh5mOQ9/UOdPrGbODKTaIhHJY7eZ1uz2zsnTDKXBuKMzq/6kPpxzIOYdh
	 XM5xxo6o/E32PsCk3kOrCOq5WhMR2Pz3yhRHkRMrRcJ63gWI1K8dzf+LWxEvMcE2Mo
	 6LA6oaqukr/AezhVHnlkpjjPqpym6KSqcUO9jAEEO17IHrmaIxXMFpriliMhzNIUld
	 pw0geI1JsvhB/TW0Aeq+9AhZZoWoqhtWVdvBVt1EJuffCohmXCErBsd8haC9wA+pcb
	 3/CvYxMiqTkJVVOVsTXw2Wgy68WshcOrc5WI9i5ZnIrJTctLGKasMNghkWRTIAoUYZ
	 +q7jDbedoEThA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
	stable@kernel.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] soc: qcom: geni-se: Correct QUP Core ICC vote constants
Date: Mon,  5 Oct 2026 10:10:27 -0400
Message-ID: <20261005141008.3003614-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100550-cradle-juncture-3156@gregkh>
References: <2026100550-cradle-juncture-3156@gregkh>
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
index 964cfe68f72cc..9e98c4525a0ed 100644
--- a/include/linux/qcom-geni-se.h
+++ b/include/linux/qcom-geni-se.h
@@ -252,17 +252,12 @@ struct geni_se {
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

