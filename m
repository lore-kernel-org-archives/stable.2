Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795043837;
	b=KciLb7Fe2mwhyPXZLmYmfg1qeueWQhdb+SaNw6qlTPiUkdwa/YohB7U9s5j3LxAIVMMS
	 0HtXg97PaSozT1UP4pvWTwbvAUzVYYZ4KiviZIuaao4r/sw3c7U9VoYZuswiSMSKEhhyr
	 2xET0FunszERg1wpWAZSnbxoDaoXUgc+wOAy1BYZnO9qVtZO+PZmpTQZBfqFDByqnVWuS
	 sgxnHAczWqtkfDqH/e/TJnCOLmrSivA6/dol7nKNywFcGXmSMBuO6JPUvBWriBkOwXAUF
	 CfTblzrsO6yKnIUx8cbvzaWk2r5WDuIUJtDFIWV2mHOui+03x00HrML2MSYcDxfO/qQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795043837;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=5dQ4JQj6AUa0iFblGEmenrbjQYznIq7haN0cV2XTtU0=;
	b=zx8F9dO6YwLBSKcM5PzVlOP0UXyfjKZJQOzBW/6Cz6GZezBDfJawHmLQk8gW9qEjWHld
	 w4h73IUvJnVnyPGoK+3VV/nDBX5Hii5OBMm6adt4KwIcG8uBuGQaFdzT9CJPBYuJUcoip
	 LmHQjFm6gcwNB0AQtkKIysORm8y6HgGvSf1Hlyay3DaxubDO5nyBOusIz0EtS4XOE0eu7
	 D3VPv1bx5aLDKPP2pkLVLmGvw8J3VPBjySxpunQ22d9qOD8PsjkTBO3XNFGs0WCKklRuN
	 RZ9yOBiOgdtHwKvjKf/WVNzmJ2JbOiyHGEKrj45KjT2j/iXTe5u7PmkI5rv6jrtK37g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L1TS4pNj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29DF60A2614;
	Wed, 18 Nov 2026 23:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L1TS4pNj
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795043837;
	b=OS5bZbstqsAzZgYMyvbhpSfAlrfBBu2q5djxtebwVrwYTlt13MLo+MOvnWAr/rzJ65RC
	 tZYU9m0S3q7Xlp0AFFck4bem/c+B7qGh4hyioD9C7wTjAcpgaZfBpRYgg3+kTtiYAdmqk
	 ppBvWDIC8oDK3pxS4goEqLalz5LV5lg4YMjj7BVFvXNpoTnzm2Fk8bXCBgDet5HksibdY
	 dGOhZ6Owh/dM4V2K8ldIzxOBUBeMefPzkqmjgsoBN/xcjbjNL8BPJ0v/nBvvjUkImzJqx
	 8Gy1ahq2EJk572D89qp0LQZ3qO0zvGNWpZXoMyDTtAzOoaklL5fMlU6nFiNkrzTT7+w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795043837;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=5dQ4JQj6AUa0iFblGEmenrbjQYznIq7haN0cV2XTtU0=;
	b=0XTY8mRyjBsX9ZrSFROBQmUAx4Nc4NSJDUzTng0t9I6gSJ36Z5ZF2qMKLO9+TLDqOJ3k
	 VkOk64PDQCVQruQcSCW3WIx/B/I7EjK5xZ5rQD2+o+vRMxFjoNbbQcARBCOoiaK8DGFwh
	 qqmFSqxPyan44y8eDVE9KwYBFA0zzN3frW+u8J0KLhBo4ueuaZakgJY1/wz6V502fY3VR
	 NnmmGXTeIgFWVH9FcZCKu7o3vqQsGBjUINBu5tj+53LNH67e/QkKF7SMBN2KQ/Nj3zKNA
	 uAVSGg4jiEdRHToaCc02gyKy5UEh2KQHry9i9lX3MEhVItJsP0RKbTZiuefjdfe2QWQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id CF1281F000C6;
	Wed, 18 Nov 2026 23:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795043837;
	bh=5dQ4JQj6AUa0iFblGEmenrbjQYznIq7haN0cV2XTtU0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=L1TS4pNjinTHQUPNzblK7H6rftDiSIGBZHMRJk9MnP+1Whjuhb1hNXEKv/dH9IwHm
	 +QIhfG+7ujPJ0z33rU+AURixQD7chABxZyLUgGpkegK37ZUAWWE4Tl3ORhRvCLfd0W
	 b5K4AZH+2tPJENb6KWFymE2tByLWeItAsHRfKSLDK1iIZ22bnLdHSL9MjQ2SO/43w0
	 UGq5Bu48mB7na5XX1ILdhn6H3Clgrbe+h4HCBvdCGKXTK/ibdeoAACJ09cpHMIA3Zr
	 xdZ/c83dKuYy2JxYDoL09whTWQ3TPxgHVe7i1xK24sDJR1fHH0NfWYyUwJrJGaBLqW
	 j3DwuOZvXH8Vw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 60B314B01F;
	Wed, 18 Nov 2026 23:17:15 +0000 (UTC)
From: =?utf-8?q?Alexandru_Andrie=C8=99_via_B4_Relay?= <devnull+alex.andries.aa.gmail.com@kernel.org>
Date: Thu, 19 Nov 2026 00:16:52 +0100
Subject: [PATCH 3/3] power: supply: qcom_battmgr: fix negative temperature
 values
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261119-upstream-qcom-battmgr-fixes-v1-v1-3-ca83700c08c1@gmail.com>
References: <20261119-upstream-qcom-battmgr-fixes-v1-v1-0-ca83700c08c1@gmail.com>
In-Reply-To: <20261119-upstream-qcom-battmgr-fixes-v1-v1-0-ca83700c08c1@gmail.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, stable@vger.kernel.org, 
 =?utf-8?q?Alexandru_Andrie=C8=99?= <alex.andries.aa@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795043834; l=2126;
 i=alex.andries.aa@gmail.com; s=20261118; h=from:subject:message-id;
 bh=rbeD9/hqy2iLa1zbMjhzXGTU00ckT0RtHpgBQ16AH5I=;
 b=JsoY8sFr/LIOpNR9zSCmVSlbAT0y8+na0ABBLTwEaUCcTDISlTl8LFCGx31mJICe5nVIy0Qtu
 UutV5/Wakh1DN2wEzee4AH33SDAS4fJv78X+dVsfRO+4EeM1fQs9uu1
X-Developer-Key: i=alex.andries.aa@gmail.com; a=ed25519;
 pk=kNAqgavfB7uUd1mA8o8TszhGxzyqBwY71PGO/oK4v84=
X-Endpoint-Received: by B4 Relay for alex.andries.aa@gmail.com/20261118
 with auth_id=1564
X-Original-From: =?utf-8?q?Alexandru_Andrie=C8=99?= <alex.andries.aa@gmail.com>
Reply-To: alex.andries.aa@gmail.com
Content-Transfer-Encoding: 8bit

From: Alexandru Andrieș <alex.andries.aa@gmail.com>

Firmware reports battery temperature in signed hundredths of a degree
Celsius, scaled to tenths of a degree for POWER_SUPPLY_PROP_TEMP.
Passing it as unsigned int to DIV_ROUND_CLOSEST(..., 10) in both
qcom_battmgr_sc8280xp_convert_temp() and qcom_battmgr_sm8350_callback()
turns sub-zero values (e.g. -5.00 C, 0xfffffe0c) into 429496680 instead
of -50.

Change status.temperature and qcom_battmgr_sc8280xp_convert_temp() to
int, and cast the SM8350 BATT_TEMP payload to s32 before dividing.

Tested at 35.0 C on a Xiaomi MIX 4 (SM8350); the SC8280XP path and
sub-zero temperatures were not hardware-tested.

Fixes: 29e8142b5623 ("power: supply: Introduce Qualcomm PMIC GLINK power supply")
Cc: stable@vger.kernel.org
Signed-off-by: Alexandru Andrieș <alex.andries.aa@gmail.com>
---
 drivers/power/supply/qcom_battmgr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
index 83e67d22c432..98b658ff6beb 100644
--- a/drivers/power/supply/qcom_battmgr.c
+++ b/drivers/power/supply/qcom_battmgr.c
@@ -278,7 +278,7 @@ struct qcom_battmgr_status {
 	int power_now;
 	unsigned int voltage_now;
 	unsigned int voltage_ocv;
-	unsigned int temperature;
+	int temperature;
 	unsigned int resistance;
 	unsigned int soh_percent;
 
@@ -1250,7 +1250,7 @@ static unsigned int qcom_battmgr_sc8280xp_parse_technology(const char *chemistry
 	return POWER_SUPPLY_TECHNOLOGY_UNKNOWN;
 }
 
-static unsigned int qcom_battmgr_sc8280xp_convert_temp(unsigned int temperature)
+static int qcom_battmgr_sc8280xp_convert_temp(int temperature)
 {
 	return DIV_ROUND_CLOSEST(temperature, 10);
 }
@@ -1467,7 +1467,7 @@ static void qcom_battmgr_sm8350_callback(struct qcom_battmgr *battmgr,
 			break;
 		case BATT_TEMP:
 			val = le32_to_cpu(resp->intval.value);
-			battmgr->status.temperature = DIV_ROUND_CLOSEST(val, 10);
+			battmgr->status.temperature = DIV_ROUND_CLOSEST((s32)val, 10);
 			break;
 		case BATT_TECHNOLOGY:
 			battmgr->info.technology = le32_to_cpu(resp->intval.value);

-- 
2.56.1


